local Lighting = game:GetService("Lighting")

if Lighting:FindFirstChild("Sky") then
    Lighting:FindFirstChild("Sky"):Destroy()
end

local sky = Instance.new("Sky")
sky.Name = "CustomSky"

sky.SkyboxBk = "rbxassetid://264908339"
sky.SkyboxDn = "rbxassetid://264907909"
sky.SkyboxFt = "rbxassetid://264909420"
sky.SkyboxLf = "rbxassetid://264909758"
sky.SkyboxRt = "rbxassetid://264908886"
sky.SkyboxUp = "rbxassetid://264907379"

sky.Parent = Lighting
