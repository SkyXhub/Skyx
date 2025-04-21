DONT MODD
-- Services
local UserInputService = game:GetService('UserInputService')
local TweenService = game:GetService('TweenService')
local HttpService = game:GetService('HttpService')
local RunService = game:GetService('RunService')
local CoreGui = game:GetService('CoreGui')
local Players = game:GetService('Players')
local TextService = game:GetService('TextService')

-- Variables
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local ViewportSize = workspace.CurrentCamera.ViewportSize

-- Constants
local TWEEN_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local PRIMARY_COLOR = Color3.fromRGB(19, 20, 24)
local SECONDARY_COLOR = Color3.fromRGB(27, 28, 33)
local ACCENT_COLOR = Color3.fromRGB(114, 137, 218)
local TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local DEFAULT_FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)

-- Main Library
Visual = {
    Version = "1.0.0",
    Connections = {},
    Flags = {},
    Windows = {},
    Enabled = true,
    CurrentTheme = {
        Primary = PRIMARY_COLOR,
        Secondary = SECONDARY_COLOR,
        Accent = ACCENT_COLOR,
        Text = TEXT_COLOR,
        Font = DEFAULT_FONT
    },
    SliderDragging = false,
    DropdownOpen = false
}

local function getTextBounds(text, font, size)
    return TextService:GetTextSize(text, size, font, Vector2.new(math.huge, math.huge))
end

function Visual:Connect(name, connection)
    self.Connections[name] = connection
    return connection
end

function Visual:Disconnect(name)
    if self.Connections[name] then
        self.Connections[name]:Disconnect()
        self.Connections[name] = nil
    end
end

function Visual:DisconnectAll()
    for name, connection in pairs(self.Connections) do
        connection:Disconnect()
        self.Connections[name] = nil
    end
end

function Visual:SaveFlags()
    if not isfolder("Visual") then
        makefolder("Visual")
    end
    
    local gameId = game and game.GameId or (_G.game and _G.game.GameId or 12345)
    local flags = HttpService:JSONEncode(self.Flags)
    writefile(string.format("Visual/%s.json", gameId), flags)
end

function Visual:LoadFlags()
    if not isfolder("Visual") then
        makefolder("Visual")
    end
    
    local gameId = game and game.GameId or (_G.game and _G.game.GameId or 12345)
    local flagsPath = string.format("Visual/%s.json", gameId)
    
    if not isfile(flagsPath) then
        self:SaveFlags()
        return
    end
    
    local success, result = pcall(function()
        return HttpService:JSONDecode(readfile(flagsPath))
    end)
    
    if success and type(result) == "table" then
        for flag, value in pairs(result) do
            self.Flags[flag] = value
        end
    else
        self:SaveFlags()
    end
end

function Visual:ClearGUI()
    for _, object in pairs(CoreGui:GetChildren()) do
        if object.Name == "VisualUI" then
            object:Destroy()
        end
    end
end

function Visual:SetTheme(theme)
    for property, value in pairs(theme) do
        if self.CurrentTheme[property] then
            self.CurrentTheme[property] = value
        end
    end
    
    -- Apply theme to existing elements
    for _, window in pairs(self.Windows) do
        window:UpdateTheme()
    end
end

function Visual:AnimateGif(imageLabel, width, height, rows, columns, numberOfFrames, imageId, fps)
    if imageId then 
        imageLabel.Image = imageId 
    end
    
    local robloxMaxImageSize = 2048
    local realWidth, realHeight
    
    if math.max(width, height) > robloxMaxImageSize then
        local longest = width > height and "Width" or "Height"
        if longest == "Width" then
            realWidth = robloxMaxImageSize
            realHeight = (realWidth / width) * height
        elseif longest == "Height" then
            realHeight = robloxMaxImageSize
            realWidth = (realHeight / height) * width
        end
    else
        realWidth, realHeight = width, height
    end
    
    local frameSize = Vector2.new(realWidth / columns, realHeight / rows)
    imageLabel.ImageRectSize = frameSize
    
    local currentRow, currentColumn = 0, 0
    local offsets = {}
    
    for i = 1, numberOfFrames do
        local currentX = currentColumn * frameSize.X
        local currentY = currentRow * frameSize.Y
        table.insert(offsets, Vector2.new(currentX, currentY))
        currentColumn = currentColumn + 1
        
        if currentColumn >= columns then
            currentColumn = 0
            currentRow = currentRow + 1
        end
    end
    
    local timeInterval = fps and 1 / fps or 0.1
    local index = 0
    
    task.spawn(function()
        while true do
            if not imageLabel then
                break
            end
            
            -- Safe check for Roblox environment
            local isValid = pcall(function()
                return imageLabel:IsDescendantOf(game)
            end)
            
            if not isValid then
                break
            end
            
            index = index + 1
            if index > numberOfFrames then
                index = 1
            end
            
            imageLabel.ImageRectOffset = offsets[index]
            task.wait(timeInterval)
        end
    end)
end

