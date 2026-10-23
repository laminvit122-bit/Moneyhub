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
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

local TEXTURE_ID = "rbxassetid://9343433823"
local MODULES_ICON = "rbxassetid://82633060732202"
local SETTINGS_ICON = "rbxassetid://138028255370142"
local MAIN_ICON = "rbxassetid://14502433595"
local VISUALS_ICON = "rbxassetid://11322089611"
local CONFIGS_ICON = "rbxassetid://90837140373377"
local GEAR_ICON = "rbxassetid://6953984741"

local SAVE_ICON = "rbxassetid://11768914234"
local IMPORT_ICON = "rbxassetid://6953990743"
local DELETE_ICON = "rbxassetid://11768918600"

local SAFE_COORDS = Vector3.new(-200.7, 675.7, 357.3)
local PINK_SKY_ID = "rbxassetid://8202961731"

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

-- СИСТЕМА УВЕДОМЛЕНИЙ
local notificationsContainer = Instance.new("Frame")
notificationsContainer.Name = "NotificationsContainer"
notificationsContainer.Size = UDim2.new(0, 240, 1, 0)
notificationsContainer.Position = UDim2.new(1, -250, 0, 0)
notificationsContainer.BackgroundTransparency = 1
notificationsContainer.ZIndex = 500
notificationsContainer.Parent = screenGui

local activeNotifications = 0

local function showNotification(title, stateText)
    activeNotifications = activeNotifications + 1
    local yPos = - (activeNotifications * 55)

    local notifFrame = Instance.new("Frame")
    notifFrame.Size = UDim2.new(1, 0, 0, 45)
    notifFrame.Position = UDim2.new(1, 50, 1, yPos - 10)
    notifFrame.BackgroundColor3 = Color3.fromRGB(45, 26, 13)
    notifFrame.BackgroundTransparency = 0.1
    notifFrame.BorderSizePixel = 0
    notifFrame.ZIndex = 501
    notifFrame.Parent = notificationsContainer

    local nCorner = Instance.new("UICorner") nCorner.CornerRadius = UDim.new(0, 8) nCorner.Parent = notifFrame

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -15, 0, 22)
    titleLbl.Position = UDim2.new(0, 10, 0, 4)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.Text = title .. ": " .. stateText
    titleLbl.TextColor3 = Color3.fromRGB(255, 200, 120)
    titleLbl.TextSize = 11
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 502
    titleLbl.Parent = notifFrame

    local lineBg = Instance.new("Frame")
    lineBg.Size = UDim2.new(1, -20, 0, 3)
    lineBg.Position = UDim2.new(0, 10, 1, -8)
    lineBg.BackgroundColor3 = Color3.fromRGB(60, 35, 18)
    lineBg.BorderSizePixel = 0
    lineBg.ZIndex = 502
    lineBg.Parent = notifFrame
    local lbCorner = Instance.new("UICorner") lbCorner.CornerRadius = UDim.new(1,0) lbCorner.Parent = lineBg

    local lineFill = Instance.new("Frame")
    lineFill.Size = UDim2.new(1, 0, 1, 0)
    lineFill.Position = UDim2.new(0, 0, 0, 0)
    lineFill.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
    lineFill.BorderSizePixel = 0
    lineFill.ZIndex = 503
    lineFill.Parent = lineBg
    local lfCorner = Instance.new("UICorner") lfCorner.CornerRadius = UDim.new(1,0) lfCorner.Parent = lineFill

    TweenService:Create(notifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 1, yPos - 10)}):Play()
    TweenService:Create(lineFill, TweenInfo.new(3.0, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)}):Play()

    task.delay(3.0, function()
        TweenService:Create(notifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 50, 1, yPos - 10), BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        notifFrame:Destroy()
        activeNotifications = math.max(0, activeNotifications - 1)
    end)
end

-- ГЛАВНОЕ ОКНО
local targetPosition = UDim2.new(0.5, -320, 0.5, -205)
local hiddenPosition = UDim2.new(0.5, -320, 0.5, 380)

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 640, 0, 410)
mainFrame.Position = hiddenPosition
mainFrame.BackgroundColor3 = Color3.fromRGB(38, 24, 12)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner") mainCorner.CornerRadius = UDim.new(0, 14) mainCorner.Parent = mainFrame

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

-- Боковая панель
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 160, 1, -20)
sidebar.Position = UDim2.new(0, 10, 0, 10)
sidebar.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
sidebar.BackgroundTransparency = 0.3
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 2
sidebar.Parent = contentContainer

local sidebarCorner = Instance.new("UICorner") sidebarCorner.CornerRadius = UDim.new(0, 10) sidebarCorner.Parent = sidebar

local logoTexture = Instance.new("ImageLabel") logoTexture.Size = UDim2.new(0, 20, 0, 20) logoTexture.Position = UDim2.new(0, 10, 0, 17) logoTexture.BackgroundTransparency = 1 logoTexture.Image = TEXTURE_ID logoTexture.ZIndex = 3 logoTexture.Parent = sidebar
local logoLabel = Instance.new("TextLabel") logoLabel.Size = UDim2.new(1, -38, 0, 35) logoLabel.Position = UDim2.new(0, 34, 0, 10) logoLabel.BackgroundTransparency = 1 logoLabel.Font = Enum.Font.GothamBold logoLabel.Text = "MONEYHUB" logoLabel.TextColor3 = Color3.fromRGB(255, 195, 80) logoLabel.TextSize = 14 logoLabel.TextXAlignment = Enum.TextXAlignment.Left logoLabel.ZIndex = 3 logoLabel.Parent = sidebar

-- Вкладка Main
local modulesIconImg = Instance.new("ImageLabel") modulesIconImg.Size = UDim2.new(0, 14, 0, 14) modulesIconImg.Position = UDim2.new(0, 12, 0, 51) modulesIconImg.BackgroundTransparency = 1 modulesIconImg.Image = MODULES_ICON modulesIconImg.ZIndex = 3 modulesIconImg.Parent = sidebar
local modulesHeader = Instance.new("TextLabel") modulesHeader.Size = UDim2.new(1, -32, 0, 20) modulesHeader.Position = UDim2.new(0, 34, 0, 48) modulesHeader.BackgroundTransparency = 1 modulesHeader.Font = Enum.Font.GothamBold modulesHeader.Text = "Modules" modulesHeader.TextColor3 = Color3.fromRGB(210, 150, 90) modulesHeader.TextSize = 11 modulesHeader.TextXAlignment = Enum.TextXAlignment.Left modulesHeader.ZIndex = 3 modulesHeader.Parent = sidebar

