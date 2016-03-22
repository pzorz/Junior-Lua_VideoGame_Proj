-----------------------------------------------------------------------------------------
--
-- Space Lab
-- Day 8
-- 
-- REFACTORIZATION - utils.lua
--
-----------------------------------------------------------------------------------------

local utils_table = {}

-- move objA to the location of objB at speed of objA
local function moveAtoB(objA, objB, callback_fn)
	local a = math.pow((objA.x - objB.x),2)
	local b = math.pow((objA.y - objB.y),2) 
	local c = math.sqrt( a + b ) -- compute the distance between objA and objB

	local time_to_move = c / objA.speed

	objA:applyForce( (objB.x - objA.x), (objB.y - objA.y), 0, 0 )
	--transition.to(objA, {time = time_to_move, x = objB.x, y = objB.y, onComplete = callback_fn})
end

utils_table.moveAtoB = moveAtoB

local function rotateAtoB(objA, objB)
	local opp = objB.y - objA.y
	local adj = objB.x - objA.x + .001

	local newAngle = math.deg(math.atan( opp/adj ))

	if(objB.x < objA.x) then
		newAngle = newAngle - 180
	end

	objA.rotation = newAngle
	-- must convert radians to degrees
	-- set rotate to that degrees
end

utils_table.rotateAtoB = rotateAtoB

print("UTILS LOADED")

return utils_table
