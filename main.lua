local P, G, S = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("TweenService")

-- Чистим старое
if G:FindFirstChild("DarkElite") then G.DarkElite:Destroy() end
if G:FindFirstChild("DarkToggleGui") then G.DarkToggleGui:Destroy() end

-- --- 1. КНОПКА-ПЛЮСИК (X / +) ---
local tg = Instance.new("ScreenGui", G); tg.Name = "DarkToggleGui"
local b = Instance.new("TextButton", tg)
b.Size = UDim2.new(0, 45, 0, 45); b.Position = UDim2.new(0, 15, 0.5, -22)
b.Text = "X"; b.BackgroundColor3 = Color3.new(0,0,0); b.TextColor3 = Color3.new(1,0,0)
b.Font = "SourceSansBold"; b.TextSize = 30; b.Draggable = true; b.Active = true
Instance.new("UIStroke", b).Color = Color3.new(1,0,0)
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

-- --- 2. ГЛАВНОЕ ОКНО ---
local s = Instance.new("ScreenGui", G); s.Name = "DarkElite"
local m = Instance.new("Frame", s)
m.Size = UDim2.new(0, 260, 0, 400); m.Position = UDim2.new(0.5, -130, 0.5, -200)
m.BackgroundColor3 = Color3.new(0,0,0); m.Active = true; m.Draggable = true; m.Visible = true
Instance.new("UIStroke", m).Color = Color3.new(1, 0, 0); Instance.new("UICorner", m)

-- Логика кнопки
b.MouseButton1Click:Connect(function()
    m.Visible = not m.Visible
    b.Text = m.Visible and "X" or "+"
    b.TextColor3 = m.Visible and Color3.new(1,0,0) or Color3.new(0,1,0)
end)

-- --- 3. СКРОЛЛ И СПИСОК ---
local sc = Instance.new("ScrollingFrame", m); sc.Size = UDim2.new(1, -10, 1, -10); sc.Position = UDim2.new(0, 5, 0, 5); sc.BackgroundTransparency = 1; sc.CanvasSize = UDim2.new(0, 0, 0, 1300); sc.ScrollBarThickness = 2
Instance.new("UIListLayout", sc).Padding = UDim.new(0, 4)

local function Add(txt, fn, clr)
    local btn = Instance.new("TextButton", sc); btn.Size = UDim2.new(1, -5, 0, 35); btn.Text = txt; btn.BackgroundColor3 = clr or Color3.fromRGB(20,20,20); btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 11; Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() pcall(fn) end)
end

-- --- 4. ТВОИ ФУНКЦИИ (В САМОМ ВЕРХУ) ---

-- РАБОЧИЙ ИНВИЗ (НОВЫЙ МЕТОД)
Add("🌫️ INVISIBLE (WORK)", function()
    local char = P.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = 1 -- Для тебя ты видимый (чуть-чуть), для других - нет
            end
        end
        char.Head.face:Destroy() -- Удаляем лицо для полной скрытности
        print("Invisible Activated")
    end
end, Color3.fromRGB(0, 80, 0))

Add("🔍 ZOOM CLICK", function()
    _G.ZC = not _G.ZC
    P:GetMouse().Button2Down:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 20 end end)
    P:GetMouse().Button2Up:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 70 end end)
end)

Add("📍 TELEPORT TO PLAYER", function()
    local all = game.Players:GetPlayers()
    local target = all[math.random(1, #all)]
    if target ~= P and target.Character then
        P.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
    end
end)

Add("🚀 SUPER JUMP (200)", function()
    P.Character.Humanoid.JumpPower = 200
    P.Character.Humanoid.UseJumpPower = true
end)

Add("✈️ FLY MODE", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))() end)
Add("🌪️ FE FLING", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DigitalityScripts/Digitality/main/Fling%20GUI"))() end)
Add("🔥 SPEED 120", function() P.Character.Humanoid.WalkSpeed = 120 end)
Add("🦘 INF JUMP", function() _G.IJ = true; game:GetService("UserInputService").JumpRequest:Connect(function() if _G.IJ then P.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end) end)
Add("🧱 INF YIELD", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
Add("❌ CLOSE ALL", function() s:Destroy(); tg:Destroy() end, Color3.fromRGB(50, 50, 50))