local mainTabBtn = Instance.new("TextButton")
mainTabBtn.Size = UDim2.new(1, -20, 0, 30)
mainTabBtn.Position = UDim2.new(0, 10, 0, 72)
mainTabBtn.BackgroundColor3 = Color3.fromRGB(85, 50, 22)
mainTabBtn.BackgroundTransparency = 0.2
mainTabBtn.Text = "          Main"
mainTabBtn.TextColor3 = Color3.fromRGB(255, 225, 180)
mainTabBtn.TextSize = 12
mainTabBtn.Font = Enum.Font.GothamMedium
mainTabBtn.TextXAlignment = Enum.TextXAlignment.Left
mainTabBtn.ZIndex = 3
mainTabBtn.Parent = sidebar

local mainTabCorner = Instance.new("UICorner") mainTabCorner.CornerRadius = UDim.new(0, 6) mainTabCorner.Parent = mainTabBtn
local mainIconImg = Instance.new("ImageLabel") mainIconImg.Size = UDim2.new(0, 14, 0, 14) mainIconImg.Position = UDim2.new(0, 12, 0, 8) mainIconImg.BackgroundTransparency = 1 mainIconImg.Image = MAIN_ICON mainIconImg.ZIndex = 4 mainIconImg.Parent = mainTabBtn

-- Секция Settings
local settingsIconImg = Instance.new("ImageLabel") settingsIconImg.Size = UDim2.new(0, 14, 0, 14) settingsIconImg.Position = UDim2.new(0, 12, 0, 115) settingsIconImg.BackgroundTransparency = 1 settingsIconImg.Image = SETTINGS_ICON settingsIconImg.ZIndex = 3 settingsIconImg.Parent = sidebar
local settingsHeader = Instance.new("TextLabel") settingsHeader.Size = UDim2.new(1, -32, 0, 20) settingsHeader.Position = UDim2.new(0, 34, 0, 112) settingsHeader.BackgroundTransparency = 1 settingsHeader.Font = Enum.Font.GothamBold settingsHeader.Text = "Settings" settingsHeader.TextColor3 = Color3.fromRGB(210, 150, 90) settingsHeader.TextSize = 11 settingsHeader.TextXAlignment = Enum.TextXAlignment.Left settingsHeader.ZIndex = 3 settingsHeader.Parent = sidebar

local visualsTabBtn = Instance.new("TextButton")
visualsTabBtn.Size = UDim2.new(1, -20, 0, 28)
visualsTabBtn.Position = UDim2.new(0, 10, 0, 136)
visualsTabBtn.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
visualsTabBtn.BackgroundTransparency = 0.5
visualsTabBtn.Text = "             Visuals"
visualsTabBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
visualsTabBtn.TextSize = 11
visualsTabBtn.Font = Enum.Font.GothamMedium
visualsTabBtn.TextXAlignment = Enum.TextXAlignment.Left
visualsTabBtn.ZIndex = 3
visualsTabBtn.Parent = sidebar

local visualsTabCorner = Instance.new("UICorner") visualsTabCorner.CornerRadius = UDim.new(0, 6) visualsTabCorner.Parent = visualsTabBtn
local visualsIconImg = Instance.new("ImageLabel") visualsIconImg.Size = UDim2.new(0, 14, 0, 14) visualsIconImg.Position = UDim2.new(0, 12, 0, 7) visualsIconImg.BackgroundTransparency = 1 visualsIconImg.Image = VISUALS_ICON visualsIconImg.ZIndex = 4 visualsIconImg.Parent = visualsTabBtn

local configTabBtn = Instance.new("TextButton")
configTabBtn.Size = UDim2.new(1, -20, 0, 28)
configTabBtn.Position = UDim2.new(0, 10, 0, 170)
configTabBtn.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
configTabBtn.BackgroundTransparency = 0.5
configTabBtn.Text = "             Configs"
configTabBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
configTabBtn.TextSize = 11
configTabBtn.Font = Enum.Font.GothamMedium
configTabBtn.TextXAlignment = Enum.TextXAlignment.Left
configTabBtn.ZIndex = 3
configTabBtn.Parent = sidebar

local configTabCorner = Instance.new("UICorner") configTabCorner.CornerRadius = UDim.new(0, 6) configTabCorner.Parent = configTabBtn
local configIconImg = Instance.new("ImageLabel") configIconImg.Size = UDim2.new(0, 14, 0, 14) configIconImg.Position = UDim2.new(0, 12, 0, 7) configIconImg.BackgroundTransparency = 1 configIconImg.Image = CONFIGS_ICON configIconImg.ZIndex = 4 configIconImg.Parent = configTabBtn

-- Верхняя панель
local topBarArea = Instance.new("Frame")
topBarArea.Name = "TopBarArea"
topBarArea.Size = UDim2.new(1, -190, 0, 45)
topBarArea.Position = UDim2.new(0, 175, 0, 10)
topBarArea.BackgroundTransparency = 1
topBarArea.ZIndex = 2
topBarArea.Parent = contentContainer

local searchBar = Instance.new("Frame")
searchBar.Size = UDim2.new(0, 190, 0, 30)
searchBar.Position = UDim2.new(0, 0, 0, 5)
searchBar.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
searchBar.BackgroundTransparency = 0.3
searchBar.ZIndex = 2
searchBar.Parent = topBarArea

local searchCorner = Instance.new("UICorner") searchCorner.CornerRadius = UDim.new(0, 8) searchCorner.Parent = searchBar
local searchIcon = Instance.new("TextLabel") searchIcon.Size = UDim2.new(0, 25, 1, 0) searchIcon.Position = UDim2.new(0, 8, 0, 0) searchIcon.BackgroundTransparency = 1 searchIcon.Text = "🔍" searchIcon.TextColor3 = Color3.fromRGB(200, 140, 70) searchIcon.TextSize = 12 searchIcon.ZIndex = 3 searchIcon.Parent = searchBar

