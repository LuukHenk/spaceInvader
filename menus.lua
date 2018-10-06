local menus = {}
local previousKey = nil

function menus.pauseStatus(currentKey, keybind, status)
	if previousKey ~= currentKey then
		if currentKey			== keybind.up and status == 'resume' then status = 'quit'
		elseif currentKey == keybind.up and status == 'quit' then status = 'resume'
		elseif currentKey == keybind.down	and status == 'quit' then status = 'resume'
		elseif currentKey == keybind.down and status == 'resume' then status = 'quit' end
	end
	return status
end

function menus.pauseAction(currentKey, keybind, status)
	local	screenStatus = 'pauseScreen'
	if previousKey ~= currentKey then
		if     currentKey == keybind.enter and status == 'quit'   then screenStatus = 'mainScreen'
		elseif currentKey == keybind.enter and status == 'resume' then screenStatus = 'gameScreen'
		end
		previousKey = currentKey
	end
	return screenStatus
end

function menus.mainStatus(currentKey, keybind, status)
	if previousKey ~= currentKey then
		if		 currentKey == keybind.up		and status == 'play'     then status = 'exit'
		elseif currentKey == keybind.up		and status == 'settings' then status = 'play'
		elseif currentKey == keybind.up		and status == 'exit'     then status = 'settings'
		elseif currentKey == keybind.down and status == 'play'     then status = 'settings'
		elseif currentKey == keybind.down and status == 'settings' then status = 'exit'
		elseif currentKey == keybind.down and status == 'exit'     then status = 'play' end
	end
	return status
end

function menus.mainAction(currentKey, keybind, status)
	local	screenStatus = 'mainScreen'
	if previousKey ~= currentKey then
		if     currentKey == keybind.enter and status == 'play'     then screenStatus = 'gameScreen'
		elseif currentKey == keybind.enter and status == 'settings' then screenStatus = 'settingsScreen'
		elseif currentKey == keybind.enter and status == 'exit'     then screenStatus = 'quitGame'
		end
		previousKey = currentKey
	end
	return screenStatus
end

return menus
