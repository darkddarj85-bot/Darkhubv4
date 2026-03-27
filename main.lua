local P, G, S = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Mouse = P:GetMouse()

-- Чистка
local function Clean(name) if G:FindFirstChild(name) then G[name]:Destroy() end end
Clean("DarkElite"); Clean("DarkToggleGui"); Clean("DarkScreamer"); Clean("DarkFOV")

-- --- 1. ГАРАНТИРОВАННЫЙ СКРИМЕР ---
local sc = Instance.new("ScreenGui", G); sc.Name = "DarkScreamer"
local bg = Instance.new("Frame", sc); bg.Size = UDim2.new(1, 0, 1, 0); bg.BackgroundColor3 = Color3.new(0,0,0); bg.ZIndex = 999
local eL = Instance.new("Frame", bg); eL.Size = UDim2.new(0, 80, 0, 80); eL.Position = UDim2.new(0.35, -40, 0.35, 0); eL.BackgroundColor3 = Color3.new(1,0,0); Instance.new("UICorner", eL).CornerRadius = UDim.new(1,0)
local eR = Instance.new("Frame", bg); eR.Size = UDim2.new(0, 80, 0, 80); eR.Position = UDim2.new(0.65, -40, 0.35, 0); eR.BackgroundColor3 = Color3.new(1,0,0); Instance.new("UICorner", eR).CornerRadius = UDim.new(1,0)
local snd = Instance.new("Sound", bg); snd.SoundId = "rbxasset://sounds/action_falling_clobber.mp3"; snd.Volume = 10; snd.Pitch = 0.5; snd:Play()

task.spawn(function()
    for i = 1, 30 do bg.Position = UDim2.new(0, math.random(-25,25), 0, math.random(-25,25)); task.wait(0.04) end
    sc:Destroy()
end)

-- --- НАСТРОЙКИ АИМА ---
_G.Aimbot = false
_G.AimbotSmooth = 0.2
_G.FOVSize = 150
_G.FlySpeed = 2

-- Круг FOV
local FOVring = Drawing.new("Circle")
FOVring.Visible = false; FOVring.Thickness = 1.5; FOVring.Radius = _G.FOVSize; FOVring.Color = Color3.fromRGB(255, 0, 0); FOVring.Filled = false

-- --- 2. КНОПКА-ПЛЮСИК (+) ---
local tg = Instance.new("ScreenGui", G); tg.Name = "DarkToggleGui"
local b = Instance.new("TextButton", tg); b.Size = UDim2.new(0, 45, 0, 45); b.Position = UDim2.new(0, 15, 0.5, -22); b.Text = "X"; b.BackgroundColor3 = Color3.new(0,0,0); b.TextColor3 = Color3.new(1,0,0); b.Font = "SourceSansBold"; b.TextSize = 30; b.Draggable = true; b.Active = true; Instance.new("UIStroke", b).Color = Color3.new(1,0,0); Instance.new("UICorner", b)

-- --- 3. ГЛАВНОЕ МЕНЮ ---
local s = Instance.new("ScreenGui", G); s.Name = "DarkElite"
local m = Instance.new("Frame", s); m.Size = UDim2.new(0, 260, 0, 420); m.Position = UDim2.new(0.5, -130, 0.5, -210); m.BackgroundColor3 = Color3.new(0,0,0); m.Visible = true; m.Active = true; m.Draggable = true; Instance.new("UIStroke", m).Color = Color3.new(1, 0, 0); Instance.new("UICorner", m)

b.MouseButton1Click:Connect(function() m.Visible = not m.Visible; b.Text = m.Visible and "X" or "+" end)

local sc_frame = Instance.new("ScrollingFrame", m); sc_frame.Size = UDim2.new(1, -10, 1, -10); sc_frame.Position = UDim2.new(0, 5, 0, 5); sc_frame.BackgroundTransparency = 1; sc_frame.CanvasSize = UDim2.new(0, 0, 0, 2500)
Instance.new("UIListLayout", sc_frame).Padding = UDim.new(0, 5)

local function Add(txt, fn)
    local btn = Instance.new("TextButton", sc_frame); btn.Size = UDim2.new(1, -5, 0, 35); btn.Text = txt; btn.BackgroundColor3 = Color3.fromRGB(20,20,20); btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 10; Instance.new("UICorner", btn)
    local on = false
    btn.MouseButton1Click:Connect(function() on = not on; btn.BackgroundColor3 = on and Color3.new(0.5,0,0) or Color3.fromRGB(20,20,20); pcall(function() fn(on, btn) end) end)
end

-- --- ФУНКЦИИ ---

-- REAL AIMBOT С КРУГОМ
Add("🎯 REAL AIMBOT: OFF", function(on, btn)
    _G.Aimbot = on
    FOVring.Visible = on
    btn.Text = on and "🎯 AIMBOT: ON (LEGIT)" or "🎯 AIMBOT: OFF"
    
    S.RenderStepped:Connect(function()
        if _G.Aimbot then
            FOVring.Position = UIS:GetMouseLocation()
            local target = nil; local dist = _G.FOVSize
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= P and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local pos, visible = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                    if visible then
                        local mag = (Vector2.new(pos.X, pos.Y) - UIS:GetMouseLocation()).Magnitude
                        if mag < dist then dist = mag; target = v end
                    end
                end
            end
            if target and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then -- Захват на правую кнопку мыши
                local cam = workspace.CurrentCamera
                cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, target.Character.HumanoidRootPart.Position), _G.AimbotSmooth)
            end
        end
    end)
end)

Add("👤 AVATAR ESP", function(on)
    _G.AvESP = on
    task.spawn(function()
        while _G.AvESP do
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= P and p.Character and p.Character:FindFirstChild("Head") and not p.Character.Head:FindFirstChild("AvX") then
                    local g = Instance.new("BillboardGui", p.Character.Head); g.Name = "AvX"; g.AlwaysOnTop = true; g.Size = UDim2.new(0, 45, 0, 45); g.ExtentsOffset = Vector3.new(0, 3, 0)
                    local i = Instance.new("ImageLabel", g); i.Size = UDim2.new(1, 0, 1, 0); i.Image = "rbxthumb://type=AvatarHeadShot&id="..p.UserId.."&w=150&h=150"; i.BackgroundTransparency = 1; Instance.new("UICorner", i).CornerRadius = UDim.new(1, 0)
                end
            end
            task.wait(1)
            if not _G.AvESP then for _, p in pairs(game.Players:GetPlayers()) do if p.Character and p.Character.Head:FindFirstChild("AvX") then p.Character.Head.AvX:Destroy() end end end
        end
    end)
end)

Add("✈️ FLY (SMOOTH)", function(on)
    _G.Flying = on
    task.spawn(function()
        while _G.Flying do
            local move = P.Character.Humanoid.MoveDirection
            if move.Magnitude > 0 then P.Character.HumanoidRootPart.CFrame = P.Character.HumanoidRootPart.CFrame + (move * _G.FlySpeed) end
            P.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0); task.wait()
        end
    end)
end)

Add("🔄 SPINBOT", function(on)
    _G.Spin = on
    task.spawn(function()
        while _G.Spin do
            if P.Character and P.Character:FindFirstChild("HumanoidRootPart") then
                P.Character.HumanoidRootPart.CFrame = P.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(100), 0)
            end
            task.wait()
        end
    end)
end)

Add("📍 TP TO RANDOM", function()
    local all