local searchInput = Instance.new("TextBox")
searchInput.Size = UDim2.new(1, -35, 1, 0)
searchInput.Position = UDim2.new(0, 30, 0, 0)
searchInput.BackgroundTransparency = 1
searchInput.PlaceholderText = "Поиск..."
searchInput.PlaceholderColor3 = Color3.fromRGB(170, 120, 70)
searchInput.Text = ""
searchInput.TextColor3 = Color3.fromRGB(250, 220, 170)
searchInput.TextSize = 12
searchInput.Font = Enum.Font.Gotham
searchInput.ZIndex = 3
searchInput.Parent = searchBar

local profileFrame = Instance.new("Frame")
profileFrame.Size = UDim2.new(0, 130, 0, 30)
profileFrame.Position = UDim2.new(1, -215, 0, 5)
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

local avatarCorner = Instance.new("UICorner") avatarCorner.CornerRadius = UDim.new(1, 0) avatarCorner.Parent = profileAvatar

local minBtn = Instance.new("TextButton")
minBtn.Name = "MinimizeButton"
minBtn.Size = UDim2.new(0, 24, 0, 24)
minBtn.Position = UDim2.new(1, -70, 0, 8)
minBtn.BackgroundColor3 = Color3.fromRGB(65, 38, 20)
minBtn.BackgroundTransparency = 0.3
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(230, 190, 140)
minBtn.TextSize = 14
minBtn.Font = Enum.Font.GothamBold
minBtn.ZIndex = 4
minBtn.Parent = topBarArea

local minCorner = Instance.new("UICorner") minCorner.CornerRadius = UDim.new(0, 6) minCorner.Parent = minBtn

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -40, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(85, 35, 20)
closeBtn.BackgroundTransparency = 0.3
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 150, 120)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.ZIndex = 4
closeBtn.Parent = topBarArea

local closeCorner = Instance.new("UICorner") closeCorner.CornerRadius = UDim.new(0, 6) closeCorner.Parent = closeBtn

local sectionTitle = Instance.new("TextLabel")
sectionTitle.Size = UDim2.new(1, -190, 0, 20)
sectionTitle.Position = UDim2.new(0, 175, 0, 52)
sectionTitle.BackgroundTransparency = 1
sectionTitle.Font = Enum.Font.GothamBold
sectionTitle.Text = "Modules / Main"
sectionTitle.TextColor3 = Color3.fromRGB(190, 135, 75)
sectionTitle.TextSize = 12
sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
sectionTitle.ZIndex = 2
sectionTitle.Parent = contentContainer

-- Контейнеры страниц с UIListLayout для предотвращения дыр и съезжания
local mainPage = Instance.new("ScrollingFrame")
mainPage.Name = "MainPage"
mainPage.Size = UDim2.new(1, -190, 1, -90)
mainPage.Position = UDim2.new(0, 175, 0, 78)
mainPage.BackgroundTransparency = 1
mainPage.CanvasSize = UDim2.new(0, 0, 0, 0)
mainPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
mainPage.ScrollBarThickness = 3
mainPage.Visible = true
mainPage.ZIndex = 2
mainPage.Parent = contentContainer

local mainLayout = Instance.new("UIListLayout")
mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
mainLayout.Padding = UDim.new(0, 10)
mainLayout.Parent = mainPage

local visualsPage = Instance.new("ScrollingFrame")
visualsPage.Name = "VisualsPage"
visualsPage.Size = UDim2.new(1, -190, 1, -90)
visualsPage.Position = UDim2.new(0, 175, 0, 78)
visualsPage.BackgroundTransparency = 1
visualsPage.CanvasSize = UDim2.new(0, 0, 0, 0)
visualsPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
visualsPage.ScrollBarThickness = 3
visualsPage.Visible = false
visualsPage.ZIndex = 2
visualsPage.Parent = contentContainer

local visualsLayout = Instance.new("UIListLayout")
visualsLayout.SortOrder = Enum.SortOrder.LayoutOrder
visualsLayout.Padding = UDim.new(0, 10)
visualsLayout.Parent = visualsPage

local configPage = Instance.new("ScrollingFrame")
configPage.Name = "ConfigPage"
configPage.Size = UDim2.new(1, -190, 1, -90)
configPage.Position = UDim2.new(0, 175, 0, 78)
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

-- Переменные функций
local autoFarmEnabled = false
local aimAssistEnabled = false
local aimTargetPart = "Torso"
local aimSmoothness = 0.2

local speedHackEnabled = false
local walkSpeedValue = 32

local jumpPowerEnabled = false
local jumpPowerValue = 100

local fakeDashEnabled = false
local fakeDashKey = Enum.KeyCode.Q
local fakeDashMobileBtnEnabled = false
local isDashing = false

local snowEnabled = false
local leavesEnabled = false
local fullbrightEnabled = false
local pinkSkyEnabled = false

local originalSky = nil

local setAutoFarmUIState = nil
local setAimAssistUIState = nil
local setSpeedHackUIState = nil
local setJumpPowerUIState = nil
local setFakeDashUIState = nil
local setSnowUIState = nil
local setLeavesUIState = nil
local setFullbrightUIState = nil
local setPinkSkyUIState = nil

local updateAimButtonsVisual = nil
local setAimSliderValue = nil
local setSpeedSliderValue = nil
local setJumpSliderValue = nil

local cardOrderIndex = 0

