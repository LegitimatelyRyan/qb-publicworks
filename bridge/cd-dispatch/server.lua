local Bridge = {}

function Bridge.SendEmergencyAlert()
	TriggerServerEvent("cd_dispatch:AddNotification", {
		job_table = { "police" },
		coords = data.coords,
		title = "10-15 - Store Robbery",
		message = "A " .. data.sex .. " robbing a store at " .. data.street,
		flash = 0,
		unique_id = data.unique_id,
		sound = 1,
		blip = {
			sprite = 431,
			scale = 1.2,
			colour = 3,
			flashes = false,
			text = "911 - Store Robbery",
			time = 5,
			radius = 0,
		},
	})
end

return Bridge
