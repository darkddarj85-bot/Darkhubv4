-- DARK HUB V6: RAINBOW & VISUALS EDITION
local P, G, S = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("RunService")

-- 1. ЧИСТИМ СТАРЬЁ
for _, v in pairs(G:GetChildren()) do
    if v.Name == "DarkElite" or v.Name == "DarkToggleGui" then v:Destroy() end
end

-- 2. КНОПКА-ПЛЮСИК (+)
local tg = Instance.new("ScreenGui", G); tg.Name = "DarkToggleGui"
local b = Instance.new("TextButton", tg)
b.Size = UDim2.new(0, 45, 0, 45); b.Position = UDim2.new(0, 15, 0.5, -22)
b.Text = "X"; b.BackgroundColor3 = Color3.new(0,0,0); b.TextColor3 = Color3.new(1,0,0)
b.Font = "SourceSansBold"; b.TextSize = 30; b.Draggable = true; b.Active = true
Instance.new("UIStroke", b).Color = Color3.new(1,0,0); Instance.new("UICorner", b)

-- 3. ГЛАВНОЕ ОКНО
local s = Instance.new("ScreenGui", G); s.Name = "DarkElite"
local m = Instance.new("Frame", s); m.Size = UDim2.new(0, 260, 0, 420); m.Position = UDim2.new(0.5, -130, 0.5, -210); m.BackgroundColor3 = Color3.new(0,0,0); m.Active = true; m.Draggable = true
Instance.new("UIStroke", m).Color = Color3.new(1, 0, 0); Instance.new("UICorner", m)

b.MouseButton1Click:Connect(function()
    m.Visible = not m.Visible
    b.Text = m.Visible and "X" or "+"
    b.TextColor3 = m.Visible and Color3.new(1,0,0) or Color3.new(0,1,0)
end)

local sc = Instance.new("ScrollingFrame", m); sc.Size = UDim2.new(1, -10, 1, -10); sc.Position = UDim2.new(0, 5, 0, 5); sc.BackgroundTransparency = 1; sc.CanvasSize = UDim2.new(0, 0, 0, 1800); sc.ScrollBarThickness = 2
Instance.new("UIListLayout", sc).Padding = UDim.new(0, 5)

local function Add(txt, fn, clr)
    local btn = Instance.new("TextButton", sc); btn.Size = UDim2.new(1, -5, 0, 35); btn.Text = txt; btn.BackgroundColor3 = clr or Color3.fromRGB(25,25,25); btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 11; Instance.new("UICorner", btn)
    local on = false
    btn.MouseButton1Click:Connect(function() on = not on; btn.BackgroundColor3 = on and Color3.new(0.6,0,0) or (clr or Color3.fromRGB(25,25,25)); pcall(function() fn(on) end) end)
end

-- --- НОВЫЕ ВИЗУАЛЫ И ФУНКЦИИ ---

-- 1. РАДУЖНАЯ КОЖА (Rainbow Skin)
Add("🌈 RAINBOW SKIN", function(st)
    _G.Rainbow = st
    while _G.Rainbow do
        local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        if P.Character then
            for _, v in pairs(P.Character:GetChildren()) do
                if v:IsA("BasePart") then v.Color = color end
            end
        end
        task.wait(0.1)
    end
end, Color3.fromRGB(100, 0, 150))

-- 2. ESP BOXES (Квадраты вокруг игроков)
Add("📦 ESP BOXES", function(st)
    _G.Boxes = st
    while _G.Boxes do
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= P and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and not p.Character:FindFirstChild("BoxESP") then
                local b = Instance.new("BoxHandleAdornment", p.Character); b.Name = "BoxESP"; b.AlwaysOnTop = true; b.Adornee = p.Character; b.Size = Vector3.new(4, 6, 1); b.Transparency = 0.5; b.Color3 = Color3.new(1,0,0); b.ZIndex = 10
            end
        end
        task.wait(1)
        if not _G.Boxes then for _,p in pairs(game.Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("BoxESP") then p.Character.BoxESP:Destroy() end end end
    end
end)

-- 3. ТРАССЕРЫ (Линии к игрокам)
Add("📏 ESP TRACERS", function(st)
    _G.Tracers = st
    -- Подключаем универсальный скрипт трассеров
    if st then loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Exunys-ESP/main/src/Tracer.lua"))() end
end)

-- 4. РОБОЧИЙ FLING (Разброс)
Add("🌪️ FE FLING (BEST)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DigitalityScripts/Digitality/main/Fling%20GUI"))()
end, Color3.fromRGB(150, 0, 0))

-- 5. РОБОЧИЙ FLY (Полет V3)
Add("✈️ FLY MODE (V3)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()
end, Color3.fromRGB(0, 100, 200))

-- --- ОСТАЛЬНОЕ ---
Add("👤 ESP AVATARS", function(st)
    _G.esp_av = st
    while _G.esp_av do
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= P and p.Character and p.Character:FindFirstChild("Head") and not p.Character.Head:FindFirstChild("AvESP") then
                local b = Instance.new("BillboardGui", p.Character.Head); b.Name = "AvESP"; b.AlwaysOnTop = true; b.Size = UDim2.new(0, 40, 0, 40); b.ExtentsOffset = Vector3.new(0, 3, 0)
                local i = Instance.new("ImageLabel", b); i.Size = UDim2.new(1, 0, 1, 0); i.Image = "rbxthumb://type=AvatarHeadShot&id="..p.UserId.."&w=150&h=150"; i.BackgroundTransparency = 1; Instance.new("UICorner", i).CornerRadius = UDim.new(1, 0)
            end
        end
        task.wait(1)
        if not _G.esp_av then for _,p in pairs(game.Players:GetPlayers()) do if p.Character and p.Character.Head:FindFirstChild("AvESP") then p.Character.Head.AvESP:Destroy() end end end
    end
end)

Add("🔍 ZOOM CLICK", function(on)
    _G.ZC = on
    P:GetMouse().Button2Down:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 20 end end)
    P:GetMouse().Button2Up:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 70 end end)
end)

Add("🌫️ INVISIBLE (WORK)", function()
    local c = P.Character
    if c then for _,v in pairs(c:GetDescendants()) do if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 1 end end end
end)

Add("⚡ SPEED 150", function(on) P.Character.Humanoid.WalkSpeed = on and 150 or 16 end)
Add("🚀 SUPER JUMP", function(on) P.Character.Humanoid.JumpPower = on and 200 or 50; P.Character.Humanoid.UseJumpPower = true end)
Add("🧱 INF YIELD", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
Add("❌ EXIT HUB", function() s:Destroy(); tg:Destroy() end, Color3.fromRGB(50, 50, 50))
