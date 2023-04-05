playersWhoLeft = {}
RegisterNetEvent("addDeadPlayer")
AddEventHandler("addDeadPlayer",function(id,reason,x,y,z)
    playersWhoLeft[id] = {bool = true,reason = reason,x=x,y=y,z=z}
    --print(id,reason,x,y,z)
    SetTimeout(30000,function()
        playersWhoLeft[id] = nil
    end)
end)
local function DrawLeaveText(x,y,z, text, scl, font) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
  
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
      SetTextScale(0.0*scale, 1.1*scale)
      SetTextFont(4)
      SetTextProportional(1)
      -- SetTextScale(0.0, 0.55)
      SetTextColour(255, 0, 0, 255)
      SetTextDropshadow(0, 0, 0, 0, 255)
      SetTextEdge(2, 0, 0, 0, 150)
      SetTextDropShadow()
      SetTextOutline()
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      DrawText(_x,_y)
    end
  end
Citizen.CreateThread(function()
    while true do
        for k,v in pairs(playersWhoLeft)do
            if Vdist(GetEntityCoords(PlayerPedId()),playersWhoLeft[k].x,playersWhoLeft[k].y,playersWhoLeft[k].z) <= 25.0 then
                if playersWhoLeft[k].bool then
                    DrawLeaveText(playersWhoLeft[k].x,playersWhoLeft[k].y,playersWhoLeft[k].z,playersWhoLeft[k].reason,1.0,0)
                end
            end
        end
        Wait(0)

    end
end)