--====================================================
-- G2L UI (NGUYÊN BẢN – KHÔNG SỬA)
--====================================================
local G2L = {}

-- ScreenGui
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
G2L["1"].Name = "UIBYMINH"
G2L["1"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main
G2L["2"] = Instance.new("Frame", G2L["1"])
G2L["2"].Name = "Main"
G2L["2"].Size = UDim2.new(0,553,0,320)
G2L["2"].Position = UDim2.new(0.215,0,0.22,0)
G2L["2"].BorderSizePixel = 0

Instance.new("UICorner", G2L["2"]).CornerRadius = UDim.new(0,15)
Instance.new("UIGradient", G2L["2"]).Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(26,26,26)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(130,131,144))
}

-- Topbar
G2L["5"] = Instance.new("Frame", G2L["2"])
G2L["5"].Name = "topbar"
G2L["5"].Size = UDim2.new(0,513,0,34)
G2L["5"].Position = UDim2.new(0.036,0,0.034,0)
G2L["5"].BorderSizePixel = 0
Instance.new("UICorner", G2L["5"]).CornerRadius = UDim.new(0,15)

-- Title
G2L["7"] = Instance.new("TextLabel", G2L["5"])
G2L["7"].Text = "Swift UI"
G2L["7"].BackgroundTransparency = 1
G2L["7"].FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json")
G2L["7"].TextSize = 18
G2L["7"].Size = UDim2.new(0,186,0,32)

-- Close
G2L["8"] = Instance.new("TextButton", G2L["5"])
G2L["8"].Name = "close"
G2L["8"].Text = "X"
G2L["8"].Size = UDim2.new(0,42,0,21)
G2L["8"].Position = UDim2.new(0.895,0,0.176,0)
G2L["8"].BorderSizePixel = 0
Instance.new("UICorner", G2L["8"])

-- Tab buttons
G2L["c"] = Instance.new("Frame", G2L["2"])
G2L["c"].Name = "TabButtons"
G2L["c"].Size = UDim2.new(0,155,0,249)
G2L["c"].Position = UDim2.new(0.036,0,0.196,0)
G2L["c"].BorderSizePixel = 0
Instance.new("UICorner", G2L["c"]).CornerRadius = UDim.new(0,10)

-- Tab Scroll
G2L["e"] = Instance.new("ScrollingFrame", G2L["c"])
G2L["e"].Name = "tabscroll"
G2L["e"].Size = UDim2.new(1,0,1,0)
G2L["e"].AutomaticCanvasSize = Enum.AutomaticSize.Y
G2L["e"].CanvasSize = UDim2.new()
G2L["e"].ScrollBarThickness = 5
G2L["e"].BackgroundTransparency = 1

local tabLayout = Instance.new("UIListLayout", G2L["e"])
tabLayout.Padding = UDim.new(0,10)

--====================================================
-- CONTENT HOLDER (GIỮ STYLE)
--====================================================
local Pages = Instance.new("Frame", G2L["2"])
Pages.Name = "Pages"
Pages.Size = UDim2.new(0,360,0,249)
Pages.Position = UDim2.new(0.33,0,0.196,0)
Pages.BackgroundTransparency = 1

--====================================================
-- DRAG UI (KHÔNG ẢNH HƯỞNG MÀU)
--====================================================
do
    local UIS = game:GetService("UserInputService")
    local drag, startPos, dragStart

    G2L["5"].InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true
            dragStart = i.Position
            startPos = G2L["2"].Position
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = i.Position - dragStart
            G2L["2"].Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = false
        end
    end)
end

--====================================================
-- UI LIBRARY API (KHÔNG ĐỔI UI)
--====================================================
local Library = {}

function Library:CreateTab(name)
    local TabBtn = Instance.new("TextButton", G2L["e"])
    TabBtn.Text = name
    TabBtn.Size = UDim2.new(0,149,0,31)
    TabBtn.BorderSizePixel = 0
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0,10)

    local Page = Instance.new("Frame", Pages)
    Page.Size = UDim2.new(1,0,1,0)
    Page.Visible = false
    Page.BackgroundTransparency = 1

    local layout = Instance.new("UIListLayout", Page)
    layout.Padding = UDim.new(0,10)

    TabBtn.MouseButton1Click:Connect(function()
        for _,v in pairs(Pages:GetChildren()) do
            if v:IsA("Frame") then v.Visible = false end
        end
        Page.Visible = true
    end)

    return {
        Button = function(text, callback)
            local btn = Instance.new("TextButton", Page)
            btn.Text = text
            btn.Size = UDim2.new(1,0,0,36)
            btn.BorderSizePixel = 0
            Instance.new("UICorner", btn)

            btn.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
        end
    }
end

G2L["8"].MouseButton1Click:Connect(function()
    G2L["1"]:Destroy()
end)

return Library
