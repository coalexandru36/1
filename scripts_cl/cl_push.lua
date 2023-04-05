local Config = {
	DamageNeeded = 90000.0,
	MaxWidth = 5.0,
	MaxHeight = 5.0,
	MaxLength = 5.0
}

local Keys = {
	["LEFTSHIFT"] = 21, ["E"] = 38, ["A"] = 34, ["D"] = 9
}

local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)


local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

local function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

local function GetVehicles()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end 

local function GetClosestVehicle()
	local closestDistance = -1
	local closestVehicle  = -1
	local playerPed 	  = _GPED
	local coords          = GetEntityCoords(playerPed)
	local vehicles 		  = GetVehicles()

	for i = 1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance      = #(coords - vehicleCoords)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end

	return closestVehicle, closestDistance
end


local Vehicle = {Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil}
CreateThread(function()
    Wait(200)
    while true do
        local ped = _GPED

        if not IsPedInAnyVehicle(ped, false) and not IsPedFalling(ped) then
            local closestVehicle, Distance = GetClosestVehicle()
            local vehicleCoords = GetEntityCoords(closestVehicle)
            local dimension = GetModelDimensions(GetEntityModel(closestVehicle), First, Second)
            if Distance < 6.0 then
                Vehicle.Coords = vehicleCoords
                Vehicle.Dimensions = dimension
                Vehicle.Vehicle = closestVehicle
                Vehicle.Distance = Distance
                local pcd = GetEntityCoords(ped)
                if #((GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle)) - pcd) > #((GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1) - pcd) then
                    Vehicle.IsInFront = false
                else
                    Vehicle.IsInFront = true
                end
            else
                Vehicle = {Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil}
            end
        else
            Vehicle = {Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil}
        end
        Wait(500)
    end
end)

CreateThread(function()
    while true do
        Wait(500)
        while Vehicle.Vehicle do
            local ped = _GPED
            local health = GetEntityHealth(ped)
            if health >= 150.0 then

                if IsControlPressed(0, Keys["LEFTSHIFT"]) and IsVehicleSeatFree(Vehicle.Vehicle, -1) and not IsEntityAttachedToEntity(ped, Vehicle.Vehicle) and IsControlJustPressed(0, Keys["E"])  and GetVehicleEngineHealth(Vehicle.Vehicle) <= Config.DamageNeeded then
                    NetworkRequestControlOfEntity(Vehicle.Vehicle)
                    local coords = GetEntityCoords(ped)
                    if Vehicle.IsInFront then
                        AttachEntityToEntity(ped, Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y * -1 + 0.1 , Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
                    else
                        AttachEntityToEntity(ped, Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y - 0.3, Vehicle.Dimensions.z  + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
                    end

    				if not HasAnimDictLoaded('missfinale_c2ig_11') then
    					RequestAnimDict('missfinale_c2ig_11')

    					while not HasAnimDictLoaded('missfinale_c2ig_11') do
    						Wait(1)
    					end
    				end
                    TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
                    Wait(200)

                    local currentVehicle = Vehicle.Vehicle
                     while true do
                        Wait(5)
                        if IsDisabledControlPressed(0, Keys["A"]) then
                            TaskVehicleTempAction(ped, currentVehicle, 11, 1000)
                        end

                        if IsDisabledControlPressed(0, Keys["D"]) then
                            TaskVehicleTempAction(ped, currentVehicle, 10, 1000)
                        end

                        if Vehicle.IsInFront then
                            SetVehicleForwardSpeed(currentVehicle, -1.0)
                        else
                            SetVehicleForwardSpeed(currentVehicle, 1.0)
                        end

                        if HasEntityCollidedWithAnything(currentVehicle) then
                            SetVehicleOnGroundProperly(currentVehicle)
                        end

                        if not IsDisabledControlPressed(0, Keys["E"]) then
                            DetachEntity(ped, false, false)
                            StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
                            FreezeEntityPosition(ped, false)
                            break
                        end
                    end
                end
            end
            Wait(1)
        end
    end
end)

