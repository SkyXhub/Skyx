--[[
    SkyX Hybrid UI Library
    
    A custom UI library combining features from Luna, Rayfield, and Valiant UI libraries
    Enhanced for Roblox game exploits with modern appearance and smooth animations
    
    Features:
    - Clean, modern design with gradient themes and smooth animations
    - Configurable theme system with presets
    - Responsive element sizing and positioning
    - Built-in notification system and tooltips
    - Auto-sizing containers and multi-column layout support
    - Drag and drop functionality
    - Mobile-friendly controls
]]

local Library = {}
Library.__index = Library

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- Variables
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera

-- Constants
local TWEEN_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Themes
Library.Themes = {
    Default = {
        Primary = Color3.fromRGB(35, 35, 45),
        Secondary = Color3.fromRGB(45, 45, 55),
        Accent = Color3.fromRGB(65, 165, 230),
        Text = Color3.fromRGB(240, 240, 240),
        StrokeColor = Color3.fromRGB(60, 60, 70),
        ElementBackground = Color3.fromRGB(40, 40, 50),
        ElementBorder = Color3.fromRGB(50, 50, 60),
        InactiveElement = Color3.fromRGB(55, 55, 65),
        
        DarkContrast = Color3.fromRGB(25, 25, 35),
        LightContrast = Color3.fromRGB(50, 50, 65),
        
        Success = Color3.fromRGB(45, 200, 110),
        Warning = Color3.fromRGB(235, 180, 50),
        Error = Color3.fromRGB(215, 70, 70),
        
        Topbar = Color3.fromRGB(30, 30, 40),
        
        TabBackground = Color3.fromRGB(40, 40, 50),
        TabSelected = Color3.fromRGB(55, 55, 70),
        TabTextSelected = Color3.fromRGB(240, 240, 240),
        TabText = Color3.fromRGB(180, 180, 190),
        
        SliderBackground = Color3.fromRGB(40, 40, 50),
        SliderProgress = Color3.fromRGB(65, 165, 230),
        SliderFill = Color3.fromRGB(65, 165, 230),
        
        ToggleBackground = Color3.fromRGB(30, 30, 40),
        ToggleEnabled = Color3.fromRGB(65, 165, 230),
        ToggleDisabled = Color3.fromRGB(60, 60, 70),
        ToggleEnabledStroke = Color3.fromRGB(85, 185, 250),
        
        DropdownBackground = Color3.fromRGB(35, 35, 45),
        DropdownOption = Color3.fromRGB(45, 45, 55),
        DropdownOptionSelected = Color3.fromRGB(55, 55, 70),
        
        InputBackground = Color3.fromRGB(35, 35, 45),
        PlaceholderText = Color3.fromRGB(150, 150, 150),
        
        ButtonBackground = Color3.fromRGB(45, 45, 55),
        ButtonBackgroundHover = Color3.fromRGB(55, 55, 70),
        ButtonBackgroundPress = Color3.fromRGB(35, 35, 45),
        
        SectionBackground = Color3.fromRGB(35, 35, 45),
        
        Gradient = {
            Color1 = Color3.fromRGB(65, 165, 230),
            Color2 = Color3.fromRGB(155, 95, 230)
        }
    },
    
    Ocean = {
        Primary = Color3.fromRGB(20, 30, 40),
        Secondary = Color3.fromRGB(30, 40, 55),
        Accent = Color3.fromRGB(65, 175, 220),
        Text = Color3.fromRGB(230, 240, 245),
        StrokeColor = Color3.fromRGB(40, 55, 70),
        ElementBackground = Color3.fromRGB(25, 35, 50),
        ElementBorder = Color3.fromRGB(35, 50, 65),
        InactiveElement = Color3.fromRGB(35, 45, 60),
        
        DarkContrast = Color3.fromRGB(15, 25, 35),
        LightContrast = Color3.fromRGB(35, 45, 60),
        
        Success = Color3.fromRGB(40, 180, 130),
        Warning = Color3.fromRGB(230, 180, 60),
        Error = Color3.fromRGB(210, 70, 90),
        
        Topbar = Color3.fromRGB(20, 30, 45),
        
        TabBackground = Color3.fromRGB(25, 35, 50),
        TabSelected = Color3.fromRGB(40, 55, 75),
        TabTextSelected = Color3.fromRGB(230, 240, 245),
        TabText = Color3.fromRGB(160, 180, 200),
        
        SliderBackground = Color3.fromRGB(25, 35, 50),
        SliderProgress = Color3.fromRGB(65, 175, 220),
        SliderFill = Color3.fromRGB(65, 175, 220),
        
        ToggleBackground = Color3.fromRGB(20, 30, 45),
        ToggleEnabled = Color3.fromRGB(65, 175, 220),
        ToggleDisabled = Color3.fromRGB(40, 55, 70),
        ToggleEnabledStroke = Color3.fromRGB(85, 195, 240),
        
        DropdownBackground = Color3.fromRGB(25, 35, 50),
        DropdownOption = Color3.fromRGB(30, 40, 55),
        DropdownOptionSelected = Color3.fromRGB(40, 55, 75),
        
        InputBackground = Color3.fromRGB(25, 35, 50),
        PlaceholderText = Color3.fromRGB(140, 160, 180),
        
        ButtonBackground = Color3.fromRGB(30, 40, 55),
        ButtonBackgroundHover = Color3.fromRGB(40, 55, 75),
        ButtonBackgroundPress = Color3.fromRGB(25, 35, 50),
        
        SectionBackground = Color3.fromRGB(25, 35, 50),
        
        Gradient = {
            Color1 = Color3.fromRGB(65, 175, 220),
            Color2 = Color3.fromRGB(90, 140, 220)
        }
    },
    
    Amethyst = {
        Primary = Color3.fromRGB(35, 25, 45),
        Secondary = Color3.fromRGB(45, 35, 60),
        Accent = Color3.fromRGB(140, 85, 230),
        Text = Color3.fromRGB(240, 230, 245),
        StrokeColor = Color3.fromRGB(60, 50, 80),
        ElementBackground = Color3.fromRGB(40, 30, 55),
        ElementBorder = Color3.fromRGB(55, 45, 75),
        InactiveElement = Color3.fromRGB(55, 45, 70),
        
        DarkContrast = Color3.fromRGB(25, 20, 35),
        LightContrast = Color3.fromRGB(50, 40, 70),
        
        Success = Color3.fromRGB(100, 200, 140),
        Warning = Color3.fromRGB(235, 180, 80),
        Error = Color3.fromRGB(210, 80, 100),
        
        Topbar = Color3.fromRGB(30, 25, 45),
        
        TabBackground = Color3.fromRGB(40, 30, 55),
        TabSelected = Color3.fromRGB(60, 50, 80),
        TabTextSelected = Color3.fromRGB(240, 230, 245),
        TabText = Color3.fromRGB(180, 170, 200),
        
        SliderBackground = Color3.fromRGB(40, 30, 55),
        SliderProgress = Color3.fromRGB(140, 85, 230),
        SliderFill = Color3.fromRGB(140, 85, 230),
        
        ToggleBackground = Color3.fromRGB(30, 25, 45),
        ToggleEnabled = Color3.fromRGB(140, 85, 230),
        ToggleDisabled = Color3.fromRGB(60, 50, 80),
        ToggleEnabledStroke = Color3.fromRGB(160, 105, 250),
        
        DropdownBackground = Color3.fromRGB(40, 30, 55),
        DropdownOption = Color3.fromRGB(45, 35, 60),
        DropdownOptionSelected = Color3.fromRGB(60, 50, 80),
        
        InputBackground = Color3.fromRGB(40, 30, 55),
        PlaceholderText = Color3.fromRGB(160, 150, 180),
        
        ButtonBackground = Color3.fromRGB(45, 35, 60),
        ButtonBackgroundHover = Color3.fromRGB(60, 50, 80),
        ButtonBackgroundPress = Color3.fromRGB(40, 30, 55),
        
        SectionBackground = Color3.fromRGB(40, 30, 55),
        
        Gradient = {
            Color1 = Color3.fromRGB(140, 85, 230),
            Color2 = Color3.fromRGB(200, 90, 200)
        }
    },
    
    Emerald = {
        Primary = Color3.fromRGB(25, 40, 35),
        Secondary = Color3.fromRGB(35, 50, 45),
        Accent = Color3.fromRGB(45, 180, 120),
        Text = Color3.fromRGB(230, 240, 235),
        StrokeColor = Color3.fromRGB(45, 65, 55),
        ElementBackground = Color3.fromRGB(30, 45, 40),
        ElementBorder = Color3.fromRGB(40, 60, 50),
        InactiveElement = Color3.fromRGB(40, 55, 50),
        
        DarkContrast = Color3.fromRGB(20, 35, 30),
        LightContrast = Color3.fromRGB(40, 60, 50),
        
        Success = Color3.fromRGB(45, 180, 120),
        Warning = Color3.fromRGB(230, 180, 60),
        Error = Color3.fromRGB(210, 80, 80),
        
        Topbar = Color3.fromRGB(25, 40, 35),
        
        TabBackground = Color3.fromRGB(30, 45, 40),
        TabSelected = Color3.fromRGB(45, 65, 55),
        TabTextSelected = Color3.fromRGB(230, 240, 235),
        TabText = Color3.fromRGB(170, 190, 180),
        
        SliderBackground = Color3.fromRGB(30, 45, 40),
        SliderProgress = Color3.fromRGB(45, 180, 120),
        SliderFill = Color3.fromRGB(45, 180, 120),
        
        ToggleBackground = Color3.fromRGB(25, 40, 35),
        ToggleEnabled = Color3.fromRGB(45, 180, 120),
        ToggleDisabled = Color3.fromRGB(45, 65, 55),
        ToggleEnabledStroke = Color3.fromRGB(65, 200, 140),
        
        DropdownBackground = Color3.fromRGB(30, 45, 40),
        DropdownOption = Color3.fromRGB(35, 50, 45),
        DropdownOptionSelected = Color3.fromRGB(45, 65, 55),
        
        InputBackground = Color3.fromRGB(30, 45, 40),
        PlaceholderText = Color3.fromRGB(150, 170, 160),
        
        ButtonBackground = Color3.fromRGB(35, 50, 45),
        ButtonBackgroundHover = Color3.fromRGB(45, 65, 55),
        ButtonBackgroundPress = Color3.fromRGB(30, 45, 40),
        
        SectionBackground = Color3.fromRGB(30, 45, 40),
        
        Gradient = {
            Color1 = Color3.fromRGB(45, 180, 120),
            Color2 = Color3.fromRGB(45, 170, 90)
        }
    }
}

