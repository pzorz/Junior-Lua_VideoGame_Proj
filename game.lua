-----------------------------------------------------------------------------------------
-- Castle Crawler
-- game.lua

-- Peter Zorzonello
-- CSC255 - Programming for Games
-- December 12,2014

-- code for the game. Takes care of creating, removing, and moving objects.
-- keeps track of a score and lives.
-- Moves the user back to the splash screen when the game is over

--backgrounds: 
--Castle: http://14textures.com/wp-content/uploads/2014/04/Charcoal-2.jpg
--Cortyard: Matt Muehleman
--Rug:http://www.rugfirm.com/images/large/195_LRG.jpg

--other assets: assets_indygamedev
-----------------------------------------------------------------------------------------

--sets the tile size for the game. all objects sould take up 1 tile
local TILESIZE = 40

--creats the player
local player = {}
local stairs = {}

-- this defines the room it will be a 2D array
local world2D = {} 

--creats enemy list and attack list
local MageList = {}
local magicAttackList={}

-- this arrray holds all of the worlds(levels)
local universe = {}
-- keeps track of whic world(level) the player is on
local universeNum = 1

local score = 0
local lives = 3

-- set up the display groups
-- thes will act as the levels in the fame
universe[1] = display.newGroup( )
universe[2] = display.newGroup( )
universe[3] = display.newGroup( )
universe[4] = display.newGroup( )

-- turn all of the levels off, no level is visiable
for i=1, 3 do
	universe[i].isVisible = false
end

--display the text on the screen.
--text for the scores, lives, and reset button
local scoreTextDisplay = display.newText( universe[universeNum], "Score: ", 430, 300, "Arial", 15 )
local scoreDisplay = display.newText( universe[universeNum], score, 460, 300, "Arial", 15 )

local livesTextDisplay = display.newText( universe[universeNum], "Lives: ", 300, 300, "Arial", 15 )
local livesDisplay = display.newText( universe[universeNum], lives, 340, 300, "Arial", 15  )

local btnReset = display.newText(universe[universeNum], "Reset", 200, 300, "Arial", 15 )

-- takes two paramerters, a row and a column. it convertes them to pixles, returns them as a table
-- the two paramiters aiill be a row location and a colum location
-- the trutring table will have those values converted into their pixal locations
function fromRowColToPixels(row,col)
	local tbl = {}
	tbl.x = TILESIZE/2 + (col * TILESIZE)
	tbl.y = TILESIZE/2 + (row * TILESIZE)
	return tbl
end

--function to reset the game if the player wants to restart
--casues the player to lose the game
function resetGame()
	lives=0
	endGame()
end

--switches the display back to the splash screen
--sesets the assets and the displays so the game can be replayed
function swichDisplay()

	game_over:removeSelf( )

	gameMessage:removeSelf( )

	gamescoreTextDisplay:removeSelf( )

	gamescoreDisplay:removeSelf( )

	audio.stop()

	for i=0,(stage_h/TILESIZE) do
		--world2D[i] = {}
		for j=0,(stage_w/TILESIZE) do
			if (world2D[i][j] ~= nil) then
				world2D[i][j]:removeSelf( )
			end
			world2D[i][j] = nil
		end
	end

	universe[universeNum].isVisible = false

	universeNum = 1

	local roomdetails = require("room".. universeNum .."_contents")
	createObjectsInRoom(universeNum,roomdetails)
	
	if (universeNum == 3) then
		MageList = nil
	end
	
	universe[universeNum]:insert( player )
	universe[universeNum]:insert(scoreDisplay)
	universe[universeNum]:insert(btnReset)
	universe[universeNum]:insert(scoreTextDisplay)
	universe[universeNum]:insert(livesDisplay)
	universe[universeNum]:insert(livesTextDisplay)

	resetPlayerLocation()
	MageList = {}

	score = 0
	scoreDisplay.text = score
	lives = 3
	livesDisplay.text = lives
	
	scrnSplash.isVisible = true
end

