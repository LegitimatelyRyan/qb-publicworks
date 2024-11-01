Config = {}

--## JOB CONFIGURATIONS ##--
Config.MaxTrafficLightsOut = 1 -- Maximum number of traffic lights that can be out at any given time
Config.MaxStreetLightsOut = 1 -- Maximum number of street lights that can be out at any given time
Config.TimeoutBeforeLightsClear = 30 -- Time in minutes before a call "clears" aka gets set back to working
Config.BreakTrafficLights = true -- Set this to false if you dont want traffic lights to break
Config.BreakStreetLights = true -- Set this to false if you dont want street lights to break
Config.TimeBetweenBreaks = 5 -- Time in MINUTES before the loop attempts to break another light
Config.MinimumWorkersRequired = 1 -- Minimum required people to be on duty before the code starts breaking things

Config.DispatchSystem = "" -- PS-Dispatch, QB-Dispatch, Standalone

--## PS-Dispatch Configurations ##--
Config.DispatchCode = ""
Config.Sprite = 64
Config.Color = 2

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
	`prop_streetlight_07a`,
	`prop_streetlight_11a`,
	`prop_streetlight_05`,
	`prop_streetlight_11c`,
	`prop_streetlight_12b`,
	`prop_streetlight_06`,
	`prop_streetlight_03d`,
	`prop_streetlight_04`,
	`prop_streetlight_14a`,
	`prop_streetlight_16a`,
	`prop_streetlight_05_b`,
	`prop_streetlight_12a`,
	`prop_streetlight_03e`,
	`prop_streetlight_07b`,
	`prop_streetlight_15a`,
	`prop_streetlight_01b`,
	`prop_streetlight_08`,
	`prop_streetlight_01`,
	`prop_streetlight_11b`,
	`prop_streetlight_10`,
	`prop_streetlight_03b`,
	`prop_streetlight_03c`,
	`prop_streetlight_03`,
	`prop_streetlight_02`,
	`prop_streetlight_09`,
	`prop_snow_streetlight01`,
	`prop_snow_streetlight_09`,
	`prop_snow_streetlight_01_frag_`,
}
