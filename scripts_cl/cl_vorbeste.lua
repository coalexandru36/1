Citizen.CreateThread(function()
  local ticks = 1000
  while true do
      local t = 0
      local activePly = GetActivePlayers()
      for _, i in pairs(activePly)  do
          if NetworkIsPlayerTalking(i) then
            ticks = 1
              local ped = GetPlayerPed(i)
              if selfPed ~= PlayerPedId() then
                local coords = GetEntityCoords(ped) + vector3(0.0, 0.0, -1.0)
                ticks = 1
                DrawMarker(27, coords, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 68,85,90, 150)
              end
          end
      end
      Wait(ticks)
      ticks = 1000
  end
end)