local function createModuleCard(parent, title, desc, callbackToggle, hasSettings, customSettingsBuilder)
    cardOrderIndex = cardOrderIndex + 1

    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 215, 0, 70)
    card.BackgroundColor3 = Color3.fromRGB(58, 36, 20)
    card.BackgroundTransparency = 0.2
    card.BorderSizePixel = 0
    card.ZIndex = 2
    card.LayoutOrder = cardOrderIndex
    card.Parent = parent

    local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, 10) corner.Parent = card

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

    local tCorner = Instance.new("UICorner") tCorner.CornerRadius = UDim.new(1, 0) tCorner.Parent = toggleFrame
    local toggleDot = Instance.new("Frame") toggleDot.Size = UDim2.new(0, 14, 0, 14) toggleDot.Position = UDim2.new(0, 2, 0, 2) toggleDot.BackgroundColor3 = Color3.fromRGB(150, 115, 80) toggleDot.BorderSizePixel = 0 toggleDot.ZIndex = 4 toggleDot.Parent = toggleFrame
    local dCorner = Instance.new("UICorner") dCorner.CornerRadius = UDim.new(1, 0) dCorner.Parent = toggleDot

    local clickBtn = Instance.new("TextButton") clickBtn.Size = UDim2.new(1, 0, 1, 0) clickBtn.BackgroundTransparency = 1 clickBtn.Text = "" clickBtn.ZIndex = 5 clickBtn.Parent = card

    local isEnabled = false
    local function setVisualState(val, noNotify)
        isEnabled = val
        if isEnabled then
            TweenService:Create(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 120, 0)}):Play()
            TweenService:Create(toggleDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0, 2), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 24, 15)}):Play()
            TweenService:Create(toggleDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color3.fromRGB(150, 115, 80)}):Play()
        end
        if callbackToggle then callbackToggle(isEnabled) end
        if not noNotify then
            local statusStr = isEnabled and "Включено" or "Выключено"
            showNotification(title, statusStr)
        end
    end

    clickBtn.MouseButton1Click:Connect(function()
        setVisualState(not isEnabled, false)
    end)

    if hasSettings then
        local settingsBtn = Instance.new("ImageButton")
        settingsBtn.Size = UDim2.new(0, 16, 0, 16)
        settingsBtn.Position = UDim2.new(1, -64, 0, 12)
        settingsBtn.BackgroundTransparency = 1
        settingsBtn.Image = GEAR_ICON
        settingsBtn.ZIndex = 5
        settingsBtn.Parent = card

        local settingsPanel = Instance.new("Frame")
        settingsPanel.Size = UDim2.new(1, -20, 0, 80)
        settingsPanel.Position = UDim2.new(0, 10, 0, 68)
        settingsPanel.BackgroundTransparency = 1
        settingsPanel.Visible = false
        settingsPanel.ZIndex = 10
        settingsPanel.Parent = card

        if customSettingsBuilder then
            customSettingsBuilder(settingsPanel)
        end

        settingsBtn.MouseButton1Click:Connect(function()
            local isOpen = not settingsPanel.Visible
            settingsPanel.Visible = isOpen
            local targetH = isOpen and 150 or 70
            TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 215, 0, targetH)}):Play()
        end)
    end

    return card, setVisualState
end

-- 1. AutoFarm
_, setAutoFarmUIState = createModuleCard(mainPage, "AutoFarm", "Рандомные удары и способности", function(state)
    autoFarmEnabled = state
end, false)

-- 2. Aim Assist
local setAimUIFunc
_, setAimUIFunc = createModuleCard(mainPage, "Aim Assist", "Автонаведение на цель", function(state)
    aimAssistEnabled = state
end, true, function(panel)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 16)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = "Целься в:"
    lbl.TextColor3 = Color3.fromRGB(250, 220, 170)
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 11
    lbl.Parent = panel

    local torsoBtn = Instance.new("TextButton")
    torsoBtn.Size = UDim2.new(0, 85, 0, 22)
    torsoBtn.Position = UDim2.new(0, 0, 0, 20)
    torsoBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
    torsoBtn.Text = "Туловище"
    torsoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    torsoBtn.TextSize = 10
    torsoBtn.Font = Enum.Font.GothamBold
    torsoBtn.ZIndex = 11
    torsoBtn.Parent = panel
    local tbC = Instance.new("UICorner") tbC.CornerRadius = UDim.new(0, 6) tbC.Parent = torsoBtn

    local headBtn = Instance.new("TextButton")
    headBtn.Size = UDim2.new(0, 85, 0, 22)
    headBtn.Position = UDim2.new(0, 95, 0, 20)
    headBtn.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
    headBtn.Text = "Голова"
    headBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
    headBtn.TextSize = 10
    headBtn.Font = Enum.Font.GothamBold
    headBtn.ZIndex = 11
    headBtn.Parent = panel
    local hbC = Instance.new("UICorner") hbC.CornerRadius = UDim.new(0, 6) hbC.Parent = headBtn

    updateAimButtonsVisual = function(partName)
        if partName == "Torso" then
            torsoBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
            torsoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            headBtn.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
            headBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
        else
            headBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
            headBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            torsoBtn.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
            torsoBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
        end
    end

    torsoBtn.MouseButton1Click:Connect(function() aimTargetPart = "Torso" updateAimButtonsVisual("Torso") end)
    headBtn.MouseButton1Click:Connect(function() aimTargetPart = "Head" updateAimButtonsVisual("Head") end)

    local sliderLbl = Instance.new("TextLabel")
    sliderLbl.Size = UDim2.new(1, 0, 0, 16)
    sliderLbl.Position = UDim2.new(0, 0, 0, 48)
    sliderLbl.BackgroundTransparency = 1
    sliderLbl.Font = Enum.Font.GothamBold
    sliderLbl.Text = "Плавность: Влево (Плавнее) - Вправо (Резче)"
    sliderLbl.TextColor3 = Color3.fromRGB(250, 220, 170)
    sliderLbl.TextSize = 9
    sliderLbl.TextXAlignment = Enum.TextXAlignment.Left
    sliderLbl.ZIndex = 11
    sliderLbl.Parent = panel

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0, 180, 0, 6)
    sliderBg.Position = UDim2.new(0, 5, 0, 72)
    sliderBg.BackgroundColor3 = Color3.fromRGB(40, 24, 15)
    sliderBg.BorderSizePixel = 0
    sliderBg.ZIndex = 11
    sliderBg.Parent = panel
    local sBgCorner = Instance.new("UICorner") sBgCorner.CornerRadius = UDim.new(1,0) sBgCorner.Parent = sliderBg

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 12
    sliderFill.Parent = sliderBg
    local sFillCorner = Instance.new("UICorner") sFillCorner.CornerRadius = UDim.new(1,0) sFillCorner.Parent = sliderFill

    local sliderBtn = Instance.new("TextButton")
    sliderBtn.Size = UDim2.new(1, 20, 1, 20)
    sliderBtn.Position = UDim2.new(0, -10, 0, -10)
    sliderBtn.BackgroundTransparency = 1
    sliderBtn.Text = ""
    sliderBtn.ZIndex = 14
    sliderBtn.Parent = sliderBg

    local draggingSlider = false
    setAimSliderValue = function(val)
        local pos = math.clamp((0.8 - val) / (0.8 - 0.05), 0, 1)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        aimSmoothness = val
    end

    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        aimSmoothness = 0.8 - (pos * 0.75)
    end

    sliderBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSlider = true end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSlider = false end end)
    UserInputService.InputChanged:Connect(function(input) if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSlider(input) end end)

    setAimSliderValue(aimSmoothness)
