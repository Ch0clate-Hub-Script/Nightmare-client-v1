local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

-- Configuration
local DEFAULT_WALKSPEED = 16
local DEFAULT_JUMPPOWER = 50

-- Remote Event Setup (Requires a RemoteEvent named 'ModActionRemote' in ReplicatedStorage)
local ModActionRemote = ReplicatedStorage:FindFirstChild("ModActionRemote")
if not ModActionRemote then
    -- Create the remote event for demonstration/ease of setup
    ModActionRemote = Instance.new("RemoteEvent")
    ModActionRemote.Name = "ModActionRemote"
    ModActionRemote.Parent = ReplicatedStorage
    warn("Created placeholder ModActionRemote. Remember to handle this on the server!")
end

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "👿nightmare client v1👿"
screenGui.ResetOnSpawn = false
screenGui.Enabled = true
screenGui.Parent = playerGui

-- Overlay GUI for analytics (top right)
local analyticsOverlayGui = Instance.new("Frame")
analyticsOverlayGui.Name = "AnalyticsOverlayGui"
analyticsOverlayGui.Size = UDim2.new(0, 180, 0, 90)
analyticsOverlayGui.Position = UDim2.new(1, -190, 0, 10)
analyticsOverlayGui.BackgroundColor3 = Color3.fromRGB(80, 0, 120)
analyticsOverlayGui.BackgroundTransparency = 0.35
analyticsOverlayGui.BorderSizePixel = 0
analyticsOverlayGui.Visible = false
analyticsOverlayGui.Parent = screenGui

local overlayCorner = Instance.new("UICorner")
overlayCorner.CornerRadius = UDim.new(0, 10)
overlayCorner.Parent = analyticsOverlayGui

local overlayTitle = Instance.new("TextLabel")
overlayTitle.Name = "OverlayTitle"
overlayTitle.Size = UDim2.new(1, 0, 0, 22)
overlayTitle.Position = UDim2.new(0, 0, 0, 0)
overlayTitle.BackgroundTransparency = 1
overlayTitle.Text = "Analytics"
overlayTitle.Font = Enum.Font.GothamBold
overlayTitle.TextSize = 15
overlayTitle.TextColor3 = Color3.fromRGB(230, 200, 255)
overlayTitle.TextXAlignment = Enum.TextXAlignment.Center
overlayTitle.Parent = analyticsOverlayGui

local overlayStats = Instance.new("TextLabel")
overlayStats.Name = "OverlayStats"
overlayStats.Size = UDim2.new(1, -16, 1, -28)
overlayStats.Position = UDim2.new(0, 8, 0, 24)
overlayStats.BackgroundTransparency = 1
overlayStats.Text = ""
overlayStats.Font = Enum.Font.Gotham
overlayStats.TextSize = 13
overlayStats.TextColor3 = Color3.fromRGB(230, 200, 255)
overlayStats.TextXAlignment = Enum.TextXAlignment.Left
overlayStats.TextYAlignment = Enum.TextYAlignment.Top
overlayStats.TextWrapped = true
overlayStats.Parent = analyticsOverlayGui

-- Main Frame (purple, see-through)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 520, 0, 340)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(80, 0, 120)
mainFrame.BackgroundTransparency = 0.35
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

mainFrame.Visible = false
mainFrame.BackgroundTransparency = 1
mainFrame.Size = UDim2.new(0, 416, 0, 272) -- Start smaller for animation

-- Title Bar (draggable, purple accent)
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
titleBar.BackgroundTransparency = 0.25
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "👿nightmare client v1👿"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.TextColor3 = Color3.fromRGB(230, 200, 255)
titleLabel.TextStrokeTransparency = 0.7
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 28, 0, 24)
closeButton.Position = UDim2.new(1, -36, 0, 6)
closeButton.BackgroundColor3 = Color3.fromRGB(180, 0, 120)
closeButton.BackgroundTransparency = 0.15
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BorderSizePixel = 0
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Controls Notification Frame
local controlsFrame = Instance.new("Frame")
controlsFrame.Name = "ControlsFrame"
controlsFrame.Size = UDim2.new(0, 340, 0, 120)
controlsFrame.Position = UDim2.new(0.5, -170, 0, -130)
controlsFrame.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
controlsFrame.BackgroundTransparency = 0.35
controlsFrame.BorderSizePixel = 0
controlsFrame.Visible = false
controlsFrame.Parent = screenGui

local controlsCorner = Instance.new("UICorner")
controlsCorner.CornerRadius = UDim.new(0, 14)
controlsCorner.Parent = controlsFrame

local controlsTitle = Instance.new("TextLabel")
controlsTitle.Name = "ControlsTitle"
controlsTitle.Size = UDim2.new(1, 0, 0, 32)
controlsTitle.Position = UDim2.new(0, 0, 0, 0)
controlsTitle.BackgroundTransparency = 1
controlsTitle.Text = "Mod Menu Controls"
controlsTitle.Font = Enum.Font.GothamBold
controlsTitle.TextSize = 18
controlsTitle.TextColor3 = Color3.fromRGB(230, 200, 255)
controlsTitle.TextXAlignment = Enum.TextXAlignment.Center
controlsTitle.Parent = controlsFrame

