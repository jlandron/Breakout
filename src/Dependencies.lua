--[[
    file created just to add requires tags in an attempt to modularize
]]
--library to allow virtual resolutions
push = require('lib/push')
--library to allow OOP
Class = require('lib/class')
--library to add live loading of edited files
--lurker = require('lib/lurker/lurker')
--GUI library
--suit = require('lib/suit')

require('src/constants')

require('src/Paddle')
require('src/Ball')
require('src/Brick')

require('src/StateMachine')

require('src/Util')
require('src/LevelMaker')

require('src/states/BaseState')
require('src/states/StartState')
require('src/states/ServeState')
require('src/states/PlayState')
require('src/states/HighScoreState')
require('src/states/GameOverState')
require('src/states/VictoryState')
require('src/states/EnterHighScoreState')
require('src/states/PaddleSelectState')
