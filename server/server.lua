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

--  Return a list of currently on duty players from the QB jobs
---@return table
local function GetPlayersOnDuty()
	local Players = {}
	for _, Job in pairs(Config.QBJobs) do
		for _, Player in pairs(QBCore.Functions.GetPlayersOnDuty(Job)) do
			Players[#Players + 1] = Player
		end
	end

	return Players
end

-- Function purely COUNTS the amount, this mostly is helpful in doing a singular check
local function GetCurrentNumberofPW()
	local DOT = 0
	for _, Job in pairs(Config.QBJobs) do
		DOT = DOT + #QBCore.Functions.GetPlayersOnDuty(Job)
	end

	return DOT
end

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

local function BreakTrafficLight()
	-- Selects a random traffic light from the server.
	local selectedLight = TrafficLights[math.random(#TrafficLights)]

	-- Utilizes recursion to then always select a unique light entity.
	if lib.table.contains(BrokenSLights, selectedLight) then
		BreakStreetLight()
	end

	-- Sets this traffic light to have no lighting.
	SetEntityTrafficlightOverride(selectedLight, 3)

	-- Adds the data to the table to allow it to be fixed in the future.
	BrokenTLights[#BrokenTLights + 1] = {
		["entity"] = selectedLight,
		["coords"] = GetEntityCoords(selectedLight),
	}

	-- TODO: Dispatch Bridge to send to the correct authorities.
end

local function BreakStreetLight()
	-- Selects a random street light from the server.
	local selectedLight = StreetLights[math.random(#StreetLights)]

	-- Utilizes recursion to then always select a unique light entity.
	if lib.table.contains(BrokenSLights, selectedLight) then
		BreakStreetLight()
	end

	-- Sets this street light to have no lighting.
	SetEntityTrafficlightOverride(selectedLight, 3)

	-- Adds the data to the table to allow it to be fixed in the future.
	BrokenSLights[#BrokenSLights + 1] = {
		["entity"] = selectedLight,
		["coords"] = GetEntityCoords(selectedLight),
	}

	-- TODO: Dispatch Bridge to send to the correct authorities.
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
		if GetCurrentNumberofPW() >= Config.MinimumWorkersRequires then
			-- If broken traffic lights are less than the config max then it will break a street light.
			if Config.MaxTrafficLightsOut < #BrokenTLights then
				BreakTrafficLight()
			end

			-- If broken street lights are less than the config max then it will break a street light.
			if Config.MaxStreetLightsOut < #BrokenSLights then
				BreakStreetLight()
			end
		end
		-- TODO: Check if someone of the Config.QBJobs is active otherwise just end this loop and only call it if someone is active.
		Wait(Config.TimeBetweenBreaks * 60000)
	end
end)
