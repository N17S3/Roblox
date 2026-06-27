local UserInputService = game:GetService("UserInputService")
local API {}
API.DeviceCheck = function()
	if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
		print("Mobile")
	else
		print("PC")
	end
end
