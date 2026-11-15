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
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

local TEXTURE_ID = "rbxassetid://9343433823"
local MODULES_ICON = "rbxassetid://82633060732202"
local SETTINGS_ICON = "rbxassetid://138028255370142"
local MAIN_ICON = "rbxassetid://14502433595"
local VISUALS_ICON = "rbxassetid://11322089611"
local LANGUAGE_ICON = "rbxassetid://84460102482950"
local CONFIGS_ICON = "rbxassetid://90837140373377"
local GEAR_ICON = "rbxassetid://6953984741"

local SAVE_ICON = "rbxassetid://11768914234"
local IMPORT_ICON = "rbxassetid://6953990743"
local DELETE_ICON = "rbxassetid://11768918600"

local SAFE_COORDS = Vector3.new(-200.7, 675.7, 357.3)

if playerGui:FindFirstChild("MoneyHubGui") then
    playerGui.MoneyHubGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MoneyHubGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    if syn and syn.protect_gui then
        syn.protect_gui(screenGui)
        screenGui.Parent = CoreGui
    elseif gethui then
        screenGui.Parent = gethui()
    else
        screenGui.Parent = playerGui
    end
end)
if not screenGui.Parent then screenGui.Parent = playerGui end

local function playEnableSound()
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://139421450430380"
        sound.Volume = 1
        sound.Parent = SoundService
        sound:Play()
        task.delay(2, function()
            sound:Destroy()
        end)
    end)
end

-- СПЕЦИАЛЬНОЕ УВЕДОМЛЕНИЕ ДЛЯ ОШИБКИ ВЫБОРА СПОСОБНОСТИ
local function showAbilityErrorNotification(onCompleted)
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://109149869070031"
        sound.Volume = 1
        sound.Parent = SoundService
        sound:Play()
        task.delay(2, function() sound:Destroy() end)
    end)

    local errContainer = Instance.new("Frame")
    errContainer.Size = UDim2.new(0, 320, 0, 50)
    errContainer.Position = UDim2.new(0.5, -160, 1, 70)
    errContainer.BackgroundTransparency = 1
    errContainer.ZIndex = 600
    errContainer.Parent = screenGui

    local errBg = Instance.new("Frame")
    errBg.Size = UDim2.new(1, 0, 1, 0)
    errBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    errBg.BackgroundTransparency = 0.05
    errBg.BorderSizePixel = 0
    errBg.ZIndex = 601
    errBg.Parent = errContainer

    local errCorner = Instance.new("UICorner")
    errCorner.CornerRadius = UDim.new(0, 12)
    errCorner.Parent = errBg

    local errGradient = Instance.new("UIGradient")
    errGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 120)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 20, 20))
    })
    errGradient.Parent = errBg

    local errIcon = Instance.new("ImageLabel")
    errIcon.Size = UDim2.new(0, 26, 0, 26)
    errIcon.Position = UDim2.new(0, 14, 0.5, -13)
    errIcon.BackgroundTransparency = 1
    errIcon.Image = "rbxassetid://12633679807"
    errIcon.ZIndex = 602
    errIcon.Parent = errBg

    local errLbl = Instance.new("TextLabel")
    errLbl.Size = UDim2.new(1, -55, 1, 0)
    errLbl.Position = UDim2.new(0, 50, 0, 0)
    errLbl.BackgroundTransparency = 1
    errLbl.Font = Enum.Font.GothamBold
    errLbl.Text = "Выберите способность"
    errLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    errLbl.TextSize = 13
    errLbl.TextXAlignment = Enum.TextXAlignment.Left
    errLbl.ZIndex = 602
    errLbl.Parent = errBg

    TweenService:Create(errContainer, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -160, 1, -80)
    }):Play()

    task.delay(3.0, function()
        local tw = TweenService:Create(errContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -160, 1, 70),
            BackgroundTransparency = 1
        })
        tw:Play()
        tw.Completed:Connect(function()
            errContainer:Destroy()
            if onCompleted then onCompleted() end
        end)
    end)
end

-- СТАНДАРТНЫЕ УВЕДОМЛЕНИЯ
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
local logoLabel = Instance.new("TextLabel") logoLabel.Size = UDim2.new(1, -38, 0, 20) logoLabel.Position = UDim2.new(0, 34, 0, 10) logoLabel.BackgroundTransparency = 1 logoLabel.Font = Enum.Font.GothamBold logoLabel.Text = "MONEYHUB" logoLabel.TextColor3 = Color3.fromRGB(255, 195, 80) logoLabel.TextSize = 14 logoLabel.TextXAlignment = Enum.TextXAlignment.Left logoLabel.ZIndex = 3 logoLabel.Parent = sidebar

local versionLabel = Instance.new("TextLabel")
versionLabel.Name = "VersionLabel"
versionLabel.Size = UDim2.new(1, -38, 0, 16)
versionLabel.Position = UDim2.new(0, 34, 0, 28)
versionLabel.BackgroundTransparency = 1
versionLabel.Font = Enum.Font.GothamBold
versionLabel.Text = "v0.1"
versionLabel.TextColor3 = Color3.fromRGB(180, 130, 80)
versionLabel.TextSize = 10
versionLabel.TextXAlignment = Enum.TextXAlignment.Left
versionLabel.ZIndex = 3
versionLabel.Parent = sidebar

-- СЕКЦИЯ MODULES (Main + Visuals)
local modulesIconImg = Instance.new("ImageLabel") modulesIconImg.Size = UDim2.new(0, 14, 0, 14) modulesIconImg.Position = UDim2.new(0, 12, 0, 55) modulesIconImg.BackgroundTransparency = 1 modulesIconImg.Image = MODULES_ICON modulesIconImg.ZIndex = 3 modulesIconImg.Parent = sidebar
local modulesHeader = Instance.new("TextLabel") modulesHeader.Size = UDim2.new(1, -32, 0, 20) modulesHeader.Position = UDim2.new(0, 34, 0, 52) modulesHeader.BackgroundTransparency = 1 modulesHeader.Font = Enum.Font.GothamBold modulesHeader.Text = "Modules" modulesHeader.TextColor3 = Color3.fromRGB(210, 150, 90) modulesHeader.TextSize = 11 modulesHeader.TextXAlignment = Enum.TextXAlignment.Left modulesHeader.ZIndex = 3 modulesHeader.Parent = sidebar

local mainTabBtn = Instance.new("TextButton")
mainTabBtn.Size = UDim2.new(1, -20, 0, 26)
mainTabBtn.Position = UDim2.new(0, 10, 0, 75)
mainTabBtn.BackgroundColor3 = Color3.fromRGB(85, 50, 22)
mainTabBtn.BackgroundTransparency = 0.2
mainTabBtn.Text = "             Main"
mainTabBtn.TextColor3 = Color3.fromRGB(255, 225, 180)
mainTabBtn.TextSize = 11
mainTabBtn.Font = Enum.Font.GothamMedium
mainTabBtn.TextXAlignment = Enum.TextXAlignment.Left
mainTabBtn.ZIndex = 3
mainTabBtn.Parent = sidebar

local mainTabCorner = Instance.new("UICorner") mainTabCorner.CornerRadius = UDim.new(0, 6) mainTabCorner.Parent = mainTabBtn
local mainIconImg = Instance.new("ImageLabel") mainIconImg.Size = UDim2.new(0, 14, 0, 14) mainIconImg.Position = UDim2.new(0, 12, 0, 6) mainIconImg.BackgroundTransparency = 1 mainIconImg.Image = MAIN_ICON mainIconImg.ZIndex = 4 mainIconImg.Parent = mainTabBtn

local visualsTabBtn = Instance.new("TextButton")
visualsTabBtn.Size = UDim2.new(1, -20, 0, 26)
visualsTabBtn.Position = UDim2.new(0, 10, 0, 105)
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
local visualsIconImg = Instance.new("ImageLabel") visualsIconImg.Size = UDim2.new(0, 14, 0, 14) visualsIconImg.Position = UDim2.new(0, 12, 0, 6) visualsIconImg.BackgroundTransparency = 1 visualsIconImg.Image = VISUALS_ICON visualsIconImg.ZIndex = 4 visualsIconImg.Parent = visualsTabBtn

