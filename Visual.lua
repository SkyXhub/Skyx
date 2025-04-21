--[[
⣿⣿⣿⣿⡿⠟⠛⠋⠉⠉⠉⠉⠉⠛⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⠟⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠈⠙⠾⣿⣾⣿⣾⣿⣾⣿⣾⣿
⠋⡁⠀⠀⠀⠀⠀⢀⠔⠁⠀⠀⢀⠠⠐⠈⠁⠀⠀⠁⠀⠈⠻⢾⣿⣾⣿⣾⣟⣿
⠊⠀⠀⠀⠀⢀⠔⠃⠀⠀⠠⠈⠁⠀⠀⠀⠀⠀⠀⠆⠀⠀⠄⠀⠙⣾⣷⣿⢿⣿
⠀⠀⠀⠀⡠⠉⠀⠀⠀⠀⠠⢰⢀⠀⠀⠀⠀⠀⠀⢰⠀⠀⠈⡀⠀⠈⢿⣟⣿⣿
⠀⠀⢀⡜⣐⠃⠀⠀⠀⣠⠁⡄⠰⠀⠀⠀⠀⠀⠀⠐⠀⠀⠀⠰⠀⠀⠈⢿⣿⣿
⠀⢠⠆⢠⡃⠀⠀⠀⣔⠆⡘⡇⢘⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿
⢀⡆⠀⡼⢣⠀⢀⠌⢸⢠⠇⡇⢘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿
⣼⣃⠀⠁⢸⢀⠎⠀⢸⠎⠀⢸⢸⡄⠀⠀⠀⠀⠀⠂⢀⠀⠀⠀⠀⠀⠀⠀⠀⣿
⠃⡏⠟⣷⣤⠁⠀⠀⠸⠀⠀⡾⢀⢇⠀⠀⠀⠀⠀⠄⠸⠀⠀⠀⠀⠄⠀⠀⠀⣿
⠀⠀⣀⣿⣿⣿⢦⠀⠀⠀⠀⡧⠋⠘⡄⠀⠀⠀⠀⡇⢸⠀⠀⠠⡘⠀⠀⠀⢠⣿
⠈⠀⢿⢗⡻⠃⠀⠀⠀⠀⠀⠀⠀⠀⠱⡀⠀⠀⢰⠁⡇⠀⠀⢨⠃⡄⢀⠀⣸⣿
⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣱⠀⠀⡎⠸⠁⠀⢀⠞⡸⠀⡜⢠⣿⣿
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣺⣿⣧⢰⣧⡁⡄⠀⡞⠰⠁⡸⣠⣿⣿⣿
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⡿⠏⣿⠟⢁⠾⢛⣧⢼⠁⠀⠀⢰⣿⡿⣷⣿
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠡⠄⠀⡠⣚⡷⠊⠀⠀⠀⣿⡿⣿⡿⣿
⡀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠊⠁⢸⠁⠀⠀⠀⢰⣿⣿⡿⣿⣿
⠱⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠊⠀⠀⠀⡞⠀⠀⠀⠀⢸⣿⣷⣿⣿⣿
⠀⠙⢦⣀⠀⠀⠀⠀⠀⢀⣀⣠⠖⠁⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⣸⣿⣾⡿⣷⣿
⠀⠀⠀⠀⠉⠉⣩⡞⠉⠁⠀⢸⡄⠀⠀⠀⠀⠀⢰⠇⠀⠀⠀⠀⣿⣿⣷⣿⣿⣿

⚡ SkyX - Visual UI Library ⚡
Modified from VisualBETA for SkyX Hub by LAJ Team
BlackBloom Edition v2.0
]]

local UserInputService = game:GetService('UserInputService')
local LocalPlayer = game:GetService('Players').LocalPlayer
local TweenService = game:GetService('TweenService')
local HttpService = game:GetService('HttpService')
local CoreGui = game:GetService('CoreGui')
local RunService = game:GetService('RunService')

local Mouse = LocalPlayer:GetMouse()

local Library = {
    connections = {},
    Flags = {},
    Enabled = true,
    slider_drag = false,
    core = nil,
    dragging = false,
    drag_position = nil,
    start_position = nil,
    hubName = "SkyX Hub", -- Default name
    blackbloom = true, -- Use BlackBloom theme by default
}

-- Check if running in a supported environment
local isRobloxEnvironment = (function()
    return type(game) == "userdata" and type(game.GetService) == "function"
end)()

-- Handle folder creation safely
local function createFolder(folderName)
    if isRobloxEnvironment then
        if not isfolder(folderName) then
            pcall(function() 
                makefolder(folderName) 
            end)
        end
    end
end

createFolder("SkyX")

function Library:disconnect()
    for _, value in pairs(self.connections) do
        if not value then
            continue
        end
        
        pcall(function() value:Disconnect() end)
        self.connections[_] = nil
    end
end

function Library:clear()
    if not isRobloxEnvironment then return end
    
    pcall(function()
        for _, object in pairs(CoreGui:GetChildren()) do
            if object.Name ~= "SkyX_UI" then
                continue
            end
        
            object:Destroy()
        end
    end)
end

function Library:exist()
    if not self.core then return false end
    if not self.core.Parent then return false end
    return true
end

function Library:save_flags()
    if not self:exist() or not isRobloxEnvironment then return end

    pcall(function()
        local flags = HttpService:JSONEncode(self.Flags)
        writefile(`SkyX/{game.GameId}.lua`, flags)
    end)
end

function Library:load_flags()
    if not isRobloxEnvironment then return end
    
    if not isfile(`SkyX/{game.GameId}.lua`) then 
        self:save_flags() 
        return 
    end

    pcall(function()
        local flags = readfile(`SkyX/{game.GameId}.lua`)
        if not flags then 
            self:save_flags() 
            return 
        end

        self.Flags = HttpService:JSONDecode(flags)
    end)
end

-- Load flags and clear existing UI
Library:load_flags()
Library:clear()

function Library:open()
    if not self:exist() then return end
    
    self.Container.Visible = true
    self.Shadow.Visible = true
    
    if self.Mobile then
        self.Mobile.Modal = true
    end

    TweenService:Create(self.Container, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
        Size = UDim2.new(0, 699, 0, 426)
    }):Play()

    TweenService:Create(self.Shadow, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
        Size = UDim2.new(0, 776, 0, 509)
    }):Play()
end

