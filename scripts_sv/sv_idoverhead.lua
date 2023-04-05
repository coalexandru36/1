AddEventHandler("vRP:playerSpawn", function(user_id, source, fs)
    if fs then
        Wait(1000)
        Player(source).state.user_id = user_id
    end
end)

AddEventHandler("vRP:playerLeave", function(_, source)
    if Player(source).state.user_id then
        Player(source).state.user_id = nil
    end
end)