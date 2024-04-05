local startDance = game:GetService("ReplicatedStorage").makePlayerDance
local stopDance = game:GetService("ReplicatedStorage").stopPlayerDance
local hum = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://14161842318"
local loadAnim = hum:LoadAnimation(anim)
local preValue = game.Players.LocalPlayer:WaitForChild("currentTask")
local pvv = preValue.Value

startDance.OnClientEvent:Connect(function(player)
	loadAnim:Play()
	hum.WalkSpeed = hum.WalkSpeed / 4
	pvv = preValue.Value
	preValue.Value = "Suspicious"
end)

stopDance.OnClientEvent:Connect(function(player)
	loadAnim:Stop()
	hum.WalkSpeed = hum.WalkSpeed * 4
	preValue.Value = pvv
end)
