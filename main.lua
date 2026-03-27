local P, G, S = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Mouse = P:GetMouse()

-- Чистим старое
if G:FindFirstChild("DarkElite") then G.DarkElite:Destroy() end
if G:FindFirstChild("DarkToggleGui") then G.DarkToggleGui:Destroy() end
if G:FindFirstChild("DarkLoader") then G.DarkLoader:Destroy() end

-- --- 1. КРАСИВОЕ ЗАГРУЗОЧНОЕ МЕНЮ ---
local lsc = Instance.new("ScreenGui", G); lsc.Name = "DarkLoader"
local lfr = Instance.new("Frame", lsc); lfr.Size = UDim2.new(0, 300, 0, 100); lfr.Position = UDim2.new(0.5, -150, 0.5, -50); lfr.BackgroundColor3 = Color3.new(0,0,0); Instance.new("UICorner", lfr)
Instance.new("UIStroke", lfr).Color = Color3.new(1,0,0)

local ltxt = Instance.new("TextLabel", lfr); ltxt.Size = UDim2.new(1, 0, 0, 50); ltxt.Text = "DARK HUB V8 LOADING..."; ltxt.TextColor3 = Color3.new(1,0,0); ltxt.BackgroundTransparency = 1; ltxt.Font = "GothamBold"; ltxt.TextSize = 20

local bar = Instance.new("Frame", lfr); bar.Size = UDim2.new(0, 0, 0, 10); bar.Position = UDim2.new(0, 10, 0.7, 0); bar.BackgroundColor3 = Color3.new(1,0,0); Instance.new("UICorner", bar)

-- Анимация загрузки
bar:TweenSize(UDim2.new(1, -20, 0, 10), "Out", "Linear", 2)
task.wait(2.2)
lsc:Destroy()

-- --- ПЕРЕМЕННЫЕ ДЛЯ ЧИТОВ ---
_G.FlySpeed = 2
_G.Aimbot = false
_G.Flying = false

-- --- 2. КНОПКА-ПЛЮСИК ---
local tg = Instance.new("ScreenGui", G); tg.Name = "DarkToggleGui"
local b = Instance.new("TextButton", tg); b.Size = UDim2.new(0, 45, 0, 45); b.Position = UDim2.new(0, 15, 0.5, -22); b.Text = "X"; b.BackgroundColor3 = Color3.new(0,0,0); b.TextColor3 = Color3.new(1,0,0); b.Font = "SourceSansBold"; b.TextSize = 30; b.Draggable = true; b.Active = true
Instance.new("UIStroke", b).Color = Color3.new(1,0,0); Instance.new("UICorner", b)

-- --- 3. ГЛАВНОЕ МЕНЮ ---
local s = Instance.new("ScreenGui", G); s.Name = "DarkElite"
local m = Instance.new("Frame", s); m.Size = UDim2.new(0, 260, 0, 420); m.Position = UDim2.new(0.5, -130, 0.5, -210); m.BackgroundColor3 = Color3.new(0,0,0); m.Visible = true; m.Active = true; m.Draggable = true
Instance.new("UIStroke", m).Color = Color3.new(1, 0, 0); Instance.new("UICorner", m)

b.MouseButton1Click:Connect(function() m.Visible = not m.Visible; b.Text = m.Visible and "X" or "+"; b.TextColor3 = m.Visible and Color3.new(1,0,0) or Color3.new(0,1,0) end)

local sc = Instance.new("ScrollingFrame", m); sc.Size = UDim2.new(1, -10, 1, -10); sc.Position = UDim2.new(0, 5, 0, 5); sc.BackgroundTransparency = 1; sc.CanvasSize = UDim2.new(0, 0, 0, 1600); sc.ScrollBarThickness = 2
Instance.new("UIListLayout", sc).Padding = UDim.new(0, 5)