--function called when the game ends to display a message
--shows different messages depending on if the player wins or loses
--callse the switch display function to return to the splash screen
function endGame()
	if (lives == 0) then
		dpad.grpHud.isVisible = false
		game_over = display.newText( universe[universeNum], "Game Over ", stage_w/2, stage_h/2, "Arial", 30  )
		gameMessage = display.newText( universe[universeNum], "You Louse ", stage_w/2, stage_h/2 - 30, "Arial", 30  )
		gamescoreTextDisplay = display.newText( universe[universeNum], "Score: ", 430, 300, "Arial", 15 )
		gamescoreDisplay = display.newText( universe[universeNum], score, 460, 300, "Arial", 15 )
		
		gamescoreTextDisplay:toFront( )
		gamescoreTextDisplay:setFillColor( 1,0,0 )
		gamescoreDisplay:toFront( )
		gamescoreDisplay:setFillColor( 1,0,0 )
		game_over:setFillColor( 1,0,0 )
		game_over:toFront( )
		gameMessage:setFillColor( 1,0,0 )
		gameMessage:toFront( )

		timer.performWithDelay( 2000, swichDisplay, 1 )
	else
		dpad.grpHud.isVisible = false
		game_over = display.newText( universe[universeNum], "Game Over ", stage_w/2, stage_h/2+10, "Arial", 30  )
		gameMessage = display.newText( universe[universeNum], "You Win ", stage_w/2, stage_h/2 - 20, "Arial", 30  )
		gamescoreTextDisplay = display.newText( universe[universeNum], "Score: ", stage_w/2 - 35, stage_h/2 - 50, "Arial", 30 )
		gamescoreDisplay = display.newText( universe[universeNum], score, stage_w/2 + 35, stage_h/2 - 50, "Arial", 30 )
		
		gamescoreTextDisplay:setFillColor( 0,1,0 )
		gamescoreTextDisplay:toFront( )
		gamescoreDisplay:setFillColor( 0,1,0 )
		gamescoreDisplay:toFront( )
		game_over:setFillColor( 0,1,0 )
		game_over:toFront( )
		gameMessage:setFillColor( 0,1,0 )
		gameMessage:toFront( )

		timer.performWithDelay( 2000, swichDisplay, 1 )
	end
end

-- takes a table as a parimiter, the tabe should ave a row and a column as well as a type. Using the table create 
-- objects of that type at the row and colum specified. after they have been created add them to the 2D array that is the room
--
-- if the obkject is a spectil type: coin, mage, ect. use a sprite sheet instead
--
-- return the tempary object
function createObjectInRoom(roomNum,tblObjectDetails)
	local newloc = fromRowColToPixels(tblObjectDetails.row,tblObjectDetails.col)
	
	if (tblObjectDetails.type == "coin") then
		local spriteCoin = 
		{
			{
				name = "spinning",
				start = 1,
				count = 30,	
				time = 1000
			}
		}

		local CoinOptions = 
		{
			width = 127,
			height = 127,
			numFrames = 30
		}

		local coinSpriteSheet = graphics.newImageSheet( "gfx/Coins.png", CoinOptions )
		
		tmpObj = display.newSprite(coinSpriteSheet, spriteCoin)
		
		tmpObj.x = newloc.x 
	 	tmpObj.y = newloc.y
	   	
		tmpObj:scale( .25, .25 )
		tmpObj.type = tblObjectDetails.type	
		tmpObj.row = tblObjectDetails.row
		tmpObj.col = tblObjectDetails.col

		tmpObj:setSequence( "spinning" )
		tmpObj:play( )

		world2D[tmpObj.row][tmpObj.col] = tmpObj
		universe[roomNum]:insert( tmpObj )

	elseif (tblObjectDetails.type == "mageUp") then
		local spritemageUp = 
		{
			{
				name = "attack",
				start = 11,
				count = 5,	
				time = 3000
			}
		}
		local MageUpOptions = 
		{
			width = 93,
			height = 105,
			numFrames = 70
		}
		local MageSpriteSheet = graphics.newImageSheet( "gfx/Mage.png", MageUpOptions )
		
		tmpObj = display.newSprite(MageSpriteSheet, spritemageUp)
		
		tmpObj.x = newloc.x 
	 	tmpObj.y = newloc.y
	   	
		tmpObj:scale( .75, .50 )
		tmpObj.type = tblObjectDetails.type	
		tmpObj.row = tblObjectDetails.row
		tmpObj.col = tblObjectDetails.col

		tmpObj:setSequence( "attack" )

		world2D[tmpObj.row][tmpObj.col] = tmpObj
		universe[roomNum]:insert( tmpObj )	
		table.insert(MageList, tmpObj)	

	elseif (tblObjectDetails.type == "mageDown") then
		local spritemageDown = 
		{
			{
				name = "attack",
				start = 52,
				count = 5,	
				time = 3000
			}
		}
		local MageDownOptions = 
		{
			width = 97,
			height = 105,
			numFrames = 70
		}
		local MageSpriteSheet = graphics.newImageSheet( "gfx/Mage.png", MageDownOptions )
		
		tmpObj = display.newSprite(MageSpriteSheet, spritemageDown)
		
		tmpObj.x = newloc.x 
	 	tmpObj.y = newloc.y
	   	
		tmpObj:scale( .75, .50 )
		tmpObj.type = tblObjectDetails.type
		tmpObj.row = tblObjectDetails.row
		tmpObj.col = tblObjectDetails.col

		tmpObj:setSequence( "attack" )

		world2D[tmpObj.row][tmpObj.col] = tmpObj
		universe[roomNum]:insert( tmpObj )	
		table.insert(MageList, tmpObj)
	else
		local tmpObj = display.newImage( "gfx/" .. tblObjectDetails.type .. ".png", newloc.x, newloc.y)
	
		tmpObj.type = tblObjectDetails.type	
		tmpObj.row = tblObjectDetails.row
		tmpObj.col = tblObjectDetails.col
		world2D[tmpObj.row][tmpObj.col] = tmpObj
		universe[roomNum]:insert( tmpObj )
		
	end
	
	return tmpObj
