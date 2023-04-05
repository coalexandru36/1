local levelOfDamageToKillThisBitch = 960.0 

function IsValidVehicle( veh )
    local model = GetEntityModel( veh )

    if ( IsThisModelACar( model ) or IsThisModelABike( model ) or IsThisModelAQuadbike( model ) ) then  
        return true 
    else 
        return false 
    end 
end 

function ManageVehicleDamage()
    local ped = PlayerPedId()

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                local damage = GetVehicleEngineHealth( vehicle )

                if ( damage < levelOfDamageToKillThisBitch and IsValidVehicle( vehicle ) ) then 
                    SetVehicleEngineHealth( vehicle, 300 )
                    SetVehicleEngineOn( vehicle, false, true )
                end 
            end  
        end 
    end 
end 

Citizen.CreateThread( function()
    local ticks = 5000
	while true do 

		if IsPedInAnyVehicle(_GPED) then
			--print('problema')
			ticks = 150
			local vehicle = GetVehiclePedIsIn( _GPED, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == _GPED ) then 
                local damage = GetVehicleEngineHealth( vehicle )
				--print(damage)
			end
			ManageVehicleDamage()
		end
		Citizen.Wait( ticks )
    end 
end )