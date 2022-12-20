local plr = game.Players.LocalPlayer
local neckC0 = CFrame.new(0, 0.8, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
local waistC0 = CFrame.new(0, 0.2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);

local function onUpdate(dt)
	if plr.Character ~= nil then
		local camera = workspace.CurrentCamera;
		local body = plr.Character.HumanoidRootPart
		if plr.Character.Head.Neck ~= nil then --neck joint is not broken
			if plr.Character.UpperTorso:FindFirstChild("Waist") ~= nil then
				local neck = plr.Character.Head.Neck;
				local waist = plr.Character.UpperTorso.Waist;
				local theta = math.asin(camera.CFrame.LookVector.y)
				local camera_angle = math.atan2(camera.CFrame.LookVector.X, camera.CFrame.LookVector.Z)
				local body_angle = math.atan2(body.CFrame.LookVector.X, body.CFrame.LookVector.Z)
				local theta2 = (camera_angle-body_angle)%(2*math.pi)

				if theta2 > math.pi/2 and theta2 < math.pi*1.5 then
					theta2 = math.pi-theta2
				end
				neck.C0 = neckC0 * CFrame.Angles(theta*0.5, -theta2, 0);
				CFrame.new()
				waist.C0 = waistC0 * CFrame.Angles(theta*0.5, 0, 0);
			end
		end
	end
end
game:GetService("RunService").RenderStepped:Connect(onUpdate);
