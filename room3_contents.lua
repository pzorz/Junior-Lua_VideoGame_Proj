----------------------------------------------------------------------------------------
-- Castle Crawler
-- room3_contents.lua

-- Peter Zorzonello
-- CSC255 - Programming for Games
-- December 14,2014

-- code that will be used to draw the third level. 
-- table of tables containing object types and their locations in a 2D array
-----------------------------------------------------------------------------------------
local room3_contents = 
	{

	{row=6,col=0,type="rock"},
	{row=7,col=0,type="rock"},
	{row=5,col=1,type="rock"},
	{row=6,col=1,type="rock"},
	{row=7,col=1,type="rock"},
	{row=1,col=1,type="rock"},
	{row=1,col=9,type="rock"},
	{row=2,col=9,type="rock"},
	{row=3,col=9,type="rock"},
	{row=4,col=9,type="rock"},
	{row=5,col=9,type="rock"},
	{row=7,col=9,type="rock"},
	{row=2,col=11,type="rock"},
	{row=3,col=11,type="rock"},
	{row=4,col=1,type="rock"},

	{row=1,col=1,type="rock"},
	{row=6,col=0,type="rock"},
	{row=3,col=11,type="rock"},
	{row=1,col=9,type="rock"},

	{row=0,col=9,type="hole"},
	{row=7,col=10,type="hole"},
	{row=6,col=11,type="hole"},
	{row=3,col=7,type="hole"},
	{row=4,col=7,type="hole"},

	{row=1,col=0,type="pushable"},
	{row=2,col=1,type="pushable"},
	{row=3,col=3,type="pushable"},
	{row=8,col=5,type="pushable"},
	{row=1,col=10,type="pushable"},

	{row=3,col=1,type="tree"},
	{row=0,col=3,type="tree"},
	{row=2,col=3,type="tree"},
	{row=5,col=3,type="tree"},
	{row=7,col=3,type="tree"},
	{row=0,col=7,type="tree"},
	{row=2,col=7,type="tree"},
	{row=5,col=7,type="tree"},
	{row=7,col=7,type="tree"},

	{row=2,col=5,type="coin"},
	{row=3,col=4,type="coin"},
	{row=3,col=6,type="coin"},
	{row=4,col=5,type="coin"},

	{row=7,col=11,type="heart"},
	{row=3,col=5,type="fountain"},

	{row=5,col=0,type="switch"},


	}

return room3_contents