game:GetService("ReplicatedStorage").doDialogue.OnClientEvent:Connect(function(text)
	
	game.Players.LocalPlayer.PlayerGui:WaitForChild("dialoges").Enabled = true
	
	local function typewriterEffect(text)
		for i = 1, #text do

			local txtlbl = game.Players.LocalPlayer.PlayerGui:WaitForChild("dialoges").Frame.TextLabel
			txtlbl.Text = string.sub(text, 1, i)

			if string.sub(text, i, i) == "." then
				game:GetService("SoundService").Dialogue:Play()
				wait(1)
			else
				game:GetService("SoundService").Dialogue:Play()
				wait(0.01)
			end
		end
	end
	
	typewriterEffect(text)
	
	task.wait(5)

	game.Players.LocalPlayer.PlayerGui:WaitForChild("dialoges").Enabled = false
	game.Players.LocalPlayer.PlayerGui:WaitForChild("dialoges").Frame.TextLabel.Text = ""
	
end)
