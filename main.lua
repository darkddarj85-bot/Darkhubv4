-- Создаем экранный интерфейс
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- Настройка GUI
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "RedBlackHub"

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Черный
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0) -- Красный
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -125)
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true -- Можно двигать

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Title.Text = "RED & BLACK HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

ScrollingFrame.Parent = MainFrame
ScrollingFrame.Position = UDim2.new(0, 0, 0, 30)
ScrollingFrame.Size = UDim2.new(1, 0, 1, -30)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
ScrollingFrame.ScrollBarThickness = 4

UIListLayout.Parent = ScrollingFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 5)

-- Функция для создания кнопок с анимацией
local function CreateButton(name, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = ScrollingFrame
    Button.Size = UDim2.new(0, 180, 0, 35)
    Button.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Text = name
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 12
    Button.AutoButtonColor = false

    -- Анимация наведения
    Button.MouseEnter:Connect(function()
        Button:TweenBackgroundColor3(Color3.fromRGB(255, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
    end)
    Button.MouseLeave:Connect(function()
        Button:TweenBackgroundColor3(Color3.fromRGB(40, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
    end)

    Button.MouseButton1Click:Connect(callback)
end

--- Функции чита ---

CreateButton("Fly (Флай)", function()
    print("Fly активирован")
    -- Логика полета обычно требует BodyVelocity в HumanoidRootPart
end)

CreateButton("Invisibility (Инвиз)", function()
    local char = game.Players.LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("
