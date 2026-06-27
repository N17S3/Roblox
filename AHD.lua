local UserInputService = game:GetService("UserInputService")
local API {}
API.DeviceCheck = function()
	if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/N17S3/Roblox/refs/heads/main/Mobile.lua"))();
	else
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/N17S3/Roblox/refs/heads/main/PC_lua"))();
	end
end

API.DeviceCheck()
