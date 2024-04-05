local tweenservice = game:GetService("TweenService")
local start = game.Workspace.CurrentCamera
local ending = {FieldOfView = 35}
local tweeninfo = TweenInfo.new(
	.5, 
	Enum.EasingStyle.Sine, 
	Enum.EasingDirection.InOut, 
	0, 
	false, 
	0
)

local starting = {FieldOfView = 75}
local tweeninfo2 = TweenInfo.new(
	.5, 
	Enum.EasingStyle.Sine, 
	Enum.EasingDirection.InOut, 
	0, 
	false, 
	0
)

local playtween = tweenservice:Create(start, tweeninfo, ending)
local endtween = tweenservice:Create(start, tweeninfo2, starting)

script.Parent.Equipped:Connect(function(mouse)
	
	local hum = script.Parent.Parent.Humanoid
	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://14190595245"
	local loadAnim = hum:LoadAnimation(anim)
	
	mouse.Button2Down:Connect(function()
		playtween:Play()
		loadAnim:Play()
	end)

	mouse.Button2Up:Connect(function()
		
		endtween:Play()
		
		script.Parent.Parent.Humanoid.WalkSpeed = 8
		wait(.1)
		game.Workspace.CurrentCamera.FieldOfView = 75
		
		loadAnim:Stop()
		
	end)
end)
