--[[
    ==================================================
    PROJECT: MONEYHUB PREMIUM GUI (Ultra Beautiful & Mobile Ability Fix)
    DESCRIPTION: Premium Glass UI, Smooth Gradients, No Strokes, Safe Escape to Vector3.new(-200.7, 675.7, 357.3), Smart Mobile Touch Skills & M1 Combos.
    COMPATIBILITY: Roblox Mobile Injectors
    ==================================================
]]

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- Безопасные координаты из вашего скриншота
local SAFE_COORDS = Vector3.new(-200.7, 675.7, 357.3)

-- Очистка старого GUI
if playerGui:FindFirstChild("MoneyHubGui") then
    playerGui.MoneyHubGui:Destroy()
end

-- Создание главного GUI контейнера
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MoneyHubGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if syn and syn.protect_gui then
    syn.protect_gui(screenGui)
    screenGui.Parent = CoreGui
elseif gethui then
    screenGui.Parent = gethui()
else
    screenGui.Parent = playerGui
end

local targetPosition = UDim2.new(0.5, -280, 0.5, -180)
local hiddenPosition = UDim2.new(0.5, -280, 0.5, 300)

-- Главное окно (Ультра-стекло без обводок)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 560, 0, 360)
mainFrame.Position = hiddenPosition
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 26)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 18)
mainCorner.Parent = mainFrame

-- Градиент фона окна
local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 15, 55)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(16, 10, 28)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 5, 14))
})
mainGradient.Rotation = 120
mainGradient.Parent = mainFrame

-- Верхняя неоновая акцентная полоска
local accentLine = Instance.new("Frame")
accentLine.Name = "AccentLine"
accentLine.Size = UDim2.new(1, 0, 0, 3)
accentLine.Position = UDim2.new(0, 0, 0, 0)
accentLine.BorderSizePixel = 0
accentLine.ZIndex = 5
accentLine.Parent = mainFrame

local accentGradient = Instance.new("UIGradient")
accentGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 30, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 230, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 30, 255))
})
accentGradient.Parent = accentLine

-- Пыль
local particleContainer = Instance.new("Frame")
particleContainer.Name = "ParticleContainer"
particleContainer.Size = UDim2.new(1, 0, 1, 0)
particleContainer.BackgroundTransparency = 1
particleContainer.ZIndex = 1
particleContainer.Parent = mainFrame

local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, 0, 1, 0)
contentContainer.BackgroundTransparency = 1
contentContainer.ZIndex = 2
contentContainer.Parent = mainFrame

-- Верхняя панель
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 50)
topBar.BackgroundTransparency = 1
topBar.ZIndex = 2
topBar.Parent = contentContainer

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0, 260, 1, 0)
titleLabel.Position = UDim2.new(0, 22, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "MONEYHUB  ✦  PREMIUM"
titleLabel.TextColor3 = Color3.fromRGB(240, 225, 255)
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 2
titleLabel.Parent = topBar

-- Кнопка закрытия (×)
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -44, 0.5, -16)
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 45)
closeBtn.BackgroundTransparency = 0.3
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 120, 130)
closeBtn.TextSize = 22
closeBtn.Font = Enum.Font.GothamBold
closeBtn.ZIndex = 3
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeBtn

-- Кнопка сворачивания (−)
local minBtn = Instance.new("TextButton")
minBtn.Name = "MinimizeButton"
minBtn.Size = UDim2.new(0, 32, 0, 32)
minBtn.Position = UDim2.new(1, -84, 0.5, -16)
minBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 60)
minBtn.BackgroundTransparency = 0.3
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(220, 220, 235)
minBtn.TextSize = 18
minBtn.Font = Enum.Font.GothamBold
minBtn.ZIndex = 3
minBtn.Parent = topBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 10)
minCorner.Parent = minBtn

-- Сайдбар слева
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 150, 1, -64)
sidebar.Position = UDim2.new(0, 14, 0, 52)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 14, 34)
sidebar.BackgroundTransparency = 0.4
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 2
sidebar.Parent = contentContainer

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 14)
sidebarCorner.Parent = sidebar

-- Вкладка Main
local mainTabBtn = Instance.new("TextButton")
mainTabBtn.Name = "MainTabButton"
mainTabBtn.Size = UDim2.new(1, -16, 0, 42)
mainTabBtn.Position = UDim2.new(0, 8, 0, 12)
mainTabBtn.BackgroundColor3 = Color3.fromRGB(135, 45, 235)
mainTabBtn.BackgroundTransparency = 0.15
mainTabBtn.Text = "  Main Functions"
mainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mainTabBtn.TextSize = 13
mainTabBtn.Font = Enum.Font.GothamBold
mainTabBtn.TextXAlignment = Enum.TextXAlignment.Left
mainTabBtn.ZIndex = 3
mainTabBtn.Parent = sidebar

