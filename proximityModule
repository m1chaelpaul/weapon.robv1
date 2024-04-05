-- This module was developed my Michael (riddleminecart) to make custom proximity prompts
local ProximityPrompts = {}

local PromptGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("Prompt")

function ProximityPrompts:Create(Prompt:ProximityPrompt)
	
	local PromptGui = PromptGui:Clone()
	PromptGui.Parent = script
	PromptGui.Adornee = Prompt.Parent
	PromptGui.Enabled = true
	
	PromptGui.Frame.TextFrame:WaitForChild("ActionText").Text = Prompt.ActionText
	PromptGui.Frame.InputFrame.Frame.ButtonText.Text = Prompt.KeyboardKeyCode.Name
	PromptGui.Frame.TextFrame:WaitForChild("ActionText").Text = Prompt.ActionText
	
	local uis = game:GetService("UserInputService")
	
	if uis.TouchEnabled then
		PromptGui.Frame.InputFrame.Frame.ClickDetector.Visible = true
		PromptGui.Frame.InputFrame.Frame.ButtonText.Visible = false
	end
	
	if uis.GamepadEnabled then
		PromptGui.Frame.InputFrame.Frame.ButtonText.Text = Prompt.GamepadKeyCode.Name
	end
	
	if Prompt.HoldDuration > 0 then
		PromptGui.Frame.InputFrame.Frame.Bar.Visible = true
	end
	
	local inputtype = uis.InputBegan
	
	if inputtype == Enum.ProximityPromptInputType.Touch or Prompt.ClickablePrompt then
		local button = PromptGui.TextButton
		
		local buttondown = false
		
		button.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) and input.UserInputState ~= Enum.UserInputState.Change then
				Prompt:InputHoldBegin()
				buttondown = true
			end
		end)
		button.InputEnded:Connect(function(input)
			if buttondown then
				buttondown = false
				Prompt:InputHoldEnd()
			end
		end)
	end
	
	local holding, duration, holdStart
	
	holding = false
	duration = 0
	holdStart = 0
	
	local highlight = Instance.new("Highlight")
	
	Prompt.PromptShown:Connect(function()

		highlight.DepthMode = Enum.HighlightDepthMode.Occluded
		highlight.FillTransparency = 1
		highlight.OutlineColor = Color3.new(1, 1, 1)
		
		highlight.Enabled = true
		
		if Prompt.Parent.Parent:FindFirstChild("Humanoid") then
			highlight.Parent = Prompt.Parent.Parent
		else
			highlight.Parent = Prompt.Parent
		end
		
	end)
	
	Prompt.PromptHidden:Connect(function()
		
		highlight.Enabled = false
		highlight:Destroy()
		
	end)
	
	Prompt.PromptButtonHoldBegan:Connect(function()
		holding = true
		holdStart = tick()
		duration = Prompt.HoldDuration
	end)
	
	Prompt.PromptButtonHoldEnded:Connect(function()
		holding = false
	end)
	
	local bar = PromptGui.Frame.InputFrame.Frame.Bar.Progress
	local before = PromptGui.Frame.InputFrame.Frame.Bar
	
	local function update()
		if duration > 0 then
			before.Visible = holding and tick() - holdStart < duration
		else
			before.Visible = false and tick() - holdStart < duration
		end
		bar.Size = UDim2.new((tick() - holdStart)/duration,0,1,0)
	end
	
	game:GetService("RunService").RenderStepped:Connect(update)
	
	return function()
		PromptGui:Destroy()
	end
end

local player = game.Players.LocalPlayer

game:GetService("ProximityPromptService").PromptShown:Connect(function(prompt, inputtype)
	
	if prompt.Style ~= Enum.ProximityPromptStyle.Custom then
		return
	end
	
	local Cleanup = ProximityPrompts:Create(prompt)
	
	prompt.PromptHidden:Wait()
	
	Cleanup()
	
end)