-- СЕКЦИЯ SETTINGS (Language + Configs)
local settingsIconImg = Instance.new("ImageLabel") settingsIconImg.Size = UDim2.new(0, 14, 0, 14) settingsIconImg.Position = UDim2.new(0, 12, 0, 144) settingsIconImg.BackgroundTransparency = 1 settingsIconImg.Image = SETTINGS_ICON settingsIconImg.ZIndex = 3 settingsIconImg.Parent = sidebar
local settingsHeader = Instance.new("TextLabel") settingsHeader.Size = UDim2.new(1, -32, 0, 20) settingsHeader.Position = UDim2.new(0, 34, 0, 141) settingsHeader.BackgroundTransparency = 1 settingsHeader.Font = Enum.Font.GothamBold settingsHeader.Text = "Settings" settingsHeader.TextColor3 = Color3.fromRGB(210, 150, 90) settingsHeader.TextSize = 11 settingsHeader.TextXAlignment = Enum.TextXAlignment.Left settingsHeader.ZIndex = 3 settingsHeader.Parent = sidebar

local languageTabBtn = Instance.new("TextButton")
languageTabBtn.Size = UDim2.new(1, -20, 0, 26)
languageTabBtn.Position = UDim2.new(0, 10, 0, 165)
languageTabBtn.BackgroundColor3 = Color3.fromRGB(54, 34, 18)
languageTabBtn.BackgroundTransparency = 0.5
languageTabBtn.Text = "             Language"
languageTabBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
languageTabBtn.TextSize = 11
languageTabBtn.Font = Enum.Font.GothamMedium
languageTabBtn.TextXAlignment = Enum.TextXAlignment.Left
languageTabBtn.ZIndex = 3
languageTabBtn.Parent = sidebar

local languageTabCorner = Instance.new("UICorner") languageTabCorner.CornerRadius = UDim.new(0, 6) languageTabCorner.Parent = languageTabBtn
local languageIconImg = Instance.new("ImageLabel") languageIconImg.Size = UDim2.new(0, 14, 0, 14) languageIconImg.Position = UDim2.new(0, 12, 0, 6) languageIconImg.BackgroundTransparency = 1 languageIconImg.Image = LANGUAGE_ICON languageIconImg.ZIndex = 4 languageIconImg.Parent = languageTabBtn

local configTabBtn = Instance.new("TextButton")
configTabBtn.Size = UDim2.new(1, -20, 0, 26)
configTabBtn.Position = UDim2.new(0, 10, 0, 195)
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
local configIconImg = Instance.new("ImageLabel") configIconImg.Size = UDim2.new(0, 14, 0, 14) configIconImg.Position = UDim2.new(0, 12, 0, 6) configIconImg.BackgroundTransparency = 1 configIconImg.Image = CONFIGS_ICON configIconImg.ZIndex = 4 configIconImg.Parent = configTabBtn

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
profileFrame.Size = UDim2.new(0, 140, 0, 30)
profileFrame.Position = UDim2.new(1, -210, 0, 5)
profileFrame.BackgroundTransparency = 1
profileFrame.ZIndex = 5
profileFrame.Parent = topBarArea

local profileName = Instance.new("TextLabel")
profileName.Size = UDim2.new(1, -35, 1, 0)
profileName.Position = UDim2.new(0, 0, 0, 0)
profileName.BackgroundTransparency = 1
profileName.Font = Enum.Font.GothamBold
profileName.Text = player.DisplayName
profileName.TextColor3 = Color3.fromRGB(250, 220, 170)
profileName.TextSize = 11
profileName.TextXAlignment = Enum.TextXAlignment.Right
profileName.ZIndex = 6
profileName.Parent = profileFrame

local profileAvatar = Instance.new("ImageLabel")
profileAvatar.Size = UDim2.new(0, 24, 0, 24)
profileAvatar.Position = UDim2.new(1, -26, 0, 3)
profileAvatar.BackgroundColor3 = Color3.fromRGB(60, 35, 18)
profileAvatar.BorderSizePixel = 0
profileAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150"
profileAvatar.ZIndex = 6
profileAvatar.Parent = profileFrame

local avatarCorner = Instance.new("UICorner") avatarCorner.CornerRadius = UDim.new(1, 0) avatarCorner.Parent = profileAvatar

local minBtn = Instance.new("TextButton")
minBtn.Name = "MinimizeButton"
minBtn.Size = UDim2.new(0, 24, 0, 24)
minBtn.Position = UDim2.new(1, -65, 0, 8)
minBtn.BackgroundColor3 = Color3.fromRGB(65, 38, 20)
minBtn.BackgroundTransparency = 0.3
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(230, 190, 140)
minBtn.TextSize = 14
minBtn.Font = Enum.Font.GothamBold
minBtn.ZIndex = 10
minBtn.Parent = topBarArea

local minCorner = Instance.new("UICorner") minCorner.CornerRadius = UDim.new(0, 6) minCorner.Parent = minBtn

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -35, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(85, 35, 20)
closeBtn.BackgroundTransparency = 0.3
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 150, 120)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.ZIndex = 10
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

-- Страницы
local mainPage = Instance.new("ScrollingFrame")
mainPage.Name = "MainPage"
mainPage.Size = UDim2.new(1, -190, 1, -90)
mainPage.Position = UDim2.new(0, 175, 0, 78)
mainPage.BackgroundTransparency = 1
mainPage.CanvasSize = UDim2.new(0, 0, 0, 0)
mainPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
mainPage.ScrollBarThickness = 4
mainPage.Visible = true
mainPage.ZIndex = 2
mainPage.Parent = contentContainer

local mainLayout = Instance.new("UIListLayout")
mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
mainLayout.Padding = UDim.new(0, 10)
mainLayout.Parent = mainPage

local mainPadding = Instance.new("UIPadding")
mainPadding.PaddingBottom = UDim.new(0, 30)
mainPadding.PaddingRight = UDim.new(0, 5)
mainPadding.Parent = mainPage

local visualsPage = Instance.new("ScrollingFrame")
visualsPage.Name = "VisualsPage"
visualsPage.Size = UDim2.new(1, -190, 1, -90)
visualsPage.Position = UDim2.new(0, 175, 0, 78)
visualsPage.BackgroundTransparency = 1
visualsPage.CanvasSize = UDim2.new(0, 0, 0, 0)
visualsPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
visualsPage.ScrollBarThickness = 4
visualsPage.Visible = false
visualsPage.ZIndex = 2
visualsPage.Parent = contentContainer

local visualsLayout = Instance.new("UIListLayout")
visualsLayout.SortOrder = Enum.SortOrder.LayoutOrder
visualsLayout.Padding = UDim.new(0, 10)
visualsLayout.Parent = visualsPage

local visualsPadding = Instance.new("UIPadding")
visualsPadding.PaddingBottom = UDim.new(0, 30)
visualsPadding.PaddingRight = UDim.new(0, 5)
visualsPadding.Parent = visualsPage

