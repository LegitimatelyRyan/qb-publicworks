--[[
	server.lua
	Manages serversided events & coordination for qb-publicworks.

	couldthisberyan & baited
	qb-publicworks
	November 1st, 2024
]]

local TrafficLights = {}
local StreetLights = {}
local BrokenTLights = {}
local BrokenSLights = {}
local QBCore = exports["qb-core"]:GetCoreObject()

-- Helper function to check if an object is a traffic light
---@param entity number
---@return boolean
local function IsTrafficLight(entity)
	-- Get the hash model of the entity
	local model = entity

	-- List of known traffic light model hashes
	local trafficLightModels = Config.TrafficLights

	-- Check if the entity's model is a traffic light
	if lib.table.contains(trafficLightModels, model) then
		return true
	end
	return false
end

-- Return a list of currently on duty players from the QB jobs
---@return table
local function GetPlayersOnDuty()
	local players = {}
	for _, value in pairs(QBCore.Players) do
		if value.PlayerData.job and Config.QBJobs[value.PlayerData.job] then
			players[#players + 1] = value.PlayerData.source
		end
	end

	return players
end

-- Checks to see if the current player is on an authorized job
---@param source number
local function IsPlayerAuthorized(source)
	local Player = QBCore.Functions.GetPlayer(source)
	local PlayerJob = Player.PlayerData.job
	if Config.QBJobs[PlayerJob] then
		return true
	end
	return false
end

-- Helper function to check if an object is a street light
---@param entity number
---@return boolean
local function IsStreetLight(entity)
	-- Get the hash model of the entity
	local model = GetEntityModel(entity)

	-- List of known traffic light model hashes
	local streetLightModels = Config.StreetLights

	-- Check if the entity's model is a traffic light
	if lib.table.contains(streetLightModels, model) then
		return true
	end
	return false
end

-- Helper function to set the traffic light override, I.E. breaking it.
local function BreakTrafficLight()
	-- Selects a random traffic light from the server.
	local selectedLight = TrafficLights[math.random(#TrafficLights)]

	-- Utilizes recursion to always select a unique light entity.
	if lib.table.contains(BrokenTLights, selectedLight) then
		BreakTrafficLight()
	end

	-- Sets this traffic light to have no lighting.
	SetEntityTrafficlightOverride(selectedLight, 3)

	-- Adds the data to the table to allow it to be fixed in the future.
	BrokenTLights[#BrokenTLights + 1] = {
		["entity"] = selectedLight,
		["coords"] = GetEntityCoords(selectedLight),
	}

	-- Sends the emergency alert to the selected jobs in the config.
	Bridge.SendEmergencyAlert("Damaged Traffic Light", GetEntityCoords(selectedLight))
end

-- Helper function to add particle effects for all users to indicate it being broken. This is a visual representation of the broken light due to FiveM limitations.
local function BreakStreetLight()
	-- Selects a random street light from the server.
	local selectedLight = StreetLights[math.random(#StreetLights)]

	-- Utilizes recursion to always select a unique light entity.
	if lib.table.contains(BrokenSLights, selectedLight) then
		BreakStreetLight()
	end

	-- Adds the data to the table to allow it to be fixed in the future.
	BrokenSLights[#BrokenSLights + 1] = {
		["entity"] = selectedLight,
		["coords"] = GetEntityCoords(selectedLight),
	}

	-- Sends the emergency alert to the selected jobs in the config.
	Bridge.SendEmergencyAlert("Damaged Street Light", GetEntityCoords(selectedLight))
end

-- Loops through all objects to check models.
Citizen.CreateThread(function()
	-- When the server starts, it will run this loop first.
	for _, object in pairs(GetAllObjects()) do
		local hash = GetEntityModel(object)

		-- Check if the object is a traffic light, if so adds it to a table which will be iterated through later.
		if IsTrafficLight(hash) then
			TrafficLights[#TrafficLights + 1] = hash
		end

		-- Checks if the object is a street light, if so adds it to a table which will be iterated through later.
		if IsStreetLight(hash) then
			StreetLights[#StreetLights + 1] = hash
		end
	end

	-- Once the objects have been retrieved it will then start this timed loop.
	while true do
		if #GetPlayersOnDuty() >= Config.MinimumWorkersRequires then
			-- If broken traffic lights are less than the config max then it will break a street light.
			if Config.MaxTrafficLightsOut < #BrokenTLights then
				BreakTrafficLight()
			end

			-- If broken street lights are less than the config max then it will break a street light.
			if Config.MaxStreetLightsOut < #BrokenSLights then
				BreakStreetLight()
			end
		end
		Wait(Config.TimeBetweenBreaks * 60000) -- Converts it to minutes.
	end
end)
