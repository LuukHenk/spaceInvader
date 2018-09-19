
function game.pauseStatus(keys, status)
	if	   love.keyboard.isDown(keys.up)   and status == 'resume' then return 'quit'
	elseif love.keyboard.isDown(keys.up)   and status == 'quit'   then return 'resume'
	elseif love.keyboard.isDown(keys.down) and status == 'resume' then return 'quit'
	elseif love.keyboard.isDown(keys.down) and status	== 'quit'   then return 'resume'
	end
end

function game.pauseAction(keys, status)
		if     love.keyboard.isDown(keys.enter) and status == 'quit'   then return 'mainMenu'
		elseif love.keyboard.isDown(keys.enter) and status == 'resume' then return 'game'
		end
end