local languagePage = Instance.new("ScrollingFrame")
languagePage.Name = "LanguagePage"
languagePage.Size = UDim2.new(1, -190, 1, -90)
languagePage.Position = UDim2.new(0, 175, 0, 78)
languagePage.BackgroundTransparency = 1
languagePage.CanvasSize = UDim2.new(0, 0, 0, 300)
languagePage.ScrollBarThickness = 3
languagePage.Visible = false
languagePage.ZIndex = 2
languagePage.Parent = contentContainer

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
    languagePage.Visible = (tabName == "Language")
    configPage.Visible = (tabName == "Configs")

    if tabName == "Main" then
        sectionTitle.Text = "Modules / Main"
    elseif tabName == "Visuals" then
        sectionTitle.Text = "Modules / Visuals"
    elseif tabName == "Language" then
        sectionTitle.Text = "Settings / Language"
    elseif tabName == "Configs" then
        sectionTitle.Text = "Settings / Configs"
    end

    mainTabBtn.BackgroundColor3 = (tabName == "Main") and Color3.fromRGB(85, 50, 22) or Color3.fromRGB(54, 34, 18)
    mainTabBtn.TextColor3 = (tabName == "Main") and Color3.fromRGB(255, 225, 180) or Color3.fromRGB(200, 160, 120)

    visualsTabBtn.BackgroundColor3 = (tabName == "Visuals") and Color3.fromRGB(85, 50, 22) or Color3.fromRGB(54, 34, 18)
    visualsTabBtn.TextColor3 = (tabName == "Visuals") and Color3.fromRGB(255, 225, 180) or Color3.fromRGB(200, 160, 120)

    languageTabBtn.BackgroundColor3 = (tabName == "Language") and Color3.fromRGB(85, 50, 22) or Color3.fromRGB(54, 34, 18)
    languageTabBtn.TextColor3 = (tabName == "Language") and Color3.fromRGB(255, 225, 180) or Color3.fromRGB(200, 160, 120)

    configTabBtn.BackgroundColor3 = (tabName == "Configs") and Color3.fromRGB(85, 50, 22) or Color3.fromRGB(54, 34, 18)
    configTabBtn.TextColor3 = (tabName == "Configs") and Color3.fromRGB(255, 225, 180) or Color3.fromRGB(200, 160, 120)
end

mainTabBtn.MouseButton1Click:Connect(function() switchTab("Main") end)
visualsTabBtn.MouseButton1Click:Connect(function() switchTab("Visuals") end)
languageTabBtn.MouseButton1Click:Connect(function() switchTab("Language") end)
configTabBtn.MouseButton1Click:Connect(function() switchTab("Configs") end)

local autoFarmEnabled = false
local autoFarmLockTarget = true
local autoFarmLowHpFinisher = true
local selectedStyle = "" -- Переменная для выбранной способности

local aimAssistEnabled = false
local aimTargetPart = "Torso"
local aimSmoothness = 0.2

local speedHackEnabled = false
local walkSpeedValue = 32

local fakeDashEnabled = false
local fakeDashKey = Enum.KeyCode.Q
local fakeDashMobileBtnEnabled = false
local isDashing = false

local fullbrightEnabled = false
local scriptVisualsEnabled = false
local worldVisualsEnabled = false
local cosmicAuraEnabled = false

local currentParticleType = "🌸"
local worldParticleType = "🌸"
local worldSpeedMultiplier = 1.0
local currentLanguage = "RU"

local originalAmbient = Lighting.Ambient
local originalOutdoorAmbient = Lighting.OutdoorAmbient

local setAutoFarmUIState = nil
local setAimAssistUIState = nil
local setSpeedHackUIState = nil
local setFakeDashUIState = nil
local setFullbrightUIState = nil
local setScriptVisualsUIState = nil
local setWorldVisualsUIState = nil
local setCosmicAuraUIState = nil

local updateAimButtonsVisual = nil
local setAimSliderValue = nil
local setSpeedSliderValue = nil

local translatableCards = {}
local function updateAllTranslations()
    for _, item in ipairs(translatableCards) do
        item.lbl.Text = (currentLanguage == "RU") and item.ru or item.en
    end
end

local cardOrderIndex = 0

local function createModuleCard(parent, title, descRu, descEn, callbackToggle, hasSettings, customSettingsBuilder)
    cardOrderIndex = cardOrderIndex + 1

    local card = Instance.new("Frame")
    card.Name = "ModuleCard"
    card.Size = UDim2.new(0, 215, 0, 70)
    card.BackgroundColor3 = Color3.fromRGB(58, 36, 20)
    card.BackgroundTransparency = 0.2
    card.BorderSizePixel = 0
    card.ZIndex = 2
    card.LayoutOrder = cardOrderIndex
    card.Parent = parent

    local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, 10) corner.Parent = card

    local tLbl = Instance.new("TextLabel")
    tLbl.Name = "TitleLabel"
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
    dLbl.Text = (currentLanguage == "RU") and descRu or descEn
    dLbl.TextColor3 = Color3.fromRGB(180, 130, 80)
    dLbl.TextSize = 10
    dLbl.TextWrapped = true
    dLbl.TextXAlignment = Enum.TextXAlignment.Left
    dLbl.ZIndex = 3
    dLbl.Parent = card

    table.insert(translatableCards, {lbl = dLbl, ru = descRu, en = descEn})

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
    local settingsPanelRef = nil

    local function setVisualState(val, noNotify)
        if val and selectedStyle == "" then
            -- Проверка: если способность не выбрана, показываем ошибку и открываем настройки
            showAbilityErrorNotification(function()
                if settingsPanelRef and not settingsPanelRef.Visible then
                    settingsPanelRef.Visible = true
                    TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 215, 0, 210)}):Play()
                end
            end)
            return
        end

        isEnabled = val
        if isEnabled then
            TweenService:Create(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 120, 0)}):Play()
            TweenService:Create(toggleDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0, 2), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            playEnableSound()
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
        settingsPanel.Size = UDim2.new(1, -20, 0, 120)
        settingsPanel.Position = UDim2.new(0, 10, 0, 68)
        settingsPanel.BackgroundTransparency = 1
        settingsPanel.Visible = false
        settingsPanel.ZIndex = 10
        settingsPanel.Parent = card
        settingsPanelRef = settingsPanel

        if customSettingsBuilder then
            customSettingsBuilder(settingsPanel, card)
        end

        settingsBtn.MouseButton1Click:Connect(function()
            local isOpen = not settingsPanel.Visible
            settingsPanel.Visible = isOpen
            local targetH = isOpen and 210 or 70
            TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 215, 0, targetH)}):Play()
        end)
    end

    return card, setVisualState
end

searchInput:GetPropertyChangedSignal("Text"):Connect(function()
    local query = searchInput.Text:lower()
    for _, page in ipairs({mainPage, visualsPage}) do
        for _, card in ipairs(page:GetChildren()) do
            if card:IsA("Frame") and card.Name == "ModuleCard" then
                local titleLbl = card:FindFirstChild("TitleLabel")
                if titleLbl then
                    local match = titleLbl.Text:lower():find(query)
                    card.Visible = (match ~= nil)
                end
            end
        end
    end
end)

