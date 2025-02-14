local CrosshairSettings = {
    Enabled = true,
    Size = 6, 
    Thickness = 3,
    Color = Color3.fromRGB(184, 47, 180)
}

local CrosshairLines = {}
for i = 1, 4 do
    local line = Drawing.new("Line")
    line.Color = CrosshairSettings.Color
    line.Thickness = CrosshairSettings.Thickness
    line.Transparency = 1
    line.Visible = CrosshairSettings.Enabled
    table.insert(CrosshairLines, line)
end

local function UpdateCrosshair()
    local camera = workspace.CurrentCamera
    local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    local size = CrosshairSettings.Size
    local gap = 2 

    if CrosshairSettings.Enabled then
        CrosshairLines[1].From = Vector2.new(center.X - (size + gap), center.Y)
        CrosshairLines[1].To = Vector2.new(center.X - gap, center.Y)

        CrosshairLines[2].From = Vector2.new(center.X + (size + gap), center.Y)
        CrosshairLines[2].To = Vector2.new(center.X + gap, center.Y)

        CrosshairLines[3].From = Vector2.new(center.X, center.Y - (size + gap))
        CrosshairLines[3].To = Vector2.new(center.X, center.Y - gap)

        CrosshairLines[4].From = Vector2.new(center.X, center.Y + (size + gap))
        CrosshairLines[4].To = Vector2.new(center.X, center.Y + gap)

        for _, line in pairs(CrosshairLines) do
            line.Visible = true
        end
    else
        for _, line in pairs(CrosshairLines) do
            line.Visible = false
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(UpdateCrosshair)
