--[[
    client.lua
    This script uses the selected minigame resource and plays the UI for the player to attempt to fix the fault.

    Authors: couldthisberyan & baited
    Resource: qb-publicworks
    Date: November 9th, 2024
]]

function StartMinigameCircleProgress()
	local success = exports["bl_ui"]:CircleProgress(5, 70)
	--[[
    1st argument (Integer): Iterations, also known as number of circles. Increase for more circles, decrease for less.
    2nd argument (Integer): Difficulty, between 1 and 100, this affects the speed of the circle. Increase for a harder difficulty, decrease for an easier difficulty.
    ]]

	if success then
		print("success")
	else
		print("fail")
	end
end

function StartMinigameUntangle()
	local success = exports["bl_ui"]:Untangle(3, {
		["numberOfNodes"] = 8, -- Number of nodes, increase for more nodes, decrease for less. (This is the number of points you have to untangle.)
		["duration"] = 8000, -- Duration in milliseconds, increase for more time, decrease for less.
	})
	--[[
    1st argument (Integer): Iterations, this is the number of times you'll have to untangle the nodes. Increase for more iterations, decrease for less.
    2nd argument (Array): Explained in line with index.
    ]]

	if success then
		print("success")
	else
		print("fail")
	end
end

function StartMinigameNumberSlide()
	local success = exports["bl_ui"]:NumberSlide(3, 70, 5)
	--[[
    1st argument (Integer): Iterations, this is the number of times you'll have to do this minigame. Increase for more iterations, decrease for less.
    2nd argument (Integer): Difficulty, between 1 and 100, this affects the speed of the number. Increase for a harder difficulty, decrease for an easier difficulty.
    3rd argument (Integer): Quantity of numbers, increase for more numbers, decrease for less.
    ]]

	if success then
		print("success")
	else
		print("fail")
	end
end

function StartMinigameRapidLines()
	local success = exports["bl_ui"]:RapidLines(3, 70, 5)
	--[[
    1st argument (Integer): Iterations, this is the number of times you'll have to do this minigame. Increase for more iterations, decrease for less.
    2nd argument (Integer): Difficulty, between 1 and 100, this affects the speed of the lines. Increase for a harder difficulty, decrease for an easier difficulty.
    3rd argument (Integer): Quantity of lines, increase for more lines, decrease for less.
    ]]

	if success then
		print("success")
	else
		print("fail")
	end
end
