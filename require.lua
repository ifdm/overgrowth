Camera = require 'lib/hump/camera'
Class = require 'lib/hump/class'
Gamestate = require 'lib/hump/gamestate'
Signals = require 'lib/hump/signal'
Timer = require 'lib/hump/timer'
vector = require 'lib/hump/vector'

require 'lib/util'

require 'data/world'
require 'states/game'

io.load('class')

Player:boot()
Wall:boot()
Mushroom:boot()

require 'editor/editor'