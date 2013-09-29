Camera = require 'lib/hump/camera'
Class = require 'lib/hump/class'
Gamestate = require 'lib/hump/gamestate'
Signals = require 'lib/hump/signal'
Timer = require 'lib/hump/timer'
vector = require 'lib/hump/vector'

require 'lib/util'

require 'states/game'

require 'class/collideable'
require 'class/controllable'
require 'class/drawable'
require 'class/player-controllable'
require 'class/entity'
require 'class/entity-manager'
require 'class/player'
Player:boot()