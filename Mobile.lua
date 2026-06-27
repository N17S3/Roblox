local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer
local Remotes = ReplicatedStorage.Modules.Net

local API = {}

getgenv = getgenv

local StaffList = {
	15830208, 137289169, 56835491, 2801665623, 2734254163,
	2310132044, 142749620, 1991618601, 1130683365, 28893687,
	34548520, 1247094293, 197269582, 1384340575, 297087250,
	324079363, 2406332172, 83224607, 137830537, 314034651,
	1385078842, 1156445873, 76968467,
}

do
	if game.PlaceId ~= 6461766546 then
		return Player:Kick("Incorrect Game | AHD Only...")
	end
end

do
	for i,player in Players:GetPlayers() do
		if table.find(StaffList, player.UserId) then
			Player:Kick("Staff Detected | Script Kick!")
		end
	end
	Players.PlayerAdded:Connect(function(player)
		if table.find(StaffList, Player.UserId) then
			Player:Kick("Staff Detected | Script Kick!")
		end
	end)
end

API.AscendedCheck = function()
	if Player and Player.PlayerGui then
		if Player.PlayerGui:WaitForChild("TopbarStandard").Holders.Left:GetChildren()[5].IconButton then
			local AscendedTextBox = Player.PlayerGui:WaitForChild("TopbarStandard").Holders.Left:GetChildren()[5]:WaitForChild("IconButton").Menu.IconSpot.Contents.IconLabelContainer.IconLabel
			if AscendedTextBox and AscendedTextBox.Visible and AscendedTextBox.Text == "Descend" then
				return true	
			else
				return false
			end	
		end
	end
end

repeat task.wait() until API.AscendedCheck() ~= nil

API.GetStat = function(Stat_Name)
	local ValidStats = {"Strength","Defense","Form","Level"}
	local Lvl = Player.PlayerGui.GameGui.MenuContainer.HUD.LevelBackground.TextLabel.Text:gsub(",","")
	local Str = Player.PlayerGui.GameGui.MenuContainer.StatsMenu.StatContainer.StrengthFrame.ValueLabel.Text:gsub(",","")
	local Def = Player.PlayerGui.GameGui.MenuContainer.StatsMenu.StatContainer.AgilityFrame.ValueLabel.Text:gsub(",","")
	local Form = Player.PlayerGui.GameGui.MenuContainer.StatsMenu.StatContainer.FormFrame.ValueLabel.Text:gsub(",","")
	if Stat_Name == ValidStats[1] then
		return tonumber(Str)
	elseif Stat_Name == ValidStats[2] then
		return tonumber(Def)
	elseif Stat_Name == ValidStats[3] then
		return tonumber(Form)
	elseif Stat_Name == ValidStats[4] then
		return tonumber(Lvl)
	else
		return error("Invalid Stat Called")
	end
end

local Temp = {
	AutoFarm = false,
	AutoSkillPoint = false,
	AutoSpin = false,
	AutoRebirth = false,

	SpinTarget = nil,
	Target = nil,
	MissingCount = 0,
	Skip = false,
	Statamount = 1000,
	
	Rebirth_Level = getgenv().Rebirth_Level or 1000000
}

local Earth_NPCS = {
	[1] = "Criminal",
	[2] = "Paradiser",
	[3] = "Hammerhead",
	[4] = "Crablante",
	[5] = "Mosquito",
	[6] = "Abnormal",
	[7] = "Werewolf",
	[8] = "Seafolk",
	[9] = "SeaKing",
	[10] = "Sonic",
	[11] = "VaccineMan",
	[12] = "MosquitoGirl",
	[13] = "Phoenix",
	[14] = "Kabuto",
	[15] = "Gouketsu",
	[16] = "Boros",
	[17] = "Charanko",
	[18] = "Psykos",
	[19] = "Bahiri",
	[20] = "Claire",
	[21] = "Fendstrum",
	[22] = "Voidlet",
	[23] = "Void",
	[24] = "VoidCrystal",
	[25] = "HumanMonster",
	[26] = "GoldenS",
	[27] = "PlatinumS",
	[28] = "AwakenedHumanMonster",
	[29] = "Rock",
	[30] = "Auroris",
	[31] = "Kayla",
	[32] = "CosmicHumanMonster",
	[33] = "Shinigami",
}

local Earth_Classes = {
	[1] = "Superhuman",
	[2] = "Esper",
	[3] = "Cyborg",
	[4] = "Alien",
	[5] = "Ninja",
	[6] = "Watchdog",
	[7] = "Dark Esper",
	[8] = "Metal Bat",
	[9] = "Angel",
	[10] = "Phoenix",
	[11] = "Demon",
	[12] = "Toxin",
	[13] = "Arcane Knight",
	[14] = "G.O.D.",
	[15] = "Ultrahuman",
	[16] = "Hero Hunter",
	[17] = "Blast",
	[18] = "Gravity",
	[19] = "Bing Bong",
	[20] = "Cosmic",
	[21] = "Reaper",
	[22] = "Limitless",
}