local mainTabCorner = Instance.new("UICorner")
mainTabCorner.CornerRadius = UDim.new(0, 10)
mainTabCorner.Parent = mainTabBtn

local mainTabGrad = Instance.new("UIGradient")
mainTabGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 50, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 25, 180))
})
mainTabGrad.Parent = mainTabBtn

-- Рабочая область справа
local mainContentArea = Instance.new("Frame")
mainContentArea.Name = "MainContentArea"
mainContentArea.Size = UDim2.new(1, -184, 1, -68)
mainContentArea.Position = UDim2.new(0, 174, 0, 54)
mainContentArea.BackgroundTransparency = 1
mainContentArea.ZIndex = 2
mainContentArea.Parent = contentContainer

-- Красивая карточка-контейнер для Auto Farm
local functionCard = Instance.new("Frame")
functionCard.Name = "FunctionCard"
functionCard.Size = UDim2.new(1, 0, 0, 80)
functionCard.Position = UDim2.new(0, 0, 0, 0)
functionCard.BackgroundColor3 = Color3.fromRGB(22, 16, 38)
functionCard.BackgroundTransparency = 0.3
functionCard.BorderSizePixel = 0
functionCard.ZIndex = 2
functionCard.Parent = mainContentArea

local cardCorner = Instance.new("UICorner")
cardCorner.CornerRadius = UDim.new(0, 12)
cardCorner.Parent = functionCard

local cardTitle = Instance.new("TextLabel")
cardTitle.Size = UDim2.new(1, -20, 0, 24)
cardTitle.Position = UDim2.new(0, 14, 0, 10)
cardTitle.BackgroundTransparency = 1
cardTitle.Font = Enum.Font.GothamBold
cardTitle.Text = "Auto Farm"
cardTitle.TextColor3 = Color3.fromRGB(225, 210, 255)
cardTitle.TextSize = 14
cardTitle.TextXAlignment = Enum.TextXAlignment.Left
cardTitle.ZIndex = 3
cardTitle.Parent = functionCard

-- Кнопка Auto Farm (Черный OFF / Ярко-зеленый ON)
local autoFarmEnabled = false

local autoFarmBtn = Instance.new("TextButton")
autoFarmBtn.Name = "AutoFarmButton"
autoFarmBtn.Size = UDim2.new(1, -28, 0, 34)
autoFarmBtn.Position = UDim2.new(0, 14, 0, 36)
autoFarmBtn.BackgroundColor3 = Color3.fromRGB(18, 14, 26)
autoFarmBtn.BackgroundTransparency = 0.2
autoFarmBtn.Text = "  Status: OFF"
autoFarmBtn.TextColor3 = Color3.fromRGB(160, 160, 175)
autoFarmBtn.TextSize = 12
autoFarmBtn.Font = Enum.Font.GothamBold
autoFarmBtn.TextXAlignment = Enum.TextXAlignment.Left
autoFarmBtn.ZIndex = 3
autoFarmBtn.Parent = functionCard

local autoFarmCorner = Instance.new("UICorner")
autoFarmCorner.CornerRadius = UDim.new(0, 8)
autoFarmCorner.Parent = autoFarmBtn

-- Настоящая серверная невидимость
local desyncConnection = nil
local function toggleServerDesync(state)
    if state then
        desyncConnection = RunService.Heartbeat:Connect(function()
            if autoFarmEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.Velocity = Vector3.new(0, -1000, 0)
            end
        end)
    else
        if desyncConnection then
            desyncConnection:Disconnect()
            desyncConnection = nil
        end
    end
end

autoFarmBtn.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    if autoFarmEnabled then
        autoFarmBtn.Text = "  Status: ON"
        autoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TweenService:Create(autoFarmBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(0, 200, 90)}):Play()
        toggleServerDesync(true)
    else
        autoFarmBtn.Text = "  Status: OFF"
        autoFarmBtn.TextColor3 = Color3.fromRGB(160, 160, 175)
        TweenService:Create(autoFarmBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(18, 14, 26)}):Play()
        toggleServerDesync(false)
    end
end)

