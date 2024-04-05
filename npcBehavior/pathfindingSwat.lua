local npc = script.Parent
local hum = npc:WaitForChild("Humanoid")

local pfs = game:GetService("PathfindingService")

local function getPath(destination)

	local pathParams = {
		["AgentHeight"] = 5,
		["AgentRadius"] = 2,
		["AgentCanJump"] = false
	}

	local path = pfs:CreatePath(pathParams)

	path:ComputeAsync(npc.HumanoidRootPart.Position, destination.Position)

	return path

end

local function walkTo(destination)
	local path = getPath(destination)

	for index, waypoint in pairs(path:GetWaypoints()) do
		hum:MoveTo(waypoint.Position)
		hum.MoveToFinished:Wait()
	end

end

local function doPatrol()
	
	for i, v in pairs(game.Workspace.SWATLaptopPFS:GetChildren()) do
		walkTo(game.Workspace.SWATLaptopPFS:FindFirstChild(i))
		if game.Workspace.SWATLaptopPFS:FindFirstChild(i):FindFirstChild("stoppingPoint") then
			wait(999999999999999999999)
		end
	end

end

while wait(2) do
	doPatrol()
end
