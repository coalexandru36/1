local fontsLoaded = false
local fontId
CreateThread(function()
    Wait(1000)
    RegisterFontFile('wmk')
    fontId = RegisterFontId('Freedom Font')
    fontsLoaded = true
end)

local function drawText(text, x, y, scale, r, g, b)
	SetTextFont(fontId)
	SetTextCentre(1)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextDropShadow(30, 5, 5, 5, 255)
	SetTextEntry("STRING")
	SetTextColour(r, g, b, 255)
	AddTextComponentString(text)
	DrawText(x, y)
end