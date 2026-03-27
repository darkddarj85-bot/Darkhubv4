local P, G, S = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("TweenService")

-- Удаление старых версий
if G:FindFirstChild("DarkElite") then G.DarkElite:Destroy() end
if G:FindFirstChild("DarkLoad") then G.DarkLoad:Destroy() end

-- --- СТИЛЬНАЯ ЗАГРУЗКА ---
local ld = Instance.new("ScreenGui", G); ld.Name = "DarkLoad"
local f = Instance.new("Frame", ld); f.Size = UDim2.new(0, 300, 0, 100); f.Position = UDim2.new(0.5, -150, 0.5, -50); f.BackgroundColor3 = Color3.new(0,0,0); Instance.new("UIStroke", f).Color = Color3.new(1,0,0)
Instance.new("UICorner", f)

local l_t = Instance.new("TextLabel", f); l_t.Size = UDim2.new(1, 0, 0.6, 0); l_t.Text = "DARK HUB V5 LOADING..."; l_t.TextColor3 = Color3.new(1,0,0); l_t.BackgroundTransparency = 1; l_t.Font = "SourceSansBold"; l_t.TextSize = 20
local b_bg = Instance.new("Frame", f); b_bg.Size = UDim2.new(0.8, 0, 0, 4); b_bg.Position = UDim2.new(0.1, 0, 0.7, 0); b_bg.BackgroundColor3 = Color3.new(0.1,0,0)
local bar = Instance.new("Frame", b_bg); bar.Size = UDim2.new(0, 0, 1, 0); bar.BackgroundColor3 = Color3.new(1,0,0)

local t = S:Create(bar, TweenInfo.new(2), {Size = UDim2.new(1, 0, 1, 0)})
t:Play()

