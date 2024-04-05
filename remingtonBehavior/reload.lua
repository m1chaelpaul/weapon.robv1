local gun = script.Parent
local ammo = gun.ammo
local ammoleft = gun.ammoleft
local players = game:GetService("Players")


gun.Activated:Connect(function()
	if ammo.Value == 0 and ammoleft.Value > 0 then
		if script.Parent.reloading.Value == false then
			script.Parent.reloading.Value = true
			ammo.Value = ammo.Value - 1
			local shellEnter = script.Parent.barrelEnter
			local doReload = game:GetService("ReplicatedStorage").doReload
			local plrName = script.Parent.Parent
			local getplr = players:GetPlayerFromCharacter(plrName)
			game:GetService("ReplicatedStorage").doReload:FireClient(getplr)
			wait(1)
			shellEnter:Play()
			ammo.Value = ammo.Value + 1
			ammoleft.Value = ammoleft.Value - 1
			wait(0.8)
			shellEnter:Play()
			ammo.Value = ammo.Value +1
			ammoleft.Value = ammoleft.Value - 1
			wait(0.8)
			shellEnter:Play()
			ammo.Value = ammo.Value +1
			ammoleft.Value = ammoleft.Value - 1
			wait(0.8)
			shellEnter:Play()
			ammo.Value = ammo.Value +1
			ammoleft.Value = ammoleft.Value - 1
			wait(0.8)
			shellEnter:Play()
			ammo.Value = ammo.Value +1
			ammoleft.Value = ammoleft.Value - 1
			wait(1.4)
			script.Parent.pump:Play()
			ammo.Value = ammo.Value +1
			script.Parent.reloading.Value = false
		end
	end
end)
