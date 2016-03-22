----------------------------------------------------------------------------------------
-- Castle Crawler
-- splash.lua

-- Peter Zorzonello
-- CSC255 - Programming for Games
-- December 14,2014

-- code dsiplays the splash screen. Butons to move to other screens and to play the game
-- live here. Clicking on the play button also starts the background music.
-----------------------------------------------------------------------------------------
local grpSplash = display.newGroup()
dpad.grpHud.isVisible =false 

--display the background image
local bg = display.newImage( grpSplash, "assets/screens/splashScreen.png", W/2, H/2, W, H )
bg:scale( 1, 1.10 )

--display the buttons on the screen
local btnPlay = display.newImage( grpSplash, "assets/buttons/Play.png", W/2, H*2/3)
local btnSettings = display.newImage( grpSplash, "assets/buttons/Optionsbtn.png", W/2, H*2/3+30)
local btnInstructions = display.newImage( grpSplash, "assets/buttons/instructions.png", W/2, H*2/3+60)
local btnCredits = display.newImage( grpSplash, "assets/buttons/Credits.png", W/2, H*2/3+90 )

--when play is tapped play the game
function playTapped()
	scrnSplash.isVisible = false
	scrnPlay.isVisible = true
	playMusic()
	dpad.grpHud.isVisible =true 
end

--if settings was tapped show settings page
--hide the splash screen
function settingsTapped()
	scrnSplash.isVisible = false
	scrnSettings.isVisible = true
end

--if instruction button is taped show instruction page
--hide the splash screen
function instructionTapped()
	scrnSplash.isVisible = false
	scrnInstruction1.isVisible = true
end

-- movues the user to the credits page
function creditsTapped( )
	scrnSplash.isVisible = false
	scrnCredits1.isVisible = true
end

--the event listners
btnPlay:addEventListener("tap", playTapped)
btnSettings:addEventListener("tap", settingsTapped)
btnInstructions:addEventListener( "tap", instructionTapped )
btnCredits:addEventListener( "tap", creditsTapped )

return grpSplash