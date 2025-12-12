local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
            -- Fire remote event to request camera view (not implemented here)
            -- ReplicatedStorage:WaitForChild("RequestCameraViewEvent"):FireServer(plr.UserId)
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
    "Slippery Ground",
    "Bouncey Ground",
    "Super Jump",
    "No Clip",
    "Gravity Control"
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

-- Add descriptions for new mods
modDescriptions["Full User Reports"] = "Shows detailed reports for all users, including stats and history."
modDescriptions["Anti Time Out"] = "Prevents you from being timed out due to inactivity."
modDescriptions["Anti Kick"] = "Attempts to block kick actions from the server."

modDescriptions["Player Speed"] = "Change your walking/running speed."
modDescriptions["Fly"] = "Allows you to fly around the map. Opens a persistent fly controls panel."
modDescriptions["Slippery Ground"] = "Makes the ground slippery for you."
modDescriptions["Bouncey Ground"] = "Makes the ground bounce you up when you touch it."
modDescriptions["Super Jump"] = "Jump much higher than normal."
modDescriptions["No Clip"] = "Walk through walls and objects."
modDescriptions["Gravity Control"] = "Change the gravity for your character."

-- Add basic actions for new mods
modActions["Full User Reports"] = function()
    print("[ModMenu700] Full User Reports activated! (Feature: Show all user reports)")
    -- Placeholder: Add logic to show full user reports here
end
modActions["Anti Time Out"] = function()
    print("[ModMenu700] Anti Time Out activated! (Feature: Prevent timeouts)")
    -- Placeholder: Add logic to prevent timeouts here
end
modActions["Anti Kick"] = function()
    print("[ModMenu700] Anti Kick activated! (Feature: Prevent kicks)")
    -- Placeholder: Add logic to prevent kicks here
end

modActions["Player Speed"] = function()
    print("[Movement] Player Speed mod activated!")
    local character = player.Character or player.CharacterAdded:Wait()
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = 50
    end
end

-- Persistent Fly Controls GUI
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

-- FLY GUI CLOSE BUTTON
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

flyCloseBtn.MouseButton1Click:Connect(function()
    flyGui.Enabled = false
    disableFly() -- Stop flying when GUI is closed
end)
-- END FLY GUI CLOSE BUTTON

local flyOn = false
local flySpeed = 2

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
end

speedUpBtn.MouseButton1Click:Connect(function()
    flySpeed = math.min(flySpeed + 1, 10)
    updateFlyGui()
end)
speedDownBtn.MouseButton1Click:Connect(function()
    flySpeed = math.max(flySpeed - 1, 1)
    updateFlyGui()
end)
updateFlyGui()

-- NEW FLY LOGIC (BodyVelocity/BodyGyro version)
local flyConnection = nil
local bodyVelocity = nil
local bodyGyro = nil

local function flyStep()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") and flyOn then
        local root = character.HumanoidRootPart
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
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            humanoid.PlatformStand = true
        end
    elseif character and character:FindFirstChild("Humanoid") then
        character.Humanoid.PlatformStand = false
    end
end

local function enableFly()
    flyGui.Enabled = true
    flyOn = true
    updateFlyGui()
    if flyConnection then
        flyConnection:Disconnect()
    end
    flyConnection = RunService.RenderStepped:Connect(flyStep)
end

local function disableFly()
    flyOn = false
    updateFlyGui()
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.PlatformStand = false
    end
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end
end

flyToggleBtn.MouseButton1Click:Connect(function()
    flyOn = not flyOn
    updateFlyGui()
    if flyOn then
        enableFly()
    else
        disableFly()
    end
end)

modActions["Fly"] = function()
    print("[Movement] Fly mod activated!")
    enableFly()
end

-- Fly GUI stays open even if mod menu is closed
local closed = false -- Fix: ensure closed variable is initialized

local function openMenu()
    if not screenGui.Enabled then
        screenGui.Enabled = true
    end
    closed = false
    animateMenuOpen()
    showControlsNotification()
    setOverlayVisible()
end

local function closeMenu()
    screenGui.Enabled = false
    closed = true
    mainFrame.Visible = false
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

-- Allow closing flyGui with F key
UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.F then
        flyGui.Enabled = not flyGui.Enabled
        if not flyGui.Enabled then
            disableFly() -- Stop flying when GUI is closed with F
        end
    end
end)

modActions["Slippery Ground"] = function()
    print("[Movement] Slippery Ground mod activated!")
    -- Placeholder: Add slippery ground logic here
end
modActions["Bouncey Ground"] = function()
    print("[Movement] Bouncey Ground mod activated!")
    -- Placeholder: Add bouncey ground logic here
end
modActions["Super Jump"] = function()
    print("[Movement] Super Jump mod activated!")
    local character = player.Character or player.CharacterAdded:Wait()
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.JumpPower = 150
    end
