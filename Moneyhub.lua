--[[
    ==================================================
    PROJECT: MONEYHUB PREMIUM GUI (Clean Cards & Texture Fix)
    DESCRIPTION: OPUS Client Style (Yellow-Orange Amber Theme), Texture ID only near MONEYHUB title,
                 Settings Tab (Snow & Falling Leaves 🍁), Fixed Mobile Abilities + M1 Random Auto Farm,
                 Safe Escape to Vector3.new(-200.7, 675.7, 357.3) & Server Desync.
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

-- ID вашей текстуры
local TEXTURE_ID = "rbxassetid://9343433823"

-- Безопасные координаты при получении урона
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

local targetPosition = UDim2.new(0.5, -290, 0.5, -185)
local hiddenPosition = UDim2.new(0.5, -290, 0.5, 350)

-- Главное окно
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 580, 0, 370)
mainFrame.Position = hiddenPosition
mainFrame.BackgroundColor3 = Color3.fromRGB(38, 24, 12)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

-- Контейнер для визуальных эффектов (снег и листья)
local effectsContainer = Instance.new("Frame")
effectsContainer.Name = "EffectsContainer"
effectsContainer.Size = UDim2.new(1, 0, 1, 0)
effectsContainer.BackgroundTransparency = 1
effectsContainer.ZIndex = 1
effectsContainer.Parent = mainFrame

-- Контейнер для контента
local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, 0, 1, 0)
contentContainer.BackgroundTransparency = 1
contentContainer.ZIndex = 2
contentContainer.Parent = mainFrame

-- Левый Сайдбар
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 145, 1, -20)
sidebar.Position = UDim2.new(0, 10, 0, 10)
sidebar.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
sidebar.BackgroundTransparency = 0.3
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 2
sidebar.Parent = contentContainer

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 10)
sidebarCorner.Parent = sidebar

-- Текстура строго возле названия MONEYHUB в сайдбаре
local logoTexture = Instance.new("ImageLabel")
logoTexture.Name = "LogoTexture"
logoTexture.Size = UDim2.new(0, 20, 0, 20)
logoTexture.Position = UDim2.new(0, 10, 0, 17)
logoTexture.BackgroundTransparency = 1
logoTexture.Image = TEXTURE_ID
logoTexture.ZIndex = 3
logoTexture.Parent = sidebar

local logoTextureCorner = Instance.new("UICorner")
logoTextureCorner.CornerRadius = UDim.new(0, 4)
logoTextureCorner.Parent = logoTexture

local logoLabel = Instance.new("TextLabel")
logoLabel.Name = "LogoLabel"
logoLabel.Size = UDim2.new(1, -38, 0, 35)
logoLabel.Position = UDim2.new(0, 34, 0, 10)
logoLabel.BackgroundTransparency = 1
logoLabel.Font = Enum.Font.GothamBold
logoLabel.Text = "MONEYHUB"
logoLabel.TextColor3 = Color3.fromRGB(255, 195, 80)
logoLabel.TextSize = 14
logoLabel.TextXAlignment = Enum.TextXAlignment.Left
logoLabel.ZIndex = 3
logoLabel.Parent = sidebar

-- Секция Modules
local modulesHeader = Instance.new("TextLabel")
modulesHeader.Size = UDim2.new(1, -20, 0, 20)
modulesHeader.Position = UDim2.new(0, 12, 0, 48)
modulesHeader.BackgroundTransparency = 1
modulesHeader.Font = Enum.Font.GothamBold
modulesHeader.Text = "▾ Modules"
modulesHeader.TextColor3 = Color3.fromRGB(210, 150, 90)
modulesHeader.TextSize = 11
modulesHeader.TextXAlignment = Enum.TextXAlignment.Left
modulesHeader.ZIndex = 3
modulesHeader.Parent = sidebar

local mainTabBtn = Instance.new("TextButton")
mainTabBtn.Name = "MainTabButton"
mainTabBtn.Size = UDim2.new(1, -20, 0, 30)
mainTabBtn.Position = UDim2.new(0, 10, 0, 70)
mainTabBtn.BackgroundColor3 = Color3.fromRGB(85, 50, 22)
mainTabBtn.BackgroundTransparency = 0.2
mainTabBtn.Text = "   ●  Main"
mainTabBtn.TextColor3 = Color3.fromRGB(255, 225, 180)
mainTabBtn.TextSize = 12
mainTabBtn.Font = Enum.Font.GothamMedium
mainTabBtn.TextXAlignment = Enum.TextXAlignment.Left
mainTabBtn.ZIndex = 3
mainTabBtn.Parent = sidebar

