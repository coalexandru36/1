vRP = Proxy.getInterface("vRP")

CreateThread(function()
    local ticks = 1000
    while true do
        ticks = 1
        HideHudComponentThisFrame(1)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)

        Wait(ticks)
        ticks = 1000
    end
end)