-- 1. AutoFarm (с выбором способности Martial Artist на первой строке настроек)
local setAutoFarmUIFunc
_, setAutoFarmUIFunc = createModuleCard(mainPage, "AutoFarm", "Обычные удары, способности и ульта", "Normal attacks, skills and ultimate", function(state)
    autoFarmEnabled = state
end, true, function(panel)
    -- Самая первая настройка внутри панели: Выбор способности
    local styleLbl = Instance.new("TextLabel")
    styleLbl.Size = UDim2.new(1, 0, 0, 16)
    styleLbl.Position = UDim2.new(0, 0, 0, 2)
    styleLbl.BackgroundTransparency = 1
    styleLbl.Font = Enum.Font.GothamBold
    styleLbl.Text = "Выберите способность:"
    styleLbl.TextColor3 = Color3.fromRGB(250, 220, 170)
    styleLbl.TextSize = 10
    styleLbl.TextXAlignment = Enum.TextXAlignment.Left
    styleLbl.ZIndex = 11
    styleLbl.Parent = panel

    local martialBtn = Instance.new("TextButton")
    martialBtn.Size = UDim2.new(1, 0, 0, 26)
    martialBtn.Position = UDim2.new(0, 0, 0, 20)
    martialBtn.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
    martialBtn.Text = "      Martial Artist"
    martialBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
    martialBtn.TextSize = 10
    martialBtn.Font = Enum.Font.GothamBold
    martialBtn.TextXAlignment = Enum.TextXAlignment.Left
    martialBtn.ZIndex = 11
    martialBtn.Parent = panel
    local mbC = Instance.new("UICorner") mbC.CornerRadius = UDim.new(0, 6) mbC.Parent = martialBtn

    local martialIcon = Instance.new("ImageLabel")
    martialIcon.Size = UDim2.new(0, 16, 0, 16)
    martialIcon.Position = UDim2.new(0, 6, 0.5, -8)
    martialIcon.BackgroundTransparency = 1
    martialIcon.Image = "rbxassetid://79240866082046"
    martialIcon.ZIndex = 12
    martialIcon.Parent = martialBtn

    martialBtn.MouseButton1Click:Connect(function()
        if selectedStyle == "MartialArtist" then
            selectedStyle = ""
            martialBtn.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
            martialBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
            showNotification("AutoFarm", "Способность сброшена")
        else
            selectedStyle = "MartialArtist"
            martialBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
            martialBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            showNotification("AutoFarm", "Выбрано: Martial Artist")
        end
    end)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 16)
    lbl.Position = UDim2.new(0, 0, 0, 52)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = "Настройки AutoFarm:"
    lbl.TextColor3 = Color3.fromRGB(250, 220, 170)
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 11
    lbl.Parent = panel

    local lockBtn = Instance.new("TextButton")
    lockBtn.Size = UDim2.new(1, 0, 0, 24)
    lockBtn.Position = UDim2.new(0, 0, 0, 72)
    lockBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
    lockBtn.Text = "Фиксация цели: ON"
    lockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    lockBtn.TextSize = 10
    lockBtn.Font = Enum.Font.GothamBold
    lockBtn.ZIndex = 11
    lockBtn.Parent = panel
    local lbC = Instance.new("UICorner") lbC.CornerRadius = UDim.new(0, 6) lbC.Parent = lockBtn

    lockBtn.MouseButton1Click:Connect(function()
        autoFarmLockTarget = not autoFarmLockTarget
        if autoFarmLockTarget then
            lockBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
            lockBtn.Text = "Фиксация цели: ON"
        else
            lockBtn.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
            lockBtn.Text = "Фиксация цели: OFF"
        end
    end)

    local lowHpBtn = Instance.new("TextButton")
    lowHpBtn.Size = UDim2.new(1, 0, 0, 24)
    lowHpBtn.Position = UDim2.new(0, 0, 0, 100)
    lowHpBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
    lowHpBtn.Text = "Добивать шотных (<35 HP): ON"
    lowHpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    lowHpBtn.TextSize = 10
    lowHpBtn.Font = Enum.Font.GothamBold
    lowHpBtn.ZIndex = 11
    lowHpBtn.Parent = panel
    local lhpC = Instance.new("UICorner") lhpC.CornerRadius = UDim.new(0, 6) lhpC.Parent = lowHpBtn

    lowHpBtn.MouseButton1Click:Connect(function()
        autoFarmLowHpFinisher = not autoFarmLowHpFinisher
        if autoFarmLowHpFinisher then
            lowHpBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
            lowHpBtn.Text = "Добивать шотных (<35 HP): ON"
        else
            lowHpBtn.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
            lowHpBtn.Text = "Добивать шотных (<35 HP): OFF"
        end
    end)
end)
setAutoFarmUIState = setAutoFarmUIFunc

-- 2. Aim Assist
local setAimUIFunc
_, setAimUIFunc = createModuleCard(mainPage, "Aim Assist", "Автонаведение на цель", "Aim assist towards target", function(state)
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
    sliderLbl.Text = "Плавность:"
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
_, setSpeedUIFunc = createModuleCard(mainPage, "SpeedHack", "Увеличение скорости бега", "Increase walk speed", function(state)
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

local performFakeDash
mdClick.MouseButton1Click:Connect(function()
    if fakeDashEnabled and performFakeDash then
        performFakeDash()
    end
end)

-- 4. Fake Dash
local setDashUIFunc
_, setDashUIFunc = createModuleCard(mainPage, "Fake Dash", "Анимация и перемещение рывка без урона", "Dash animation and movement without damage", function(state)
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

    local mobBtnToggle = Instance.new("TextButton")
    mobBtnToggle.Size = UDim2.new(0, 180, 0, 26)
    mobBtnToggle.Position = UDim2.new(0, 0, 0, 48)
    mobBtnToggle.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
    mobBtnToggle.Text = "Кнопка (телефон): OFF"
    mobBtnToggle.TextColor3 = Color3.fromRGB(200, 160, 120)
    mobBtnToggle.TextSize = 9
    mobBtnToggle.Font = Enum.Font.GothamBold
    mobBtnToggle.ZIndex = 11
    mobBtnToggle.Parent = panel
    local mbtC = Instance.new("UICorner") mbtC.CornerRadius = UDim.new(0, 6) mbtC.Parent = mobBtnToggle

    mobBtnToggle.MouseButton1Click:Connect(function()
        fakeDashMobileBtnEnabled = not fakeDashMobileBtnEnabled
        if fakeDashMobileBtnEnabled then
            mobBtnToggle.Text = "Кнопка (телефон): ON"
            mobBtnToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            mobBtnToggle.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
            if fakeDashEnabled then mobileDashBtn.Visible = true end
        else
            mobBtnToggle.Text = "Кнопка (телефон): OFF"
            mobBtnToggle.TextColor3 = Color3.fromRGB(200, 160, 120)
            mobBtnToggle.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
            mobileDashBtn.Visible = false
        end
    end)
end)
setFakeDashUIState = setDashUIFunc

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

-- Visuals (Вкладка Modules / Visuals)
createModuleCard(visualsPage, "Fullbright", "Максимально светлое освещение карты", "Maximum bright map lighting", function(state)
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
        Lighting.Ambient = originalAmbient
        Lighting.OutdoorAmbient = originalOutdoorAmbient
    end
end, false)

local setScriptVisualsUIFunc
_, setScriptVisualsUIFunc = createModuleCard(visualsPage, "Script Visuals", "Падающие стикеры в меню", "Falling stickers in menu", function(state)
    scriptVisualsEnabled = state
end, true, function(panel)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 16)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = "Выберите стиль меню:"
    lbl.TextColor3 = Color3.fromRGB(250, 220, 170)
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 11
    lbl.Parent = panel

    local btn1 = Instance.new("TextButton") btn1.Size = UDim2.new(0, 32, 0, 24) btn1.Position = UDim2.new(0, 0, 0, 22) btn1.BackgroundColor3 = Color3.fromRGB(255, 120, 0) btn1.Text = "🌸" btn1.TextColor3 = Color3.fromRGB(255, 255, 255) btn1.TextSize = 12 btn1.Font = Enum.Font.GothamBold btn1.ZIndex = 11 btn1.Parent = panel local c1 = Instance.new("UICorner") c1.CornerRadius = UDim.new(0, 6) c1.Parent = btn1
    local btn2 = Instance.new("TextButton") btn2.Size = UDim2.new(0, 32, 0, 24) btn2.Position = UDim2.new(0, 36, 0, 22) btn2.BackgroundColor3 = Color3.fromRGB(50, 28, 14) btn2.Text = "❤️" btn2.TextColor3 = Color3.fromRGB(200, 160, 120) btn2.TextSize = 12 btn2.Font = Enum.Font.GothamBold btn2.ZIndex = 11 btn2.Parent = panel local c2 = Instance.new("UICorner") c2.CornerRadius = UDim.new(0, 6) c2.Parent = btn2
    local btn3 = Instance.new("TextButton") btn3.Size = UDim2.new(0, 32, 0, 24) btn3.Position = UDim2.new(0, 72, 0, 22) btn3.BackgroundColor3 = Color3.fromRGB(50, 28, 14) btn3.Text = "⭐" btn3.TextColor3 = Color3.fromRGB(200, 160, 120) btn3.TextSize = 12 btn3.Font = Enum.Font.GothamBold btn3.ZIndex = 11 btn3.Parent = panel local c3 = Instance.new("UICorner") c3.CornerRadius = UDim.new(0, 6) c3.Parent = btn3
    local btn4 = Instance.new("TextButton") btn4.Size = UDim2.new(0, 38, 0, 24) btn4.Position = UDim2.new(0, 108, 0, 22) btn4.BackgroundColor3 = Color3.fromRGB(50, 28, 14) btn4.Text = "🍃" btn4.TextColor3 = Color3.fromRGB(200, 160, 120) btn4.TextSize = 12 btn4.Font = Enum.Font.GothamBold btn4.ZIndex = 11 btn4.Parent = panel local c4 = Instance.new("UICorner") c4.CornerRadius = UDim.new(0, 6) c4.Parent = btn4
    local btn5 = Instance.new("TextButton") btn5.Size = UDim2.new(0, 38, 0, 24) btn5.Position = UDim2.new(0, 150, 0, 22) btn5.BackgroundColor3 = Color3.fromRGB(50, 28, 14) btn5.Text = "❄️" btn5.TextColor3 = Color3.fromRGB(200, 160, 120) btn5.TextSize = 12 btn5.Font = Enum.Font.GothamBold btn5.ZIndex = 11 btn5.Parent = panel local c5 = Instance.new("UICorner") c5.CornerRadius = UDim.new(0, 6) c5.Parent = btn5

    local function updateParticleButtons(pType)
        currentParticleType = pType
        local buttons = { {btn1, "🌸"}, {btn2, "❤️"}, {btn3, "⭐"}, {btn4, "🍃"}, {btn5, "❄️"} }
        for _, pair in ipairs(buttons) do
            local active = (pair[2] == pType)
            pair[1].BackgroundColor3 = active and Color3.fromRGB(255, 120, 0) or Color3.fromRGB(50, 28, 14)
            pair[1].TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 160, 120)
        end
    end

    btn1.MouseButton1Click:Connect(function() updateParticleButtons("🌸") end)
    btn2.MouseButton1Click:Connect(function() updateParticleButtons("❤️") end)
    btn3.MouseButton1Click:Connect(function() updateParticleButtons("⭐") end)
    btn4.MouseButton1Click:Connect(function() updateParticleButtons("🍃") end)
    btn5.MouseButton1Click:Connect(function() updateParticleButtons("❄️") end)
end)
setScriptVisualsUIState = setScriptVisualsUIFunc