end
modActions["No Clip"] = function()
    print("[Movement] No Clip mod activated!")
    -- Placeholder: Add no clip logic here
end
modActions["Gravity Control"] = function()
    print("[Movement] Gravity Control mod activated!")
    -- Placeholder: Add gravity control logic here
end

-- Selected category
local selectedCategory = nil

-- Tab buttons for categories
local categoryButtons = {}

local function createCategoryButton(catName, layoutOrder)
    local button = Instance.new("TextButton")
    button.Name = catName .. "Button"
    button.Size = UDim2.new(1, -10, 0, 36)
    button.BackgroundColor3 = Color3.fromRGB(140, 0, 200)
    button.BackgroundTransparency = 0.45
    button.BorderSizePixel = 0
    button.Text = catName
    button.Font = Enum.Font.GothamBold
    button.TextSize = 15
    button.TextColor3 = Color3.fromRGB(230, 200, 255)
    button.LayoutOrder = layoutOrder
    button.Parent = categoriesPanel

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
        button.BackgroundTransparency = 0.15
    end)
    button.MouseLeave:Connect(function()
        if selectedCategory ~= catName then
            button.BackgroundColor3 = Color3.fromRGB(140, 0, 200)
            button.BackgroundTransparency = 0.45
        end
    end)

    button.MouseButton1Click:Connect(function()
        selectedCategory = catName
        for name, btn in categoryButtons do
            btn.BackgroundColor3 = Color3.fromRGB(140, 0, 200)
            btn.BackgroundTransparency = 0.45
        end
        button.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
        button.BackgroundTransparency = 0.15
        updateModsList()
    end)

    categoryButtons[catName] = button
    return button
end

-- Mod info popup GUI (right corner)
local modInfoGui = Instance.new("Frame")
modInfoGui.Name = "ModInfoGui"
modInfoGui.Size = UDim2.new(0, 220, 0, 120)
modInfoGui.Position = UDim2.new(1, -230, 1, -130)
modInfoGui.BackgroundColor3 = Color3.fromRGB(80, 0, 120)
modInfoGui.BackgroundTransparency = 0.5
modInfoGui.BorderSizePixel = 0
modInfoGui.Visible = false
modInfoGui.Parent = screenGui

local modInfoCorner = Instance.new("UICorner")
modInfoCorner.CornerRadius = UDim.new(0, 10)
modInfoCorner.Parent = modInfoGui

local modInfoTitle = Instance.new("TextLabel")
modInfoTitle.Name = "ModInfoTitle"
modInfoTitle.Size = UDim2.new(1, -16, 0, 32)
modInfoTitle.Position = UDim2.new(0, 8, 0, 8)
modInfoTitle.BackgroundTransparency = 1
modInfoTitle.Text = ""
modInfoTitle.Font = Enum.Font.GothamBold
modInfoTitle.TextSize = 16
modInfoTitle.TextColor3 = Color3.fromRGB(230, 200, 255)
modInfoTitle.TextXAlignment = Enum.TextXAlignment.Left
modInfoTitle.Parent = modInfoGui

local modInfoDesc = Instance.new("TextLabel")
modInfoDesc.Name = "ModInfoDesc"
modInfoDesc.Size = UDim2.new(1, -16, 0, 70)
modInfoDesc.Position = UDim2.new(0, 8, 0, 44)
modInfoDesc.BackgroundTransparency = 1
modInfoDesc.Text = ""
modInfoDesc.Font = Enum.Font.Gotham
modInfoDesc.TextSize = 13
modInfoDesc.TextColor3 = Color3.fromRGB(230, 200, 255)
modInfoDesc.TextXAlignment = Enum.TextXAlignment.Left
modInfoDesc.TextYAlignment = Enum.TextYAlignment.Top
modInfoDesc.TextWrapped = true
modInfoDesc.Parent = modInfoGui

-- Mods list logic
local hoveredModButton = nil
local modButtons = {}
local analyticsModButtons = {}

local function createModButton(modName, layoutOrder, parentFrame)
    local button = Instance.new("TextButton")
    button.Name = modName .. "Button"
    button.Size = UDim2.new(1, 0, 0, 28)
    button.BackgroundColor3 = Color3.fromRGB(140, 0, 200)
    button.BackgroundTransparency = 0.45
    button.BorderSizePixel = 0
    button.Text = modName
    button.Font = Enum.Font.Gotham
    button.TextSize = 13
    button.TextColor3 = Color3.fromRGB(230, 200, 255)
    button.LayoutOrder = layoutOrder
    button.Parent = parentFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = button

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
        button.BackgroundTransparency = 0.15
        hoveredModButton = button
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(140, 0, 200)
        button.BackgroundTransparency = 0.45
        if hoveredModButton == button then
            hoveredModButton = nil
        end
    end)

    button.MouseButton1Click:Connect(function()
        if modActions[modName] then
            modActions[modName]()
        else
			print("[👿nightmare client v1👿] Activated mod:", modName)
        end
    end)

    if parentFrame == modsScroll then
        modButtons[modName] = button
    else
        analyticsModButtons[modName] = button
    end
    return button
