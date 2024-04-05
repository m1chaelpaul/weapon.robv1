local gun = script.Parent
local player = game.Players.LocalPlayer
local mousedown = false


gun.Equipped:Connect(function(mouse)
	mouse.Button1Down:Connect(function()
		if gun.ammo.Value > 0 then
			if mousedown == false then
				if script.Parent.reloading.Value == false then
					mousedown = true
					local plrMouse = player:GetMouse()
					gun.ShotFired:FireServer(plrMouse.Hit.Position)
					wait(0.9)
					mousedown = false
				end
			end
		end
	end)
end)
