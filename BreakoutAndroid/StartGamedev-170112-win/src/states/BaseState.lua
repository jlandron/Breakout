--[[this is the base state for all other states, difinitions of methods start here
create new states by inheriting methods from this baseState
]]--

BaseState = Class{}

function BaseState:init()end
function BaseState:enter()end
function BaseState:exit()end
function BaseState:update( dt )end
function BaseState:render()end