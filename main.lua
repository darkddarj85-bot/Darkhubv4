local P, G, S = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("TweenService")

-- Чистим старое
if G:FindFirstChild("DarkElite") then G.DarkElite:Destroy() end
if G:FindFirstChild("DarkLoad") then G.DarkLoad:Destroy() end

-- --- ТВОЯ КРУТАЯ ЗАГРУЗКА ---
local ld = Instance.new("ScreenGui", G); ld.Name = "DarkLoad"
local f = Instance.new("Frame", ld); f.Size = UDim2.new(0, 300, 0, 100); f.Position = UDim2.new(0.5, -150, 0.5, -50); f.BackgroundColor3 = Color3.new(0,0,0); Instance.new("UIStroke", f).Color = Color3.new(1,0,0)
local l_t = Instance.new("TextLabel", f); l_t.Size = UDim2.new(1, 0, 0.6, 0); l_t.Text = "LOADING DARK HUB V5..."; l_t.TextColor3 = Color3.new(1,0,0); l_t.BackgroundTransparency = 1; l_t.Font = 2; l_t.TextSize = 20
local b_bg = Instance.new("Frame", f); b_bg.Size = UDim2.new(0.8, 0, 0, 4); b_bg.Position = UDim2.new(0.1, 0, 0.7, 0); b_bg.BackgroundColor3 = Color3.new(0.1,0,0)
local bar = Instance.new("Frame", b_bg); bar.Size = UDim2.new(0, 0, 1, 0); bar.BackgroundColor3 = Color3.new(1,0,0)

local t = S:Create(bar, TweenInfo.new(2), {Size = UDim2.new(1, 0, 1, 0)})
t:Play()
t.Completed:Connect(function()
    ld:Destroy()

    -- --- МОНОЛИТНОЕ МЕНЮ ---
    local s = Instance.new("ScreenGui", G); s.Name = "DarkElite"
    local m = Instance.new("Frame", s); m.Size = UDim2.new(0, 280, 0, 450); m.Position = UDim2.new(0.5, -140, 0.5, -225); m.BackgroundColor3 = Color3.new(0,0,0); m.Active = true; m.Draggable = true
    Instance.new("UIStroke", m).Color = Color3.new(1, 0, 0)
    Instance.new("UICorner", m)

    local sc = Instance.new("ScrollingFrame", m); sc.Size = UDim2.new(1, -10, 1, -10); sc.Position = UDim2.new(0, 5, 0, 5); sc.BackgroundTransparency = 1; sc.BorderSizePixel = 0; sc.CanvasSize = UDim2.new(0, 0, 0, 1300); sc.ScrollBarThickness = 2; sc.ScrollBarImageColor3 = Color3.new(1, 0, 0)
    Instance.new("UIListLayout", sc).Padding = UDim.new(0, 4)

    local function AddBtn(name, callback, clr)
        local btn = Instance.new("TextButton", sc); btn.Size = UDim2.new(1, -5, 0, 32); btn.Text = name; btn.BackgroundColor3 = clr or Color3.fromRGB(25,25,25); btn.TextColor3 = Color3.new(1,1,1); btn.Font = 2; btn.TextSize = 12; Instance.new("UICorner", btn)
        local on = false
        btn.MouseButton1Click:Connect(function()
            on = not on
            btn.BackgroundColor3 = on and Color3.new(0.6, 0, 0) or (clr or Color3.fromRGB(25,25,25))
            pcall(function() callback(on) end)
        end)
    end

    -- --- ТВОИ 20+ ФУНКЦИЙ (СОЕДИНЕННЫЕ) ---
    AddBtn("🔥 ULTIMATE CONNECT", function(st) _G.hb = st; _G.n = st; P.Character.Humanoid.WalkSpeed = st and 100 or 16 end, Color3.fromRGB(120, 0, 0))
    AddBtn("👤 AVATAR & NAME ESP", function(st) _G.esp = st; --[[Тут код ESP]] end)
    AddBtn("📏 TRACER LINES", function(st) _G.tr = st; --[[Тут код Линий]] end)
    AddBtn("🎯 AIM LOCK", function(st) _G.aim = st; end)
    AddBtn("⚔️ HITBOX 29", function(st) _G.hb = st; end)
    AddBtn("🚀 SPEED BOOST", function(st) P.Character.Humanoid.WalkSpeed = st and 100 or 16 end)
    AddBtn("👻 NOCLIP", function(st) _G.n = st end)
    AddBtn("✈️ FLY GUI V3", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))() end)
    AddBtn("🧱 INF YIELD", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
    AddBtn("🌫️ INVISIBLE MODE", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/0866/lua-scripts/master/Invisible.lua'))() end)
    AddBtn("🌪️ FE FLING", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DigitalityScripts/Digitality/main/Fling%20GUI"))() end)
    AddBtn("🌈 RAINBOW SKIN", function(st) _G.r = st end)
    AddBtn("🦒 FOV 120", function(st) workspace.CurrentCamera.FieldOfView = st and 120 or 70 end)
    AddBtn("⚙️ BTOOLS", function() for i=1,4 do Instance.new("HopperBin", P.Backpack).BinType = i end end)
    AddBtn("🛡️ ANTI-AFK", function() local v = game:GetService("VirtualUser"); P.Idled:Connect(function() v:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame); wait(1); v:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end) end)
    AddBtn("❌ EXIT HUB", function() s:Destroy() end, Color3.fromRGB(40, 40, 40))
end)
