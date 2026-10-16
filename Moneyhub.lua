--[[
    ==================================================
    PROJECT: MONEYHUB PREMIUM GUI (Injector Version)
    DESCRIPTION: Modern Glass UI with falling snow/dust particles.
    COMPATIBILITY: Roblox Injectors / Exploits (Luau)
    ==================================================
]]

-- Ожидание полной загрузки игры
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Безопасное удаление предыдущей копии скрипта, если она уже была запущена
if playerGui:FindFirstChild("MoneyHubGui") then
    playerGui.MoneyHubGui:Destroy()
end

-- Создание главного контейнера ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MoneyHubGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Защита GUI от обнаружения некоторыми античитами (опционально для инжекторов)
if syn and syn.protect_gui then
    syn.protect_gui(screenGui)
    screenGui.Parent = CoreGui
elseif gethui then
    screenGui.Parent = gethui()
else
    screenGui.Parent = playerGui
end

-- Главное окно интерфейса (Main Frame)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 340)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 10, 20) -- Глубокий чёрно-фиолетовый фон
mainFrame.BackgroundTransparency = 0.1 -- Ровно 10% прозрачности
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Скругление углов главного окна
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

-- Тонкая фиолетовая обводка (UIStroke)
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(138, 43, 226)
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.3
mainStroke.Parent = mainFrame

-- Премиальный градиент фона
local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 16, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 6, 12))
})
mainGradient.Rotation = 45
mainGradient.Parent = mainFrame

-- Контейнер для частиц (снег/пыль) — находится строго позади контента (ZIndex = 1)
local particleContainer = Instance.new("Frame")
particleContainer.Name = "ParticleContainer"
particleContainer.Size = UDim2.new(1, 0, 1, 0)
particleContainer.BackgroundTransparency = 1
particleContainer.ZIndex = 1
particleContainer.Parent = mainFrame

-- Контейнер для основного содержимого (ZIndex = 2)
local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, 0, 1, 0)
contentContainer.BackgroundTransparency = 1
contentContainer.ZIndex = 2
contentContainer.Parent = mainFrame

-- Верхняя панель (TopBar) для перетаскивания и кнопок управления
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 50)
topBar.BackgroundTransparency = 1
topBar.ZIndex = 2
topBar.Parent = contentContainer

-- Название интерфейса
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0, 200, 1, 0)
titleLabel.Position = UDim2.new(0, 18, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "MONEYHUB"
titleLabel.TextColor3 = Color3.fromRGB(240, 225, 255)
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 2
titleLabel.Parent = topBar

-- Кнопка закрытия (×)
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -42, 0.5, -16)
closeBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 55)
closeBtn.BackgroundTransparency = 0.5
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.TextSize = 22
closeBtn.Font = Enum.Font.GothamBold
closeBtn.ZIndex = 3
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

-- Кнопка сворачивания (−)
local minBtn = Instance.new("TextButton")
minBtn.Name = "MinimizeButton"
minBtn.Size = UDim2.new(0, 32, 0, 32)
minBtn.Position = UDim2.new(1, -82, 0.5, -16)
minBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 55)
minBtn.BackgroundTransparency = 0.5
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minBtn.TextSize = 18
minBtn.Font = Enum.Font.GothamBold
minBtn.ZIndex = 3
minBtn.Parent = topBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minBtn

-- Информационный текст-приветствие внутри интерфейса
local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(1, -36, 0, 120)
welcomeLabel.Position = UDim2.new(0, 18, 0, 70)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Font = Enum.Font.GothamMedium
welcomeLabel.Text = "Добро пожаловать в MONEYHUB\n\nИнтерфейс успешно инжектирован.\nВсе системы работают в штатном режиме."
welcomeLabel.TextColor3 = Color3.fromRGB(180, 165, 205)
welcomeLabel.TextSize = 14
welcomeLabel.TextWrapped = true
welcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
welcomeLabel.TextYAlignment = Enum.TextYAlignment.Top
welcomeLabel.ZIndex = 2
welcomeLabel.Parent = contentContainer

