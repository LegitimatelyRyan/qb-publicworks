--[[
    bridge.lua
    This script checks for integrated resources based on Config settings, using them as bridges if available.

    Authors: couldthisberyan & baited
    Resource: qb-publicworks
    Date: November 1st, 2024
]]

local Bridge = {}

-- Function to merge data if resource state is valid
---@param resourceName string
---@param type number
---@return boolean
local function mergeIfResourceActive(resourceName, type)
	if GetResourceState(resourceName) == "started" or GetResourceState(resourceName) == "starting" then
		-- Gets data.
		local data = require("bridge." .. (type == 1) and "dispatch" or "minigame" .. resourceName .. ".server")

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
---@param resourceList table
---@param resource string
---@param type number
local function integrateResources(resourceList, resource, type)
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
integrateResources(dispatchResources, Config.Dispatch, 1)
integrateResources(minigameResources, Config.Minigame, 2)

return Bridge