-- UI Scale Settings
Library.Scale = {
    ButtonHeight = 32,
    ToggleHeight = 32,
    SliderHeight = 40,
    DropdownHeight = 32,
    InputHeight = 32,
    TabHeight = 30,
    SectionSpacing = 8,
    ElementSpacing = 8,
    CornerRadius = 4,
    TextSize = 15,
    Padding = 10,
    Margin = 5
}

-- Fonts
Library.Fonts = {
    Regular = Enum.Font.Gotham,
    SemiBold = Enum.Font.GothamSemibold,
    Bold = Enum.Font.GothamBold,
    Medium = Enum.Font.GothamMedium
}

-- Icons
Library.Icons = {
    Warning = "rbxassetid://9072920609",
    Error = "rbxassetid://9072944922",
    Success = "rbxassetid://9072944817",
    Information = "rbxassetid://9072962894",
    Close = "rbxassetid://10723374589",
    Minimize = "rbxassetid://10723373911",
    Maximize = "rbxassetid://10723373222",
    Circle = "rbxassetid://4560909609",
    Search = "rbxassetid://10723368638",
    Settings = "rbxassetid://10734883356",
    ChevronDown = "rbxassetid://10723348921",
    ChevronUp = "rbxassetid://10723349167",
    ChevronRight = "rbxassetid://10723349013",
    Lock = "rbxassetid://10723345378",
    Globe = "rbxassetid://10723344500",
    Home = "rbxassetid://10723344121",
    Star = "rbxassetid://10723342952",
    Bolt = "rbxassetid://10723128526",
    Fire = "rbxassetid://10723130440",
    Plus = "rbxassetid://10734892874",
    Minus = "rbxassetid://10723126876",
    Check = "rbxassetid://10723127474",
    Heart = "rbxassetid://10734887223",
    Gift = "rbxassetid://10723128171",
    Trash = "rbxassetid://10723126491",
    Target = "rbxassetid://10723127987",
    Map = "rbxassetid://10723126081",
    Pin = "rbxassetid://10723125679",
    Bell = "rbxassetid://10723125057",
    User = "rbxassetid://10723124568",
    Calendar = "rbxassetid://10723123923",
    Clock = "rbxassetid://10723123476",
    Reload = "rbxassetid://10723122908",
    Tools = "rbxassetid://10734896910",
    Wallet = "rbxassetid://10723122278",
    List = "rbxassetid://10723121920"
}

-- Utility Functions
local Utility = {}

function Utility:Create(instanceType, properties, children)
    local instance = Instance.new(instanceType)
    
    for property, value in pairs(properties or {}) do
        instance[property] = value
    end
    
    for _, child in ipairs(children or {}) do
        child.Parent = instance
    end
    
    return instance
end

function Utility:Tween(instance, properties, duration, style, direction)
    local tweenInfo = TweenInfo.new(
        duration or 0.2,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    )
    
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    
    return tween
end

function Utility:Ripple(button, x, y)
    local ripple = Utility:Create("Frame", {
        Name = "Ripple",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.8,
        Position = UDim2.new(0, x, 0, y),
        Size = UDim2.new(0, 0, 0, 0),
        BorderSizePixel = 0,
        Parent = button,
        ZIndex = button.ZIndex + 1
    })
    
    Utility:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = ripple
    })
    
    local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
    
    local tween = Utility:Tween(ripple, {
        Size = UDim2.new(0, size, 0, size),
        BackgroundTransparency = 1
    }, 0.5)
    
    tween.Completed:Connect(function()
        ripple:Destroy()
    end)
    
    return ripple
end

function Utility:DraggingEnabled(frame, parent)
    parent = parent or frame
    
    local dragging = false
    local dragInput, mousePos, framePos
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
        end
    end)
    
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position = UDim2.new(
                framePos.X.Scale, 
                framePos.X.Offset + delta.X, 
                framePos.Y.Scale, 
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

function Utility:ShadowEffect(parent, lightColor, shadowColor, offset)
    offset = offset or 4
    
    local shadow = Utility:Create("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, offset),
        Size = UDim2.new(1, offset * 2, 1, offset * 2),
        ZIndex = parent.ZIndex - 1,
        Image = "rbxassetid://6015897843",
        ImageColor3 = shadowColor or Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.6,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(49, 49, 450, 450),
        Parent = parent
    })
    
    return shadow
