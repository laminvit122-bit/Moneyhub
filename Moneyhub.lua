--[[
    ==================================================
    PROJECT: MONEYHUB PREMIUM GUI (Final Custom Textures Edition)
    DESCRIPTION: OPUS Client Style, Texture ID near MONEYHUB, Custom Asset Icons
                 for Settings (6953984741) and Config Import (6953990743),
                 Fixed Window Close/Minimize buttons & ScrollingFrames.
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
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

local TEXTURE_ID = "rbxassetid://9343433823"
local SETTINGS_ICON = "rbxassetid://6953984741"
local IMPORT_ICON = "rbxassetid://6953990743"
local SAFE_COORDS = Vector3.new(-200.7, 675.7, 357.3)

if playerGui:FindFirstChild("MoneyHubGui") then
    playerGui.MoneyHubGui:Destroy()
end

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

-- Контейнер частиц
local effectsContainer = Instance.new("Frame")
effectsContainer.Name = "EffectsContainer"
effectsContainer.Size = UDim2.new(1, 0, 1, 0)
effectsContainer.BackgroundTransparency = 1
effectsContainer.ZIndex = 1
effectsContainer.Parent = mainFrame

local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, 0, 1, 0)
contentContainer.BackgroundTransparency = 1
contentContainer.ZIndex = 2
contentContainer.Parent = mainFrame

-- Сайдбар
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

local visualsTabBtn = Instance.new("TextButton")
visualsTabBtn.Name = "VisualsTabButton"
visualsTabBtn.Size = UDim2.new(1, -20, 0, 28)
visualsTabBtn.Position = UDim2.new(0, 10, 0, 132)
visualsTabBtn.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
visualsTabBtn.BackgroundTransparency = 0.5
visualsTabBtn.Text = "   ○  Visuals"
visualsTabBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
visualsTabBtn.TextSize = 11
visualsTabBtn.Font = Enum.Font.GothamMedium
visualsTabBtn.TextXAlignment = Enum.TextXAlignment.Left
visualsTabBtn.ZIndex = 3
visualsTabBtn.Parent = sidebar

local visualsTabCorner = Instance.new("UICorner")
visualsTabCorner.CornerRadius = UDim.new(0, 6)
visualsTabCorner.Parent = visualsTabBtn

local configTabBtn = Instance.new("TextButton")
configTabBtn.Name = "ConfigTabButton"
configTabBtn.Size = UDim2.new(1, -20, 0, 28)
configTabBtn.Position = UDim2.new(0, 10, 0, 164)
configTabBtn.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
configTabBtn.BackgroundTransparency = 0.5
configTabBtn.Text = "   ○  Configs"
configTabBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
configTabBtn.TextSize = 11
configTabBtn.Font = Enum.Font.GothamMedium
configTabBtn.TextXAlignment = Enum.TextXAlignment.Left
configTabBtn.ZIndex = 3
configTabBtn.Parent = sidebar

local configTabCorner = Instance.new("UICorner")
configTabCorner.CornerRadius = UDim.new(0, 6)
configTabCorner.Parent = configTabBtn

-- Верхняя панель
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

-- Кнопки сворачивания (−) и закрытия (×)
local minBtn = Instance.new("TextButton")
minBtn.Name = "MinimizeButton"
minBtn.Size = UDim2.new(0, 22, 0, 22)
minBtn.Position = UDim2.new(1, 14, 0, -2)
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

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, 40, 0, -2)
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

-- Страницы (ScrollingFrame)
local mainPage = Instance.new("ScrollingFrame")
mainPage.Name = "MainPage"
mainPage.Size = UDim2.new(1, -175, 1, -80)
mainPage.Position = UDim2.new(0, 165, 0, 72)
mainPage.BackgroundTransparency = 1
mainPage.CanvasSize = UDim2.new(0, 0, 0, 200)
mainPage.ScrollBarThickness = 3
mainPage.Visible = true
mainPage.ZIndex = 2
mainPage.Parent = contentContainer