local setWorldVisualsUIFunc
_, setWorldVisualsUIFunc = createModuleCard(visualsPage, "World Visual", "Стикеры падают вокруг вас в мире", "Stickers fall around you in the world", function(state)
    worldVisualsEnabled = state
end, true, function(panel)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 16)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = "Выберите стиль мира:"
    lbl.TextColor3 = Color3.fromRGB(250, 220, 170)
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 11
    lbl.Parent = panel

    local wbtn1 = Instance.new("TextButton") wbtn1.Size = UDim2.new(0, 32, 0, 22) wbtn1.Position = UDim2.new(0, 0, 0, 20) wbtn1.BackgroundColor3 = Color3.fromRGB(255, 120, 0) wbtn1.Text = "🌸" wbtn1.TextColor3 = Color3.fromRGB(255, 255, 255) wbtn1.TextSize = 11 wbtn1.Font = Enum.Font.GothamBold wbtn1.ZIndex = 11 wbtn1.Parent = panel local wc1 = Instance.new("UICorner") wc1.CornerRadius = UDim.new(0, 6) wc1.Parent = wbtn1
    local wbtn2 = Instance.new("TextButton") wbtn2.Size = UDim2.new(0, 32, 0, 22) wbtn2.Position = UDim2.new(0, 36, 0, 20) wbtn2.BackgroundColor3 = Color3.fromRGB(50, 28, 14) wbtn2.Text = "❤️" wbtn2.TextColor3 = Color3.fromRGB(200, 160, 120) wbtn2.TextSize = 11 wbtn2.Font = Enum.Font.GothamBold wbtn2.ZIndex = 11 wbtn2.Parent = panel local wc2 = Instance.new("UICorner") wc2.CornerRadius = UDim.new(0, 6) wc2.Parent = wbtn2
    local wbtn3 = Instance.new("TextButton") wbtn3.Size = UDim2.new(0, 32, 0, 22) wbtn3.Position = UDim2.new(0, 72, 0, 20) wbtn3.BackgroundColor3 = Color3.fromRGB(50, 28, 14) wbtn3.Text = "⭐" wbtn3.TextColor3 = Color3.fromRGB(200, 160, 120) wbtn3.TextSize = 11 wbtn3.Font = Enum.Font.GothamBold wbtn3.ZIndex = 11 wbtn3.Parent = panel local wc3 = Instance.new("UICorner") wc3.CornerRadius = UDim.new(0, 6) wc3.Parent = wbtn3
    local wbtn4 = Instance.new("TextButton") wbtn4.Size = UDim2.new(0, 38, 0, 22) wbtn4.Position = UDim2.new(0, 108, 0, 20) wbtn4.BackgroundColor3 = Color3.fromRGB(50, 28, 14) wbtn4.Text = "🍃" wbtn4.TextColor3 = Color3.fromRGB(200, 160, 120) wbtn4.TextSize = 11 wbtn4.Font = Enum.Font.GothamBold wbtn4.ZIndex = 11 wbtn4.Parent = panel local wc4 = Instance.new("UICorner") wc4.CornerRadius = UDim.new(0, 6) wc4.Parent = wbtn4
    local wbtn5 = Instance.new("TextButton") wbtn5.Size = UDim2.new(0, 38, 0, 22) wbtn5.Position = UDim2.new(0, 150, 0, 20) wbtn5.BackgroundColor3 = Color3.fromRGB(50, 28, 14) wbtn5.Text = "❄️" wbtn5.TextColor3 = Color3.fromRGB(200, 160, 120) wbtn5.TextSize = 11 wbtn5.Font = Enum.Font.GothamBold wbtn5.ZIndex = 11 wbtn5.Parent = panel local wc5 = Instance.new("UICorner") wc5.CornerRadius = UDim.new(0, 6) wc5.Parent = wbtn5

    local function updateWorldParticleButtons(pType)
        worldParticleType = pType
        local buttons = { {wbtn1, "🌸"}, {wbtn2, "❤️"}, {wbtn3, "⭐"}, {wbtn4, "🍃"}, {wbtn5, "❄️"} }
        for _, pair in ipairs(buttons) do
            local active = (pair[2] == pType)
            pair[1].BackgroundColor3 = active and Color3.fromRGB(255, 120, 0) or Color3.fromRGB(50, 28, 14)
            pair[1].TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 160, 120)
        end
    end

    wbtn1.MouseButton1Click:Connect(function() updateWorldParticleButtons("🌸") end)
    wbtn2.MouseButton1Click:Connect(function() updateWorldParticleButtons("❤️") end)
    wbtn3.MouseButton1Click:Connect(function() updateWorldParticleButtons("⭐") end)
    wbtn4.MouseButton1Click:Connect(function() updateWorldParticleButtons("🍃") end)
    wbtn5.MouseButton1Click:Connect(function() updateWorldParticleButtons("❄️") end)

    local speedLbl = Instance.new("TextLabel")
    speedLbl.Size = UDim2.new(1, 0, 0, 16)
    speedLbl.Position = UDim2.new(0, 0, 0, 48)
    speedLbl.BackgroundTransparency = 1
    speedLbl.Font = Enum.Font.GothamBold
    speedLbl.Text = "Скорость падения:"
    speedLbl.TextColor3 = Color3.fromRGB(250, 220, 170)
    speedLbl.TextSize = 9
    speedLbl.TextXAlignment = Enum.TextXAlignment.Left
    speedLbl.ZIndex = 11
    speedLbl.Parent = panel

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0, 180, 0, 6)
    sliderBg.Position = UDim2.new(0, 5, 0, 70)
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

    local draggingWorldSpeed = false
    local function updateWorldSpeedSlider(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        worldSpeedMultiplier = 0.3 + (pos * 2.2)
    end

    sliderBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingWorldSpeed = true end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingWorldSpeed = false end end)
    UserInputService.InputChanged:Connect(function(input) if draggingWorldSpeed and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateWorldSpeedSlider(input) end end)