local controlsDesc = Instance.new("TextLabel")
controlsDesc.Name = "ControlsDesc"
controlsDesc.Size = UDim2.new(1, -20, 1, -40)
controlsDesc.Position = UDim2.new(0, 10, 0, 36)
controlsDesc.BackgroundTransparency = 1
controlsDesc.Text = "K - Open Menu\nX - Close Menu\nMouse - Navigate\nL - Show Mod Info (hover mod)\nClick - Activate Mod"
controlsDesc.Font = Enum.Font.Gotham
controlsDesc.TextSize = 15
controlsDesc.TextColor3 = Color3.fromRGB(230, 200, 255)
controlsDesc.TextXAlignment = Enum.TextXAlignment.Left
controlsDesc.TextYAlignment = Enum.TextYAlignment.Top
controlsDesc.TextWrapped = true
controlsDesc.Parent = controlsFrame

-- Make MainFrame draggable
local dragging = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		local mousePos = input.Position
		local relX = mousePos.X - titleBar.AbsolutePosition.X
		if relX < titleLabel.Position.X.Offset or relX > titleBar.AbsoluteSize.X - 36 then
			return
		end
		dragging = true
		dragStart = input.Position
		startPos = Vector2.new(mainFrame.Position.X.Offset, mainFrame.Position.Y.Offset)
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(
			0, startPos.X + delta.X,
			0, startPos.Y + delta.Y
		)
	end
end)

-- Categories Panel (left side, vertical)
local categoriesPanel = Instance.new("Frame")
categoriesPanel.Name = "CategoriesPanel"
categoriesPanel.Size = UDim2.new(0, 120, 1, -44)
categoriesPanel.Position = UDim2.new(0, 0, 0, 44)
categoriesPanel.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
categoriesPanel.BackgroundTransparency = 0.45
categoriesPanel.BorderSizePixel = 0
categoriesPanel.Parent = mainFrame

local categoriesCorner = Instance.new("UICorner")
categoriesCorner.CornerRadius = UDim.new(0, 8)
categoriesCorner.Parent = categoriesPanel

local categoriesListLayout = Instance.new("UIListLayout")
categoriesListLayout.SortOrder = Enum.SortOrder.LayoutOrder
categoriesListLayout.Padding = UDim.new(0, 6)
categoriesListLayout.Parent = categoriesPanel

-- Mods Panel (right side, vertical)
local modsPanel = Instance.new("Frame")
modsPanel.Name = "ModsPanel"
modsPanel.Size = UDim2.new(1, -140, 1, -44)
modsPanel.Position = UDim2.new(0, 130, 0, 44)
modsPanel.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
modsPanel.BackgroundTransparency = 0.45
modsPanel.BorderSizePixel = 0
modsPanel.Parent = mainFrame

local modsCorner = Instance.new("UICorner")
modsCorner.CornerRadius = UDim.new(0, 8)
modsCorner.Parent = modsPanel

local modsScroll = Instance.new("ScrollingFrame")
modsScroll.Name = "ModsScroll"
modsScroll.Size = UDim2.new(1, -10, 1, -10)
modsScroll.Position = UDim2.new(0, 5, 0, 5)
modsScroll.BackgroundTransparency = 1
modsScroll.BorderSizePixel = 0
modsScroll.ScrollBarThickness = 8
modsScroll.ScrollBarImageColor3 = Color3.fromRGB(180, 0, 255)
modsScroll.Parent = modsPanel

local modsListLayout = Instance.new("UIListLayout")
modsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
modsListLayout.Padding = UDim.new(0, 5)
modsListLayout.Parent = modsScroll

-- Info Panel (for Info tab)
local infoPanel = Instance.new("Frame")
infoPanel.Name = "InfoPanel"
infoPanel.Size = UDim2.new(1, -10, 1, -10)
infoPanel.Position = UDim2.new(0, 5, 0, 5)
infoPanel.BackgroundColor3 = Color3.fromRGB(80, 0, 120)
infoPanel.BackgroundTransparency = 0.4
infoPanel.BorderSizePixel = 0
infoPanel.Visible = false
infoPanel.Parent = modsPanel

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 8)
infoCorner.Parent = infoPanel

local infoTitle = Instance.new("TextLabel")
infoTitle.Name = "InfoTitle"
infoTitle.Size = UDim2.new(1, 0, 0, 38)
infoTitle.Position = UDim2.new(0, 0, 0, 0)
infoTitle.BackgroundTransparency = 1
infoTitle.Text = "Mod Menu Info"
infoTitle.Font = Enum.Font.GothamBold
infoTitle.TextSize = 18
infoTitle.TextColor3 = Color3.fromRGB(230, 200, 255)
infoTitle.TextXAlignment = Enum.TextXAlignment.Center
infoTitle.Parent = infoPanel

local infoDesc = Instance.new("TextLabel")
infoDesc.Name = "InfoDesc"
infoDesc.Size = UDim2.new(1, -20, 1, -50)
infoDesc.Position = UDim2.new(0, 10, 0, 44)
infoDesc.BackgroundTransparency = 1
infoDesc.Text = "👿nightmare client v1👿\n\nCreated by: YourName\n\nFeatures:\n- 75 Mods\n- Animated Menu\n- Controls Notification\n- Mod Info Popup\n\nUse K to open, X to close, L for mod info.\n\nEnjoy!"
infoDesc.Font = Enum.Font.Gotham
infoDesc.TextSize = 15
infoDesc.TextColor3 = Color3.fromRGB(230, 200, 255)
infoDesc.TextXAlignment = Enum.TextXAlignment.Left
infoDesc.TextYAlignment = Enum.TextYAlignment.Top
infoDesc.TextWrapped = true
infoDesc.Parent = infoPanel

