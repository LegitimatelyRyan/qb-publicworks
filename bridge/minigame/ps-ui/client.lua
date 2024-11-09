--[[
    client.lua
    This script uses the selected minigame resource and plays the UI for the player to attempt to fix the fault.

    Authors: couldthisberyan & baited
    Resource: qb-publicworks
    Date: November 9th, 2024
]]

local function StartMinigameMaze()
	exports["ps-ui"]:Maze(function(success)
		if success then
			print("success")
		else
			print("fail")
		end
	end, 20)
	--[[
    1 argument: Time in seconds, increase for more time, decrease for less.
    ]]
end

local function StartMinigameCircle()
	exports["ps-ui"]:Circle(function(success)
		if success then
			print("success")
		else
			print("fail")
		end
	end, 5, 2000)
	--[[
    1 argument (Integer): Number of circles, increase for more circles, decrease for less.
    2 argument (Integer): Time in milliseconds, increase for more time, decrease for less.
    ]]
end

local function StartMinigameScrambler()
	exports["ps-ui"]:Scrambler(function(success)
		if success then
			print("success")
		else
			print("fail")
		end
	end, "numeric", 30, 1)
	--[[
    1 argument (String): alphabet, numeric, alphanumeric, greek, braille, runes. 
    2 argument (Integer): Time in seconds. 
    3 argument (Integer): Mirrored options: 0, 1, 2
    ]]
end

local function StartMinigameThermite()
	exports["ps-ui"]:Thermite(function(success)
		if success then
			print("success")
		else
			print("fail")
		end
	end, 15, 5, 3) -- Time in seconds, Grid Size (5-10), Incorrect Blocks)
	--[[
    1 argument (Integer): Time in seconds, increase for more time, decrease for less.
    2 argument (Integer): Grid Size (5-10)
    3 argument (Integer): Incorrect Blocks
    ]]
end

RegisterNetEvent("qb-publicworks:PlayMinigame:client", function(minigameType)
	if minigameType == "Maze" then
		StartMinigameMaze()
	elseif minigameType == "Circle" then
		StartMinigameCircle()
	elseif minigameType == "Scrambler" then
		StartMinigameScrambler()
	elseif minigameType == "Thermite" then
		StartMinigameThermite()
	end
end)
