script.Parent.HealthChanged:Connect(function()
	if script.Parent.Health == 0 then
		game.Workspace.saveValues.Objs.killRod.Value = true
		local text = "I hope you know that wasn't personal."
		game:GetService("ReplicatedStorage").doDialogue:FireAllClients(text)
	end
end)
