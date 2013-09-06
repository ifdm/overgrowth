overgrowth
==========

IFDM Capstone Game.

- - - 

Style Guide
-----------

### Editor
Set your text editor to indent using tabs.  The tab width should be 2.  As a general rule, indentation used to indent functional code blocks should use tabs, and any indentation used to visually align any text should use spaces.  Example:

	[1] if not moving then
	[2] 	speed = 0
	[3] 	player:decelerate()
	[4] 	      :lerpFunction(fxnBounce)
	[5] 	      :setDuration(350)
	[6] end

Lines 1, 2, 3, and 6 would use exclusively tabs.  Lines 4 and 5 would use one initial tab, followed by spaces to align the colons.

### Comments
When using single line comments, type `--`, followed by a single space, followed by the comment.  Any comment that is not a line of code should have a blank newline above it.  Example:

	function dance()
		
		-- Time to get down and dirty.
		door:open()
		player:getOnFloor()
		-- with('all', 'walkTheDinosaur')
	end

Comment headers may be used to section off larger files or group related variables and functions.  Comment headers are similar to normal comments, except they have sixteen hyphens above and below them:

	----------------
	-- Meta Info
	----------------
	slot = belt
	material = leather
	
	----------------
	-- Stats
	----------------
	str = 4
	stam = 4