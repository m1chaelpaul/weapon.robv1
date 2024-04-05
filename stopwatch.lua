while true do 
	wait()
	local txtlbl = game.Players.LocalPlayer.PlayerGui:WaitForChild("lostimer").Frame.TextLabel
	local seconds = math.floor(game.Workspace.DistributedGameTime)
	local minutes = math.floor(game.Workspace.DistributedGameTime / 60)
	local hours = math.floor(game.Workspace.DistributedGameTime / 60 / 60)
	local seconds = seconds - (minutes * 60)
	local minutes = minutes - (hours * 60)
	if hours < 1 then
		if minutes < 1 then
			local seconds2 = string.format("%0.2i", seconds)
			txtlbl.Text = "00:"..seconds2
		else
			local minutes2 = string.format("%0.2i", minutes)
			local seconds2 = string.format("%0.2i", seconds)
			txtlbl.Text = minutes2..":" ..seconds2
		end
	else 
		txtlbl.Text = hours..":"..minutes.. ":"..seconds
	end
end
