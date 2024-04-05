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
	
	for i, v in pairs(game.Workspace.GuardPatrols.GuardPatrol10:GetChildren()) do
		walkTo(game.Workspace.GuardPatrols.GuardPatrol10:FindFirstChild(i))
		if game.Workspace.GuardPatrols.GuardPatrol10:FindFirstChild(i):FindFirstChild("stoppingPoint") then
			wait(math.random(20, 30))
		end
	end

end

while wait(2) do
	doPatrol()
end
