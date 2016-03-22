----------------------------------------------------------------------------------------
-- Castle Crawler
-- room1_contents.lua

-- Peter Zorzonello
-- CSC255 - Programming for Games
-- December 14,2014

-- code that will be used to draw the first level. 
-- table of tables containing object types and their locations in a 2D array
-----------------------------------------------------------------------------------------
local room1_contents = 
	{
		{row=7,col=0,type="rock"},
		{row=7,col=1,type="rock"},
		{row=7,col=2,type="rock"},
		{row=7,col=3,type="rock"},
		{row=7,col=4,type="rock"},
		{row=7,col=5,type="rock"},
		{row=7,col=6,type="rock"},
		{row=7,col=7,type="rock"},
		{row=7,col=8,type="rock"},
		{row=7,col=9,type="rock"},
		{row=7,col=10,type="rock"},
		{row=7,col=11,type="rock"},
		{row=0,col=0,type="rock"},
		{row=0,col=1,type="rock"},
		{row=0,col=2,type="rock"},
		{row=0,col=3,type="rock"},
		{row=0,col=4,type="rock"},
		{row=0,col=5,type="rock"},
		{row=0,col=7,type="rock"},
		{row=0,col=8,type="rock"},
		{row=0,col=9,type="rock"},
		{row=0,col=10,type="rock"},
		{row=0,col=11,type="rock"},
		{row=4,col=4,type="rock"},
		{row=1,col=0,type="rock"},
		{row=1,col=1,type="rock"},
		{row=6,col=4,type="rock"},
		{row=5,col=0,type="rock"},
		{row=5,col=1,type="rock"},
		{row=5,col=3,type="rock"},
		{row=4,col=1,type="rock"},
		{row=4,col=3,type="rock"},
		{row=1,col=3,type="rock"},
		{row=1,col=4,type="rock"},
		{row=2,col=5,type="rock"},
		{row=2,col=6,type="rock"},
		{row=2,col=7,type="rock"},
		{row=2,col=8,type="rock"},
		{row=2,col=9,type="rock"},
		{row=2,col=10,type="rock"},
		{row=3,col=10,type="rock"},
		{row=4,col=10,type="rock"},
		{row=6,col=10,type="rock"},
		{row=6,col=6,type="rock"},
		{row=6,col=7,type="rock"},
		{row=5,col=7,type="rock"},

		{row=1,col=11,type="gBrick"},
		{row=2,col=11,type="gBrick"},
		{row=3,col=11,type="gBrick"},
		{row=4,col=11,type="gBrick"},
		{row=5,col=11,type="gBrick"},
		{row=6,col=11,type="gBrick"},

		{row=4,col=0,type="coin"},
		{row=1,col=2,type="coin"},
		{row=5,col=4,type="coin"},
		{row=3,col=9,type="coin"},

		{row=0,col=6,type="castle"},

		{row=6, col=5,type="switch"},

		{row=6,col=2,type="pushable"},
		{row=5,col=5,type="pushable"},
		{row=3,col=8,type="pushable"},
		{row=5,col=9,type="pushable"},
		{row=4,col=6,type="pushable"},
		{row=1,col=7,type="pushable"},
		{row=5,col=2,type="pushable"}
	}

return room1_contents