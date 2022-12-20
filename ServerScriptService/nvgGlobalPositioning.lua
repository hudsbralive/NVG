local event = game.ReplicatedStorage.PutNVGOn
local debounce = false
local nvg = game.ServerStorage.NVG


event.OnServerEvent:Connect(function(player, method)
	print(method)
	local char = player.Character or player.CharacterAdded:Wait()
	if method == "equip" then
	
	if not debounce then
		debounce = true
	
	char = player.Character
	if char:WaitForChild("Torso"):FindFirstChild("Weld") then
		char:FindFirstChild("Torso"):FindFirstChild("Weld"):Destroy()
	end
	if not char:FindFirstChild("NVG") then
		nvg = game.ServerStorage.NVG:Clone()
		end
	nvg.Parent = char
	local humanoid = char:WaitForChild("Humanoid")
	local mortor6D = Instance.new("Motor6D")
	mortor6D.Parent = char:WaitForChild("Torso")
	mortor6D.Part0 = char:WaitForChild("Torso")
	mortor6D.Part1 = nvg.RootPart

			wait(1.9)
		mortor6D:Destroy()
		weld = Instance.new("Weld", char:WaitForChild("Torso"))
		weld.Part0 = char:WaitForChild("Torso")
		weld.Part1 = nvg.RootPart
			weld.C1 = CFrame.new(0, -1.8,0)
			debounce = false
			--event:FireClient(player)
		 end
	elseif method == "unequip" and not debounce then
		weld:Destroy()
		local mortor6D = Instance.new("Motor6D")
		mortor6D.Parent = char:WaitForChild("Torso")
		mortor6D.Part0 = char:WaitForChild("Torso")
		mortor6D.Part1 = nvg.RootPart
		wait(1.25)
		mortor6D:Destroy()
		nvg:Destroy()
	end
end)