local visualsPage = Instance.new("ScrollingFrame")
visualsPage.Name = "VisualsPage"
visualsPage.Size = UDim2.new(1, -175, 1, -80)
visualsPage.Position = UDim2.new(0, 165, 0, 72)
visualsPage.BackgroundTransparency = 1
visualsPage.CanvasSize = UDim2.new(0, 0, 0, 200)
visualsPage.ScrollBarThickness = 3
visualsPage.Visible = false
visualsPage.ZIndex = 2
visualsPage.Parent = contentContainer

local configPage = Instance.new("ScrollingFrame")
configPage.Name = "ConfigPage"
configPage.Size = UDim2.new(1, -175, 1, -80)
configPage.Position = UDim2.new(0, 165, 0, 72)
configPage.BackgroundTransparency = 1
configPage.CanvasSize = UDim2.new(0, 0, 0, 300)
configPage.ScrollBarThickness = 3
configPage.Visible = false
configPage.ZIndex = 2
configPage.Parent = contentContainer

local function switchTab(tabName)
    mainPage.Visible = (tabName == "Main")
    visualsPage.Visible = (tabName == "Visuals")
    configPage.Visible = (tabName == "Configs")

    sectionTitle.Text = "Modules / " .. tabName
    if tabName == "Visuals" then sectionTitle.Text = "Settings / Visuals" end
    if tabName == "Configs" then sectionTitle.Text = "Settings / Configs" end

    mainTabBtn.BackgroundColor3 = (tabName == "Main") and Color3.fromRGB(85, 50, 22) or Color3.fromRGB(54, 34, 18)
    mainTabBtn.TextColor3 = (tabName == "Main") and Color3.fromRGB(255, 225, 180) or Color3.fromRGB(200, 160, 120)

    visualsTabBtn.BackgroundColor3 = (tabName == "Visuals") and Color3.fromRGB(85, 50, 22) or Color3.fromRGB(54, 34, 18)
    visualsTabBtn.TextColor3 = (tabName == "Visuals") and Color3.fromRGB(255, 225, 180) or Color3.fromRGB(200, 160, 120)

    configTabBtn.BackgroundColor3 = (tabName == "Configs") and Color3.fromRGB(85, 50, 22) or Color3.fromRGB(54, 34, 18)
    configTabBtn.TextColor3 = (tabName == "Configs") and Color3.fromRGB(255, 225, 180) or Color3.fromRGB(200, 160, 120)
end

mainTabBtn.MouseButton1Click:Connect(function() switchTab("Main") end)
visualsTabBtn.MouseButton1Click:Connect(function() switchTab("Visuals") end)
configTabBtn.MouseButton1Click:Connect(function() switchTab("Configs") end)

local autoFarmEnabled = false
local aimAssistEnabled = false
local snowEnabled = false
local leavesEnabled = false

