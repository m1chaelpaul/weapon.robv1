local gun = script.Parent
local bullet = gun.Handle:WaitForChild("Bullet")
local shotfired = gun:WaitForChild("ShotFired")
local speed = gun.speed.Value

shotfired.OnServerEvent:Connect(function(Player, MousePosition)
	if gun.ammo.Value > 0 then
		gun.ammo.Value = gun.ammo.Value -1

		local BulletClone = bullet:Clone()
		local damclone = game.ReplicatedStorage.damage:Clone()

		BulletClone.Transparency = 1
		BulletClone.Position = bullet.Position + Vector3.new(0, 1, 0)
		BulletClone.CFrame = CFrame.new(BulletClone.Position, MousePosition)
		BulletClone.Parent = game.Workspace

		local Force = Instance.new("BodyVelocity", BulletClone)
		Force.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		Force.Velocity = BulletClone.CFrame.lookVector * speed
		
		local hum = script.Parent.Parent:WaitForChild("Humanoid")
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://14171887020"
		local loadAnim = hum:LoadAnimation(anim)

		gun.gunshot:Play()
		loadAnim:Play()
		
		local h = script.Parent.Handle.SmokePart
		
		h["FlashFX[Flash]"].Enabled = true
		h.PointLight.Enabled =true
		h.Smoke.Enabled = true

		local att = Instance.new("Attachment")
		local att1 = Instance.new("Attachment")
		local trail = Instance.new("Trail")
		att.Name = "Attachment"
		att1.Name = "Attachment1"
		att.Parent = BulletClone
		att1.Parent = BulletClone
		trail.Parent = BulletClone
		trail.Attachment0 = att
		trail.Attachment1 = att1
		trail.Color = ColorSequence.new(Color3.fromRGB(255, 247, 25))
		att.CFrame = CFrame.new(0, 0.05, 0)
		trail.Lifetime = 0.2
		trail.Transparency = NumberSequence.new(0.7)

		damclone.Parent = BulletClone
		
		wait(0.1)
		
		h["FlashFX[Flash]"].Enabled = false
		h.PointLight.Enabled = false
		h.Smoke.Enabled = false
		
		wait(0.4)
		
		script.Parent.pump:Play()
		BulletClone:Destroy()
		
	end
end)
