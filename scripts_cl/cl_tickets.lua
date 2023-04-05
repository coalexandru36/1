RegisterNetEvent('utdHud:getInfo')
AddEventHandler('utdHud:getInfo',function(infoData,amount)
	SendNUIMessage({
		act = 'setMoney',
		type = infoData or '',
		val = amount or 0
	})
end)
