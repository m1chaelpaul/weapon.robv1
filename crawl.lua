local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
local animation = humanoid:LoadAnimation(game.Workspace.animations.Crawling) -- Replace 'Crawling' with the name of your crawling animation

local isCrawling = false

local function toggleCrawl()
	isCrawling = not isCrawling

	if isCrawling then
		humanoid.WalkSpeed = humanoid.WalkSpeed / 2
		humanoid.AutoRotate = false
		animation:Play()
	else
		humanoid.WalkSpeed = humanoid.WalkSpeed * 2
		humanoid.AutoRotate = true
		animation:Stop()
	end
end

local function onKeyPress(input, gameProcessedEvent)
	if gameProcessedEvent then
		return
	end

	if input.KeyCode == Enum.KeyCode.C then
		toggleCrawl()
	end
end

game:GetService("UserInputService").InputBegan:Connect(onKeyPress)