-- ==========================================
-- КАРТОЧКА ФУНКЦИИ С ИКОНКОЙ НАСТРОЕК (6953984741)
-- ==========================================
local function createModuleCard(parent, title, desc, yPos, callbackToggle, hasSettings)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 190, 0, 70)
    card.Position = UDim2.new(0, 0, 0, yPos)
    card.BackgroundColor3 = Color3.fromRGB(58, 36, 20)
    card.BackgroundTransparency = 0.2
    card.BorderSizePixel = 0
    card.ZIndex = 2
    card.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = card

    local tLbl = Instance.new("TextLabel")
    tLbl.Size = UDim2.new(0, 110, 0, 20)
    tLbl.Position = UDim2.new(0, 12, 0, 10)
    tLbl.BackgroundTransparency = 1
    tLbl.Font = Enum.Font.GothamBold
    tLbl.Text = title
    tLbl.TextColor3 = Color3.fromRGB(250, 220, 170)
    tLbl.TextSize = 13
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    tLbl.ZIndex = 3
    tLbl.Parent = card

    local dLbl = Instance.new("TextLabel")
    dLbl.Size = UDim2.new(1, -20, 0, 28)
    dLbl.Position = UDim2.new(0, 12, 0, 36)
    dLbl.BackgroundTransparency = 1
    dLbl.Font = Enum.Font.Gotham
    dLbl.Text = desc
    dLbl.TextColor3 = Color3.fromRGB(180, 130, 80)
    dLbl.TextSize = 10
    dLbl.TextWrapped = true
    dLbl.TextXAlignment = Enum.TextXAlignment.Left
    dLbl.ZIndex = 3
    dLbl.Parent = card

    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0, 34, 0, 18)
    toggleFrame.Position = UDim2.new(1, -42, 0, 11)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 24, 15)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.ZIndex = 3
    toggleFrame.Parent = card

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleFrame

    local toggleDot = Instance.new("Frame")
    toggleDot.Size = UDim2.new(0, 14, 0, 14)
    toggleDot.Position = UDim2.new(0, 2, 0, 2)
    toggleDot.BackgroundColor3 = Color3.fromRGB(150, 115, 80)
    toggleDot.BorderSizePixel = 0
    toggleDot.ZIndex = 4
    toggleDot.Parent = toggleFrame

    local dCorner = Instance.new("UICorner")
    dCorner.CornerRadius = UDim.new(1, 0)
    dCorner.Parent = toggleDot

    local clickBtn = Instance.new("TextButton")
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""
    clickBtn.ZIndex = 5
    clickBtn.Parent = card

    local isEnabled = false
    clickBtn.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        if isEnabled then
            TweenService:Create(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 120, 0)}):Play()
            TweenService:Create(toggleDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0, 2), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 24, 15)}):Play()
            TweenService:Create(toggleDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color3.fromRGB(150, 115, 80)}):Play()
        end
        if callbackToggle then callbackToggle(isEnabled) end
    end)

    if hasSettings then
        local settingsBtn = Instance.new("ImageButton")
        settingsBtn.Size = UDim2.new(0, 16, 0, 16)
        settingsBtn.Position = UDim2.new(1, -64, 0, 12)
        settingsBtn.BackgroundTransparency = 1
        settingsBtn.Image = SETTINGS_ICON
        settingsBtn.ZIndex = 5
        settingsBtn.Parent = card

        local settingsPanel = Instance.new("Frame")
        settingsPanel.Size = UDim2.new(1, 0, 0, 45)
        settingsPanel.Position = UDim2.new(0, 0, 1, 4)
        settingsPanel.BackgroundColor3 = Color3.fromRGB(48, 28, 14)
        settingsPanel.BackgroundTransparency = 0.1
        settingsPanel.Visible = false
        settingsPanel.ZIndex = 10
        settingsPanel.Parent = card

        local spCorner = Instance.new("UICorner")
        spCorner.CornerRadius = UDim.new(0, 8)
        spCorner.Parent = settingsPanel

        local sPanelText = Instance.new("TextLabel")
        sPanelText.Size = UDim2.new(1, -10, 1, 0)
        sPanelText.Position = UDim2.new(0, 5, 0, 0)
        sPanelText.BackgroundTransparency = 1
        sPanelText.Font = Enum.Font.Gotham
        sPanelText.Text = "Настройки: Активно"
        sPanelText.TextColor3 = Color3.fromRGB(230, 200, 150)
        sPanelText.TextSize = 10
        sPanelText.ZIndex = 11
        sPanelText.Parent = settingsPanel

        settingsBtn.MouseButton1Click:Connect(function()
            settingsPanel.Visible = not settingsPanel.Visible
            card.Size = settingsPanel.Visible and UDim2.new(0, 190, 0, 120) or UDim2.new(0, 190, 0, 70)
        end)
    end

    return card, function(val)
        isEnabled = val
        if isEnabled then
            toggleFrame.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
            toggleDot.Position = UDim2.new(1, -16, 0, 2)
            toggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        else
            toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 24, 15)
            toggleDot.Position = UDim2.new(0, 2, 0, 2)
            toggleDot.BackgroundColor3 = Color3.fromRGB(150, 115, 80)
        end
    end
