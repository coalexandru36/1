-- Script made by JayJax aka Black Book --

local ishurt = false
Enabled = true
HealthEnabled = true -- You can decide one or off..
HealthRatio = 150 -- 100 up to 200.
HealthRatioextreme = 120 -- Extreme ratio
EnableAnimation = true -- Some other fucking messed up shit to fuck people more up...
StaminaEnabled = true -- You can decide on or off..
StaminaFuckyness = true -- Welp not sure what this does yet...
StaminaDefaultRatio = 0.9 -- Default ratio
StaminaRatio = 0.1 -- 0.0 up to 1.0... I guess??
ShakeEnabled = true -- Enable shake effects
DisableDrops = true -- This way you disable drops of ammo and weapons when player is dead...
DistableRadio = false -- Enabling/Disabling of car radios..
EnableCrouch = true
EnableHandsup = true
EnablePointing = true

-- The movement mechanics
CreateThread(function()
	while true do
		Wait(150)
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		
		if Enabled then
			if HealthEnabled then
				if GetEntityHealth(PlayerPedId()) <= HealthRatio and GetEntityHealth(PlayerPedId()) > HealthRatioextreme then
					setHurt()
					
					if StaminaEnabled then
						StaminaMechanicsOn()
					end
					
					SetCamEffect(1)
				elseif GetEntityHealth(PlayerPedId()) <= HealthRatioextreme then
					setHurtExtreme()
					
					if StaminaEnabled then
						StaminaMechanicsOn()
					end
					
					SetCamEffect(2)
				elseif ishurt and GetEntityHealth(PlayerPedId()) > HealthRatio then
					setNotHurt()
					
					if StaminaEnabled then
						StaminaMechanicsOff()
					end
					
					SetCamEffect(0)
					if ishurt then
						return
					end
				end
			end
		end
	end
end)

-- Functions
-- Do not touch unless you actually know the fuck you are doing...
function setHurt()
	RequestAnimSet("move_m@injured")
	SetPedMovementClipset(PlayerPedId(), "move_m@injured", true)
	
	-- Other elements
	if EnableAnimation then
		SetPedMotionBlur(PlayerPedId(), true)
		SetPedIsDrunk(PlayerPedId(), true)
	end
	ishurt = true
end

function setHurtExtreme()	
	RequestAnimSet("move_m@injured")
	SetPedMovementClipset(PlayerPedId(), "move_m@injured", true)
	
	-- Other elements
	if EnableAnimation then
		SetPedMotionBlur(PlayerPedId(), true)
		SetPedIsDrunk(PlayerPedId(), true)
		SetTimecycleModifier("damage")
	end
	ishurt = true
end

function setNotHurt()	
	ResetPedMovementClipset(PlayerPedId())
	ResetPedWeaponMovementClipset(PlayerPedId())
	ResetPedStrafeClipset(PlayerPedId())

	-- Other elements
	if EnableAnimation then
		SetPedMotionBlur(PlayerPedId(), false)
		SetPedIsDrunk(PlayerPedId(), false)
		ClearTimecycleModifier()
	end
	ishurt = false
end

function StaminaMechanicsOn()
	RestorePlayerStamina(PlayerPedId(), StaminaRatio)
	
	-- Other elements
	if EnableAnimation then
		if ShakeEnabled then
			ShakeCam(GetRenderingCam(), 'DRUNK_SHAKE', 0)
		end
	end
end

function StaminaMechanicsOff()
	RestorePlayerStamina(PlayerPedId(), StaminaDefaultRatio)
	
	-- Other elements
	if EnableAnimation then
		if ShakeEnabled then
			ShakeCam(GetRenderingCam(), 'DRUNK_SHAKE', 1)
		end
	end
end