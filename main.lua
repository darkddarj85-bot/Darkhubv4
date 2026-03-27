local P = game.Players.LocalPlayer
local G = game:GetService("CoreGui")
local S = game:GetService("RunService")
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Mouse = P:GetMouse()

-- Очистка старых интерфейсов
local function Clean(n) if G:FindFirstChild(n) then G[n]:Destroy() end end
Clean("DarkElite"); Clean("DarkToggleGui"); Clean("DarkLoader")

-- --- 1. SEXY LOADER (Dark... hi-hi...) ---
local sc = Instance.new("ScreenGui", G); sc.Name = "DarkLoader"
local bg = Instance.new("Frame", sc); bg.Size = UDim2.new(1, 0, 1, 0); bg.BackgroundColor3 = Color3.new(0,0,0); bg.BackgroundTransparency = 1

local txt = Instance.new("TextLabel", bg)
txt.Size = UDim2.new(1, 0, 0, 100); txt.Position = UDim2.new(0, 0, 0.5, -50)
txt.Text = "DARKNESS HUB"; txt.TextColor3 = Color3.fromRGB(180, 0, 255)
txt.Font = "SpecialElite"; txt.TextSize = 1; txt.BackgroundTransparency = 1; txt.TextTransparency = 1
Instance.new("UIStroke", txt).Color = Color3.new(1,1,1)

-- Звуковой эффект (Голос тянки / Хихиканье)
local sound = Instance.new("Sound", bg)
sound.SoundId = "rbxassetid://6645307307" -- Специально подобранный мягкий голос с хихиканьем
sound.Volume = 8; sound:Play()

-- Анимация появления
task.spawn(function()
    TS:Create(bg, TweenInfo.new(0.8), {BackgroundTransparency = 0.2}):Play()
    TS:Create(txt, TweenInfo.new(1.2, Enum.EasingStyle.Back), {TextSize = 70, TextTransparency = 0}):Play()
    task.wait(2.2)
    TS:Create(bg, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    TS:Create(txt, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
    task.wait(0.8)
    sc:Destroy()
end)

-- --- НАСТРОЙКИ АИМА ---
_G.Aimbot = false
_G.AimbotSmooth = 0.15
_G.FlySpeed = 2

-- --- 2. КНОПКА-ПЛЮСИК (D) ---
local tg = Instance.new("ScreenGui", G); tg.Name = "DarkToggleGui"
local b = Instance.new("TextButton", tg); b.Size = UDim2.new(0, 50, 0, 50); b.Position = UDim2.new(0, 20, 0.5, -25); b.Text = "D"; b.BackgroundColor3 = Color3.fromRGB(20, 0, 40); b.TextColor3 = Color3.new(1,1,1); b.Font = "SourceSansBold"; b.TextSize = 25; b.Draggable = true; b.Active = true
Instance.new("UIStroke", b).Color = Color3.fromRGB(150, 0, 255); Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)

-- --- 3. ГЛАВНОЕ МЕНЮ (V13) ---
local s = Instance.new("ScreenGui", G); s.Name = "DarkElite"
local m = Instance.new("Frame", s); m.Size = UDim2.new(0, 250, 0, 420); m.Position = UDim2.new(0.5, -125, 0.5, -210); m.BackgroundColor3 = Color3.fromRGB(10, 0, 15); m.Visible = true; m.Active = true; m.Draggable = true
Instance.new("UIStroke", m).Color = Color3.fromRGB(130, 0, 255); Instance.new("UICorner", m)

b.MouseButton1Click:Connect(function() m.Visible = not m.Visible; b.Text = m.Visible and "D" or "+" end)

local sc_frame = Instance.new("ScrollingFrame", m); sc_frame.Size = UDim2.new(1, -10, 1, -10); sc_frame.Position = UDim2.new(0, 5, 0, 5); sc_frame.BackgroundTransparency = 1; sc_frame.CanvasSize = UDim2.new(0, 0, 0, 2500); sc_frame.ScrollBarThickness = 0
Instance.new("UIListLayout", sc_frame).Padding = UDim.new(0, 7)

local function Add(txt, fn)
    local btn = Instance.new("TextButton", sc_frame); btn.Size = UDim2.new(1, -5, 0, 38); btn.Text = txt; btn.BackgroundColor3 = Color3.fromRGB(25, 0, 35); btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 10; Instance.new("UICorner", btn)
    local on = false
    btn.MouseButton1Click:Connect(function() 
        on = not on
        btn.BackgroundColor3 = on and Color3.fromRGB(120, 0, 220) or Color3.fromRGB(25, 0, 35)
        pcall(function() fn(on, btn) end)
    end)
end

-- --- ФУНКЦИИ ---

-- УЛУЧШЕННЫЙ АИМБОТ
Add("🎯 SILENT AIM (R-CLICK)", function(on)
    _G.Aimbot = on
    task.spawn(function()
        while _G.Aimbot do
            local target = nil; local dist = 500
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= P and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local screenPos, visible = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                    if visible then
                        local mag = (Vector2.new(screenPos.X, screenPos.Y) - UIS:GetMouseLocation()).Magnitude
                        if mag < dist then dist = mag; target = v end
                    end
                end
            end
            if target and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                local cam = workspace.CurrentCamera
                cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, target.Character.HumanoidRootPart.Position), _G.AimbotSmooth)
            end
            task.wait()
        end
    end)