end)
setWorldVisualsUIState = setWorldVisualsUIFunc

-- Cosmic Aura
local PsychoAuraConnection = nil
local PsychoAuraFolder = nil

local function applyCosmicAura(char)
    pcall(function()
        if PsychoAuraConnection then PsychoAuraConnection:Disconnect() end
        if PsychoAuraFolder then PsychoAuraFolder:Destroy() end

        local root = char:WaitForChild("HumanoidRootPart", 2)
        if not root then return end

        local Folder = Instance.new("Folder")
        Folder.Name = "PsychoAura"
        Folder.Parent = Workspace
        PsychoAuraFolder = Folder

        local Colors = {
            Color3.fromRGB(125, 50, 255),
            Color3.fromRGB(65, 160, 255),
            Color3.fromRGB(200, 100, 255)
        }

        local Attachment = Instance.new("Attachment")
        Attachment.Name = "AuraAttachment"
        Attachment.Parent = root

        local Emitter = Instance.new("ParticleEmitter")
        Emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        Emitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Colors[1]),
            ColorSequenceKeypoint.new(0.5, Colors[2]),
            ColorSequenceKeypoint.new(1, Colors[3])
        })
        Emitter.LightEmission = 1
        Emitter.LightInfluence = 0
        Emitter.Rate = 110
        Emitter.Lifetime = NumberRange.new(0.5, 1.2)
        Emitter.Speed = NumberRange.new(2, 5)
        Emitter.SpreadAngle = Vector2.new(180, 180)
        Emitter.RotSpeed = NumberRange.new(-180, 180)
        Emitter.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.5, 0.8),
            NumberSequenceKeypoint.new(1, 0)
        })
        Emitter.Parent = Attachment

        local Highlight = Instance.new("Highlight")
        Highlight.Adornee = char
        Highlight.FillColor = Colors[1]
        Highlight.OutlineColor = Colors[2]
        Highlight.FillTransparency = 0.75
        Highlight.OutlineTransparency = 0.15
        Highlight.Parent = Folder

        local Time = 0
        PsychoAuraConnection = RunService.RenderStepped:Connect(function(Delta)
            if not char or not char.Parent or not root.Parent then return end
            Time += Delta * 2
            local Pulse = (math.sin(Time) + 1) / 2
            Highlight.FillTransparency = 0.85 - Pulse * 0.15
            Highlight.OutlineTransparency = 0.4 - Pulse * 0.25
            Emitter.Rate = 80 + Pulse * 70
        end)
    end)
end

local function removeCosmicAura()
    pcall(function()
        if PsychoAuraConnection then
            PsychoAuraConnection:Disconnect()
            PsychoAuraConnection = nil
        end
        if PsychoAuraFolder then
            PsychoAuraFolder:Destroy()
            PsychoAuraFolder = nil
        end
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local att = char.HumanoidRootPart:FindFirstChild("AuraAttachment")
            if att then att:Destroy() end
        end
    end)
end

local setAuraUIFunc
_, setAuraUIFunc = createModuleCard(visualsPage, "Cosmic Aura", "Психо-аура вокруг персонажа", "Psycho aura around character", function(state)
    cosmicAuraEnabled = state
    if cosmicAuraEnabled then
        if player.Character then applyCosmicAura(player.Character) end
    else
        removeCosmicAura()
    end
end, true, function(panel, card)
    panel.Size = UDim2.new(1, -20, 0, 170)

    local previewContainer = Instance.new("Frame")
    previewContainer.Name = "PreviewContainer"
    previewContainer.Size = UDim2.new(0, 195, 0, 125)
    previewContainer.Position = UDim2.new(0, 0, 0, 5)
    previewContainer.BackgroundColor3 = Color3.fromRGB(30, 16, 8)
    previewContainer.BackgroundTransparency = 0.2
    previewContainer.BorderSizePixel = 0
    previewContainer.ZIndex = 11
    previewContainer.Parent = panel

    local pcCorner = Instance.new("UICorner") pcCorner.CornerRadius = UDim.new(0, 8) pcCorner.Parent = previewContainer

    local prevTitle = Instance.new("TextLabel")
    prevTitle.Size = UDim2.new(1, -10, 0, 18)
    prevTitle.Position = UDim2.new(0, 6, 0, 4)
    prevTitle.BackgroundTransparency = 1
    prevTitle.Font = Enum.Font.GothamBold
    prevTitle.Text = (currentLanguage == "RU") and "Предпросмотр" or "Preview"
    prevTitle.TextColor3 = Color3.fromRGB(250, 220, 170)
    prevTitle.TextSize = 11
    prevTitle.TextXAlignment = Enum.TextXAlignment.Left
    prevTitle.ZIndex = 12
    prevTitle.Parent = previewContainer

    table.insert(translatableCards, {lbl = prevTitle, ru = "Предпросмотр", en = "Preview"})

    local viewport = Instance.new("ViewportFrame")
    viewport.Size = UDim2.new(1, -12, 1, -40)
    viewport.Position = UDim2.new(0, 6, 0, 22)
    viewport.BackgroundTransparency = 1
    viewport.ZIndex = 12
    viewport.Parent = previewContainer

    local vpCam = Instance.new("Camera")
    viewport.CurrentCamera = vpCam
    vpCam.Parent = viewport

    local previewCharModel = nil
    pcall(function()
        if player.Character then
            player.Character.Archivable = true
            previewCharModel = player.Character:Clone()
            for _, c in ipairs(previewCharModel:GetChildren()) do
                if c:IsA("Script") or c:IsA("LocalScript") or c:IsA("ModuleScript") then
                    c:Destroy()
                end
            end
            previewCharModel.Parent = viewport

            local root = previewCharModel:FindFirstChild("HumanoidRootPart") or previewCharModel:FindFirstChild("Torso")
            if root then
                vpCam.CFrame = CFrame.new(root.Position + Vector3.new(0, 1.5, 3.8), root.Position + Vector3.new(0, 0.5, 0))
                
                local vpLight = Instance.new("PointLight")
                vpLight.Brightness = 3
                vpLight.Range = 15
                vpLight.Parent = root

                local Folder = Instance.new("Folder")
                Folder.Parent = previewCharModel
                
                local att = Instance.new("Attachment")
                att.Parent = root

                local Emitter = Instance.new("ParticleEmitter")
                Emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
                Emitter.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 50, 255)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(65, 160, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 100, 255))
                })
                Emitter.LightEmission = 1
                Emitter.LightInfluence = 0
                Emitter.Rate = 80
                Emitter.Lifetime = NumberRange.new(0.5, 1)
                Emitter.Speed = NumberRange.new(2, 4)
                Emitter.SpreadAngle = Vector2.new(180, 180)
                Emitter.Parent = att

                local Highlight = Instance.new("Highlight")
                Highlight.Adornee = previewCharModel
                Highlight.FillColor = Color3.fromRGB(125, 50, 255)
                Highlight.OutlineColor = Color3.fromRGB(65, 160, 255)
                Highlight.FillTransparency = 0.75
                Highlight.OutlineTransparency = 0.2
                Highlight.Parent = Folder
            end
        end
    end)

    local draggingModel = false
    local lastMousePos = Vector2.new()
    local modelRot = 0

    local rotButton = Instance.new("TextButton")
    rotButton.Size = UDim2.new(1, 0, 1, 0)
    rotButton.BackgroundTransparency = 1
    rotButton.Text = ""
    rotButton.ZIndex = 15
    rotButton.Parent = viewport

    rotButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingModel = true
            lastMousePos = input.Position
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingModel = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if draggingModel and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - lastMousePos
            lastMousePos = input.Position
            modelRot = modelRot + (delta.X * 0.01)
            if previewCharModel then
                local root = previewCharModel:FindFirstChild("HumanoidRootPart") or previewCharModel:FindFirstChild("Torso")
                if root then
                    previewCharModel:SetPrimaryPartCFrame(CFrame.new(root.Position) * CFrame.Angles(0, modelRot, 0))
                end
            end
        end
    end)

    local hintLbl = Instance.new("TextLabel")
    hintLbl.Size = UDim2.new(1, -10, 0, 16)
    hintLbl.Position = UDim2.new(0, 6, 1, -18)
    hintLbl.BackgroundTransparency = 1
    hintLbl.Font = Enum.Font.Gotham
    hintLbl.Text = (currentLanguage == "RU") and "Тащите мышью, чтобы повернуть" or "Drag with mouse to rotate"
    hintLbl.TextColor3 = Color3.fromRGB(160, 120, 80)
    hintLbl.TextSize = 8
    hintLbl.TextXAlignment = Enum.TextXAlignment.Center
    hintLbl.ZIndex = 12
    hintLbl.Parent = previewContainer

    table.insert(translatableCards, {lbl = hintLbl, ru = "Тащите мышью, чтобы повернуть", en = "Drag with mouse to rotate"})
