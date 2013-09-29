Camera = require 'lib/hump/camera'
Class = require 'lib/hump/class'
Gamestate = require 'lib/hump/gamestate'
Signals = require 'lib/hump/signal'
Timer = require 'lib/hump/timer'
vector = require 'lib/hump/vector'

require 'lib/util'

-- Globals :)
actions = {'update', 'draw', 'keypressed', 'keyreleased', 'mousepressed', 'mousereleased', 'sakujo', 'quit'}
unitSize = 32

require 'states/game'

require 'class/control-component'
require 'class/draw-component'
require 'class/physics-component'

require 'class/entity'
require 'class/entity-manager'

require 'class/player'
require 'class/player-control-component'
Player:boot()