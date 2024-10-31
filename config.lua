Config = {}

--## JOB CONFIGURATIONS ##--
Config.MaxTrafficLightsOut = 1 -- Maximum number of traffic lights that can be out at any given time
Config.TimeoutBeforeLightsClear = 30 -- Time in minutes before a call "clears" aka gets set back to working
Config.BreakTrafficLights = true
Config.BreakStreetLights = true

Config.QBJobs = {
	"DOT",
	"LTA",
	"LiterallyAnyJobHere",
}

Config.TrafficLights = {
	0x83838863, -- Small traffic light model
	0xB8A15DAB, -- Large traffic light model
}

Config.StreetLights = {
	0x83838863, -- Small traffic light model
	0xB8A15DAB, -- Large traffic light model
}