local mainTabCorner = Instance.new("UICorner")
mainTabCorner.CornerRadius = UDim.new(0, 6)
mainTabCorner.Parent = mainTabBtn

-- Секция Settings
local settingsHeader = Instance.new("TextLabel")
settingsHeader.Size = UDim2.new(1, -20, 0, 20)
settingsHeader.Position = UDim2.new(0, 12, 0, 110)
settingsHeader.BackgroundTransparency = 1
settingsHeader.Font = Enum.Font.GothamBold
settingsHeader.Text = "▾ Settings"
settingsHeader.TextColor3 = Color3.fromRGB(210, 150, 90)
settingsHeader.TextSize = 11
settingsHeader.TextXAlignment = Enum.TextXAlignment.Left
settingsHeader.ZIndex = 3
settingsHeader.Parent = sidebar

local settingsTabBtn = Instance.new("TextButton")
settingsTabBtn.Name = "SettingsTabButton"
settingsTabBtn.Size = UDim2.new(1, -20, 0, 30)
settingsTabBtn.Position = UDim2.new(0, 10, 0, 132)
settingsTabBtn.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
settingsTabBtn.BackgroundTransparency = 0.5
settingsTabBtn.Text = "   ○  Visuals"
settingsTabBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
settingsTabBtn.TextSize = 12
settingsTabBtn.Font = Enum.Font.GothamMedium
settingsTabBtn.TextXAlignment = Enum.TextXAlignment.Left
settingsTabBtn.ZIndex = 3
settingsTabBtn.Parent = sidebar

local settingsTabCorner = Instance.new("UICorner")
settingsTabCorner.CornerRadius = UDim.new(0, 6)
settingsTabCorner.Parent = settingsTabBtn

-- Верхняя рабочая панель
local topBarArea = Instance.new("Frame")
topBarArea.Name = "TopBarArea"
topBarArea.Size = UDim2.new(1, -175, 0, 40)
topBarArea.Position = UDim2.new(0, 165, 0, 10)
topBarArea.BackgroundTransparency = 1
topBarArea.ZIndex = 2
topBarArea.Parent = contentContainer

local searchBar = Instance.new("Frame")
searchBar.Name = "SearchBar"
searchBar.Size = UDim2.new(0, 180, 0, 30)
searchBar.Position = UDim2.new(0, 0, 0, 5)
searchBar.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
searchBar.BackgroundTransparency = 0.3
searchBar.BorderSizePixel = 0
searchBar.ZIndex = 2
searchBar.Parent = topBarArea

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 8)
searchCorner.Parent = searchBar

local searchIcon = Instance.new("TextLabel")
searchIcon.Size = UDim2.new(0, 25, 1, 0)
searchIcon.Position = UDim2.new(0, 8, 0, 0)
searchIcon.BackgroundTransparency = 1
searchIcon.Font = Enum.Font.GothamMedium
searchIcon.Text = "🔍"
searchIcon.TextColor3 = Color3.fromRGB(200, 140, 70)
searchIcon.TextSize = 12
searchIcon.ZIndex = 3
searchIcon.Parent = searchBar

local searchInput = Instance.new("TextBox")
searchInput.Size = UDim2.new(1, -35, 1, 0)
searchInput.Position = UDim2.new(0, 30, 0, 0)
searchInput.BackgroundTransparency = 1
searchInput.Font = Enum.Font.Gotham
searchInput.PlaceholderText = "Поиск..."
searchInput.PlaceholderColor3 = Color3.fromRGB(170, 120, 70)
searchInput.Text = ""
searchInput.TextColor3 = Color3.fromRGB(250, 220, 170)
searchInput.TextSize = 12
searchInput.TextXAlignment = Enum.TextXAlignment.Left
searchInput.ZIndex = 3
searchInput.Parent = searchBar

-- Профиль пользователя
local profileFrame = Instance.new("Frame")
profileFrame.Name = "ProfileFrame"
profileFrame.Size = UDim2.new(0, 120, 0, 30)
profileFrame.Position = UDim2.new(1, -110, 0, 5)
profileFrame.BackgroundTransparency = 1
profileFrame.ZIndex = 2
profileFrame.Parent = topBarArea

