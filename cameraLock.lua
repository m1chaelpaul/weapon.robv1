local INPUT_SENSITIVITY = 5
local CAMERA_DAMPENING = 18
local CAMERA_OFFESET = CFrame.new(2.86, 1.99, 5.5)

local PITCH_RANGE = {-45, 50}

local VALID_INPUT_TYPES = {[Enum.UserInputType.Touch] = true, [Enum.UserInputType.MouseMovement] = true}

local Players = game:GetService("UserInputService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = game.Players.LocalPlayer
local CurrentCamera = game.Workspace.CurrentCamera

local isEnabled = false

local totalYaw = 0
local totalPitch = 0

local lastCameraCf = nil

local StrafingController = {}

function StrafingController:SetEnabled(status)
	isEnabled = status

	if status == true then
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
	else
		if LocalPlayer.Character and LocalPlayer.Character.Humanoid then
			LocalPlayer.Character.Humanoid.AutoRotate = true -- Change it back to the default
		end
		CurrentCamera.CameraType = Enum.CameraType.Custom
	end 

	return
end

function StrafingController:Init()
	self:SetEnabled(false)

	return
end

local function canProceed()
	if not LocalPlayer.Character then return false end
	if not isEnabled then return false end

	return true
end

local function inputChanged(inputObject ,gameProcessed)
	if gameProcessed then return end
	if not VALID_INPUT_TYPES[inputObject.UserInputType] then return end
	if not canProceed() then return end

	local delta = inputObject.Delta 

	totalPitch = math.clamp(totalPitch + delta.Y/INPUT_SENSITIVITY, PITCH_RANGE[1], PITCH_RANGE[2])
	totalYaw = totalYaw + delta.X/INPUT_SENSITIVITY

	return
end

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
raycastParams.IgnoreWater = true

local function updateCamera(dt)
	local rootCf = LocalPlayer.Character.HumanoidRootPart.CFrame
	local destiredCf = rootCf * CFrame.Angles(math.rad(-totalPitch), 0, 0) * CAMERA_OFFESET
	local actualCf = (lastCameraCf or destiredCf):Lerp(destiredCf, dt * CAMERA_DAMPENING)

	raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}

	local result = game.Workspace:Raycast(rootCf.Position, destiredCf.Position - rootCf.Position, raycastParams)

	if result then 
		actualCf = actualCf - (actualCf.Position - (result.Position + result.Normal * 0.4))
	end

	CurrentCamera.CFrame = actualCf
	lastCameraCf = actualCf

	return
end

local function updateCharacter(dt)
	local rootPart = LocalPlayer.Character.HumanoidRootPart
	local desiriedCf = CFrame.new(rootPart.Position) * CFrame.Angles(0, math.rad(-totalYaw), 0)

	rootPart.CFrame = desiriedCf
	LocalPlayer.Character.Humanoid.AutoRotate = true

	return
end

local function update(dt)
	if not canProceed() then return end
	if not LocalPlayer.Character and LocalPlayer.Character.Humanoid then return end

	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	updateCharacter(dt)
	updateCamera(dt)

	return
end

UserInputService.InputChanged:Connect(inputChanged)

RunService.RenderStepped:Connect(update)

return StrafingController
