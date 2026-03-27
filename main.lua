local P, G, S = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("TweenService")

-- Чистим всё старое перед запуском
if G:FindFirstChild("DarkElite") then G.DarkElite:Destroy() end
if G:FindFirstChild("DarkToggleGui") then G.DarkToggleGui:Destroy() end

-- --- 1. КНОПКА ПЕРЕКЛЮЧЕНИЯ (ПЛЮСИК) ---
local tg = Instance.new("ScreenGui", G); tg.Name = "DarkToggleGui"
local b = Instance.new("TextButton", tg)
b.Size = UDim2.new(0, 45, 0, 45); b.Position = UDim2.new(0, 15, 0.5, -22)
b.Text = "X"; b.BackgroundColor3 = Color3.new(0,0,0); b.TextColor3 = Color3.new(1,0,0)
b.Font = "SourceSansBold"; b.TextSize = 30; b.Draggable = true; b.Active = true
Instance.new("UIStroke", b).Color = Color3.new(1,0,0)
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

-- --- 2. ГЛАВНОЕ ОКНО МЕНЮ ---
local s = Instance.new("ScreenGui", G); s.Name = "DarkElite"
local m = Instance.new("Frame", s)
m.Size = UDim2.new(0, 260, 0, 420); m.Position = UDim2.new(0.5, -130, 0.5, -210)
m.BackgroundColor3 = Color3.new(0,0,0); m.Active = true; m.Draggable = true; m.Visible = true
Instance.new("UIStroke", m).Color = Color3.new(1, 0, 0); Instance.new("UICorner", m)

-- Логика кнопки X / +
b.MouseButton1Click:Connect(function()
    m.Visible = not m.Visible
    b.Text = m.Visible and "X" or "+"
    b.TextColor3 = m.Visible and Color3.new(1,0,0) or Color3.new(0,1,0)
end)

-- --- 3. СКРОЛЛ И СПИСОК ---
local sc = Instance.new("ScrollingFrame", m); sc.Size = UDim2.new(1, -10, 1, -10); sc.Position = UDim2.new(0, 5, 0, 5); sc.BackgroundTransparency = 1; sc.CanvasSize = UDim2.new(0, 0, 0, 1500); sc.ScrollBarThickness = 2
Instance.new("UIListLayout", sc).Padding = UDim.new(0, 4)

local function Add(txt, fn, clr)
    local btn = Instance.new("TextButton", sc); btn.Size = UDim2.new(1, -5, 0, 35); btn.Text = txt; btn.BackgroundColor3 = clr or Color3.fromRGB(20,20,20); btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 11; Instance.new("UICorner", btn)
    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on; btn.BackgroundColor3 = on and Color3.new(0.6, 0, 0) or (clr or Color3.fromRGB(20,20,20))
        pcall(function() fn(on) end)
    end)
end

-- --- 4. ВСЕ ТВОИ ФУНКЦИИ ВМЕСТЕ ---

-- Основные читы
Add("🔥 ULTIMATE SPEED", function(st) P.Character.Humanoid.WalkSpeed = st and 120 or 16 end, Color3.fromRGB(100, 0, 0))
Add("👤 ESP AVATARS", function(st) _G.esp = st end) -- ESP код подхватится из твоего основного скрипта
Add("🔍 ZOOM CLICK", function(on) _G.ZC = on; P:GetMouse().Button2Down:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 20 end end); P:GetMouse().Button2Up:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 70 end end) end)
Add("🚀 SUPER JUMP", function(on) P.Character.Humanoid.JumpPower = on and 200 or 50; P.Character.Humanoid.UseJumpPower = true end)
Add("📍 TP TO PLAYER", function() local all = game.Players:GetPlayers(); local r = all[math.random(1, #all)]; if r ~= P and r.Character then P.Character.HumanoidRootPart.CFrame = r.Character.HumanoidRootPart.CFrame end end)

-- Вспомогательные скрипты (Loadstrings)
Add("✈️ FLY MODE", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))() end)
Add("🌫️ INVISIBLE FIXED", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/0866/lua-scripts/master/Invisible.lua'))() end)
Add("🌪️ FE FLING", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DigitalityScripts/Digitality/main/Fling%20GUI"))() end)
Add("🦘 INF JUMP", function(on) _G.IJ = on; game:GetService("UserInputService").JumpRequest:Connect(function() if _G.IJ then P.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end) end)
Add("🧱 INF YIELD", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)

-- Выход
Add("❌ CLOSE HUB", function() s:Destroy(); tg:Destroy() end, Color3.fromRGB(40,40,40))