end)
setCosmicAuraUIState = setAuraUIFunc

player.CharacterAdded:Connect(function(char)
    if cosmicAuraEnabled then
        task.delay(1, function()
            applyCosmicAura(char)
        end)
    end
end)

-- КОНТЕЙНЕР ДЛЯ МИРОВЫХ ЧАСТИЦ
local worldParticlesFolder = Workspace:FindFirstChild("MoneyHubWorldParticles")
if worldParticlesFolder then worldParticlesFolder:Destroy() end
worldParticlesFolder = Instance.new("Folder")
worldParticlesFolder.Name = "MoneyHubWorldParticles"
worldParticlesFolder.Parent = Workspace

local worldParts = {}
for i = 1, 50 do
    local part = Instance.new("Part")
    part.Size = Vector3.new(1, 1, 1)
    part.Transparency = 1
    part.Anchored = true
    part.CanCollide = false
    part.CastShadow = false

    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 32, 0, 32)
    bb.AlwaysOnTop = true
    bb.Parent = part

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "🌸"
    lbl.TextSize = 22
    lbl.Font = Enum.Font.GothamBold
    lbl.Parent = bb

    part.Parent = worldParticlesFolder
    
    local initPos = Vector3.new(math.random(-60, 60), math.random(0, 45), math.random(-60, 60))
    table.insert(worldParts, { part = part, lbl = lbl, pos = initPos, speed = math.random(15, 35) })
end

-- ЭФФЕКТЫ ЧАСТИЦ МЕНЮ
local scriptParticles = {}
for i = 1, 20 do
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 22, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = "🌸"
    lbl.TextSize = 16
    lbl.Font = Enum.Font.GothamBold
    lbl.Visible = false
    lbl.Parent = effectsContainer

    table.insert(scriptParticles, { lbl = lbl, x = math.random(), y = math.random(), speed = math.random(15, 40) / 100000, sway = math.random(1, 10) })
end

RunService.RenderStepped:Connect(function(dt)
    if not screenGui.Parent then return end
    local scaledDt = dt * 65

    for _, p in ipairs(scriptParticles) do
        p.y = p.y + (p.speed * scaledDt)
        if p.y > 1.05 then p.y = -0.05 p.x = math.random() end
        
        local active = (scriptVisualsEnabled and mainFrame.Visible)
        p.lbl.Visible = active

        if active then
            p.lbl.Text = currentParticleType
            p.lbl.Position = UDim2.new(p.x, math.cos(tick() * 1.5 + p.sway) * 25, p.y, 0)
        end
    end

    for _, wp in ipairs(worldParts) do
        if worldVisualsEnabled then
            wp.lbl.Text = worldParticleType
            
            wp.pos = wp.pos - Vector3.new(0, (wp.speed * worldSpeedMultiplier) * dt, 0)

            if wp.pos.Y < -10 then
                wp.pos = Vector3.new(math.random(-60, 60), math.random(35, 60), math.random(-60, 60))
            end

            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                local targetWorldPos = root.Position + wp.pos
                local relX = targetWorldPos.X - root.Position.X
                local relZ = targetWorldPos.Z - root.Position.Z
                
                if relX > 70 then wp.pos = wp.pos - Vector3.new(140, 0, 0)
                elseif relX < -70 then wp.pos = wp.pos + Vector3.new(140, 0, 0) end
                
                if relZ > 70 then wp.pos = wp.pos - Vector3.new(0, 0, 140)
                elseif relZ < -70 then wp.pos = wp.pos + Vector3.new(0, 0, 140) end

                wp.part.Position = root.Position + wp.pos
                wp.part.Transparency = 1
            else
                wp.part.Transparency = 1
            end
        else
            wp.part.Transparency = 1
        end
    end
end)

-- НАСТРОЙКА ВКЛАДКИ LANGUAGE
local langLbl = Instance.new("TextLabel")
langLbl.Size = UDim2.new(1, 0, 0, 24)
langLbl.Position = UDim2.new(0, 0, 0, 10)
langLbl.BackgroundTransparency = 1
langLbl.Font = Enum.Font.GothamBold
langLbl.Text = "Выберите язык / Select Language:"
langLbl.TextColor3 = Color3.fromRGB(250, 220, 170)
langLbl.TextSize = 12
langLbl.TextXAlignment = Enum.TextXAlignment.Left
langLbl.ZIndex = 3
langLbl.Parent = languagePage

local ruBtn = Instance.new("TextButton")
ruBtn.Size = UDim2.new(0, 110, 0, 32)
ruBtn.Position = UDim2.new(0, 0, 0, 42)
ruBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
ruBtn.Text = "🇷🇺 Русский"
ruBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ruBtn.TextSize = 11
ruBtn.Font = Enum.Font.GothamBold
ruBtn.ZIndex = 3
ruBtn.Parent = languagePage
local rbC = Instance.new("UICorner") rbC.CornerRadius = UDim.new(0, 6) rbC.Parent = ruBtn

local enBtn = Instance.new("TextButton")
enBtn.Size = UDim2.new(0, 110, 0, 32)
enBtn.Position = UDim2.new(0, 120, 0, 42)
enBtn.BackgroundColor3 = Color3.fromRGB(50, 28, 14)
enBtn.Text = "🇬🇧 English"
enBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
enBtn.TextSize = 11
enBtn.Font = Enum.Font.GothamBold
enBtn.ZIndex = 3
enBtn.Parent = languagePage
local ebC = Instance.new("UICorner") ebC.CornerRadius = UDim.new(0, 6) ebC.Parent = enBtn

ruBtn.MouseButton1Click:Connect(function()
    currentLanguage = "RU"
    ruBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0) ruBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    enBtn.BackgroundColor3 = Color3.fromRGB(50, 28, 14) enBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
    updateAllTranslations()
    showNotification("Language", "Установлен русский язык")
end)

enBtn.MouseButton1Click:Connect(function()
    currentLanguage = "EN"
    enBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0) enBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ruBtn.BackgroundColor3 = Color3.fromRGB(50, 28, 14) ruBtn.TextColor3 = Color3.fromRGB(200, 160, 120)
    updateAllTranslations()
    showNotification("Language", "English language selected")
