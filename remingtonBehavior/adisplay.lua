local gun = script.Parent
local player = game.Players.LocalPlayer
local playergui = player:WaitForChild("PlayerGui")
local ammodisplay = playergui:WaitForChild("AmmoDisplay"):WaitForChild("Frame").AmmoText

while wait() do
	ammodisplay.Text = gun:WaitForChild("ammo").Value
	ammodisplay.Parent.totally.Text = "/" .. gun:WaitForChild("ammoleft").Value
	wait(.1)
end
