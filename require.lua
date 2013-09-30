Camera = require 'lib/hump/camera'
Class = require 'lib/hump/class'
Gamestate = require 'lib/hump/gamestate'
Signals = require 'lib/hump/signal'
Timer = require 'lib/hump/timer'
vector = require 'lib/hump/vector'

require 'lib/util'

-- Globals :)
actions = {'update', 'draw', 'keypressed', 'keyreleased', 'mousepressed', 'mousereleased', 'sakujo', 'quit'}

require "data/world"

require 'states/game'

require 'class/control-component'
require 'class/draw-component'
require 'class/physics-component'

require 'class/entity'
require 'class/entity-manager'

require 'class/player'
require 'class/player-control-component'
require 'class/player-draw-component'
require 'class/player-physics-component'
Player:boot()

require 'class/wall'
require 'class/wall-draw-component'
Wall:boot()

require 'class/seed'
require 'class/seed-draw-component'
require 'class/seed-physics-component'
Seed:boot()
