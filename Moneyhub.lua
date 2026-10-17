--[[
    ==================================================
    PROJECT: MONEYHUB PREMIUM GUI (Full & Complete)
    DESCRIPTION: Modern Glass UI, Smooth Animations, Green/Black Toggles, Shift Lock Auto-Face + Auto Block.
    COMPATIBILITY: Roblox Injectors / Exploits (PC & Mobile)
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
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

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

-- Главное окно (без обводки)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 560, 0, 360)
mainFrame.Position = hiddenPosition
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 10, 20)
mainFrame.BackgroundTransparency = 1
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 16, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 6, 12))
})
mainGradient.Rotation = 45
mainGradient.Parent = mainFrame

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
topBar.Size = UDim2.new(1, 0, 0, 45)
topBar.BackgroundTransparency = 1
topBar.ZIndex = 2
topBar.Parent = contentContainer

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

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 55)
closeBtn.BackgroundTransparency = 0.5
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.ZIndex = 3
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

local minBtn = Instance.new("TextButton")
minBtn.Name = "MinimizeButton"
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -76, 0.5, -15)
minBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 55)
minBtn.BackgroundTransparency = 0.5
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minBtn.TextSize = 16
minBtn.Font = Enum.Font.GothamBold
minBtn.ZIndex = 3
minBtn.Parent = topBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minBtn

-- Сайдбар
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 140, 1, -55)
sidebar.Position = UDim2.new(0, 12, 0, 50)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 14, 28)
sidebar.BackgroundTransparency = 0.4
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 2
sidebar.Parent = contentContainer

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 10)
sidebarCorner.Parent = sidebar

local mainTabBtn = Instance.new("TextButton")
mainTabBtn.Name = "MainTabButton"
mainTabBtn.Size = UDim2.new(1, -16, 0, 38)
mainTabBtn.Position = UDim2.new(0, 8, 0, 10)
mainTabBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
mainTabBtn.BackgroundTransparency = 0.3
mainTabBtn.Text = "  Main"
mainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mainTabBtn.TextSize = 14
mainTabBtn.Font = Enum.Font.GothamBold
mainTabBtn.TextXAlignment = Enum.TextXAlignment.Left
mainTabBtn.ZIndex = 3
mainTabBtn.Parent = sidebar

local mainTabCorner = Instance.new("UICorner")
mainTabCorner.CornerRadius = UDim.new(0, 8)
mainTabCorner.Parent = mainTabBtn

local mainContentArea = Instance.new("Frame")
mainContentArea.Name = "MainContentArea"
mainContentArea.Size = UDim2.new(1, -170, 1, -65)
mainContentArea.Position = UDim2.new(0, 160, 0, 55)
mainContentArea.BackgroundTransparency = 1
mainContentArea.ZIndex = 2
mainContentArea.Parent = contentContainer

local tabTitle = Instance.new("TextLabel")
tabTitle.Size = UDim2.new(1, 0, 0, 25)
tabTitle.BackgroundTransparency = 1
tabTitle.Font = Enum.Font.GothamBold
tabTitle.Text = "Main Functions"
tabTitle.TextColor3 = Color3.fromRGB(230, 215, 255)
tabTitle.TextSize = 15
tabTitle.TextXAlignment = Enum.TextXAlignment.Left
tabTitle.ZIndex = 2
tabTitle.Parent = mainContentArea

-- Кнопка Auto Block (ЧЁРНЫЙ / ЗЕЛЁНЫЙ)
local autoBlockEnabled = false

local autoBlockBtn = Instance.new("TextButton")
autoBlockBtn.Name = "AutoBlockButton"
autoBlockBtn.Size = UDim2.new(1, 0, 0, 42)
autoBlockBtn.Position = UDim2.new(0, 0, 0, 35)
autoBlockBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
autoBlockBtn.BackgroundTransparency = 0.3
autoBlockBtn.Text = "  Auto Block: OFF"
autoBlockBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
autoBlockBtn.TextSize = 13
autoBlockBtn.Font = Enum.Font.GothamMedium
autoBlockBtn.TextXAlignment = Enum.TextXAlignment.Left
autoBlockBtn.ZIndex = 2
autoBlockBtn.Parent = mainContentArea

local autoBlockCorner = Instance.new("UICorner")
autoBlockCorner.CornerRadius = UDim.new(0, 8)
autoBlockCorner.Parent = autoBlockBtn

autoBlockBtn.MouseButton1Click:Connect(function()
    autoBlockEnabled = not autoBlockEnabled
    if autoBlockEnabled then
        autoBlockBtn.Text = "  Auto Block: ON"
        autoBlockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TweenService:Create(autoBlockBtn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(0, 180, 80)}):Play()
    else
        autoBlockBtn.Text = "  Auto Block: OFF"
        autoBlockBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
        TweenService:Create(autoBlockBtn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(20, 20, 25)}):Play()
    end