function Library:close()
    if not self:exist() then return end
    
    TweenService:Create(self.Shadow, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()

    local main_tween = TweenService:Create(self.Container, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
        Size = UDim2.new(0, 0, 0, 0)
    })

    main_tween:Play()
    main_tween.Completed:Once(function()
        if self.Enabled then
            return
        end

        self.Container.Visible = false
        self.Shadow.Visible = false
        
        if self.Mobile then
            self.Mobile.Modal = false
        end
    end)
end

function Library:drag()
    if not self:exist() then return end
    if not self.drag_position then return end
    if not self.start_position then return end
    
    local delta = UserInputService:GetMouseLocation() - self.drag_position
    local position = UDim2.new(
        self.start_position.X.Scale, 
        self.start_position.X.Offset + delta.X, 
        self.start_position.Y.Scale, 
        self.start_position.Y.Offset + delta.Y
    )

    TweenService:Create(self.Container, TweenInfo.new(0.2), {
        Position = position
    }):Play()

    TweenService:Create(self.Shadow, TweenInfo.new(0.2), {
        Position = position
    }):Play()
end

function Library:toggle()
    if not self:exist() then return end
    
    self.Enabled = not self.Enabled

    if self.Enabled then
        self:open()
    else
        self:close()
    end
end

function Library:set_theme(blackbloom)
    self.blackbloom = blackbloom
    
    -- Update UI theme elements based on blackbloom setting
    if self.Container then
        if blackbloom then
            -- BlackBloom theme colors
            self.Container.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
            if self.Shadow then
                self.Shadow.ImageColor3 = Color3.fromRGB(0, 0, 5)
            end
        else
            -- Ocean theme colors
            self.Container.BackgroundColor3 = Color3.fromRGB(19, 20, 24)
            if self.Shadow then
                self.Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
            end
        end
    end
end

function Library:Create(options)
    options = options or {}
    self.hubName = options.name or "SkyX Hub"
    
    if options.blackbloom ~= nil then
        self.blackbloom = options.blackbloom
    end
    
    -- Initialize the UI
    local container = Instance.new("ScreenGui")
    container.Name = "SkyX_UI"
    
    -- Handle different parent options based on environment
    if isRobloxEnvironment then
        container.Parent = CoreGui
    else
        print("⚠️ Warning: Not running in a Roblox environment. UI creation may not work properly.")
    end

    self.core = container

    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = container
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BackgroundTransparency = 1.000
    Shadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BorderSizePixel = 0
    Shadow.Position = UDim2.new(0.508668244, 0, 0.5, 0)
    Shadow.Size = UDim2.new(0, 0, 0, 0) -- Start small for animation
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://17290899982"
    Shadow.ImageColor3 = self.blackbloom and Color3.fromRGB(0, 0, 5) or Color3.fromRGB(0, 0, 0)

    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Parent = container
    Container.AnchorPoint = Vector2.new(0.5, 0.5)
    Container.BackgroundColor3 = self.blackbloom and Color3.fromRGB(10, 10, 12) or Color3.fromRGB(19, 20, 24)
    Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Container.BorderSizePixel = 0
    Container.ClipsDescendants = true
    Container.Position = UDim2.new(0.5, 0, 0.5, 0)
    Container.Size = UDim2.new(0, 0, 0, 0) -- Start small for animation

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 20)
    ContainerCorner.Parent = Container

    local Top = Instance.new("ImageLabel")
    Top.Name = "Top"
    Top.Parent = Container
    Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Top.BackgroundTransparency = 1.000
    Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Top.BorderSizePixel = 0
    Top.Size = UDim2.new(0, 699, 0, 39)
    Top.Image = "rbxassetid://17290652150"

    local Logo = Instance.new("ImageLabel")
    Logo.Name = "Logo"
    Logo.Parent = Top
    Logo.AnchorPoint = Vector2.new(0.5, 0.5)
    Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Logo.BackgroundTransparency = 1.000
    Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Logo.BorderSizePixel = 0
    Logo.Position = UDim2.new(0.950000048, 0, 0.5, 0)
    Logo.Size = UDim2.new(0, 20, 0, 20)
    Logo.Image = "rbxassetid://11876864401" -- SkyX temporary logo
    Logo.ImageTransparency = 0.2
    
    local Title = Instance.new("TextLabel")
    Title.Parent = Top
    Title.AnchorPoint = Vector2.new(0.5, 0.5)
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0.0938254446, 0, 0.496794879, 0)
    Title.Size = UDim2.new(0, 75, 0, 16)
    Title.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
    Title.Text = self.hubName
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.TextSize = 14.000
    Title.TextWrapped = true
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local TimeDisplay = Instance.new("TextLabel")
    TimeDisplay.Parent = Top
    TimeDisplay.AnchorPoint = Vector2.new(0.5, 0.5)
    TimeDisplay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TimeDisplay.BackgroundTransparency = 1.000
    TimeDisplay.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TimeDisplay.BorderSizePixel = 0
    TimeDisplay.Position = UDim2.new(0.5, 0, 0.5, 0)
    TimeDisplay.Size = UDim2.new(0, 75, 0, 16)
    TimeDisplay.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
    TimeDisplay.Text = "00:00"
    TimeDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
    TimeDisplay.TextScaled = true
    TimeDisplay.TextSize = 13
    TimeDisplay.TextWrapped = true
    TimeDisplay.TextXAlignment = Enum.TextXAlignment.Center
    TimeDisplay.TextTransparency = 0

    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Parent = Top
    Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Icon.BackgroundTransparency = 1.000
    Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Icon.BorderSizePixel = 0
    Icon.Position = UDim2.new(0.930000007, 0, 0.200000003, 0)
    Icon.Size = UDim2.new(0, 25, 0, 25)
    Icon.ZIndex = 3
    Icon.Image = "rbxassetid://11876864401" -- Default to SkyX temporary icon
    
    -- Add the theme icon (lightning for BlackBloom or water for Ocean)
    if self.blackbloom then
        Icon.Image = "rbxassetid://7733774602" -- Lightning icon
    else
        Icon.Image = "rbxassetid://7733920644" -- Water icon
    end

    local Line = Instance.new("Frame")
    Line.Name = "Line"
    Line.Parent = Container
    Line.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
    Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Line.BorderSizePixel = 0
    Line.Position = UDim2.new(0.296137333, 0, 0.0915492922, 0)
    Line.Size = UDim2.new(0, 2, 0, 387)

    local Tabs = Instance.new("ScrollingFrame")
    Tabs.Name = "Tabs"
    Tabs.Parent = Container
    Tabs.Active = true
    Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tabs.BackgroundTransparency = 1.000
    Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Tabs.BorderSizePixel = 0
    Tabs.Position = UDim2.new(0, 0, 0.0915492922, 0)
    Tabs.Size = UDim2.new(0, 209, 0, 386)
    Tabs.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
    Tabs.ScrollBarThickness = 0
    
    local TabsList = Instance.new("UIListLayout")
    TabsList.Parent = Tabs
    TabsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabsList.SortOrder = Enum.SortOrder.LayoutOrder
    TabsList.Padding = UDim.new(0, 5)
    
    local TabsPadding = Instance.new("UIPadding")
    TabsPadding.Parent = Tabs
    TabsPadding.PaddingTop = UDim.new(0, 7)
    
    local Pages = Instance.new("Frame")
    Pages.Name = "Pages"
    Pages.Parent = Container
    Pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Pages.BackgroundTransparency = 1.000
    Pages.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Pages.BorderSizePixel = 0
    Pages.Position = UDim2.new(0.299, 0, 0.0915492922, 0)
    Pages.Size = UDim2.new(0, 490, 0, 386)
    
    -- Setup time display
    local startTime = os.time()

    local function formatTime(seconds)
        local minutes = math.floor(seconds / 60)
        local secs = seconds % 60
        return string.format("%02d:%02d", minutes, secs)
    end

    local function updateTextSmoothly(newText)
        local fadeOutInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local fadeInInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
        
        local fadeOut = TweenService:Create(TimeDisplay, fadeOutInfo, {TextTransparency = 1})
        fadeOut:Play()

        fadeOut.Completed:Connect(function()
            TimeDisplay.Text = newText
            local fadeIn = TweenService:Create(TimeDisplay, fadeInInfo, {TextTransparency = 0})
            fadeIn:Play()
        end)
    end

    -- Update time display
    local timeUpdater = RunService.Heartbeat:Connect(function()
        if not Library:exist() then
            timeUpdater:Disconnect()
            return
        end
        
        local elapsedTime = os.time() - startTime
        if elapsedTime % 1 == 0 then -- Update every second
            updateTextSmoothly(formatTime(elapsedTime))
        end
    end)
    
    table.insert(self.connections, timeUpdater)
    
    -- Make the top bar draggable
    local dragging = false
    local dragStart = nil
    local startPos = nil

    -- Dragging functionality for the top bar
    local function updateDrag(input)
        if not dragging or not startPos then return end
        
        local delta = input.Position - dragStart
        local newPosition = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
        
        Container.Position = newPosition
        Shadow.Position = newPosition
    end

    Top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Container.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            updateDrag(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            dragStart = nil
            startPos = nil
        end
    end)
    
    -- Store references
    self.Container = Container
    self.Shadow = Shadow
    self.Tabs = Tabs
    self.Pages = Pages
    
    -- Initially open the UI
    self:open()
    
    return self
