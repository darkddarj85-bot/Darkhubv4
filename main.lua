-- DARK HUB V5 (MOBILE & PC)
local P, G = game.Players.LocalPlayer, game:GetService("CoreGui")

-- ЧИСТИМ СТАРЬЁ
if G:FindFirstChild("DarkElite") then G.DarkElite:Destroy() end
if G:FindFirstChild("DarkToggleGui") then G.DarkToggleGui:Destroy() end

-- --- 1. КНОПКА-ПЛЮСИК (ПОЯВИТСЯ СРАЗУ) ---
local tg = Instance.new("ScreenGui", G); tg.Name = "DarkToggleGui"
local b = Instance.new("TextButton", tg)
b.Size = UDim2.new(0, 50, 0, 50); b.Position = UDim2.new(0, 20, 0.4, 0)
b.Text = "X"; b.BackgroundColor3 = Color3.new(0,0,0); b.TextColor3 = Color3.new(1,0,0)
b.Font = "SourceSansBold"; b.TextSize = 35; b.Draggable = true; b.Active = true
Instance.new("UIStroke", b).Color = Color3.new(1,0,0)
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

-- --- 2. ГЛАВНОЕ ОКНО ---
local s = Instance.new("ScreenGui", G); s.Name = "DarkElite"
local m = Instance.new("Frame", s)
m.Size = UDim2.new(0, 260, 0, 400); m.Position = UDim2.new(0.5, -130, 0.5, -200)
m.BackgroundColor3 = Color3.new(0,0,0); m.Active = true; m.Draggable = true; m.Visible = true
Instance.new("UIStroke", m).Color = Color3.new(1, 0, 0); Instance.new("UICorner", m)

-- ЛОГИКА СКРЫТИЯ
b.MouseButton1Click:Connect(function()
    m.Visible = not m.Visible
    b.Text = m.Visible and "X" or "+"
    b.TextColor3 = m.Visible and Color3.new(1,0,0) or Color3.new(0,1,0)
end)

-- --- 3. ФУНКЦИИ (ZOOM, INVIS, JUMP, TP) ---
local sc = Instance.new("ScrollingFrame", m); sc.Size = UDim2.new(1, -10, 1, -10); sc.Position = UDim2.new(0, 5, 0, 5); sc.BackgroundTransparency = 1; sc.CanvasSize = UDim2.new(0, 0, 0, 1200); sc.ScrollBarThickness = 2
Instance.new("UIListLayout", sc).Padding = UDim.new(0, 4)

local function Add(txt, fn, clr)
    local btn = Instance.new("TextButton", sc); btn.Size = UDim2.new(1, -5, 0, 35); btn.Text = txt; btn.BackgroundColor3 = clr or Color3.fromRGB(20,20,20); btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 11; Instance.new("UICorner", btn)
    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on; btn.BackgroundColor3 = on and Color3.new(0.6, 0, 0) or (clr or Color3.fromRGB(20,20,20))
        pcall(function() fn(on) end)
    end)
end

-- ТЕ САМЫЕ ЧИТЫ:
Add("🔍 ZOOM CLICK", function(on)
    _G.ZC = on
    P:GetMouse().Button2Down:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 20 end end)
    P:GetMouse().Button2Up:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 70 end end)
end)

Add("🌫️ INVISIBLE FIXED", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/0866/lua-scripts/master/Invisible.lua'))() end)

Add("🚀 SUPER JUMP (200)", function(on)
    P.Character.Humanoid.JumpPower = on and 200 or 5