-- Overview/Analytics Panel
local analyticsPanel = Instance.new("Frame")
analyticsPanel.Name = "AnalyticsPanel"
analyticsPanel.Size = UDim2.new(1, -10, 1, -10)
analyticsPanel.Position = UDim2.new(0, 5, 0, 5)
analyticsPanel.BackgroundColor3 = Color3.fromRGB(80, 0, 120)
analyticsPanel.BackgroundTransparency = 0.4
analyticsPanel.BorderSizePixel = 0
analyticsPanel.Visible = false
analyticsPanel.Parent = modsPanel

local analyticsCorner = Instance.new("UICorner")
analyticsCorner.CornerRadius = UDim.new(0, 8)
analyticsCorner.Parent = analyticsPanel

local analyticsTitle = Instance.new("TextLabel")
analyticsTitle.Name = "AnalyticsTitle"
analyticsTitle.Size = UDim2.new(1, 0, 0, 38)
analyticsTitle.Position = UDim2.new(0, 0, 0, 0)
analyticsTitle.BackgroundTransparency = 1
analyticsTitle.Text = "Overview / Analytics"
analyticsTitle.Font = Enum.Font.GothamBold
analyticsTitle.TextSize = 18
analyticsTitle.TextColor3 = Color3.fromRGB(230, 200, 255)
analyticsTitle.TextXAlignment = Enum.TextXAlignment.Center
analyticsTitle.Parent = analyticsPanel

local analyticsStats = Instance.new("TextLabel")
analyticsStats.Name = "AnalyticsStats"
analyticsStats.Size = UDim2.new(1, -20, 0, 90)
analyticsStats.Position = UDim2.new(0, 10, 0, 44)
analyticsStats.BackgroundTransparency = 1
analyticsStats.Text = "FPS: ...\nMS: ...\nPing: ...\nPlayers: ...\nConnection: ..."
analyticsStats.Font = Enum.Font.Gotham
analyticsStats.TextSize = 15
analyticsStats.TextColor3 = Color3.fromRGB(230, 200, 255)
analyticsStats.TextXAlignment = Enum.TextXAlignment.Left
analyticsStats.TextYAlignment = Enum.TextYAlignment.Top
analyticsStats.TextWrapped = true
analyticsStats.Parent = analyticsPanel

-- Add a new frame for mod buttons under analytics stats
local analyticsModsFrame = Instance.new("Frame")
analyticsModsFrame.Name = "AnalyticsModsFrame"
analyticsModsFrame.Size = UDim2.new(1, -20, 0, 100)
analyticsModsFrame.Position = UDim2.new(0, 10, 0, 140)
analyticsModsFrame.BackgroundTransparency = 1
analyticsModsFrame.BorderSizePixel = 0
analyticsModsFrame.Parent = analyticsPanel

local analyticsModsLayout = Instance.new("UIListLayout")
analyticsModsLayout.SortOrder = Enum.SortOrder.LayoutOrder
analyticsModsLayout.Padding = UDim.new(0, 6)
analyticsModsLayout.Parent = analyticsModsFrame

-- Toggle Button (Slider) for overlay
local overlayToggle = Instance.new("TextButton")
overlayToggle.Name = "OverlayToggle"
overlayToggle.Size = UDim2.new(0, 120, 0, 32)
overlayToggle.Position = UDim2.new(0, 10, 1, -40)
overlayToggle.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
overlayToggle.BackgroundTransparency = 0.25
overlayToggle.BorderSizePixel = 0
overlayToggle.Text = "Show Overlay: OFF"
overlayToggle.Font = Enum.Font.GothamBold
overlayToggle.TextSize = 14
overlayToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
overlayToggle.Parent = analyticsPanel

local overlayToggleCorner = Instance.new("UICorner")
overlayToggleCorner.CornerRadius = UDim.new(0, 8)
overlayToggleCorner.Parent = overlayToggle

local overlayOn = false
local function setOverlayVisible()
    analyticsOverlayGui.Visible = overlayOn
end
overlayToggle.MouseButton1Click:Connect(function()
    overlayOn = not overlayOn
    if overlayOn then
        overlayToggle.Text = "Show Overlay: ON"
        overlayToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
    else
        overlayToggle.Text = "Show Overlay: OFF"
        overlayToggle.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
    end
    setOverlayVisible()
end)

-- FPS/MS/Ping update logic
local lastUpdate = 0
local frameCount = 0
local fps = 0
local ms = 0
local ping = "..."
local function getConnectionStatus()
    -- Simulate connection status: "Good", "Average", "Poor"
    if type(ping) == "number" then
        if ping < 70 then return "Good"
        elseif ping < 120 then return "Average"
        else return "Poor"
        end
    end
    return "Unknown"