end

function Utility:CreateStroke(parent, color, thickness, transparency)
    return Utility:Create("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        Parent = parent
    })
end

function Utility:IsOverElement(element, x, y)
    local pos = element.AbsolutePosition
    local size = element.AbsoluteSize
    
    return (x >= pos.X and x <= pos.X + size.X) and (y >= pos.Y and y <= pos.Y + size.Y)
end

-- Main Library Function
function Library:Init(title, themeName)
    local self = setmetatable({}, Library)
    
    self.Title = title or "SkyX Hub"
    self.ThemeName = themeName or "Default"
    self.Theme = self.Themes[self.ThemeName]
    self.Windows = {}
    self.Tabs = {}
    self.Flags = {}
    self.ActiveTab = nil
    
    -- Create Main GUI
    self:CreateMainGUI()
    
    return self
end

function Library:CreateMainGUI()
    -- Generate random name for the ScreenGui to avoid detection
    local randomString = HttpService:GenerateGUID(false)
    
    -- Create ScreenGui
    self.ScreenGui = Utility:Create("ScreenGui", {
        Name = randomString,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        Parent = (RunService:IsStudio() and Player.PlayerGui) or CoreGui
    })
    
    -- Create main window frame
    self.Main = Utility:Create("Frame", {
        Name = "Main",
        BackgroundColor3 = self.Theme.Primary,
        Position = UDim2.new(0.5, -300, 0.5, -200),
        Size = UDim2.new(0, 600, 0, 400),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = self.ScreenGui
    }, {
        -- Apply corner radius
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, self.Scale.CornerRadius)
        }),
        
        -- Shadow effect
        Utility:Create("ImageLabel", {
            Name = "Shadow",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(1, 30, 1, 30),
            ZIndex = 0,
            Image = "rbxassetid://6015897843",
            ImageColor3 = Color3.fromRGB(0, 0, 0),
            ImageTransparency = 0.6,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(49, 49, 450, 450)
        })
    })
    
    -- Create titlebar
    self.TitleBar = Utility:Create("Frame", {
        Name = "TitleBar",
        BackgroundColor3 = self.Theme.Topbar,
        Size = UDim2.new(1, 0, 0, 32),
        BorderSizePixel = 0,
        Parent = self.Main
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, self.Scale.CornerRadius)
        })
    })
    
    -- Create title text
    self.TitleText = Utility:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(1, -80, 1, 0),
        Font = self.Fonts.SemiBold,
        Text = self.Title,
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.TitleBar
    })
    
    -- Create accent bar
    self.AccentBar = Utility:Create("Frame", {
        Name = "AccentBar",
        BackgroundColor3 = self.Theme.Accent,
        Position = UDim2.new(0, 0, 1, -1),
        Size = UDim2.new(1, 0, 0, 1),
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = self.TitleBar
    })
    
    -- Add gradient to accent bar
    self.AccentGradient = Utility:Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, self.Theme.Gradient.Color1),
            ColorSequenceKeypoint.new(1, self.Theme.Gradient.Color2)
        }),
        Parent = self.AccentBar
    })
    
    -- Create close button
    self.CloseButton = Utility:Create("ImageButton", {
        Name = "CloseButton",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -30, 0, 1),
        Size = UDim2.new(0, 30, 0, 30),
        Image = self.Icons.Close,
        ImageColor3 = self.Theme.Text,
        Parent = self.TitleBar
    })
    
    -- Create minimize button
    self.MinimizeButton = Utility:Create("ImageButton", {
        Name = "MinimizeButton",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -60, 0, 1),
        Size = UDim2.new(0, 30, 0, 30),
        Image = self.Icons.Minimize,
        ImageColor3 = self.Theme.Text,
        Parent = self.TitleBar
    })
    
    -- Create content container
    self.ContentContainer = Utility:Create("Frame", {
        Name = "ContentContainer",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 32),
        Size = UDim2.new(1, 0, 1, -32),
        Parent = self.Main
    })
    
    -- Create tabs container
    self.TabContainer = Utility:Create("Frame", {
        Name = "TabContainer",
        BackgroundColor3 = self.Theme.TabBackground,
        Position = UDim2.new(0, 5, 0, 5),
        Size = UDim2.new(0, 130, 1, -10),
        BorderSizePixel = 0,
        Parent = self.ContentContainer
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, self.Scale.CornerRadius)
        }),
        
        Utility:Create("UIStroke", {
            Color = self.Theme.StrokeColor,
            Thickness = 1,
            Transparency = 0.5
        }),
        
        Utility:Create("ScrollingFrame", {
            Name = "TabScroller",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = self.Theme.Accent,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ClipsDescendants = true
        }, {
            Utility:Create("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, self.Scale.ElementSpacing)
            }),
            
            Utility:Create("UIPadding", {
                PaddingTop = UDim.new(0, self.Scale.Padding),
                PaddingBottom = UDim.new(0, self.Scale.Padding),
                PaddingLeft = UDim.new(0, self.Scale.Padding),
                PaddingRight = UDim.new(0, self.Scale.Padding)
            })
        })
    })
    
    -- Create page container
    self.PageContainer = Utility:Create("Frame", {
        Name = "PageContainer",
        BackgroundColor3 = self.Theme.Secondary,
        Position = UDim2.new(0, 140, 0, 5),
        Size = UDim2.new(1, -145, 1, -10),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = self.ContentContainer
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, self.Scale.CornerRadius)
        }),
        
        Utility:Create("UIStroke", {
            Color = self.Theme.StrokeColor,
            Thickness = 1,
            Transparency = 0.5
        })
    })
    
    -- Enable dragging
    Utility:DraggingEnabled(self.TitleBar, self.Main)
    
    -- Connect close button
    self.CloseButton.MouseButton1Click:Connect(function()
        local tween = Utility:Tween(self.Main, {Size = UDim2.new(0, 600, 0, 0)}, 0.3)
        tween.Completed:Connect(function()
            self.ScreenGui:Destroy()
        end)
    end)
    
    -- Connect minimize button
    local minimized = false
    self.MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        
        if minimized then
            Utility:Tween(self.Main, {Size = UDim2.new(0, 600, 0, 32)}, 0.3)
            Utility:Tween(self.MinimizeButton, {Rotation = 180}, 0.3)
        else
            Utility:Tween(self.Main, {Size = UDim2.new(0, 600, 0, 400)}, 0.3)
            Utility:Tween(self.MinimizeButton, {Rotation = 0}, 0.3)
        end
    end)
    
    -- Make tween when GUI opens
    self.Main.Size = UDim2.new(0, 600, 0, 0)
    Utility:Tween(self.Main, {Size = UDim2.new(0, 600, 0, 400)}, 0.3)
end