end

function updateModsList()
    -- Hide all panels first
    modsScroll.Visible = false
    infoPanel.Visible = false
    analyticsPanel.Visible = false
    reportsPanel.Visible = false
    cameraViewFrame.Visible = false
    analyticsModsFrame.Visible = false

    if selectedCategory == "Info" then
        infoPanel.Visible = true
    elseif selectedCategory == "Overview / Analytics" then
        analyticsPanel.Visible = true
        analyticsModsFrame.Visible = true
        -- Remove old mod buttons from analyticsModsFrame
        for _, child in analyticsModsFrame:GetChildren() do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        local mods = categories[selectedCategory]
        if mods and #mods > 0 then
            for i = 1, #mods do
                createModButton(mods[i], i, analyticsModsFrame)
            end
        end
    elseif selectedCategory == "User Reports" then
        reportsPanel.Visible = true
        updateLeaderboard()
        -- Show mods for User Reports (now empty)
        for _, child in modsScroll:GetChildren() do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        local mods = categories[selectedCategory]
        if mods and #mods > 0 then
            modsScroll.Visible = true
            for i = 1, #mods do
                createModButton(mods[i], i, modsScroll)
            end
            modsScroll.CanvasSize = UDim2.new(0, 0, 0, modsListLayout.AbsoluteContentSize.Y + 10)
        end
    elseif selectedCategory and categories[selectedCategory] then
        modsScroll.Visible = true
        for _, child in modsScroll:GetChildren() do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        local mods = categories[selectedCategory]
        for i = 1, #mods do
            createModButton(mods[i], i, modsScroll)
        end
        modsScroll.CanvasSize = UDim2.new(0, 0, 0, modsListLayout.AbsoluteContentSize.Y + 10)
    end
end

-- Create category buttons (three main categories, plus Info/Analytics/Reports)
local catNames = {"Info", "Movement", "Visual", "OP", "Overview / Analytics", "User Reports"}
for i = 1, #catNames do
    createCategoryButton(catNames[i], i)
end

-- Select Info tab by default
selectedCategory = "Info"
categoryButtons[selectedCategory].BackgroundColor3 = Color3.fromRGB(180, 0, 255)
categoryButtons[selectedCategory].BackgroundTransparency = 0.15
updateModsList()

-- Animation logic for menu open (slower)
function animateMenuOpen()
    mainFrame.Visible = true
    mainFrame.BackgroundTransparency = 1
    mainFrame.Size = UDim2.new(0, 416, 0, 272)
    local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) -- Slower animation
    local tween = TweenService:Create(mainFrame, tweenInfo, {
        BackgroundTransparency = 0.35,
        Size = UDim2.new(0, 520, 0, 340)
    })
    tween:Play()
end

-- Controls notification logic
function showControlsNotification()
    controlsFrame.Visible = true
    controlsFrame.BackgroundTransparency = 1
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(controlsFrame, tweenInfo, {
        BackgroundTransparency = 0.35
    })
    tween:Play()
    task.spawn(function()
        task.wait(10)
        local tweenOut = TweenService:Create(controlsFrame, TweenInfo.new(0.4), {
            BackgroundTransparency = 1
        })
        tweenOut:Play()
        tweenOut.Completed:Wait()
        controlsFrame.Visible = false
    end)
end

-- Hide mod info popup when clicking anywhere else or pressing L again
UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.UserInputType == Enum.UserInputType.MouseButton1 then
        if modInfoGui.Visible then
            modInfoGui.Visible = false
        end
    end
    if not processed and input.KeyCode == Enum.KeyCode.L then
        if modInfoGui.Visible and not hoveredModButton then
            modInfoGui.Visible = false
        end
    end
end)

-- Show mod info popup when hovering and pressing L
UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.L then
        if hoveredModButton then
            local modName = hoveredModButton.Text
            modInfoTitle.Text = modName
            modInfoDesc.Text = modDescriptions[modName] or "No info available."
            modInfoGui.Visible = true
        end
    end
end)

-- Initial menu open (on game start)
task.spawn(function()
    openMenu()
end)

print("[👿nightmare client v1👿] Mod menu loaded with Movement mods: Player Speed, Fly, Slippery Ground, Bouncey Ground, Super Jump, No Clip, Gravity Control, and Overview / Analytics mods added. Fly mod now uses BodyVelocity/BodyGyro for flying and opens persistent controls GUI.")