local function Add(txt, fn)
    local btn = Instance.new("TextButton", sc); btn.Size = UDim2.new(1, -5, 0, 35); btn.Text = txt; btn.BackgroundColor3 = Color3.fromRGB(25,25,25); btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 11; Instance.new("UICorner", btn)
    local on = false
    btn.MouseButton1Click:Connect(function() on = not on; btn.BackgroundColor3 = on and Color3.new(0.6,0,0) or Color3.fromRGB(25,25,25); pcall(function() fn(on, btn) end) end)
end

-- --- ФУНКЦИИ ---

-- СУПЕР ПЛАВНЫЙ FLY (CFRAME)
Add("✈️ FLY: OFF", function(on, btn)
    _G.Flying = on
    btn.Text = on and "✈️ FLY: ON (SMOOTH)" or "✈️ FLY: OFF"
    task.spawn(function()
        while _G.Flying do
            local cam = workspace.CurrentCamera.CFrame
            local move = Vector3.new(0,0,0)
            if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + cam.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - cam.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - cam.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + cam.RightVector end
            
            -- Для мобилок используем Humanoid.MoveDirection
            if P.Character.Humanoid.MoveDirection.Magnitude > 0 then
                move = P.Character.Humanoid.MoveDirection * 1.5
            end
            
            if move.Magnitude > 0 then
                P.Character.HumanoidRootPart.CFrame = P.Character.HumanoidRootPart.CFrame + (move * _G.FlySpeed)
            end
            P.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            task.wait()
        end
    end)
end)

-- AIMBOT НА ТЕЛО (БЛИЖАЙШИЙ)
Add("🎯 AIMBOT: OFF", function(on, btn)
    _G.Aimbot = on
    btn.Text = on and "🎯 AIMBOT: ON (BODY)" or "🎯 AIMBOT: OFF"
    task.spawn(function()
        while _G.Aimbot do
            local target = nil; local dist = math.huge
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= P and v.Character and v.Character:FindFirstChild("UpperTorso") or v.Character:FindFirstChild("Torso") then
                    local d = (v.Character.HumanoidRootPart.Position - P.Character.HumanoidRootPart.Position).Magnitude
                    if d < dist then dist = d; target = v end
                end
            end
            if target then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character:FindFirstChild("UpperTorso") and target.Character.UpperTorso.Position or target.Character.Torso.Position) end
            task.wait()
        end
    end)
end)

Add("🌫️ INVISIBLE (TOGGLE)", function(on)
    for _, v in pairs(P.Character:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = on and 1 or 0 end
    end
end)

Add("🌈 RAINBOW SKIN", function(st)
    _G.Rain = st
    while _G.Rain do
        local c = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        if P.Character then for _, v in pairs(P.Character:GetChildren()) do if v:IsA("BasePart") then v.Color = c end end end
        task.wait(0.1)
    end
end)

Add("⚡ FLY SPEED: x2", function(_, btn)
    if _G.FlySpeed == 2 then _G.FlySpeed = 5; btn.Text = "⚡ FLY SPEED: x5"
    elseif _G.FlySpeed == 5 then _G.FlySpeed = 10; btn.Text = "⚡ FLY SPEED: x10"
    else _G.FlySpeed = 2; btn.Text = "⚡ FLY SPEED: x2" end
end)

Add("🌪️ FE FLING", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DigitalityScripts/Digitality/main/Fling%20GUI"))() end)
Add("📍 TP TO RANDOM", function() local p = game.Players:GetPlayers(); local r = p[math.random(1,#p)]; P.Character.HumanoidRootPart.CFrame = r.Character.HumanoidRootPart.CFrame end)
Add("🔍 ZOOM CLICK", function(on) _G.ZC = on; Mouse.Button2Down:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 20 end end); Mouse.Button2Up:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 70 end end) end)
Add("🚀 SUPER JUMP", function(on) P.Character.Humanoid.JumpPower = on and 200 or 50; P.Character.Humanoid.UseJumpPower = true end)
Add("🧱 INF YIELD", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
Add("❌ CLOSE HUB", function() s:Destroy(); tg:Destroy() end)