end)
setAimAssistUIState = setAimUIFunc

-- 3. SpeedHack
local setSpeedUIFunc
_, setSpeedUIFunc = createModuleCard(mainPage, "SpeedHack", "Увеличение скорости бега", function(state)
    speedHackEnabled = state
end, true, function(panel)
    local sliderLbl = Instance.new("TextLabel")
    sliderLbl.Size = UDim2.new(1, 0, 0, 16)
    sliderLbl.Position = UDim2.new(0, 0, 0, 10)
    sliderLbl.BackgroundTransparency = 1
    sliderLbl.Font = Enum.Font.GothamBold
    sliderLbl.Text = "Скорость (16 - 150):"
    sliderLbl.TextColor3 = Color3.fromRGB(250, 220, 170)
    sliderLbl.TextSize = 10
    sliderLbl.TextXAlignment = Enum.TextXAlignment.Left
    sliderLbl.ZIndex = 11
    sliderLbl.Parent = panel

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0, 180, 0, 6)
    sliderBg.Position = UDim2.new(0, 5, 0, 35)
    sliderBg.BackgroundColor3 = Color3.fromRGB(40, 24, 15)
    sliderBg.BorderSizePixel = 0
    sliderBg.ZIndex = 11
    sliderBg.Parent = panel
    local sBgCorner = Instance.new("UICorner") sBgCorner.CornerRadius = UDim.new(1,0) sBgCorner.Parent = sliderBg

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(0.2, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 12
    sliderFill.Parent = sliderBg
    local sFillCorner = Instance.new("UICorner") sFillCorner.CornerRadius = UDim.new(1,0) sFillCorner.Parent = sliderFill

    local sliderBtn = Instance.new("TextButton")
    sliderBtn.Size = UDim2.new(1, 20, 1, 20)
    sliderBtn.Position = UDim2.new(0, -10, 0, -10)
    sliderBtn.BackgroundTransparency = 1
    sliderBtn.Text = ""
    sliderBtn.ZIndex = 14
    sliderBtn.Parent = sliderBg

    local draggingSpeed = false
    setSpeedSliderValue = function(val)
        local pos = math.clamp((val - 16) / (150 - 16), 0, 1)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        walkSpeedValue = val
    end

    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        walkSpeedValue = math.floor(16 + (pos * (150 - 16)))
    end

    sliderBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSpeed = true end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSpeed = false end end)
    UserInputService.InputChanged:Connect(function(input) if draggingSpeed and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSlider(input) end end)

    setSpeedSliderValue(walkSpeedValue)
end)
setSpeedHackUIState = setSpeedUIFunc

-- 4. JumpPower (Исправлен)
local setJumpUIFunc
_, setJumpUIFunc = createModuleCard(mainPage, "JumpPower", "Увеличение высоты прыжка", function(state)
    jumpPowerEnabled = state
end, true, function(panel)
    local sliderLbl = Instance.new("TextLabel")
    sliderLbl.Size = UDim2.new(1, 0, 0, 16)
    sliderLbl.Position = UDim2.new(0, 0, 0, 10)
    sliderLbl.BackgroundTransparency = 1
    sliderLbl.Font = Enum.Font.GothamBold
    sliderLbl.Text = "Прыжок (50 - 300):"
    sliderLbl.TextColor3 = Color3.fromRGB(250, 220, 170)
    sliderLbl.TextSize = 10
    sliderLbl.TextXAlignment = Enum.TextXAlignment.Left
    sliderLbl.ZIndex = 11
    sliderLbl.Parent = panel

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0, 180, 0, 6)
    sliderBg.Position = UDim2.new(0, 5, 0, 35)
    sliderBg.BackgroundColor3 = Color3.fromRGB(40, 24, 15)
    sliderBg.BorderSizePixel = 0
    sliderBg.ZIndex = 11
    sliderBg.Parent = panel
    local sBgCorner = Instance.new("UICorner") sBgCorner.CornerRadius = UDim.new(1,0) sBgCorner.Parent = sliderBg

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(0.2, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 12
    sliderFill.Parent = sliderBg
    local sFillCorner = Instance.new("UICorner") sFillCorner.CornerRadius = UDim.new(1,0) sFillCorner.Parent = sliderFill

    local sliderBtn = Instance.new("TextButton")
    sliderBtn.Size = UDim2.new(1, 20, 1, 20)
    sliderBtn.Position = UDim2.new(0, -10, 0, -10)
    sliderBtn.BackgroundTransparency = 1
    sliderBtn.Text = ""
    sliderBtn.ZIndex = 14
    sliderBtn.Parent = sliderBg

    local draggingJump = false
    setJumpSliderValue = function(val)
        local pos = math.clamp((val - 50) / (300 - 50), 0, 1)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        jumpPowerValue = val
    end

    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        jumpPowerValue = math.floor(50 + (pos * (300 - 50)))
    end

    sliderBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingJump = true end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingJump = false end end)
    UserInputService.InputChanged:Connect(function(input) if draggingJump and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSlider(input) end end)

    setJumpSliderValue(jumpPowerValue)
end)
setJumpPowerUIState = setJumpUIFunc

-- Функция перетаскивания объектов
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

-- Плавающая мобильная кнопка Fake Dash
local mobileDashBtn = Instance.new("Frame")
mobileDashBtn.Name = "MobileDashBtn"
mobileDashBtn.Size = UDim2.new(0, 60, 0, 60)
mobileDashBtn.Position = UDim2.new(0.8, 0, 0.6, 0)
mobileDashBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
mobileDashBtn.BackgroundTransparency = 0.2
mobileDashBtn.Visible = false
mobileDashBtn.ZIndex = 200
mobileDashBtn.Parent = screenGui