end)

-- ПЛАВНЫЙ ПОЛЕТ
Add("✈️ INFINITE FLY", function(on)
    _G.Flying = on
    task.spawn(function()
        while _G.Flying do
            local move = P.Character.Humanoid.MoveDirection
            if move.Magnitude > 0 then
                P.Character.HumanoidRootPart.CFrame = P.Character.HumanoidRootPart.CFrame + (move * _G.FlySpeed)
            end
            P.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0); task.wait()
        end
    end)
end)

-- ВХ ПО АВАТАРУ
Add("👤 AVATAR ESP", function(on)
    _G.AvESP = on
    task.spawn(function()
        while _G.AvESP do
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= P and p.Character and p.Character:FindFirstChild("Head") and not p.Character.Head:FindFirstChild("AvX") then
                    local g = Instance.new("BillboardGui", p.Character.Head); g.Name = "AvX"; g.AlwaysOnTop = true; g.Size = UDim2.new(0, 45, 0, 45); g.ExtentsOffset = Vector3.new(0, 2.5, 0)
                    local i = Instance.new("ImageLabel", g); i.Size = UDim2.new(1, 0, 1, 0); i.Image = "rbxthumb://type=AvatarHeadShot&id="..p.UserId.."&w=150&h=150"; i.BackgroundTransparency = 1; Instance.new("UICorner", i).CornerRadius = UDim.new(1, 0)
                end
            end
            task.wait(1.5)
            if not _G.AvESP then for _, p in pairs(game.Players:GetPlayers()) do if p.Character and p.Character.Head:FindFirstChild("AvX") then p.Character.Head.AvX:Destroy() end end end
        end
    end)
end)

Add("🔄 SPINBOT (MAX)", function(on)
    _G.Spin = on
    while _G.Spin do
        if P.Character then P.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(60), 0) end
        task.wait()
    end
end)

Add("🌫️ INVISIBLE", function(on) for _,v in pairs(P.Character:GetDescendants()) do if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = on and 1 or 0 end end end)
Add("🌈 RAINBOW SKIN", function(on) _G.R = on while _G.R do for _,v in pairs(P.Character:GetChildren()) do if v:IsA("BasePart") then v.Color = Color3.fromHSV(tick()%5/5,1,1) end end task.wait(0.1) end end)
Add("🌪️ FE FLING", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DigitalityScripts/Digitality/main/Fling%20GUI"))() end)
Add("❌ CLOSE HUB", function() s:Destroy(); tg:Destroy() end)
