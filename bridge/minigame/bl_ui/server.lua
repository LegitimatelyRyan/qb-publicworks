--[[
    server.lua
    This script uses the selected minigame resource and sends the minigame type to the client for it to be played.

    Authors: couldthisberyan & baited
    Resource: qb-publicworks
    Date: November 1st, 2024
]]

local Bridge = {}

-- Randomizes the minigame type to be played.
local function Bridge.ChooseMinigame()
	-- Array of minigame types
	local minigameTypes = { "CircleProgress", "Untangle", "NumberSlide", "RapidLines" }

	-- Selects a random minigame type and returns it for it to be used to repair the fault.
	local selectedMinigame = minigameTypes[math.random(1, #minigameTypes)]

	return selectedMinigame
end

-- Sends the minigame type to the client for it to be played.
local function Bridge.PlayMinigame()
	-- Gets random minigame type.
	local minigameType = Bridge.ChooseMinigame()

	-- Sends the minigame type to the client for it to be played.
	TriggerClientEvent("qb-publicworks:PlayMinigame:client", source, minigameType)
end

return Bridge
