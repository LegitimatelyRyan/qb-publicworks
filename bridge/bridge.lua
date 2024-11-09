--[[
    bridge.lua
    This script checks for integrated resources based on Config settings, using them as bridges if available.

    Authors: couldthisberyan & baited
    Resource: qb-publicworks
    Date: November 1st, 2024
]]

local Bridge = {}

-- Function to merge data if resource state is valid
local function mergeIfResourceActive(resourceName)
	if GetResourceState(resourceName) == "started" or GetResourceState(resourceName) == "starting" then
		-- Gets data.
		local data = require(resourceName .. ".server")

		-- Checks if data exists and then merges the tables.
		if data then
			lib.table.merge(Bridge, data)
			return true
		end
	end
	print("Bridge: Resource " .. resourceName .. " is not active.")
	return false
end

-- Function to handle resources based on Config and fallback options
local function integrateResources(resourceList, resource)
	if resource == "auto" then
		-- If Config is set to auto, iterate through resourceList
		for _, resourceName in ipairs(resourceList) do
			if mergeIfResourceActive(resourceName) then
				break
			end
		end
	else
		-- If Config is set to a specific resource
		mergeIfResourceActive(resource)
	end
end

-- Tables of integrated resources
local dispatchResources = { "cd_dispatch", "ps-dispatch" }
local minigameResources = { "bl_ui", "ps-ui" }

-- Attempt to integrate Dispatch and Minigame resources based on Config
integrateResources(dispatchResources, Config.Dispatch)
integrateResources(minigameResources, Config.Minigame)

return Bridge
