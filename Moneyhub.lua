--[[
    ==================================================
    PROJECT: MONEYHUB PREMIUM GUI (Real Server Invisibility)
    DESCRIPTION: Modern Glass UI, Smooth Animations, Green/Black Toggles, No Strokes & Real Server-Invisible Auto Farm.
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

-- Главное окно (без обводок)
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

-- Кнопка Auto Farm (ЧЁРНЫЙ / ЗЕЛЁНЫЙ)
local autoFarmEnabled = false

local autoFarmBtn = Instance.new("TextButton")
autoFarmBtn.Name = "AutoFarmButton"
autoFarmBtn.Size = UDim2.new(1, 0, 0, 42)
autoFarmBtn.Position = UDim2.new(0, 0, 0, 35)
autoFarmBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
autoFarmBtn.BackgroundTransparency = 0.3
autoFarmBtn.Text = "  Auto Farm: OFF"
autoFarmBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
autoFarmBtn.TextSize = 13
autoFarmBtn.Font = Enum.Font.GothamMedium
autoFarmBtn.TextXAlignment = Enum.TextXAlignment.Left
autoFarmBtn.ZIndex = 2
autoFarmBtn.Parent = mainContentArea

local autoFarmCorner = Instance.new("UICorner")
autoFarmCorner.CornerRadius = UDim.new(0, 8)
autoFarmCorner.Parent = autoFarmBtn

-- Функция настоящей серверной невидимости (Server-Side Invisibility)
local savedClones = {}

local function toggleServerInvisibility(state)
    local char = player.Character
    if not char then return end
    
    if state then
        pcall(function()
            -- Удаляем отображение внешних деталей для сервера через узел LowerTorso/Root
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                for _, child in ipairs(char:GetChildren()) do
                    if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
                        child.Transparency = 1
                        if child:FindFirstChildOfClass("SpecialMesh") then
                            child:FindFirstChildOfClass("SpecialMesh").TextureId = ""
                        end
                    elseif child:IsA("Accessory") then
                        local handle = child:FindFirstChild("Handle")
                        if handle then handle.Transparency = 1 end
                    end
                end
                -- Смещение локального кадра для десинхронизации от сервера
                if char:FindFirstChild("LowerTorso") and char.LowerTorso:FindFirstChild("Root") then
                    char.LowerTorso.Root:Destroy()
                end
            end
        end)
    else
        -- При выключении переспавниваем персонажа нормальным образом
        pcall(function()
            if char:FindFirstChild("Humanoid") then
                char.Humanoid.Health = 0
            end
        end)
    end
end

autoFarmBtn.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    if autoFarmEnabled then
        autoFarmBtn.Text = "  Auto Farm: ON"
        autoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TweenService:Create(autoFarmBtn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(0, 180, 80)}):Play()
        toggleServerInvisibility(true)
    else
        autoFarmBtn.Text = "  Auto Farm: OFF"
        autoFarmBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
        TweenService:Create(autoFarmBtn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(20, 20, 25)}):Play()
        toggleServerInvisibility(false)
    end
end)

-- Логика Auto Farm
local currentTarget = nil

task.spawn(function()
    while true do
        task.wait(0.2)
        if autoFarmEnabled then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                
                local targetValid = false
                if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild("HumanoidRootPart") and currentTarget.Character:FindFirstChild("Humanoid") then
                    if currentTarget.Character.Humanoid.Health > 0 then
                        targetValid = true
                    end
                end

                if not targetValid then
                    local validPlayers = {}
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
                            if p.Character.Humanoid.Health > 0 then
                                table.insert(validPlayers, p)
                            end
                        end
                    end

                    if #validPlayers > 0 then
                        currentTarget = validPlayers[math.random(1, #validPlayers)]
                    else
                        currentTarget = nil
                    end
                end

                if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild("HumanoidRootPart") then
                    pcall(function()
                        local enemyRoot = currentTarget.Character.HumanoidRootPart
                        local myRoot = char.HumanoidRootPart
                        
                        -- Мгновенная телепортация за спину
                        myRoot.CFrame = enemyRoot.CFrame * CFrame.new(0, 0, 2.5)
                        
                        -- Атака M1
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        task.wait(0.02)
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)

                        -- Способности
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.One, false, game)
                        task.wait(0.01)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.One, false, game)
                        
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Two, false, game)
                        task.wait(0.01)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Two, false, game)

                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Three, false, game)
                        task.wait(0.01)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Three, false, game)
                    end)
                end
            end
        end
    end
end)

-- Авто-невидимость при респавне
player.CharacterAdded:Connect(function(newChar)
    newChar:WaitForChild("HumanoidRootPart")
    task.wait(0.5)
    if autoFarmEnabled then
        toggleServerInvisibility(true)
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

-- Пыль
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