end
local function updateAnalytics()
    analyticsStats.Text = string.format(
        "FPS: %d\nMS: %.2f\nPing: %s\nPlayers: %d\nConnection: %s",
        fps, ms, ping, #Players:GetPlayers(), getConnectionStatus()
    )
    overlayStats.Text = string.format(
        "FPS: %d\nMS: %.2f\nPing: %s\nPlayers: %d\nConnection: %s",
        fps, ms, ping, #Players:GetPlayers(), getConnectionStatus()
    )
end
RunService.RenderStepped:Connect(function(dt)
    frameCount = frameCount + 1
    ms = dt * 1000
    local now = tick()
    if now - lastUpdate > 1 then
        fps = frameCount
        frameCount = 0
        lastUpdate = now
        -- Ping (Roblox doesn't expose true ping, so use a placeholder)
        if player and player:IsDescendantOf(Players) then
            ping = math.random(40, 120) -- Simulated ping
        end
        updateAnalytics()
    end
end)

-- User Reports Panel
local reportsPanel = Instance.new("Frame")
reportsPanel.Name = "ReportsPanel"
reportsPanel.Size = UDim2.new(1, -10, 1, -10)
reportsPanel.Position = UDim2.new(0, 5, 0, 5)
reportsPanel.BackgroundColor3 = Color3.fromRGB(80, 0, 120)
reportsPanel.BackgroundTransparency = 0.4
reportsPanel.BorderSizePixel = 0
reportsPanel.Visible = false
reportsPanel.Parent = modsPanel

local reportsCorner = Instance.new("UICorner")
reportsCorner.CornerRadius = UDim.new(0, 8)
reportsCorner.Parent = reportsPanel

local reportsTitle = Instance.new("TextLabel")
reportsTitle.Name = "ReportsTitle"
reportsTitle.Size = UDim2.new(1, 0, 0, 38)
reportsTitle.Position = UDim2.new(0, 0, 0, 0)
reportsTitle.BackgroundTransparency = 1
reportsTitle.Text = "User Reports / Leaderboard"
reportsTitle.Font = Enum.Font.GothamBold
reportsTitle.TextSize = 18
reportsTitle.TextColor3 = Color3.fromRGB(230, 200, 255)
reportsTitle.TextXAlignment = Enum.TextXAlignment.Center
reportsTitle.Parent = reportsPanel

local leaderboardScroll = Instance.new("ScrollingFrame")
leaderboardScroll.Name = "LeaderboardScroll"
leaderboardScroll.Size = UDim2.new(1, -20, 1, -50)
leaderboardScroll.Position = UDim2.new(0, 10, 0, 44)
leaderboardScroll.BackgroundTransparency = 1
leaderboardScroll.BorderSizePixel = 0
leaderboardScroll.ScrollBarThickness = 8
leaderboardScroll.ScrollBarImageColor3 = Color3.fromRGB(180, 0, 255)
leaderboardScroll.Parent = reportsPanel

local leaderboardLayout = Instance.new("UIListLayout")
leaderboardLayout.SortOrder = Enum.SortOrder.LayoutOrder
leaderboardLayout.Padding = UDim.new(0, 5)
leaderboardLayout.Parent = leaderboardScroll

local cameraViewFrame = Instance.new("Frame")
cameraViewFrame.Name = "CameraViewFrame"
cameraViewFrame.Size = UDim2.new(1, -20, 0, 120)
cameraViewFrame.Position = UDim2.new(0, 10, 1, -130)
cameraViewFrame.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
cameraViewFrame.BackgroundTransparency = 0.25
cameraViewFrame.BorderSizePixel = 0
cameraViewFrame.Visible = false
cameraViewFrame.Parent = reportsPanel

local cameraCorner = Instance.new("UICorner")
cameraCorner.CornerRadius = UDim.new(0, 8)
cameraCorner.Parent = cameraViewFrame

local cameraLabel = Instance.new("TextLabel")
cameraLabel.Name = "CameraLabel"
cameraLabel.Size = UDim2.new(1, -16, 1, -16)
cameraLabel.Position = UDim2.new(0, 8, 0, 8)
cameraLabel.BackgroundTransparency = 1
cameraLabel.Text = "Camera view will appear here."
cameraLabel.Font = Enum.Font.Gotham
cameraLabel.TextSize = 15
cameraLabel.TextColor3 = Color3.fromRGB(230, 200, 255)
cameraLabel.TextXAlignment = Enum.TextXAlignment.Center
cameraLabel.TextYAlignment = Enum.TextYAlignment.Center
cameraLabel.TextWrapped = true
cameraLabel.Parent = cameraViewFrame

-- Leaderboard logic
local function updateLeaderboard()
    for _, child in leaderboardScroll:GetChildren() do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    local players = Players:GetPlayers()
    for i = 1, #players do
        local plr = players[i]
        local button = Instance.new("TextButton")
        button.Name = plr.Name .. "LeaderboardButton"
        button.Size = UDim2.new(1, 0, 0, 32)
        button.BackgroundColor3 = Color3.fromRGB(140, 0, 200)
        button.BackgroundTransparency = 0.45
        button.BorderSizePixel = 0
        button.Text = string.format("%d. %s (@%s)", i, plr.DisplayName, plr.Name)
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.TextColor3 = Color3.fromRGB(230, 200, 255)
        button.LayoutOrder = i
        button.Parent = leaderboardScroll

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = button

        button.MouseButton1Click:Connect(function()
            cameraViewFrame.Visible = true
			cameraLabel.Text = "Viewing " .. plr.DisplayName .. "'s camera...\n(Menu state: " .. (plr.PlayerGui and plr.PlayerGui:FindFirstChild("👿nightmare client v1👿") and "Open" or "Closed") .. ")"
            -- In a real system, would request camera feed from server/client
            -- ModActionRemote:FireServer("RequestCameraView", plr.UserId)
        end)
    end
    leaderboardScroll.CanvasSize = UDim2.new(0, 0, 0, leaderboardLayout.AbsoluteContentSize.Y + 10)
end
Players.PlayerAdded:Connect(updateLeaderboard)
Players.PlayerRemoving:Connect(updateLeaderboard)
updateLeaderboard()

-- Categories and mods data
local categories = {}
categories["Movement"] = {
    "Player Speed",
    "Fly",
    "Super Jump",
    "No Clip",
    "Gravity Control",
    "Slippery Ground",
    "Bouncey Ground"
}
categories["Visual"] = {}
categories["OP"] = {}
categories["User Reports"] = {}
categories["Overview / Analytics"] = {
    "Full User Reports",
    "Anti Time Out",
    "Anti Kick"
}

local modDescriptions = {}
local modActions = {}
local activeMods = {}

-- Mod Descriptions
modDescriptions["Full User Reports"] = "Shows detailed reports for all users, including stats and history."
modDescriptions["Anti Time Out"] = "Prevents you from being timed out due to inactivity."
modDescriptions["Anti Kick"] = "Attempts to block kick actions from the server."
modDescriptions["Player Speed"] = "Change your walking/running speed. (Toggle)"
modDescriptions["Fly"] = "Allows you to fly around the map, and acts as a ragdoll/noclip toggle. (Toggle)"
modDescriptions["Super Jump"] = "Jump much higher than normal. (Toggle)"
modDescriptions["No Clip"] = "Walk through walls and objects. (Toggle, Server Interaction Required)"
modDescriptions["Gravity Control"] = "Change the gravity for your character/the whole workspace. (Toggle, Server Interaction Required)"
modDescriptions["Slippery Ground"] = "Makes the ground slippery for you. (Toggle, Server Interaction Required)"
modDescriptions["Bouncey Ground"] = "Makes the ground bounce you up when you touch it. (Toggle, Server Interaction Required)"

-- General Mod Toggle Function
local function toggleMod(modName)
    activeMods[modName] = not (activeMods[modName] or false)
    local button = modsScroll:FindFirstChild(modName .. "Button")
    if button then
        button.BackgroundColor3 = activeMods[modName] and Color3.fromRGB(180, 0, 255) or Color3.fromRGB(140, 0, 200)
        button.Text = modName .. (activeMods[modName] and " [ON]" or " [OFF]")
    end
    return activeMods[modName]
end

-- Fly/Ragdoll/Reset System
local flyConnection = nil
local bodyVelocity = nil
local bodyGyro = nil
local flyOn = false
local flySpeed = 2

-- Persistent Fly Controls GUI (from your script)
local flyGui = Instance.new("ScreenGui")
flyGui.Name = "FlyControlsGui"
flyGui.ResetOnSpawn = false
flyGui.Enabled = false
flyGui.Parent = playerGui

local flyFrame = Instance.new("Frame")
flyFrame.Name = "FlyFrame"
flyFrame.Size = UDim2.new(0, 220, 0, 120)
flyFrame.Position = UDim2.new(1, -230, 1, -130)
flyFrame.BackgroundColor3 = Color3.fromRGB(80, 0, 120)
flyFrame.BackgroundTransparency = 0.5
flyFrame.BorderSizePixel = 0
flyFrame.Parent = flyGui

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 10)
flyCorner.Parent = flyFrame

