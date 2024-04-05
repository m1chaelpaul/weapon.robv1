local enemy = script.Parent
local detectionRange = 65
local domain = false

enemy.PrimaryPart = enemy:FindFirstChild("HumanoidRootPart")
if not enemy.PrimaryPart then
	error("No current valid response")
	return
end

function checkForNearbyPlayers()
	while true do
		wait(0.4)
		
		local gun = game:GetService("ReplicatedStorage").Handgun

		local players = game.Players:GetPlayers()
		
		if script.Parent:FindFirstChild("Handgun") then
			
		else
			if script.Parent.Humanoid.Health > 0 then
				local gc = gun:Clone()
				gc.Parent = script.Parent
			end
		end
		
		wait()
		
		local gun = script.Parent:WaitForChild("Handgun")

		if domain == false then
			for _, player in pairs(players) do
				if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local playerPosition = player.Character.HumanoidRootPart.Position
					local enemyPosition = enemy.PrimaryPart.Position
					local distance = (playerPosition - enemyPosition).magnitude

					if distance <= detectionRange then
						local direction = (playerPosition - enemyPosition).unit
						local frontoffset = 3
						local projection = enemyPosition + direction * frontoffset

						-- Perform Raycasting to check for obstacles between the NPC and player
						local ray = Ray.new(projection, direction * detectionRange)
						local part, position = game.Workspace:FindPartOnRay(ray, enemy)
						if part and part:IsDescendantOf(player.Character) then
							local hum = script.Parent.Humanoid
							local anim = Instance.new("Animation")
							anim.AnimationId = "rbxassetid://14131287240"

							local loadinganim = Instance.new("Animation")
							loadinganim.AnimationId = "rbxassetid://14131303547"

							local firinganim = Instance.new("Animation")
							firinganim.AnimationId = "rbxassetid://14135315820"

							local abc = hum:LoadAnimation(firinganim)
							local xyz = hum:LoadAnimation(loadinganim)
							local loadanim = hum:LoadAnimation(anim)

							local domath = math.random(1, 20)

							if domath == 7 then
								local lookat = (playerPosition - enemyPosition).unit
								local lookatCFrame = CFrame.new(enemyPosition, enemyPosition + lookat)
								enemy:SetPrimaryPartCFrame(lookatCFrame)

								xyz:Play()
								abc:Play()
								script.Parent.Reload:Play()
								wait(2)
							else
								local lookat = (playerPosition - enemyPosition).unit
								local lookatCFrame = CFrame.new(enemyPosition, enemyPosition + lookat)
								enemy:SetPrimaryPartCFrame(lookatCFrame)

								player.Character.Humanoid.Health -= 30
								xyz:Play()
								loadanim:Play()

								script.Parent.gunshot:Play()
								script.Parent.Handgun.Handle.SmokePart["FlashFX[Flash]"].Enabled = true
								script.Parent.Handgun.Handle.SmokePart.Smoke.Enabled = true
								script.Parent.Handgun.Handle.SmokePart.PointLight.Enabled = true
								wait(0.1)
								script.Parent.Handgun.Handle.SmokePart["FlashFX[Flash]"].Enabled = false
								script.Parent.Handgun.Handle.SmokePart.Smoke.Enabled = false
								script.Parent.Handgun.Handle.SmokePart.PointLight.Enabled = false
							end
						end
					end
				end
			end
		end
	end
end

local compromised = game.Workspace.saveValues.compromised
local hum = script.Parent.Humanoid

if compromised.Value == true then
	checkForNearbyPlayers()
end

compromised:GetPropertyChangedSignal("Value"):Connect(function()
	if compromised.Value == true then
		checkForNearbyPlayers()
	end
end)

hum.HealthChanged:Connect(function()
	if hum.Health == 0 then
		domain = true
	end
end)
