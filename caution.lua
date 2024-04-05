local alertLvl = game.Workspace.saveValues.AlertLV
local txtlbl = script.Parent.Frame.TextLabel

alertLvl:GetPropertyChangedSignal("Value"):Connect(function()
	if alertLvl.Value == 0 then
		txtlbl.Text = "Relaxed"
		txtlbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	elseif alertLvl.Value == 1 then
		txtlbl.Text = "Neutral"
		txtlbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	elseif alertLvl.Value == 2 then
		txtlbl.Text = "Anxious"
		txtlbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	elseif alertLvl.Value == 3 then
		txtlbl.Text = "Uneasy"
		txtlbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	elseif alertLvl.Value == 4 then
		txtlbl.Text = "Tense"
		txtlbl.TextColor3 = Color3.fromRGB(255, 0, 4)
		script.Parent.Frame.img.ImageColor3 = Color3.fromRGB(255, 0, 4)
	elseif alertLvl.Value == 5 then
		txtlbl.Text = "Panicked"
		txtlbl.TextColor3 = Color3.fromRGB(255, 0, 4)
		script.Parent.Frame.img.ImageColor3 = Color3.fromRGB(255, 0, 4)
	elseif alertLvl.Value == 6 then
		txtlbl.Text = "Stressed"
		txtlbl.TextColor3 = Color3.fromRGB(255, 0, 4)
	elseif alertLvl.Value == 7 then
		txtlbl.Text = "Alert"
		txtlbl.TextColor3 = Color3.fromRGB(255,0,4)
	end
end)

alertLvl.Parent.compromised:GetPropertyChangedSignal("Value"):Connect(function()
	txtlbl.Text = "Lockdown"
	txtlbl.TextColor3 = Color3.fromRGB(255, 0, 4)
	script.Parent.Frame.img.ImageColor3 = Color3.fromRGB(255, 0, 4)
end)