local profileName = Instance.new("TextLabel")
profileName.Size = UDim2.new(1, -35, 1, 0)
profileName.Position = UDim2.new(0, 0, 0, 0)
profileName.BackgroundTransparency = 1
profileName.Font = Enum.Font.GothamBold
profileName.Text = player.DisplayName
profileName.TextColor3 = Color3.fromRGB(250, 220, 170)
profileName.TextSize = 12
profileName.TextXAlignment = Enum.TextXAlignment.Right
profileName.ZIndex = 3
profileName.Parent = profileFrame

local profileAvatar = Instance.new("ImageLabel")
profileAvatar.Size = UDim2.new(0, 26, 0, 26)
profileAvatar.Position = UDim2.new(1, -28, 0, 2)
profileAvatar.BackgroundColor3 = Color3.fromRGB(60, 35, 18)
profileAvatar.BorderSizePixel = 0
profileAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150"
profileAvatar.ZIndex = 3
profileAvatar.Parent = profileFrame

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(1, 0)
avatarCorner.Parent = profileAvatar

-- Кнопки управления окном
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, 15, 0, -2)
closeBtn.BackgroundColor3 = Color3.fromRGB(85, 35, 20)
closeBtn.BackgroundTransparency = 0.3
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 150, 120)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.ZIndex = 4
closeBtn.Parent = topBarArea

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

local minBtn = Instance.new("TextButton")
minBtn.Name = "MinimizeButton"
minBtn.Size = UDim2.new(0, 22, 0, 22)
minBtn.Position = UDim2.new(1, -12, 0, -2)
minBtn.BackgroundColor3 = Color3.fromRGB(65, 38, 20)
minBtn.BackgroundTransparency = 0.3
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(230, 190, 140)
minBtn.TextSize = 14
minBtn.Font = Enum.Font.GothamBold
minBtn.ZIndex = 4
minBtn.Parent = topBarArea

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minBtn

local sectionTitle = Instance.new("TextLabel")
sectionTitle.Size = UDim2.new(1, -175, 0, 20)
sectionTitle.Position = UDim2.new(0, 165, 0, 48)
sectionTitle.BackgroundTransparency = 1
sectionTitle.Font = Enum.Font.GothamBold
sectionTitle.Text = "Modules / Main"
sectionTitle.TextColor3 = Color3.fromRGB(190, 135, 75)
sectionTitle.TextSize = 12
sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
sectionTitle.ZIndex = 2
sectionTitle.Parent = contentContainer

-- Рабочие страницы
local mainPage = Instance.new("Frame")
mainPage.Name = "MainPage"
mainPage.Size = UDim2.new(1, -175, 1, -80)
mainPage.Position = UDim2.new(0, 165, 0, 72)
mainPage.BackgroundTransparency = 1
mainPage.Visible = true
mainPage.ZIndex = 2
mainPage.Parent = contentContainer

local settingsPage = Instance.new("Frame")
settingsPage.Name = "SettingsPage"
settingsPage.Size = UDim2.new(1, -175, 1, -80)
settingsPage.Position = UDim2.new(0, 165, 0, 72)
settingsPage.BackgroundTransparency = 1
settingsPage.Visible = false
settingsPage.ZIndex = 2
settingsPage.Parent = contentContainer

mainTabBtn.MouseButton1Click:Connect(function()
    mainPage.Visible = true
    settingsPage.Visible = false
    sectionTitle.Text = "Modules / Main"
    mainTabBtn.BackgroundColor3 = Color3.fromRGB(85, 50, 22)
    mainTabBtn.TextColor3 = Color3.fromRGB(255, 225, 180)
    settingsTabBtn.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
    settingsTabBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
end)

settingsTabBtn.MouseButton1Click:Connect(function()
    mainPage.Visible = false
    settingsPage.Visible = true
    sectionTitle.Text = "Settings / Visuals"
    settingsTabBtn.BackgroundColor3 = Color3.fromRGB(85, 50, 22)
    settingsTabBtn.TextColor3 = Color3.fromRGB(255, 225, 180)
    mainTabBtn.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
    mainTabBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
end)