local flyTitle = Instance.new("TextLabel")
flyTitle.Name = "FlyTitle"
flyTitle.Size = UDim2.new(1, -16, 0, 32)
flyTitle.Position = UDim2.new(0, 8, 0, 8)
flyTitle.BackgroundTransparency = 1
flyTitle.Text = "Fly Controls"
flyTitle.Font = Enum.Font.GothamBold
flyTitle.TextSize = 16
flyTitle.TextColor3 = Color3.fromRGB(230, 200, 255)
flyTitle.TextXAlignment = Enum.TextXAlignment.Left
flyTitle.Parent = flyFrame

local flySpeedLabel = Instance.new("TextLabel")
flySpeedLabel.Name = "FlySpeedLabel"
flySpeedLabel.Size = UDim2.new(1, -16, 0, 22)
flySpeedLabel.Position = UDim2.new(0, 8, 0, 44)
flySpeedLabel.BackgroundTransparency = 1
flySpeedLabel.Text = "Speed: 2"
flySpeedLabel.Font = Enum.Font.Gotham
flySpeedLabel.TextSize = 13
flySpeedLabel.TextColor3 = Color3.fromRGB(230, 200, 255)
flySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
flySpeedLabel.Parent = flyFrame

local flyCloseBtn = Instance.new("TextButton")
flyCloseBtn.Name = "FlyCloseBtn"
flyCloseBtn.Size = UDim2.new(0, 28, 0, 24)
flyCloseBtn.Position = UDim2.new(1, -36, 0, 8)
flyCloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 120)
flyCloseBtn.BackgroundTransparency = 0.15
flyCloseBtn.Text = "X"
flyCloseBtn.Font = Enum.Font.GothamBold
flyCloseBtn.TextSize = 18
flyCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyCloseBtn.BorderSizePixel = 0
flyCloseBtn.Parent = flyFrame