end

-- loop through a tabe of objects and call a function to create each object
function createObjectsInRoom(roomNum, lstOfObjectTables)
	for i = 1, table.getn(lstOfObjectTables) do
		createObjectInRoom(roomNum, lstOfObjectTables[i])
	end
end

-- resets the player to being idle after each time it moves, provets the player from steping someplace
-- not on the grid. Also reset back to idle so the player can move again
function resetMoving()
	player.isMoving = false
	player:setSequence("idle")
	player:play()
end

--resets the players location depending on the the level
function resetPlayerLocation()
	if (universeNum == 1) then
		player.x = 20			    
	    player.y = 260
	    player.row = 6
	    player.col = 0
	elseif universeNum == 2 then
	    player.x = 300			    
	    player.y = 300
	    player.row = 7
	    player.col = 7 
    elseif universeNum == 3 then
	    player.x = 460		    
	    player.y = 180
	    player.row = 4
	    player.col = 11 
    elseif universeNum == 4 then
	    player.x = 220	    
	    player.y = 300
	    player.row = 7
	    player.col = 5   
	end
end

-- this function moves an object; the object MUST have a .row and a .col
-- preform checks on the spaces around the moving object to decide if it should move there or if there is any penilty or reward
-- preform checks to make sure player does not walk offscrene
function moveObject(object, row_change, col_change)

	if((object.row+row_change)>=0 and (object.row+row_change)<stage_h/TILESIZE
		and (object.col+col_change)>=0 and (object.col+col_change)<stage_w/TILESIZE) then
	
		--if the next space is empty move there
		if(world2D[object.row+row_change][object.col+col_change]==nil) then
			object.isMoving = true
			if(object.type=="player") then
				if(dpad.scaled_x >= 0) then
					object.xScale = 0.75
				else
					object.xScale = -0.75
				end
				object:setSequence("walking")
				object:play()
				transition.to(object,{time=500,x=object.x+(col_change*TILESIZE),y=object.y+(row_change*TILESIZE), onComplete=resetMoving})
			else
				if(object.type =="enemy")then
					if(dpad.scaled_x >= 0) then
						object.xScale = 0.5
					else
						object.xScale = -0.5
					end
				end
				transition.to(object,{time=500,x=object.x+(col_change*TILESIZE),y=object.y+(row_change*TILESIZE)})
			end
			-- empty out their previous location
			world2D[object.row][object.col] = nil

			-- update the objects notion of its own location
			object.row = object.row + row_change
			object.col = object.col + col_change

			-- place the object at the new location
			world2D[object.row][object.col] = object

		--if the object is a pushable object, call the move object on the pushavle object so both it and the 
		--player move, (if there is a free space behind the object)
		elseif (world2D[object.row+row_change][object.col+col_change].type == "pushable") then
			moveObject((world2D[object.row+row_change][object.col+col_change]), row_change, col_change)

		--if the object colides with a coin remove the coin. 
		--if the object is a player increase the score
		--if the level is level 1 only increase the score a little
		elseif (world2D[object.row+row_change][object.col+col_change].type == "coin") then
			playSound("coinSound")
			world2D[object.row+row_change][object.col+col_change]:removeSelf( )
			world2D[object.row+row_change][object.col+col_change] = nil

			--move the player
			object.isMoving = true
			if(object.type=="player") then
				if(dpad.scaled_x >= 0) then
					object.xScale = 0.75
				else
					object.xScale = -0.75
				end
				object:setSequence("walking")
				object:play()	
				transition.to(object,{time=500,x=object.x+(col_change*TILESIZE),y=object.y+(row_change*TILESIZE), onComplete=resetMoving})
			--if it isnt the player move it
			else 
				transition.to(object,{time=500,x=object.x+(col_change*TILESIZE),y=object.y+(row_change*TILESIZE)})
			end
			world2D[object.row][object.col] = nil

			-- update the object's location
			object.row = object.row + row_change
			object.col = object.col + col_change

			-- place the object at the new location
			world2D[object.row][object.col] = object
			
			--update score
			if(object.type=="player") then
				--if the player is on level 1 only update it a little
				if(universeNum == 1) then 
					score = score + 1
					scoreDisplay.text = score
				elseif(universeNum == 2) then 
					score = score + 3
					scoreDisplay.text = score
				elseif(universeNum == 3) then 
					score = score + 5
					scoreDisplay.text = score
				end
			end

		--if the player steps on a switch activate the switch and remove it from play
		elseif (world2D[object.row+row_change][object.col+col_change].type == "switch") then
			--remove the switch
			playSound("click")
			if (not (object.type == "player")) then
			    score = score + 2
				scoreDisplay.text = score
			end
			world2D[object.row+row_change][object.col+col_change]:removeSelf( )
			world2D[object.row+row_change][object.col+col_change] = nil

			--move the player
			object.isMoving = true
			if(object.type=="player") then
				if(dpad.scaled_x >= 0) then
					object.xScale = 0.75
				else
					object.xScale = -0.75
				end
				object:setSequence("walking")
				object:play()
				transition.to(object,{time=500,x=object.x+(col_change*TILESIZE),y=object.y+(row_change*TILESIZE), onComplete=resetMoving})
			else 
				transition.to(object,{time=500,x=object.x+(col_change*TILESIZE),y=object.y+(row_change*TILESIZE)})
			end
			world2D[object.row][object.col] = nil

			-- update the objects notion of its own location
			object.row = object.row + row_change
			object.col = object.col + col_change

			-- place the object at the new location
			world2D[object.row][object.col] = object

			--removes the gold bricks
			if (universeNum == 1) then
				world2D[1][11]:removeSelf( )
				world2D[2][11]:removeSelf( )
				world2D[3][11]:removeSelf( )
				world2D[4][11]:removeSelf( )
				world2D[5][11]:removeSelf( )
				world2D[6][11]:removeSelf( )

				world2D[1][11] = nil
				world2D[2][11] = nil
				world2D[3][11] = nil
				world2D[4][11] = nil
				world2D[5][11] = nil
				world2D[6][11] = nil
			else
				moveObject(world2D[3][5], 0, 1)
				stairs = display.newImage( "gfx/stairs.png",220,140)
				stairs.row = 3
				stairs.col = 5
				stairs.type = "stairs"
				world2D[3][5] = stairs
			end
		
		--interacting with the wand ends the game
		elseif (world2D[object.row+row_change][object.col+col_change].type == "wand") then
			world2D[object.row+row_change][object.col+col_change]:removeSelf( )
			world2D[object.row+row_change][object.col+col_change] = nil
			endGame()	
		
		--cliding with the stairs moves the player down into the next level
		elseif (world2D[object.row+row_change][object.col+col_change].type == "stairs") then
			if(object.type=="player") then
				score = score + 5
				scoreDisplay.text = score
				

				for i=0,(stage_h/TILESIZE) do
					--world2D[i] = {}
					for j=0,(stage_w/TILESIZE) do
						-- print ("checking "..i .. " " .. "checking " .. j )
						if (not (world2D[i][j] == nil)) then
							-- if (world2D[i][j].type=="pushable") then
							-- 	-- print ("removing brick")
							-- end
							universe[universeNum]:remove(world2D[i][j])
							world2D[i][j]:removeSelf( )
						end
						world2D[i][j] = nil
					end
				end

				universe[universeNum].isVisible = false
				universeNum = universeNum + 1
				universe[universeNum].isVisible = true
				local roomdetails = require("room".. universeNum .."_contents")
				createObjectsInRoom(universeNum,roomdetails)
				if (universeNum == 3) then
					MageList = nil
				end
				
				universe[universeNum]:insert( player )
				universe[universeNum]:insert(scoreDisplay)
				universe[universeNum]:insert(scoreTextDisplay)
				universe[universeNum]:insert(btnReset)
				universe[universeNum]:insert(livesDisplay)
				universe[universeNum]:insert(livesTextDisplay)

				resetPlayerLocation()
			end
		--if the player colides with a hole he should be transpoted back to the beging of the level
		--player will also suffer poitns reduction and lose 1 life
		--if the lifes remaning are 0 end game  
		--if the player pushes a block onto the hole it falls down and plugs up the hole
		elseif (world2D[object.row+row_change][object.col+col_change].type == "hole") then
			if object.type == "player" then
			    score = score - 10
			    scoreDisplay.text = score
			    lives = lives -1
			    livesDisplay.text = lives
			    if (lives == 0) then
			    	endGame()
			    end
			    world2D[object.row][object.col]= nil
			    resetPlayerLocation()
		    elseif object.type == "pushable" then
		    	--remove the hole
		    	world2D[object.row+row_change][object.col+col_change]:removeSelf( )
		    	world2D[object.row+row_change][object.col+col_change]= nil
		    	--remove the pushable
		    	world2D[object.row][object.col]:removeSelf( )
		    	world2D[object.row][object.col]= nil
					
			end
		-- if the object the player colides with is a casle(castle door) the player should advance to the next level
		-- to advance the original room must be cleared, this way the player dosnt get traped by invisiable objects
		-- after the room is cleared mke the existing room visble, create and make the next room visiable
		elseif (world2D[object.row+row_change][object.col+col_change].type == "heart") then
			world2D[object.row+row_change][object.col+col_change]:removeSelf( )
			world2D[object.row+row_change][object.col+col_change] = nil
			lives = lives+1
			livesDisplay.text = lives

		elseif (world2D[object.row+row_change][object.col+col_change].type == "castle") then
			score = score + 3
			scoreDisplay.text = score
			-- print ("score changed")
			
			for i=0,(stage_h/TILESIZE) do
				--world2D[i] = {}
				for j=0,(stage_w/TILESIZE) do
					-- print ("checking "..i .. " " .. "checking " .. j )
					if (not (world2D[i][j] == nil)) then
						-- if (world2D[i][j].type=="pushable") then
						-- 	print ("removing brick")
						-- end
						universe[universeNum]:remove(world2D[i][j])
						world2D[i][j]:removeSelf( )
					end
					world2D[i][j] = nil
				end
			end

			universe[universeNum].isVisible = false
			-- universe[universeNum]:removeSelf( )
			-- universe[universeNum] = nil
			universeNum = universeNum + 1
			universe[universeNum].isVisible = true
			local roomdetails = require("room".. universeNum .."_contents")
			createObjectsInRoom(universeNum,roomdetails)
			if (universeNum == 3) then
				MageList = nil
			end
			
			universe[universeNum]:insert( player )
			universe[universeNum]:insert(scoreDisplay)
			universe[universeNum]:insert(scoreTextDisplay)
			universe[universeNum]:insert(btnReset)
			universe[universeNum]:insert(livesDisplay)
			universe[universeNum]:insert(livesTextDisplay)

			resetPlayerLocation()
		end
	end
