script.Parent.HealthChanged:Connect(function()
	if script.Parent.Health == 0 then
		script.Parent.Parent.Head.shocked.Transparency = 1
		script.Parent.Parent.Head.Decal.Transparency = 1
		script.Parent.Parent.Head.death.Transparency = 0
		
		script.Parent.Parent.suspiciousItem.Value = true
		
		local ammoCrate = game:GetService("ReplicatedStorage").AmmoCrate:Clone()
		ammoCrate.Parent = game.Workspace
		local headpos = script.Parent.Parent.Head.Position
		
		ammoCrate.Position = headpos
		
	end
end)
