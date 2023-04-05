RegisterNetEvent("murtaza:fix")
AddEventHandler("murtaza:fix", function()
	local playerPed = PlayerPedId()
	if IsPedInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed)
		SetVehicleEngineHealth(vehicle, 9999)
		SetVehiclePetrolTankHealth(vehicle, 9999)
		SetVehicleFixed(vehicle)
	else
	end
end)

local distanceToCheck = 5.0

RegisterNetEvent('wk:deleteVehicle')
AddEventHandler('wk:deleteVehicle', function()
    local ped = PlayerPedId()

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                SetEntityAsMissionEntity( vehicle, true, true )
                DeleteEntity(vehicle)
                DeleteVehicle(vehicle)
                if ( DoesEntityExist( vehicle ) ) then 
                    tvRP.notify("Incearca din nou!")
                else 
                    tvRP.notify("Vehicul sters")
                end 
            else 
                tvRP.notify("Trebuie sa fii la volan")
            end 
        else
            local playerPos = GetEntityCoords( ped, 1 )
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( playerPos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                SetEntityAsMissionEntity( vehicle, true, true )
                DeleteEntity(vehicle)
                DeleteVehicle(vehicle)
                if ( DoesEntityExist( vehicle ) ) then 
                    tvRP.notify("Incearca din nou!")
                else 
                    tvRP.notify("Vehicul sters")
                end 
            else 
                tvRP.notify("Trebuie sa fii la volan")
            end 
        end 
    end 
end )

RegisterNetEvent('murtaza:fix')
AddEventHandler('murtaza:fix', function()
    tvRP.notify("Ai reparat masina")
end)

function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end