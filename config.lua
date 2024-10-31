Config = {}

--## JOB CONFIGURATIONS ##--
Config.MaxTrafficLightsOut = 1 -- Maximum number of traffic lights that can be out at any given time
Config.MaxStreetLightsOut = 1 -- Maximum number of street lights that can be out at any given time
Config.TimeoutBeforeLightsClear = 30 -- Time in minutes before a call "clears" aka gets set back to working
Config.BreakTrafficLights = true
Config.BreakStreetLights = true

Config.QBJobs = {
	"DOT",
	"LTA",
	"LiterallyAnyJobHere",
}

Config.TrafficLights = {
	`prop_traffic_01a`,
	`prop_traffic_01b`,
	`prop_traffic_01d`,
	`prop_traffic_03a`,
	`prop_traffic_lightset_01`,
}

Config.StreetLights = {
	0x83838863, -- Small traffic light model
	0xB8A15DAB, -- Large traffic light model
}
