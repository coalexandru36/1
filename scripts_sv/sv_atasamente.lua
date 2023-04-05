
vRP.defInventoryItem("lanterna", "Lanterna", "Este un component de arma!", function(args) 
    local choices = {}	
	choices["Foloseste"] = {function(player,choice,mod)
		local user_id = vRP.getUserId(player)
        if user_id ~= nil then
            vRP.tryGetInventoryItem(user_id, "lanterna", 1, true)
            TriggerClientEvent('add:lanterna', player)
            vRP.closeMenu(player)
        end
    end}
    return choices
end, 0.05)  

vRP.defInventoryItem("surpresor", "Surpresor", "Este un component de arma!", function(args) 
    local choices = {}	
	choices["Foloseste"] = {function(player,choice,mod)
		local user_id = vRP.getUserId(player)
        if user_id ~= nil then 
            vRP.tryGetInventoryItem(user_id, "surpresor", 1, true)
            TriggerClientEvent('add:surpresor', player)
            vRP.closeMenu(player)
        end
    end}
    return choices
end, 0.05)  

vRP.defInventoryItem("grip", "Grip", "Este un component de arma!", function(args) 
    local choices = {}	
	choices["Foloseste"] = {function(player,choice,mod)
		local user_id = vRP.getUserId(player)
        if user_id ~= nil then 
            vRP.tryGetInventoryItem(user_id, "grip", 1, true)
            TriggerClientEvent('add:grip', player)
            vRP.closeMenu(player)
        end
    end}
    return choices
end, 0.05)  

vRP.defInventoryItem("skin", "Skin", "Este un component de arma!", function(args) 
    local choices = {}
	choices["Foloseste"] = {function(player,choice,mod)
		local user_id = vRP.getUserId(player)
        if user_id ~= nil then 
            vRP.tryGetInventoryItem(user_id, "skin", 1, true)
            TriggerClientEvent('add:skin', player)
            vRP.closeMenu(player)
        end
    end}
    return choices
end, 0.05)  