local flyCloseCorner = Instance.new("UICorner")
flyCloseCorner.CornerRadius = UDim.new(0, 8)
flyCloseCorner.Parent = flyCloseBtn

local flyToggleBtn = Instance.new("TextButton")
flyToggleBtn.Name = "FlyToggleBtn"
flyToggleBtn.Size = UDim2.new(0, 90, 0, 28)
flyToggleBtn.Position = UDim2.new(0, 8, 1, -36)
flyToggleBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
flyToggleBtn.BackgroundTransparency = 0.25
flyToggleBtn.BorderSizePixel = 0
flyToggleBtn.Text = "Fly: OFF"
flyToggleBtn.Font = Enum.Font.GothamBold
flyToggleBtn.TextSize = 14
flyToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyToggleBtn.Parent = flyFrame

local flyToggleCorner = Instance.new("UICorner")
flyToggleCorner.CornerRadius = UDim.new(0, 8)
flyToggleCorner.Parent = flyToggleBtn

local speedUpBtn = Instance.new("TextButton")
speedUpBtn.Name = "SpeedUpBtn"
speedUpBtn.Size = UDim2.new(0, 48, 0, 28)
speedUpBtn.Position = UDim2.new(0, 110, 1, -36)
speedUpBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
speedUpBtn.BackgroundTransparency = 0.25
speedUpBtn.BorderSizePixel = 0
speedUpBtn.Text = "+"
speedUpBtn.Font = Enum.Font.GothamBold
speedUpBtn.TextSize = 14
speedUpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedUpBtn.Parent = flyFrame

local speedUpCorner = Instance.new("UICorner")
speedUpCorner.CornerRadius = UDim.new(0, 8)
speedUpCorner.Parent = speedUpBtn

local speedDownBtn = Instance.new("TextButton")
speedDownBtn.Name = "SpeedDownBtn"
speedDownBtn.Size = UDim2.new(0, 48, 0, 28)
speedDownBtn.Position = UDim2.new(0, 164, 1, -36)
speedDownBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
speedDownBtn.BackgroundTransparency = 0.25
speedDownBtn.BorderSizePixel = 0
speedDownBtn.Text = "-"
speedDownBtn.Font = Enum.Font.GothamBold
speedDownBtn.TextSize = 14
speedDownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedDownBtn.Parent = flyFrame

local speedDownCorner = Instance.new("UICorner")
speedDownCorner.CornerRadius = UDim.new(0, 8)
speedDownCorner.Parent = speedDownBtn

local function updateFlyGui()
    flyToggleBtn.Text = "Fly: " .. (flyOn and "ON" or "OFF")
    flyToggleBtn.BackgroundColor3 = flyOn and Color3.fromRGB(180, 0, 255) or Color3.fromRGB(120, 0, 180)
    flySpeedLabel.Text = "Speed: " .. tostring(flySpeed)
    local flyModButton = modsScroll:FindFirstChild("FlyButton")
    if flyModButton then
        flyModButton.Text = "Fly" .. (flyOn and " [ON]" or " [OFF]")
        flyModButton.BackgroundColor3 = flyOn and Color3.fromRGB(180, 0, 255) or Color3.fromRGB(140, 0, 200)
        activeMods["Fly"] = flyOn
    end
end

local function updateModsDisplay()
    -- Forward declaration to allow updateModsDisplay to be called in resetCharacter
    -- (The full body of this function is later in the script)
end

local function resetCharacter()
    print("Resetting character to restore movement...")
    
    -- Clean up physics objects
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end

    -- Toggle off fly state variables
    flyOn = false
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    flyGui.Enabled = false
    updateFlyGui()
    
    -- The core fix: load character to reset platform stand, ragdoll, and movement
    player:LoadCharacter() 
    
    -- Wait for new character and reset movement values in case of mod conflict
    player.CharacterAdded:Wait()
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = DEFAULT_WALKSPEED
        humanoid.JumpPower = DEFAULT_JUMPPOWER
        humanoid.PlatformStand = false
        activeMods["Player Speed"] = false
        activeMods["Super Jump"] = false
    end
    updateModsDisplay() -- Update menu to reflect reset
end

local function flyStep()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") and flyOn then
        local root = character.HumanoidRootPart
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        
        -- Set Humanoid properties for fly/ragdoll
        humanoid:ChangeState(Enum.HumanoidStateType.Physics) -- Enables Physics state (like ragdoll)
        humanoid.PlatformStand = true
        
        if not bodyVelocity then
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = root
        end
        if not bodyGyro then
            bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame
            bodyGyro.Parent = root
        end

        local moveVec = Vector3.new()
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + workspace.CurrentCamera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - workspace.CurrentCamera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - workspace.CurrentCamera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + workspace.CurrentCamera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveVec = moveVec + Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveVec = moveVec - Vector3.new(0, 1, 0) end
        
        if moveVec.Magnitude > 0 then
            bodyVelocity.Velocity = moveVec.Unit * (flySpeed * 10)
        else
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
    end
