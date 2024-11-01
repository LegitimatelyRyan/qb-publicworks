local Bridge = {}

function Bridge.SendEmergencyAlert(alert)
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
