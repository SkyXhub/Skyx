--[[
⚡ SkyX Visual UI Library Initialization Fix ⚡
]]

local Library = {}
Library.connections = {}
Library.Flags = {}
Library.Enabled = true
Library.slider_drag = false
Library.core = nil
Library.dragging = false
Library.drag_position = nil
Library.start_position = nil
Library.hubName = "SkyX Hub"
Library.enabled = true -- Used in close() function to check UI state

function Library:CreateWindow(options)
    -- Clean up any existing UIs
    for _, obj in pairs(game:GetService("CoreGui"):GetChildren()) do
        if obj.Name == "Visual" then
            obj:Destroy()
        end
    end
    
    options = options or {}
    options.Title = options.Title or getgenv().namehub or "SkyX Hub"
    
    local UserInputService = game:GetService('UserInputService')
    local TweenService = game:GetService('TweenService')
    local HttpService = game:GetService('HttpService')
    local CoreGui = game:GetService('CoreGui')
    
    -- Create ScreenGui
    local container = Instance.new("ScreenGui")
    container.Name = "Visual"
    
    -- Add protection
    if syn and syn.protect_gui then
        syn.protect_gui(container)
        container.Parent = game.CoreGui
    elseif gethui then
        container.Parent = gethui()
    else
        container.Parent = CoreGui
    end
    
    -- Store core reference
    Library.core = container
    
    -- Create Shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = container
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BackgroundTransparency = 1
    Shadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BorderSizePixel = 0
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(0, 776, 0, 509)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://17290899982"
    
    -- Create Container
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Parent = container
    Container.AnchorPoint = Vector2.new(0.5, 0.5)
    Container.BackgroundColor3 = Color3.fromRGB(19, 20, 24)
    Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Container.BorderSizePixel = 0
    Container.ClipsDescendants = true
    Container.Position = UDim2.new(0.5, 0, 0.5, 0)
    Container.Size = UDim2.new(0, 699, 0, 426)
    
    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 20)
    ContainerCorner.Parent = Container
    
    -- Create Top Bar
    local Top = Instance.new("ImageLabel")
    Top.Name = "Top"
    Top.Parent = Container
    Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Top.BackgroundTransparency = 1
    Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Top.BorderSizePixel = 0
    Top.Size = UDim2.new(0, 699, 0, 39)
    Top.Image = "rbxassetid://17290652150"
    
    -- Add Logo
    local Logo = Instance.new("ImageLabel")
    Logo.Name = "Logo"
    Logo.Parent = Top
    Logo.AnchorPoint = Vector2.new(0.5, 0.5)
    Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Logo.BackgroundTransparency = 1
    Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Logo.BorderSizePixel = 0
    Logo.Position = UDim2.new(0.95, 0, 0.5, 0)
    Logo.Size = UDim2.new(0, 20, 0, 20)
    Logo.Image = "rbxassetid://10993237411" -- Default SkyX logo
    
    -- Add Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = Top
    TitleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TitleLabel.BorderSizePixel = 0
    TitleLabel.Position = UDim2.new(0.094, 0, 0.5, 0)
    TitleLabel.Size = UDim2.new(0, 75, 0, 16)
    TitleLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
    TitleLabel.Text = options.Title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Add Timer
    local Timer = Instance.new("TextLabel")
    Timer.Parent = Top
    Timer.AnchorPoint = Vector2.new(0.5, 0.5)
    Timer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Timer.BackgroundTransparency = 1
    Timer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Timer.BorderSizePixel = 0
    Timer.Position = UDim2.new(0.5, 0, 0.5, 0)
    Timer.Size = UDim2.new(0, 75, 0, 16)
    Timer.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
    Timer.Text = "00:00"
    Timer.TextColor3 = Color3.fromRGB(255, 255, 255)
    Timer.TextSize = 13
    Timer.TextTransparency = 0
    
    -- Setup Timer
    local startTime = os.time()
    
    local function formatTime(seconds)
        local minutes = math.floor(seconds / 60)
        local secs = seconds % 60
        return string.format("%02d:%02d", minutes, secs)
    end
    
    local function updateTextSmoothly(newText)
        local fadeOutInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local fadeInInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
        
        local fadeOut = TweenService:Create(Timer, fadeOutInfo, {TextTransparency = 1})
        fadeOut:Play()
        
        fadeOut.Completed:Connect(function()
            Timer.Text = newText
            local fadeIn = TweenService:Create(Timer, fadeInInfo, {TextTransparency = 0})
            fadeIn:Play()
        end)
    end
    
    spawn(function()
        while true do
            if not container.Parent then break end
            local elapsedTime = os.time() - startTime
            updateTextSmoothly(formatTime(elapsedTime))
            wait(1)
        end
    end)
    
    -- Create Divider Line
    local Line = Instance.new("Frame")
    Line.Name = "Line"
    Line.Parent = Container
    Line.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
    Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Line.BorderSizePixel = 0
    Line.Position = UDim2.new(0.296, 0, 0.092, 0)
    Line.Size = UDim2.new(0, 2, 0, 387)
    
    -- Create Tabs container
    local Tabs = Instance.new("ScrollingFrame")
    Tabs.Name = "Tabs"
    Tabs.Active = true
    Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tabs.BackgroundTransparency = 1
    Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Tabs.BorderSizePixel = 0
    Tabs.Position = UDim2.new(0, 0, 0.092, 0)
    Tabs.Size = UDim2.new(0, 209, 0, 386)
    Tabs.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
    Tabs.ScrollBarThickness = 0
    Tabs.Parent = Container
    
    local TabsList = Instance.new("UIListLayout")
    TabsList.Parent = Tabs
    TabsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabsList.SortOrder = Enum.SortOrder.LayoutOrder
    TabsList.Padding = UDim.new(0, 9)
    
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = Tabs
    UIPadding.PaddingTop = UDim.new(0, 15)
    
    -- Create Pages container
    local Pages = Instance.new("Frame")
    Pages.Name = "Pages"
    Pages.Parent = Container
    Pages.BackgroundTransparency = 1
    Pages.Position = UDim2.new(0.3, 0, 0.092, 0)
    Pages.Size = UDim2.new(0, 480, 0, 386)
    
    -- Add Mobile Button
    local Mobile = Instance.new("TextButton")
    Mobile.Name = "Mobile"
    Mobile.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
    Mobile.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Mobile.BorderSizePixel = 0
    Mobile.Position = UDim2.new(0.5, -300, 0.8, 33)
    Mobile.Size = UDim2.new(0, 85, 0, 38)
    Mobile.AutoButtonColor = false
    Mobile.Modal = true
    Mobile.Text = ""
    Mobile.TextColor3 = Color3.fromRGB(0, 0, 0)
    Mobile.TextSize = 14
    Mobile.Parent = container
    
    -- Setup mobile button position tweens
    local defaultPosition = UDim2.new(0.5, -300, 0.8, 33)
    local newPosition1 = UDim2.new(0.5, 0, 0.5, 0)
    
    local ctrlDown = false
    local cDown = false
    
    local function tweenPosition(targetPosition)
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        local goal = {Position = targetPosition}
        local tween = TweenService:Create(Mobile, tweenInfo, goal)
        tween:Play()
    end
    
    local function onInputBegan(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
            ctrlDown = true
        elseif input.KeyCode == Enum.KeyCode.C then
            cDown = true
        elseif input.KeyCode == Enum.KeyCode.P and ctrlDown and cDown then
            tweenPosition(newPosition1)
        elseif input.KeyCode == Enum.KeyCode.B and ctrlDown and cDown then
            tweenPosition(defaultPosition)
        end
    end
    
    local function onInputEnded(input)
        if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
            ctrlDown = false
        elseif input.KeyCode == Enum.KeyCode.C then
            cDown = false
        end
    end
    
    UserInputService.InputBegan:Connect(onInputBegan)
    UserInputService.InputEnded:Connect(onInputEnded)
    
    -- Mobile button dragging
    local dragging, dragInput, dragStart, startPos
    local mobileVisible = true
    
    local function update(input)
        local delta = input.Position - dragStart
        local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        
        TweenService:Create(Mobile, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = newPos}):Play()
    end
    
    Mobile.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Mobile.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    Mobile.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Setup menu dragging
    local menuDragging = false
    local menuDragInput
    local menuDragStart
    local menuStartPos
    
    Top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            menuDragging = true
            menuDragStart = input.Position
            menuStartPos = Container.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    menuDragging = false
                end
            end)
        end
    end)
    
    Top.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            menuDragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == menuDragInput and menuDragging then
            local delta = input.Position - menuDragStart
            Container.Position = UDim2.new(menuStartPos.X.Scale, menuStartPos.X.Offset + delta.X, menuStartPos.Y.Scale, menuStartPos.Y.Offset + delta.Y)
            Shadow.Position = Container.Position
        end
    end)
    
    -- Store important references
    local window = {}
    window.container = container
    window.shadow = Shadow
    window.main = Container
    window.tabs = Tabs
    window.pages = Pages
    window.mobile = Mobile
    
    -- Setup Open/Close functions
    function window:Toggle()
        Library.enabled = not Library.enabled
        
        if Library.enabled then
            window:Open()
        else
            window:Close()
        end
    end
    
    function window:Open()
        Container.Visible = true
        Shadow.Visible = true
        Mobile.Modal = true
        
        TweenService:Create(Container, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 699, 0, 426)
        }):Play()
        
        TweenService:Create(Shadow, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 776, 0, 509)
        }):Play()
    end
    
    function window:Close()
        TweenService:Create(Shadow, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        
        local main_tween = TweenService:Create(Container, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 0, 0, 0)
        })
        
        main_tween:Play()
        main_tween.Completed:Connect(function()
            if not Library.enabled then
                Container.Visible = false
                Shadow.Visible = false
                Mobile.Modal = false
            end
        end)
    end
    
    -- Fix references for Library functions
    Library.Window = window
    Library.Container = Container
    Library.Shadow = Shadow
    Library.Mobile = Mobile
    
    -- Add tab creation functionality
    function window:CreateTab(name, iconID)
        local tabID = #Tabs:GetChildren() - 1 -- Account for UIListLayout
        
        -- Create tab button
        local Tab = Instance.new("TextButton")
        Tab.Name = name.."Tab"
        Tab.Parent = Tabs
        Tab.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
        Tab.Size = UDim2.new(0, 183, 0, 40)
        Tab.AutoButtonColor = false
        Tab.Font = Enum.Font.SourceSans
        Tab.Text = ""
        Tab.TextColor3 = Color3.fromRGB(0, 0, 0)
        Tab.TextSize = 14
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 10)
        TabCorner.Parent = Tab
        
        local Icon = Instance.new("ImageLabel")
        Icon.Name = "Icon"
        Icon.Parent = Tab
        Icon.BackgroundTransparency = 1
        Icon.Position = UDim2.new(0.05, 0, 0.5, 0)
        Icon.AnchorPoint = Vector2.new(0, 0.5)
        Icon.Size = UDim2.new(0, 20, 0, 20)
        Icon.Image = iconID or "rbxassetid://7733799185" -- Default icon
        Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
        
        local Title = Instance.new("TextLabel")
        Title.Name = "Title"
        Title.Parent = Tab
        Title.BackgroundTransparency = 1
        Title.Position = UDim2.new(0.17, 0, 0.5, 0)
        Title.AnchorPoint = Vector2.new(0, 0.5)
        Title.Size = UDim2.new(0.8, 0, 0.9, 0)
        Title.Font = Enum.Font.GothamSemibold
        Title.Text = name
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextTransparency = 0.3
        Title.TextSize = 14
        Title.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Create page for this tab
        local Page = Instance.new("ScrollingFrame")
        Page.Name = name.."Page"
        Page.Parent = Pages
        Page.Active = true
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.Position = UDim2.new(0, 0, 0, 0)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.ScrollBarThickness = 3
        Page.ScrollBarImageColor3 = Color3.fromRGB(66, 135, 245) -- Accent color
        Page.Visible = false
        
        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Parent = Page
        PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 10)
        
        local PagePadding = Instance.new("UIPadding")
        PagePadding.Parent = Page
        PagePadding.PaddingTop = UDim.new(0, 10)
        
        -- Tab selection logic
        Tab.MouseButton1Click:Connect(function()
            -- Hide all pages
            for _, page in pairs(Pages:GetChildren()) do
                if page:IsA("ScrollingFrame") then
                    page.Visible = false
                end
            end
            
            -- Reset all tabs
            for _, tab in pairs(Tabs:GetChildren()) do
                if tab:IsA("TextButton") then
                    tab.BackgroundColor3 = Color3.fromRGB(27, 28, 33) -- Default color
                    
                    if tab:FindFirstChild("Title") then
                        tab.Title.TextTransparency = 0.3
                    end
                    
                    if tab:FindFirstChild("Icon") then
                        tab.Icon.ImageTransparency = 0.3
                    end
                end
            end
            
            -- Show selected page
            Page.Visible = true
            
            -- Highlight selected tab
            Tab.BackgroundColor3 = Color3.fromRGB(66, 135, 245) -- Accent color
            Title.TextTransparency = 0
            Icon.ImageTransparency = 0
        end)
        
        -- Select first tab by default
        if tabID == 0 then
            Tab.BackgroundColor3 = Color3.fromRGB(66, 135, 245) -- Accent color
            Title.TextTransparency = 0
            Icon.ImageTransparency = 0
            Page.Visible = true
        end
        
        -- Tab controls
        local tabControls = {}
        
        -- Section creation function
        function tabControls:CreateSection(sectionName)
            local Section = Instance.new("Frame")
            Section.Name = sectionName.."Section"
            Section.Parent = Page
            Section.BackgroundTransparency = 1
            Section.Size = UDim2.new(0.97, 0, 0, 40) -- Will adjust based on content
            
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "Title"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0.02, 0, 0, 0)
            SectionTitle.Size = UDim2.new(0.96, 0, 0, 30)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = sectionName
            SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.TextSize = 14
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local SectionContent = Instance.new("Frame")
            SectionContent.Name = "Content"
            SectionContent.Parent = Section
            SectionContent.BackgroundTransparency = 1
            SectionContent.Position = UDim2.new(0, 0, 0, 30)
            SectionContent.Size = UDim2.new(1, 0, 0, 0) -- Will grow based on content
            
            local ContentLayout = Instance.new("UIListLayout")
            ContentLayout.Parent = SectionContent
            ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ContentLayout.Padding = UDim.new(0, 8)
            
            -- Auto-size the section based on content
            ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionContent.Size = UDim2.new(1, 0, 0, ContentLayout.AbsoluteContentSize.Y)
                Section.Size = UDim2.new(0.97, 0, 0, 30 + ContentLayout.AbsoluteContentSize.Y + 10)
            end)
            
            -- Section controls
            local sectionControls = {}
            
            -- Button creation function
            function sectionControls:CreateButton(options)
                options = options or {}
                options.Name = options.Name or "Button"
                options.Callback = options.Callback or function() end
                
                local Button = Instance.new("TextButton")
                Button.Name = options.Name.."Button"
                Button.Parent = SectionContent
                Button.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
                Button.Size = UDim2.new(0.95, 0, 0, 35)
                Button.Font = Enum.Font.GothamSemibold
                Button.Text = options.Name
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.TextSize = 14
                Button.AutoButtonColor = false
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 6)
                ButtonCorner.Parent = Button
                
                -- Button hover and click effects
                Button.MouseEnter:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(36, 37, 43) -- Slightly lighter
                    }):Play()
                end)
                
                Button.MouseLeave:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(27, 28, 33)
                    }):Play()
                end)
                
                Button.MouseButton1Down:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.1), {
                        BackgroundColor3 = Color3.fromRGB(66, 135, 245) -- Accent color
                    }):Play()
                end)
                
                Button.MouseButton1Up:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.1), {
                        BackgroundColor3 = Color3.fromRGB(36, 37, 43)
                    }):Play()
                    
                    pcall(options.Callback)
                end)
                
                return Button
            end
            
            -- Toggle creation function
            function sectionControls:CreateToggle(options)
                options = options or {}
                options.Name = options.Name or "Toggle"
                options.CurrentValue = options.CurrentValue or false
                options.Flag = options.Flag or nil
                options.Callback = options.Callback or function() end
                
                -- Set flag if provided
                if options.Flag then
                    Library.Flags[options.Flag] = options.CurrentValue
                end
                
                local Toggle = Instance.new("Frame")
                Toggle.Name = options.Name.."Toggle"
                Toggle.Parent = SectionContent
                Toggle.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
                Toggle.Size = UDim2.new(0.95, 0, 0, 35)
                
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 6)
                ToggleCorner.Parent = Toggle
                
                local ToggleTitle = Instance.new("TextLabel")
                ToggleTitle.Name = "Title"
                ToggleTitle.Parent = Toggle
                ToggleTitle.BackgroundTransparency = 1
                ToggleTitle.Position = UDim2.new(0.03, 0, 0, 0)
                ToggleTitle.Size = UDim2.new(0.5, 0, 1, 0)
                ToggleTitle.Font = Enum.Font.GothamSemibold
                ToggleTitle.Text = options.Name
                ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleTitle.TextSize = 14
                ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                -- Toggle Switch
                local ToggleSwitch = Instance.new("Frame")
                ToggleSwitch.Name = "Switch"
                ToggleSwitch.Parent = Toggle
                ToggleSwitch.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                ToggleSwitch.Position = UDim2.new(0.85, 0, 0.5, 0)
                ToggleSwitch.AnchorPoint = Vector2.new(0, 0.5)
                ToggleSwitch.Size = UDim2.new(0, 35, 0, 18)
                
                local SwitchCorner = Instance.new("UICorner")
                SwitchCorner.CornerRadius = UDim.new(1, 0)
                SwitchCorner.Parent = ToggleSwitch
                
                local SwitchKnob = Instance.new("Frame")
                SwitchKnob.Name = "Knob"
                SwitchKnob.Parent = ToggleSwitch
                SwitchKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SwitchKnob.Position = UDim2.new(0, 2, 0.5, 0)
                SwitchKnob.AnchorPoint = Vector2.new(0, 0.5)
                SwitchKnob.Size = UDim2.new(0, 14, 0, 14)
                
                local KnobCorner = Instance.new("UICorner")
                KnobCorner.CornerRadius = UDim.new(1, 0)
                KnobCorner.Parent = SwitchKnob
                
                -- Update toggle display based on value
                local function UpdateToggle()
                    if options.CurrentValue then
                        TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
                            BackgroundColor3 = Color3.fromRGB(66, 135, 245) -- Accent color
                        }):Play()
                        
                        TweenService:Create(SwitchKnob, TweenInfo.new(0.2), {
                            Position = UDim2.new(0, 19, 0.5, 0)
                        }):Play()
                    else
                        TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
                            BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                        }):Play()
                        
                        TweenService:Create(SwitchKnob, TweenInfo.new(0.2), {
                            Position = UDim2.new(0, 2, 0.5, 0)
                        }):Play()
                    end
                    
                    -- Update flag if provided
                    if options.Flag then
                        Library.Flags[options.Flag] = options.CurrentValue
                    end
                    
                    pcall(options.Callback, options.CurrentValue)
                end
                
                -- Set initial toggle state
                UpdateToggle()
                
                -- Create click region for the entire toggle
                local ClickRegion = Instance.new("TextButton")
                ClickRegion.Name = "ClickRegion"
                ClickRegion.Parent = Toggle
                ClickRegion.BackgroundTransparency = 1
                ClickRegion.Size = UDim2.new(1, 0, 1, 0)
                ClickRegion.Text = ""
                ClickRegion.ZIndex = 10
                
                ClickRegion.MouseButton1Click:Connect(function()
                    options.CurrentValue = not options.CurrentValue
                    UpdateToggle()
                end)
                
                -- Hover effect
                ClickRegion.MouseEnter:Connect(function()
                    TweenService:Create(Toggle, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(36, 37, 43) -- Slightly lighter
                    }):Play()
                end)
                
                ClickRegion.MouseLeave:Connect(function()
                    TweenService:Create(Toggle, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(27, 28, 33)
                    }):Play()
                end)
                
                local toggleObj = {
                    Instance = Toggle,
                    Value = options.CurrentValue,
                    Set = function(self, value)
                        options.CurrentValue = value
                        UpdateToggle()
                    end
                }
                
                return toggleObj
            end
            
            return sectionControls
        end
        
        return tabControls
    end
    
    -- Initialize the window
    window:Open()
    
    return window
end

-- Return the library
return Library
