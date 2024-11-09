--[[
	server.lua
	Manages client-sided events & coordination for qb-publicworks.

	couldthisberyan & baited
	qb-publicworks
	November 9th, 2024
]]

RegisterNetEvent("qb-publicworks:PlayMinigame:client", function(minigameType)
	-- ps-ui
	if minigameType == "Maze" then
		StartMinigameMaze()
	elseif minigameType == "Circle" then
		StartMinigameCircle()
	elseif minigameType == "Scrambler" then
		StartMinigameScrambler()
	elseif minigameType == "Thermite" then
		StartMinigameThermite()
	end

	-- bl_ui
	if minigameType == "CircleProgress" then
		StartMinigameCircleProgress()
	elseif minigameType == "Untangle" then
		StartMinigameUntangle()
	elseif minigameType == "NumberSlide" then
		StartMinigameNumberSlide()
	elseif minigameType == "RapidLines" then
		StartMinigameRapidLines()
	end

	--TODO: Better management of sending player to the correct function, this way is just inefficient but works, so hey.
end)