end

local function enableFly()
    if flyOn then return end
    print("[Fly] Enabling fly and ragdoll...")
    -- Ensure the character exists
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    -- Client-side Ragdoll/PlatformStand setup
    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    humanoid.PlatformStand = true

    flyGui.Enabled = true
    flyOn = true
    updateFlyGui()
    if flyConnection then
        flyConnection:Disconnect()
    end
    flyConnection = RunService.RenderStepped:Connect(flyStep)
end

local function disableFly()
    if not flyOn then return end
    print("[Fly] Disabling fly and resetting character...")
    resetCharacter() -- Calls player:LoadCharacter() which resets state and movement
end

speedUpBtn.MouseButton1Click:Connect(function()
    flySpeed = math.min(flySpeed + 1, 10)
    updateFlyGui()
end)
speedDownBtn.MouseButton1Click:Connect(function()
    flySpeed = math.max(flySpeed - 1, 1)
    updateFlyGui()
end)
flyCloseBtn.MouseButton1Click:Connect(disableFly) -- Close button calls disableFly

flyToggleBtn.MouseButton1Click:Connect(function()
    if flyOn then
        disableFly()
    else
        enableFly()
    end
end)
updateFlyGui() -- Initial update


-- Mod Actions
modActions["Player Speed"] = function()
    local enabled = toggleMod("Player Speed")
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = enabled and 50 or DEFAULT_WALKSPEED
        print("[Movement] Player Speed set to:", humanoid.WalkSpeed)
    end
end
modActions["Fly"] = function()
    if flyOn then
        disableFly()
    else
        enableFly()
    end
end
modActions["Super Jump"] = function()
    local enabled = toggleMod("Super Jump")
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.JumpPower = enabled and 150 or DEFAULT_JUMPPOWER
        print("[Movement] Super Jump set to:", humanoid.JumpPower)
    end
end
modActions["No Clip"] = function()
    local enabled = toggleMod("No Clip")
    print("[Movement] No Clip mod activated! State:", enabled)
    -- WARNING: No-Clip usually involves changing CollisionGroups or parts of the character
    -- which is best done via the server for proper functionality and persistence.
    -- ModActionRemote:FireServer("NoClipToggle", enabled)
end
modActions["Gravity Control"] = function()
    local enabled = toggleMod("Gravity Control")
    print("[Movement] Gravity Control mod activated! State:", enabled)
    -- WARNING: Changing Gravity is a World property and MUST be done on the server.
    -- ModActionRemote:FireServer("GravityControlToggle", enabled)
end
modActions["Slippery Ground"] = function()
    local enabled = toggleMod("Slippery Ground")
    print("[Movement] Slippery Ground mod activated! State:", enabled)
    -- WARNING: Changing Ground properties is a World property and MUST be done on the server.
    -- ModActionRemote:FireServer("SlipperyGroundToggle", enabled)
end
modActions["Bouncey Ground"] = function()
    local enabled = toggleMod("Bouncey Ground")
    print("[Movement] Bouncey Ground mod activated! State:", enabled)
    -- WARNING: Changing Ground properties is a World property and MUST be done on the server.
    -- ModActionRemote:FireServer("BounceyGroundToggle", enabled)
end

-- Other Mod Actions
modActions["Full User Reports"] = function()
    print("[ModMenu700] Full User Reports activated! (Feature: Show all user reports)")
    ModActionRemote:FireServer("FullUserReports", player.UserId)
end
modActions["Anti Time Out"] = function()
    print("[ModMenu700] Anti Time Out activated! (Feature: Prevent timeouts)")
    ModActionRemote:FireServer("AntiTimeOut")
end
modActions["Anti Kick"] = function()
    print("[ModMenu700] Anti Kick activated! (Feature: Prevent kicks)")
    ModActionRemote:FireServer("AntiKick")
end

-- Selected category
local selectedCategory = nil

-- Tab buttons for categories
local categoryButtons = {}

-- Function to handle menu animation (as implied by your code)
local function animateMenuOpen()
    mainFrame.Visible = true
    local goal = {BackgroundTransparency = 0.35, Size = UDim2.new(0, 520, 0, 340)}
    local info = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    TweenService:Create(mainFrame, info, goal):Play()
end

local function showControlsNotification()
    controlsFrame.Position = UDim2.new(0.5, -170, 0, -130)
    controlsFrame.Visible = true
    local goal = {Position = UDim2.new(0.5, -170, 0, 10)}
    local info = TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
    local tween = TweenService:Create(controlsFrame, info, goal)
    tween:Play()
    tween.Completed:Wait()
    task.wait(4) -- Display for 4 seconds
    local hideGoal = {Position = UDim2.new(0.5, -170, 0, -130)}
    local hideInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    TweenService:Create(controlsFrame, hideInfo, hideGoal):Play()
end

