local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character:WaitForChild("Humanoid")
local speedMultiplier = 2 -- Change this value to adjust sprinting speed

local isSprinting = false

function onKeyUp(inputObject, gameProcessedEvent)
	if inputObject.KeyCode == Enum.KeyCode.LeftShift then
		isSprinting = false
		humanoid.WalkSpeed = humanoid.WalkSpeed / speedMultiplier
	end
end

function onKeyDown(inputObject, gameProcessedEvent)
	if inputObject.KeyCode == Enum.KeyCode.LeftShift then
		isSprinting = true
		humanoid.WalkSpeed = humanoid.WalkSpeed * speedMultiplier
	end
end

function onCharacterAdded(character)
	humanoid = character:WaitForChild("Humanoid")
end

player.CharacterAdded:Connect(onCharacterAdded)
game:GetService("UserInputService").InputBegan:Connect(onKeyDown)
game:GetService("UserInputService").InputEnded:Connect(onKeyUp)