function Library:CreateTab(name, icon)
    local tabScroller = self.TabContainer.TabScroller
    
    -- Create tab button
    local tabButton = Utility:Create("TextButton", {
        Name = name .. "Tab",
        BackgroundColor3 = self.Theme.TabBackground,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, self.Scale.TabHeight),
        Text = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent = tabScroller
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, self.Scale.CornerRadius)
        })
    })
    
    -- Create tab icon if provided
    if icon then
        local iconImage = Utility:Create("ImageLabel", {
            Name = "Icon",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 5, 0.5, -8),
            Size = UDim2.new(0, 16, 0, 16),
            Image = (typeof(icon) == "string" and icon:sub(1, 13) == "rbxassetid://") and icon or self.Icons[icon] or self.Icons.List,
            ImageColor3 = self.Theme.TabText,
            Parent = tabButton
        })
    end
    
    -- Create tab text
    local tabText = Utility:Create("TextLabel", {
        Name = "TabText",
        BackgroundTransparency = 1,
        Position = icon and UDim2.new(0, 26, 0, 0) or UDim2.new(0, 10, 0, 0),
        Size = icon and UDim2.new(1, -26, 1, 0) or UDim2.new(1, -10, 1, 0),
        Font = self.Fonts.Regular,
        Text = name,
        TextColor3 = self.Theme.TabText,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = tabButton
    })
    
    -- Create tab selection indicator
    local tabIndicator = Utility:Create("Frame", {
        Name = "TabIndicator",
        BackgroundColor3 = self.Theme.Accent,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 2, 1, 0),
        BorderSizePixel = 0,
        Visible = false,
        Parent = tabButton
    })
    
    -- Create tab page
    local tabPage = Utility:Create("ScrollingFrame", {
        Name = name .. "Page",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = self.Theme.Accent,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
        Parent = self.PageContainer
    }, {
        Utility:Create("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, self.Scale.SectionSpacing)
        }),
        
        Utility:Create("UIPadding", {
            PaddingTop = UDim.new(0, self.Scale.Padding),
            PaddingBottom = UDim.new(0, self.Scale.Padding),
            PaddingLeft = UDim.new(0, self.Scale.Padding),
            PaddingRight = UDim.new(0, self.Scale.Padding)
        })
    })
    
    -- Store tab information
    local tab = {
        Name = name,
        Button = tabButton,
        Icon = icon,
        Page = tabPage,
        Indicator = tabIndicator,
        Sections = {}
    }
    
    table.insert(self.Tabs, tab)
    
    -- Tab click callback
    tabButton.MouseButton1Click:Connect(function()
        self:SelectTab(name)
    end)
    
    -- Hover effect
    tabButton.MouseEnter:Connect(function()
        if self.ActiveTab ~= name then
            Utility:Tween(tabButton, {BackgroundTransparency = 0.9}, 0.2)
        end
    end)
    
    tabButton.MouseLeave:Connect(function()
        if self.ActiveTab ~= name then
            Utility:Tween(tabButton, {BackgroundTransparency = 1}, 0.2)
        end
    end)
    
    -- Select first tab by default
    if #self.Tabs == 1 then
        self:SelectTab(name)
    end
    
    -- Return section functions
    return {
        CreateSection = function(sectionName)
            return self:CreateSection(name, sectionName)
        end
    }
end

function Library:SelectTab(tabName)
    -- Hide all tabs
    for _, tab in ipairs(self.Tabs) do
        if tab.Name ~= tabName then
            tab.Page.Visible = false
            tab.Indicator.Visible = false
            Utility:Tween(tab.Button, {BackgroundTransparency = 1}, 0.2)
            
            -- Reset text color
            if tab.Button:FindFirstChild("TabText") then
                Utility:Tween(tab.Button.TabText, {TextColor3 = self.Theme.TabText}, 0.2)
            end
            
            -- Reset icon color
            if tab.Button:FindFirstChild("Icon") then
                Utility:Tween(tab.Button.Icon, {ImageColor3 = self.Theme.TabText}, 0.2)
            end
        end
    end
    
    -- Find and show selected tab
    for _, tab in ipairs(self.Tabs) do
        if tab.Name == tabName then
            tab.Page.Visible = true
            tab.Indicator.Visible = true
            Utility:Tween(tab.Button, {BackgroundTransparency = 0.8}, 0.2)
            Utility:Tween(tab.Button, {BackgroundColor3 = self.Theme.TabSelected}, 0.2)
            
            -- Change text color
            if tab.Button:FindFirstChild("TabText") then
                Utility:Tween(tab.Button.TabText, {TextColor3 = self.Theme.TabTextSelected}, 0.2)
            end
            
            -- Change icon color
            if tab.Button:FindFirstChild("Icon") then
                Utility:Tween(tab.Button.Icon, {ImageColor3 = self.Theme.TabTextSelected}, 0.2)
            end
            
            self.ActiveTab = tabName
            break
        end
    end
end

function Library:CreateSection(tabName, sectionName)
    -- Find the tab
    local targetTab
    for _, tab in ipairs(self.Tabs) do
        if tab.Name == tabName then
            targetTab = tab
            break
        end
    end
    
    if not targetTab then
        warn("Tab '" .. tabName .. "' not found")
        return
    end
    
    -- Create section frame
    local section = Utility:Create("Frame", {
        Name = sectionName .. "Section",
        BackgroundColor3 = self.Theme.SectionBackground,
        Size = UDim2.new(1, 0, 0, 32), -- Initial size, will auto-adjust
        AutomaticSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        Parent = targetTab.Page
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, self.Scale.CornerRadius)
        }),
        
        Utility:Create("UIStroke", {
            Color = self.Theme.StrokeColor,
            Thickness = 1,
            Transparency = 0.5
        })
    })
    
    -- Create section header
    local sectionHeader = Utility:Create("Frame", {
        Name = "Header",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 30),
        BorderSizePixel = 0,
        Parent = section
    })
    
    -- Create section title
    local sectionTitle = Utility:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(1, -20, 1, 0),
        Font = self.Fonts.SemiBold,
        Text = sectionName,
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = sectionHeader
    })
    
    -- Create section content
    local sectionContent = Utility:Create("Frame", {
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 30),
        Size = UDim2.new(1, -20, 0, 0), -- Will resize based on content
        AutomaticSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        Parent = section
    }, {
        Utility:Create("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, self.Scale.ElementSpacing)
        }),
        
        Utility:Create("UIPadding", {
            PaddingBottom = UDim.new(0, self.Scale.Padding)
        })
    })
    
    -- Create section object
    local sectionObj = {
        Name = sectionName,
        Section = section,
        Content = sectionContent,
        Tab = targetTab
    }
    
    -- Store section in tab
    table.insert(targetTab.Sections, sectionObj)
    
    -- Return section API
    return {
        AddButton = function(text, callback)
            return self:AddButton(sectionObj, text, callback)
        end,
        AddToggle = function(text, default, callback)
            return self:AddToggle(sectionObj, text, default, callback)
        end,
        AddSlider = function(text, min, max, default, step, callback)
            return self:AddSlider(sectionObj, text, min, max, default, step, callback)
        end,
        AddDropdown = function(text, options, default, callback)
            return self:AddDropdown(sectionObj, text, options, default, callback)
        end,
        AddInput = function(text, placeholder, default, callback)
            return self:AddInput(sectionObj, text, placeholder, default, callback)
        end,
        AddLabel = function(text)
            return self:AddLabel(sectionObj, text)
        end,
        AddDivider = function()
            return self:AddDivider(sectionObj)
        end,
        AddKeyBind = function(text, default, callback) 
            return self:AddKeyBind(sectionObj, text, default, callback)
        end,
        AddColorPicker = function(text, default, callback)
            return self:AddColorPicker(sectionObj, text, default, callback)
        end
    }