end

createModuleCard(mainPage, "AutoFarm", "Рандомные удары и способности", 0, function(state)
    autoFarmEnabled = state
end, true)

createModuleCard(mainPage, "Aim Assist", "Автонаведение на туловище", 80, function(state)
    aimAssistEnabled = state
end, true)

createModuleCard(visualsPage, "Snow (Пыль)", "Плавные круглые точки снега", 0, function(state)
    snowEnabled = state
end, false)

createModuleCard(visualsPage, "Leaves 🍁", "Падающие осенние листья", 80, function(state)
    leavesEnabled = state
end, false)


-- ==========================================
-- МЕНЕДЖЕР КОНФИГОВ (Импорт с текстурой 6953990743)
-- ==========================================
local configsFolder = "MoneyHubConfigs"

local configNameBox = Instance.new("TextBox")
configNameBox.Size = UDim2.new(0, 120, 0, 28)
configNameBox.Position = UDim2.new(0, 0, 0, 10)
configNameBox.BackgroundColor3 = Color3.fromRGB(48, 28, 14)
configNameBox.BackgroundTransparency = 0.3
configNameBox.PlaceholderText = "Имя конфига..."
configNameBox.PlaceholderColor3 = Color3.fromRGB(170, 120, 70)
configNameBox.Text = ""
configNameBox.TextColor3 = Color3.fromRGB(255, 220, 170)
configNameBox.TextSize = 11
configNameBox.Font = Enum.Font.Gotham
configNameBox.ZIndex = 3
configNameBox.Parent = configPage

local cnCorner = Instance.new("UICorner") cnCorner.CornerRadius = UDim.new(0, 6) cnCorner.Parent = configNameBox

local createCfgBtn = Instance.new("TextButton")
createCfgBtn.Size = UDim2.new(0, 65, 0, 28)
createCfgBtn.Position = UDim2.new(0, 125, 0, 10)
createCfgBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
createCfgBtn.Text = "OK / Создать"
createCfgBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
createCfgBtn.TextSize = 10
createCfgBtn.Font = Enum.Font.GothamBold
createCfgBtn.ZIndex = 3
createCfgBtn.Parent = configPage

local ccCorner = Instance.new("UICorner") ccCorner.CornerRadius = UDim.new(0, 6) ccCorner.Parent = createCfgBtn

local configListContainer = Instance.new("ScrollingFrame")
configListContainer.Name = "ConfigListContainer"
configListContainer.Size = UDim2.new(1, 0, 0, 220)
configListContainer.Position = UDim2.new(0, 0, 0, 50)
configListContainer.BackgroundTransparency = 1
configListContainer.BorderSizePixel = 0
configListContainer.ScrollBarThickness = 3
configListContainer.ZIndex = 2
configListContainer.Parent = configPage

