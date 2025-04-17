
pcall(function()
    game:GetService("CoreGui").TimerUI:Destroy()
end)


local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")


local gui = Instance.new("ScreenGui")
gui.Name = "TimerUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = CoreGui


local backgroundLayer = Instance.new("Frame")
backgroundLayer.Size = UDim2.new(0, 120, 0, 50) -- Smaller background
backgroundLayer.Position = UDim2.new(1, -125, 1, -55) -- Bottom-right corner
backgroundLayer.BackgroundColor3 = Color3.fromRGB(169, 169, 169) -- Gray color
backgroundLayer.BorderSizePixel = 0
backgroundLayer.Parent = gui


local bgCorner = Instance.new("UICorner")
bgCorner.CornerRadius = UDim.new(0, 10)
bgCorner.Parent = backgroundLayer


local dragFrame = Instance.new("Frame")
dragFrame.Size = UDim2.new(0, 100, 0, 40) -- idl.vb
dragFrame.Position = UDim2.new(0.5, -50, 0.5, -20)
dragFrame.BackgroundColor3 = Color3.new(0, 0, 0) -- idl.vb
dragFrame.BorderSizePixel = 0
dragFrame.Active = true
dragFrame.Draggable = false
dragFrame.Parent = backgroundLayer


local round = Instance.new("UICorner")
round.CornerRadius = UDim.new(0, 10)
round.Parent = dragFrame


local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255, 255, 255) -- Wy.bn
label.Font = Enum.Font.GothamBold
label.TextScaled = true
label.Text = "10:00"
label.Parent = dragFrame


local dragging = false
local dragStart, startPos

dragFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = dragFrame.Position

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
		local newPos = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)

		TweenService:Create(dragFrame, TweenInfo.new(0.05), {Position = newPos}):Play()
	end
end)


local totalTime = 10 * 60

task.spawn(function()
	while totalTime >= 0 do
		local minutes = math.floor(totalTime / 60)
		local seconds = totalTime % 60

		
		if totalTime == 119 then
			label.TextColor3 = Color3.fromRGB(139, 0, 0) -- idl
		end

		
		if totalTime == 0 then
			label.Text = "Time's Up!"
			label.TextColor3 = Color3.fromRGB(139, 0, 0) -- idl
			break
		else
			label.Text = string.format("%02d:%02d", minutes, seconds)
		end

		task.wait(1)
		totalTime -= 1
	end
end)


task.spawn(function()
    local url = "https://raw.githubusercontent.com/ringtaa/newpacifisct/refs/heads/main/newpacifisct.lua"
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if success then
        local func, err = loadstring(response)
        if func then
            func()
        else
            warn("Error loading script: " .. err)
        end
    else
        warn("Failed to fetch script: " .. response)
    end
end)