end

-- Function to add a tab to the UI
function Library:AddTab(title, icon)
    if not self:exist() then return end
    
    local TabButton = Instance.new("TextButton")
    TabButton.Name = title.."Tab"
    TabButton.Parent = self.Tabs
    TabButton.BackgroundColor3 = Color3.fromRGB(26, 27, 32)
    TabButton.BackgroundTransparency = 1.000
    TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabButton.BorderSizePixel = 0
    TabButton.Position = UDim2.new(0.0430622026, 0, 0, 0)
    TabButton.Size = UDim2.new(0, 183, 0, 40)
    TabButton.AutoButtonColor = false
    TabButton.Font = Enum.Font.SourceSans
    TabButton.Text = ""
    TabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    TabButton.TextSize = 14.000
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 10)
    TabCorner.Parent = TabButton
    
    local TabIcon = Instance.new("ImageLabel")
    TabIcon.Name = "Icon"
    TabIcon.Parent = TabButton
    TabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabIcon.BackgroundTransparency = 1.000
    TabIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabIcon.BorderSizePixel = 0
    TabIcon.Position = UDim2.new(0.0655737705, 0, 0.274999917, 0)
    TabIcon.Size = UDim2.new(0, 18, 0, 18)
    
    -- Set icon based on name or provided icon
    if icon then
        TabIcon.Image = icon
    else
        -- Default icons based on common tab names
        if title:lower():match("main") then
            TabIcon.Image = "rbxassetid://7733799185" -- Home icon
        elseif title:lower():match("player") or title:lower():match("character") then
            TabIcon.Image = "rbxassetid://7743875962" -- Player icon
        elseif title:lower():match("teleport") then
            TabIcon.Image = "rbxassetid://7743875930" -- Teleport icon
        elseif title:lower():match("combat") or title:lower():match("weapon") then
            TabIcon.Image = "rbxassetid://7743875900" -- Combat icon
        elseif title:lower():match("farm") or title:lower():match("auto") then
            TabIcon.Image = "rbxassetid://7743875878" -- Farm icon
        elseif title:lower():match("visual") or title:lower():match("esp") then
            TabIcon.Image = "rbxassetid://7743875850" -- Visual icon
        elseif title:lower():match("misc") or title:lower():match("other") then
            TabIcon.Image = "rbxassetid://7743875826" -- Misc icon
        elseif title:lower():match("setting") then
            TabIcon.Image = "rbxassetid://7743875782" -- Settings icon
        else
            TabIcon.Image = "rbxassetid://7743875805" -- Default icon
        end
    end
    
    local TabTitle = Instance.new("TextLabel")
    TabTitle.Name = "Title"
    TabTitle.Parent = TabButton
    TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabTitle.BackgroundTransparency = 1.000
    TabTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabTitle.BorderSizePixel = 0
    TabTitle.Position = UDim2.new(0.19126289, 0, 0.275000006, 0)
    TabTitle.Size = UDim2.new(0, 130, 0, 18)
    TabTitle.Font = Enum.Font.GothamMedium
    TabTitle.Text = title
    TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabTitle.TextSize = 14.000
    TabTitle.TextTransparency = 0.300
    TabTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Create the page for this tab
    local Page = Instance.new("ScrollingFrame")
    Page.Name = title.."Page"
    Page.Parent = self.Pages
    Page.Active = true
    Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Page.BackgroundTransparency = 1.000
    Page.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Page.BorderSizePixel = 0
    Page.Position = UDim2.new(0, 0, 0, 0)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(66, 135, 245) -- Bright blue for BlackBloom theme
    Page.Visible = false -- Initially hidden
    
    local PageList = Instance.new("UIListLayout")
    PageList.Parent = Page
    PageList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.Padding = UDim.new(0, 10)
    
    local PagePadding = Instance.new("UIPadding")
    PagePadding.Parent = Page
    PagePadding.PaddingTop = UDim.new(0, 10)
    PagePadding.PaddingBottom = UDim.new(0, 10)
    
    -- Tab selection functionality
    TabButton.MouseButton1Click:Connect(function()
        -- Hide all pages
        for _, child in pairs(self.Pages:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        
        -- Reset all tab buttons
        for _, tab in pairs(self.Tabs:GetChildren()) do
            if tab:IsA("TextButton") then
                tab.BackgroundTransparency = 1
                tab.Title.TextTransparency = 0.3
            end
        end
        
        -- Show this page and highlight this tab
        Page.Visible = true
        TabButton.BackgroundTransparency = 0.5
        TabButton.Title.TextTransparency = 0
        
        -- Add a nice selection effect
        TweenService:Create(TabButton, TweenInfo.new(0.3), {
            BackgroundColor3 = self.blackbloom and Color3.fromRGB(30, 50, 80) or Color3.fromRGB(30, 80, 110)
        }):Play()
    end)
    
    -- Select the first tab by default if this is the first one
    if #self.Tabs:GetChildren() == 2 then -- UIListLayout + this new tab
        TabButton.BackgroundTransparency = 0.5
        TabButton.Title.TextTransparency = 0
        Page.Visible = true
        
        TabButton.BackgroundColor3 = self.blackbloom and Color3.fromRGB(30, 50, 80) or Color3.fromRGB(30, 80, 110)
    end
    
    -- Object to store tab functions
    local tabObject = {}
    
    -- Function to add a section to this tab
    function tabObject:AddSection(sectionTitle)
        local Section = Instance.new("Frame")
        Section.Name = sectionTitle.."Section"
        Section.Parent = Page
        Section.BackgroundColor3 = Color3.fromRGB(26, 27, 32)
        Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Section.BorderSizePixel = 0
        Section.Size = UDim2.new(0, 460, 0, 36) -- Will auto-adjust height based on content
        
        local SectionCorner = Instance.new("UICorner")
        SectionCorner.CornerRadius = UDim.new(0, 10)
        SectionCorner.Parent = Section
        
        local SectionTitle = Instance.new("TextLabel")
        SectionTitle.Name = "Title"
        SectionTitle.Parent = Section
        SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SectionTitle.BackgroundTransparency = 1.000
        SectionTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SectionTitle.BorderSizePixel = 0
        SectionTitle.Position = UDim2.new(0.031, 0, 0, 8)
        SectionTitle.Size = UDim2.new(0, 420, 0, 20)
        SectionTitle.Font = Enum.Font.GothamBold
        SectionTitle.Text = sectionTitle
        SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        SectionTitle.TextSize = 16.000
        SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        
        local ContentFrame = Instance.new("Frame")
        ContentFrame.Name = "Content"
        ContentFrame.Parent = Section
        ContentFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ContentFrame.BackgroundTransparency = 1.000
        ContentFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ContentFrame.BorderSizePixel = 0
        ContentFrame.Position = UDim2.new(0, 0, 0, 36) -- Below the title
        ContentFrame.Size = UDim2.new(1, 0, 0, 0) -- Will expand with content
        
        local ContentList = Instance.new("UIListLayout")
        ContentList.Parent = ContentFrame
        ContentList.HorizontalAlignment = Enum.HorizontalAlignment.Center
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, 8)
        
        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.Parent = ContentFrame
        ContentPadding.PaddingTop = UDim.new(0, 8)
        ContentPadding.PaddingBottom = UDim.new(0, 8)
        
        -- Auto-size the section based on content
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            ContentFrame.Size = UDim2.new(1, 0, 0, ContentList.AbsoluteContentSize.Y + 16) -- +16 for padding
            Section.Size = UDim2.new(0, 460, 0, 36 + ContentFrame.Size.Y.Offset)
        end)
        
        local sectionObject = {}
        
        -- Add button to section
        function sectionObject:AddButton(options)
            options = options or {}
            options.text = options.text or "Button"
            options.callback = options.callback or function() end
            
            local Button = Instance.new("TextButton")
            Button.Name = options.text.."Button"
            Button.Parent = ContentFrame
            Button.BackgroundColor3 = Color3.fromRGB(36, 37, 42)
            Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Button.BorderSizePixel = 0
            Button.Size = UDim2.new(0, 440, 0, 36)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.GothamMedium
            Button.Text = options.text
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 14.000
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = Button
            
            -- Button effects
            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Library.blackbloom and Color3.fromRGB(40, 50, 70) or Color3.fromRGB(40, 70, 100)
                }):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(36, 37, 42)
                }):Play()
            end)
            
            Button.MouseButton1Down:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.1), {
                    BackgroundColor3 = Library.blackbloom and Color3.fromRGB(50, 70, 100) or Color3.fromRGB(50, 100, 150)
                }):Play()
            end)
            
            Button.MouseButton1Up:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.1), {
                    BackgroundColor3 = Library.blackbloom and Color3.fromRGB(40, 50, 70) or Color3.fromRGB(40, 70, 100)
                }):Play()
                
                pcall(options.callback)
            end)
            
            return Button
        end
        
        -- Add toggle to section
        function sectionObject:AddToggle(options)
            options = options or {}
            options.text = options.text or "Toggle"
            options.default = options.default or false
            options.flag = options.flag or options.text:gsub("%s+", "").."Toggle"
            options.callback = options.callback or function() end
            
            -- Set default flag value
            Library.Flags[options.flag] = options.default
            
            local Toggle = Instance.new("Frame")
            Toggle.Name = options.text.."Toggle"
            Toggle.Parent = ContentFrame
            Toggle.BackgroundColor3 = Color3.fromRGB(36, 37, 42)
            Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.BorderSizePixel = 0
            Toggle.Size = UDim2.new(0, 440, 0, 36)
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 6)
            ToggleCorner.Parent = Toggle
            
            local ToggleTitle = Instance.new("TextLabel")
            ToggleTitle.Name = "Title"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ToggleTitle.BorderSizePixel = 0
            ToggleTitle.Position = UDim2.new(0.03, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0, 350, 0, 36)
            ToggleTitle.Font = Enum.Font.GothamMedium
            ToggleTitle.Text = options.text
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 14.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local ToggleSwitch = Instance.new("Frame")
            ToggleSwitch.Name = "Switch"
            ToggleSwitch.Parent = Toggle
            ToggleSwitch.BackgroundColor3 = Color3.fromRGB(46, 47, 52)
            ToggleSwitch.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ToggleSwitch.BorderSizePixel = 0
            ToggleSwitch.Position = UDim2.new(0.92, 0, 0.5, 0)
            ToggleSwitch.AnchorPoint = Vector2.new(0, 0.5)
            ToggleSwitch.Size = UDim2.new(0, 36, 0, 18)
            
            local SwitchCorner = Instance.new("UICorner")
            SwitchCorner.CornerRadius = UDim.new(1, 0)
            SwitchCorner.Parent = ToggleSwitch
            
            local SwitchCircle = Instance.new("Frame")
            SwitchCircle.Name = "Circle"
            SwitchCircle.Parent = ToggleSwitch
            SwitchCircle.AnchorPoint = Vector2.new(0, 0.5)
            SwitchCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SwitchCircle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SwitchCircle.BorderSizePixel = 0
            SwitchCircle.Position = UDim2.new(0, 2, 0.5, 0)
            SwitchCircle.Size = UDim2.new(0, 14, 0, 14)
            
            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(1, 0)
            CircleCorner.Parent = SwitchCircle
            
            -- Button functionality
            local function toggleCallback()
                Library.Flags[options.flag] = not Library.Flags[options.flag]
                
                pcall(options.callback, Library.Flags[options.flag])
                
                -- Switch visual state
                if Library.Flags[options.flag] then
                    TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
                        BackgroundColor3 = Library.blackbloom and Color3.fromRGB(66, 135, 245) or Color3.fromRGB(30, 180, 255)
                    }):Play()
                    
                    TweenService:Create(SwitchCircle, TweenInfo.new(0.2), {
                        Position = UDim2.new(0, 20, 0.5, 0)
                    }):Play()
                else
                    TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(46, 47, 52)
                    }):Play()
                    
                    TweenService:Create(SwitchCircle, TweenInfo.new(0.2), {
                        Position = UDim2.new(0, 2, 0.5, 0)
                    }):Play()
                end
                
                -- Save flags
                Library:save_flags()
            end
            
            Toggle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    toggleCallback()
                end
            end)
            
            -- Set default state
            if options.default then
                TweenService:Create(ToggleSwitch, TweenInfo.new(0), {
                    BackgroundColor3 = Library.blackbloom and Color3.fromRGB(66, 135, 245) or Color3.fromRGB(30, 180, 255)
                }):Play()
                
                TweenService:Create(SwitchCircle, TweenInfo.new(0), {
                    Position = UDim2.new(0, 20, 0.5, 0)
                }):Play()
            end
            
            -- Create return object
            local toggleObject = {}
            
            function toggleObject:SetValue(value)
                if Library.Flags[options.flag] == value then return end
                
                Library.Flags[options.flag] = value
                
                if value then
                    TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
                        BackgroundColor3 = Library.blackbloom and Color3.fromRGB(66, 135, 245) or Color3.fromRGB(30, 180, 255)
                    }):Play()
                    
                    TweenService:Create(SwitchCircle, TweenInfo.new(0.2), {
                        Position = UDim2.new(0, 20, 0.5, 0)
                    }):Play()
                else
                    TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(46, 47, 52)
                    }):Play()
                    
                    TweenService:Create(SwitchCircle, TweenInfo.new(0.2), {
                        Position = UDim2.new(0, 2, 0.5, 0)
                    }):Play()
                end
                
                pcall(options.callback, value)
                Library:save_flags()
            end
            
            function toggleObject:GetValue()
                return Library.Flags[options.flag]
            end
            
            return toggleObject
        end
        
        -- Add slider to section
        function sectionObject:AddSlider(options)
            options = options or {}
            options.text = options.text or "Slider"
            options.flag = options.flag or options.text:gsub("%s+", "").."Slider"
            options.min = options.min or 0
            options.max = options.max or 100
            options.default = options.default or options.min
            options.increment = options.increment or 1
            options.callback = options.callback or function() end
            
            -- Set default flag value
            Library.Flags[options.flag] = options.default
            
            local Slider = Instance.new("Frame")
            Slider.Name = options.text.."Slider"
            Slider.Parent = ContentFrame
            Slider.BackgroundColor3 = Color3.fromRGB(36, 37, 42)
            Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Slider.BorderSizePixel = 0
            Slider.Size = UDim2.new(0, 440, 0, 50)
            
            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 6)
            SliderCorner.Parent = Slider
            
            local SliderTitle = Instance.new("TextLabel")
            SliderTitle.Name = "Title"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SliderTitle.BorderSizePixel = 0
            SliderTitle.Position = UDim2.new(0.03, 0, 0, 0)
            SliderTitle.Size = UDim2.new(0, 350, 0, 36)
            SliderTitle.Font = Enum.Font.GothamMedium
            SliderTitle.Text = options.text
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local SliderValue = Instance.new("TextLabel")
            SliderValue.Name = "Value"
            SliderValue.Parent = Slider
            SliderValue.AnchorPoint = Vector2.new(1, 0)
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SliderValue.BorderSizePixel = 0
            SliderValue.Position = UDim2.new(0.98, 0, 0, 0)
            SliderValue.Size = UDim2.new(0, 60, 0, 36)
            SliderValue.Font = Enum.Font.GothamMedium
            SliderValue.Text = tostring(options.default)
            SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.TextSize = 14.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right
            
            local SliderBar = Instance.new("Frame")
            SliderBar.Name = "Bar"
            SliderBar.Parent = Slider
            SliderBar.AnchorPoint = Vector2.new(0.5, 0)
            SliderBar.BackgroundColor3 = Color3.fromRGB(46, 47, 52)
            SliderBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SliderBar.BorderSizePixel = 0
            SliderBar.Position = UDim2.new(0.5, 0, 0, 36)
            SliderBar.Size = UDim2.new(0, 420, 0, 8)
            
            local BarCorner = Instance.new("UICorner")
            BarCorner.CornerRadius = UDim.new(1, 0)
            BarCorner.Parent = SliderBar
            
            local Progress = Instance.new("Frame")
            Progress.Name = "Progress"
            Progress.Parent = SliderBar
            Progress.BackgroundColor3 = Library.blackbloom and Color3.fromRGB(66, 135, 245) or Color3.fromRGB(30, 180, 255)
            Progress.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Progress.BorderSizePixel = 0
            Progress.Size = UDim2.new(0, 0, 1, 0)
            
            local ProgressCorner = Instance.new("UICorner")
            ProgressCorner.CornerRadius = UDim.new(1, 0)
            ProgressCorner.Parent = Progress
            
            -- Slider handle
            local Handle = Instance.new("TextButton")
            Handle.Name = "Handle"
            Handle.Parent = Progress
            Handle.AnchorPoint = Vector2.new(0, 0.5)
            Handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Handle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Handle.BorderSizePixel = 0
            Handle.Position = UDim2.new(1, -5, 0.5, 0)
            Handle.Size = UDim2.new(0, 10, 0, 10)
            Handle.Font = Enum.Font.SourceSans
            Handle.Text = ""
            Handle.TextColor3 = Color3.fromRGB(0, 0, 0)
            Handle.TextSize = 14.000
            Handle.AutoButtonColor = false
            
            local HandleCorner = Instance.new("UICorner")
            HandleCorner.CornerRadius = UDim.new(1, 0)
            HandleCorner.Parent = Handle
            
            -- Slider functionality
            local function updateSlider(value)
                value = math.clamp(value, options.min, options.max)
                value = math.floor((value - options.min) / options.increment + 0.5) * options.increment + options.min
                value = math.clamp(value, options.min, options.max) -- Double clamp to handle precision issues
                
                -- Update value
                Library.Flags[options.flag] = value
                SliderValue.Text = tostring(value)
                
                -- Update bar
                local percent = (value - options.min) / (options.max - options.min)
                Progress:TweenSize(UDim2.new(percent, 0, 1, 0), "Out", "Quad", 0.1, true)
                
                -- Callback
                pcall(options.callback, value)
                
                -- Save flags
                Library:save_flags()
            end
            
            local dragging = false
            
            Handle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local mousePos = UserInputService:GetMouseLocation()
                    local relativeX = mousePos.X - SliderBar.AbsolutePosition.X
                    local percent = math.clamp(relativeX / SliderBar.AbsoluteSize.X, 0, 1)
                    local value = options.min + (options.max - options.min) * percent
                    updateSlider(value)
                end
            end)
            
            SliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local mousePos = UserInputService:GetMouseLocation()
                    local relativeX = mousePos.X - SliderBar.AbsolutePosition.X
                    local percent = math.clamp(relativeX / SliderBar.AbsoluteSize.X, 0, 1)
                    local value = options.min + (options.max - options.min) * percent
                    updateSlider(value)
                    dragging = true
                end
            end)
            
            -- Set default value
            updateSlider(options.default)
            
            -- Create return object
            local sliderObject = {}
            
            function sliderObject:SetValue(value)
                updateSlider(value)
            end
            
            function sliderObject:GetValue()
                return Library.Flags[options.flag]
            end
            
            return sliderObject
        end
        
        -- Add dropdown to section
        function sectionObject:AddDropdown(options)
            options = options or {}
            options.text = options.text or "Dropdown"
            options.flag = options.flag or options.text:gsub("%s+", "").."Dropdown"
            options.values = options.values or {}
            options.default = options.default or (options.values[1] or "")
            options.callback = options.callback or function() end
            
            -- Set default flag value
            Library.Flags[options.flag] = options.default
            
            local Dropdown = Instance.new("Frame")
            Dropdown.Name = options.text.."Dropdown"
            Dropdown.Parent = ContentFrame
            Dropdown.BackgroundColor3 = Color3.fromRGB(36, 37, 42)
            Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Dropdown.BorderSizePixel = 0
            Dropdown.ClipsDescendants = true
            Dropdown.Size = UDim2.new(0, 440, 0, 36) -- Will expand when opened
            
            local DropdownCorner = Instance.new("UICorner")
            DropdownCorner.CornerRadius = UDim.new(0, 6)
            DropdownCorner.Parent = Dropdown
            
            local DropdownTitle = Instance.new("TextLabel")
            DropdownTitle.Name = "Title"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            DropdownTitle.BorderSizePixel = 0
            DropdownTitle.Position = UDim2.new(0.03, 0, 0, 0)
            DropdownTitle.Size = UDim2.new(0, 350, 0, 36)
            DropdownTitle.Font = Enum.Font.GothamMedium
            DropdownTitle.Text = options.text
            DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.TextSize = 14.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local SelectedValue = Instance.new("TextLabel")
            SelectedValue.Name = "Selected"
            SelectedValue.Parent = Dropdown
            SelectedValue.AnchorPoint = Vector2.new(1, 0)
            SelectedValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SelectedValue.BackgroundTransparency = 1.000
            SelectedValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SelectedValue.BorderSizePixel = 0
            SelectedValue.Position = UDim2.new(0.95, 0, 0, 0)
            SelectedValue.Size = UDim2.new(0, 180, 0, 36)
            SelectedValue.Font = Enum.Font.GothamMedium
            SelectedValue.Text = options.default
            SelectedValue.TextColor3 = Color3.fromRGB(180, 180, 180)
            SelectedValue.TextSize = 14.000
            SelectedValue.TextXAlignment = Enum.TextXAlignment.Right
            
            local DropdownArrow = Instance.new("ImageLabel")
            DropdownArrow.Name = "Arrow"
            DropdownArrow.Parent = Dropdown
            DropdownArrow.AnchorPoint = Vector2.new(1, 0.5)
            DropdownArrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownArrow.BackgroundTransparency = 1.000
            DropdownArrow.BorderColor3 = Color3.fromRGB(0, 0, 0)
            DropdownArrow.BorderSizePixel = 0
            DropdownArrow.Position = UDim2.new(0.98, 0, 0, 18)
            DropdownArrow.Size = UDim2.new(0, 16, 0, 16)
            DropdownArrow.Image = "rbxassetid://7743878857" -- Dropdown arrow
            DropdownArrow.ImageColor3 = Color3.fromRGB(180, 180, 180)
            DropdownArrow.Rotation = 0
            
            local OptionsFrame = Instance.new("Frame")
            OptionsFrame.Name = "Options"
            OptionsFrame.Parent = Dropdown
            OptionsFrame.BackgroundColor3 = Color3.fromRGB(46, 47, 52)
            OptionsFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            OptionsFrame.BorderSizePixel = 0
            OptionsFrame.Position = UDim2.new(0, 5, 0, 40)
            OptionsFrame.Size = UDim2.new(0, 430, 0, 0) -- Will expand with options
            
            local OptionsCorner = Instance.new("UICorner")
            OptionsCorner.CornerRadius = UDim.new(0, 6)
            OptionsCorner.Parent = OptionsFrame
            
            local OptionsList = Instance.new("UIListLayout")
            OptionsList.Parent = OptionsFrame
            OptionsList.SortOrder = Enum.SortOrder.LayoutOrder
            OptionsList.Padding = UDim.new(0, 5)
            
            local OptionsPadding = Instance.new("UIPadding")
            OptionsPadding.Parent = OptionsFrame
            OptionsPadding.PaddingTop = UDim.new(0, 5)
            OptionsPadding.PaddingBottom = UDim.new(0, 5)
            
            -- Dropdown functionality
            local open = false
            
            local function toggleDropdown()
                open = not open
                
                if open then
                    -- Calculate frame size based on options
                    local optionsHeight = math.min(150, #options.values * 30 + 10) -- Max height of 150px
                    
                    -- Open the dropdown
                    TweenService:Create(Dropdown, TweenInfo.new(0.3), {
                        Size = UDim2.new(0, 440, 0, 36 + optionsHeight + 10)
                    }):Play()
                    
                    TweenService:Create(OptionsFrame, TweenInfo.new(0.3), {
                        Size = UDim2.new(0, 430, 0, optionsHeight)
                    }):Play()
                    
                    TweenService:Create(DropdownArrow, TweenInfo.new(0.3), {
                        Rotation = 180
                    }):Play()
                else
                    -- Close the dropdown
                    TweenService:Create(Dropdown, TweenInfo.new(0.3), {
                        Size = UDim2.new(0, 440, 0, 36)
                    }):Play()
                    
                    TweenService:Create(OptionsFrame, TweenInfo.new(0.3), {
                        Size = UDim2.new(0, 430, 0, 0)
                    }):Play()
                    
                    TweenService:Create(DropdownArrow, TweenInfo.new(0.3), {
                        Rotation = 0
                    }):Play()
                end
            end
            
            Dropdown.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    toggleDropdown()
                end
            end)
            
            -- Create option buttons
            local function createOptions()
                -- Clear existing options
                for _, child in pairs(OptionsFrame:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                
                -- Add new options
                for i, value in ipairs(options.values) do
                    local Option = Instance.new("TextButton")
                    Option.Name = "Option_"..i
                    Option.Parent = OptionsFrame
                    Option.BackgroundColor3 = Color3.fromRGB(46, 47, 52)
                    Option.BackgroundTransparency = 0.000
                    Option.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Option.BorderSizePixel = 0
                    Option.Size = UDim2.new(0, 430, 0, 30)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.GothamMedium
                    Option.Text = tostring(value)
                    Option.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Option.TextSize = 14.000
                    
                    -- Option hover effect
                    Option.MouseEnter:Connect(function()
                        TweenService:Create(Option, TweenInfo.new(0.2), {
                            BackgroundColor3 = Library.blackbloom and Color3.fromRGB(40, 50, 70) or Color3.fromRGB(40, 70, 100)
                        }):Play()
                    end)
                    
                    Option.MouseLeave:Connect(function()
                        TweenService:Create(Option, TweenInfo.new(0.2), {
                            BackgroundColor3 = Color3.fromRGB(46, 47, 52)
                        }):Play()
                    end)
                    
                    -- Option selection
                    Option.MouseButton1Click:Connect(function()
                        Library.Flags[options.flag] = value
                        SelectedValue.Text = tostring(value)
                        toggleDropdown()
                        pcall(options.callback, value)
                        Library:save_flags()
                    end)
                end
            end
            
            -- Create initial options
            createOptions()
            
            -- Create return object
            local dropdownObject = {}
            
            function dropdownObject:SetValue(value)
                if table.find(options.values, value) then
                    Library.Flags[options.flag] = value
                    SelectedValue.Text = tostring(value)
                    pcall(options.callback, value)
                    Library:save_flags()
                end
            end
            
            function dropdownObject:GetValue()
                return Library.Flags[options.flag]
            end
            
            function dropdownObject:SetValues(newValues)
                options.values = newValues
                createOptions()
                
                -- Reset selected value if it's not in the new values
                if not table.find(newValues, Library.Flags[options.flag]) and #newValues > 0 then
                    self:SetValue(newValues[1])
                end
            end
            
            return dropdownObject
        end
        
        -- Add colorpicker to section
        function sectionObject:AddColorPicker(options)
            options = options or {}
            options.text = options.text or "ColorPicker"
            options.flag = options.flag or options.text:gsub("%s+", "").."ColorPicker"
            options.default = options.default or Color3.fromRGB(255, 255, 255)
            options.callback = options.callback or function() end
            
            -- Set default flag value
            Library.Flags[options.flag] = options.default
            
            local ColorPicker = Instance.new("Frame")
            ColorPicker.Name = options.text.."ColorPicker"
            ColorPicker.Parent = ContentFrame
            ColorPicker.BackgroundColor3 = Color3.fromRGB(36, 37, 42)
            ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ColorPicker.BorderSizePixel = 0
            ColorPicker.Size = UDim2.new(0, 440, 0, 36)
            
            local ColorPickerCorner = Instance.new("UICorner")
            ColorPickerCorner.CornerRadius = UDim.new(0, 6)
            ColorPickerCorner.Parent = ColorPicker
            
            local ColorPickerTitle = Instance.new("TextLabel")
            ColorPickerTitle.Name = "Title"
            ColorPickerTitle.Parent = ColorPicker
            ColorPickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorPickerTitle.BackgroundTransparency = 1.000
            ColorPickerTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ColorPickerTitle.BorderSizePixel = 0
            ColorPickerTitle.Position = UDim2.new(0.03, 0, 0, 0)
            ColorPickerTitle.Size = UDim2.new(0, 350, 0, 36)
            ColorPickerTitle.Font = Enum.Font.GothamMedium
            ColorPickerTitle.Text = options.text
            ColorPickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ColorPickerTitle.TextSize = 14.000
            ColorPickerTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local ColorDisplay = Instance.new("Frame")
            ColorDisplay.Name = "Display"
            ColorDisplay.Parent = ColorPicker
            ColorDisplay.AnchorPoint = Vector2.new(1, 0.5)
            ColorDisplay.BackgroundColor3 = options.default
            ColorDisplay.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ColorDisplay.BorderSizePixel = 0
            ColorDisplay.Position = UDim2.new(0.97, 0, 0.5, 0)
            ColorDisplay.Size = UDim2.new(0, 30, 0, 30)
            
            local DisplayCorner = Instance.new("UICorner")
            DisplayCorner.CornerRadius = UDim.new(0, 6)
            DisplayCorner.Parent = ColorDisplay
            
            local DisplayValue = Instance.new("TextLabel")
            DisplayValue.Name = "Value"
            DisplayValue.Parent = ColorPicker
            DisplayValue.AnchorPoint = Vector2.new(1, 0.5)
            DisplayValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DisplayValue.BackgroundTransparency = 1.000
            DisplayValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
            DisplayValue.BorderSizePixel = 0
            DisplayValue.Position = UDim2.new(0.87, 0, 0.5, 0)
            DisplayValue.Size = UDim2.new(0, 100, 0, 36)
            DisplayValue.Font = Enum.Font.Code
            DisplayValue.TextColor3 = Color3.fromRGB(180, 180, 180)
            DisplayValue.TextSize = 14.000
            DisplayValue.TextXAlignment = Enum.TextXAlignment.Right
            
            -- Format color value text
            local function formatRGB(color)
                return string.format("%d, %d, %d", 
                    math.floor(color.R * 255 + 0.5),
                    math.floor(color.G * 255 + 0.5),
                    math.floor(color.B * 255 + 0.5)
                )
            end
            
            DisplayValue.Text = formatRGB(options.default)
            
            -- Click event
            ColorPicker.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    -- In a real implementation, this would open a color picker UI
                    -- For this example, we'll just cycle through some colors
                    local colors = {
                        Color3.fromRGB(255, 0, 0),   -- Red
                        Color3.fromRGB(0, 255, 0),   -- Green
                        Color3.fromRGB(0, 0, 255),   -- Blue
                        Color3.fromRGB(255, 255, 0), -- Yellow
                        Color3.fromRGB(0, 255, 255), -- Cyan
                        Color3.fromRGB(255, 0, 255), -- Magenta
                        Color3.fromRGB(255, 255, 255) -- White
                    }
                    
                    local currentColor = Library.Flags[options.flag]
                    local closestIndex = 1
                    local closestDist = math.huge
                    
                    -- Find the closest color in our list to the current color
                    for i, color in ipairs(colors) do
                        local dist = (color.R - currentColor.R)^2 + 
                                     (color.G - currentColor.G)^2 + 
                                     (color.B - currentColor.B)^2
                        if dist < closestDist then
                            closestDist = dist
                            closestIndex = i
                        end
                    end
                    
                    -- Get the next color in the list
                    local nextIndex = closestIndex % #colors + 1
                    local newColor = colors[nextIndex]
                    
                    -- Update display
                    ColorDisplay.BackgroundColor3 = newColor
                    DisplayValue.Text = formatRGB(newColor)
                    
                    -- Update value
                    Library.Flags[options.flag] = newColor
                    pcall(options.callback, newColor)
                    Library:save_flags()
                end
            end)
            
            -- Create return object
            local colorPickerObject = {}
            
            function colorPickerObject:SetValue(color)
                if typeof(color) ~= "Color3" then return end
                
                ColorDisplay.BackgroundColor3 = color
                DisplayValue.Text = formatRGB(color)
                
                Library.Flags[options.flag] = color
                pcall(options.callback, color)
                Library:save_flags()
            end
            
            function colorPickerObject:GetValue()
                return Library.Flags[options.flag]
            end
            
            return colorPickerObject
        end
        
        -- Add paragraph to section
        function sectionObject:AddParagraph(headerText, contentText)
            local Paragraph = Instance.new("Frame")
            Paragraph.Name = "Paragraph"
            Paragraph.Parent = ContentFrame
            Paragraph.BackgroundColor3 = Color3.fromRGB(36, 37, 42)
            Paragraph.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Paragraph.BorderSizePixel = 0
            Paragraph.Size = UDim2.new(0, 440, 0, 60) -- Will auto-adjust
            
            local ParagraphCorner = Instance.new("UICorner")
            ParagraphCorner.CornerRadius = UDim.new(0, 6)
            ParagraphCorner.Parent = Paragraph
            
            local Header = Instance.new("TextLabel")
            Header.Name = "Header"
            Header.Parent = Paragraph
            Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Header.BackgroundTransparency = 1.000
            Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Header.BorderSizePixel = 0
            Header.Position = UDim2.new(0.03, 0, 0, 8)
            Header.Size = UDim2.new(0, 420, 0, 20)
            Header.Font = Enum.Font.GothamBold
            Header.Text = headerText or "Header"
            Header.TextColor3 = Color3.fromRGB(255, 255, 255)
            Header.TextSize = 14.000
            Header.TextXAlignment = Enum.TextXAlignment.Left
            
            local Content = Instance.new("TextLabel")
            Content.Name = "Content"
            Content.Parent = Paragraph
            Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Content.BackgroundTransparency = 1.000
            Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Content.BorderSizePixel = 0
            Content.Position = UDim2.new(0.03, 0, 0, 30)
            Content.Size = UDim2.new(0, 420, 0, 20)
            Content.Font = Enum.Font.Gotham
            Content.Text = contentText or "Content text goes here"
            Content.TextColor3 = Color3.fromRGB(180, 180, 180)
            Content.TextSize = 14.000
            Content.TextWrapped = true
            Content.TextXAlignment = Enum.TextXAlignment.Left
            Content.TextYAlignment = Enum.TextYAlignment.Top
            Content.AutomaticSize = Enum.AutomaticSize.Y
            
            -- Auto-size the paragraph based on content
            Content:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                Paragraph.Size = UDim2.new(0, 440, 0, Content.Position.Y.Offset + Content.AbsoluteSize.Y + 10)
            end)
            
            local paragraphObject = {}
            
            -- Method to update paragraph text
            function paragraphObject:UpdateText(newHeader, newContent)
                if newHeader then
                    Header.Text = newHeader
                end
                
                if newContent then
                    Content.Text = newContent
                end
            end
            
            return paragraphObject
        end
        
        return sectionObject
    end
    
    return tabObject
end

-- Key bind functionality
function Library:SetKeyBindToToggle(key)
    key = key or Enum.KeyCode.RightControl
    
    local keyConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == key then
            self:toggle()
        end
    end)
    
    table.insert(self.connections, keyConnection)
end

return Library
