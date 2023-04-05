CreateThread(function()
  Wait(1000)
  RegisterFontFile('wmk')
  RegisterFontFile('Montserrat')
end)

CreateThread(function()
  while true do
    local pcMin = GlobalState.minute
    local pcSec = GlobalState.secunde
    local paydayformat = ("%02dm %02ds"):format(pcMin, pcSec)
    if pcMin <= 0 then paydayformat = ("%02d sec"):format(pcSec) end;
    SendNUIMessage({
      act = "setMoney",
      type = "payday",
      payday = paydayformat
    })
    Wait(1000)
  end
end)