end

function Library:AddButton(section, text, callback)
    callback = callback or function() end
    
    -- Create button
    local button = Utility:Create("TextButton", {
        Name = text .. "Button",
        BackgroundColor3 = self.Theme.ButtonBackground,
        Size = UDim2.new(1, 0, 0, self.Scale.ButtonHeight),
        Text = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent = section.Content
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, self.Scale.CornerRadius)
        }),
        
        Utility:Create("UIStroke", {
            Color = self.Theme.StrokeColor,
            Thickness = 1,
            Transparency = 0.5
        })
    })
    
    -- Button text
    local buttonText = Utility:Create("TextLabel", {
        Name = "ButtonText",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(1, -20, 1, 0),
        Font = self.Fonts.Regular,
        Text = text,
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = button
    })
    
    -- Button interaction
    button.MouseEnter:Connect(function()
        Utility:Tween(button, {BackgroundColor3 = self.Theme.ButtonBackgroundHover}, 0.2)
    end)
    
    button.MouseLeave:Connect(function()
        Utility:Tween(button, {BackgroundColor3 = self.Theme.ButtonBackground}, 0.2)
    end)
    
    button.MouseButton1Down:Connect(function()
        Utility:Tween(button, {BackgroundColor3 = self.Theme.ButtonBackgroundPress}, 0.1)
    end)
    
    button.MouseButton1Up:Connect(function()
        Utility:Tween(button, {BackgroundColor3 = self.Theme.ButtonBackgroundHover}, 0.1)
    end)
    
    button.MouseButton1Click:Connect(function()
        local success, result = pcall(callback)
        
        -- Create ripple effect
        local x, y = Mouse.X - button.AbsolutePosition.X, Mouse.Y - button.AbsolutePosition.Y
        Utility:Ripple(button, x, y)
        
        if not success then
            warn("Button callback error: " .. tostring(result))
        end
    end)
    
    return {
        Button = button,
        SetText = function(newText)
            buttonText.Text = newText
        end
    }
end

function Library:AddToggle(section, text, default, callback)
    default = default or false
    callback = callback or function() end
    
    local toggleId = HttpService:GenerateGUID(false)
    self.Flags[toggleId] = default
    
    -- Create toggle container
    local toggleContainer = Utility:Create("Frame", {
        Name = text .. "ToggleContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, self.Scale.ToggleHeight),
        BorderSizePixel = 0,
        Parent = section.Content
    })
    
    -- Create toggle text
    local toggleText = Utility:Create("TextLabel", {
        Name = "ToggleText",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, -50, 1, 0),
        Font = self.Fonts.Regular,
        Text = text,
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = toggleContainer
    })
    
    -- Create toggle background
    local toggleBackground = Utility:Create("Frame", {
        Name = "ToggleBackground",
        BackgroundColor3 = default and self.Theme.ToggleEnabled or self.Theme.ToggleBackground,
        Position = UDim2.new(1, -40, 0.5, -10),
        Size = UDim2.new(0, 40, 0, 20),
        BorderSizePixel = 0,
        Parent = toggleContainer
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(1, 0)
        }),
        
        Utility:Create("UIStroke", {
            Color = default and self.Theme.ToggleEnabledStroke or self.Theme.ToggleDisabled,
            Thickness = 1
        })
    })
    
    -- Create toggle knob
    local toggleKnob = Utility:Create("Frame", {
        Name = "ToggleKnob",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Position = UDim2.new(default and 0.55 or 0.05, 0, 0.5, -8),
        Size = UDim2.new(0, 16, 0, 16),
        BorderSizePixel = 0,
        Parent = toggleBackground
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(1, 0)
        })
    })
    
    -- Create toggle button (invisible for interactions)
    local toggleButton = Utility:Create("TextButton", {
        Name = "ToggleButton",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
        Parent = toggleContainer
    })
    
    -- Toggle state function
    local function updateToggle(value)
        self.Flags[toggleId] = value
        
        Utility:Tween(toggleBackground, {
            BackgroundColor3 = value and self.Theme.ToggleEnabled or self.Theme.ToggleBackground
        }, 0.2)
        
        Utility:Tween(toggleBackground.UIStroke, {
            Color = value and self.Theme.ToggleEnabledStroke or self.Theme.ToggleDisabled
        }, 0.2)
        
        Utility:Tween(toggleKnob, {
            Position = value and UDim2.new(0.55, 0, 0.5, -8) or UDim2.new(0.05, 0, 0.5, -8)
        }, 0.2)
        
        spawn(function()
            callback(value)
        end)
    end
    
    -- Toggle button events
    toggleButton.MouseButton1Click:Connect(function()
        local newValue = not self.Flags[toggleId]
        updateToggle(newValue)
    end)
    
    -- API
    return {
        Toggle = toggleContainer,
        SetValue = function(value)
            updateToggle(value)
        end,
        GetValue = function()
            return self.Flags[toggleId]
        end,
        ToggleId = toggleId
    }
end