local Sky_NPCS = {
	[1] = "Skyroach",
	[2] = "SkyroachKing",
	[3] = "WindFairy",
	[4] = "SylphQueen",
	[5] = "DivineKnight",
	[6] = "DivineMagician",
	[7] = "DivineBrute",
	[8] = "DivineKnightCaptain",
	[9] = "ThunderCloud",
	[10] = "Raijin",
	[11] = "LunarCultist",
	[12] = "LunarCore",
	[13] = "SamuraiDisciple",
	[14] = "AtomicSamurai",
	[15] = "CursedStudent",
	[16] = "CursedKing",
	[17] = "InfinityMan",
	[18] = "CatBoy",
	[19] = "DemonSlime",
	[20] = "Sdjkfjsdgha",
	[21] = "EvilCarrot",
}

local Sky_Classes = {
	[1] = "Thor",
	[2] = "Jajanken",
	[3] = "Tanktop",
	[4] = "Frost Phoenix",
	[5] = "Tempest",
	[6] = "Azure",
	[7] = "Esoteric Knight",
	[8] = "Atomic",
	[9] = "Eclipse",
	[10] = "Malevolent",
	[11] = "Infinity",
	[12] = "Slime",
	[13] = "Psycho",
	[14] = "Rose",
}

local Quests = {}
local Classes = {}

if API.AscendedCheck() then
	for i,v in Sky_NPCS do
		if v then
			table.insert(Quests, v)
		end
	end

	for i,v in Sky_Classes do if v then
			table.insert(Classes, v)
		end
	end
else
	for i,v in Earth_NPCS do
		if v then
			table.insert(Quests, v)
		end
	end

	for i,v in Earth_Classes do if v then
			table.insert(Classes, v)
		end
	end
end

wait(.5)


API.GetQuest = function(NPC)
	if API.AscendedCheck() then
		if NPC then
			Remotes["RE/Quest"]:FireServer("GetAscendantQuest", NPC)
		else
			print(NPC)
			return error("No Valid Quest Input Given")
		end
	else
		if NPC then
			Remotes["RE/Quest"]:FireServer("GetQuest", NPC)
		else
			return error("No Valid Quest Input Given")
		end
	end
end

API.HasQuest = function()
	if Player:FindFirstChild("Quest") then
		return Player.Quest:WaitForChild("Target").Value
	else 
		return false
	end
end

API.GetCurrentClass = function()
	if Player.PlayerGui.GameGui.MenuContainer.ClassMenu.OuterContainer.ClassLabel then
		return Player.PlayerGui.GameGui.MenuContainer.ClassMenu.OuterContainer.ClassLabel.Text
	else
		return error("Error [1]")
	end
end

API.GetNpcIndex = function(NPC_NAME)
	if API.AscendedCheck() then
		for i,v in Sky_NPCS do
			if v == NPC_NAME then
				return i
			end
		end
	else
		for i,v in Earth_NPCS do
			if v == NPC_NAME then
				return i
			end
		end
	end
end

API.GetTarget = function(Target_Name)
	if Target_Name then
		local Targets = {}
		for i,v in workspace.Spawns:GetChildren() do
			if v and v:FindFirstChild(Target_Name) then
				local Target = v:FindFirstChild(Target_Name)
				if Target and Target:FindFirstChildOfClass("Humanoid") and Target:FindFirstChildOfClass("Humanoid").Health > 0 then
					table.insert(Targets, Target)
				end
			end
		end
		return Targets
	end
end

task.spawn(function()
	while task.wait(120) do
		VirtualUser:CaptureController()

		VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		task.wait(1)
		VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	end
end)

API.AntiFall = function(Character)
	if Temp.AntiFallConnection then
		Temp.AntiFallConnection:Disconnect()
	end

	Temp.AntiFallConnection = RunService.RenderStepped:Connect(function()
		if Character:FindFirstChild("HumanoidRootPart") and Character:FindFirstChild("HumanoidRootPart"):IsDescendantOf(workspace) then
			Character:FindFirstChild("HumanoidRootPart").CanCollide = false
			Character:FindFirstChild("UpperTorso").CanCollide = false
			Character:FindFirstChild("LowerTorso").CanCollide = false

			local vel = Character:FindFirstChild("HumanoidRootPart").Velocity
			if vel.Y then
				Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(vel.X, 0, vel.Z)
			end
		end
	end)
end

