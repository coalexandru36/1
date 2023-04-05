CreateThread(function()
	Wait(10000)

	local injuredWalking = false

	if not HasAnimSetLoaded("move_m@injured") then
		RequestAnimSet("move_m@injured")
	end

	while true do

		if GetEntityHealth(_GPED) <= 130 then
			SetPedMovementClipset(_GPED, "move_m@injured", 0.2)
			injuredWalking = true
		elseif injuredWalking then
			injuredWalking = false
			ResetPedMovementClipset(_GPED)
		end

		Wait(2000)
	end
end)

local targetedPed, targetedPlayer = 0, 0

CreateThread(function()
	local runOnce = true
	local hoursToShow = -1
	local tied = false
	local targetId = nil
	while true do
		Wait(100)
		while targetedPlayer ~= 0 do
			if runOnce then
				targetId = GetPlayerServerId(targetedPlayer)
				vRPserver.getUserHours({targetId}, function(hours)
					hoursToShow = hours
				end)
				runOnce = false
			end
			if hoursToShow ~= -1 then
				if hoursToShow < 25 then
					local x, y, z = table.unpack(GetEntityCoords(targetedPed))
					DrawText3D(x, y, z+0.4, "Jucatorul nu are 25 ore jucate", 0.5)
				end
			end
			Wait(1)
		end
		tied = false
		hoursToShow = -1
		runOnce = true
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(300)
		local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
		if aiming then
			if DoesEntityExist(targetPed) and IsEntityAPed(targetPed) then
				if targetedPed ~= targetPed then
					for _, player in pairs(GetActivePlayers()) do
						if GetPlayerPed(player) == targetPed then
							targetedPed = targetPed
							targetedPlayer = player
							break
						end
					end
				end
			end
		else
			targetedPed, targetedPlayer = 0, 0
		end
	end
end)