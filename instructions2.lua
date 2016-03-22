----------------------------------------------------------------------------------------
-- Castle Crawler
-- instructuins2.lua

-- Peter Zorzonello
-- CSC255 - Programming for Games
-- December 14,2014

-- code dsiplays the instruction page. 2 of 3. 
-----------------------------------------------------------------------------------------
local grpInstruction2 = display.newGroup( )

--display the bagground image
local bg = display.newImage( grpInstruction2, "assets/screens/Instruction2.png", W/2, H/2, W, H  )
bg:scale( .95, 1.029 )

--displays buttons on the screen
local btnBack = display.newImage( grpInstruction2, "assets/gfx/Back.png", W-100, H-20)
btnBack:scale( .3, .3 )

local btnNext = display.newImage( grpInstruction2, "assets/gfx/Right-Play.png", W-30, H-20)
btnNext:scale( .3, .3 )


grpInstruction2.isVisible = false

--button functionality
function nextTapped()
	scrnInstruction2.isVisible = false
	scrnInstruction3.isVisible = true
end

--tap this button to return to the splash screen
function backTapped()
	scrnInstruction2.isVisible = false
	scrnInstruction1.isVisible = true
end


btnNext:addEventListener( "tap", nextTapped )
btnBack:addEventListener("tap", backTapped)


return grpInstruction2