-- Create a new window
function Visual:Window(config)
    Visual:ClearGUI()
    Visual:LoadFlags()
    
    config = config or {}
    local title = config.title or "Visual UI"
    local defaultSize = config.size or UDim2.new(0, 700, 0, 430)
    local defaultPosition = config.position or UDim2.new(0.5, -350, 0.5, -215)
    
    -- For testing in non-Roblox environments
    _G.namehub = _G.namehub or config.title or "Visual UI"
    
    -- Create GUI
    local VisualGUI = Instance.new("ScreenGui")
    VisualGUI.Name = "VisualUI"
    VisualGUI.Parent = CoreGui
    VisualGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Create Shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = VisualGUI
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BackgroundTransparency = 1
    Shadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BorderSizePixel = 0
    Shadow.Position = defaultPosition
    Shadow.Size = UDim2.new(0, defaultSize.X.Offset + 70, 0, defaultSize.Y.Offset + 70)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://17290899982"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    
    -- Create Container
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Parent = VisualGUI
    Container.AnchorPoint = Vector2.new(0.5, 0.5)
    Container.BackgroundColor3 = self.CurrentTheme.Primary
    Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Container.BorderSizePixel = 0
    Container.ClipsDescendants = true
    Container.Position = defaultPosition
    Container.Size = defaultSize
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 20)
    UICorner.Parent = Container
    
    -- Create Top Bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = Container
    TopBar.BackgroundColor3 = self.CurrentTheme.Secondary
    TopBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    
    local UICornerTopBar = Instance.new("UICorner")
    UICornerTopBar.CornerRadius = UDim.new(0, 20)
    UICornerTopBar.Parent = TopBar
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Parent = TopBar
    TitleLabel.AnchorPoint = Vector2.new(0, 0.5)
    TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TitleLabel.BorderSizePixel = 0
    TitleLabel.Position = UDim2.new(0.025, 0, 0.5, 0)
    TitleLabel.Size = UDim2.new(0, 200, 0, 20)
    TitleLabel.FontFace = self.CurrentTheme.Font
    TitleLabel.Text = title
    TitleLabel.TextColor3 = self.CurrentTheme.Text
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Time Display
    local TimeLabel = Instance.new("TextLabel")
    TimeLabel.Name = "Time"
    TimeLabel.Parent = TopBar
    TimeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TimeLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TimeLabel.BackgroundTransparency = 1
    TimeLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TimeLabel.BorderSizePixel = 0
    TimeLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    TimeLabel.Size = UDim2.new(0, 100, 0, 20)
    TimeLabel.FontFace = self.CurrentTheme.Font
    TimeLabel.Text = "00:00"
    TimeLabel.TextColor3 = self.CurrentTheme.Text
    TimeLabel.TextSize = 14
    TimeLabel.TextTransparency = 0
    
    -- Logo
    local Logo = Instance.new("ImageLabel")
    Logo.Name = "Logo"
    Logo.Parent = TopBar
    Logo.AnchorPoint = Vector2.new(1, 0.5)
    Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Logo.BackgroundTransparency = 1
    Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Logo.BorderSizePixel = 0
    Logo.Position = UDim2.new(1, -15, 0.5, 0)
    Logo.Size = UDim2.new(0, 24, 0, 24)
    Logo.Image = "rbxassetid://7733658504" -- Example Roblox gear icon
    
    -- Tabs Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Container
    TabContainer.BackgroundColor3 = self.CurrentTheme.Primary
    TabContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.Size = UDim2.new(0, 200, 1, -40)
    
    -- Tabs Scroll
    local TabsScroll = Instance.new("ScrollingFrame")
    TabsScroll.Name = "TabsScroll"
    TabsScroll.Parent = TabContainer
    TabsScroll.Active = true
    TabsScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabsScroll.BackgroundTransparency = 1
    TabsScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabsScroll.BorderSizePixel = 0
    TabsScroll.Position = UDim2.new(0, 0, 0, 0)
    TabsScroll.Size = UDim2.new(1, 0, 1, 0)
    TabsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabsScroll.ScrollBarThickness = 2
    TabsScroll.ScrollBarImageColor3 = self.CurrentTheme.Accent
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = TabsScroll
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = TabsScroll
    UIPadding.PaddingLeft = UDim.new(0, 10)
    UIPadding.PaddingRight = UDim.new(0, 10)
    UIPadding.PaddingTop = UDim.new(0, 10)
    UIPadding.PaddingBottom = UDim.new(0, 10)
    
    -- Divider
    local Divider = Instance.new("Frame")
    Divider.Name = "Divider"
    Divider.Parent = Container
    Divider.BackgroundColor3 = self.CurrentTheme.Secondary
    Divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Divider.BorderSizePixel = 0
    Divider.Position = UDim2.new(0, 200, 0, 40)
    Divider.Size = UDim2.new(0, 2, 1, -40)
    
    -- Tab Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = Container
    ContentContainer.BackgroundColor3 = self.CurrentTheme.Primary
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Position = UDim2.new(0, 202, 0, 40)
    ContentContainer.Size = UDim2.new(1, -202, 1, -40)
    
    -- Time updater
    local startTime = os.time()
    
    local function formatTime(seconds)
        local minutes = math.floor(seconds / 60)
        local remainingSeconds = seconds % 60
        return string.format("%02d:%02d", minutes, remainingSeconds)
    end
    
    local function updateTextSmoothly(label, newText)
        local fadeOutInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local fadeInInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
        
        local fadeOut = TweenService:Create(label, fadeOutInfo, {TextTransparency = 1})
        fadeOut:Play()
        
        fadeOut.Completed:Connect(function()
            label.Text = newText
            local fadeIn = TweenService:Create(label, fadeInInfo, {TextTransparency = 0})
            fadeIn:Play()
        end)
    end
    
    task.spawn(function()
        while true do
            local elapsedTime = os.time() - startTime
            updateTextSmoothly(TimeLabel, formatTime(elapsedTime))
            task.wait(1)
        end
    end)
    
    -- Drag functionality
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local function updateDrag(input)
        local delta = input.Position - dragStart
        Container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        Shadow.Position = Container.Position
    end
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Container.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateDrag(input)
        end
    end)
    
    -- Window methods
    local window = {}
    window.Tabs = {}
    window.ActiveTab = nil
    window.GUI = VisualGUI
    window.Container = Container
    window.Shadow = Shadow
    
    function window:UpdateTheme()
        Container.BackgroundColor3 = Visual.CurrentTheme.Primary
        TopBar.BackgroundColor3 = Visual.CurrentTheme.Secondary
        TitleLabel.TextColor3 = Visual.CurrentTheme.Text
        TitleLabel.FontFace = Visual.CurrentTheme.Font
        TimeLabel.TextColor3 = Visual.CurrentTheme.Text
        TimeLabel.FontFace = Visual.CurrentTheme.Font
        Divider.BackgroundColor3 = Visual.CurrentTheme.Secondary
        TabsScroll.ScrollBarImageColor3 = Visual.CurrentTheme.Accent
        
        -- Update tabs
        for _, tab in pairs(self.Tabs) do
            tab:UpdateTheme()
        end
    end
    
    function window:Toggle()
        Visual.Enabled = not Visual.Enabled
        
        if Visual.Enabled then
            -- Open animation
            Container.Visible = true
            Shadow.Visible = true
            
            TweenService:Create(Container, TWEEN_INFO, {
                Size = defaultSize
            }):Play()
            
            TweenService:Create(Shadow, TWEEN_INFO, {
                Size = UDim2.new(0, defaultSize.X.Offset + 70, 0, defaultSize.Y.Offset + 70)
            }):Play()
        else
            -- Close animation
            local closeTween = TweenService:Create(Container, TWEEN_INFO, {
                Size = UDim2.new(0, 0, 0, 0)
            })
            
            TweenService:Create(Shadow, TWEEN_INFO, {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            
            closeTween:Play()
            closeTween.Completed:Connect(function()
                if not Visual.Enabled then
                    Container.Visible = false
                    Shadow.Visible = false
                end
            end)
        end
    end
    
    -- Handle keybind to toggle UI
    Visual:Connect("ToggleKeybind", UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            window:Toggle()
        end
    end))
    
    function window:Tab(config)
        config = config or {}
        local tabName = config.name or "Tab"
        local tabIcon = config.icon
        
        -- Create tab button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "Tab_" .. tabName
        TabButton.Parent = TabsScroll
        TabButton.BackgroundColor3 = Visual.CurrentTheme.Secondary
        TabButton.BackgroundTransparency = 1
        TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.FontFace = Visual.CurrentTheme.Font
        TabButton.Text = ""
        TabButton.TextColor3 = Visual.CurrentTheme.Text
        TabButton.TextSize = 14
        TabButton.AutoButtonColor = false
        
        local UICornerButton = Instance.new("UICorner")
        UICornerButton.CornerRadius = UDim.new(0, 6)
        UICornerButton.Parent = TabButton
        
        local TabIcon
        if tabIcon then
            TabIcon = Instance.new("ImageLabel")
            TabIcon.Name = "Icon"
            TabIcon.Parent = TabButton
            TabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TabIcon.BackgroundTransparency = 1
            TabIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TabIcon.BorderSizePixel = 0
            TabIcon.Position = UDim2.new(0, 8, 0, 8)
            TabIcon.Size = UDim2.new(0, 20, 0, 20)
            TabIcon.Image = tabIcon
            TabIcon.ImageColor3 = Visual.CurrentTheme.Text
        end
        
        local TabText = Instance.new("TextLabel")
        TabText.Name = "Text"
        TabText.Parent = TabButton
        TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabText.BackgroundTransparency = 1
        TabText.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabText.BorderSizePixel = 0
        TabText.Position = tabIcon and UDim2.new(0, 35, 0, 0) or UDim2.new(0, 10, 0, 0)
        TabText.Size = UDim2.new(1, tabIcon and -35 or -10, 1, 0)
        TabText.FontFace = Visual.CurrentTheme.Font
        TabText.Text = tabName
        TabText.TextColor3 = Visual.CurrentTheme.Text
        TabText.TextSize = 14
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Create tab content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = "Content_" .. tabName
        TabContent.Parent = ContentContainer
        TabContent.Active = true
        TabContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabContent.BorderSizePixel = 0
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.ScrollBarThickness = 2
        TabContent.ScrollBarImageColor3 = Visual.CurrentTheme.Accent
        TabContent.Visible = false
        
        local UIListLayoutContent = Instance.new("UIListLayout")
        UIListLayoutContent.Parent = TabContent
        UIListLayoutContent.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayoutContent.Padding = UDim.new(0, 8)
        
        local UIPaddingContent = Instance.new("UIPadding")
        UIPaddingContent.Parent = TabContent
        UIPaddingContent.PaddingLeft = UDim.new(0, 15)
        UIPaddingContent.PaddingRight = UDim.new(0, 15)
        UIPaddingContent.PaddingTop = UDim.new(0, 15)
        UIPaddingContent.PaddingBottom = UDim.new(0, 15)
        
        -- Auto-adjust canvas size
        UIListLayoutContent:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, UIListLayoutContent.AbsoluteContentSize.Y + 30)
        end)
        
        -- Tab functionality
        local tab = {}
        tab.Button = TabButton
        tab.Content = TabContent
        tab.Name = tabName
        
        function tab:UpdateTheme()
            TabText.TextColor3 = Visual.CurrentTheme.Text
            TabText.FontFace = Visual.CurrentTheme.Font
            if TabIcon then
                TabIcon.ImageColor3 = Visual.CurrentTheme.Text
            end
            TabContent.ScrollBarImageColor3 = Visual.CurrentTheme.Accent
            
            -- Update all sections in this tab
            for _, child in pairs(TabContent:GetChildren()) do
                if child:IsA("Frame") and child.Name:find("Section") then
                    for _, element in pairs(child:GetDescendants()) do
                        if element:IsA("TextLabel") or element:IsA("TextButton") then
                            element.TextColor3 = Visual.CurrentTheme.Text
                            element.FontFace = Visual.CurrentTheme.Font
                        elseif element:IsA("Frame") and element.Name == "Slider" then
                            element.Inner.BackgroundColor3 = Visual.CurrentTheme.Accent
                        end
                    end
                end
            end
        end
        
        function tab:Select()
            if window.ActiveTab == tab then return end
            
            -- Deselect current tab
            if window.ActiveTab then
                TweenService:Create(window.ActiveTab.Button, TWEEN_INFO, {
                    BackgroundTransparency = 1
                }):Play()
                window.ActiveTab.Content.Visible = false
            end
            
            -- Select new tab
            window.ActiveTab = tab
            tab.Content.Visible = true
            
            TweenService:Create(tab.Button, TWEEN_INFO, {
                BackgroundTransparency = 0.9,
                BackgroundColor3 = Visual.CurrentTheme.Accent
            }):Play()
        end
        
        TabButton.MouseButton1Click:Connect(function()
            tab:Select()
        end)
        
        -- Section creator
        function tab:Section(config)
            config = config or {}
            local sectionName = config.name or "Section"
            
            local Section = Instance.new("Frame")
            Section.Name = "Section_" .. sectionName
            Section.Parent = TabContent
            Section.BackgroundColor3 = Visual.CurrentTheme.Secondary
            Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Section.BorderSizePixel = 0
            Section.Size = UDim2.new(1, 0, 0, 40) -- Will be automatically adjusted
            
            local UICornerSection = Instance.new("UICorner")
            UICornerSection.CornerRadius = UDim.new(0, 8)
            UICornerSection.Parent = Section
            
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "Title"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionTitle.BorderSizePixel = 0
            SectionTitle.Position = UDim2.new(0, 10, 0, 0)
            SectionTitle.Size = UDim2.new(1, -20, 0, 30)
            SectionTitle.FontFace = Visual.CurrentTheme.Font
            SectionTitle.Text = sectionName
            SectionTitle.TextColor3 = Visual.CurrentTheme.Text
            SectionTitle.TextSize = 16
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local SectionContent = Instance.new("Frame")
            SectionContent.Name = "Content"
            SectionContent.Parent = Section
            SectionContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionContent.BackgroundTransparency = 1
            SectionContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionContent.BorderSizePixel = 0
            SectionContent.Position = UDim2.new(0, 10, 0, 30)
            SectionContent.Size = UDim2.new(1, -20, 1, -35)
            
            local UIListLayoutSection = Instance.new("UIListLayout")
            UIListLayoutSection.Parent = SectionContent
            UIListLayoutSection.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayoutSection.Padding = UDim.new(0, 8)
            
            -- Auto-adjust section height
            UIListLayoutSection:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Section.Size = UDim2.new(1, 0, 0, UIListLayoutSection.AbsoluteContentSize.Y + 45)
            end)
            
            local section = {}
            
            -- Create a button
            function section:Button(config)
                config = config or {}
                local buttonText = config.text or "Button"
                local callback = config.callback or function() end
                
                local Button = Instance.new("TextButton")
                Button.Name = "Button"
                Button.Parent = SectionContent
                Button.BackgroundColor3 = Visual.CurrentTheme.Primary
                Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(1, 0, 0, 35)
                Button.FontFace = Visual.CurrentTheme.Font
                Button.Text = buttonText
                Button.TextColor3 = Visual.CurrentTheme.Text
                Button.TextSize = 14
                Button.AutoButtonColor = false
                
                local UICornerButton = Instance.new("UICorner")
                UICornerButton.CornerRadius = UDim.new(0, 6)
                UICornerButton.Parent = Button
                
                -- Button animation
                Button.MouseEnter:Connect(function()
                    TweenService:Create(Button, TWEEN_INFO, {
                        BackgroundColor3 = Visual.CurrentTheme.Accent
                    }):Play()
                end)
                
                Button.MouseLeave:Connect(function()
                    TweenService:Create(Button, TWEEN_INFO, {
                        BackgroundColor3 = Visual.CurrentTheme.Primary
                    }):Play()
                end)
                
                Button.MouseButton1Down:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.new(1, 0, 0, 32)
                    }):Play()
                end)
                
                Button.MouseButton1Up:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.new(1, 0, 0, 35)
                    }):Play()
                end)
                
                Button.MouseButton1Click:Connect(function()
                    pcall(callback)
                end)
                
                return Button
            end
            
            -- Create a toggle
            function section:Toggle(config)
                config = config or {}
                local toggleText = config.text or "Toggle"
                local default = config.default or false
                local flag = config.flag
                local callback = config.callback or function() end
                
                if flag and Visual.Flags[flag] ~= nil then
                    default = Visual.Flags[flag]
                end
                
                local Toggle = Instance.new("Frame")
                Toggle.Name = "Toggle"
                Toggle.Parent = SectionContent
                Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Toggle.BackgroundTransparency = 1
                Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Toggle.BorderSizePixel = 0
                Toggle.Size = UDim2.new(1, 0, 0, 35)
                
                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Name = "Button"
                ToggleButton.Parent = Toggle
                ToggleButton.BackgroundColor3 = Visual.CurrentTheme.Primary
                ToggleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ToggleButton.BorderSizePixel = 0
                ToggleButton.Size = UDim2.new(1, 0, 1, 0)
                ToggleButton.FontFace = Visual.CurrentTheme.Font
                ToggleButton.Text = ""
                ToggleButton.TextColor3 = Visual.CurrentTheme.Text
                ToggleButton.TextSize = 14
                ToggleButton.AutoButtonColor = false
                
                local UICornerToggle = Instance.new("UICorner")
                UICornerToggle.CornerRadius = UDim.new(0, 6)
                UICornerToggle.Parent = ToggleButton
                
                local ToggleText = Instance.new("TextLabel")
                ToggleText.Name = "Text"
                ToggleText.Parent = ToggleButton
                ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleText.BackgroundTransparency = 1
                ToggleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ToggleText.BorderSizePixel = 0
                ToggleText.Position = UDim2.new(0, 10, 0, 0)
                ToggleText.Size = UDim2.new(1, -60, 1, 0)
                ToggleText.FontFace = Visual.CurrentTheme.Font
                ToggleText.Text = toggleText
                ToggleText.TextColor3 = Visual.CurrentTheme.Text
                ToggleText.TextSize = 14
                ToggleText.TextXAlignment = Enum.TextXAlignment.Left
                
                local ToggleIndicator = Instance.new("Frame")
                ToggleIndicator.Name = "Indicator"
                ToggleIndicator.Parent = ToggleButton
                ToggleIndicator.AnchorPoint = Vector2.new(1, 0.5)
                ToggleIndicator.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                ToggleIndicator.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ToggleIndicator.BorderSizePixel = 0
                ToggleIndicator.Position = UDim2.new(1, -10, 0.5, 0)
                ToggleIndicator.Size = UDim2.new(0, 40, 0, 20)
                
                local UICornerIndicator = Instance.new("UICorner")
                UICornerIndicator.CornerRadius = UDim.new(1, 0)
                UICornerIndicator.Parent = ToggleIndicator
                
                local ToggleCircle = Instance.new("Frame")
                ToggleCircle.Name = "Circle"
                ToggleCircle.Parent = ToggleIndicator
                ToggleCircle.AnchorPoint = Vector2.new(0, 0.5)
                ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleCircle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ToggleCircle.BorderSizePixel = 0
                ToggleCircle.Position = UDim2.new(0, 2, 0.5, 0)
                ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
                
                local UICornerCircle = Instance.new("UICorner")
                UICornerCircle.CornerRadius = UDim.new(1, 0)
                UICornerCircle.Parent = ToggleCircle
                
                local toggle = {Value = default}
                
                function toggle:Set(value)
                    toggle.Value = value
                    
                    if flag then
                        Visual.Flags[flag] = value
                        Visual:SaveFlags()
                    end
                    
                    local targetPosition = value and UDim2.new(1, -2, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                    local targetColor = value and Visual.CurrentTheme.Accent or Color3.fromRGB(60, 60, 70)
                    
                    TweenService:Create(ToggleIndicator, TWEEN_INFO, {
                        BackgroundColor3 = targetColor
                    }):Play()
                    
                    TweenService:Create(ToggleCircle, TWEEN_INFO, {
                        Position = targetPosition
                    }):Play()
                    
                    pcall(callback, value)
                end
                
                -- Button animation
                ToggleButton.MouseEnter:Connect(function()
                    TweenService:Create(ToggleButton, TWEEN_INFO, {
                        BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                    }):Play()
                end)
                
                ToggleButton.MouseLeave:Connect(function()
                    TweenService:Create(ToggleButton, TWEEN_INFO, {
                        BackgroundColor3 = Visual.CurrentTheme.Primary
                    }):Play()
                end)
                
                ToggleButton.MouseButton1Click:Connect(function()
                    toggle:Set(not toggle.Value)
                end)
                
                toggle:Set(default)
                return toggle
            end
            
            -- Create a slider
            function section:Slider(config)
                config = config or {}
                local sliderText = config.text or "Slider"
                local min = config.min or 0
                local max = config.max or 100
                local default = config.default or min
                local float = config.float or 1
                local suffix = config.suffix or ""
                local flag = config.flag
                local callback = config.callback or function() end
                
                if flag and Visual.Flags[flag] ~= nil then
                    default = Visual.Flags[flag]
                end
                
                local Slider = Instance.new("Frame")
                Slider.Name = "Slider"
                Slider.Parent = SectionContent
                Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Slider.BackgroundTransparency = 1
                Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Slider.BorderSizePixel = 0
                Slider.Size = UDim2.new(1, 0, 0, 50)
                
                local SliderText = Instance.new("TextLabel")
                SliderText.Name = "Text"
                SliderText.Parent = Slider
                SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderText.BackgroundTransparency = 1
                SliderText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                SliderText.BorderSizePixel = 0
                SliderText.Position = UDim2.new(0, 0, 0, 0)
                SliderText.Size = UDim2.new(1, 0, 0, 20)
                SliderText.FontFace = Visual.CurrentTheme.Font
                SliderText.Text = sliderText
                SliderText.TextColor3 = Visual.CurrentTheme.Text
                SliderText.TextSize = 14
                SliderText.TextXAlignment = Enum.TextXAlignment.Left
                
                local SliderValue = Instance.new("TextLabel")
                SliderValue.Name = "Value"
                SliderValue.Parent = Slider
                SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.BackgroundTransparency = 1
                SliderValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
                SliderValue.BorderSizePixel = 0
                SliderValue.Position = UDim2.new(1, -40, 0, 0)
                SliderValue.Size = UDim2.new(0, 40, 0, 20)
                SliderValue.FontFace = Visual.CurrentTheme.Font
                SliderValue.Text = tostring(default) .. suffix
                SliderValue.TextColor3 = Visual.CurrentTheme.Text
                SliderValue.TextSize = 14
                SliderValue.TextXAlignment = Enum.TextXAlignment.Right
                
                local SliderOuter = Instance.new("Frame")
                SliderOuter.Name = "Outer"
                SliderOuter.Parent = Slider
                SliderOuter.BackgroundColor3 = Visual.CurrentTheme.Primary
                SliderOuter.BorderColor3 = Color3.fromRGB(0, 0, 0)
                SliderOuter.BorderSizePixel = 0
                SliderOuter.Position = UDim2.new(0, 0, 0, 25)
                SliderOuter.Size = UDim2.new(1, 0, 0, 10)
                
                local UICornerSlider = Instance.new("UICorner")
                UICornerSlider.CornerRadius = UDim.new(0, 5)
                UICornerSlider.Parent = SliderOuter
                
                local SliderInner = Instance.new("Frame")
                SliderInner.Name = "Inner"
                SliderInner.Parent = SliderOuter
                SliderInner.BackgroundColor3 = Visual.CurrentTheme.Accent
                SliderInner.BorderColor3 = Color3.fromRGB(0, 0, 0)
                SliderInner.BorderSizePixel = 0
                SliderInner.Size = UDim2.new(0, 0, 1, 0)
                
                local UICornerInner = Instance.new("UICorner")
                UICornerInner.CornerRadius = UDim.new(0, 5)
                UICornerInner.Parent = SliderInner
                
                local SliderButton = Instance.new("TextButton")
                SliderButton.Name = "Button"
                SliderButton.Parent = SliderOuter
                SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderButton.BackgroundTransparency = 1
                SliderButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
                SliderButton.BorderSizePixel = 0
                SliderButton.Size = UDim2.new(1, 0, 1, 0)
                SliderButton.Text = ""
                
                local slider = {Value = default}
                
                function slider:Set(value)
                    value = math.clamp(value, min, max)
                    
                    if float then
                        value = math.floor(value / float) * float
                        value = tonumber(string.format("%.2f", value))
                    end
                    
                    slider.Value = value
                    
                    if flag then
                        Visual.Flags[flag] = value
                        Visual:SaveFlags()
                    end
                    
                    local percent = (value - min) / (max - min)
                    SliderValue.Text = tostring(value) .. suffix
                    SliderInner.Size = UDim2.new(percent, 0, 1, 0)
                    
                    pcall(callback, value)
                end
                
                SliderButton.MouseButton1Down:Connect(function()
                    Visual.SliderDragging = true
                    
                    while Visual.SliderDragging do
                        local mousePos = UserInputService:GetMouseLocation()
                        local relativePos = mousePos.X - SliderOuter.AbsolutePosition.X
                        local percent = math.clamp(relativePos / SliderOuter.AbsoluteSize.X, 0, 1)
                        local value = min + (max - min) * percent
                        
                        slider:Set(value)
                        RunService.Heartbeat:Wait()
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Visual.SliderDragging = false
                    end
                end)
                
                slider:Set(default)
                return slider
            end
            
            -- Create a dropdown
            function section:Dropdown(config)
                config = config or {}
                local dropdownText = config.text or "Dropdown"
                local items = config.items or {}
                local default = config.default or ""
                local flag = config.flag
                local callback = config.callback or function() end
                
                if flag and Visual.Flags[flag] ~= nil then
                    default = Visual.Flags[flag]
                end
                
                local Dropdown = Instance.new("Frame")
                Dropdown.Name = "Dropdown"
                Dropdown.Parent = SectionContent
                Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Dropdown.BackgroundTransparency = 1
                Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Dropdown.BorderSizePixel = 0
                Dropdown.ClipsDescendants = true
                Dropdown.Size = UDim2.new(1, 0, 0, 35)
                
                local DropdownButton = Instance.new("TextButton")
                DropdownButton.Name = "Button"
                DropdownButton.Parent = Dropdown
                DropdownButton.BackgroundColor3 = Visual.CurrentTheme.Primary
                DropdownButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
                DropdownButton.BorderSizePixel = 0
                DropdownButton.Size = UDim2.new(1, 0, 0, 35)
                DropdownButton.FontFace = Visual.CurrentTheme.Font
                DropdownButton.Text = ""
                DropdownButton.TextColor3 = Visual.CurrentTheme.Text
                DropdownButton.TextSize = 14
                DropdownButton.AutoButtonColor = false
                
                local UICornerDropdown = Instance.new("UICorner")
                UICornerDropdown.CornerRadius = UDim.new(0, 6)
                UICornerDropdown.Parent = DropdownButton
                
                local DropdownText = Instance.new("TextLabel")
                DropdownText.Name = "Text"
                DropdownText.Parent = DropdownButton
                DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownText.BackgroundTransparency = 1
                DropdownText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                DropdownText.BorderSizePixel = 0
                DropdownText.Position = UDim2.new(0, 10, 0, 0)
                DropdownText.Size = UDim2.new(0, 200, 0, 35)
                DropdownText.FontFace = Visual.CurrentTheme.Font
                DropdownText.Text = dropdownText
                DropdownText.TextColor3 = Visual.CurrentTheme.Text
                DropdownText.TextSize = 14
                DropdownText.TextXAlignment = Enum.TextXAlignment.Left
                
                local SelectedText = Instance.new("TextLabel")
                SelectedText.Name = "Selected"
                SelectedText.Parent = DropdownButton
                SelectedText.AnchorPoint = Vector2.new(1, 0)
                SelectedText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SelectedText.BackgroundTransparency = 1
                SelectedText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                SelectedText.BorderSizePixel = 0
                SelectedText.Position = UDim2.new(1, -30, 0, 0)
                SelectedText.Size = UDim2.new(0, 200, 0, 35)
                SelectedText.FontFace = Visual.CurrentTheme.Font
                SelectedText.Text = default
                SelectedText.TextColor3 = Visual.CurrentTheme.Text
                SelectedText.TextSize = 14
                SelectedText.TextXAlignment = Enum.TextXAlignment.Right
                
                local DropdownArrow = Instance.new("ImageLabel")
                DropdownArrow.Name = "Arrow"
                DropdownArrow.Parent = DropdownButton
                DropdownArrow.AnchorPoint = Vector2.new(1, 0.5)
                DropdownArrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownArrow.BackgroundTransparency = 1
                DropdownArrow.BorderColor3 = Color3.fromRGB(0, 0, 0)
                DropdownArrow.BorderSizePixel = 0
                DropdownArrow.Position = UDim2.new(1, -10, 0.5, 0)
                DropdownArrow.Size = UDim2.new(0, 12, 0, 12)
                DropdownArrow.Image = "rbxassetid://7072706679" -- Down arrow
                DropdownArrow.ImageColor3 = Visual.CurrentTheme.Text
                DropdownArrow.Rotation = 0
                
                local ItemsContainer = Instance.new("Frame")
                ItemsContainer.Name = "Items"
                ItemsContainer.Parent = Dropdown
                ItemsContainer.BackgroundColor3 = Visual.CurrentTheme.Secondary
                ItemsContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ItemsContainer.BorderSizePixel = 0
                ItemsContainer.Position = UDim2.new(0, 0, 0, 35)
                ItemsContainer.Size = UDim2.new(1, 0, 0, 0) -- This will be expanded when the dropdown is opened
                
                local UICornerItems = Instance.new("UICorner")
                UICornerItems.CornerRadius = UDim.new(0, 6)
                UICornerItems.Parent = ItemsContainer
                
                local ItemsList = Instance.new("ScrollingFrame")
                ItemsList.Name = "List"
                ItemsList.Parent = ItemsContainer
                ItemsList.Active = true
                ItemsList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ItemsList.BackgroundTransparency = 1
                ItemsList.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ItemsList.BorderSizePixel = 0
                ItemsList.Size = UDim2.new(1, 0, 1, 0)
                ItemsList.CanvasSize = UDim2.new(0, 0, 0, 0)
                ItemsList.ScrollBarThickness = 2
                ItemsList.ScrollBarImageColor3 = Visual.CurrentTheme.Accent
                
                local UIListLayoutItems = Instance.new("UIListLayout")
                UIListLayoutItems.Parent = ItemsList
                UIListLayoutItems.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayoutItems.Padding = UDim.new(0, 0)
                
                local UIPaddingItems = Instance.new("UIPadding")
                UIPaddingItems.Parent = ItemsList
                UIPaddingItems.PaddingLeft = UDim.new(0, 5)
                UIPaddingItems.PaddingRight = UDim.new(0, 5)
                UIPaddingItems.PaddingTop = UDim.new(0, 5)
                UIPaddingItems.PaddingBottom = UDim.new(0, 5)
                
                local dropdown = {Value = default, Open = false, Items = {}}
                
                function dropdown:Set(value)
                    dropdown.Value = value
                    SelectedText.Text = value
                    
                    if flag then
                        Visual.Flags[flag] = value
                        Visual:SaveFlags()
                    end
                    
                    pcall(callback, value)
                end
                
                function dropdown:Toggle()
                    dropdown.Open = not dropdown.Open
                    
                    local itemsCount = #items
                    local containerSize = math.min(itemsCount * 30, 150) -- Max height of 150, each item is 30 pixels
                    
                    if dropdown.Open then
                        Dropdown.Size = UDim2.new(1, 0, 0, 35 + containerSize + 10)
                        ItemsContainer.Size = UDim2.new(1, 0, 0, containerSize)
                        DropdownArrow.Rotation = 180
                    else
                        Dropdown.Size = UDim2.new(1, 0, 0, 35)
                        ItemsContainer.Size = UDim2.new(1, 0, 0, 0)
                        DropdownArrow.Rotation = 0
                    end
                    
                    Visual.DropdownOpen = dropdown.Open
                end
                
                function dropdown:AddItems()
                    for _, item in pairs(ItemsList:GetChildren()) do
                        if item:IsA("TextButton") then
                            item:Destroy()
                        end
                    end
                    
                    for _, itemText in pairs(items) do
                        local Item = Instance.new("TextButton")
                        Item.Name = "Item"
                        Item.Parent = ItemsList
                        Item.BackgroundColor3 = Visual.CurrentTheme.Primary
                        Item.BackgroundTransparency = 1
                        Item.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        Item.BorderSizePixel = 0
                        Item.Size = UDim2.new(1, 0, 0, 30)
                        Item.FontFace = Visual.CurrentTheme.Font
                        Item.Text = itemText
                        Item.TextColor3 = Visual.CurrentTheme.Text
                        Item.TextSize = 14
                        Item.AutoButtonColor = false
                        
                        Item.MouseEnter:Connect(function()
                            TweenService:Create(Item, TWEEN_INFO, {
                                BackgroundTransparency = 0.8,
                                BackgroundColor3 = Visual.CurrentTheme.Accent
                            }):Play()
                        end)
                        
                        Item.MouseLeave:Connect(function()
                            TweenService:Create(Item, TWEEN_INFO, {
                                BackgroundTransparency = 1
                            }):Play()
                        end)
                        
                        Item.MouseButton1Click:Connect(function()
                            dropdown:Set(itemText)
                            dropdown:Toggle()
                        end)
                        
                        table.insert(dropdown.Items, Item)
                    end
                    
                    ItemsList.CanvasSize = UDim2.new(0, 0, 0, UIListLayoutItems.AbsoluteContentSize.Y + 10)
                end
                
                DropdownButton.MouseEnter:Connect(function()
                    TweenService:Create(DropdownButton, TWEEN_INFO, {
                        BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                    }):Play()
                end)
                
                DropdownButton.MouseLeave:Connect(function()
                    TweenService:Create(DropdownButton, TWEEN_INFO, {
                        BackgroundColor3 = Visual.CurrentTheme.Primary
                    }):Play()
                end)
                
                DropdownButton.MouseButton1Click:Connect(function()
                    dropdown:Toggle()
                end)
                
                dropdown:AddItems()
                if default ~= "" then
                    dropdown:Set(default)
                end
                
                return dropdown
            end
            
            -- Create a textbox
            function section:Textbox(config)
                config = config or {}
                local textboxText = config.text or "Textbox"
                local default = config.default or ""
                local placeholder = config.placeholder or "Enter text..."
                local flag = config.flag
                local callback = config.callback or function() end
                
                if flag and Visual.Flags[flag] ~= nil then
                    default = Visual.Flags[flag]
                end
                
                local Textbox = Instance.new("Frame")
                Textbox.Name = "Textbox"
                Textbox.Parent = SectionContent
                Textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Textbox.BackgroundTransparency = 1
                Textbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Textbox.BorderSizePixel = 0
                Textbox.Size = UDim2.new(1, 0, 0, 50)
                
                local TextboxText = Instance.new("TextLabel")
                TextboxText.Name = "Text"
                TextboxText.Parent = Textbox
                TextboxText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxText.BackgroundTransparency = 1
                TextboxText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                TextboxText.BorderSizePixel = 0
                TextboxText.Position = UDim2.new(0, 0, 0, 0)
                TextboxText.Size = UDim2.new(1, 0, 0, 20)
                TextboxText.FontFace = Visual.CurrentTheme.Font
                TextboxText.Text = textboxText
                TextboxText.TextColor3 = Visual.CurrentTheme.Text
                TextboxText.TextSize = 14
                TextboxText.TextXAlignment = Enum.TextXAlignment.Left
                
                local TextboxInput = Instance.new("TextBox")
                TextboxInput.Name = "Input"
                TextboxInput.Parent = Textbox
                TextboxInput.BackgroundColor3 = Visual.CurrentTheme.Primary
                TextboxInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
                TextboxInput.BorderSizePixel = 0
                TextboxInput.Position = UDim2.new(0, 0, 0, 25)
                TextboxInput.Size = UDim2.new(1, 0, 0, 30)
                TextboxInput.FontFace = Visual.CurrentTheme.Font
                TextboxInput.PlaceholderText = placeholder
                TextboxInput.Text = default
                TextboxInput.TextColor3 = Visual.CurrentTheme.Text
                TextboxInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
                TextboxInput.TextSize = 14
                TextboxInput.ClearTextOnFocus = false
                
                local UICornerTextbox = Instance.new("UICorner")
                UICornerTextbox.CornerRadius = UDim.new(0, 6)
                UICornerTextbox.Parent = TextboxInput
                
                local UIPaddingTextbox = Instance.new("UIPadding")
                UIPaddingTextbox.Parent = TextboxInput
                UIPaddingTextbox.PaddingLeft = UDim.new(0, 8)
                UIPaddingTextbox.PaddingRight = UDim.new(0, 8)
                
                local textbox = {Value = default}
                
                function textbox:Set(value)
                    textbox.Value = value
                    TextboxInput.Text = value
                    
                    if flag then
                        Visual.Flags[flag] = value
                        Visual:SaveFlags()
                    end
                    
                    pcall(callback, value)
                end
                
                TextboxInput.FocusLost:Connect(function(enterPressed)
                    textbox:Set(TextboxInput.Text)
                end)
                
                textbox:Set(default)
                return textbox
            end
            
            -- Create a label
            function section:Label(config)
                config = config or {}
                local labelText = config.text or "Label"
                
                local Label = Instance.new("Frame")
                Label.Name = "Label"
                Label.Parent = SectionContent
                Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Label.BackgroundTransparency = 1
                Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Label.BorderSizePixel = 0
                Label.Size = UDim2.new(1, 0, 0, 25)
                
                local LabelText = Instance.new("TextLabel")
                LabelText.Name = "Text"
                LabelText.Parent = Label
                LabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelText.BackgroundTransparency = 1
                LabelText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                LabelText.BorderSizePixel = 0
                LabelText.Size = UDim2.new(1, 0, 1, 0)
                LabelText.FontFace = Visual.CurrentTheme.Font
                LabelText.Text = labelText
                LabelText.TextColor3 = Visual.CurrentTheme.Text
                LabelText.TextSize = 14
                LabelText.TextWrapped = true
                
                local label = {}
                
                function label:Set(text)
                    LabelText.Text = text
                end
                
                return label
            end
            
            -- Create a keybind
            function section:Keybind(config)
                config = config or {}
                local keybindText = config.text or "Keybind"
                local default = config.default or Enum.KeyCode.Unknown
                local flag = config.flag
                local callback = config.callback or function() end
                
                if flag and Visual.Flags[flag] ~= nil then
                    default = Enum.KeyCode[Visual.Flags[flag]]
                end
                
                local Keybind = Instance.new("Frame")
                Keybind.Name = "Keybind"
                Keybind.Parent = SectionContent
                Keybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Keybind.BackgroundTransparency = 1
                Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Keybind.BorderSizePixel = 0
                Keybind.Size = UDim2.new(1, 0, 0, 35)
                
                local KeybindButton = Instance.new("TextButton")
                KeybindButton.Name = "Button"
                KeybindButton.Parent = Keybind
                KeybindButton.BackgroundColor3 = Visual.CurrentTheme.Primary
                KeybindButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
                KeybindButton.BorderSizePixel = 0
                KeybindButton.Size = UDim2.new(1, 0, 1, 0)
                KeybindButton.FontFace = Visual.CurrentTheme.Font
                KeybindButton.Text = ""
                KeybindButton.TextColor3 = Visual.CurrentTheme.Text
                KeybindButton.TextSize = 14
                KeybindButton.AutoButtonColor = false
                
                local UICornerKeybind = Instance.new("UICorner")
                UICornerKeybind.CornerRadius = UDim.new(0, 6)
                UICornerKeybind.Parent = KeybindButton
                
                local KeybindText = Instance.new("TextLabel")
                KeybindText.Name = "Text"
                KeybindText.Parent = KeybindButton
                KeybindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindText.BackgroundTransparency = 1
                KeybindText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                KeybindText.BorderSizePixel = 0
                KeybindText.Position = UDim2.new(0, 10, 0, 0)
                KeybindText.Size = UDim2.new(1, -80, 1, 0)
                KeybindText.FontFace = Visual.CurrentTheme.Font
                KeybindText.Text = keybindText
                KeybindText.TextColor3 = Visual.CurrentTheme.Text
                KeybindText.TextSize = 14
                KeybindText.TextXAlignment = Enum.TextXAlignment.Left
                
                local KeybindDisplay = Instance.new("TextLabel")
                KeybindDisplay.Name = "Display"
                KeybindDisplay.Parent = KeybindButton
                KeybindDisplay.AnchorPoint = Vector2.new(1, 0.5)
                KeybindDisplay.BackgroundColor3 = Visual.CurrentTheme.Secondary
                KeybindDisplay.BorderColor3 = Color3.fromRGB(0, 0, 0)
                KeybindDisplay.BorderSizePixel = 0
                KeybindDisplay.Position = UDim2.new(1, -10, 0.5, 0)
                KeybindDisplay.Size = UDim2.new(0, 60, 0, 25)
                KeybindDisplay.FontFace = Visual.CurrentTheme.Font
                KeybindDisplay.Text = default == Enum.KeyCode.Unknown and "None" or default.Name
                KeybindDisplay.TextColor3 = Visual.CurrentTheme.Text
                KeybindDisplay.TextSize = 12
                
                local UICornerDisplay = Instance.new("UICorner")
                UICornerDisplay.CornerRadius = UDim.new(0, 4)
                UICornerDisplay.Parent = KeybindDisplay
                
                local keybind = {Value = default, Listening = false}
                
                function keybind:Set(key)
                    keybind.Value = key
                    
                    if flag then
                        Visual.Flags[flag] = key.Name
                        Visual:SaveFlags()
                    end
                    
                    KeybindDisplay.Text = key == Enum.KeyCode.Unknown and "None" or key.Name
                    pcall(callback, key)
                end
                
                KeybindButton.MouseEnter:Connect(function()
                    TweenService:Create(KeybindButton, TWEEN_INFO, {
                        BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                    }):Play()
                end)
                
                KeybindButton.MouseLeave:Connect(function()
                    TweenService:Create(KeybindButton, TWEEN_INFO, {
                        BackgroundColor3 = Visual.CurrentTheme.Primary
                    }):Play()
                end)
                
                KeybindButton.MouseButton1Click:Connect(function()
                    keybind.Listening = true
                    KeybindDisplay.Text = "..."
                end)
                
                UserInputService.InputBegan:Connect(function(input, processed)
                    if processed then return end
                    
                    if keybind.Listening then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            keybind:Set(input.KeyCode)
                            keybind.Listening = false
                        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                            keybind.Listening = false
                            KeybindDisplay.Text = keybind.Value == Enum.KeyCode.Unknown and "None" or keybind.Value.Name
                        end
                    elseif input.KeyCode == keybind.Value and keybind.Value ~= Enum.KeyCode.Unknown then
                        pcall(callback, keybind.Value)
                    end
                end)
                
                keybind:Set(default)
                return keybind
            end
            
            -- Create a color picker
            function section:ColorPicker(config)
                config = config or {}
                local colorText = config.text or "Color"
                local default = config.default or Color3.fromRGB(255, 255, 255)
                local flag = config.flag
                local callback = config.callback or function() end
                
                if flag and Visual.Flags[flag] ~= nil then
                    local color = Visual.Flags[flag]
                    default = Color3.fromRGB(color[1], color[2], color[3])
                end
                
                local ColorPicker = Instance.new("Frame")
                ColorPicker.Name = "ColorPicker"
                ColorPicker.Parent = SectionContent
                ColorPicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorPicker.BackgroundTransparency = 1
                ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ColorPicker.BorderSizePixel = 0
                ColorPicker.Size = UDim2.new(1, 0, 0, 35)
                
                local ColorButton = Instance.new("TextButton")
                ColorButton.Name = "Button"
                ColorButton.Parent = ColorPicker
                ColorButton.BackgroundColor3 = Visual.CurrentTheme.Primary
                ColorButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ColorButton.BorderSizePixel = 0
                ColorButton.Size = UDim2.new(1, 0, 1, 0)
                ColorButton.FontFace = Visual.CurrentTheme.Font
                ColorButton.Text = ""
                ColorButton.TextColor3 = Visual.CurrentTheme.Text
                ColorButton.TextSize = 14
                ColorButton.AutoButtonColor = false
                
                local UICornerColor = Instance.new("UICorner")
                UICornerColor.CornerRadius = UDim.new(0, 6)
                UICornerColor.Parent = ColorButton
                
                local ColorText = Instance.new("TextLabel")
                ColorText.Name = "Text"
                ColorText.Parent = ColorButton
                ColorText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorText.BackgroundTransparency = 1
                ColorText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ColorText.BorderSizePixel = 0
                ColorText.Position = UDim2.new(0, 10, 0, 0)
                ColorText.Size = UDim2.new(1, -70, 1, 0)
                ColorText.FontFace = Visual.CurrentTheme.Font
                ColorText.Text = colorText
                ColorText.TextColor3 = Visual.CurrentTheme.Text
                ColorText.TextSize = 14
                ColorText.TextXAlignment = Enum.TextXAlignment.Left
                
                local ColorDisplay = Instance.new("Frame")
                ColorDisplay.Name = "Display"
                ColorDisplay.Parent = ColorButton
                ColorDisplay.AnchorPoint = Vector2.new(1, 0.5)
                ColorDisplay.BackgroundColor3 = default
                ColorDisplay.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ColorDisplay.BorderSizePixel = 0
                ColorDisplay.Position = UDim2.new(1, -10, 0.5, 0)
                ColorDisplay.Size = UDim2.new(0, 50, 0, 25)
                
                local UICornerDisplay = Instance.new("UICorner")
                UICornerDisplay.CornerRadius = UDim.new(0, 4)
                UICornerDisplay.Parent = ColorDisplay
                
                local colorPicker = {Value = default, Open = false}
                
                function colorPicker:Set(color)
                    colorPicker.Value = color
                    ColorDisplay.BackgroundColor3 = color
                    
                    if flag then
                        Visual.Flags[flag] = {
                            math.floor(color.R * 255),
                            math.floor(color.G * 255),
                            math.floor(color.B * 255)
                        }
                        Visual:SaveFlags()
                    end
                    
                    pcall(callback, color)
                end
                
                ColorButton.MouseEnter:Connect(function()
                    TweenService:Create(ColorButton, TWEEN_INFO, {
                        BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                    }):Play()
                end)
                
                ColorButton.MouseLeave:Connect(function()
                    TweenService:Create(ColorButton, TWEEN_INFO, {
                        BackgroundColor3 = Visual.CurrentTheme.Primary
                    }):Play()
                end)
                
                ColorButton.MouseButton1Click:Connect(function()
                    -- Toggle color picker (simplified for example)
                    colorPicker.Open = not colorPicker.Open
                    -- Would implement a color picker UI here in a real implementation
                end)
                
                colorPicker:Set(default)
                return colorPicker
            end
            
            return section
        end
        
        -- Select the tab (if it's the first tab)
        if #window.Tabs == 0 then
            tab:Select()
        end
        
        table.insert(window.Tabs, tab)
        return tab
    end
    
    -- Load the flags
    Visual:LoadFlags()
    
    -- Add window to windows table
    table.insert(self.Windows, window)
    
    return window
end

-- Initialize
function Visual:Init()
    self:LoadFlags()
    return self
end

return Visual:Init()