local mdCorner = Instance.new("UICorner") mdCorner.CornerRadius = UDim.new(1, 0) mdCorner.Parent = mobileDashBtn
local mdLbl = Instance.new("TextLabel") mdLbl.Size = UDim2.new(1, 0, 1, 0) mdLbl.BackgroundTransparency = 1 mdLbl.Font = Enum.Font.GothamBold mdLbl.Text = "DASH" mdLbl.TextColor3 = Color3.fromRGB(255, 255, 255) mdLbl.TextSize = 13 mdLbl.ZIndex = 201 mdLbl.Parent = mobileDashBtn
local mdClick = Instance.new("TextButton") mdClick.Size = UDim2.new(1, 0, 1, 0) mdClick.BackgroundTransparency = 1 mdClick.Text = "" mdClick.ZIndex = 202 mdClick.Parent = mobileDashBtn

enableDragging(mobileDashBtn, mobileDashBtn)

local performFakeDash -- объявление заранее

mdClick.MouseButton1Click:Connect(function()
    if fakeDashEnabled and performFakeDash then
        performFakeDash()
    end
end)

-- 5. Fake Dash + Настройка моб. кнопки
local setDashUIFunc
_, setDashUIFunc = createModuleCard(mainPage, "Fake Dash", "Анимация и перемещение рывка без урона", function(state)
    fakeDashEnabled = state
    if not fakeDashEnabled then
        mobileDashBtn.Visible = false
    else
        mobileDashBtn.Visible = fakeDashMobileBtnEnabled
    end
end, true, function(panel)
    local keyLbl = Instance.new("TextLabel")
    keyLbl.Size = UDim2.new(1, 0, 0, 16)
    keyLbl.Position = UDim2.new(0, 0, 0, 2)
    keyLbl.BackgroundTransparency = 1
    keyLbl.Font = Enum.Font.GothamBold
    keyLbl.Text = "Клавиша рывка (ПК):"
    keyLbl.TextColor3 = Color3.fromRGB(250, 220, 170)
    keyLbl.TextSize = 10
    keyLbl.TextXAlignment = Enum.TextXAlignment.Left
    keyLbl.ZIndex = 11
    keyLbl.Parent = panel

    local keyBtn = Instance.new("TextButton")
    keyBtn.Size = UDim2.new(0, 90, 0, 22)
    keyBtn.Position = UDim2.new(0, 0, 0, 20)
    keyBtn.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
    keyBtn.Text = "[" .. fakeDashKey.Name .. "]"
    keyBtn.TextColor3 = Color3.fromRGB(255, 180, 90)
    keyBtn.TextSize = 10
    keyBtn.Font = Enum.Font.GothamBold
    keyBtn.ZIndex = 11
    keyBtn.Parent = panel
    local kbC = Instance.new("UICorner") kbC.CornerRadius = UDim.new(0, 6) kbC.Parent = keyBtn

    local listeningForKey = false
    keyBtn.MouseButton1Click:Connect(function()
        listeningForKey = true
        keyBtn.Text = "[Жми...]"
        keyBtn.TextColor3 = Color3.fromRGB(255, 120, 0)
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if listeningForKey and input.UserInputType == Enum.UserInputType.Keyboard then
            listeningForKey = false
            fakeDashKey = input.KeyCode
            keyBtn.Text = "[" .. fakeDashKey.Name .. "]"
            keyBtn.TextColor3 = Color3.fromRGB(255, 180, 90)
        end
    end)

    -- Тумблер мобильной кнопки
    local mobBtnToggle = Instance.new("TextButton")
    mobBtnToggle.Size = UDim2.new(0, 180, 0, 24)
    mobBtnToggle.Position = UDim2.new(0, 0, 0, 48)
    mobBtnToggle.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
    mobBtnToggle.Text = "Кнопка на экран (для моб.): OFF"
    mobBtnToggle.TextColor3 = Color3.fromRGB(200, 160, 120)
    mobBtnToggle.TextSize = 9
    mobBtnToggle.Font = Enum.Font.GothamBold
    mobBtnToggle.ZIndex = 11
    mobBtnToggle.Parent = panel
    local mbtC = Instance.new("UICorner") mbtC.CornerRadius = UDim.new(0, 6) mbtC.Parent = mobBtnToggle

    mobBtnToggle.MouseButton1Click:Connect(function()
        fakeDashMobileBtnEnabled = not fakeDashMobileBtnEnabled
        if fakeDashMobileBtnEnabled then
            mobBtnToggle.Text = "Кнопка на экран (для моб.): ON"
            mobBtnToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            mobBtnToggle.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
            if fakeDashEnabled then mobileDashBtn.Visible = true end
        else
            mobBtnToggle.Text = "Кнопка на экран (для моб.): OFF"
            mobBtnToggle.TextColor3 = Color3.fromRGB(200, 160, 120)
            mobBtnToggle.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
            mobileDashBtn.Visible = false
        end
    end)
end)
setFakeDashUIState = setDashUIFunc

-- Логика Fake Dash
performFakeDash = function()
    local char = player.Character
    if not char or isDashing then return end

    local root = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid then return end

    isDashing = true

    local animator = humanoid:FindFirstChildOfClass("Animator")
    if animator then
        local dashAnim = Instance.new("Animation")
        dashAnim.AnimationId = "rbxassetid://10479335381"
        local track = animator:LoadAnimation(dashAnim)
        track.Priority = Enum.AnimationPriority.Action
        track:Play()
    end

    local moveDir = humanoid.MoveDirection
    if moveDir.Magnitude == 0 then
        moveDir = root.CFrame.LookVector
    end

    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
    bodyVelocity.Velocity = moveDir * 65
    bodyVelocity.Parent = root

    task.wait(0.25)
    bodyVelocity:Destroy()
    isDashing = false
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if fakeDashEnabled and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == fakeDashKey then
        performFakeDash()
    end
end)

-- Visuals
_, setSnowUIState = createModuleCard(visualsPage, "Snow (Пыль)", "Плавные круглые точки снега", function(state)
    snowEnabled = state
end, false)