local function refreshConfigList()
    for _, ch in ipairs(configListContainer:GetChildren()) do
        ch:Destroy()
    end
    
    if not isfolder(configsFolder) then makefolder(configsFolder) end
    local files = listfiles(configsFolder)
    local yOffset = 0
    
    for _, file in ipairs(files) do
        local cfgName = file:match("([^/]+)$"):gsub(".json", "")
        
        local itemFrame = Instance.new("Frame")
        itemFrame.Size = UDim2.new(1, -5, 0, 32)
        itemFrame.Position = UDim2.new(0, 0, 0, yOffset)
        itemFrame.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
        itemFrame.BackgroundTransparency = 0.3
        itemFrame.ZIndex = 3
        itemFrame.Parent = configListContainer
        
        local itCorner = Instance.new("UICorner") itCorner.CornerRadius = UDim.new(0, 6) itCorner.Parent = itemFrame
        
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0, 75, 1, 0)
        lbl.Position = UDim2.new(0, 8, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = cfgName
        lbl.TextColor3 = Color3.fromRGB(255, 220, 170)
        lbl.TextSize = 11
        lbl.Font = Enum.Font.GothamBold
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 4
        lbl.Parent = itemFrame
        
        local saveBtn = Instance.new("TextButton")
        saveBtn.Size = UDim2.new(0, 32, 0, 22)
        saveBtn.Position = UDim2.new(1, -112, 0, 5)
        saveBtn.BackgroundColor3 = Color3.fromRGB(80, 45, 20)
        saveBtn.Text = "Сохр"
        saveBtn.TextColor3 = Color3.fromRGB(255, 200, 150)
        saveBtn.TextSize = 9
        saveBtn.Font = Enum.Font.GothamBold
        saveBtn.ZIndex = 4
        saveBtn.Parent = itemFrame
        local sbC = Instance.new("UICorner") sbC.CornerRadius = UDim.new(0, 4) sbC.Parent = saveBtn
        
        -- Кнопка импорта с текстурой 6953990743
        local loadBtn = Instance.new("ImageButton")
        loadBtn.Size = UDim2.new(0, 24, 0, 22)
        loadBtn.Position = UDim2.new(1, -72, 0, 5)
        loadBtn.BackgroundTransparency = 1
        loadBtn.Image = IMPORT_ICON
        loadBtn.ZIndex = 4
        loadBtn.Parent = itemFrame
        
        local delBtn = Instance.new("TextButton")
        delBtn.Size = UDim2.new(0, 30, 0, 22)
        delBtn.Position = UDim2.new(1, -34, 0, 5)
        delBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        delBtn.Text = "Удал"
        delBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        delBtn.TextSize = 9
        delBtn.Font = Enum.Font.GothamBold
        delBtn.ZIndex = 4
        delBtn.Parent = itemFrame
        local dbC = Instance.new("UICorner") dbC.CornerRadius = UDim.new(0, 4) dbC.Parent = delBtn
        
        saveBtn.MouseButton1Click:Connect(function()
            local data = { AutoFarm = autoFarmEnabled, AimAssist = aimAssistEnabled, Snow = snowEnabled, Leaves = leavesEnabled }
            writefile(configsFolder .. "/" .. cfgName .. ".json", HttpService:JSONEncode(data))
        end)
        
        loadBtn.MouseButton1Click:Connect(function()
            pcall(function()
                local content = readfile(configsFolder .. "/" .. cfgName .. ".json")
                local data = HttpService:JSONDecode(content)
                autoFarmEnabled = data.AutoFarm or false
                aimAssistEnabled = data.AimAssist or false
                snowEnabled = data.Snow or false
                leavesEnabled = data.Leaves or false
            end)
        end)
        
        delBtn.MouseButton1Click:Connect(function()
            if delfile then
                delfile(configsFolder .. "/" .. cfgName .. ".json")
                refreshConfigList()
            end
        end)
        
        yOffset = yOffset + 38
    end
    configListContainer.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

createCfgBtn.MouseButton1Click:Connect(function()
    local name = configNameBox.Text
    if name and name ~= "" then
        if not isfolder(configsFolder) then makefolder(configsFolder) end
        writefile(configsFolder .. "/" .. name .. ".json", HttpService:JSONEncode({ AutoFarm = false, AimAssist = false, Snow = false, Leaves = false }))
        configNameBox.Text = ""
        refreshConfigList()
    end
end)

refreshConfigList()

-- ==========================================
-- ПЛАВНЫЙ СНЕГ И ЛИСТЬЯ 🍁
-- ==========================================
local particles = {}
for i = 1, 26 do
    local snow = Instance.new("Frame")
    snow.Size = UDim2.new(0, math.random(3, 5), 0, math.random(3, 5))
    snow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    snow.BackgroundTransparency = 0.3
    snow.BorderSizePixel = 0
    snow.ZIndex = 1
    snow.Visible = false
    snow.Parent = effectsContainer
    local sCorner = Instance.new("UICorner") sCorner.CornerRadius = UDim.new(1, 0) sCorner.Parent = snow

    local leaf = Instance.new("TextLabel")
    leaf.Size = UDim2.new(0, 16, 0, 16)
    leaf.BackgroundTransparency = 1
    leaf.Font = Enum.Font.GothamBold
    leaf.Text = "🍁"
    leaf.TextSize = math.random(10, 15)
    leaf.ZIndex = 1
    leaf.Visible = false
    leaf.Parent = effectsContainer

    table.insert(particles, { snow = snow, leaf = leaf, x = math.random(), y = math.random(), speed = math.random(20, 50) / 100000, sway = math.random(1, 10) })
end

RunService.RenderStepped:Connect(function(dt)
    if not screenGui.Parent then return end
    local scaledDt = dt * 60
    for _, p in ipairs(particles) do
        p.y = p.y + (p.speed * scaledDt)
        if p.y > 1.05 then p.y = -0.05 p.x = math.random() end
        
        p.snow.Visible = (snowEnabled and mainFrame.Visible)
        if p.snow.Visible then p.snow.Position = UDim2.new(p.x, math.sin(tick() + p.sway) * 12, p.y, 0) end

        p.leaf.Visible = (leavesEnabled and mainFrame.Visible)
        if p.leaf.Visible then p.leaf.Position = UDim2.new(p.x, math.cos(tick() * 1.5 + p.sway) * 20, p.y, 0) end
    end
end)

-- ==========================================
-- БОЙ, АВТОФАРМ И AIM ASSIST
-- ==========================================
local function getTouchButton(nameKeyword)
    for _, gui in ipairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name ~= "MoneyHubGui" then
            for _, btn in ipairs(gui:GetDescendants()) do
                if (btn:IsA("ImageButton") or btn:IsA("TextButton")) and btn.Visible then
                    local name = btn.Name:lower()
                    local text = btn:IsA("TextButton") and btn.Text:lower() or ""
                    if name:find(nameKeyword) or text:find(nameKeyword) then return btn end
                end
            end
        end
    end
    return nil
end

local currentTarget = nil
local isEvadingDamage = false

local function getClosestPlayer()
    local nearest, minDist = nil, math.huge
    local myChar = player.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = myChar.HumanoidRootPart.Position

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
            if p.Character.Humanoid.Health > 0 then
                local dist = (p.Character.HumanoidRootPart.Position - myPos).Magnitude
                if dist < minDist then minDist = dist nearest = p end
            end
        end
    end
    return nearest
end

RunService.RenderStepped:Connect(function()
    local char = player.Character
    if not char then return end
    local myRoot = char:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    local target = getClosestPlayer()
    currentTarget = target

    if aimAssistEnabled and target and target.Character then
        local torso = target.Character:FindFirstChild("HumanoidRootPart") or target.Character:FindFirstChild("Torso")
        if torso then camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, torso.Position), 0.2) end
    end

    if not autoFarmEnabled or isEvadingDamage or not target or not target.Character then return end
    local enemyRoot = target.Character:FindFirstChild("HumanoidRootPart")
    if enemyRoot then
        local backPos = enemyRoot.CFrame * CFrame.new(0, 0, 2)
        myRoot.CFrame = CFrame.lookAt(backPos.Position, enemyRoot.Position)
    end
