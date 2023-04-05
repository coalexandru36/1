local anuntWaiting = false;
RegisterNetEvent('CNN:anuntPost')
AddEventHandler('CNN:anuntPost',function(data)
    local src = source;
    local user_id = vRP.getUserId(src);
    if not user_id then return end;
    if not src then return end;
    if not data then return end;
    if not anuntWaiting then
        if data == 'comercial' then
            vRP.prompt(src, "Anunt Comercial", "", function(player, value)
                value = tostring(value)
                if string.len(value) >= 15 and string.len(value) <= 100 then
                    if vRP.tryPayment(user_id,500) then
                        --local phoneNumber = getPlayerNumber(user_id);
                        TriggerClientEvent('showAnunt:post', -1, "comercial",value, Player(player).state.number)
                     --   vRPclient.notify(src, {'Anuntul a fost dat cu succes!'});
                    else
                        return vRPclient.notify(src, {"Nu ai destui bani pentru a putea da un anunt!"});
                    end
                else
                    return vRPclient.notify(src,{"Anuntul trebuie sa aiba peste 15 caractere."})
                end
            end)
        elseif data == 'eveniment' then
            vRP.prompt(src, "Anunt Eveniment", "", function(player, value)
                value = tostring(value)
                if string.len(value) >= 15 and string.len(value) <= 100 then
                    if vRP.tryPayment(user_id,500) then
                        -- local phoneNumber = getPlayerNumber(user_id);
                        TriggerClientEvent('showAnunt:post', -1, "event", value, Player(player).state.number)
                      --  vRPclient.notify(src,{'Anuntul a fost dat cu succes, ai platit 500$!'});
                    else
                        return vRPclient.notify(src, {"Nu ai destui bani pentru a putea da un anunt!"});
                    end
                else
                    return vRPclient.notify(src, {"Anuntul trebuie sa aiba peste 15 caractere."})
                end
            end)
        elseif data == 'darkweb' then
            vRP.prompt(src, "Dark-Web", "", function(player, value)
                value = tostring(value)
                if string.len(value) >= 15 and string.len(value) <= 100 then
                    if vRP.tryPayment(user_id,650) then
                        -- local phoneNumber = getPlayerNumber(user_id);
                        TriggerClientEvent('showAnunt:post', -1, "darkweb", value, Player(player).state.number)
                     --   vRPclient.notify(src, {'Anuntul a fost dat cu succes, ai platit 650$!'});
                    else
                       return vRPclient.notify(src, {"Nu ai destui bani pentru a putea da un anunt!"});
                    end
                else
                    return vRPclient.notify(src,{"Anuntul trebuie sa aiba peste 15 caractere."})
                end
            end)
        end
    else
       return vRPclient.notify(src,{"Nu poti da un anunt in acest moment."})
    end

    anuntWaiting = true;
    SetTimeout(30000,function()
        anuntWaiting = false;
    end)
end)