function Library:AddSlider(section, text, min, max, default, step, callback)
    min = min or 0
    max = max or 100
    default = default or min
    step = step or 1
    callback = callback or function() end
    
    local sliderId = HttpService:GenerateGUID(false)
    self.Flags[sliderId] = default
    
    -- Clamp default value
    default = math.clamp(default, min, max)
    
    -- Create slider container
    local sliderContainer = Utility:Create("Frame", {
        Name = text .. "SliderContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, self.Scale.SliderHeight + 16),
        BorderSizePixel = 0,
        Parent = section.Content
    })
    
    -- Create slider text
    local sliderText = Utility:Create("TextLabel", {
        Name = "SliderText",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, -70, 0, 16),
        Font = self.Fonts.Regular,
        Text = text,
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = sliderContainer
    })
    
    -- Create value display
    local valueDisplay = Utility:Create("TextLabel", {
        Name = "ValueDisplay",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -70, 0, 0),
        Size = UDim2.new(0, 70, 0, 16),
        Font = self.Fonts.Regular,
        Text = tostring(default),
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = sliderContainer
    })
    
    -- Create slider background
    local sliderBackground = Utility:Create("Frame", {
        Name = "SliderBackground",
        BackgroundColor3 = self.Theme.SliderBackground,
        Position = UDim2.new(0, 0, 0, 24),
        Size = UDim2.new(1, 0, 0, 6),
        BorderSizePixel = 0,
        Parent = sliderContainer
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(1, 0)
        })
    })
    
    -- Create slider fill
    local sliderFill = Utility:Create("Frame", {
        Name = "SliderFill",
        BackgroundColor3 = self.Theme.SliderFill,
        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
        BorderSizePixel = 0,
        Parent = sliderBackground
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(1, 0)
        })
    })
    
    -- Create slider knob
    local sliderKnob = Utility:Create("Frame", {
        Name = "SliderKnob",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8),
        Size = UDim2.new(0, 16, 0, 16),
        BorderSizePixel = 0,
        Parent = sliderBackground
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(1, 0)
        })
    })
    
    -- Slider function
    local isDragging = false
    
    local function updateSlider(value)
        value = math.clamp(value, min, max)
        
        -- Round value to the nearest step
        value = min + (math.floor((value - min) / step + 0.5) * step)
        value = math.clamp(value, min, max) -- Clamp again after rounding
        
        -- Update display
        valueDisplay.Text = tostring(value)
        
        -- Update visual position
        local percent = (value - min) / (max - min)
        Utility:Tween(sliderFill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
        Utility:Tween(sliderKnob, {Position = UDim2.new(percent, -8, 0.5, -8)}, 0.1)
        
        -- Update flag
        self.Flags[sliderId] = value
        
        spawn(function()
            callback(value)
        end)
    end
    
    -- Slider interactions
    local function onSliderPress(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            
            -- Update based on input position
            local percent = math.clamp((input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X, 0, 1)
            local value = min + (max - min) * percent
            updateSlider(value)
        end
    end
    
    local function onSliderDrag(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            -- Update based on input position
            local percent = math.clamp((input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X, 0, 1)
            local value = min + (max - min) * percent
            updateSlider(value)
        end
    end
    
    local function onSliderRelease(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end
    
    -- Connect events
    sliderBackground.InputBegan:Connect(onSliderPress)
    sliderKnob.InputBegan:Connect(onSliderPress)
    UserInputService.InputChanged:Connect(onSliderDrag)
    UserInputService.InputEnded:Connect(onSliderRelease)
    
    -- Initialize slider position
    updateSlider(default)
    
    -- API
    return {
        Slider = sliderContainer,
        SetValue = function(value)
            updateSlider(value)
        end,
        GetValue = function()
            return self.Flags[sliderId]
        end,
        SliderId = sliderId
    }
end

function Library:AddDropdown(section, text, options, default, callback)
    options = options or {}
    default = default or options[1] or ""
    callback = callback or function() end
    
    local dropdownId = HttpService:GenerateGUID(false)
    self.Flags[dropdownId] = default
    
    -- Create dropdown container
    local dropdownContainer = Utility:Create("Frame", {
        Name = text .. "DropdownContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, self.Scale.DropdownHeight),
        AutomaticSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        ClipsDescendants = false,
        Parent = section.Content
    })
    
    -- Create dropdown text
    local dropdownText = Utility:Create("TextLabel", {
        Name = "DropdownText",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 16),
        Font = self.Fonts.Regular,
        Text = text,
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = dropdownContainer
    })
    
    -- Create dropdown button
    local dropdownButton = Utility:Create("TextButton", {
        Name = "DropdownButton",
        BackgroundColor3 = self.Theme.DropdownBackground,
        Position = UDim2.new(0, 0, 0, 20),
        Size = UDim2.new(1, 0, 0, self.Scale.DropdownHeight),
        Text = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent = dropdownContainer
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, self.Scale.CornerRadius)
        }),
        
        Utility:Create("UIStroke", {
            Color = self.Theme.StrokeColor,
            Thickness = 1,
            Transparency = 0.5
        })
    })
    
    -- Create selected value text
    local selectedValue = Utility:Create("TextLabel", {
        Name = "SelectedValue",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(1, -40, 1, 0),
        Font = self.Fonts.Regular,
        Text = default,
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = dropdownButton
    })
    
    -- Create dropdown arrow
    local dropdownArrow = Utility:Create("ImageLabel", {
        Name = "DropdownArrow",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -25, 0.5, -8),
        Size = UDim2.new(0, 16, 0, 16),
        Image = self.Icons.ChevronDown,
        ImageColor3 = self.Theme.Text,
        Parent = dropdownButton
    })
    
    -- Create dropdown list
    local dropdownList = Utility:Create("Frame", {
        Name = "DropdownList",
        BackgroundColor3 = self.Theme.DropdownBackground,
        Position = UDim2.new(0, 0, 1, 5),
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 5,
        ClipsDescendants = true,
        Parent = dropdownButton
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, self.Scale.CornerRadius)
        }),
        
        Utility:Create("UIStroke", {
            Color = self.Theme.StrokeColor,
            Thickness = 1,
            Transparency = 0.5
        }),
        
        Utility:Create("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 2)
        }),
        
        Utility:Create("UIPadding", {
            PaddingTop = UDim.new(0, 2),
            PaddingBottom = UDim.new(0, 2)
        })
    })
    
    -- Create dropdown options
    local dropdownOptions = {}
    
    local function createOption(optionText)
        local option = Utility:Create("TextButton", {
            Name = optionText .. "Option",
            BackgroundColor3 = self.Theme.DropdownOption,
            Size = UDim2.new(1, -4, 0, self.Scale.DropdownHeight - 8),
            Text = "",
            AutoButtonColor = false,
            BorderSizePixel = 0,
            ZIndex = 6,
            Parent = dropdownList
        }, {
            Utility:Create("UICorner", {
                CornerRadius = UDim.new(0, self.Scale.CornerRadius - 2)
            })
        })
        
        local optionLabel = Utility:Create("TextLabel", {
            Name = "OptionLabel",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 10, 0, 0),
            Size = UDim2.new(1, -20, 1, 0),
            Font = self.Fonts.Regular,
            Text = optionText,
            TextColor3 = self.Theme.Text,
            TextSize = self.Scale.TextSize,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 6,
            Parent = option
        })
        
        -- Option hover effect
        option.MouseEnter:Connect(function()
            Utility:Tween(option, {BackgroundColor3 = self.Theme.DropdownOptionSelected}, 0.2)
        end)
        
        option.MouseLeave:Connect(function()
            if selectedValue.Text ~= optionText then
                Utility:Tween(option, {BackgroundColor3 = self.Theme.DropdownOption}, 0.2)
            end
        end)
        
        option.MouseButton1Click:Connect(function()
            selectedValue.Text = optionText
            self.Flags[dropdownId] = optionText
            
            -- Close dropdown
            Utility:Tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
            Utility:Tween(dropdownArrow, {Rotation = 0}, 0.2)
            
            task.delay(0.2, function()
                dropdownList.Visible = false
            end)
            
            -- Highlight selected option
            for _, opt in pairs(dropdownOptions) do
                if opt.Name == optionText .. "Option" then
                    Utility:Tween(opt, {BackgroundColor3 = self.Theme.DropdownOptionSelected}, 0.2)
                else
                    Utility:Tween(opt, {BackgroundColor3 = self.Theme.DropdownOption}, 0.2)
                end
            end
            
            callback(optionText)
        end)
        
        table.insert(dropdownOptions, option)
        return option
    end
    
    -- Add options
    for _, optionText in ipairs(options) do
        createOption(optionText)
    end
    
    -- Set initial selected option
    for _, option in pairs(dropdownOptions) do
        if option.Name == default .. "Option" then
            option.BackgroundColor3 = self.Theme.DropdownOptionSelected
        end
    end
    
    -- Dropdown toggle
    local dropdownOpen = false
    dropdownButton.MouseButton1Click:Connect(function()
        dropdownOpen = not dropdownOpen
        
        if dropdownOpen then
            dropdownList.Visible = true
            Utility:Tween(dropdownList, {
                Size = UDim2.new(1, 0, 0, math.min(#options * (self.Scale.DropdownHeight - 4), 150))
            }, 0.2)
            Utility:Tween(dropdownArrow, {Rotation = 180}, 0.2)
        else
            Utility:Tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
            Utility:Tween(dropdownArrow, {Rotation = 0}, 0.2)
            
            task.delay(0.2, function()
                dropdownList.Visible = false
            end)
        end
    end)
    
    -- Close dropdown when clicking elsewhere
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local mousePos = UserInputService:GetMouseLocation()
            if dropdownOpen and not Utility:IsOverElement(dropdownButton, mousePos.X, mousePos.Y) and not Utility:IsOverElement(dropdownList, mousePos.X, mousePos.Y) then
                dropdownOpen = false
                Utility:Tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
                Utility:Tween(dropdownArrow, {Rotation = 0}, 0.2)
                
                task.delay(0.2, function()
                    dropdownList.Visible = false
                end)
            end
        end
    end)
    
    -- API
    return {
        Dropdown = dropdownContainer,
        SetOptions = function(newOptions)
            -- Clear existing options
            for _, option in pairs(dropdownOptions) do
                option:Destroy()
            end
            dropdownOptions = {}
            
            -- Add new options
            for _, optionText in ipairs(newOptions) do
                createOption(optionText)
            end
            
            -- Reset selected value if needed
            if not table.find(newOptions, selectedValue.Text) and #newOptions > 0 then
                selectedValue.Text = newOptions[1]
                self.Flags[dropdownId] = newOptions[1]
                callback(newOptions[1])
            end
        end,
        SetValue = function(value)
            if table.find(options, value) then
                selectedValue.Text = value
                self.Flags[dropdownId] = value
                
                -- Highlight selected option
                for _, option in pairs(dropdownOptions) do
                    if option.Name == value .. "Option" then
                        option.BackgroundColor3 = self.Theme.DropdownOptionSelected
                    else
                        option.BackgroundColor3 = self.Theme.DropdownOption
                    end
                end
                
                callback(value)
            end
        end,
        GetValue = function()
            return self.Flags[dropdownId]
        end,
        DropdownId = dropdownId
    }
end

function Library:AddInput(section, text, placeholder, default, callback)
    placeholder = placeholder or ""
    default = default or ""
    callback = callback or function() end
    
    local inputId = HttpService:GenerateGUID(false)
    self.Flags[inputId] = default
    
    -- Create input container
    local inputContainer = Utility:Create("Frame", {
        Name = text .. "InputContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, self.Scale.InputHeight + 16),
        BorderSizePixel = 0,
        Parent = section.Content
    })
    
    -- Create input text
    local inputText = Utility:Create("TextLabel", {
        Name = "InputText",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 16),
        Font = self.Fonts.Regular,
        Text = text,
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = inputContainer
    })
    
    -- Create input background
    local inputBackground = Utility:Create("Frame", {
        Name = "InputBackground",
        BackgroundColor3 = self.Theme.InputBackground,
        Position = UDim2.new(0, 0, 0, 20),
        Size = UDim2.new(1, 0, 0, self.Scale.InputHeight),
        BorderSizePixel = 0,
        Parent = inputContainer
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, self.Scale.CornerRadius)
        }),
        
        Utility:Create("UIStroke", {
            Color = self.Theme.StrokeColor,
            Thickness = 1,
            Transparency = 0.5
        })
    })
    
    -- Create input field
    local inputField = Utility:Create("TextBox", {
        Name = "InputField",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(1, -20, 1, 0),
        Font = self.Fonts.Regular,
        Text = default,
        PlaceholderText = placeholder,
        PlaceholderColor3 = self.Theme.PlaceholderText,
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        Parent = inputBackground
    })
    
    -- Input field events
    inputField.Focused:Connect(function()
        Utility:Tween(inputBackground.UIStroke, {Color = self.Theme.Accent}, 0.2)
    end)
    
    inputField.FocusLost:Connect(function(enterPressed)
        Utility:Tween(inputBackground.UIStroke, {Color = self.Theme.StrokeColor}, 0.2)
        
        if enterPressed or not enterPressed then
            self.Flags[inputId] = inputField.Text
            callback(inputField.Text)
        end
    end)
    
    -- API
    return {
        Input = inputContainer,
        SetValue = function(value)
            inputField.Text = value
            self.Flags[inputId] = value
            callback(value)
        end,
        GetValue = function()
            return self.Flags[inputId]
        end,
        InputId = inputId
    }
