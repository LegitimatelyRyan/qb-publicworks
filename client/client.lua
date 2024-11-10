--[[
	server.lua
	Manages client-sided events & coordination for qb-publicworks.

	couldthisberyan & baited
	qb-publicworks
	November 9th, 2024
]]

-- Event to play the minigame for the player to fix the fault.
RegisterNetEvent("qb-publicworks:PlayMinigame:client", function(minigameType)
	-- Define lookup tables for minigame functions
	local psMinigames = {
		Maze = StartMinigameMaze,
		Circle = StartMinigameCircle,
		Scrambler = StartMinigameScrambler,
		Thermite = StartMinigameThermite,
	}

	local blMinigames = {
		CircleProgress = StartMinigameCircleProgress,
		Untangle = StartMinigameUntangle,
		NumberSlide = StartMinigameNumberSlide,
		RapidLines = StartMinigameRapidLines,
	}

	-- Check and execute the appropriate function based on minigameType
	if psMinigames[minigameType] then
		psMinigames[minigameType]()
	elseif blMinigames[minigameType] then
		blMinigames[minigameType]()
	else
		print("Error: Minigame type not found!")
	end
end)
