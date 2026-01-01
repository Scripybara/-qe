--==================================================
-- UIBYMINH - UI LIBRARY (FULL)
--==================================================

local Library = {}

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

--------------------------------------------------
-- CREATE WINDOW
--------------------------------------------------
function Library:CreateWindow(config)
    config = config or {}

    local G2L = {}

    -- ScreenGui
    G2L["1"] = Instance.new("ScreenGui", PlayerGui)
    G2L["1"].Name = "UIBYMINH"
    G2L["1"].ResetOnSpawn = false

    -- Main
    G2L["2"] = Instance.new("Frame", G2L["1"])
    G2L["2"].Size = UDim2.new(0, 553, 0, 320)
    G2L["2"].Position = UDim2.new(0.3, 0, 0.3, 0)
    G2L["2"].BackgroundColor3 = Color3.fromRGB(255,255,255)
    G2L["2"].BorderSizePixel = 0
    Instance.new("UICorner", G2L["2"]).CornerRadius = UDim.new(0,15)

    local gradMain = Instance.new("UIGradient", G2L["2"])
    gradMain.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(26,26,26)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(130,131,144))
    }

    -- Topbar
    G2L["5"] = Instance.new("Frame", G2L["2"])
    G2L["5"].Size = UDim2.new(0,513,0,34)
    G2L["5"].Position = UDim2.new(0.036,0,0.03,0)
    G2L["5"].BorderSizePixel = 0
    Instance.new("UICorner", G2L["5"]).CornerRadius = UDim.new(0,15)

    -- Title
    G2L["7"] = Instance.new("TextLabel", G2L["5"])
    G2L["7"].BackgroundTransparency = 1
    G2L["7"].Size = UDim2.new(0,200,1,0)
    G2L["7"].Text = config.Title or "Swift UI"
    G2L["7"].Font = Enum.Font.GothamBold
    G2L["7"].TextSize = 18
    G2L["7"].TextColor3 = Color3.fromRGB(50,59,60)

    -- Close
    G2L["8"] = Instance.new("TextButton", G2L["5"])
    G2L["8"].Size = UDim2.new(0,42,0,21)
    G2L["8"].Position = UDim2.new(0.9,0,0.2,0)
    G2L["8"].Text = "X"
    Instance.new("UICorner", G2L["8"])

    G2L["8"].MouseButton1Click:Connect(function()
        G2L["1"]:Destroy()
    end)

    -- Tabs frame
    G2L["c"] = Instance.new("Frame", G2L["2"])
    G2L["c"].Size = UDim2.new(0,155,0,249)
    G2L["c"].Position = UDim2.new(0.036,0,0.2,0)
    G2L["c"].BorderSizePixel = 0
    Instance.new("UICorner", G2L["c"]).CornerRadius = UDim.new(0,10)

    -- Tab scroll
    G2L["e"] = Instance.new("ScrollingFrame", G2L["c"])
    G2L["e"].Size = UDim2.new(1,0,1,0)
    G2L["e"].AutomaticCanvasSize = Enum.AutomaticSize.Y
    G2L["e"].CanvasSize = UDim2.new(0,0,0,0)
    G2L["e"].ScrollBarThickness = 5
    G2L["e"].BackgroundTransparency = 1

    local tabLayout = Instance.new("UIListLayout", G2L["e"])
    tabLayout.Padding = UDim.new(0,10)

    --------------------------------------------------
    -- DRAG UI
    --------------------------------------------------
    local dragging, dragStart, startPos

    G2L["5"].InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = G2L["2"].Position
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            G2L["2"].Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    --------------------------------------------------
    -- WINDOW OBJECT
    --------------------------------------------------
    local Window = {}

    function Window:CreateTab(tabName)
        local Tab = {}

        -- Tab Button
        local TabBtn = Instance.new("TextButton", G2L["e"])
        TabBtn.Size = UDim2.new(1,-6,0,31)
        TabBtn.Text = tabName
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.TextSize = 14
        TabBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0,10)

        -- Page
        local Page = Instance.new("ScrollingFrame", G2L["2"])
        Page.Size = UDim2.new(0,340,0,240)
        Page.Position = UDim2.new(0.36,0,0.2,0)
        Page.Visible = false
        Page.ScrollBarImageTransparency = 1
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y

        local layout = Instance.new("UIListLayout", Page)
        layout.Padding = UDim.new(0,8)

        TabBtn.MouseButton1Click:Connect(function()
            for _,v in pairs(G2L["2"]:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            Page.Visible = true
        end)

        --------------------------------------------------
        -- BUTTON
        --------------------------------------------------
        function Tab:Button(cfg)
            local Btn = Instance.new("TextButton", Page)
            Btn.Size = UDim2.new(1,-10,0,36)
            Btn.Text = cfg.Title or "Button"
            Btn.Font = Enum.Font.Gotham
            Btn.TextSize = 14
            Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
            Btn.TextColor3 = Color3.new(1,1,1)
            Instance.new("UICorner", Btn)

            Btn.MouseButton1Click:Connect(function()
                if cfg.Callback then
                    cfg.Callback()
                end
            end)
        end

        return Tab
    end

    return Window
end

return Library
