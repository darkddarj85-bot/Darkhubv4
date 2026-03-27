local P, G, S = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- Чистим старое
if G:FindFirstChild("DarkElite") then G.DarkElite:Destroy() end
if G:FindFirstChild("DarkToggleGui") then G.DarkToggleGui:Destroy() end

-- Переменные для Полета
_G.FlySpeed = 50
local flyConnection

-- --- КНОПКА-ПЛЮСИК (X / +) ---
local tg = Instance.new("ScreenGui", G); tg.Name = "DarkToggleGui"
local b = Instance.new("TextButton", tg)
b.Size = UDim2.new(0, 45, 0, 45); b.Position = UDim2.new(0, 15, 0.5, -22)
b.Text = "X"; b.BackgroundColor3 = Color3.new(0,0,0); b.TextColor3 = Color3.new(1,0,0)
b.Font = "SourceSansBold"; b.TextSize = 30; b.Draggable = true; b.Active = true
Instance.new("UIStroke", b).Color = Color3.new(1,0,0); Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

-- --- ГЛАВНОЕ ОКНО ---
local s = Instance.new("ScreenGui", G); s.Name = "DarkElite"
local m = Instance.new("Frame", s); m.Size = UDim2.new(0, 260, 0, 420); m.Position = UDim2.new(0.5, -130, 0.5, -210); m.BackgroundColor3 = Color3.new(0,0,0); m.Active = true; m.Draggable = true
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
        pcall(function() fn(on, btn) end)
    end)
end

-- --- ФУНКЦИИ ---

-- 1. ЛУЧШИЙ FLY (ВСТРОЕННЫЙ)
Add("✈️ FLY: OFF", function(on, btn)
    _G.Flying = on
    btn.Text = on and "✈️ FLY: ON (WORKING)" or "✈️ FLY: OFF"
    
    if on then
        local bg = Instance.new("BodyGyro", P.Character.HumanoidRootPart)
        bg.P = 9e4; bg.maxTorque = Vector3.new(9e9, 9e9, 9e9); bg.cframe = P.Character.HumanoidRootPart.CFrame
        local bv = Instance.new("BodyVelocity", P.Character.HumanoidRootPart)
        bv.velocity = Vector3.new(0,0.1,0); bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        
        flyConnection = S.RenderStepped:Connect(function()
            P.Character.Humanoid.PlatformStand = true
            local cam = workspace.CurrentCamera.CFrame
            local moveDir = P.Character.Humanoid.MoveDirection
            bv.velocity = (cam.LookVector * moveDir.Z + cam.RightVector * moveDir.X) * _G.FlySpeed
            bg.cframe = cam
            if moveDir.Magnitude == 0 then bv.velocity = Vector3.new(0,0.1,0) end
        end)
    else
        if flyConnection then flyConnection:Disconnect() end
        P.Character.Humanoid.PlatformStand = false
        if P.Character.HumanoidRootPart:FindFirstChild("BodyGyro") then P.Character.HumanoidRootPart.BodyGyro:Destroy() end
        if P.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then P.Character.HumanoidRootPart.BodyVelocity:Destroy() end
    end
end, Color3.fromRGB(0, 80, 200))

-- 2. СКОРОСТЬ ПОЛЕТА (ПЕРЕКЛЮЧАТЕЛЬ)
Add("🏃 FLY SPEED: 50", function(on, btn)
    if _G.FlySpeed == 50 then _G.FlySpeed = 150; btn.Text = "🏃 FLY SPEED: 150"
    elseif _G.FlySpeed == 150 then _G.FlySpeed = 300; btn.Text = "🏃 FLY SPEED: 300"
    else _G.FlySpeed = 50; btn.Text = "🏃 FLY SPEED: 50" end
end)

-- 3. INVISIBLE (TOGGLE + RETURN)
Add("🌫️ INVISIBLE", function(on)
    _G.Invis = on
    local char = P.Character
    if on then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 1 end
        end
        char.Head.face.Transparency = 1
    else
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 0 end
        end
        char.Head.face.Transparency = 0
    end
end)

-- 4. RAINBOW SKIN
Add("🌈 RAINBOW SKIN", function(st)
    _G.Rain = st
    while _G.Rain do
        local c = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        if P.Character then
            for _, v in pairs(P.Character:GetChildren()) do if v:IsA("BasePart") then v.Color = c end end
        end
        task.wait(0.1)
    end
end)

-- 5. ТЕЛЕПОРТ, ZOOM И ПРОЧЕЕ
Add("📍 TP TO PLAYER", function()
    local all = game.Players:GetPlayers(); local target = all[math.random(1, #all)]
    if target ~= P and target.Character then P.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame end
end)

Add("🔍 ZOOM CLICK", function(on)
    _G.ZC = on
    P:GetMouse().Button2Down:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 20 end end)
    P:GetMouse().Button2Up:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 70 end end)
end)

Add("🌪️ FE FLING", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DigitalityScripts/Digitality/main/Fling%20GUI"))() end)
Add("🧱 INF YIELD", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
Add("❌ EXIT HUB", function() s:Destroy(); tg:Destroy() end, Color3.fromRGB(50, 50, 50))
