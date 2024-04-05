local hum = script.Parent
local dialogues = {"An intruder injured me, send help!", "Someone has injured me, send help!", "I've been injured, I need help!", "Operator, I need help!", "Operator, an intruder injured me!", "I require assistance!", "I'm in critical condition!"}

hum.HealthChanged:Connect(function()
	if game.Workspace.saveValues.compromised.Value == false then
		if hum.Health > 0 then
			if script.Parent.Parent.alreadyTakenShots.Value == false then
				script.Parent.Parent.alreadyTakenShots.Value = true
				local function bground()
					for i = 1, 10 do
						local bground = script.Parent.Parent.Head.dialogueMaster.Frame
						bground.BackgroundTransparency -= 0.01
						wait(0.01)
					end
				end

				local function txtlbl()
					for i = 1, 10 do
						local txtlbl = script.Parent.Parent.Head.dialogueMaster.Frame.TextLabel
						txtlbl.BackgroundTransparency -= 0.05
						wait(0.01)
					end
				end

				local function typewriterEffect(text)
					for i = 1, #text do
						local txtlbl = script.Parent.Parent.Head.dialogueMaster.Frame.TextLabel
						txtlbl.Text = string.sub(text, 1, i)
						script.Parent.Parent.Dialogue:Play()
						wait(0.02)
					end
				end

				local randomItem = dialogues[math.random(1, #dialogues)]

				local y = coroutine.wrap(bground)
				local x = coroutine.wrap(txtlbl)

				script.Parent.Parent.noticed:Play()
				script.Parent.WalkSpeed = 0
				script.Parent.Parent.Head.headsUpDisplay.Frame.exc.Visible = true
				
				script.Parent.Parent.Head.shocked.Transparency = 0
				script.Parent.Parent.Head.Decal.Transparency = 1
				script.Parent.Parent.Head.death.Transparency = 1
				
				wait(4)
				
				script.Parent.Parent.Head.shocked.Transparency = 1
				script.Parent.Parent.Head.Decal.Transparency = 0
				script.Parent.Parent.Head.death.Transparency = 1

				if hum.Health == 0 then
					script.Parent.Parent.Head.shocked.Transparency = 1
					script.Parent.Parent.Head.Decal.Transparency = 1
					script.Parent.Parent.Head.death.Transparency = 0
					script.Parent.Parent.Head.headsUpDisplay.Frame.exc.Visible = false
					script.Parent.Parent.Head.dialogueMaster.Enabled = false
					game.Workspace.saveValues.compromised.Value = false
					script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.Visible = false
					wait(1)
					script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.Visible = true
					script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.new(255,255,255)
					script.Parent.Parent.radio:Play()
					script.Parent.Parent.operator:Play()
					script.Parent.Parent.UpperTorso.ProximityPrompt.Enabled = true
					task.wait(7)
					if script.Parent.Parent.UpperTorso.ProximityPrompt.answered.Value == false then
						script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.fromRGB(255, 0, 4)
						wait(1)
						script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.new(255,255,255)
						wait(1)
						script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.fromRGB(255, 0, 4)
						wait(1)
						script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.new(255,255,255)
						task.wait(1)
						if script.Parent.Parent.UpperTorso.ProximityPrompt.answered.Value == false then
							game.Workspace.saveValues.compromised.Value = true
							game.Workspace.saveValues.compromised.reason.Value = "Player didn't answer pager in time!"
						end
					end
				else
					script.Parent.Parent.Head.headsUpDisplay.Frame.exc.Visible = false
					script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.Visible = true
					wait(0.5)
					y()
					wait(0.5)
					x()
					wait(0.5)

					typewriterEffect(randomItem)

					task.wait(3)

					if hum.Health > 0 then
						game.Workspace.saveValues.compromised.Value = true
						script.Parent.Parent.Head.dialogueMaster.Enabled = false
						game.Workspace.saveValues.compromised.reason.Value = "Player attempted to injure a guard!"
						script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.Visible = false
					else
						script.Parent.Parent.Head.dialogueMaster.Enabled = false
						game.Workspace.saveValues.compromised.Value = false
						script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.Visible = false
						wait(1)
						script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.Visible = true
						script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.new(255,255,255)
						script.Parent.Parent.radio:Play()
						script.Parent.Parent.operator:Play()
						script.Parent.Parent.UpperTorso.ProximityPrompt.Enabled = true
						task.wait(7)
						if script.Parent.Parent.UpperTorso.ProximityPrompt.answered.Value == false then
							script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.fromRGB(255, 0, 4)
							wait(1)
							script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.new(255,255,255)
							wait(1)
							script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.fromRGB(255, 0, 4)
							wait(1)
							script.Parent.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.new(255,255,255)
							task.wait(1)
							if script.Parent.Parent.UpperTorso.ProximityPrompt.answered.Value == false then
								game.Workspace.saveValues.compromised.Value = true
								game.Workspace.saveValues.compromised.reason.Value = "Player didn't answer pager in time!"
							end
						end
					end
				end
			end
		else
			script.Parent.Parent.Head.ProximityAttatchment.ProximityPrompt.Enabled = true
			script.Parent.Parent.Highlight.Enabled = true
		end
	end
end)

script.Parent.HealthChanged:Connect(function()
	if hum.Health == 0 then
		script.Parent.Parent.suspiciousItem.Value = true
	else
		script.Parent.Parent.suspiciousItem.Value = false
	end
end)
