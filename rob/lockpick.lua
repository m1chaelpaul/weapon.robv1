local door = script.Parent.Parent.Parent

local door2 = script.Parent.Parent.Parent.Parent.Door2

local hinge = script.Parent.Parent.Parent.Parent.Hinge

local hinge2 = script.Parent.Parent.Parent.Parent.Hinge2

local ts = game:GetService("TweenService")

local ti = TweenInfo.new(1.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0,false,0)
local ti2 = TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)

local offset = hinge.CFrame:Inverse() * door.CFrame

local offset2 = hinge2.CFrame:Inverse() * door2.CFrame

local dooropen = ts:Create(script.Parent.Angle, ti, {Value = -99})
local doorclose = ts:Create(script.Parent.Angle, ti2, {Value = 0})

local opening = script.Parent.Parent.Parent.Parent.opening

game:GetService("RunService").Heartbeat:Connect(function(dt)
	door.CFrame = hinge.CFrame * CFrame.Angles(0, math.rad(script.Parent.Angle.Value), 0) * offset
end)

game:GetService("RunService").Heartbeat:Connect(function(dt)
	door2.CFrame = hinge2.CFrame * CFrame.Angles(0, math.rad(script.Parent.Angle.Value), 0) * offset2
end)

script.Parent.Triggered:Connect(function(plr)
	
	if opening.Value == false then
		opening.Value = true
		
		dooropen:Play()
		door.CanCollide = false
		door.Handle.CanCollide = false
		
		door2.CanCollide = false
		door2.Handle.CanCollide = false
		
		door.DoorOpen:Play()
		script.Parent.Enabled = false
		
		wait(4)
		
		doorclose:Play()

		wait(0.8)
		
		door.CanCollide = true
		door.Handle.CanCollide = true
		door.DoorClose:Play()
		
		door2.CanCollide = true
		door2.Handle.CanCollide = true
		
		script.Parent.Enabled = true
		
		opening.Value = false
		
	end
end)
