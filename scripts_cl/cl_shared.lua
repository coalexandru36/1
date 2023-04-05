--[[local getLocalPed = PlayerPedId
local getECoords = GetEntityCoords
local yieldThread = Wait

--local cachedPed = 0xff

PlayerPedId() = getLocalPed()
_PLAYERCOORDS = getECoords(PlayerPedId())

local updateGlobalVariables = function()
    while 1 do
        PlayerPedId() = getLocalPed()
        _PLAYERCOORDS = getECoords(PlayerPedId())
        yieldThread(430)
    end
end

CreateThread(updateGlobalVariables)--]]

