----------------------------------------------------------------------------------------
-- Castle Crawler
-- dpad.lua

-- Peter Zorzonello
-- CSC255 - Programming for Games
-- December 14,2014

-- code dsiplays a dpad on the screen. It gets the users input and controlls movement
-- also allows the visiblity to be toggled on and off
----------------------------------------------------------------------------------------
local t = {} -- t is the name of an empty table
t.scaled_x = 0
t.scaled_y = 0
t.angle = 0

local grpHud = display.newGroup( )

--dpad object
local dpadCtrl = display.newImage( grpHud, "gfx/Movement.png", 64, 320-64)
dpadCtrl.alpha = .5
local halfDpad =  (dpadCtrl.width / 2)
grpHud:toFront()


--called when the dpad is touched
--casues the dpad to become brighter send movment instruction back to the game
local function dpadTouched(event)
	grpHud:toFront()
	if( event.phase=="ended" or event.phase == "canceled") then
		t.scaled_x = 0
		t.scaled_y = 0
		dpadCtrl.alpha = .25
	else
		local x_movement = event.x - dpadCtrl.x
		local y_movement = event.y - dpadCtrl.y

		t.scaled_x = x_movement / halfDpad 
		t.scaled_y = y_movement / halfDpad

		if(math.abs(t.scaled_x) > math.abs(t.scaled_y)) then
			t.scaled_y = 0
		else
			t.scaled_x = 0
		end

		t.scaled_x = math.round(t.scaled_x)
		t.scaled_y = math.round(t.scaled_y)

		dpadCtrl.alpha = .9
	end
end

--touch event listner for the dpad
dpadCtrl:addEventListener("touch", dpadTouched)
--allows the visiblity to be toggled
t.grpHud = grpHud

return t



