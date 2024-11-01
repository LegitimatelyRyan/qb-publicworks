local Bridge = {}

function Bridge.SendEmergencyAlert(alert, coords)
	TriggerClientEvent("cd_dispatch:AddNotification", -1, {
		job_table = Config.QBJobs,
		coords = coords,
		title = "311",
		message = alert,
		flash = 0,
		unique_id = tostring(math.random(0000000, 9999999)), -- Pulled from their documentation, weird way of doing it but okay :thumbsup:
		sound = 1,
		blip = {
			sprite = Config.Blip.Sprite,
			scale = Config.Blip.Scale,
			colour = Config.Blip.Colour,
			flashes = false,
			text = "311 - " .. alert,
			time = Config.Blip.Duration,
			radius = 0,
		},
	})
end

return Bridge