-- Function to update mod list display (now fully defined)
function updateModsDisplay()
    for _, child in modsScroll:GetChildren() do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    if selectedCategory == "Overview / Analytics" then
        modsScroll.Visible = false
        infoPanel.Visible = false
        reportsPanel.Visible = false
        analyticsPanel.Visible = true
        return
    elseif selectedCategory == "User Reports" then
        modsScroll.Visible = false
        infoPanel.Visible = false
        analyticsPanel.Visible = false
        reportsPanel.Visible = true
        updateLeaderboard()
        return
    else
        modsScroll.Visible = true
        infoPanel.Visible = false
        reportsPanel.Visible = false
        analyticsPanel.Visible = false
    end

    local modNames = categories[selectedCategory] or {}
    for i, modName in modNames do
        local button = Instance.new("TextButton")
        button.Name = modName .. "Button"
        button.Size = UDim2.new(1, 0, 0, 32)
        button.BackgroundColor3 = activeMods[modName] and Color3.fromRGB(180, 0, 255) or Color3.fromRGB(140, 0, 200)
        button.BackgroundTransparency = 0.35
        button.BorderSizePixel = 0
        button.Text = modName .. (activeMods[modName] and " [ON]" or activeMods[modName] == false and " [OFF]" or "")
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.TextColor3 = Color3.fromRGB(230, 200, 255)
        button.TextXAlignment = Enum.TextXAlignment.Left
        button.TextScaled = true
        button.LayoutOrder = i
        button.Parent = modsScroll

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = button

        button.MouseButton1Click:Connect(function()
            local action = modActions[modName]
            if action then
                action()
                if activeMods[modName] ~= nil then -- Only update button if it's a togglable mod handled by toggleMod
                    button.Text = modName .. (activeMods[modName] and " [ON]" or " [OFF]")
                    button.BackgroundColor3 = activeMods[modName] and Color3.fromRGB(180, 0, 255) or Color3.fromRGB(140, 0, 200)
                end
            end
        end)
        
        -- Hover for info
        button.MouseEnter:Connect(function()
            if UIS:IsKeyDown(Enum.KeyCode.L) then
                local desc = modDescriptions[modName] or "No description available."
                infoPanel.Visible = true
                infoTitle.Text = modName
                infoDesc.Text = desc
            end
        end)
        button.MouseLeave:Connect(function()
            infoPanel.Visible = false
        end)
    end
    modsScroll.CanvasSize = UDim2.new(0, 0, 0, modsListLayout.AbsoluteContentSize.Y + 10)
end


local function createCategoryButton(catName, layoutOrder)
    local button = Instance.new("TextButton")
    button.Name = catName .. "CategoryButton"
    button.Size = UDim2.new(1, -10, 0, 36)
    button.Position = UDim2.new(0, 5, 0, 5)
    button.BackgroundColor3 = Color3.fromRGB(140, 0, 200)
    button.BackgroundTransparency = 0.3
    button.BorderSizePixel = 0
    button.Text = catName
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.LayoutOrder = layoutOrder
    button.Parent = categoriesPanel

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    categoryButtons[catName] = button
    return button
end

local function selectCategory(catName)
    if selectedCategory then
        local prevButton = categoryButtons[selectedCategory]
        if prevButton then
            prevButton.BackgroundColor3 = Color3.fromRGB(140, 0, 200)
            prevButton.BackgroundTransparency = 0.3
        end
    end

    selectedCategory = catName
    local newButton = categoryButtons[catName]
    if newButton then
        newButton.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
        newButton.BackgroundTransparency = 0.1
    end
    updateModsDisplay()
end

-- Initialize Categories
local order = 1
for catName in categories do
    local button = createCategoryButton(catName, order)
    button.MouseButton1Click:Connect(function()
        selectCategory(catName)
    end)
    order = order + 1
end

-- Initial selection
selectCategory("Movement")

local closed = true

local function openMenu()
    if not screenGui.Enabled then
        screenGui.Enabled = true
    end
    closed = false
    animateMenuOpen()
    showControlsNotification()
    setOverlayVisible()
    updateModsDisplay() -- Refresh mods when opening
end

local function closeMenu()
    if flyOn then return end -- Prevent closing menu if fly is active, to force use of X or F for fly
    closed = true
    local goal = {BackgroundTransparency = 1, Size = UDim2.new(0, 416, 0, 272)} -- Animate out
    local info = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    local tween = TweenService:Create(mainFrame, info, goal)
    tween.Completed:Connect(function()
        mainFrame.Visible = false
        screenGui.Enabled = false
    end)
    tween:Play()
    setOverlayVisible()
    -- Do NOT disable flyGui here
end

closeButton.MouseButton1Click:Connect(function()
    closeMenu()
end)

-- Only open menu with K if closed
UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.K then
        if closed then
            openMenu()
        end
    elseif not processed and input.KeyCode == Enum.KeyCode.X then
        if not closed then
            closeMenu()
        end
    end
end)

-- Allow toggling flyGui/fly state with F key
UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.F then
        if flyOn then
            disableFly() -- Disables fly and resets character (ragdoll off, walk on)
        else
            -- If not flying, simply toggle the control GUI visibility
            flyGui.Enabled = not flyGui.Enabled 
        end
    end
end)

-- Handle Character Respawn to clear fly physics
player.CharacterAdded:Connect(function(character)
    -- This handles the case if the player dies while flying or if the resetCharacter
    -- function called :LoadCharacter(). It ensures the state variables are clean.
    if flyOn then
        flyOn = false
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        flyGui.Enabled = false
        updateFlyGui()
    end
end)
