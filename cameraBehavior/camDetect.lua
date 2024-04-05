local foundsusssyitem = false

local detectionRange = 45 -- Adjust this value to set the detection range for items around the NPC

local fov = 75

local function isItemSuspicious(item)
	if item:FindFirstChild("suspiciousItem") then
		if item.suspiciousItem.Value == true then
			return item
		end
	end
end

local function releaseMayhem()
	local cbb = script.Parent.canbeBroken
	if cbb.Value == false then
		local radios = game.Workspace.saveValues.radioWork
		if radios.Value == false then
			script.Parent.noticed:Play()
			script.Parent.HumanoidRootPart.headsUpDisplay.Frame.exc.Visible = true
			task.wait(4)
			script.Parent.HumanoidRootPart.headsUpDisplay.Frame.exc.Visible = false
			game.Workspace.saveValues.compromised.Value = true
			game.Workspace.saveValues.compromised.reason.Value = "Camera saw something suspicious!"
		end
	end
end

-- Function to detect nearby items
local function detectNearbyItems()
	local items = {} -- Table to store nearby items

	local fovRadians = math.rad(fov)

	local coneDirectionLeft = (script.Parent.HumanoidRootPart.CFrame * CFrame.Angles(0, fovRadians / 2, 0)).LookVector
	local coneDirectionRight = (script.Parent.HumanoidRootPart.CFrame * CFrame.Angles(0, -fovRadians / 2, 0)).LookVector

	local npcPosition = script.Parent.HumanoidRootPart.Position -- Position of the NPC

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
								if game.Workspace.saveValues.compromised.Value == false then
									foundsusssyitem = true
									releaseMayhem()
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
										if game.Workspace.saveValues.compromised.Value == false then
											foundsusssyitem = true
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
