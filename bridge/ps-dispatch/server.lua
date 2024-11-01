local Bridge = {}

function Bridge.SendEmergencyAlert(alert)
	TriggerClientEvent("ps-dispatch:client:sendEmergencyMsg", source, alert, "311", true)
end

return Bridge
