Camera = require 'lib/hump/camera'
Class = require 'lib/hump/class'
Gamestate = require 'lib/hump/gamestate'
Signals = require 'lib/hump/signal'
Timer = require 'lib/hump/timer'
vector = require 'lib/hump/vector'

require 'lib/util'

actions = {'update', 'draw', 'keypressed', 'keyreleased', 'mousepressed', 'mousereleased', 'sakujo', 'quit'}

require 'states/game'

require 'class/collide-component'
require 'class/control-component'
require 'class/draw-component'
require 'class/player-control-component'
require 'class/entity'
require 'class/entity-manager'
require 'class/player'
Player:boot()