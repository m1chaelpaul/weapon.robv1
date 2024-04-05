local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

ReplicatedStorage:WaitForChild("KillHumanoidEvent").OnServerEvent:Connect(function(firerPlayer, targetHumanoid, damage)
	game.Workspace:FindFirstChild(tostring(firerPlayer.Name)):FindFirstChild("suspiciousItem").Value = true
	targetHumanoid:TakeDamage(damage)
	wait(2)
	game.Workspace:FindFirstChild(tostring(firerPlayer.Name)):FindFirstChild("suspiciousItem").Value = false
end)
