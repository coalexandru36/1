function tvRP.setSponsorSkin(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end
	SetPlayerModel(PlayerId(), model)
end

function tvRP.teleportOutOfSponsorCar(theVehicle)
	local pos = GetEntityCoords(theVehicle, true)
	SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z+1.0)
end

function tvRP.deleteSponsorCar()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		DeleteVehicle(GetVehiclePedIsUsing(PlayerPedId()))
	end
end

---- Rainbow Masina ----
local isRainbowActivated = false

function tvRP.setRainbowCar()
	isRainbowActivated = not isRainbowActivated
	Citizen.CreateThread(function()
		local function RGBRainbow(frequency)
			local result = {}
			local curtime = GetGameTimer() / 1000
	
			result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
			result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
			result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)
	
			return result
		end
		while true do
			if isRainbowActivated then
				local rainbow = RGBRainbow(0.80)
				if IsPedInAnyVehicle(PlayerPedId(), true) then
					local veh = GetVehiclePedIsUsing(PlayerPedId())
					SetVehicleCustomPrimaryColour(veh, rainbow.r, rainbow.g, rainbow.b)
					SetVehicleCustomSecondaryColour(veh, rainbow.r, rainbow.g, rainbow.b)
					SetVehicleNeonLightsColour(veh, rainbow.r, rainbow.g, rainbow.b)
					SetVehicleNeonLightEnabled(veh,0,true)
					SetVehicleNeonLightEnabled(veh,1,true)
					SetVehicleNeonLightEnabled(veh,2,true)
					SetVehicleNeonLightEnabled(veh,3,true)
				else
					isRainbowActivated = false
				end
			else
				break
			end
			Wait(0)
		end
	end)
end
---- Rainbow Masina ----

---- SkyFall ----
local isSkyfall = false

function tvRP.startSkyFall()
	if not isSkyfall then
		isSkyfall = true
		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local playerPos = GetEntityCoords(playerPed)
			GiveWeaponToPed(playerPed, GetHashKey("gadget_parachute"), 1, true, true)
			DoScreenFadeOut(3000)
			while(not IsScreenFadedOut())do
				Wait(0)
			end
			SetEntityCoords(playerPed, playerPos.x, playerPos.y, playerPos.z + 500.0)
			DoScreenFadeIn(2000)
			Wait(2000)
			tvRP.notify("Skyfall ~g~Activat")
			SetPlayerInvincible(playerPed, true)
			SetEntityProofs(playerPed, true, true, true, true, true, false, 0, false)
			while true do
				if isSkyfall then
					if IsPedInParachuteFreeFall(playerPed) and not HasEntityCollidedWithAnything(playerPed) then
						ApplyForceToEntity(playerPed, true, 0.0, 200.0, 2.5, 0.0, 0.0, 0.0, false, true, false, false, false, true)
					else
						isSkyfall = false
					end
				else
					break
				end
				Wait(0)
			end
			RemoveWeaponFromPed(playerPed, GetHashKey("gadget_parachute"))
			Wait(3000)
			SetPlayerInvincible(playerPed, false)
			SetEntityProofs(playerPed, false, false, false, false, false, false, 0, false)
		end)
	end
end
---- SkyFall ----

local cooldownCarWash = false
RegisterNetEvent('washTheCar',function()
	local ped = PlayerPedId()
	if not cooldownCarWash then
		cooldownCarWash = true
    	if IsPedInAnyVehicle(ped) then
    	    local veh = GetVehiclePedIsIn(ped, false)
    	    if veh then
    	        SetVehicleDirtLevel(veh, 0.0)
    	        TriggerEvent("chatMessage", "^2Succes: ^0Ti-ai curatat rabla!")
    	    else
    	        TriggerEvent("chatMessage", "^1Error: ^0Nu te aflii in nicio masina!")
    	    end
    	else
    	    TriggerEvent("chatMessage", "^1Error: ^0Nu te aflii in nicio masina!")
    	end
		Wait(10000)
		cooldownCarWash = false
	else
		TriggerEvent("chatMessage", "^1Error: ^0Asteapta cateva secunde pentru a folosi utilitatea din nou!")
	end
end)

