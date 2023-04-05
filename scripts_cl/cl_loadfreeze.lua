local isFrozen = false

function tvRP.loadFreeze(flag)
  isFrozen = flag
  Citizen.CreateThread(function()
    while true do
      if isFrozen then
        SetEntityInvincible(_GPED,true)
        SetEntityVisible(_GPED,false)
        FreezeEntityPosition(_GPED,true)
      else
        SetEntityInvincible(_GPED,false)
        SetEntityVisible(_GPED,true)
        FreezeEntityPosition(_GPED,false)
        break
      end
      Wait(0)
    end
  end)
end