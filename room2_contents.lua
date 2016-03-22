----------------------------------------------------------------------------------------
-- Castle Crawler
-- room2_contents.lua

-- Peter Zorzonello
-- CSC255 - Programming for Games
-- December 14,2014

-- code that will be used to draw the second level. 
-- table of tables containing object types and their locations in a 2D array
-----------------------------------------------------------------------------------------
local room2_contents = 
	{
		{row=7,col=11,type="rock"},
		{row=7,col=10,type="rock"},
		{row=7,col=8,type="rock"},
		{row=6,col=8,type="rock"},
		{row=5,col=8,type="rock"},
		{row=4,col=8,type="rock"},
		{row=3,col=8,type="rock"},
		{row=0,col=8,type="rock"},
		{row=0,col=10,type="rock"},
		{row=1,col=10,type="rock"},

		{row=0,col=0,type="heart"},
		
		{row=4,col=8,type="rock"},
		{row=5,col=4,type="rock"},
		{row=5,col=5,type="rock"},
		{row=5,col=6,type="rock"},
		{row=5,col=7,type="rock"},
		{row=4,col=10,type="rock"},
		{row=2,col=5,type="rock"},

		{row=7,col=0,type="mageUp"},
		{row=4,col=11,type="mageUp"},
		{row=0,col=1,type="mageDown"},
		{row=0,col=9,type="mageDown"},

		{row=7,col=9,type="castle"},

		{row=0,col=11,type="coin"},
		{row=2,col=4,type="coin"},
		{row=1,col=0,type="coin"},
		{row=2,col=0,type="coin"},

		{row=1,col=8,type="hole"},
		{row=2,col=8,type="hole"},
		{row=6,col=9,type="hole"},

		{row=6,col=10,type="pushable"},
		{row=3,col=10,type="pushable"},
		{row=6,col=3,type="pushable"},
		{row=6,col=1,type="pushable"},
		{row=3,col=4,type="pushable"},
		{row=1,col=4,type="pushable"},
		{row=1,col=5,type="pushable"},
		{row=2,col=6,type="pushable"}
	}
return room2_contents