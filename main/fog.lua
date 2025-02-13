pcall(function()
    local lighting = game:GetService("Lighting")
    lighting.FogEnd = 1e10
    lighting.Changed:Connect(function()
        lighting.FogEnd = 1e10
    end)
end)
