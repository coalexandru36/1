local idsState = false;
local function drawTxt3d(x,y,z, text, r,g,b,font) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px,py,pz)-vector3(x,y,z))
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    local font = font or 0
   
    if onScreen then
        if not useCustomScale then
            SetTextScale(0.0*scale, 0.55*scale)
        else 
            SetTextScale(0.0*scale, customScale)
        end
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 100)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
local delay = 0
RegisterCommand("togIDs", function(...)
    if GetGameTimer() < delay then
        tvRP.notify("Trebuie sa mai astepti inca ~r~"..math.floor((delay - GetGameTimer()) / 1000).." secunde~w~.")
        return
    end

    idsState = not idsState;
    delay = GetGameTimer() + 5000
    if idsState then
        tvRP.executeCommand("me ~w~Aceasta persoana isi pune mana la ochi~s~")
        tvRP.executeCommand("e facepalm4")
        while idsState do
            if not idsState then
                break
            end

            for _, id in ipairs(GetActivePlayers()) do
                if id ~= _GPLAYER then
                    local sId = GetPlayerServerId(id)
                    local ped = GetPlayerPed(id)
                    local coords = GetEntityCoords(ped)

                    local dist = #(_GCOORDS - coords)
                    if dist <= 15.0 then
                        local user_id = Player(sId).state.user_id
                        if NetworkIsPlayerTalking(id) then
                            drawTxt3d(coords.x, coords.y, coords.z + 1.0, user_id, 144, 215, 255, 0)
                            DrawMarker(0, coords.x, coords.y, coords.z + 1.1, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 0.05, 255, 255, 255, 150);
                        else
                            drawTxt3d(coords.x, coords.y, coords.z + 1.0, user_id, 255, 255, 255, 0)
                        end
                    end
                end
            end
            Citizen.Wait(1)
        end
    else
        tvRP.executeCommand("me ~w~Aceasta persoana isi ia mana de la ochi~s~")
        tvRP.executeCommand("e c")
    end


end, false)

RegisterKeyMapping('togIDs', 'Afiseaza id-ul jucatorilor', 'keyboard', 'DELETE')



function tvRP.executeCommand(cmd)
    if not cmd then return end;
    ExecuteCommand(cmd);
end;