end

-- gets input from the dpad every time the screen is redrawn. using this data move the object
-- in order for the object to move it must curentky not be moving, this way objects wont end up in spaces not on the grid
function onRedraw()
	--print(dpad.scaled_x .. " " .. dpad.scaled_y)
	if((not(dpad.scaled_x==0) or not(dpad.scaled_y == 0)) and player.isMoving==false) then
		moveObject(player,dpad.scaled_y, dpad.scaled_x)
	end

end

--checks to see if a magical atack has conected with anything
--if it hit the player react 
--if it hit a wall item or left the screen remove it
function checkMagicCollision()
	-- if (universeNum == 2) then	
		for i = table.getn(magicAttackList), 1, -1  do
			local magic = magicAttackList[i]
			magic.row = magic.row + magic.motion
			if((magic.row)>=0 and (magic.row)<stage_h/TILESIZE
			and (magic.col)>=0 and (magic.col)<stage_w/TILESIZE) then
				if (world2D[magic.row][magic.col] == nil) then
					if(magic.row <= stage_h / TILESIZE) and (magic.row >= 0) then
						transition.to( magic, {time = magic.transitionTime, delta = true, x = 0, y = magic.motion*TILESIZE} )
					else
						table.remove( magicAttackList, i )
						magic:removeSelf()
					end
				elseif(world2D[magic.row][magic.col].type == "player") then
					world2D[player.row][player.col] = nil
					resetPlayerLocation()
					lives = lives -1
					livesDisplay.text = lives
					if (lives == 0) then
						endGame()
					end
				else
					table.remove( magicAttackList, i )
					magic:removeSelf( )			
				end
			else
				table.remove( magicAttackList, i )
				magic:removeSelf( )
			end
		end
	-- end