end)

local lastHealth = 100
player.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid", 5)
    if humanoid then
        lastHealth = humanoid.Health
        humanoid.HealthChanged:Connect(function(newHealth)
            if autoFarmEnabled and not isEvadingDamage and newHealth < lastHealth then
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
        end)
    end
end)

local function executeInstantM1()
    pcall(function()
        local punchBtn = getTouchButton("punch") or getTouchButton("attack") or getTouchButton("m1")
        if punchBtn then firesignal(punchBtn.MouseButton1Down) firesignal(punchBtn.Activated) firesignal(punchBtn.MouseButton1Up) end
        for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
            if obj:IsA("RemoteEvent") and (obj.Name:lower():find("comm") or obj.Name:lower():find("event") or obj.Name:lower():find("punch")) then
                obj:FireServer({Goal = "LeftClick"}) obj:FireServer("LeftClick") obj:FireServer("Punch")
            end
        end
    end)
end

local function executeInstantSkill(skillNumber)
    pcall(function()
        local skillBtn = getTouchButton(tostring(skillNumber))
        if skillBtn then firesignal(skillBtn.MouseButton1Down) firesignal(skillBtn.Activated) firesignal(skillBtn.MouseButton1Up) end
        local keyEnum = Enum.KeyCode.One
        if skillNumber == 2 then keyEnum = Enum.KeyCode.Two elseif skillNumber == 3 then keyEnum = Enum.KeyCode.Three elseif skillNumber == 4 then keyEnum = Enum.KeyCode.Four end
        game:GetService("VirtualInputManager"):SendKeyEvent(true, keyEnum, false, game)
        task.wait(0.02)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, keyEnum, false, game)
    end)
