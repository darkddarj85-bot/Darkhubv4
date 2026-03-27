-- DARK HUB V7: FIXED FLY & FLING + RAINBOW
local P, G, S = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("RunService")

-- Очистка
for _, v in pairs(G:GetChildren()) do
    if v.Name == "DarkElite" or v.Name == "DarkToggleGui" then v:Destroy() end
end

-- КНОПКА-ПЛЮСИК
local tg = Instance.new("ScreenGui", G); tg.Name = "DarkToggleGui"
local b = Instance.new("TextButton", tg)
b.Size = UDim2.new(0, 45, 0, 45); b.Position = UDim2.new(0, 15, 0.5, -22)
b.Text = "X"; b.BackgroundColor3 = Color3.new(0,0,0); b.TextColor3 = Color3.new(1,0,0)
b.Font = "SourceSansBold"; b.TextSize = 30; b.Draggable = true; b.Active = true
Instance.new("UIStroke", b).Color = Color3.new(1,0,0); Instance.new("UICorner", b)

-- ОКНО
local s = Instance.new("ScreenGui", G); s.Name = "DarkElite"
local m = Instance.new("Frame", s); m.Size = UDim2.new(0, 260, 0, 420); m.Position = UDim2.new(0.5, -130, 0.5, -210); m.BackgroundColor3 = Color3.new(0,0,0); m.Visible = true; m.Active = true; m.Draggable = true
Instance.new("UIStroke", m).Color = Color3.new(1, 0, 0); Instance.new("UICorner", m)

b.MouseButton1Click:Connect(function()
    m.Visible = not m.Visible
    b.Text = m.Visible and "X" or "+"
    b.TextColor3 = m.Visible and Color3.new(1,0,0) or Color3.new(0,1,0)
end)

local sc = Instance.new("ScrollingFrame", m); sc.Size = UDim2.new(1, -10, 1, -10); sc.Position = UDim2.new(0, 5, 0, 5); sc.BackgroundTransparency = 1; sc.CanvasSize = UDim2.new(0, 0, 0, 1800)
Instance.new("UIListLayout", sc).Padding = UDim.new(0, 5)

local function Add(txt, fn, clr)
    local btn = Instance.new("TextButton", sc); btn.Size = UDim2.new(1, -5, 0, 35); btn.Text = txt; btn.BackgroundColor3 = clr or Color3.fromRGB(25,25,25); btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 11; Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() pcall(fn) end)
end

-- --- ФУНКЦИИ ---

-- 1. WORKING FLY (Новая ссылка, 100% рабочая)
Add("✈️ WORKING FLY (V3)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()
end, Color3.fromRGB(0, 100, 200))

-- 2. FE FLING (Самый мощный вариант)
Add("🌪️ FE FLING (KILL)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DigitalityScripts/Digitality/main/Fling%20GUI"))()
end, Color3.fromRGB(150, 0, 0))

-- 3. RAINBOW SKIN
Add("🌈 RAINBOW SKIN", function()
    _G.Rain = not _G.Rain
    while _G.Rain do
        local c = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        for _, v in pairs(P.Character:GetChildren()) do
            if v:IsA("BasePart") then v.Color = c end
        end
        task.wait(0.1)
    end
end, Color3.fromRGB(100, 0, 150))

-- 4. ESP BOXES (Визуал)
Add("📦 ESP BOXES", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/ESP.lua"))()
end)

-- 5. ZOOM CLICK
Add("🔍 ZOOM CLICK", function()
    _G.ZC = not _G.ZC
    P:GetMouse().Button2Down:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 20 end end)
    P:GetMouse().Button2Up:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 70 end end)
end)

-- 6. TP TO PLAYER
Add("📍 TP TO RANDOM PLAYER", function()
    local all = game.Players:GetPlayers(); local r = all[math.random(1, #all)]
    if r ~= P and r.Character then P.Character.HumanoidRootPart.CFrame = r.Character.HumanoidRootPart.CFrame end
end)

-- 7. SUPER JUMP
Add("🚀 SUPER JUMP", function() P.Character.Humanoid.JumpPower = 200; P.Character.Humanoid.UseJumpPower = true end)

-- 8. SPEED 150
Add("⚡ SPEED 150", function() P.Character.Humanoid.WalkSpeed = 150 end)

-- 9. INVISIBLE
Add("🌫️ INVISIBLE", function()
    local c = P.Character
    if c then for _,v in pairs(c:GetDescendants()) do if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 1 end end end
end)

-- 10. INF YIELD
Add("🧱 INF YIELD", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)

-- 11. EXIT
Add("❌ CLOSE HUB", function() s:Destroy(); tg:Destroy() end, Color3.fromRGB(50, 50, 50))