_, setLeavesUIState = createModuleCard(visualsPage, "Leaves 🍁", "Падающие осенние листья", function(state)
    leavesEnabled = state
end, false)

_, setFullbrightUIState = createModuleCard(visualsPage, "Fullbright", "Максимально светлое освещение карты", function(state)
    fullbrightEnabled = state
    if fullbrightEnabled then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
        Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
    end
end, false)

-- Функция Pink Sky 🌸
_, setPinkSkyUIState = createModuleCard(visualsPage, "Pink Sky 🌸", "Розовое красиво оформленное небо", function(state)
    pinkSkyEnabled = state
    local currentSky = Lighting:FindFirstChildOfClass("Sky")

    if pinkSkyEnabled then
        if currentSky and currentSky.Name ~= "MoneyHubPinkSky" then
            originalSky = currentSky:Clone()
            currentSky:Destroy()
        end

        local newSky = Instance.new("Sky")
        newSky.Name = "MoneyHubPinkSky"
        newSky.SkyboxBk = PINK_SKY_ID
        newSky.SkyboxDn = PINK_SKY_ID
        newSky.SkyboxFt = PINK_SKY_ID
        newSky.SkyboxLf = PINK_SKY_ID
        newSky.SkyboxRt = PINK_SKY_ID
        newSky.SkyboxUp = PINK_SKY_ID
        newSky.Parent = Lighting
    else
        local customSky = Lighting:FindFirstChild("MoneyHubPinkSky")
        if customSky then customSky:Destroy() end
        if originalSky then
            originalSky.Parent = Lighting
        end
    end
end, false)

-- МЕНЕДЖЕР КОНФИГОВ
local configsFolder = "MoneyHubConfigs"

local configNameBox = Instance.new("TextBox")
configNameBox.Size = UDim2.new(0, 140, 0, 28)
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
createCfgBtn.Size = UDim2.new(0, 75, 0, 28)
createCfgBtn.Position = UDim2.new(0, 145, 0, 10)
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
configListContainer.Size = UDim2.new(1, 0, 0, 240)
configListContainer.Position = UDim2.new(0, 0, 0, 50)
configListContainer.BackgroundTransparency = 1
configListContainer.BorderSizePixel = 0
configListContainer.ScrollBarThickness = 3
configListContainer.ZIndex = 2
configListContainer.Parent = configPage