-- Плавающая кнопка для разворачивания (при свёрнутом окне)
local floatBtn = Instance.new("TextButton")
floatBtn.Name = "FloatingButton"
floatBtn.Size = UDim2.new(0, 140, 0, 42)
floatBtn.Position = UDim2.new(0.5, -70, 0.05, 0)
floatBtn.BackgroundColor3 = Color3.fromRGB(15, 12, 25)
floatBtn.BackgroundTransparency = 0.2
floatBtn.Text = "MONEYHUB"
floatBtn.TextColor3 = Color3.fromRGB(230, 200, 255)
floatBtn.TextSize = 14
floatBtn.Font = Enum.Font.GothamBold
floatBtn.Visible = false
floatBtn.ZIndex = 10
floatBtn.Parent = screenGui

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(0, 21)
floatCorner.Parent = floatBtn

local floatStroke = Instance.new("UIStroke")
floatStroke.Color = Color3.fromRGB(138, 43, 226)
floatStroke.Thickness = 1.5
floatStroke.Parent = floatBtn

-- ==========================================
-- ЛОГИКА ПЕРЕТАСКИВАНИЯ (ПК и ТЕЛЕФОНЫ)
-- ==========================================
local function enableDragging(frame, handle)
    local dragging, dragInput, dragStart, startPos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

enableDragging(mainFrame, topBar)
enableDragging(floatBtn, floatBtn)

-- ==========================================
-- УПРАВЛЕНИЕ ОКНОМ (СВОРАЧИВАНИЕ И ЗАКРЫТИЕ)
-- ==========================================
minBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    floatBtn.Visible = true
end)

floatBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    floatBtn.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Анимация при наведении на кнопки управления
local function setupHover(btn)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
    end)
end
setupHover(closeBtn)
setupHover(minBtn)

-- ==========================================
-- СИСТЕМА ПАДАЮЩЕГО СНЕГА И СВЕТЯЩЕЙСЯ ПЫЛИ
-- ==========================================
local maxParticles = 22 -- Оптимальный лимит для производительности
local particles = {}
local active = true

-- Очистка при уничтожении GUI
screenGui.Destroying:Connect(function()
    active = false
end)

-- Спавн новых частиц с интервалом
task.spawn(function()
    while active do
        task.wait(0.4)
        if not active then break end
        
        if #particles < maxParticles and mainFrame.Visible then
            local particle = Instance.new("Frame")
            local size = math.random(3, 6)
            particle.Size = UDim2.new(0, size, 0, size)
            particle.Position = UDim2.new(math.random(), 0, 0, -10)
            particle.BackgroundColor3 = Color3.new(1, 1, 1)
            particle.BackgroundTransparency = math.random(35, 75) / 100
            particle.BorderSizePixel = 0
            particle.ZIndex = 1
            particle.Parent = particleContainer

            local pCorner = Instance.new("UICorner")
            pCorner.CornerRadius = UDim.new(1, 0)
            pCorner.Parent = particle

            table.insert(particles, {
                instance = particle,
                speed = math.random(12, 28) / 10,        -- Скорость падения
                swaySpeed = math.random(2, 5),          -- Частота покачивания
                swayAmount = math.random(8, 25),        -- Амплитуда покачивания
                startTime = tick(),
                initialX = particle.Position.X.Scale
            })
        end
    end
end)

-- Плавное обновление движения частиц через RenderStepped
RunService.RenderStepped:Connect(function()
    if not active or not screenGui.Parent then return end
    
    local currentTime = tick()
    for i = #particles, 1, -1 do
        local pData = particles[i]
        if pData.instance and pData.instance.Parent then
            local elapsed = currentTime - pData.startTime
            local currentY = (elapsed * pData.speed) / mainFrame.AbsoluteSize.Y
            local sway = math.sin(elapsed * pData.swaySpeed) * (pData.swayAmount / mainFrame.AbsoluteSize.X)
            
            -- Если частица долетела до низа — удаляем её
            if currentY > 1.05 then
                pData.instance:Destroy()
                table.remove(particles, i)
            else
                pData.instance.Position = UDim2.new(pData.initialX + sway, 0, currentY, 0)
            end
        else
            table.remove(particles, i)
        end
    end
end)
