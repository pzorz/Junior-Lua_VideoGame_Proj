local grpCredits1 = display.newGroup( )

local bg = display.newImage( grpCredits1, "assets/screens/credits-images.png", W/2, H/2, W, H  )
bg:scale( .95, 1.029 )

local btnBack = display.newImage( grpCredits1, "assets/gfx/Back.png", W-100, H-20)
btnBack:scale( .3, .3 )

local btnNext = display.newImage( grpCredits1, "assets/gfx/Right-Play.png", W-30, H-20)
btnNext:scale( .3, .3 )

grpCredits1.isVisible = false

function backTapped()
	scrnCredits1.isVisible = false
	scrnSplash.isVisible = true
end

function nextTapped()
	scrnCredits1.isVisible = false
	scrnCredits2.isVisible = true
end

btnBack:addEventListener("tap", backTapped)
btnNext:addEventListener( "tap", nextTapped )

return grpCredits1