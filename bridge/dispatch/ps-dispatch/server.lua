--[[
    server.lua
    This script uses the selected dispatch resource and sends the emergency call to the config jobs.

    Authors: couldthisberyan & baited
    Resource: qb-publicworks
    Date: November 9th, 2024
]]

local Bridge = {}

---@param alert string
---@param coords table
function Bridge.SendEmergencyAlert(alert, coords)
	TriggerServerEvent("ps-dispatch:server:notify", {
		message = alert,
		codeName = "311",
		coords = coords,
		jobs = Config.QBJobs,
		alert = {
			sprite = Config.Blip.Sprite,
			color = Config.Blip.Colour,
			scale = Config.Blip.Scale,
		},
	})
end

return Bridge
