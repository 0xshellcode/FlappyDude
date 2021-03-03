InitScreenState = Class{__includes = BaseState}

function InitScreenState:update(dt)
    if love.keyboard.wasPressed('space') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function InitScreenState:render()
    love.graphics.setFont(dudeFont)
    love.graphics.printf('It is...', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Please Press Space to Start', 0, 100, VIRTUAL_WIDTH, 'center')
end