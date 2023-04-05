RegisterNetEvent('showAnunt:post')
AddEventHandler('showAnunt:post',function(tip, anunt, phoneNumber)
    if anunt then
        SendNUIMessage({
            announcement = tip,
            annSenderphone = phoneNumber,
            annMessage = anunt
        })
    end
end)