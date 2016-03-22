----------------------------------------------------------------------------------------
-- Castle Crawler
-- instructuins1.lua

-- Peter Zorzonello
-- CSC255 - Programming for Games
-- December 14,2014

-- code dsiplays the instruction page. 1 of 3. 
-----------------------------------------------------------------------------------------
local grpInstruction1 = display.newGroup( )

--display the bagground image
local bg = display.newImage( grpInstruction1, "assets/screens/Instruction1.png", W/2, H/2, W, H  )
bg:scale( .95, 1.029 )


local btnBack = display.newImage( grpInstruction1, "assets/gfx/Back.png", W-100, H-20)
btnBack:scale( .3, .3 )

local btnNext = display.newImage( grpInstruction1, "assets/gfx/Right-Play.png", W-30, H-20)
btnNext:scale( .3, .3 )


grpInstruction1.isVisible = false


--tap this button to return to the splash screen
function backTapped()
	scrnInstruction1.isVisible = false
	scrnSplash.isVisible = true
end

function nextTapped()
	scrnInstruction1.isVisible = false
	scrnInstruction2.isVisible = true
end

btnBack:addEventListener("tap", backTapped)
btnNext:addEventListener( "tap", nextTapped )


return grpInstruction1