end)

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
        
        local saveBtn = Instance.new("ImageButton") saveBtn.Size = UDim2.new(0, 24, 0, 24) saveBtn.Position = UDim2.new(1, -100, 0, 6) saveBtn.BackgroundTransparency = 1 saveBtn.Image = SAVE_ICON saveBtn.ZIndex = 4 saveBtn.Parent = itemFrame
        local loadBtn = Instance.new("ImageButton") loadBtn.Size = UDim2.new(0, 24, 0, 24) loadBtn.Position = UDim2.new(1, -66, 0, 6) loadBtn.BackgroundTransparency = 1 loadBtn.Image = IMPORT_ICON loadBtn.ZIndex = 4 loadBtn.Parent = itemFrame
        local delBtn = Instance.new("ImageButton") delBtn.Size = UDim2.new(0, 24, 0, 24) delBtn.Position = UDim2.new(1, -32, 0, 6) delBtn.BackgroundTransparency = 1 delBtn.Image = DELETE_ICON delBtn.ZIndex = 4 delBtn.Parent = itemFrame
        
        saveBtn.MouseButton1Click:Connect(function()
            local data = { 
                SelectedStyle = selectedStyle, AutoFarm = autoFarmEnabled, AimAssist = aimAssistEnabled, AimTarget = aimTargetPart, AimSmoothness = aimSmoothness,
                SpeedHack = speedHackEnabled, WalkSpeed = walkSpeedValue, FakeDashEnabled = fakeDashEnabled, FakeDashKeyName = fakeDashKey.Name,
                FakeDashMobile = fakeDashMobileBtnEnabled, Fullbright = fullbrightEnabled, ScriptVisuals = scriptVisualsEnabled,
                WorldVisuals = worldVisualsEnabled, CosmicAura = cosmicAuraEnabled, ParticleType = currentParticleType,
                WorldParticleType = worldParticleType, WorldSpeed = worldSpeedMultiplier, Language = currentLanguage
            }
            writefile(configsFolder .. "/" .. cfgName .. ".json", HttpService:JSONEncode(data))
            showNotification("Configs", "Сохранено: " .. cfgName)
        end)
        
        loadBtn.MouseButton1Click:Connect(function()
            pcall(function()
                local content = readfile(configsFolder .. "/" .. cfgName .. ".json")
                local data = HttpService:JSONDecode(content)
                
                selectedStyle = data.SelectedStyle or ""
                autoFarmEnabled = data.AutoFarm or false if setAutoFarmUIState then setAutoFarmUIState(autoFarmEnabled, true) end
                aimAssistEnabled = data.AimAssist or false if setAimAssistUIState then setAimAssistUIState(aimAssistEnabled, true) end
                aimTargetPart = data.AimTarget or "Torso" if updateAimButtonsVisual then updateAimButtonsVisual(aimTargetPart) end
                aimSmoothness = data.AimSmoothness or 0.2 if setAimSliderValue then setAimSliderValue(aimSmoothness) end
                speedHackEnabled = data.SpeedHack or false if setSpeedHackUIState then setSpeedHackUIState(speedHackEnabled, true) end
                walkSpeedValue = data.WalkSpeed or 32 if setSpeedSliderValue then setSpeedSliderValue(walkSpeedValue) end
                fakeDashEnabled = data.FakeDashEnabled or false if setFakeDashUIState then setFakeDashUIState(fakeDashEnabled, true) end
                fakeDashMobileBtnEnabled = data.FakeDashMobile or false if fakeDashEnabled then mobileDashBtn.Visible = fakeDashMobileBtnEnabled end
                if data.FakeDashKeyName and Enum.KeyCode[data.FakeDashKeyName] then fakeDashKey = Enum.KeyCode[data.FakeDashKeyName] end
                fullbrightEnabled = data.Fullbright or false if setFullbrightUIState then setFullbrightUIState(fullbrightEnabled, true) end
                scriptVisualsEnabled = data.ScriptVisuals or false if setScriptVisualsUIState then setScriptVisualsUIState(scriptVisualsEnabled, true) end
                worldVisualsEnabled = data.WorldVisuals or false if setWorldVisualsUIState then setWorldVisualsUIState(worldVisualsEnabled, true) end
                cosmicAuraEnabled = data.CosmicAura or false if setCosmicAuraUIState then setCosmicAuraUIState(cosmicAuraEnabled, true) end
                currentParticleType = data.ParticleType or "🌸"
                worldParticleType = data.WorldParticleType or "🌸"
                worldSpeedMultiplier = data.WorldSpeed or 1.0
                currentLanguage = data.Language or "RU"
                updateAllTranslations()
                
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
        writefile(configsFolder .. "/" .. name .. ".json", HttpService:JSONEncode({ SelectedStyle = "", AutoFarm = false, AimAssist = false, AimTarget = "Torso", AimSmoothness = 0.2, SpeedHack = false, WalkSpeed = 32, FakeDashEnabled = false, FakeDashKeyName = "Q", FakeDashMobile = false, Fullbright = false, ScriptVisuals = false, WorldVisuals = false, CosmicAura = false, ParticleType = "🌸", WorldParticleType = "🌸", WorldSpeed = 1.0, Language = "RU" }))
        configNameBox.Text = ""
        refreshConfigList()
        showNotification("Configs", "Создан конфиг")
    end
end)

refreshConfigList()

-- КЛАССИЧЕСКАЯ ЛОГИКА AUTOFARM, AIM, SPEEDHACK И БЕЗОПАСНОЙ ЗОНЫ
local currentTarget = nil
local isEvadingDamage = false

local function selectAutoFarmTarget()
    local myChar = player.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = myChar.HumanoidRootPart.Position

    if autoFarmLockTarget and currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild("Humanoid") and currentTarget.Character.Humanoid.Health > 0 then
        return currentTarget
    end

    if autoFarmLowHpFinisher then
        local lowestHpPlayer = nil
        local lowestHpVal = 35
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
                local hum = p.Character.Humanoid
                if hum.Health > 0 and hum.Health <= lowestHpVal then
                    lowestHpVal = hum.Health
                    lowestHpPlayer = p
                end
            end
        end
        if lowestHpPlayer then return lowestHpPlayer end
    end

    local nearest, minDist = nil, math.huge
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
    if humanoid and speedHackEnabled then
        humanoid.WalkSpeed = walkSpeedValue
    end

    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local target = selectAutoFarmTarget()
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
        root.CFrame = CFrame.lookAt(backPos.Position, enemyRoot.Position)
    end
end)

-- ТЕЛЕПОРТАЦИЯ НА БЕЗОПАСНУЮ ЗОНУ ПРИ УРОНЕ
local lastHealth = 100
local function setupHealthListener(char)
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
end

if player.Character then setupHealthListener(player.Character) end
player.CharacterAdded:Connect(setupHealthListener)

local function executeActionKey(keyCode)
    pcall(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, keyCode, false, game)
        task.wait(0.03)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, keyCode, false, game)
    end)
end

local function performNormalAttack()
    pcall(function()
        local char = player.Character
        if char then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
            end
        end
        local vim = game:GetService("VirtualInputManager")
        vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        task.wait(0.03)
        vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end)
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if autoFarmEnabled and currentTarget and currentTarget.Character and not isEvadingDamage then
            pcall(function()
                local char = player.Character local enemyChar = currentTarget.Character
                if not char or not enemyChar then return end
                local myRoot = char:FindFirstChild("HumanoidRootPart") local enemyRoot = enemyChar:FindFirstChild("HumanoidRootPart")
                if not myRoot or not enemyRoot then return end
                
                if (myRoot.Position - enemyRoot.Position).Magnitude <= 10 then
                    local actionRand = math.random(1, 10)
                    if actionRand <= 4 then
                        performNormalAttack()
                    elseif actionRand == 5 then
                        executeActionKey(Enum.KeyCode.One)
                    elseif actionRand == 6 then
                        executeActionKey(Enum.KeyCode.Two)
                    elseif actionRand == 7 then
                        executeActionKey(Enum.KeyCode.Three)
                    elseif actionRand == 8 then
                        executeActionKey(Enum.KeyCode.Four)
                    elseif actionRand >= 9 then
                        executeActionKey(Enum.KeyCode.G)
                    end
                end
            end)
        else
            task.wait(0.3)
        end
    end
end)

enableDragging(mainFrame, topBarArea)

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
