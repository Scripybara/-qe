--// Swift UI Library
--// Converted from UIBYMINH
--// By Minh

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

--==================================================
-- THEME
--==================================================
local Theme = {
    Background = Color3.fromRGB(40, 40, 45),
    Topbar     = Color3.fromRGB(60, 60, 65),
    Accent     = Color3.fromRGB(111, 208, 187),
    Accent2    = Color3.fromRGB(115, 137, 106),
    Text       = Color3.fromRGB(230,230,230),
    Stroke     = Color3.fromRGB(243,246,255),
    CloseRed1  = Color3.fromRGB(255,77,77),
    CloseRed2  = Color3.fromRGB(255,145,145)
}

--==================================================
-- CREATE UI BASE (YOUR UI)
--==================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SwiftUILibrary"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(553,320)
Main.Position = UDim2.fromScale(0.25,0.25)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,15)

local Topbar = Instance.new("Frame", Main)
Topbar.Size = UDim2.new(1,-40,0,36)
Topbar.Position = UDim2.new(0,20,0,12)
Topbar.BackgroundColor3 = Theme.Topbar
Topbar.BorderSizePixel = 0
Instance.new("UICorner", Topbar).CornerRadius = UDim.new(0,15)

local Title = Instance.new("TextLabel", Topbar)
Title.Size = UDim2.new(1,-80,1,0)
Title.BackgroundTransparency = 1
Title.Text = "Swift UI"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Theme.Text

local Close = Instance.new("TextButton", Topbar)
Close.Size = UDim2.fromOffset(42,22)
Close.Position = UDim2.new(1,-50,0.5,-11)
Close.Text = "X"
Close.TextColor3 = Color3.new(0,0,0)
Close.BackgroundColor3 = Theme.CloseRed1
Close.BorderSizePixel = 0
Instance.new("UICorner", Close)

-- Gradient close
local cg = Instance.new("UIGradient", Close)
cg.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0,Theme.CloseRed1),
    ColorSequenceKeypoint.new(1,Theme.CloseRed2)
}

--==================================================
-- DRAG SYSTEM (IMPORTANT)
--==================================================
do
    local dragging, dragStart, startPos
    Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)

    Topbar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

--==================================================
-- TAB SYSTEM
--==================================================
local TabHolder = Instance.new("Frame", Main)
TabHolder.Size = UDim2.fromOffset(155,249)
TabHolder.Position = UDim2.new(0,20,0,60)
TabHolder.BackgroundColor3 = Theme.Background
TabHolder.BorderSizePixel = 0
Instance.new("UICorner", TabHolder).CornerRadius = UDim.new(0,10)

local TabScroll = Instance.new("ScrollingFrame", TabHolder)
TabScroll.Size = UDim2.new(1,0,1,0)
TabScroll.CanvasSize = UDim2.new(0,0,0,0)
TabScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabScroll.ScrollBarThickness = 4
TabScroll.BackgroundTransparency = 1

Instance.new("UIListLayout", TabScroll).Padding = UDim.new(0,10)

local Pages = Instance.new("Frame", Main)
Pages.Size = UDim2.new(1,-200,1,-80)
Pages.Position = UDim2.new(0,185,0,60)
Pages.BackgroundTransparency = 1

--==================================================
-- LIBRARY API
--==================================================
local Library = {}

function Library:CreateTab(name)
    local TabButton = Instance.new("TextButton", TabScroll)
    TabButton.Size = UDim2.fromOffset(145,32)
    TabButton.Text = name
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 14
    TabButton.TextColor3 = Color3.new(0,0,0)
    TabButton.BackgroundColor3 = Theme.Accent
    TabButton.BorderSizePixel = 0
    Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0,10)

    local grad = Instance.new("UIGradient", TabButton)
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0,Theme.Accent),
        ColorSequenceKeypoint.new(1,Theme.Accent2)
    }

    local Page = Instance.new("Frame", Pages)
    Page.Size = UDim2.new(1,0,1,0)
    Page.Visible = false
    Page.BackgroundTransparency = 1

    local layout = Instance.new("UIListLayout", Page)
    layout.Padding = UDim.new(0,10)

    TabButton.MouseButton1Click:Connect(function()
        for _,v in pairs(Pages:GetChildren()) do
            if v:IsA("Frame") then v.Visible = false end
        end
        Page.Visible = true
    end)

    return {
        Button = function(text, callback)
            local B = Instance.new("TextButton", Page)
            B.Size = UDim2.new(1,0,0,36)
            B.Text = text
            B.Font = Enum.Font.Gotham
            B.TextSize = 14
            B.TextColor3 = Theme.Text
            B.BackgroundColor3 = Theme.Topbar
            B.BorderSizePixel = 0
            Instance.new("UICorner", B)

            B.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
        end
    }
end

--==================================================
-- CLOSE
--==================================================
Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

--==================================================
-- RETURN LIBRARY
--==================================================
return Library
