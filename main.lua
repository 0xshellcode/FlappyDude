push = require 'push' -- Load by default the push.lua
Class = require 'Class' -- Class handler


-- Getting our external class

require 'Dude'
require 'Pipe'
require 'PipePair'


-- all code related to game state and state machines
require 'StateMachine'
require 'gameStates/BaseState'
require 'gameStates/PlayState'
require 'gameStates/ScoreState'
require 'gameStates/InitScreenState'

-- Defining constansts

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Addapt resolution to our graphics

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288


local background = love.graphics.newImage('resources/images/background.jpg')
local backgroundScroll = 0

local ground = love.graphics.newImage('resources/images/cyberGround.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60 -- Twice than the brackgound
local BACKGROUND_LOOPING_POINT = 1387  -- in the x axis
local GROUND_LOOPING_POINT = 514

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('CyberDude')

    -- Cool Fonts

    smallFont = love.graphics.newFont('resources/fonts/Cybrpnuk2.ttf', 8)
    mediumFont = love.graphics.newFont('resources/fonts/Cybrpnuk2.ttf', 14)
    dudeFont = love.graphics.newFont('resources/fonts/Cybrpnuk2.ttf', 28)
    hugeFont = love.graphics.newFont('resources/fonts/Cybrpnuk2.ttf', 56)
    love.graphics.setFont(dudeFont)

    -- Loading our table of sounds
    sounds = {
        ['music'] = love.audio.newSource('resources/sounds/wednesdayFinale.mp3', 'static'),
        ['jump'] = love.audio.newSource('resources/sounds/jump.wav', 'static'),
        ['die'] = love.audio.newSource('resources/sounds/die.wav', 'static'),
        ['ouch'] = love.audio.newSource('resources/sounds/Aaahh.wav', 'static'),
        ['score'] = love.audio.newSource('resources/sounds/score.wav', 'static')
        
    }

        -- Background music
        sounds['music']:setLooping(true)
        sounds['music']:play()


    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- initialize state machine with all state-returning functions
    gStateMachine = StateMachine {
        ['title'] = function() return InitScreenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    gStateMachine:change('title')

    -- initialize input table
    love.keyboard.keysPressed = {}
end

-- Resize our screen thanks to push, by taking care of dynamically rescaling the canvas that we are using internally

function love.resize(w, h)
    push:resize(w, h)
end



function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
    
    if key == 'escape' then -- To exit
        love.event.quit()
    end
end

-- Check if the global input table where activated by any pressed key

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    -- Parallax update
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) %  BACKGROUND_LOOPING_POINT -- dt for frame rate independent, reset the image thaks to the modulo result
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % GROUND_LOOPING_POINT -- Same thing for the ground

     -- Init our game state machine
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    -- draw state machine between the background and ground, which defers
    -- render logic to the currently active state
    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    
    push:finish()
end
