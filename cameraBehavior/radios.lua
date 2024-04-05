local radios = game.Workspace.saveValues.radioWork

radios:GetPropertyChangedSignal("Value"):Connect(function()
	if radios.Value == true then
		script.Parent.HumanoidRootPart.enableder.Enabled = true
		script.Parent.HumanoidRootPart.ProximityPrompt.Enabled = false
	end
end)
