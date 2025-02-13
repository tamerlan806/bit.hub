local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local fullbrightEnabled = false

local function applyFullbright()
    Lighting.Brightness = 2
    Lighting.ClockTime = 12
    Lighting.FogEnd = 1e10
    Lighting.GlobalShadows = false
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
end

local function resetLighting()
    Lighting.Brightness = 1
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = true
    Lighting.Ambient = Color3.fromRGB(100, 100, 100)
end

local function toggleFullbright()
    fullbrightEnabled = not fullbrightEnabled
    if fullbrightEnabled then
        applyFullbright()
        RunService:BindToRenderStep("Fullbright", Enum.RenderPriority.Camera.Value, applyFullbright)
    else
        RunService:UnbindFromRenderStep("Fullbright")
        resetLighting()
    end
end

toggleFullbright()