t.Completed:Connect(function()
    ld:Destroy()

    -- --- ГЛАВНОЕ МЕНЮ (МОНОЛИТ) ---
    local s = Instance.new("ScreenGui", G); s.Name = "DarkElite"
    local m = Instance.new("Frame", s); m.Size = UDim2.new(0, 280, 0, 450); m.Position = UDim2.new(0.5, -140, 0.5, -225); m.BackgroundColor3 = Color3.new(0,0,0); m.Active = true; m.Draggable = true
    Instance.new("UIStroke", m).Color = Color3.new(1, 0, 0)
    Instance.new("UICorner", m)

    local sc = Instance.new("ScrollingFrame", m); sc.Size = UDim2.new(1, -10, 1, -10); sc.Position = UDim2.new(0, 5, 0, 5); sc.BackgroundTransparency = 1; sc.BorderSizePixel = 0; sc.CanvasSize = UDim2.new(0, 0, 0, 1300); sc.ScrollBarThickness = 2; sc.ScrollBarImageColor3 = Color3.new(1, 0, 0)
    local lay = Instance.new("UIListLayout", sc); lay.Padding = UDim.new(0, 4); lay.HorizontalAlignment = "Center"

    local function AddBtn(name, callback, clr)
        local btn = Instance.new("TextButton", sc); btn.Size = UDim2.new(1, -5, 0, 32); btn.Text = name; btn.BackgroundColor3 = clr or Color3.fromRGB(25,25,25); btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 12; Instance.new("UICorner", btn)
        local on = false
        btn.MouseButton1Click:Connect(function()
            on = not on
            btn.BackgroundColor3 = on and Color3.new(0.6, 0, 0) or (clr or Color3.fromRGB(25,25,25))
            pcall(function() callback(on) end)
        end)
    end

    -- --- КНОПКИ (ВСЁ В ОДНОМ) ---
    AddBtn("🔥 ULTIMATE CONNECT", function(st) _G.hb = st; _G.n = st; P.Character.Humanoid.WalkSpeed = st and 100 or 16 end, Color3.fromRGB(150, 0, 0))
    
    AddBtn("👤 AVATAR & NAME ESP", function(st)
        _G.esp = st
        if st then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= P then
                    local bb = Instance.new("BillboardGui", G); bb.Name = plr.Name.."_ESP"; bb.AlwaysOnTop = true; bb.Size = UDim2.new(0, 50, 0, 70)
                    local img = Instance.new("ImageLabel", bb); img.Size = UDim2.new(1, 0, 0, 50); img.Image = "rbxthumb://type=AvatarHeadShot&id="..plr.UserId.."&w=150&h=150"; img.BackgroundTransparency = 1
                    local nm = Instance.new("TextLabel", bb); nm.Size = UDim2.new(1, 0, 0, 20); nm.Position = UDim2.new(0,0,1,0); nm.Text = plr.DisplayName; nm.TextColor3 = Color3.new(1,0,0); nm.BackgroundTransparency = 1; nm.Font = 2; nm.TextSize = 10
                    task.spawn(function()
                        while _G.esp and plr.Parent do 
                            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then bb.Adornee = plr.Character.HumanoidRootPart; bb.Enabled = true else bb.Enabled = false end
                            task.wait(0.1) 
                        end
                        bb:Destroy()
                    end)
                end
            end
        end
    end)

    AddBtn("🎯 AIM LOCK", function(st) _G.aim = st; while _G.aim do task.wait() if game:GetService("UserInputService"):IsMouseButtonPressed(0) then local t, d = nil, 1000; for _, v in pairs(game.Players:GetPlayers()) do if v ~= P and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then local p, o = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position); if o then local m = (Vector2.new(p.X, p.Y) - Vector2.new(P:GetMouse().X, P:GetMouse().Y)).Magnitude; if m < d then d = m; t = v end end end end; if t then S:Create(workspace.CurrentCamera, TweenInfo.new(0.1), {CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, t.Character.HumanoidRootPart.Position)}):Play() end end end end)
    AddBtn("⚔️ HITBOX 29", function(st) _G.hb = st; game:GetService("RunService").RenderStepped:Connect(function() if _G.hb then for _, v in pairs(game.Players:GetPlayers()) do if v ~= P and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then v.Character.HumanoidRootPart.Size = Vector3.new(29, 29, 29); v.Character.HumanoidRootPart.Transparency = 0.7; v.Character.HumanoidRootPart.CanCollide = false end end end end) end)
    AddBtn("🚀 SPEED BOOST 100", function(st) P.Character.Humanoid.WalkSpeed = st and 100 or 16 end)
    AddBtn("👻 NOCLIP", function(st) _G.n = st; game:GetService("RunService").Stepped:Connect(function() if _G.n then for _, v in pairs(P.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end end) end)
    AddBtn("✈️ FLY GUI V3", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))() end)
    AddBtn("🧱 INF YIELD", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
    AddBtn("🌫️ INVISIBLE MODE", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/0866/lua-scripts/master/Invisible.lua'))() end)
    AddBtn("🌪️ FE FLING", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DigitalityScripts/Digitality/main/Fling%20GUI"))() end)
    AddBtn("🌈 RAINBOW SKIN", function(st) _G.r = st; while _G.r do local c = Color3.fromHSV(tick() % 5 / 5, 1, 1); if P.Character then for _, v in pairs(P.Character:GetChildren()) do if v:IsA("BasePart") then v.Color = c end end end task.wait(0.1) end end)
    AddBtn("🦒 FOV 120", function(st) workspace.CurrentCamera.FieldOfView = st and 120 or 70 end)
    AddBtn("⚙️ BTOOLS", function() for i=1,4 do Instance.new("HopperBin", P.Backpack).BinType = i end end)
    AddBtn("🛡️ ANTI-AFK", function() local v = game:GetService("VirtualUser"); P.Idled:Connect(function() v:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame); task.wait(1); v:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end) end)
    AddBtn("❌ EXIT HUB", function() s:Destroy() end, Color3.fromRGB(50, 50, 50))
end)
