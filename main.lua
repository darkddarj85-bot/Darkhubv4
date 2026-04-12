--[[
    † THE ULTIMATE BLOODY GOTHIC OVERHAUL †
    BY DARK | ONLY MAIN HUB | NO OLD MENU
]]

local notifyTitle = "OPEN SEA FOR BRAIROTS BY DARK"

-- 1. ОБНОВЛЕННЫЙ ЛОАДЕР С НАДПИСЯМИ ВОКРУГ КРЕСТА
local function SpawnGothicNotify()
    local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 300, 0, 110)
    frame.Position = UDim2.new(1, 0, 0.7, 0) 
    frame.BackgroundColor3 = Color3.new(0,0,0)
    frame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 8)
    
    local line = Instance.new("Frame", frame)
    line.Size = UDim2.new(1, 0, 0, 3)
    line.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    line.BorderSizePixel = 0

    -- ГЛАВНЫЙ КРЕСТ
    local Cross = Instance.new("TextLabel", frame)
    Cross.Size = UDim2.new(0, 60, 0, 60)
    Cross.Position = UDim2.new(0, 15, 0.5, -30)
    Cross.Text = "†"
    Cross.TextColor3 = Color3.fromRGB(255, 0, 0)
    Cross.TextSize = 65
    Cross.BackgroundTransparency = 1
    Cross.Font = Enum.Font.SourceSansBold
    Cross.Parent = frame

    -- ДОПОЛНИТЕЛЬНЫЕ НАДПИСИ У КРЕСТА
    local ritualText = Instance.new("TextLabel", frame)
    ritualText.Size = UDim2.new(0, 100, 0, 20)
    ritualText.Position = UDim2.new(0, -5, 0.7, 0)
    ritualText.Text = "† RITUAL †"
    ritualText.TextColor3 = Color3.fromRGB(150, 0, 0)
    ritualText.TextSize = 12
    ritualText.BackgroundTransparency = 1
    ritualText.Font = Enum.Font.Antique

    -- АНИМАЦИЯ
    task.spawn(function()
        while frame.Parent do
            local t = tick()
            local p = (math.sin(t * 6) * 0.5) + 0.5
            Cross.TextTransparency = 0.3 * p
            ritualText.TextTransparency = p
            line.BackgroundColor3 = Color3.fromRGB(150 + (p * 105), 0, 0)
            task.wait(0.05)
        end
    end)
    
    local t = Instance.new("TextLabel", frame)
    t.Size = UDim2.new(1, -90, 0, 30)
    t.Position = UDim2.new(0, 90, 0, 20)
    t.Text = "† DARK SOULS †"
    t.TextColor3 = Color3.fromRGB(255, 0, 0)
    t.Font = Enum.Font.Antique
    t.TextSize = 20
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.BackgroundTransparency = 1
    
    local desc = Instance.new("TextLabel", frame)
    desc.Size = UDim2.new(1, -90, 0, 40)
    desc.Position = UDim2.new(0, 90, 0, 50)
    desc.Text = "ABSORBING BRAIROTS..."
    desc.TextColor3 = Color3.fromRGB(100, 100, 100)
    desc.Font = Enum.Font.SourceSansItalic
    desc.TextSize = 14
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.BackgroundTransparency = 1
    desc.Parent = frame

    frame:TweenPosition(UDim2.new(1, -320, 0.7, 0), "Out", "Back", 0.6)
    task.delay(5, function() if sg then sg:Destroy() end end)
end

SpawnGothicNotify()

-- 2. ИНЪЕКЦИЯ КРОВИ (ТОЛЬКО В ОСНОВНОЙ ХАБ)
local function BloodInfection(obj)
    if obj:IsA("Frame") or obj:IsA("ScrollingFrame") or obj:IsA("TextButton") then
        obj.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
        if obj:IsA("TextButton") then obj.TextColor3 = Color3.fromRGB(255, 0, 0) end
    elseif obj:IsA("TextLabel") then
        obj.TextColor3 = Color3.fromRGB(255, 0, 0)
        if not obj.Text:find("†") then obj.Text = "† " .. obj.Text .. " †" end
    elseif obj:IsA("UIStroke") then
        obj.Color = Color3.fromRGB(180, 0, 0)
    end
end

game:GetService("CoreGui").DescendantAdded:Connect(function(d)
    task.wait(0.1)
    BloodInfection(d)
end)

-- 3. ЗАПУСК ГЛАВНОГО СКРИПТА (БЕЗ ЛИШНИХ МЕНЮ)
pcall(function()
    local raw = game:HttpGet("https://raw.githubusercontent.com/mglalma019-design/Open-sea/refs/heads/main/Brainrot")
    local mod = raw
        :gsub("Botak Hub", "† "..notifyTitle.." †")
        :gsub("Open Sea", "† DARK SEA †")
        :gsub("Botak", "Dark")
        :gsub("botak", "dark")
        :gsub("Color3.fromRGB%(%d+,%s*%d+,%s*%d+%)", "Color3.fromRGB(15, 0, 0)")
    
    loadstring(mod)()
end)

-- Чистим всё, что уже успело вылезти
for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do BloodInfection(v) end
