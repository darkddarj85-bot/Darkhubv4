local P, G, S = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- Чистим старое
local function Clean(name) if G:FindFirstChild(name) then G[name]:Destroy() end end
Clean("DarkElite"); Clean("DarkToggleGui"); Clean("DarkScreamer")

-- --- 1. ГАРАНТИРОВАННЫЙ ХОРРОР-ЛОАДЕР (БЕЗ ID) ---
local sc = Instance.new("ScreenGui", G); sc.Name = "DarkScreamer"
local bg = Instance.new("Frame", sc); bg.Size = UDim2.new(1, 0, 1, 0); bg.BackgroundColor3 = Color3.new(0,0,0); bg.ZIndex = 999

-- Рисуем жуткую рожу программно
local function CreatePart(sz, ps, clr)
    local p = Instance.new("Frame", bg); p.Size = sz; p.Position = ps; p.BackgroundColor3 = clr; p.BorderSizePixel = 0; return p
end

local eyeL = CreatePart(UDim2.new(0, 80, 0, 80), UDim2.new(0.35, -40, 0.35, 0), Color3.new(1,0,0))
local eyeR = CreatePart(UDim2.new(0, 80, 0, 80), UDim2.new(0.65, -40, 0.35, 0), Color3.new(1,0,0))
local mouth = CreatePart(UDim2.new(0, 200, 0, 50), UDim2.new(0.5, -100, 0.7, 0), Color3.new(1,1,1))
Instance.new("UICorner", eyeL).CornerRadius = UDim.new(1,0)
Instance.new("UICorner", eyeR).CornerRadius = UDim.new(1,0)
Instance.new("UICorner", mouth).CornerRadius = UDim.new(0,20)

-- Звук (используем стандартный из папки звуков игры)
local sound = Instance.new("Sound", bg)
sound.SoundId = "rbxasset://sounds/action_falling_clobber.mp3" -- Этот файл есть у ВСЕХ
sound.Volume = 10; sound.Pitch = 0.5; sound:Play()

-- Эффект безумия
task.spawn(function()
    for i = 1, 40 do
        bg.BackgroundColor3 = (i % 2 == 0) and Color3.new(0,0,0) or Color3.new(0.2,0,0)
        eyeL.Size = UDim2.new(0, math.random(60,120), 0, math.random(60,120))
        eyeR.Size = eyeL.Size
        bg.Position = UDim2.new(0, math.random(-30,30), 0, math.random(-30,30))
        task.wait(0.03)
    end
    sc:Destroy()
end)

-- --- ПЕРЕМЕННЫЕ ЧИТОВ ---
_G.FlySpeed = 2
_G.SpinSpeed = 100

-- --- 2. КНОПКА-ПЛЮСИК (+) ---
local tg = Instance.new("ScreenGui", G); tg.Name = "DarkToggleGui"
local b = Instance.new("TextButton", tg); b.Size = UDim2.new(0, 45, 0, 45); b.Position = UDim2.new(0, 15, 0.5, -22); b.Text = "X"; b.BackgroundColor3 = Color3.new(0,0,0); b.TextColor3 = Color3.new(1,0,0); b.Font = "SourceSansBold"; b.TextSize = 30; b.Draggable = true; b.Active = true; Instance.new("UIStroke", b).Color = Color3.new(1,0,0); Instance.new("UICorner", b)

-- --- 3. ГЛАВНОЕ МЕНЮ ---
local s = Instance.new("ScreenGui", G); s.Name = "DarkElite"
local m = Instance.new("Frame", s); m.Size = UDim2.new(0, 260, 0, 420); m.Position = UDim2.new(0.5, -130, 0.5, -210); m.BackgroundColor3 = Color3.new(0,0,0); m.Visible = true; m.Active = true; m.Draggable = true; Instance.new("UIStroke", m).Color = Color3.new(1, 0, 0); Instance.new("UICorner", m)

b.MouseButton1Click:Connect(function() m.Visible = not m.Visible; b.Text = m.Visible and "X" or "+" end)

local sc_frame = Instance.new("ScrollingFrame", m); sc_frame.Size = UDim2.new(1, -10, 1, -10); sc_frame.Position = UDim2.new(0, 5, 0, 5); sc_frame.BackgroundTransparency = 1; sc_frame.CanvasSize = UDim2.new(0, 0, 0, 2400)
Instance.new("UIListLayout", sc_frame).Padding = UDim.new(0, 5)

local function Add(txt, fn)
    local btn = Instance.new("TextButton", sc_frame); btn.Size = UDim2.new(1, -5, 0, 35); btn.Text = txt; btn.BackgroundColor3 = Color3.fromRGB(20,20,20); btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 10; Instance.new("UICorner", btn)
    local on = false
    btn.MouseButton1Click:Connect(function() on = not on; btn.BackgroundColor3 = on and Color3.new(0.5,0,0) or Color3.fromRGB(20,20,20); pcall(function() fn(on, btn) end) end)
end

-- --- ФУНКЦИИ ---

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

Add("🔄 SPINBOT", function(on)
    _G.Spin = on
    task.spawn(function()
        while _G.Spin do
            if P.Character and P.Character:FindFirstChild("HumanoidRootPart") then
                P.Character.HumanoidRootPart.CFrame = P.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(_G.SpinSpeed), 0)
            end
            task.wait()
        end
    end)
end)

Add("📏 TRACERS (LINES)", function(on)
    _G.Tracers = on
    if on then loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Exunys-ESP/main/src/Tracer.lua"))() end
end)

Add("📍 TP TO RANDOM", function()
    local all = game.Players:GetPlayers(); local t = all[math.random(1, #all)]
    if t ~= P and t.Character then P.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame end
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

Add("🎯 AIMBOT (BODY)", function(on)
    _G.Aimbot = on
    task.spawn(function()
        while _G.Aimbot do
            local target = nil; local dist = math.huge
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= P and v.Character then
                    local d = (v.Character.HumanoidRootPart.Position - P.Character.HumanoidRootPart.Position).Magnitude
                    if d < dist then dist = d; target = v end
                end
            end
            if target then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.HumanoidRootPart.Position) end
            task.wait()
        end
    end)
end)

Add("🌈 RAINBOW SKIN", function(st)
    _G.Rain = st
    while _G.Rain do
        local c = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        if P.Character then for _, v in pairs(P.Character:GetChildren()) do if v:IsA("BasePart") then v.Color = c end end end
        task.wait(0.1)
    end
end)

Add("🌫️ INVISIBLE", function(on) for _,v in pairs(P.Character:GetDescendants()) do if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = on and 1 or 0 end end end)
Add("🌪️ FE FLING", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DigitalityScripts/Digitality/main/Fling%20GUI"))() end)
Add("❌ CLOSE", function() s:Destroy(); tg:Destroy() end)
