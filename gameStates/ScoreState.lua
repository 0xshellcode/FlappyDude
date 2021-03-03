ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('space') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
        sounds['music']:setLooping(true)
        sounds['music']:play()
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(dudeFont)
    love.graphics.printf('F in the Chat, You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Space to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end