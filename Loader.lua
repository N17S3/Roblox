local UserInputService = game:GetService("UserInputService")
local API = {}
API.DeviceCheck = function()
	if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/N17S3/Roblox/refs/heads/main/Mobile.lua"))();
	elseif UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/N17S3/Roblox/refs/heads/main/PC.lua"))();
	end
end

API.DeviceCheck()