end)

-- Поиск мобильной кнопки
local function getMobileBlockButton()
    for _, gui in ipairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name ~= "MoneyHubGui" then
            for _, btn in ipairs(gui:GetDescendants()) do
                if (btn:IsA("ImageButton") or btn:IsA("TextButton")) and btn.Visible then
                    if btn.Name:lower():find("block") or btn.Name:lower():find("defend") then
                        return btn
                    end
                end
            end
        end
    end
    return nil
end

local isBlockingNow = false

-- Точная функция блока под реальный удар + разворот в Shift Lock
local function doBlock(enemyRoot)
    if isBlockingNow then return end
    isBlockingNow = true

    task.spawn(function()
        pcall(function()
            -- Разворот перса и камеры к врагу (работает даже в Shift Lock)
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root and enemyRoot then
                    local targetPos = Vector3.new(enemyRoot.Position.X, root.Position.Y, enemyRoot.Position.Z)
                    local lookCFrame = CFrame.lookAt(root.Position, targetPos)
                    
                    -- Поворачиваем сам RootPart
                    root.CFrame = lookCFrame
                    
                    -- Принудительно разворачиваем камеру для обхода ограничений Shift Lock
                    local camera = workspace.CurrentCamera
                    if camera then
                        local camDist = (camera.CFrame.Position - root.Position).Magnitude
                        camera.CFrame = CFrame.lookAt(root.Position - (lookCFrame.LookVector * camDist), root.Position + lookCFrame.LookVector)
                    end
                end
            end

            -- Активация блока
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
            local mobileBtn = getMobileBlockButton()
            if mobileBtn then firesignal(mobileBtn.MouseButton1Down) end
            
            local commEvent = ReplicatedStorage:FindFirstChild("Event") or ReplicatedStorage:FindFirstChild("Comm")
            if commEvent and commEvent:IsA("RemoteEvent") then
                commEvent:FireServer({Goal = "LeftClick", Key = Enum.KeyCode.F})
            end
        end)

        -- Задержка удерживания блока под удар
        task.wait(0.28)

        pcall(function()
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
            local mobileBtn = getMobileBlockButton()
            if mobileBtn then firesignal(mobileBtn.MouseButton1Up) end
        end)

        task.wait(0.05)
        isBlockingNow = false
    end)
end

-- Сканирование ударов
RunService.RenderStepped:Connect(function()
    if not autoBlockEnabled or isBlockingNow then return end
    
    local character = player.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local enemyChar = otherPlayer.Character
            local enemyRoot = enemyChar:FindFirstChild("HumanoidRootPart")
            local enemyHum = enemyChar:FindFirstChild("Humanoid")
            
            if enemyRoot and enemyHum and enemyHum.Health > 0 then
                local distance = (rootPart.Position - enemyRoot.Position).Magnitude
                
                if distance <= 8.5 then
                    local isRealAttack = false
                    local animator = enemyHum:FindFirstChildOfClass("Animator")
                    
                    if animator then
                        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                            if track.IsPlaying then
                                local speed = track.Speed
                                local priority = track.Priority
                                local animId = track.Animation.AnimationId:lower()

                                local isMovement = animId:find("idle") or animId:find("walk") or animId:find("run") or animId:find("jump") or animId:find("fall")
                                local isBlock = animId:find("block") or animId:find("defend") or animId:find("guard")

                                if not isMovement and not isBlock and (priority == Enum.AnimationPriority.Action or speed > 0.8) then
                                    isRealAttack = true
                                    break
                                end
                            end
                        end
                    end

                    if isRealAttack then
                        doBlock(enemyRoot)
                        break
                    end
                end
            end
        end
    end
end)

-- Плавающая кнопка
local floatBtn = Instance.new("TextButton")
floatBtn.Name = "FloatingButton"
floatBtn.Size = UDim2.new(0, 140, 0, 42)
floatBtn.Position = UDim2.new(0.5, -70, 0, -60)
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

-- Перетаскивание
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

-- Анимации
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

-- Медленная пыль
local maxParticles = 16
local particles = {}

for i = 1, maxParticles do
    local particle = Instance.new("Frame")
    local size = math.random(2, 4)
    particle.Size = UDim2.new(0, size, 0, size)
    particle.BackgroundColor3 = Color3.new(1, 1, 1)
    particle.BackgroundTransparency = math.random(50, 80) / 100
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
        speed = math.random(3, 7) / 10000
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
            p.speed = math.random(3, 7) / 10000
        end
        p.instance.Position = UDim2.new(p.x, 0, p.y, 0)
    end
end)
