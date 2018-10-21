settings = {}
settings.text = {}
local previousKey = nil

--audio
local masterVolume = 10
local previousMasterVolume = nil

function settings.settingsAction(currentKey, graph, settingsStatus)
	if currentKey ~= previousKey then
		if settingsStatus == 'audio' then

			if currentKey	== graph.keybinds.left and masterVolume > 0 then
				masterVolume = masterVolume - 1
			end

			if currentKey	== graph.keybinds.right and masterVolume < 10 then
				masterVolume = masterVolume + 1
			end

			if masterVolume ~= previousMasterVolume then settings.setVolume(graph) end
		end
		previousKey = currentKey
	end

	return settings.text
end

--audio
function settings.setVolume(graph)
	setObjectVolumes(masterVolume, graph.objects)
	graph.gameMusic:setVolume(graph.gameMusicVol * (masterVolume / 10))
	settings.text['volume'] = generateVolumeText(masterVolume, graph)
	previousMasterVolume = masterVolume
end

function setObjectVolumes(master, objects)
	for _, object in pairs(objects) do
		object.fireSound:setVolume(object.fireSoundVol * (master / 10))
		object.dieSound:setVolume(object.dieSoundVol * (master / 10))
	end
end

function generateVolumeText(masterVolume, graph)
	local volumeText = {}
	volumeText.mode = 'volume'
	volumeText.str  = tostring(masterVolume)
	volumeText.size = 40
	volumeText.x    = 'center'
	volumeText.y    = 360
	return volumeText
end

return settings
