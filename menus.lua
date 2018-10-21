local menus = {}
local previousKey = nil

function menus.settingsStatus(currentKey, keybind, status)
	if previousKey ~= currentKey then
		if     currentKey	== keybind.up   and status == 'audio'    then status = 'quit'
		elseif currentKey == keybind.up   and status == 'video'    then status = 'audio'
		elseif currentKey == keybind.up   and status == 'keybinds' then status = 'video'
		elseif currentKey == keybind.up   and status == 'quit'     then status = 'keybinds'
		elseif currentKey == keybind.down	and status == 'quit'     then status = 'audio'
		elseif currentKey == keybind.down and status == 'keybinds' then status = 'quit'
		elseif currentKey == keybind.down and status == 'video'    then status = 'keybinds'
		elseif currentKey == keybind.down and status == 'audio'    then status = 'video'
		end
	end
	return status
end

function menus.settingsAction(currentKey, keybind, previousScreenStatus, status)
	local	screenStatus = 'settingsScreen'
	if previousKey ~= currentKey then
		if currentKey == keybind.enter and status == 'quit' then screenStatus = previousScreenStatus end
		previousKey = currentKey
	end
	return screenStatus
end
function menus.pauseStatus(currentKey, keybind, status)
	if previousKey ~= currentKey then
		if     currentKey	== keybind.up   and status == 'quit'     then status = 'settings'
		elseif currentKey == keybind.up   and status == 'resume'	 then status = 'quit'
		elseif currentKey == keybind.up   and status == 'settings' then status = 'resume'
		elseif currentKey == keybind.down	and status == 'quit'     then status = 'resume'
		elseif currentKey == keybind.down and status == 'settings' then status = 'quit'
		elseif currentKey == keybind.down and status == 'resume'   then status = 'settings'
		end
	end
	return status
end

function menus.pauseAction(currentKey, keybind, status)
	local	screenStatus = 'pauseScreen'
	if previousKey ~= currentKey then
		if     currentKey == keybind.enter and status == 'quit'     then screenStatus = 'mainScreen'
		elseif currentKey == keybind.enter and status == 'settings' then screenStatus = 'settingsScreen'
		elseif currentKey == keybind.enter and status == 'resume'   then screenStatus = 'gameScreen'
		end
		previousKey = currentKey
	end
	return screenStatus
end

function menus.mainStatus(currentKey, keybind, status)
	if previousKey ~= currentKey then
		if		 currentKey == keybind.up		and status == 'play'     then status = 'quit'
		elseif currentKey == keybind.up		and status == 'settings' then status = 'play'
		elseif currentKey == keybind.up		and status == 'quit'     then status = 'settings'
		elseif currentKey == keybind.down and status == 'play'     then status = 'settings'
		elseif currentKey == keybind.down and status == 'settings' then status = 'quit'
		elseif currentKey == keybind.down and status == 'quit'     then status = 'play' end
	end
	return status
end

function menus.mainAction(currentKey, keybind, status)
	local	screenStatus = 'mainScreen'
	if previousKey ~= currentKey then
		if     currentKey == keybind.enter and status == 'play'     then screenStatus = 'gameScreen'
		elseif currentKey == keybind.enter and status == 'settings' then screenStatus = 'settingsScreen'
		elseif currentKey == keybind.enter and status == 'quit'     then screenStatus = 'quitGame'
		end
		previousKey = currentKey
	end
	return screenStatus
end

return menus
