----------------------------------------------------------------------------------------
-- Castle Crawler
-- instructuins3.lua

-- Peter Zorzonello
-- CSC255 - Programming for Games
-- December 14,2014

-- code dsiplays the instruction page. 3 of 3. 
-----------------------------------------------------------------------------------------
local grpInstruction3 = display.newGroup( )

--display the bagground image
local bg = display.newImage( grpInstruction3, "assets/screens/Instruction3.jpg", W/2, H/2, W, H  )
bg:scale( .95, 1.029 )

--display buttons on the screen
local btnBack = display.newImage( grpInstruction3, "assets/gfx/Back.png", W-100, H-20)
btnBack:scale( .3, .3 )

local btnNext = display.newImage( grpInstruction3, "assets/gfx/Right-Play.png", W-30, H-20)
btnNext:scale( .3, .3 )


grpInstruction3.isVisible = false


--tap this button to return to the splash screen
function backTapped()
	scrnInstruction3.isVisible = false
	scrnInstruction2.isVisible = true
end


btnBack:addEventListener("tap", backTapped)


return grpInstruction3