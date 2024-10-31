local TrafficLights = {}
local StreetLights = {}
local BrokenTLights = {}
local BrokenSLights = {}
local QBCore = exports["qb-core"]:GetCoreObject()

-- Helper function to check if an object is a traffic light
function IsTrafficLight(entity)
	-- Get the hash model of the entity
	local model = entity

	-- List of known traffic light model hashes
	local trafficLightModels = Config.TrafficLights

	-- Check if the entity's model is a traffic light
	for _, trafficLightHash in ipairs(trafficLightModels) do
		if model == trafficLightHash then
			return true
		end
	end

	return false
end

function IsStreetLight(entity)
	-- Get the hash model of the entity
	local model = GetEntityModel(entity)

	-- List of known traffic light model hashes
	local streetLightModels = Config.StreetLights

	-- Check if the entity's model is a traffic light
	for _, trafficLightHash in ipairs(trafficLightModels) do
		if model == trafficLightHash then
			return true
		end
	end

	return false
end

-- Enumerator function to loop through all objects
function EnumerateObjects()
	return coroutine.wrap(function()
		local handle, object = FindFirstObject()
		if not handle or handle == -1 then
			return
		end

		local success
		repeat
			coroutine.yield(object)
			success, object = FindNextObject(handle)
		until not success

		EndFindObject(handle)
	end)
end

for entity in EnumerateObjects() do
	if IsTrafficLight(entity) then
		table.insert(TrafficLights, entity)
	elseif IsStreetLight(entity) then
		table.insert(StreetLights, entity)
	end
end

function BreakTrafficLight(entity)
	if
		IsTrafficLight(entity)
		and Config.BreakTrafficLights
		and #BrokenTLights < Config.MaxTrafficLightsOut
		and not BrokenTLights[entity]
	then
		print("We've chosen a traffic light at " .. GetEntityCoords(entity))
		table.insert(BrokenTLights, entity) -- add the entity to our registry
		-- tell the client the lights out
		-- do dispatching?!?!?!
	end
end