-- ==========================================
-- КАРТОЧКА AUTO FARM (Чистая, без текстур на самой карточке)
-- ==========================================
local autoFarmCard = Instance.new("Frame")
autoFarmCard.Name = "AutoFarmCard"
autoFarmCard.Size = UDim2.new(0, 190, 0, 70)
autoFarmCard.Position = UDim2.new(0, 0, 0, 0)
autoFarmCard.BackgroundColor3 = Color3.fromRGB(58, 36, 20)
autoFarmCard.BackgroundTransparency = 0.2
autoFarmCard.BorderSizePixel = 0
autoFarmCard.ZIndex = 2
autoFarmCard.Parent = mainPage

local cardCorner = Instance.new("UICorner")
cardCorner.CornerRadius = UDim.new(0, 10)
cardCorner.Parent = autoFarmCard

local cardTitle = Instance.new("TextLabel")
cardTitle.Size = UDim2.new(0, 130, 0, 20)
cardTitle.Position = UDim2.new(0, 12, 0, 10)
cardTitle.BackgroundTransparency = 1
cardTitle.Font = Enum.Font.GothamBold
cardTitle.Text = "Auto Farm"
cardTitle.TextColor3 = Color3.fromRGB(250, 220, 170)
cardTitle.TextSize = 13
cardTitle.TextXAlignment = Enum.TextXAlignment.Left
cardTitle.ZIndex = 3
cardTitle.Parent = autoFarmCard

local cardDesc = Instance.new("TextLabel")
cardDesc.Size = UDim2.new(1, -20, 0, 28)
cardDesc.Position = UDim2.new(0, 12, 0, 36)
cardDesc.BackgroundTransparency = 1
cardDesc.Font = Enum.Font.Gotham
cardDesc.Text = "Рандомные удары и способности за спиной"
cardDesc.TextColor3 = Color3.fromRGB(180, 130, 80)
cardDesc.TextSize = 10
cardDesc.TextWrapped = true
cardDesc.TextXAlignment = Enum.TextXAlignment.Left
cardDesc.ZIndex = 3
cardDesc.Parent = autoFarmCard

local toggleFrame = Instance.new("Frame")
toggleFrame.Name = "ToggleFrame"
toggleFrame.Size = UDim2.new(0, 34, 0, 18)
toggleFrame.Position = UDim2.new(1, -42, 0, 11)
toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 24, 15)
toggleFrame.BorderSizePixel = 0
toggleFrame.ZIndex = 3
toggleFrame.Parent = autoFarmCard

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = toggleFrame

local toggleDot = Instance.new("Frame")
toggleDot.Name = "ToggleDot"
toggleDot.Size = UDim2.new(0, 14, 0, 14)
toggleDot.Position = UDim2.new(0, 2, 0, 2)
toggleDot.BackgroundColor3 = Color3.fromRGB(150, 115, 80)
toggleDot.BorderSizePixel = 0
toggleDot.ZIndex = 4
toggleDot.Parent = toggleFrame

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = toggleDot

local clickButton = Instance.new("TextButton")
clickButton.Size = UDim2.new(1, 0, 1, 0)
clickButton.BackgroundTransparency = 1
clickButton.Text = ""
clickButton.ZIndex = 5
clickButton.Parent = autoFarmCard

local autoFarmEnabled = false

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

clickButton.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    if autoFarmEnabled then
        TweenService:Create(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 120, 0)}):Play()
        TweenService:Create(toggleDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0, 2), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        toggleServerDesync(true)
    else
        TweenService:Create(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 24, 15)}):Play()
        TweenService:Create(toggleDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color3.fromRGB(150, 115, 80)}):Play()
        toggleServerDesync(false)
    end
end)

-- ==========================================
-- НАСТРОЙКИ (Снег и Листья 🍁)
-- ==========================================
local snowEnabled = false
local leavesEnabled = false

local snowCard = Instance.new("Frame")
snowCard.Size = UDim2.new(0, 190, 0, 70)
snowCard.Position = UDim2.new(0, 0, 0, 0)
snowCard.BackgroundColor3 = Color3.fromRGB(58, 36, 20)
snowCard.BackgroundTransparency = 0.2
snowCard.BorderSizePixel = 0
snowCard.ZIndex = 2
snowCard.Parent = settingsPage

local snowCorner = Instance.new("UICorner")
snowCorner.CornerRadius = UDim.new(0, 10)
snowCorner.Parent = snowCard

