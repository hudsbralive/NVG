local uis = game:GetService("UserInputService")
local event = game.ReplicatedStorage.PutNVGOn
local countdown = false
local equipped = false
local mainLight = game.Lighting.Brightness
local mainCC = game.Lighting.ColorCorrection.TintColor
local mainBlur = game.Lighting.Blur.Size
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local animator = humanoid:FindFirstChildOfClass("Animator")

local putOn = game.ReplicatedStorage.Animations:WaitForChild("Animation1")
local putOff = game.ReplicatedStorage.Animations:WaitForChild("Animation2")
local animTrack = animator:LoadAnimation(putOn)
local animTrack2 = animator:LoadAnimation(putOff)
animTrack.Priority = "Action"
animTrack2.Priority = "Action"

local function lerp(pointA, pointB, Alpha)
	return pointA + (pointB - pointA) * Alpha
end

uis.InputBegan:Connect(function(input)
	
	if input.KeyCode == Enum.KeyCode.N then
		if not equipped and not countdown then
			equipped = true
			countdown = true
			event:FireServer("equip")
			if animator then
				animTrack:Play()
				task.wait(2.1)
				game.Lighting.GlobalShadows = false
				game.Lighting.ExposureCompensation = 1
				for i = 0, 1, 0.1 do
					task.wait(0.05)
					game.Lighting.ColorCorrection.TintColor = mainCC:Lerp(Color3.fromRGB(180, 255, 167), lerp(0, 1, i))
					game.Lighting.Brightness = lerp(mainLight, 5, i)
					game.Lighting.Blur.Size = lerp(mainLight, 5, i)
				end
				
				for i, v in pairs(workspace:GetChildren()) do
					if v:IsA("BasePart") then
						v.CastShadow = false
					end
				end
				
				countdown = false
			end	
			
		elseif equipped and not countdown then
			countdown = true
			equipped = false
			event:FireServer("unequip")
			animTrack2:Play()		
			wait(2.0)
			game.Lighting.ExposureCompensation = 0
			game.Lighting.GlobalShadows = true
			
			for i = 0, 1, 0.1 do
				task.wait(0.05)
				game.Lighting.ColorCorrection.TintColor = Color3.fromRGB(180, 255, 167):Lerp(Color3.fromRGB(255, 255, 255), lerp(0, 1, i))
				game.Lighting.Brightness = lerp(game.Lighting.Brightness, mainLight, i)
				game.Lighting.Blur.Size = lerp(game.Lighting.Blur.Size, mainBlur, i)	
			end
			
			for i, v in pairs(workspace:GetChildren()) do
				if v:IsA("BasePart") then
					v.CastShadow = true
				end
			end
			countdown = false
		end
	end
end)