end

function Library:AddLabel(section, text)
    -- Create label
    local label = Utility:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        Font = self.Fonts.Regular,
        Text = text,
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = section.Content
    })
    
    -- Auto-size based on text content
    label:GetPropertyChangedSignal("TextBounds"):Connect(function()
        label.Size = UDim2.new(1, 0, 0, label.TextBounds.Y)
    end)
    
    -- API
    return {
        Label = label,
        SetText = function(newText)
            label.Text = newText
        end
    }
end

function Library:AddDivider(section)
    -- Create divider
    local divider = Utility:Create("Frame", {
        Name = "Divider",
        BackgroundColor3 = self.Theme.StrokeColor,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1),
        Parent = section.Content
    })
    
    -- API
    return {
        Divider = divider
    }
end

function Library:AddKeyBind(section, text, default, callback)
    default = default or Enum.KeyCode.Unknown
    callback = callback or function() end
    
    local keyBindId = HttpService:GenerateGUID(false)
    self.Flags[keyBindId] = default
    
    -- Create keybind container
    local keyBindContainer = Utility:Create("Frame", {
        Name = text .. "KeyBindContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, self.Scale.ButtonHeight),
        BorderSizePixel = 0,
        Parent = section.Content
    })
    
    -- Create keybind text
    local keyBindText = Utility:Create("TextLabel", {
        Name = "KeyBindText",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0.5, -10, 1, 0),
        Font = self.Fonts.Regular,
        Text = text,
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = keyBindContainer
    })
    
    -- Create keybind button
    local keyBindButton = Utility:Create("TextButton", {
        Name = "KeyBindButton",
        BackgroundColor3 = self.Theme.InputBackground,
        Position = UDim2.new(0.5, 0, 0, 0),
        Size = UDim2.new(0.5, 0, 1, 0),
        Text = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent = keyBindContainer
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, self.Scale.CornerRadius)
        }),
        
        Utility:Create("UIStroke", {
            Color = self.Theme.StrokeColor,
            Thickness = 1,
            Transparency = 0.5
        })
    })
    
    -- Create keybind value text
    local keyBindValue = Utility:Create("TextLabel", {
        Name = "KeyBindValue",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        Font = self.Fonts.Regular,
        Text = default ~= Enum.KeyCode.Unknown and default.Name or "None",
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = keyBindButton
    })
    
    -- Keybind variables
    local waitingForInput = false
    
    -- Keybind button events
    keyBindButton.MouseButton1Click:Connect(function()
        waitingForInput = true
        keyBindValue.Text = "Press a key..."
        Utility:Tween(keyBindButton.UIStroke, {Color = self.Theme.Accent}, 0.2)
    end)
    
    -- Input capture
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if waitingForInput and not gameProcessed then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                waitingForInput = false
                
                if input.KeyCode == Enum.KeyCode.Escape then
                    keyBindValue.Text = "None"
                    self.Flags[keyBindId] = Enum.KeyCode.Unknown
                else
                    keyBindValue.Text = input.KeyCode.Name
                    self.Flags[keyBindId] = input.KeyCode
                    
                    -- Call the callback with the new keybind
                    callback(input.KeyCode)
                end
                
                Utility:Tween(keyBindButton.UIStroke, {Color = self.Theme.StrokeColor}, 0.2)
            end
        elseif not waitingForInput and not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == self.Flags[keyBindId] then
                callback(input.KeyCode)
            end
        end
    end)
    
    -- API
    return {
        KeyBind = keyBindContainer,
        SetKey = function(key)
            if typeof(key) == "EnumItem" and key.EnumType == Enum.KeyCode then
                self.Flags[keyBindId] = key
                keyBindValue.Text = key.Name
                callback(key)
            end
        end,
        GetKey = function()
            return self.Flags[keyBindId]
        end,
        KeyBindId = keyBindId
    }