-- Поиск мобильной кнопки PunchButton
local function getTouchButton(nameKeyword)
    for _, gui in ipairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name ~= "MoneyHubGui" then
            for _, btn in ipairs(gui:GetDescendants()) do
                if (btn:IsA("ImageButton") or btn:IsA("TextButton")) and btn.Visible then
                    local name = btn.Name:lower()
                    local text = btn:IsA("TextButton") and btn.Text:lower() or ""
                    if name:find(nameKeyword) or text:find(nameKeyword) then
                        return btn
                    end
                end
            end
        end
    end
    return nil
end

local currentTarget = nil
local isEvadingDamage = false

local function getNextTarget()
    local validPlayers = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
            if p.Character.Humanoid.Health > 0 then
                table.insert(validPlayers, p)
            end
        end
    end

    if #validPlayers > 0 then
        return validPlayers[math.random(1, #validPlayers)]
    end
    return nil
end

-- Безопасный телепорт в точные координаты SAFE_COORDS при получении урона
local lastHealth = 100
player.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid", 5)
    if humanoid then
        lastHealth = humanoid.Health
        humanoid.HealthChanged:Connect(function(newHealth)
            if autoFarmEnabled and not isEvadingDamage then
                if newHealth < lastHealth then
                    isEvadingDamage = true
                    task.spawn(function()
                        pcall(function()
                            local root = char:FindFirstChild("HumanoidRootPart")
                            if root then
                                local safePos = root.CFrame
                                root.CFrame = CFrame.new(SAFE_COORDS)
                                task.wait(2.0)
                                root.CFrame = safePos
                            end
                        end)
                        isEvadingDamage = false
                    end)
                end
                lastHealth = newHealth
            end
        end)
    end
end)

if player.Character and player.Character:FindFirstChild("Humanoid") then
    local humanoid = player.Character.Humanoid
    lastHealth = humanoid.Health
    humanoid.HealthChanged:Connect(function(newHealth)
        if autoFarmEnabled and not isEvadingDamage then
            if newHealth < lastHealth then
                isEvadingDamage = true
                task.spawn(function()
                    pcall(function()
                        local root = player.Character:FindFirstChild("HumanoidRootPart")
                        if root then
                            local safePos = root.CFrame
                            root.CFrame = CFrame.new(SAFE_COORDS)
                            task.wait(2.0)
                            root.CFrame = safePos
                        end
                    end)
                    isEvadingDamage = false
                end)
            end
            lastHealth = newHealth
        end
    end)
end

-- Следование за спиной + Аимлок
RunService.RenderStepped:Connect(function()
    if not autoFarmEnabled or isEvadingDamage then return end
    
    local char = player.Character
    if not char then return end
    local myRoot = char:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    if not currentTarget or not currentTarget.Character or not currentTarget.Character:FindFirstChild("HumanoidRootPart") or not currentTarget.Character:FindFirstChild("Humanoid") or currentTarget.Character.Humanoid.Health <= 0 then
        currentTarget = getNextTarget()
    end

    if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild("HumanoidRootPart") then
        local enemyRoot = currentTarget.Character.HumanoidRootPart
        local backPos = enemyRoot.CFrame * CFrame.new(0, 0, 2)
        
        myRoot.CFrame = CFrame.lookAt(backPos.Position, enemyRoot.Position)
        camera.CFrame = CFrame.lookAt(camera.CFrame.Position, enemyRoot.Position)
    end
end)

-- Мобильный удар M1
local function executeInstantM1()
    pcall(function()
        local punchBtn = getTouchButton("punch") or getTouchButton("attack") or getTouchButton("m1")
        if punchBtn then
            firesignal(punchBtn.MouseButton1Down)
            firesignal(punchBtn.Activated)
            firesignal(punchBtn.MouseButton1Up)
        end

        for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                local name = obj.Name:lower()
                if name:find("comm") or name:find("event") or name:find("punch") or name:find("m1") then
                    obj:FireServer({Goal = "LeftClick"})
                    obj:FireServer("LeftClick")
                    obj:FireServer("Punch")
                end
            end
        end
    end)
end

-- Мобильное нажатие способностей (1, 2, 3, 4) через поиск кнопок на экране телефона
local function executeInstantSkill(skillNumber)
    pcall(function()
        local skillBtn = getTouchButton(tostring(skillNumber))
        if skillBtn then
            firesignal(skillBtn.MouseButton1Down)
            firesignal(skillBtn.Activated)
            firesignal(skillBtn.MouseButton1Up)
        end

        for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                local name = obj.Name:lower()
                if name:find("comm") or name:find("event") then
                    obj:FireServer({Goal = "KeyPress", Key = skillNumber})
                    obj:FireServer("KeyPress", skillNumber)
                end
            end
        end
    end)
end

-- Умный боевой цикл с проверкой дистанции
task.spawn(function()
    while true do
        task.wait(0.05)
        if autoFarmEnabled and currentTarget and not isEvadingDamage then
            pcall(function()
                local char = player.Character
                local enemyChar = currentTarget.Character
                if not char or not enemyChar then return end
                
                local myRoot = char:FindFirstChild("HumanoidRootPart")
                local enemyRoot = enemyChar:FindFirstChild("HumanoidRootPart")
                if not myRoot or not enemyRoot then return end

                for i = 1, 4 do
                    if not autoFarmEnabled or isEvadingDamage or not currentTarget then break end
                    
                    local dist = (myRoot.Position - enemyRoot.Position).Magnitude
                    if dist > 7 then 
                        break 
                    end

                    executeInstantM1()
                    task.wait(0.08)
                end

                if not autoFarmEnabled or isEvadingDamage or not currentTarget then return end

                executeInstantSkill(1)
                task.wait(0.15)

                if not autoFarmEnabled or isEvadingDamage or not currentTarget then return end

                executeInstantSkill(2)
                task.wait(0.1)
                executeInstantSkill(2)

                task.wait(0.3)
            end)
        else
            task.wait(0.4)
        end
    end
end)

-- Красивая плавающая кнопка
local floatBtn = Instance.new("TextButton")
floatBtn.Name = "FloatingButton"
floatBtn.Size = UDim2.new(0, 140, 0, 42)
floatBtn.Position = UDim2.new(0.5, -70, 0, -60)
floatBtn.BackgroundColor3 = Color3.fromRGB(28, 16, 48)
floatBtn.BackgroundTransparency = 0.15
floatBtn.Text = "MONEYHUB"
floatBtn.TextColor3 = Color3.fromRGB(245, 220, 255)
floatBtn.TextSize = 13
floatBtn.Font = Enum.Font.GothamBold
floatBtn.Visible = false
floatBtn.ZIndex = 100
floatBtn.Parent = screenGui

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(0, 21)
floatCorner.Parent = floatBtn

local floatGrad = Instance.new("UIGradient")
floatGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 45, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(65, 20, 120))
})
floatGrad.Parent = floatBtn

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

