--[[█▀▀ █▀█ █▀▄ █▀▀ █▀▄   █▄▄ █▄█   █░█ █▀█ █▀   ▀█▀ █▀█ █░█ █░░ █▄█
    █▄▄ █▄█ █▄▀ ██▄ █▄▀   █▄█ ░█░   █▄█ █▀▄ ▄█   ░█░ █▀▄ █▄█ █▄▄ ░█░

█▀█ █ █▀▄ █▀▄ █░░ █▀▀ █▀▄▀█ █ █▄░█ █▀▀ █▀▀ █▀█ ▄▀█ █▀▀ ▀█▀ █▀▀ █▀▄
█▀▄ █ █▄▀ █▄▀ █▄▄ ██▄ █░▀░█ █ █░▀█ ██▄ █▄▄ █▀▄ █▀█ █▀░ ░█░ ██▄ █▄▀]]--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local localPlayer = Players.LocalPlayer

local damage = 85

local debounce = false

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if input.KeyCode == Enum.KeyCode.F and not gameProcessedEvent then
		if not debounce then -- Checks if debounce == false
			debounce = true
			
			local humanoid = localPlayer.Character.Humanoid -- Gets the localPlayer's humanoid
			
			if humanoid.RigType == Enum.HumanoidRigType.R6 then -- Checks if the localPlayer's humanoid is R6
			
				local animation = Instance.new("Animation") -- Inserts an animation
				animation.AnimationId = "rbxassetid://14121165874"
				animation.Parent = humanoid
				
				local animationToLoad = {animation}
				ContentProvider:PreloadAsync(animationToLoad) -- Preloads the animation to prevent delay
				
				local loadedAnimation = humanoid:LoadAnimation(animation) -- Loads the animation with the humanoid
				
				loadedAnimation:Play() -- Plays the animation
				
				local hitDebounce = false 
				
				local touch 
				
				local function onTouch(hit)
					if hit.Parent:FindFirstChildWhichIsA("Humanoid") then -- Checks if the instance hit has a humanoid
						if hit.Parent.Humanoid.Health > 0 and not hitDebounce then -- Checks if hitDebounce == false and the target's health > 0
							hitDebounce = true
							
							local targetCharacter = hit.Parent -- Gets the target character
						
							ReplicatedStorage.KillHumanoidEvent:FireServer( -- Fires the ServerScript which makes the health of the target go down
								targetCharacter.Humanoid, -- Target humanoid
								damage -- Damage
							)
	
							touch:Disconnect()
							wait(1)
							hitDebounce = false
						end
					end
				end
				
				touch = localPlayer.Character["Right Arm"].Touched:Connect(onTouch)
				
			else
				
				-- Below is basically the same thing but with R15 -- 
				
				wait(0.1)
				
				local prevalue = game.Players.LocalPlayer.currentTask.Value
				
				local animation1 = Instance.new("Animation")
				animation1.AnimationId = "rbxassetid://14121165874" 
				animation1.Parent = humanoid
				
				local animationToLoad = {animation1}
				
				ContentProvider:PreloadAsync(animationToLoad) -- Preloads the animation to prevent delay
				
				local loadedAnimation = humanoid:LoadAnimation(animation1) -- Loads the animation with the humanoid
				
				local animation2 = Instance.new("Animation")
				animation2.AnimationId = "rbxassetid://14121193778" 
				animation2.Parent = humanoid

				local animationToLoad = {animation2}

				ContentProvider:PreloadAsync(animationToLoad) -- Preloads the animation to prevent delay

				local loadedAnimation2 = humanoid:LoadAnimation(animation2) -- Loads the animation with the humanoid
				
				local DoMath = math.random(1, 2)
				if DoMath == 1 then
					loadedAnimation:Play()
					game.Players.LocalPlayer.currentTask.Value = "Suspicious"
				elseif DoMath == 2 then
					loadedAnimation2:Play()
					game.Players.LocalPlayer.currentTask.Value = "Suspicious"
				end
				
				wait(0.25)
				
				game.Players.LocalPlayer.currentTask.Value = tostring(prevalue)
				
				local hitDebounce = false 
				
				local touch 
				
				local function onTouch(hit)
					if hit.Parent:FindFirstChildWhichIsA("Humanoid") then -- Checks if the instance hit has a humanoid
						if hit.Parent.Humanoid.Health > 0 and not hitDebounce then -- Checks if hitDebounce == false and the target's health > 0
							hitDebounce = true
							
							local targetCharacter = hit.Parent -- Gets the target character
						
							ReplicatedStorage.KillHumanoidEvent:FireServer( -- Fires the ServerScript which makes the health of the target go down
								targetCharacter.Humanoid, -- Target humanoid
								damage -- Damage
							)
	
							touch:Disconnect()
							wait(2.5)
							hitDebounce = false
						end
					end
					
				end
				
				touch = localPlayer.Character["RightHand"].Touched:Connect(onTouch)
			end
			
			wait(1)
			debounce = false
		end
	end
end)
