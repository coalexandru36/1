-- unfreeze on spawn
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	local player = source
	SetTimeout(15000,function() 
		vRPclient.loadFreeze(player,{false})
	end)
end)