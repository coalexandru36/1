--- DO NOT EDIT THIS
local holstered = true

-- RESTRICTED PEDS --
-- I've only listed peds that have a remote speaker mic, but any ped listed here will do the animations.
local skins = {

}

-- Add/remove weapon hashes here to be added for holster checks.
-- Add/remove weapon hashes here to be added for holster checks.
local weapons = {
	"WEAPON_PISTOL",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_MACHINEPISTOL",
	"weapon_carbinerifle", 
	"weapon_specialcarbine",
	"weapon_stungun_mp",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_FLAREGUN",
	"WEAPON_STUNGUN",
	"WEAPON_REVOLVER",
	"WEAPON_DOUBLEACTION",
	"WEAPON_MG",
	"WEAPON_ASSAULTRIFLE",			
}
-- https://runtime.fivem.net/doc/natives/#_0x0A6DB4965674D243
-- RADIO ANIMATIONS --


-- HOLD WEAPON HOLSTER ANIMATION --


-- HOLSTER/UNHOLSTER PISTOL --
 
 Citizen.CreateThread(function()
	ticks = 1000
	while true do	
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) and GetPedParachuteState(ped) == -1 then
			loadAnimDict( "reaction@intimidation@1h" )
			loadAnimDict( "weapons@pistol_1h@gang" )
			if CheckWeapon(ped) then
				if holstered then
					ticks = 1	
					TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
					DisablePlayerFiring(GetPlayerPed(-1), true)
					Citizen.Wait(2500)
					DisablePlayerFiring(GetPlayerPed(-1), false)
					ClearPedTasks(ped)
					holstered = false
				end
			elseif not CheckWeapon(ped) then
				if not holstered then
					TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
					DisablePlayerFiring(GetPlayerPed(-1), true)
					Citizen.Wait(1500)
					DisablePlayerFiring(GetPlayerPed(-1), false)			
					ClearPedTasks(ped)

					holstered = true
				end
			end
		end
		Citizen.Wait(ticks)
        ticks = 1000
	end
end)

function CheckWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

function DisableActions(ped)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)
	DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, true) -- Disable weapon firing
end

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end
