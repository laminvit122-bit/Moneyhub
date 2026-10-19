--[[
    ==================================================
    PROJECT: MONEYHUB PREMIUM GUI (Ultra Beautiful & Safe Escape Edition)
    DESCRIPTION: Stunning Glass UI, Smooth Animated Gradients, No Strokes, Safe Sky Escape on Damage (No Void Death), Smart Distance Combo & Mobile Optimized.
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
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 8, 16)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

-- Красивый переливающийся градиент фона
local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 14, 45)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 10, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 5, 12))
})
mainGradient.Rotation = 135
mainGradient.Parent = mainFrame

-- Пыль (задний план)
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
topBar.Size = UDim2.new(1, 0, 0, 48)
topBar.BackgroundTransparency = 1
topBar.ZIndex = 2
topBar.Parent = contentContainer

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0, 250, 1, 0)
titleLabel.Position = UDim2.new(0, 20, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "MONEYHUB  •  PREMIUM"
titleLabel.TextColor3 = Color3.fromRGB(235, 215, 255)
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 2
titleLabel.Parent = topBar

-- Кнопка закрытия (×)
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -44, 0.5, -16)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 40)
closeBtn.BackgroundTransparency = 0.4
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 110, 110)
closeBtn.TextSize = 20
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
minBtn.BackgroundColor3 = Color3.fromRGB(35, 20, 50)
minBtn.BackgroundTransparency = 0.4
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(210, 210, 210)
minBtn.TextSize = 16
minBtn.Font = Enum.Font.GothamBold
minBtn.ZIndex = 3
minBtn.Parent = topBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 10)
minCorner.Parent = minBtn

-- Сайдбар слева
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 150, 1, -62)
sidebar.Position = UDim2.new(0, 14, 0, 54)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 12, 30)
sidebar.BackgroundTransparency = 0.5
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 2
sidebar.Parent = contentContainer

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 12)
sidebarCorner.Parent = sidebar

-- Вкладка Main
local mainTabBtn = Instance.new("TextButton")
mainTabBtn.Name = "MainTabButton"
mainTabBtn.Size = UDim2.new(1, -16, 0, 40)
mainTabBtn.Position = UDim2.new(0, 8, 0, 12)
mainTabBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 210)
mainTabBtn.BackgroundTransparency = 0.2
mainTabBtn.Text = "   Main Functions"
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
    ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 50, 240)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 20, 170))
})
mainTabGrad.Parent = mainTabBtn

-- Рабочая зона контента
local mainContentArea = Instance.new("Frame")
mainContentArea.Name = "MainContentArea"
mainContentArea.Size = UDim2.new(1, -182, 1, -68)
mainContentArea.Position = UDim2.new(0, 174, 0, 58)
mainContentArea.BackgroundTransparency = 1
mainContentArea.ZIndex = 2
mainContentArea.Parent = contentContainer

local tabTitle = Instance.new("TextLabel")
tabTitle.Size = UDim2.new(1, 0, 0, 25)
tabTitle.BackgroundTransparency = 1
tabTitle.Font = Enum.Font.GothamBold
tabTitle.Text = "Combat Automation"
tabTitle.TextColor3 = Color3.fromRGB(220, 200, 255)
tabTitle.TextSize = 14
tabTitle.TextXAlignment = Enum.TextXAlignment.Left
tabTitle.ZIndex = 2
tabTitle.Parent = mainContentArea

-- Кнопка Auto Farm (Черный/Зеленый индикатор)
local autoFarmEnabled = false

local autoFarmBtn = Instance.new("TextButton")
autoFarmBtn.Name = "AutoFarmButton"
autoFarmBtn.Size = UDim2.new(1, 0, 0, 46)
autoFarmBtn.Position = UDim2.new(0, 0, 0, 34)
autoFarmBtn.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
autoFarmBtn.BackgroundTransparency = 0.3
autoFarmBtn.Text = "  Auto Farm: OFF"
autoFarmBtn.TextColor3 = Color3.fromRGB(160, 160, 175)
autoFarmBtn.TextSize = 13
autoFarmBtn.Font = Enum.Font.GothamMedium
autoFarmBtn.TextXAlignment = Enum.TextXAlignment.Left
autoFarmBtn.ZIndex = 2
autoFarmBtn.Parent = mainContentArea