end

--shots magic from the mages either up or down
function MagicAttack()
	if (not (MageList == nil)) then
		for i = table.getn(MageList),1, -1 do
			local magic = display.newImage( "gfx/magicAttack.png", MageList[i].x, MageList[i].y )
			playSound("shine")
		
			magic.transitionTime = 100
			magic.row = MageList[i].row
			magic.col = MageList[i].col
		
			if(MageList[i].type == "mageUp") then
				magic.motion = -1
			else
				magic.motion = 1
			end

			transition.to( magic, {time = magic.transitionTime, delta = true, x = 0, y = magic.motion*TILESIZE} )

			universe[2]:insert(magic)
			table.insert(magicAttackList, magic)
		end
	end
end

--makes the mages attack and play their animation
function MagesAttack()
	if (not (MageList == nil)) then
		for i = 1, table.getn(MageList) do
			MageList[i]:play( )
			MagicAttack()
		end
	end
end

-- the onStart function. 
-- set up the stage width and stage height
-- sets up the player
-- defines player animation
-- creats the 2D array
-- calles the function to move enimies
-- gets the detales for the room
-- creats the room
function onStart()
	-- init the display/screen so that coronaSDK doesn't throw up when I ask the size
	display.newRect( 0, 0, 0, 0 )
	
	--set a screen hight and width so they can be used for display objects
	stage_w = display.currentStage.contentWidth
	stage_h = display.currentStage.contentHeight

	local Knightoptions = 
	{
		width = 35,
		height = 51,
		numFrames = 24
	}

	-- local coinSpriteSheet = graphics.newImageSheet( "gfx/Coins.png", CoinOptions )
	local playerImageSheet = graphics.newImageSheet( "gfx/KnightSheet.png", Knightoptions )

	local spriteKinight = 
	{
		{ 
			name = "walking",
			frames = { 1, 2, 3},
			loopDirection = "bounce",
			time = 300 --300ms
		},
		{ 
			name = "idle",
			start = 1,
			count = 2,
			time = 500
		},			
	}

	--sets the player up
	--the players soritesheet and location
	player = display.newSprite(playerImageSheet, spriteKinight)
	player.x = 20
	player.y = 260
	player:setSequence("idle")
	player:play()
	player:scale( 0.75, 0.75 )
	player.isFixedRotation = true
	player.isMoving = false
	player.row = 6
	player.col = 0
	player.type = "player"
	universe[universeNum]:insert( player )
	
	btnReset:addEventListener( "tap", resetGame )
	Runtime:addEventListener("enterFrame", onRedraw)
	--dpad.addButtonListener(fireArrow)
	dpad.grpHud:toFront( )
	--create the 2D array
	world2D = {}
	for i=0,(stage_h/TILESIZE) do
		world2D[i] = {}
		for j=0,(stage_w/TILESIZE) do
			world2D[i][j] = nil
		end
	end
	
	-- load the room1_contents.lua file (contains a list of details about world objects)
	local roomdetails_1 = require("room1_contents")

	level1_background = display.newImage( universe[1], "assets/backgrounds/castle_floor.jpg", stage_w/2, stage_h/2)
	level1_background:toBack( )

	level2_background = display.newImage( universe[2], "assets/backgrounds/castle_floor_2.jpg", stage_w/2, stage_h/2)
	level2_background:toBack( )

	level3_background = display.newImage( universe[3], "assets/backgrounds/grass.jpg", stage_w/2, stage_h/2)
	level3_background:toBack( )
	
	-- call the function to create the display objects in the specified room number
	createObjectsInRoom(1,roomdetails_1)
	scoreDisplay:toFront( )
	scoreTextDisplay:toFront( )
	livesDisplay:toFront( )
	livesTextDisplay:toFront( )
	btnReset:toFront( )
	
	timer.performWithDelay( 1000, MagesAttack, 0 )
	timer.performWithDelay( 100, checkMagicCollision, 0)
end

onStart()


return universe[1]