local snowTitle = Instance.new("TextLabel")
snowTitle.Size = UDim2.new(0, 130, 0, 20)
snowTitle.Position = UDim2.new(0, 12, 0, 10)
snowTitle.BackgroundTransparency = 1
snowTitle.Font = Enum.Font.GothamBold
snowTitle.Text = "Snow (Пыль)"
snowTitle.TextColor3 = Color3.fromRGB(250, 220, 170)
snowTitle.TextSize = 13
snowTitle.TextXAlignment = Enum.TextXAlignment.Left
snowTitle.ZIndex = 3
snowTitle.Parent = snowCard

local snowDesc = Instance.new("TextLabel")
snowDesc.Size = UDim2.new(1, -20, 0, 28)
snowDesc.Position = UDim2.new(0, 12, 0, 36)
snowDesc.BackgroundTransparency = 1
snowDesc.Font = Enum.Font.Gotham
snowDesc.Text = "Падающие частицы снега на фоне"
snowDesc.TextColor3 = Color3.fromRGB(180, 130, 80)
snowDesc.TextSize = 10
snowDesc.TextWrapped = true
snowDesc.TextXAlignment = Enum.TextXAlignment.Left
snowDesc.ZIndex = 3
snowDesc.Parent = snowCard

local snowToggleFrame = Instance.new("Frame")
snowToggleFrame.Size = UDim2.new(0, 34, 0, 18)
snowToggleFrame.Position = UDim2.new(1, -42, 0, 11)
snowToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 24, 15)
snowToggleFrame.BorderSizePixel = 0
snowToggleFrame.ZIndex = 3
snowToggleFrame.Parent = snowCard

local snowTCorner = Instance.new("UICorner")
snowTCorner.CornerRadius = UDim.new(1, 0)
snowTCorner.Parent = snowToggleFrame

local snowDot = Instance.new("Frame")
snowDot.Size = UDim2.new(0, 14, 0, 14)
snowDot.Position = UDim2.new(0, 2, 0, 2)
snowDot.BackgroundColor3 = Color3.fromRGB(150, 115, 80)
snowDot.BorderSizePixel = 0
snowDot.ZIndex = 4
snowDot.Parent = snowToggleFrame

local snowDC = Instance.new("UICorner")
snowDC.CornerRadius = UDim.new(1, 0)
snowDC.Parent = snowDot

local snowClick = Instance.new("TextButton")
snowClick.Size = UDim2.new(1, 0, 1, 0)
snowClick.BackgroundTransparency = 1
snowClick.Text = ""
snowClick.ZIndex = 5
snowClick.Parent = snowCard

snowClick.MouseButton1Click:Connect(function()
    snowEnabled = not snowEnabled
    if snowEnabled then
        TweenService:Create(snowToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 120, 0)}):Play()
        TweenService:Create(snowDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0, 2), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    else
        TweenService:Create(snowToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 24, 15)}):Play()
        TweenService:Create(snowDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color3.fromRGB(150, 115, 80)}):Play()
    end
end)

-- Карточка Листьев (🍁)
local leavesCard = Instance.new("Frame")
leavesCard.Size = UDim2.new(0, 190, 0, 70)
leavesCard.Position = UDim2.new(0, 200, 0, 0)
leavesCard.BackgroundColor3 = Color3.fromRGB(58, 36, 20)
leavesCard.BackgroundTransparency = 0.2
leavesCard.BorderSizePixel = 0
leavesCard.ZIndex = 2
leavesCard.Parent = settingsPage

local leavesCorner = Instance.new("UICorner")
leavesCorner.CornerRadius = UDim.new(0, 10)
leavesCorner.Parent = leavesCard

local leavesTitle = Instance.new("TextLabel")
leavesTitle.Size = UDim2.new(0, 130, 0, 20)
leavesTitle.Position = UDim2.new(0, 12, 0, 10)
leavesTitle.BackgroundTransparency = 1
leavesTitle.Font = Enum.Font.GothamBold
leavesTitle.Text = "Leaves 🍁"
leavesTitle.TextColor3 = Color3.fromRGB(250, 220, 170)
leavesTitle.TextSize = 13
leavesTitle.TextXAlignment = Enum.TextXAlignment.Left
leavesTitle.ZIndex = 3
leavesTitle.Parent = leavesCard

local leavesDesc = Instance.new("TextLabel")
leavesDesc.Size = UDim2.new(1, -20, 0, 28)
leavesDesc.Position = UDim2.new(0, 12, 0, 36)
leavesDesc.BackgroundTransparency = 1
leavesDesc.Font = Enum.Font.Gotham
leavesDesc.Text = "Падающие осенние листья клёна"
leavesDesc.TextColor3 = Color3.fromRGB(180, 130, 80)
leavesDesc.TextSize = 10
leavesDesc.TextWrapped = true
leavesDesc.TextXAlignment = Enum.TextXAlignment.Left
leavesDesc.ZIndex = 3
leavesDesc.Parent = leavesCard