local function animateOpen()
    mainFrame.Position = hiddenPosition
    mainFrame.BackgroundTransparency = 1
    TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = targetPosition, BackgroundTransparency = 0.05}):Play()
end

minBtn.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = hiddenPosition, BackgroundTransparency = 1}):Play()
    task.wait(0.3)
    mainFrame.Visible = false
    floatBtn.Visible = true
    floatBtn.Position = UDim2.new(0.5, -70, 0, -60)
    TweenService:Create(floatBtn, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -70, 0.05, 0)}):Play()
end)

floatBtn.MouseButton1Click:Connect(function()
    TweenService:Create(floatBtn, TweenInfo.new(0.2), {Position = UDim2.new(0.5, -70, 0, -60)}):Play()
    task.wait(0.2)
    floatBtn.Visible = false
    mainFrame.Visible = true
    animateOpen()
end)

closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 1}):Play()
    task.wait(0.35)
    screenGui:Destroy()
end)

animateOpen()

-- Медленная мерцающая пыль
local maxParticles = 20
local particles = {}

for i = 1, maxParticles do
    local particle = Instance.new("Frame")
    local size = math.random(2, 5)
    particle.Size = UDim2.new(0, size, 0, size)
    particle.BackgroundColor3 = Color3.fromRGB(225, 190, 255)
    particle.BackgroundTransparency = math.random(40, 80) / 100
    particle.BorderSizePixel = 0
    particle.ZIndex = 1
    particle.Parent = particleContainer

    local pCorner = Instance.new("UICorner")
    pCorner.CornerRadius = UDim.new(1, 0)
    pCorner.Parent = particle

    table.insert(particles, {
        instance = particle,
        x = math.random(),
        y = math.random(),
        speed = math.random(2, 6) / 10000
    })
end

RunService.RenderStepped:Connect(function(dt)
    if not screenGui.Parent or not mainFrame.Visible then return end
    
    local scaledDt = dt * 60
    for _, p in ipairs(particles) do
        p.y = p.y + (p.speed * scaledDt)
        if p.y > 1.05 then
            p.y = -0.05
            p.x = math.random()
            p.speed = math.random(2, 6) / 10000
        end
        p.instance.Position = UDim2.new(p.x, 0, p.y, 0)
    end
end)
