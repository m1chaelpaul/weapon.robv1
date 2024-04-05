local foundsusssyitem = false

local detectionRange = 80 -- Adjust this value to set the detection range for items around the NPC

local fov = 180

local dialogues = {"I've discovered something unusual!", "I've discovered a hazardous object!", "I've discovered a suspicious object!", "I've seen something suspicious!", "I saw something unusual!", "I saw something suspicious!"}

local function bground()
	for i = 1, 10 do
		local bground = script.Parent.Head.dialogueMaster.Frame
		bground.BackgroundTransparency -= 0.01
		wait(0.01)
	end
end

local function txtlbl()
	for i = 1, 10 do
		local txtlbl = script.Parent.Head.dialogueMaster.Frame.TextLabel
		txtlbl.BackgroundTransparency -= 0.05
		wait(0.01)
	end
end

local function typewriterEffect(text)
	for i = 1, #text do
		local txtlbl = script.Parent.Head.dialogueMaster.Frame.TextLabel
		txtlbl.Text = string.sub(text, 1, i)
		script.Parent.Dialogue:Play()
		wait(0.02)
	end
end

local function releaseMayhem()
	if script.Parent.alreadyTakenShots.Value == false then

		if script.Parent.Humanoid.Health > 0 then
			script.Parent.alreadyTakenShots.Value = true
			local randomItem = dialogues[math.random(1, #dialogues)]

			local y = coroutine.wrap(bground)
			local x = coroutine.wrap(txtlbl)

			script.Parent.noticed:Play()
			script.Parent.Head.headsUpDisplay.Frame.exc.Visible = true

			script.Parent.Humanoid.WalkSpeed = 0

			script.Parent.Head.shocked.Transparency = 0
			script.Parent.Head.Decal.Transparency = 1
			script.Parent.Head.death.Transparency = 1

			wait(4)
			script.Parent.Head.headsUpDisplay.Frame.exc.Visible = false
			script.Parent.Head.headsUpDisplay.Frame.ImageLabel.Visible = true

			local hum = script.Parent.Humanoid
			if hum.Health > 0 then
				script.Parent.Head.shocked.Transparency = 1
				script.Parent.Head.Decal.Transparency = 0
				script.Parent.Head.death.Transparency = 1
			else
				script.Parent.Head.shocked.Transparency = 1
				script.Parent.Head.Decal.Transparency = 1
				script.Parent.Head.death.Transparency = 0
			end

			if script.Parent.Humanoid.Health > 0 then

				wait(0.5)
				y()
				wait(0.5)
				x()
				wait(0.5)

				typewriterEffect(randomItem)

			end

			task.wait(3)

			local hum = script.Parent.Humanoid

			if hum.Health > 0 then
				game.Workspace.saveValues.compromised.Value = true
				script.Parent.Head.dialogueMaster.Enabled = false
				game.Workspace.saveValues.compromised.reason.Value = "Guard saw something suspicious!"
				script.Parent.Head.headsUpDisplay.Frame.ImageLabel.Visible = false
			else
				script.Parent.Head.dialogueMaster.Enabled = false
				game.Workspace.saveValues.compromised.Value = false
				script.Parent.Head.headsUpDisplay.Frame.ImageLabel.Visible = false
				wait(1)

				script.Parent.Head.headsUpDisplay.Frame.ImageLabel.Visible = true
				script.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.new(255,255,255)
				script.Parent.radio:Play()
				script.Parent.operator:Play()
				script.Parent.UpperTorso.ProximityPrompt.Enabled = true
				task.wait(7)
				if script.Parent.UpperTorso.ProximityPrompt.answered.Value == false then
					script.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.fromRGB(255, 0, 4)
					wait(1)
					script.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.new(255,255,255)
					wait(1)
					script.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.fromRGB(255, 0, 4)
					wait(1)
					script.Parent.Head.headsUpDisplay.Frame.ImageLabel.ImageColor3 = Color3.new(255,255,255)
					task.wait(1)
					if script.Parent.UpperTorso.ProximityPrompt.answered.Value == false then
						game.Workspace.saveValues.compromised.Value = true
						game.Workspace.saveValues.compromised.reason.Value = "Player didn't answer pager in time!"
					end
				end
			end
		end
	end
end

local function isItemSuspicious(item)
	if item:FindFirstChild("suspiciousItem") then
		if item.suspiciousItem.Value == true then
			return item
		end
	end
end


-- Function to detect nearby items
local function detectNearbyItems()
	local items = {} -- Table to store nearby items

	local fovRadians = math.rad(fov)

	local coneDirectionLeft = (script.Parent.Head.CFrame * CFrame.Angles(0, fovRadians / 2, 0)).LookVector
	local coneDirectionRight = (script.Parent.Head.CFrame * CFrame.Angles(0, -fovRadians / 2, 0)).LookVector

	local npcPosition = script.Parent.Head.Position -- Position of the NPC

	for _, item in ipairs(workspace:GetChildren()) do
		if isItemSuspicious(item) then
			local itemPosition = item:IsA("BasePart") and item.Position or item.Head.Position
			if item:FindFirstChild("Humanoid") then
				if (item.Head.Position - npcPosition).magnitude <= detectionRange then
					local direction = (itemPosition - npcPosition).unit
					local projection = npcPosition + direction * 3
					local ray = Ray.new(projection, direction * detectionRange)
					local part, position = game.Workspace:FindPartOnRay(ray, script.Parent)
					
					if part and part:IsDescendantOf(item) then
						local angleToLeft = math.acos(coneDirectionLeft:Dot(direction))
						local angleToRight = math.acos(coneDirectionRight:Dot(direction))
						if angleToLeft <= fovRadians and angleToRight <= fovRadians then
							if foundsusssyitem == false then
								if script.Parent.Humanoid.Health > 0 then
									if game.Workspace.saveValues.compromised.Value == false then
										foundsusssyitem = true
										local head = script.Parent.Head
										local headDirection = (itemPosition - head.Position).unit
										local lookatCframe = CFrame.new(head.Position, head.Position + headDirection)
										head.CFrame = lookatCframe
										releaseMayhem()
									end
								end
							end
						end
					end
				else
				end
			else
				if item:FindFirstChild("suspiciousItem") then
					if (item.Position - npcPosition).magnitude <= detectionRange then
						if isItemSuspicious(item) then
							local direction = (itemPosition - npcPosition).unit
							local projection = npcPosition + direction * 3
							local ray = Ray.new(projection, direction * detectionRange)
							
							local raycastresult = workspace:Raycast(projection, direction * detectionRange)

							if raycastresult then
								local hitObject = raycastresult.Instance
								if hitObject == item then
									if foundsusssyitem == false then
										if script.Parent.Humanoid.Health > 0 then
											if game.Workspace.saveValues.compromised.Value == false then
												foundsusssyitem = true
												local head = script.Parent.Head
												local headDirection = (itemPosition - head.Position).unit
												local lookatCframe = CFrame.new(head.Position, head.Position + headDirection)
												head.CFrame = lookatCframe
												releaseMayhem()
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	return items
end

local function processDetectedItems(items)
	for _, item in ipairs(items) do
		print(item.Name .. " is a suspicious item!")
	end
end

while wait() do
	local nearbyItems = detectNearbyItems()
	processDetectedItems(nearbyItems)
end