local function refreshConfigList()
    for _, ch in ipairs(configListContainer:GetChildren()) do ch:Destroy() end
    if not isfolder(configsFolder) then makefolder(configsFolder) end
    local files = listfiles(configsFolder)
    local yOffset = 0
    
    for _, file in ipairs(files) do
        local cfgName = file:match("([^/]+)$"):gsub(".json", "")
        
        local itemFrame = Instance.new("Frame")
        itemFrame.Size = UDim2.new(1, -5, 0, 36)
        itemFrame.Position = UDim2.new(0, 0, 0, yOffset)
        itemFrame.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
        itemFrame.BackgroundTransparency = 0.3
        itemFrame.ZIndex = 3
        itemFrame.Parent = configListContainer
        
        local itCorner = Instance.new("UICorner") itCorner.CornerRadius = UDim.new(0, 6) itCorner.Parent = itemFrame
        
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0, 130, 1, 0)
        lbl.Position = UDim2.new(0, 10, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = cfgName
        lbl.TextColor3 = Color3.fromRGB(255, 220, 170)
        lbl.TextSize = 11
        lbl.Font = Enum.Font.GothamBold
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 4
        lbl.Parent = itemFrame
        
        local saveBtn = Instance.new("ImageButton")
        saveBtn.Size = UDim2.new(0, 24, 0, 24)
        saveBtn.Position = UDim2.new(1, -100, 0, 6)
        saveBtn.BackgroundTransparency = 1
        saveBtn.Image = SAVE_ICON
        saveBtn.ZIndex = 4
        saveBtn.Parent = itemFrame
        
        local loadBtn = Instance.new("ImageButton")
        loadBtn.Size = UDim2.new(0, 24, 0, 24)
        loadBtn.Position = UDim2.new(1, -66, 0, 6)
        loadBtn.BackgroundTransparency = 1
        loadBtn.Image = IMPORT_ICON
        loadBtn.ZIndex = 4
        loadBtn.Parent = itemFrame
        
        local delBtn = Instance.new("ImageButton")
        delBtn.Size = UDim2.new(0, 24, 0, 24)
        delBtn.Position = UDim2.new(1, -32, 0, 6)
        delBtn.BackgroundTransparency = 1
        delBtn.Image = DELETE_ICON
        delBtn.ZIndex = 4
        delBtn.Parent = itemFrame
        
        saveBtn.MouseButton1Click:Connect(function()
            local data = { 
                AutoFarm = autoFarmEnabled, 
                AimAssist = aimAssistEnabled, 
                AimTarget = aimTargetPart, 
                AimSmoothness = aimSmoothness,
                SpeedHack = speedHackEnabled,
                WalkSpeed = walkSpeedValue,
                JumpPowerEnabled = jumpPowerEnabled,
                JumpPowerVal = jumpPowerValue,
                FakeDashEnabled = fakeDashEnabled,
                FakeDashKeyName = fakeDashKey.Name,
                FakeDashMobile = fakeDashMobileBtnEnabled,
                Snow = snowEnabled, 
                Leaves = leavesEnabled,
                Fullbright = fullbrightEnabled,
                PinkSky = pinkSkyEnabled
            }
            writefile(configsFolder .. "/" .. cfgName .. ".json", HttpService:JSONEncode(data))
            showNotification("Configs", "Сохранено: " .. cfgName)
        end)
        
        loadBtn.MouseButton1Click:Connect(function()
            pcall(function()
                local content = readfile(configsFolder .. "/" .. cfgName .. ".json")
                local data = HttpService:JSONDecode(content)
                
                autoFarmEnabled = data.AutoFarm or false
                if setAutoFarmUIState then setAutoFarmUIState(autoFarmEnabled, true) end
                
                aimAssistEnabled = data.AimAssist or false
                if setAimAssistUIState then setAimAssistUIState(aimAssistEnabled, true) end
                
                aimTargetPart = data.AimTarget or "Torso"
                if updateAimButtonsVisual then updateAimButtonsVisual(aimTargetPart) end

                aimSmoothness = data.AimSmoothness or 0.2
                if setAimSliderValue then setAimSliderValue(aimSmoothness) end

                speedHackEnabled = data.SpeedHack or false
                if setSpeedHackUIState then setSpeedHackUIState(speedHackEnabled, true) end

                walkSpeedValue = data.WalkSpeed or 32
                if setSpeedSliderValue then setSpeedSliderValue(walkSpeedValue) end

                jumpPowerEnabled = data.JumpPowerEnabled or false
                if setJumpPowerUIState then setJumpPowerUIState(jumpPowerEnabled, true) end

                jumpPowerValue = data.JumpPowerVal or 100
                if setJumpSliderValue then setJumpSliderValue(jumpPowerValue) end

                fakeDashEnabled = data.FakeDashEnabled or false
                if setFakeDashUIState then setFakeDashUIState(fakeDashEnabled, true) end

                fakeDashMobileBtnEnabled = data.FakeDashMobile or false
                if fakeDashEnabled then mobileDashBtn.Visible = fakeDashMobileBtnEnabled end

                if data.FakeDashKeyName and Enum.KeyCode[data.FakeDashKeyName] then
                    fakeDashKey = Enum.KeyCode[data.FakeDashKeyName]
                end
                
                snowEnabled = data.Snow or false
                if setSnowUIState then setSnowUIState(snowEnabled, true) end
                
                leavesEnabled = data.Leaves or false
                if setLeavesUIState then setLeavesUIState(leavesEnabled, true) end

                fullbrightEnabled = data.Fullbright or false
                if setFullbrightUIState then setFullbrightUIState(fullbrightEnabled, true) end

                pinkSkyEnabled = data.PinkSky or false
                if setPinkSkyUIState then setPinkSkyUIState(pinkSkyEnabled, true) end
                
                showNotification("Configs", "Загружено: " .. cfgName)
            end)
        end)
        
        delBtn.MouseButton1Click:Connect(function()
            if delfile then
                delfile(configsFolder .. "/" .. cfgName .. ".json")
                refreshConfigList()
                showNotification("Configs", "Удалено: " .. cfgName)
            end
        end)
        
        yOffset = yOffset + 42
    end
    configListContainer.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

createCfgBtn.MouseButton1Click:Connect(function()
    local name = configNameBox.Text
    if name and name ~= "" then
        if not isfolder(configsFolder) then makefolder(configsFolder) end
        writefile(configsFolder .. "/" .. name .. ".json", HttpService:JSONEncode({ AutoFarm = false, AimAssist = false, AimTarget = "Torso", AimSmoothness = 0.2, SpeedHack = false, WalkSpeed = 32, JumpPowerEnabled = false, JumpPowerVal = 100, FakeDashEnabled = false, FakeDashKeyName = "Q", FakeDashMobile = false, Snow = false, Leaves = false, Fullbright = false, PinkSky = false }))
        configNameBox.Text = ""
        refreshConfigList()
        showNotification("Configs", "Создан конфиг")
    end
end)

refreshConfigList()

-- ЭФФЕКТЫ СНЕГА И ЛИСТЬЕВ 🍁
local particles = {}
for i = 1, 26 do
    local snow = Instance.new("Frame")
    snow.Size = UDim2.new(0, math.random(3, 5), 0, math.random(3, 5))
    snow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    snow.BackgroundTransparency = 0.3
    snow.Visible = false
    snow.Parent = effectsContainer
    local sC = Instance.new("UICorner") sC.CornerRadius = UDim.new(1, 0) sC.Parent = snow

    local leaf = Instance.new("TextLabel")
    leaf.Size = UDim2.new(0, 16, 0, 16)
    leaf.BackgroundTransparency = 1
    leaf.Font = Enum.Font.GothamBold
    leaf.Text = "🍁"
    leaf.TextSize = math.random(10, 15)
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

-- ИСПОЛНЕНИЕ ЛОГИКИ SPEEDHACK, JUMPPOWER, AIM И AUTOFARM
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
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        if speedHackEnabled then
            humanoid.WalkSpeed = walkSpeedValue
        end
        if jumpPowerEnabled then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = jumpPowerValue
            humanoid.JumpHeight = jumpPowerValue / 7 -- Поддержка режима JumpHeight в играх
        end
    end

    local myRoot = char:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    local target = getClosestPlayer()
    currentTarget = target

    if aimAssistEnabled and target and target.Character then
        local aimPart = target.Character:FindFirstChild(aimTargetPart) or target.Character:FindFirstChild("HumanoidRootPart") or target.Character:FindFirstChild("Torso")
        if aimPart then
            camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, aimPart.Position), aimSmoothness)
        end
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

enableDragging(mainFrame, topBarArea)

-- Кнопка сворачивания
local floatBtn = Instance.new("Frame")
floatBtn.Size = UDim2.new(0, 36, 0, 36)
floatBtn.Position = UDim2.new(0.5, -18, 0, -50)
floatBtn.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
floatBtn.BackgroundTransparency = 0.15
floatBtn.Visible = false
floatBtn.ZIndex = 100
floatBtn.Parent = screenGui

local floatCorner = Instance.new("UICorner") floatCorner.CornerRadius = UDim.new(1, 0) floatCorner.Parent = floatBtn
local floatTexture = Instance.new("ImageLabel") floatTexture.Size = UDim2.new(0, 22, 0, 22) floatTexture.Position = UDim2.new(0.5, -11, 0.5, -11) floatTexture.BackgroundTransparency = 1 floatTexture.Image = TEXTURE_ID floatTexture.ZIndex = 101 floatTexture.Parent = floatBtn
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
    floatBtn.Position = UDim2.new(0.5, -18, 0, -50)
    TweenService:Create(floatBtn, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -18, 0.05, 0)}):Play()
end)

floatClick.MouseButton1Click:Connect(function()
    TweenService:Create(floatBtn, TweenInfo.new(0.2), {Position = UDim2.new(0.5, -18, 0, -50)}):Play()
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
