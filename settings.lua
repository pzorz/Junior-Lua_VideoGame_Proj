----------------------------------------------------------------------------------------
-- Castle Crawler
-- settings.lua

-- Peter Zorzonello
-- CSC255 - Programming for Games
-- December 14,2014

-- code dsiplays the options page with 2 buttons to control sound and music
-- clicking thies buttons changes the values in the settigns table stored in main
-----------------------------------------------------------------------------------------
local grpSettings = display.newGroup( )

--display the background 
local bg = display.newImage( grpSettings, "assets/screens/options.png", W/2, H/2, W, H )
bg:scale( 1, 1.029 )


-- display the buttons on the page
local btnBack = display.newImage( grpSettings, "assets/gfx/Back.png", W/12, H/7)
btnBack:scale( .4, .4 )

local btnMusicOff = display.newImage( grpSettings, "assets/buttons/Music-Off.png", W/2, H*2/3)
local btnMusicOn = display.newImage( grpSettings, "assets/buttons/Music-On.png", W/2, H*2/3)

local btnSoundOff = display.newImage( grpSettings, "assets/buttons/Sound-Off.png", W/2, H*2/3 - 60)
local btnSoundOn = display.newImage( grpSettings, "assets/buttons/Sound-On.png", W/2, H*2/3 - 60)

grpSettings.isVisible = false
btnMusicOff.isVisible = false
btnSoundOff.isVisible = false

--tap this button to return to the splash screen
function backTapped()
	scrnSettings.isVisible = false
	scrnSplash.isVisible = true
end

--tap this button to turn the music off
--switch to the sound off button
function SoundOnTapped()
	tblSettings.bSound = false
	btnSoundOn.isVisible = false
	btnSoundOff.isVisible = true
end
--tap this button to turn on the sound
--switch to the sould on button
function SoundOffTapped()
	tblSettings.bSound = true
	btnSoundOn.isVisible = true
	btnSoundOff.isVisible = false
end

--tap this button to turn off the music
--switch to the music off button
function MusicOnTapped()
	tblSettings.bMusic = false
	btnMusicOn.isVisible = false
	btnMusicOff.isVisible = true
end
--tap this button to turn on the music
--switch to the music on button
function MusicOffTapped()
	tblSettings.bMusic = true
	btnMusicOn.isVisible = true
	btnMusicOff.isVisible = false
end


--event handlers for the buttons on this page
btnBack:addEventListener("tap", backTapped)

btnSoundOff:addEventListener( "tap", SoundOffTapped )
btnSoundOn:addEventListener( "tap", SoundOnTapped )

btnMusicOff:addEventListener( "tap", MusicOffTapped )
btnMusicOn:addEventListener( "tap", MusicOnTapped )



return grpSettings