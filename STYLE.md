Style Guide
-----------

### Little Things
- Avoid unnecessary whitespace.
- (Almost) always have a blank line above a return.
- Always use single quotes.  Because they're classy and stuff.
- Every mathematical operator should be surrounded by spaces.
- `if`'s hardly ever need parentheses.
- Filenames should always consist of lowercase letters.  If you *really* need a filename with multiple words, use hyphens.
- Variables are camelCased, not StudlyCased or snake_cased.
- Classes are StudlyCased, not camelCased or snake_cased.

### Editor
Set your text editor to indent using tabs.  I hate tabs too, but it makes things easier when working on a collaborative project.  As a general rule, indentation used to indent functional code blocks should use tabs, and any indentation used to visually align any text should use spaces.  Example:

	[1] if not moving then
	[2] 	speed = 0
	[3] 	player:decelerate()
	[4] 	      :lerpFunction(fxnBounce)
	[5] 	      :setDuration(350)
	[6] end

Lines 1, 2, 3, and 6 would use exclusively tabs.  Lines 4 and 5 would use one initial tab, followed by spaces to align the colons.

### Comments
When using single line comments, type `--`, followed by a single space, followed by the comment.  Any comment that is not a line of code should have a blank newline above it.  Example:

```lua
	function dance()
		
		-- Time to get down and dirty.
		door:open()
		player:getOnFloor()
		-- with('all', 'walkTheDinosaur')
	end
```

Comment headers may be used to section off larger files or group related variables and functions.  Comment headers are similar to normal comments, except they have sixteen hyphens above and below them:

```lua
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
```

### Commits
When committing, the first line of the commit should be a brief description of changes.  Changes should be separated by semicolons, and the line should not exceed 50 characters.  Vim will automatically color code the first 50 characters of a git commit message.  Follow this brief description by a blank line, then a more detailed description of what has changed (if applicable).
