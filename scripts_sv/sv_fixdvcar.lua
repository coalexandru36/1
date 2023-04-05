AddEventHandler('chatMessage', function(source, name, msg)
	local user_id = vRP.getUserId(source)
	if msg == "/fix" or msg == "/fixmasina" or msg == "/FIX" then
		if vRP.isUserHelper(user_id)then
			CancelEvent()
			TriggerClientEvent("murtaza:fix", source)
		else
			CancelEvent()
		end
	elseif msg == "/dv" or msg == "/de" or msg == "/DV" or msg == "/DE" then
		CancelEvent()
		TriggerClientEvent("wk:deleteVehicle", source)
	end
end)