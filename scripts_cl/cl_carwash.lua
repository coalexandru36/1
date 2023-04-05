local vehicleWashStation = {
	vector3(26.5906,-1392.0261,27.3634),
	vector3(170.58941650391,-1718.6125488281,27.2916),
	vector3(-74.5693,6427.8715,29.4400),
	vector3(-700.07843017578,-932.45861816406,17.0139)
}

local fontsLoaded = false
local fontId
CreateThread(function()
  Wait(1000)
  RegisterFontFile('wmk')
  fontId = RegisterFontId('Freedom Font')
  fontsLoaded = true
end)

CreateThread(function ()
	local ticks = 1000
	for i = 1, #vehicleWashStation do
		garageCoords = vehicleWashStation[i]
		stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		ticks = 1
		SetBlipSprite(stationBlip, 100) -- 100 = carwash
		SetBlipAsShortRange(stationBlip, true)

		Wait(ticks)
		ticks = 1000
	end
    return
end)

CreateThread(function ()
	while true do
		while _GVEHICLE ~= 0 do
			for i = 1, #vehicleWashStation do
				local washStation = vehicleWashStation[i]
				local dist = #(_GCOORDS - washStation)
				while dist <= 5 do
					DrawMarker(1, washStation[1], washStation[2], washStation[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 1.5, 0, 134, 255, 255, 0, 0, 2, 0, 0, 0, 0)
					if dist <= 2.5 then
						carwashdraw(0.51, 0.85, 0,0, 0.55, "~w~Apasa ~b~E ~w~pentru a curata ~b~Masina", 255, 255, 255, 230, 1, 2, 1)
						if(IsControlJustPressed(1, 38)) then
							DoScreenFadeOut(500)
							SetTimeout(500, function()
								TriggerServerEvent('carwash:checkmoney', GetVehicleDirtLevel(_GVEHICLE))	
								SetTimeout(1000, function()
                    	    		DoScreenFadeIn(100)
								end)
							end)
						end
					end
					dist = #(_GCOORDS - washStation)
					Wait(1)
				end
			end
			Wait(750)
		end
		Wait(1500)
	end
end)

RegisterNetEvent('carwash:success')
AddEventHandler('carwash:success', function()
	SetVehicleDirtLevel(GetVehiclePedIsIn(PlayerPedId(),false), 0.0)
	SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId(),false), false)
	tvRP.notify("~w~Ai curatat masina cu succes ~g~(500 lei)~w~")
end)

RegisterNetEvent('carwash:notenough')
AddEventHandler('carwash:notenough', function()
	tvRP.notify("~w~Nu ai destui bani la tine")
end)

RegisterNetEvent('carwash:alreadyclean')
AddEventHandler('carwash:alreadyclean', function()
	tvRP.notify("~w~Masina este deja spalata")
end)

function carwashdraw(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextCentre(center)
	if(outline)then
	  SetTextOutline()
	end
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/1, y - height/1 + 0.002)
  end