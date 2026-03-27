local P, G, S = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- Чистим старое
if G:FindFirstChild("DarkElite") then G.DarkElite:Destroy() end
if G:FindFirstChild("DarkToggleGui") then G.DarkToggleGui:Destroy() end
if G:FindFirstChild("DarkScreamer") then G.DarkScreamer:Destroy() end

-- --- 1. ХОРРОР-ЛОАДЕР (СКРИМЕР) ---
local sc = Instance.new("ScreenGui", G); sc.Name = "DarkScreamer"
local m_img = Instance.new("ImageLabel", sc)
m_img.Size = UDim2.new(0, 0, 0, 0)
m_img.Position = UDim2.new(0.5, 0, 0.5, 0)
m_img.AnchorPoint = Vector2.new(0.5, 0.5)
m_img.Image = "rbxassetid://10435316484" -- ID страшного лица
m_img.BackgroundTransparency = 1
m_img.ZIndex = 10

local sound = Instance.new("Sound", sc)
sound.SoundId = "rbxassetid://5567501602" -- ID громкого крика
sound.Volume = 10

-- Запуск анимации
task.spawn(function()
    sound:Play()
    -- Резкое увеличение монстра на весь экран
    m_img:TweenSize(UDim2.new(1.2, 0, 1.2, 0), "Out", "Bounce", 0.5)
    
    -- Тряска экрана
    for i = 1, 20 do
        m_img.Position = UDim2.new(0.5, math.random(-20,20), 0.5, math.random(-20,20))
        task.wait(0.05)
    end
    
    -- Исчезновение
    m_img:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quad", 0.3)
    task.wait(0.3)
    sc:Destroy()
end)

-- --- ПЕРЕМЕННЫЕ ЧИТОВ ---
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

local sc_frame = Instance.new("ScrollingFrame", m); sc_frame.Size = UDim2.new(1, -10, 1, -10); sc_frame.Position = UDim2.new(0, 5, 0, 5); sc_frame.BackgroundTransparency = 1; sc_frame.CanvasSize = UDim2.new(0, 0, 0, 1600)
Instance.new("UIListLayout", sc_frame).Padding = UDim.new(0, 5)

local function Add(txt, fn)
    local btn = Instance.new("TextButton", sc_frame); btn.Size = UDim2.new(1, -5, 0, 35); btn.Text = txt; btn.BackgroundColor3 = Color3.fromRGB(25,25,25); btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 11; Instance.new("UICorner", btn)
    local on = false
    btn.MouseButton1Click:Connect(function() on = not on; btn.BackgroundColor3 = on and Color3.new(0.6,0,0) or Color3.fromRGB(25,25,25); pcall(function() fn(on, btn) end) end)
end

-- --- ФУНКЦИИ ---

Add("✈️ FLY (SMOOTH)", function(on, btn)
    _G.Flying = on
    task.spawn(function()
        while _G.Flying do
            local move = P.Character.Humanoid.MoveDirection
            if move.Magnitude > 0 then
                P.Character.HumanoidRootPart.CFrame = P.Character.HumanoidRootPart.CFrame + (move * _G.FlySpeed)
            end
            P.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            task.wait()
        end
    end)
end)

Add("🎯 AIMBOT (BODY)", function(on)
    _G.Aimbot = on
    task.spawn(function()
        while _G.Aimbot do
            local target = nil; local dist = math.huge
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= P and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (v.Character.HumanoidRootPart.Position - P.Character.HumanoidRootPart.Position).Magnitude
                    if d < dist then dist = d; target = v end
                end
            end
            if target then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.HumanoidRootPart.Position) end
            task.wait()
        end
    end)
end)

Add("🌫️ INVISIBLE", function(on)
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

Add("🌪️ FE FLING", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DigitalityScripts/Digitality/main/Fling%20GUI"))() end)
Add("⚡ FLY SPEED: x5", function(_, btn) _G.FlySpeed = (_G.FlySpeed == 2 and 5 or 2) btn.Text = "⚡ FLY SPEED: x".._G.FlySpeed end)
Add("🧱 INF YIELD", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
Add("❌ EXIT", function() s:Destroy(); tg:Destroy() end)