local leavesToggleFrame = Instance.new("Frame")
leavesToggleFrame.Size = UDim2.new(0, 34, 0, 18)
leavesToggleFrame.Position = UDim2.new(1, -42, 0, 11)
leavesToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 24, 15)
leavesToggleFrame.BorderSizePixel = 0
leavesToggleFrame.ZIndex = 3
leavesToggleFrame.Parent = leavesCard

local leavesTCorner = Instance.new("UICorner")
leavesTCorner.CornerRadius = UDim.new(1, 0)
leavesTCorner.Parent = leavesToggleFrame

local leavesDot = Instance.new("Frame")
leavesDot.Size = UDim2.new(0, 14, 0, 14)
leavesDot.Position = UDim2.new(0, 2, 0, 2)
leavesDot.BackgroundColor3 = Color3.fromRGB(150, 115, 80)
leavesDot.BorderSizePixel = 0
leavesDot.ZIndex = 4
leavesDot.Parent = leavesToggleFrame

local leavesDC = Instance.new("UICorner")
leavesDC.CornerRadius = UDim.new(1, 0)
leavesDC.Parent = leavesDot

local leavesClick = Instance.new("TextButton")
leavesClick.Size = UDim2.new(1, 0, 1, 0)
leavesClick.BackgroundTransparency = 1
leavesClick.Text = ""
leavesClick.ZIndex = 5
leavesClick.Parent = leavesCard

leavesClick.MouseButton1Click:Connect(function()
    leavesEnabled = not leavesEnabled
    if leavesEnabled then
        TweenService:Create(leavesToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 120, 0)}):Play()
        TweenService:Create(leavesDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0, 2), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    else
        TweenService:Create(leavesToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 24, 15)}):Play()
        TweenService:Create(leavesDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color3.fromRGB(150, 115, 80)}):Play()
    end
end)

-- Рендер частиц снега и листьев
local particles = {}
for i = 1, 24 do
    local snow = Instance.new("Frame")
    snow.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
    snow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    snow.BackgroundTransparency = 0.4
    snow.BorderSizePixel = 0
    snow.ZIndex = 1
    snow.Visible = false
    snow.Parent = effectsContainer
    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(1, 0)
    sCorner.Parent = snow

    local leaf = Instance.new("TextLabel")
    leaf.Size = UDim2.new(0, 16, 0, 16)
    leaf.BackgroundTransparency = 1
    leaf.Font = Enum.Font.GothamBold
    leaf.Text = "🍁"
    leaf.TextSize = math.random(10, 16)
    leaf.ZIndex = 1
    leaf.Visible = false
    leaf.Parent = effectsContainer

    table.insert(particles, {
        snow = snow,
        leaf = leaf,
        x = math.random(),
        y = math.random(),
        speed = math.random(2, 5) / 10000,
        sway = math.random(1, 10)
    })
end

RunService.RenderStepped:Connect(function(dt)
    if not screenGui.Parent then return end
    local scaledDt = dt * 60
    for _, p in ipairs(particles) do
        p.y = p.y + (p.speed * scaledDt)
        if p.y > 1.05 then
            p.y = -0.05
            p.x = math.random()
        end
        
        if snowEnabled and mainFrame.Visible then
            p.snow.Visible = true
            p.snow.Position = UDim2.new(p.x, math.sin(tick() + p.sway) * 15, p.y, 0)
        else
            p.snow.Visible = false
        end

        if leavesEnabled and mainFrame.Visible then
            p.leaf.Visible = true
            p.leaf.Position = UDim2.new(p.x, math.cos(tick() * 2 + p.sway) * 25, p.y, 0)
        else
            p.leaf.Visible = false
        end
    end
end)

-- ==========================================
-- ЛОГИКА БОЯ И АВТОФАРМА
-- ==========================================
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

-- Защитный телепорт в точные SAFE_COORDS при получении урона
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

-- Привязка за спину + Аимлок
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

