local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local playerGui = player:FindFirstChildOfClass("PlayerGui")
if not playerGui then
    warn("playergui disable")
    return
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoaderUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local openButton = Instance.new("TextButton", screenGui)
openButton.Size = UDim2.new(0, 100, 0, 30)
openButton.Position = UDim2.new(0.5, -75, 0, -50)
openButton.Text = "bit.hub"
openButton.BackgroundColor3 = Color3.fromRGB(148, 87, 82)
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.Font = Enum.Font.GothamBold
openButton.TextScaled = true
openButton.BorderSizePixel = 0

local openCorner = Instance.new("UICorner", openButton)
openCorner.CornerRadius = UDim.new(0, 5)

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 450, 0, 300)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 10)

local gradient = Instance.new("UIGradient", mainFrame)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 20, 20))
}
gradient.Rotation = 90

local uiElements = {}

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Text = "bit.hub"
titleLabel.BackgroundColor3 = Color3.fromRGB(148, 87, 82)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextScaled = true
titleLabel.BorderSizePixel = 0
table.insert(uiElements, titleLabel)

local titleStroke = Instance.new("UIStroke", titleLabel)
titleStroke.Thickness = 2
titleStroke.Color = Color3.fromRGB(0, 0, 0)

local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 5)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextScaled = true
table.insert(uiElements, closeButton)

local closeCorner = Instance.new("UICorner", closeButton)
closeCorner.CornerRadius = UDim.new(0, 5)

local function loadScript(url)
    local success, err = pcall(function()
        loadstring(game:HttpGet(url, true))()
    end)
    if not success then
        warn("Ошибка загрузки скрипта:", err)
    end
end

local scripts = {
    {name = "fps boost", url = "https://raw.githubusercontent.com/tamerlan806/bit.hub/refs/heads/main/main/fpsboost.lua"},
    {name = "sky", url = "https://raw.githubusercontent.com/tamerlan806/bit.hub/refs/heads/main/main/sky.lua"},
    {name = "fullbright/fog", url = "https://raw.githubusercontent.com/tamerlan806/bit.hub/refs/heads/main/main/fog.lua"},
    {name = "crosshair", url = "https://raw.githubusercontent.com/tamerlan806/bit.hub/refs/heads/main/main/crosshair.lua"}
}

for i, script in ipairs(scripts) do
    local scriptButton = Instance.new("TextButton", mainFrame)
    scriptButton.Size = UDim2.new(0.25, 0, 0, 35)
    scriptButton.Position = UDim2.new(0.7, 0, 0.2 + (i - 1) * 0.2, 0)
    scriptButton.Text = script.name
    scriptButton.BackgroundColor3 = Color3.fromRGB(148, 87, 82)
    scriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    scriptButton.Font = Enum.Font.GothamBold
    scriptButton.TextScaled = true
    table.insert(uiElements, scriptButton)

    local buttonCorner = Instance.new("UICorner", scriptButton)
    buttonCorner.CornerRadius = UDim.new(0, 8)

    scriptButton.MouseButton1Click:Connect(function()
        loadScript(script.url)
    end)
end

local function toggleUI()
    mainFrame.Visible = not mainFrame.Visible
end

closeButton.MouseButton1Click:Connect(toggleUI)
openButton.MouseButton1Click:Connect(toggleUI)

local dragging = false
local dragInput, mousePos, framePos

titleLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = mainFrame.Position
    end
end)

titleLabel.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

titleLabel.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - mousePos
        mainFrame.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)
