script.Parent.Triggered:Connect(function()
	game.Workspace.saveValues.Objs.collectEvidence.evidenceNums.Value += 1
	script.Parent.Enabled = false
	script.Parent.Parent.Parent:Destroy()
end)