local function executeInstantSkill(skillNumber)
    pcall(function()
        local skillBtn = getTouchButton(tostring(skillNumber))
        if skillBtn then
            firesignal(skillBtn.MouseButton1Down)
            firesignal(skillBtn.Activated)
            firesignal(skillBtn.MouseButton1Up)
        end

        local keyEnum = Enum.KeyCode.One
        if skillNumber == 2 then keyEnum = Enum.KeyCode.Two
        elseif skillNumber == 3 then keyEnum = Enum.KeyCode.Three
        elseif skillNumber == 4 then keyEnum = Enum.KeyCode.Four end
        
        game:GetService("VirtualInputManager"):SendKeyEvent(true, keyEnum, false, game)
        task.wait(0.02)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, keyEnum, false, game)

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

-- Рандомный боевой цикл
task.spawn(function()
    while true do
        task.wait(0.08)
        if autoFarmEnabled and currentTarget and not isEvadingDamage then
            pcall(function()
                local char = player.Character
                local enemyChar = currentTarget.Character
                if not char or not enemyChar then return end
                
                local myRoot = char:FindFirstChild("HumanoidRootPart")
                local enemyRoot = enemyChar:FindFirstChild("HumanoidRootPart")
                if not myRoot or not enemyRoot then return end

                local dist = (myRoot.Position - enemyRoot.Position).Magnitude
                if dist <= 8 then
                    local randomAction = math.random(1, 6)
                    if randomAction <= 3 then
                        executeInstantM1()
                    else
                        local randomSkill = math.random(1, 4)
                        executeInstantSkill(randomSkill)
                    end
                end
            end)
        else
            task.wait(0.3)
        end
    end
end)

-- Перетаскивание окна
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

enableDragging(mainFrame, topBarArea)

-- Плавающая кнопка разворачивания (содержит текстуру строго около названия)
local floatBtn = Instance.new("Frame")
floatBtn.Name = "FloatingButton"
floatBtn.Size = UDim2.new(0, 130, 0, 36)
floatBtn.Position = UDim2.new(0.5, -65, 0, -50)
floatBtn.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
floatBtn.BackgroundTransparency = 0.15
floatBtn.Visible = false
floatBtn.ZIndex = 100
floatBtn.Parent = screenGui

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(0, 18)
floatCorner.Parent = floatBtn

local floatTexture = Instance.new("ImageLabel")
floatTexture.Size = UDim2.new(0, 18, 0, 18)
floatTexture.Position = UDim2.new(0, 10, 0.5, -9)
floatTexture.BackgroundTransparency = 1
floatTexture.Image = TEXTURE_ID
floatTexture.ZIndex = 101
floatTexture.Parent = floatBtn

local floatTitle = Instance.new("TextLabel")
floatTitle.Size = UDim2.new(1, -34, 1, 0)
floatTitle.Position = UDim2.new(0, 30, 0, 0)
floatTitle.BackgroundTransparency = 1
floatTitle.Font = Enum.Font.GothamBold
floatTitle.Text = "MONEYHUB"
floatTitle.TextColor3 = Color3.fromRGB(255, 195, 80)
floatTitle.TextSize = 12
floatTitle.TextXAlignment = Enum.TextXAlignment.Left
floatTitle.ZIndex = 101
floatTitle.Parent = floatBtn

local floatClick = Instance.new("TextButton")
floatClick.Size = UDim2.new(1, 0, 1, 0)
floatClick.BackgroundTransparency = 1
floatClick.Text = ""
floatClick.ZIndex = 102
floatClick.Parent = floatBtn

enableDragging(floatBtn, floatBtn)

local function animateOpen()
    mainFrame.Position = hiddenPosition
    mainFrame.BackgroundTransparency = 1
    TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = targetPosition, BackgroundTransparency = 0.05}):Play()
end

minBtn.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = hiddenPosition, BackgroundTransparency = 1}):Play()
    task.wait(0.3)
    mainFrame.Visible = false
    floatBtn.Visible = true
    floatBtn.Position = UDim2.new(0.5, -65, 0, -50)
    TweenService:Create(floatBtn, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -65, 0.05, 0)}):Play()
end)

floatClick.MouseButton1Click:Connect(function()
    TweenService:Create(floatBtn, TweenInfo.new(0.2), {Position = UDim2.new(0.5, -65, 0, -50)}):Play()
    task.wait(0.2)
    floatBtn.Visible = false
    mainFrame.Visible = true
    animateOpen()
end)

closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 1}):Play()
    task.wait(0.3)
    screenGui:Destroy()
end)

animateOpen()
