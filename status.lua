local currentTask = game.Players.LocalPlayer.currentTask
local compromised = game.Workspace.saveValues.compromised

currentTask:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.TextLabel.Text = tostring(currentTask.Value)
	if currentTask.Value == "Suspicious" then
		if compromised.Value == true then
			script.Parent.TextLabel.Text = "Compromised"
			script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 4)
		else
			script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 4)
			script.Parent.EXC.Visible = true
			script.Parent.Eye.Visible = false
		end
	else
		if script.Parent.TextLabel.Text ~= "Compromised" then
			script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
			script.Parent.EXC.Visible = false
			script.Parent.Eye.Visible = true
		end
	end
	wait(2)
	if currentTask.Value == "Compromised" then
		script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 4)
		script.Parent.EXC.Visible = true
		script.Parent.Eye.Visible = false
		script.Parent.TextLabel.Text = "Compromised"
	end
end)

compromised:GetPropertyChangedSignal("Value"):Connect(function()
	if compromised.Value == true then
		script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 4)
		script.Parent.EXC.Visible = true
		script.Parent.Eye.Visible = false
		script.Parent.TextLabel.Text = "Compromised"
	end
end)

while wait(1) do
	if currentTask.Value == "Suspicious" then
		if compromised.Value == true then
			script.Parent.TextLabel.Text = "Compromised"
			script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 4)
			script.Parent.EXC.Visible = true
			script.Parent.Eye.Visible = false
		else
			script.Parent.TextLabel.Text = "Suspicious"
			script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 4)
			script.Parent.EXC.Visible = true
			script.Parent.Eye.Visible = false
		end
	elseif compromised.Value == true then
		script.Parent.TextLabel.Text = "Compromised"
		script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 4)
		script.Parent.EXC.Visible = true
		script.Parent.Eye.Visible = false
	else
		script.Parent.TextLabel.Text = currentTask.Value
		script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
		script.Parent.EXC.Visible = false
		script.Parent.Eye.Visible = true
	end
end