end

function Library:AddColorPicker(section, text, default, callback)
    default = default or Color3.fromRGB(255, 255, 255)
    callback = callback or function() end
    
    local colorPickerId = HttpService:GenerateGUID(false)
    self.Flags[colorPickerId] = default
    
    -- Create color picker container
    local colorPickerContainer = Utility:Create("Frame", {
        Name = text .. "ColorPickerContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, self.Scale.ButtonHeight),
        BorderSizePixel = 0,
        Parent = section.Content
    })
    
    -- Create color picker text
    local colorPickerText = Utility:Create("TextLabel", {
        Name = "ColorPickerText",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0.5, -10, 1, 0),
        Font = self.Fonts.Regular,
        Text = text,
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = colorPickerContainer
    })
    
    -- Create color display button
    local colorDisplay = Utility:Create("TextButton", {
        Name = "ColorDisplay",
        BackgroundColor3 = default,
        Position = UDim2.new(0.5, 0, 0, 0),
        Size = UDim2.new(0.5, 0, 1, 0),
        Text = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent = colorPickerContainer
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, self.Scale.CornerRadius)
        }),
        
        Utility:Create("UIStroke", {
            Color = self.Theme.StrokeColor,
            Thickness = 1,
            Transparency = 0.5
        })
    })
    
    -- Create color picker popup (will implement later)
    -- For now, this is a simple color cycling system for the example
    
    -- Color display button click handler
    local function cycleColor()
        local h, s, v = Color3.toHSV(self.Flags[colorPickerId])
        h = (h + 0.1) % 1
        local newColor = Color3.fromHSV(h, s, v)
        
        colorDisplay.BackgroundColor3 = newColor
        self.Flags[colorPickerId] = newColor
        
        callback(newColor)
    end
    
    colorDisplay.MouseButton1Click:Connect(cycleColor)
    
    -- API
    return {
        ColorPicker = colorPickerContainer,
        SetColor = function(color)
            if typeof(color) == "Color3" then
                colorDisplay.BackgroundColor3 = color
                self.Flags[colorPickerId] = color
                callback(color)
            end
        end,
        GetColor = function()
            return self.Flags[colorPickerId]
        end,
        ColorPickerId = colorPickerId
    }
end

-- Notification System
function Library:Notify(title, message, duration, notificationType)
    title = title or "Notification"
    message = message or ""
    duration = duration or 5
    notificationType = notificationType or "Information"
    
    -- Notification icons
    local icons = {
        Success = self.Icons.Check,
        Error = self.Icons.Close,
        Warning = self.Icons.Warning,
        Information = self.Icons.Information
    }
    
    -- Notification colors
    local colors = {
        Success = self.Theme.Success,
        Error = self.Theme.Error,
        Warning = self.Theme.Warning,
        Information = self.Theme.Accent
    }
    
    -- Create notification container if it doesn't exist
    if not self.NotificationContainer then
        self.NotificationContainer = Utility:Create("Frame", {
            Name = "NotificationContainer",
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -20, 0, 20),
            Size = UDim2.new(0, 300, 1, -40),
            AnchorPoint = Vector2.new(1, 0),
            ClipsDescendants = false,
            Parent = self.ScreenGui
        }, {
            Utility:Create("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                Padding = UDim.new(0, 10)
            })
        })
    end
    
    -- Create notification frame
    local notification = Utility:Create("Frame", {
        Name = "Notification",
        BackgroundColor3 = self.Theme.Primary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        ClipsDescendants = true,
        Parent = self.NotificationContainer
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, self.Scale.CornerRadius)
        }),
        
        Utility:Create("UIStroke", {
            Color = self.Theme.StrokeColor,
            Thickness = 1,
            Transparency = 0.5
        })
    })
    
    -- Create accent bar
    local accentBar = Utility:Create("Frame", {
        Name = "AccentBar",
        BackgroundColor3 = colors[notificationType],
        BorderSizePixel = 0,
        Size = UDim2.new(0, 4, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Parent = notification
    })
    
    -- Create notification title
    local notificationTitle = Utility:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 40, 0, 10),
        Size = UDim2.new(1, -50, 0, 20),
        Font = self.Fonts.SemiBold,
        Text = title,
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = notification
    })
    
    -- Create notification message
    local notificationMessage = Utility:Create("TextLabel", {
        Name = "Message",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 40, 0, 30),
        Size = UDim2.new(1, -50, 0, 0),
        Font = self.Fonts.Regular,
        Text = message,
        TextColor3 = self.Theme.Text,
        TextSize = self.Scale.TextSize - 1,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = notification
    })
    
    -- Create bottom padding
    local bottomPadding = Utility:Create("Frame", {
        Name = "BottomPadding",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 10),
        LayoutOrder = 999,
        Parent = notification
    })
    
    -- Create notification icon
    local notificationIcon = Utility:Create("ImageLabel", {
        Name = "Icon",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 12),
        Size = UDim2.new(0, 16, 0, 16),
        Image = icons[notificationType],
        ImageColor3 = colors[notificationType],
        Parent = notification
    })
    
    -- Create close button
    local closeButton = Utility:Create("ImageButton", {
        Name = "CloseButton",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -25, 0, 10),
        Size = UDim2.new(0, 16, 0, 16),
        Image = self.Icons.Close,
        ImageColor3 = self.Theme.Text,
        ImageTransparency = 0.5,
        Parent = notification
    })
    
    -- Animation
    notification.Size = UDim2.new(1, 0, 0, 0)
    notification.ClipsDescendants = true
    
    -- Animate in
    Utility:Tween(notification, {
        Size = UDim2.new(1, 0, 0, notificationMessage.TextBounds.Y + 50)
    }, 0.3)
    
    -- Auto-close
    local closing = false
    local function closeNotification()
        if not closing then
            closing = true
            
            Utility:Tween(notification, {
                Position = UDim2.new(1, 300, 0, 0)
            }, 0.5)
            
            task.delay(0.5, function()
                notification:Destroy()
            end)
        end
    end
    
    closeButton.MouseButton1Click:Connect(closeNotification)
    
    task.delay(duration, closeNotification)
    
    -- Hover effects
    closeButton.MouseEnter:Connect(function()
        Utility:Tween(closeButton, {ImageTransparency = 0}, 0.2)
    end)
    
    closeButton.MouseLeave:Connect(function()
        Utility:Tween(closeButton, {ImageTransparency = 0.5}, 0.2)
    end)
    
    notification.MouseEnter:Connect(function()
        Utility:Tween(notification.UIStroke, {Color = self.Theme.Accent}, 0.2)
    end)
    
    notification.MouseLeave:Connect(function()
        Utility:Tween(notification.UIStroke, {Color = self.Theme.StrokeColor}, 0.2)
    end)
    
    return notification
end

-- Return the library
return Library
