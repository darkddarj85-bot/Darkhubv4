local P, G, S = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- Чистим старое
if G:FindFirstChild("DarkElite") then G.DarkElite:Destroy() end
if G:FindFirstChild("DarkToggleGui") then G.DarkToggleGui:Destroy() end

-- --- КНОПКА-ПЛЮСИК (X / +) ---
local tg = Instance.new("ScreenGui", G); tg.Name = "DarkToggleGui"
local b = Instance.new("TextButton", tg)
b.Size = UDim2.new(0, 45, 0, 45); b.Position = UDim2.new(0, 15, 0.5, -22)
b.Text = "X"; b.BackgroundColor3 = Color3.new(0,0,0); b.TextColor3 = Color3.new(1,0,0)
b.Font = "SourceSansBold"; b.TextSize = 30; b.Draggable = true; b.Active = true
Instance.new("UIStroke", b).Color = Color3.new(1,0,0); Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

-- --- ГЛАВНОЕ ОКНО ---
local s = Instance.new("ScreenGui", G); s.Name = "DarkElite"
local m = Instance.new("Frame", s); m.Size = UDim2.new(0, 260, 0, 400); m.Position = UDim2.new(0.5, -130, 0.5, -200); m.BackgroundColor3 = Color3.new(0,0,0); m.Active = true; m.Draggable = true
Instance.new("UIStroke", m).Color = Color3.new(1, 0, 0); Instance.new("UICorner", m)

b.MouseButton1Click:Connect(function()
    m.Visible = not m.Visible
    b.Text = m.Visible and "X" or "+"
    b.TextColor3 = m.Visible and Color3.new(1,0,0) or Color3.new(0,1,0)
end)

local sc = Instance.new("ScrollingFrame", m); sc.Size = UDim2.new(1, -10, 1, -10); sc.Position = UDim2.new(0, 5, 0, 5); sc.BackgroundTransparency = 1; sc.CanvasSize = UDim2.new(0, 0, 0, 1500)
Instance.new("UIListLayout", sc).Padding = UDim.new(0, 5)

local function Add(txt, fn, clr)
    local btn = Instance.new("TextButton", sc); btn.Size = UDim2.new(1, -5, 0, 35); btn.Text = txt; btn.BackgroundColor3 = clr or Color3.fromRGB(25,25,25); btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 11; Instance.new("UICorner", btn)
    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on; btn.BackgroundColor3 = on and Color3.new(0.6, 0, 0) or (clr or Color3.fromRGB(25,25,25))
        pcall(function() fn(on) end)
    end)
end

-- --- ФУНКЦИИ ---

-- 1. INVISIBLE (ВКЛ / ВЫКЛ)
Add("🌫️ INVISIBLE (TOGGLE)", function(on)
    if on then
        -- Становимся невидимым
        local char = P.Character
        if char then
            _G.OldPos = char.HumanoidRootPart.CFrame
            char:MoveTo(Vector3.new(0, 1000, 0)) -- Прячем тело под карту или высоко в небо
            task.wait(0.2)
            local clone = char.HumanoidRootPart:Clone()
            clone.Parent = char
            clone.CFrame = _G.OldPos
            char.HumanoidRootPart:Destroy()
            print("Invisible ON")
        end
    else
        -- Появляемся обратно (самый надежный способ - быстрый ресет персонажа)
        P.Character:BreakJoints()
        print("Visible ON (Respawning)")
    end
end, Color3.fromRGB(0, 100, 0))

-- 2. WORKING FLY (V3 MOBILE)
Add("✈️ FLY MODE (V3)", function(on)
    if on then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()
    end
end, Color3.fromRGB(0, 50, 150))

-- 3. RAINBOW SKIN
Add("🌈 RAINBOW SKIN", function(st)
    _G.Rain = st
    while _G.Rain do
        local c = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        if P.Character then
            for _, v in pairs(P.Character:GetChildren()) do
                if v:IsA("BasePart") then v.Color = c end
            end
        end
        task.wait(0.1)
    end
end)

-- 4. ZOOM CLICK
Add("🔍 ZOOM CLICK", function(on)
    _G.ZC = on
    P:GetMouse().Button2Down:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 20 end end)
    P:GetMouse().Button2Up:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 70 end end)
end)

-- 5. FE FLING (KILL)
Add("🌪️ FE FLING", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DigitalityScripts/Digitality/main/Fling%20GUI"))()
end)

-- 6. SUPER JUMP (200)
Add("🚀 SUPER JUMP", function(on)
    P.Character.Humanoid.JumpPower = on and 200 or 50
    P.Character.Humanoid.UseJumpPower = true
end)

-- 7. SPEED 150
Add("⚡ SPEED 150", function(on)
    P.Character.Humanoid.WalkSpeed = on and 150 or 16
end)

Add("🧱 INF YIELD", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

Add("❌ EXIT HUB", function() s:Destroy(); tg:Destroy() end, Color3.fromRGB(50, 50, 50))