local rainbowveh = false
local neoanerainbow = false
local luminirainbow = false
local fumColorat = false
local speed = 5.00
local speedlumini = 0.25
local speedFum = 2.00
function RGBRainbow(frequency)
    local result = {}
    local curtime = GetGameTimer() / 1000
    
    result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
    result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
    result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)
    
    return result
end
RegisterNetEvent("toggleRainbowVehicle")
RegisterNetEvent("toggleRainbowNeon")
RegisterNetEvent("toggleRainbowLumini")
RegisterNetEvent("toggleRainbowTyres")
AddEventHandler("toggleRainbowVehicle", function()
    if (rainbowveh == true) then
        rainbowveh = false
        tvRP.notify("Masina Rainbow: ~r~OFF")
    else
        rainbowveh = true
        tvRP.notify("Masina Rainbow: ~g~ON")
        while rainbowveh do
            local rainbow = RGBRainbow(2)
            if IsPedInAnyVehicle(PlayerPedId(), true) and rainbowveh then
                veh = GetVehiclePedIsUsing(PlayerPedId())
                SetVehicleCustomPrimaryColour(veh, rainbow.r, rainbow.g, rainbow.b)
                SetVehicleCustomSecondaryColour(veh, rainbow.r, rainbow.g, rainbow.b)
            else
                rainbowveh = false
                break
            end
            Wait(1)
        end
    end
end)

AddEventHandler("toggleRainbowNeon", function()
    if (neoanerainbow == true) then
        neoanerainbow = false
        tvRP.notify("Neoane Rainbow: ~r~OFF")
    else
        neoanerainbow = true
        tvRP.notify("Neoane Rainbow: ~g~ON")
        while neoanerainbow do
            local rainbow = RGBRainbow(2)
            if IsPedInAnyVehicle(PlayerPedId(), true) and neoanerainbow then
                veh = GetVehiclePedIsUsing(PlayerPedId())
                SetVehicleNeonLightsColour(veh, rainbow.r, rainbow.g, rainbow.b)
                SetVehicleNeonLightsColour(veh, rainbow.r, rainbow.g, rainbow.b)
            else
                neoanerainbow = false
                break
            end
            Wait(1)
        end
    end
end)

AddEventHandler("toggleRainbowLumini", function()
    if (luminirainbow == true) then
        luminirainbow = false
        ToggleVehicleMod(veh, 22, false)
        tvRP.notify("Lumini Rainbow: ~r~OFF")
    else
        luminirainbow = true
        ToggleVehicleMod(veh, 22, true)
        tvRP.notify("Lumini Rainbow: ~g~ON")
        while luminirainbow do
            local rainbow = RGBRainbow(2)
            if IsPedInAnyVehicle(PlayerPedId(), true) and luminirainbow then
                veh = GetVehiclePedIsUsing(PlayerPedId())
                for i = 1, 12 do
                    SetVehicleXenonLightsColour(veh, i)
                    Wait(500)
                end
            else
                luminirainbow = false
                break
            end
            Wait(1)
        end
    end
end)

AddEventHandler("toggleRainbowTyres", function()
    if (fumColorat == true) then
        fumColorat = false
        tvRP.notify("Fum Colorat: ~r~OFF")
    else
        fumColorat = true
        tvRP.notify("Fum Colorat: ~g~ON")
        while fumColorat do
            local rainbow = RGBRainbow(2)
            if IsPedInAnyVehicle(PlayerPedId(), true) and fumColorat then
                veh = GetVehiclePedIsUsing(PlayerPedId())
                SetVehicleModKit(veh, 0)
                ToggleVehicleMod(veh, 20, true)
                SetVehicleTyreSmokeColor(veh, rainbow.r, rainbow.g, rainbow.b)
                SetVehicleTyreSmokeColor(veh, rainbow.r, rainbow.g, rainbow.b)
            else
                fumColorat = false
                break
            end
            Wait(1)
        end
    end
end)