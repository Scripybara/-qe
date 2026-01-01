--==================================================
-- WINDUI STYLE - FULL WORKING UI LIBRARY
-- Made for Executor
--==================================================

local Library = {}
Library.__index = Library

-- Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CREATE WINDOW
--==================================================
function Library:CreateWindow(cfg)
    cfg = cfg or {}

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "WindUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 520, 0, 360)
    Main.Position = UDim2.new(0.5, -260, 0.5, -180)
    Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
    Main.Parent = ScreenGui
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0,14)

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,0,0,42)
    Title.BackgroundTransparency = 1
    Title.Text = cfg.Title or "WindUI"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextColor3 = Color3.fromRGB(0,170,255)
    Title.Parent = Main

    -- Sidebar (Tabs)
    local TabsFrame = Instance.new("Frame")
    TabsFrame.Size = UDim2.new(0,130,1,-42)
    TabsFrame.Position = UDim2.new(0,0,0,42)
    TabsFrame.BackgroundColor3 = Color3.fromRGB(22,22,22)
    TabsFrame.Parent = Main

    local TabsLayout = Instance.new("UIListLayout", TabsFrame)
    TabsLayout.Padding = UDim.new(0,6)

    -- Pages
    local Pages = Instance.new("Frame")
    Pages.Size = UDim2.new(1,-140,1,-52)
    Pages.Position = UDim2.new(0,135,0,47)
    Pages.BackgroundTransparency = 1
    Pages.Parent = Main

    local Window = {}

    --==================================================
    -- CREATE TAB
    --==================================================
    function Window:Tab(tabCfg)
        tabCfg = tabCfg or {}
        local Tab = {}

        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1,-10,0,36)
        TabButton.Text = tabCfg.Title or "Tab"
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 14
        TabButton.TextColor3 = Color3.new(1,1,1)
        TabButton.BackgroundColor3 = Color3.fromRGB(35,35,35)
        TabButton.Parent = TabsFrame
        Instance.new("UICorner", TabButton)

        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1,0,1,0)
        Page.CanvasSize = UDim2.new(0,0,0,0)
        Page.ScrollBarImageTransparency = 1
        Page.Visible = false
        Page.Parent = Pages

        local Layout = Instance.new("UIListLayout", Page)
        Layout.Padding = UDim.new(0,8)

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 10)
        end)

        TabButton.MouseButton1Click:Connect(function()
            for _,v in pairs(Pages:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            Page.Visible = true
        end)

        --==================================================
        -- BUTTON
        --==================================================
        function Tab:Button(cfg)
            cfg = cfg or {}
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1,-10,0,36)
            Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
            Btn.Text = cfg.Title or "Button"
            Btn.Font = Enum.Font.Gotham
            Btn.TextSize = 14
            Btn.TextColor3 = Color3.new(1,1,1)
            Btn.Parent = Page
            Instance.new("UICorner", Btn)

            Btn.MouseButton1Click:Connect(function()
                if cfg.Callback then
                    cfg.Callback()
                end
            end)
        end

        --==================================================
        -- TOGGLE
        --==================================================
        function Tab:Toggle(cfg)
            cfg = cfg or {}
            local state = cfg.Value or false

            local Toggle = Instance.new("TextButton")
            Toggle.Size = UDim2.new(1,-10,0,36)
            Toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
            Toggle.Text = (cfg.Title or "Toggle") .. ": " .. (state and "ON" or "OFF")
            Toggle.Font = Enum.Font.Gotham
            Toggle.TextSize = 14
            Toggle.TextColor3 = Color3.new(1,1,1)
            Toggle.Parent = Page
            Instance.new("UICorner", Toggle)

            Toggle.MouseButton1Click:Connect(function()
                state = not state
                Toggle.Text = cfg.Title .. ": " .. (state and "ON" or "OFF")
                if cfg.Callback then
                    cfg.Callback(state)
                end
            end)
        end

        -- Auto open first tab
        if #Pages:GetChildren() == 1 then
            Page.Visible = true
        end

        return Tab
    end

    return Window
end

return Library
