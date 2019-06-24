--[[
    file created just to add requires tags in an attempt to modularize
]]
--library to allow virtual resolutions
push = require("lib/push")
--library to allow OOP
Class = require("lib/class")

require("src/constants")

require("src/StateMachine")

require("src/states/BaseState")
require("src/states/StartState")