task.spawn(function()
	if Player.Character then
		API.AntiFall(Player.Character)
	end

	Player.CharacterAdded:Connect(function(Char)
		API.AntiFall(Char)
	end)
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/N17S3/Main/refs/heads/main/Mobile_UI.lua"))()
local Window = Library:Window("AHD | N17S3")
local Tab1 = Window:Tab("Farm")
local Tab2 = Window:Tab("Spin")
local Tab3 = Window:Tab("Rebirth")

Tab1:Toggle("AutoFarm", function(Value)
	Temp.AutoFarm = not Temp.AutoFarm

	while Temp.AutoFarm do
		if not Temp.AutoFarm then break end
		if not API.HasQuest() or Temp.Skip then
			local QuestNum = API.GetNpcIndex(Temp.Target)

			if Temp.Skip and QuestNum then
				local r = math.random(1, 3)

				QuestNum += (r == 1 and -2) or (r == 2 and -1) or 1
			end
			API.GetQuest(QuestNum)
			wait(1)
			Temp.Skip = false

		else
			local Targets = API.GetTarget(Player.Quest:WaitForChild("Target").Value)

			if not Targets or #Targets == 0 then
				Temp.MissingCount += 1

				if Temp.MissingCount >= 15 then
					Temp.Skip = true
					Temp.MissingCount = 0
				end
			else
				Temp.MissingCount = 0
				local Target = Targets[math.random(1, #Targets)]

				if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
					Player.Character:PivotTo(Target:GetPivot() * CFrame.new(0, -12, 0))

					for i = 1, 10 do
						Remotes["RE/CombatEvent"]:FireServer("PunchHit", Targets)
					end
				end
			end
		end

		task.wait()
	end
end)

Tab1:Dropdown("Select NPC", Quests, function(Value)
	Temp.Target = Value
end)

Tab1:Button("Force Selected Quest", function()
	API.GetQuest(API.GetNpcIndex(Temp.Target))
end)

Tab1:Toggle("Auto Spend Skill Points", function(Value)
	Temp.AutoSkillPoint = not Temp.AutoSkillPoint

	while Temp.AutoSkillPoint do
		if not Temp.AutoSkillPoint then break end
		if API.AscendedCheck() then
			local PlayerStats = {"Authority","Presence","Grace"}

			for i, Stat in PlayerStats do
				local Str = API.GetStat("Strength")
				local Def = API.GetStat("Defense")
				local Form = API.GetStat("Form")
				
				local Fallback = true

				if Stat == "Authority" then
					if Str < 20000 then
						Remotes["RE/UpgradeAscendantStat"]:FireServer(Stat, 20000 - Str)
						Fallback = false
					elseif Str < 1000000 and Def >= 400000 and Form >= 200000 then
						Remotes["RE/UpgradeAscendantStat"]:FireServer(Stat, 1000000 - Str)
						Fallback = false
					end
					
				elseif Stat == "Presence" then
					if Str >= 20000 and Def < 400000 then
						Remotes["RE/UpgradeAscendantStat"]:FireServer(Stat, 400000 - Def)
						Fallback = false
					elseif Str >= 1000000 and Def < 1000000 and Form >= 200000 then
						Remotes["RE/UpgradeAscendantStat"]:FireServer(Stat, 1000000 - Def)
						Fallback = false
					end
					
				elseif Stat == "Grace" then
					if Str >= 20000 and Def >= 400000 and Form < 200000 then
						Remotes["RE/UpgradeAscendantStat"]:FireServer(Stat, 200000 - Form)
						Fallback = false
					end
				end
				
				if Fallback then
					Remotes["RE/UpgradeAscendantStat"]:FireServer(Stat, Temp.Statamount)
				end
			end
		else
			local PlayerStats = {"Health","Form"}

			for i, Stat in PlayerStats do
				Remotes["RE/UpgradeStat"]:FireServer(Stat, Temp.Statamount)
			end
		end
		task.wait(1)
	end
end)

Tab1:Textbox("Amount of StatPoints", false, function(Value)
	Temp.Statamount = tonumber(Value)
end)

Tab2:Toggle("AutoSpin", function()
	Temp.AutoSpin = not Temp.AutoSpin

	while Temp.AutoSpin do
		if not Temp.AutoSpin then break end
		local CurrentClass = API.GetCurrentClass()
		if Temp.SpinTarget and CurrentClass and CurrentClass ~= Temp.SpinTarget then
			if API.AscendedCheck() then
				Remotes["RF/SpinClass"]:InvokeServer("Ascendant")
			else
				Remotes["RF/SpinClass"]:InvokeServer()
			end
		end
		task.wait()
	end
end)

Tab2:Dropdown("Select Class", Classes, function(Value)
	Temp.SpinTarget = Value
end)

Tab3:Toggle("AutoRebirth", function()
	Temp.AutoRebirth = not Temp.AutoRebirth
	
	while Temp.AutoRebirth do
		if not Temp.AutoRebirth then break end
		local CurrentLevel = API.GetStat("Level")
		if CurrentLevel >= Temp.Rebirth_Level then
			for i = 1, 100 do
				Remotes["RE/AscendantRebirth"]:FireServer()
			end
		end
		task.wait()
	end
end)

Tab3:Textbox("Rebirth level requirement",false, function(Value)
	Temp.Rebirth_Level = tonumber(Value)
end)
