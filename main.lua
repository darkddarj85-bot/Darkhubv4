-- FULL DARK HUB V5: 11 FUNCTIONS + TOGGLE
local P, G, S = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("RunService")

-- 1. ОЧИСТКА
for _, v in pairs(G:GetChildren()) do
    if v.Name == "DarkElite" or v.Name == "DarkToggleGui" then v:Destroy() end
end

-- 2. КНОПКА-ПЛЮСИК (ДЛЯ СКРЫТИЯ)
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

local sc = Instance.new("ScrollingFrame", m); sc.Size = UDim2.new(1, -10, 1, -10); sc.Position = UDim2.new(0, 5, 0, 5); sc.BackgroundTransparency = 1; sc.CanvasSize = UDim2.new(0, 0, 0, 1600); sc.ScrollBarThickness = 2
Instance.new("UIListLayout", sc).Padding = UDim.new(0, 5)

local function Add(txt, fn, clr)
    local btn = Instance.new("TextButton", sc); btn.Size = UDim2.new(1, -5, 0, 35); btn.Text = txt; btn.BackgroundColor3 = clr or Color3.fromRGB(25,25,25); btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 11; Instance.new("UICorner", btn)
    local on = false
    btn.MouseButton1Click:Connect(function() on = not on; btn.BackgroundColor3 = on and Color3.new(0.6,0,0) or (clr or Color3.fromRGB(25,25,25)); pcall(function() fn(on) end) end)
end

-- --- ВСЕ 11 ФУНКЦИЙ ---

-- 1. ВХ АВАТАРЫ
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

-- 2. ТРАССЕРЫ (ВХ ЛИНИИ)
Add("📏 ESP TRACERS", function(st)
    _G.tracers = st
    S.RenderStepped:Connect(function()
        if not _G.tracers then return end
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= P and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                -- Логика отрисовки линий (упрощенно для мобилок)
            end
        end
    end)
end)

-- 3. ZOOM CLICK (RMB)
Add("🔍 ZOOM CLICK", function(on)
    _G.ZC = on
    P:GetMouse().Button2Down:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 20 end end)
    P:GetMouse().Button2Up:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 70 end end)
end)

-- 4. ТЕЛЕПОРТ К ИГРОКУ
Add("📍 TP TO RANDOM", function()
    local all = game.Players:GetPlayers(); local r = all[math.random(1, #all)]
    if r ~= P and r.Character then P.Character.HumanoidRootPart.CFrame = r.Character.HumanoidRootPart.CFrame end
end)

-- 5. СУПЕР ПРЫЖОК
Add("🚀 SUPER JUMP (200)", function(on) P.Character.Humanoid.JumpPower = on and 200 or 50; P.Character.Humanoid.UseJumpPower = true end)

-- 6. ИНВИЗ (FIXED)
Add("🌫️ INVISIBLE (WORK)", function()
    local c = P.Character
    if c then for _,v in pairs(c:GetDescendants()) do if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 1 end end end
end, Color3.fromRGB(0, 60, 0))

-- 7. ПОЛЕТ (FLY)
Add("✈️ FLY MODE", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))() end)

-- 8. ФЛИНГ (FE FLING)
Add("🌪️ FE FLING", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DigitalityScripts/Digitality/main/Fling%20GUI"))() end)

-- 9. БЕСКОНЕЧНЫЕ ПРЫЖКИ
Add("🦘 INF JUMP", function(on) _G.IJ = on; game:GetService("UserInputService").JumpRequest:Connect(function() if _G.IJ then P.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end) end)

-- 10. СКОРОСТЬ 150
Add("⚡ SPEED 150", function(on) P.Character.Humanoid.WalkSpeed = on and 150 or 16 end)

-- 11. INF YIELD (АДМИНКА)
Add("🧱 INF YIELD", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)

Add("❌ EXIT HUB", function() s:Destroy(); tg:Destroy() end, Color3.fromRGB(50, 50, 50))
