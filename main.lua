----------------------------------------------------------------------------------------
-- Castle Crawler
-- main.lua

-- Peter Zorzonello
-- CSC255 - Programming for Games
-- December 14,2014

-- code that requires all the other code in the project.
-- require the sounds and functions that play sounds
-- keeps track of the settings
-----------------------------------------------------------------------------------------

W = 480
H = 320


--settings table. Keep track of the state of the music and sound
tblSettings = {}
tblSettings.bSound = true
tblSettings.bMusic = true

-- require all the files that the game needs to run

-- load/run the dpad.lua file
-- alows a dpad to show up in game and a b-button
dpad = require("dpad") 
--rewuire all the lua files
scrnSplash = require("splash")
scrnSettings = require("settings")
scrnInstruction1 = require("instructions1")
scrnInstruction2 = require("instructions2")
scrnInstruction3 = require( "instructions3" )
scrnPlay = require("game")
scrnCredits1 = require( "credits_1" )
scrnCredits2 = require( "credits_2" )


--inport all audio assetts
soundTable = {
	bgMusic = audio.loadSound( "assets/sounds/bg.wav" ),
    coinSound = audio.loadSound( "assets/sounds/coin.mp3" ),
    shine = audio.loadSound( "assets/sounds/shine.wav" ),
    click = audio.loadSound( "assets/sounds/click.mp3" )
}

--makes the background music loop
local options =
{ 
    loops = -1,
}

--plays the background music if the correct setting is active
function playMusic()
	if (tblSettings.bMusic == true) then
		audio.play( soundTable["bgMusic"], options)
	end
end

--plays the sounds in the game if the correct setting is active
function playSound(sName)
	if (tblSettings.bSound == true) then
		audio.play( soundTable[sName] )
	end
end