local autoFarmCorner = Instance.new("UICorner")
autoFarmCorner.CornerRadius = UDim.new(0, 10)
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
        autoFarmBtn.Text = "  Auto Farm: ON"
        autoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TweenService:Create(autoFarmBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(0, 190, 85)}):Play()
        toggleServerDesync(true)
    else
        autoFarmBtn.Text = "  Auto Farm: OFF"
        autoFarmBtn.TextColor3 = Color3.fromRGB(160, 160, 175)
        TweenService:Create(autoFarmBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(22, 18, 32)}):Play()
        toggleServerDesync(false)
    end
end)

-- Поиск мобильного PunchButton
local function getTouchPunchButton()
    local touchGui = playerGui:FindFirstChild("TouchGui")
    if touchGui then
        local frame = touchGui:FindFirstChild("TouchControlFrame")
        if frame then
            local btn = frame:FindFirstChild("PunchButton")
            if btn then return btn end
        end
    end
    for _, gui in ipairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name ~= "MoneyHubGui" then
            local btn = gui:FindFirstChild("PunchButton", true)
            if btn then return btn end
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

-- БЕЗОПАСНАЯ СИСТЕМА УХОДА ОТ УРОНА (Телепорт в небо Y = 500 вместо пустоты)
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
                                -- Телепортируемся высоко в небо (безопасно от kill-зон под картой)
                                root.CFrame = CFrame.new(safePos.X, 500, safePos.Z)
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
                            root.CFrame = CFrame.new(safePos.X, 500, safePos.Z)
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

-- Выполнение удара M1
local function executeInstantM1()
    pcall(function()
        local punchBtn = getTouchPunchButton()
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

-- Выполнение способности
local function executeInstantSkill(skillNumber)
    pcall(function()
        for _, gui in ipairs(playerGui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Name ~= "MoneyHubGui" then
                for _, btn in ipairs(gui:GetDescendants()) do
                    if (btn:IsA("ImageButton") or btn:IsA("TextButton")) and btn.Visible then
                        local text = btn:IsA("TextButton") and btn.Text or ""
                        local name = btn.Name
                        if text == tostring(skillNumber) or name == tostring(skillNumber) then
                            firesignal(btn.Activated)
                        end
                    end
                end
            end
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

-- Умный боевой цикл с проверкой дистанции и пропуском пустых ударов
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

                -- 4 удара с проверкой дистанции (если промахнулся — сразу прерываем серию и переходим к скиллам!)
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
floatBtn.BackgroundColor3 = Color3.fromRGB(25, 15, 40)
floatBtn.BackgroundTransparency = 0.2
floatBtn.Text = "MONEYHUB"
floatBtn.TextColor3 = Color3.fromRGB(240, 210, 255)
floatBtn.TextSize = 14
floatBtn.Font = Enum.Font.GothamBold
floatBtn.Visible = false
floatBtn.ZIndex = 100
floatBtn.Parent = screenGui

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(0, 21)
floatCorner.Parent = floatBtn

local floatGrad = Instance.new("UIGradient")
floatGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 40, 220)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 20, 110))
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
    TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = targetPosition, BackgroundTransparency = 0.1}):Play()
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

-- Красивая медленная пыль
local maxParticles = 18
local particles = {}

for i = 1, maxParticles do
    local particle = Instance.new("Frame")
    local size = math.random(2, 5)
    particle.Size = UDim2.new(0, size, 0, size)
    particle.BackgroundColor3 = Color3.fromRGB(220, 180, 255)
    particle.BackgroundTransparency = math.random(40, 75) / 100
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
