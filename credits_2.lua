local grpCredits2 = display.newGroup( )

local bg = display.newImage( grpCredits2, "assets/screens/credits-Music.png", W/2, H/2, W, H  )
bg:scale( .95, 1.029 )

local btnBack = display.newImage( grpCredits2, "assets/gfx/Back.png", W-100, H-20)
btnBack:scale( .3, .3 )

grpCredits2.isVisible = false

function backTapped()
	scrnCredits2.isVisible = false
	scrnCredits1.isVisible = true
end

btnBack:addEventListener("tap", backTapped)

return grpCredits2