setfpscap(900) -- normal fps cap for other executors
setfflag("TaskSchedulerTargetFps", "900") -- for setfpscap unc missing or unsupported for executors

local function removeWater()
    local terrain = workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.WaterTransparency = 1
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0
    end
end

local function removeReflections()
    local lighting = game:GetService("Lighting")
    lighting.EnvironmentSpecularScale = 0
    lighting.EnvironmentDiffuseScale = 0
end

local function reduceGrassDetail()
    local terrain = workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain:SetMaterialColor(Enum.Material.Grass, Color3.fromRGB(34, 139, 34))  -- Set to a less bright green
        terrain:SetMaterialProperty(Enum.Material.Grass, "Transparency", 1)  -- Increase transparency
        terrain:SetMaterialProperty(Enum.Material.Grass, "Reflectance", 0)  -- Remove reflectance
    end
end

local function disableParticleEffects()
    local effects = {"ParticleEmitter", "Smoke", "Fire", "Sparkles"}
    for _, effectType in ipairs(effects) do
        for _, effect in pairs(workspace:GetDescendants()) do
            if effect:IsA(effectType) then
                effect.Enabled = false
            end
        end
    end
end

local function removeExplosions()
    for _, explosion in pairs(workspace:GetDescendants()) do
        if explosion:IsA("Explosion") then
            explosion:Destroy()
        end
    end
end

local function setLowShadows()
    game.Lighting.GlobalShadows = false
end

local function setMediumQuality()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level02  -- Use medium quality for balance
end

local function setLowRenderDistance()
    local camera = game:GetService("Workspace").CurrentCamera
    camera.MaxZoomDistance = 50
    camera.FieldOfView = 70
end

local function setLowGraphics()
    local lighting = game:FindService("Lighting")
    setscriptable(lighting, "Technology", true)
    lighting.Technology = Enum.Technology.Legacy

    for _, light in pairs(workspace:GetDescendants()) do
        if light:IsA("PointLight") or light:IsA("SpotLight") or light:IsA("SurfaceLight") then
            light.Shadows = true
        end
    end
end

local function reduceLag()
    removeWater()
    removeReflections()
    reduceGrassDetail()
    disableParticleEffects()
    removeExplosions()
    setLowShadows()
    setMediumQuality()
    setLowRenderDistance()
    setLowGraphics()
end

reduceLag()

workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("Terrain") then
        removeWater()  -- Efficiently handle water removal
    elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Smoke") or descendant:IsA("Fire") or descendant:IsA("Sparkles") or descendant:IsA("Explosion") then
        reduceLag()  -- Optimize lag reduction
    end
end)
