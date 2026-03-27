local P, G = game.Players.LocalPlayer, game:GetService("CoreGui")

-- Удаляем старые меню, если они зависли
for _, v in pairs(G:GetChildren()) do
    if v.Name == "DarkElite" or v.Name == "DarkToggleGui" then v:Destroy() end
end

-- КНОПКА-ПЛЮСИК
local tg = Instance.new("ScreenGui", G); tg.Name = "DarkToggleGui"
local b = Instance.new("TextButton", tg)
b.Size = UDim2.new(0, 50, 0, 50); b.Position = UDim2.new(0, 10, 0.5, 0)
b.Text = "X"; b.BackgroundColor3 = Color3.new(0,0,0); b.TextColor3 = Color3.new(1,0,0)
b.Font = "SourceSansBold"; b.TextSize = 30; b.Draggable = true; b.Active = true
Instance.new("UIStroke", b).Color = Color3.new(1,0,0); Instance.new("UICorner", b)

-- ГЛАВНОЕ ОКНО
local s = Instance.new("ScreenGui", G); s.Name = "DarkElite"
local m = Instance.new("Frame", s); m.Size = UDim2.new(0, 260, 0, 350); m.Position = UDim2.new(0.5, -130, 0.5, -175); m.BackgroundColor3 = Color3.new(0,0,0); m.Visible = true
Instance.new("UIStroke", m).Color = Color3.new(1, 0, 0); Instance.new("UICorner", m)

b.MouseButton1Click:Connect(function()
    m.Visible = not m.Visible
    b.Text = m.Visible and "X" or "+"
    b.TextColor3 = m.Visible and Color3.new(1,0,0) or Color3.new(0,1,0)
end)

local sc = Instance.new("ScrollingFrame", m); sc.Size = UDim2.new(1, -10, 1, -10); sc.Position = UDim2.new(0, 5, 0, 5); sc.BackgroundTransparency = 1; sc.CanvasSize = UDim2.new(0, 0, 0, 800)
Instance.new("UIListLayout", sc).Padding = UDim.new(0, 4)

local function Add(txt, fn)
    local btn = Instance.new("TextButton", sc); btn.Size = UDim2.new(1, -5, 0, 35); btn.Text = txt; btn.BackgroundColor3 = Color3.fromRGB(30,30,30); btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 12; Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() pcall(fn) end)
end

-- ФУНКЦИИ
Add("🔍 ZOOM CLICK", function() _G.ZC = not _G.ZC; P:GetMouse().Button2Down:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 20 end end); P:GetMouse().Button2Up:Connect(function() if _G.ZC then workspace.CurrentCamera.FieldOfView = 70 end end) end)
Add("🌫️ INVISIBLE (FIXED)", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/0866/lua-scripts/master/Invisible.lua'))() end)
Add("🚀 SUPER JUMP", function() P.Character.Humanoid.JumpPower = 200; P.Character.Humanoid.UseJumpPower = true end)
Add("📍 TP TO PLAYER", function() local all = game.Players:GetPlayers(); local r = all[math.random(1,#all)]; if r.Character then P.Character.HumanoidRootPart.CFrame = r.Character.HumanoidRootPart.CFrame end end)
Add("❌ CLOSE HUB", function() s:Destroy(); tg:Destroy() end)