end

task.spawn(function()
    while true do
        task.wait(0.08)
        if autoFarmEnabled and currentTarget and currentTarget.Character and not isEvadingDamage then
            pcall(function()
                local char = player.Character local enemyChar = currentTarget.Character
                if not char or not enemyChar then return end
                local myRoot = char:FindFirstChild("HumanoidRootPart") local enemyRoot = enemyChar:FindFirstChild("HumanoidRootPart")
                if not myRoot or not enemyRoot then return end
                if (myRoot.Position - enemyRoot.Position).Magnitude <= 8 then
                    if math.random(1, 6) <= 3 then executeInstantM1() else executeInstantSkill(math.random(1, 4)) end
                end
            end)
        else
            task.wait(0.3)
        end
    end
end)

-- Перетаскивание и плавающая кнопка
local function enableDragging(frame, handle)
    local dragging, dragInput, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true dragStart = input.Position startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

enableDragging(mainFrame, topBarArea)

local floatBtn = Instance.new("Frame")
floatBtn.Name = "FloatingButton"
floatBtn.Size = UDim2.new(0, 130, 0, 36)
floatBtn.Position = UDim2.new(0.5, -65, 0, -50)
floatBtn.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
floatBtn.BackgroundTransparency = 0.15
floatBtn.Visible = false
floatBtn.ZIndex = 100
floatBtn.Parent = screenGui

local floatCorner = Instance.new("UICorner") floatCorner.CornerRadius = UDim.new(0, 18) floatCorner.Parent = floatBtn
local floatTexture = Instance.new("ImageLabel") floatTexture.Size = UDim2.new(0, 18, 0, 18) floatTexture.Position = UDim2.new(0, 10, 0.5, -9) floatTexture.BackgroundTransparency = 1 floatTexture.Image = TEXTURE_ID floatTexture.ZIndex = 101 floatTexture.Parent = floatBtn
local floatTitle = Instance.new("TextLabel") floatTitle.Size = UDim2.new(1, -34, 1, 0) floatTitle.Position = UDim2.new(0, 30, 0, 0) floatTitle.BackgroundTransparency = 1 floatTitle.Font = Enum.Font.GothamBold floatTitle.Text = "MONEYHUB" floatTitle.TextColor3 = Color3.fromRGB(255, 195, 80) floatTitle.TextSize = 12 floatTitle.TextXAlignment = Enum.TextXAlignment.Left floatTitle.ZIndex = 101 floatTitle.Parent = floatBtn
local floatClick = Instance.new("TextButton") floatClick.Size = UDim2.new(1, 0, 1, 0) floatClick.BackgroundTransparency = 1 floatClick.Text = "" floatClick.ZIndex = 102 floatClick.Parent = floatBtn

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
