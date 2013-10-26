Overgrowth
----------

IFDM Capstone Game.

- - - 

Submodules
----------
We are using submodules to hold assets.  Currently, we have 2 submodules: [overgrowth-art](http://github.com/ifdm/overgrowth-art) (`/media/art`) and [overgrowth-levels](http://github.com/ifdm/overgrowth-levels) (`/levels`).  To grab changes from submodules, do:

	git submodule update

Also, do not make changes to any submodule directories.  Instead, make changes to the appropriate repository, commit the changes, and pull the changes into the main repository using `git submodule update`.