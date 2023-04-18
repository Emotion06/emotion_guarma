local TravelToGuarma
local TravelToMainland
local buttons_prompt = GetRandomIntInRange(0, 0xffffff)
local buttons_prompt2 = GetRandomIntInRange(0, 0xffffff)

-------------------------------------------------------------------------
------------------------------    Prompts    ----------------------------
-------------------------------------------------------------------------

function Button_Prompt()

    Citizen.CreateThread(function()
        local str = _U("traveltoguarma")
        TravelToGuarma = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(TravelToGuarma, Config.Key)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(TravelToGuarma, str)
        PromptSetEnabled(TravelToGuarma, true)
        PromptSetVisible(TravelToGuarma, true)
        PromptSetHoldMode(TravelToGuarma, true)
        PromptSetGroup(TravelToGuarma, buttons_prompt)
        PromptRegisterEnd(TravelToGuarma)
    end)
end

function Button_Prompt2()

    Citizen.CreateThread(function()
        local str = _U("traveltomainland")
        TravelToMainland = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(TravelToMainland, Config.Key)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(TravelToMainland, str)
        PromptSetEnabled(TravelToMainland, true)
        PromptSetVisible(TravelToMainland, true)
        PromptSetHoldMode(TravelToMainland, true)
        PromptSetGroup(TravelToMainland, buttons_prompt2)
        PromptRegisterEnd(TravelToMainland)
    end)
end

-------------------------------------------------------------------------
-----------------------------    TP Guarma    ---------------------------
-------------------------------------------------------------------------

Citizen.CreateThread(function()
    Button_Prompt()
	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(PlayerPedId())
        local chance = math.random(1,5)
        local diceroll = chance
        local spawnroll = diceroll
        for i, v in pairs(Config.TravelToGuarma) do
            if (Vdist(coords.x, coords.y, coords.z, v.pos.x, v.pos.y, v.pos.z) < 2.0) then
                local TravelToGuarma = CreateVarString(10, 'LITERAL_STRING', _U("traveltoguarmaprice"))
                PromptSetActiveGroupThisFrame(buttons_prompt, TravelToGuarma)
                if IsControlJustReleased(0, Config.Key) then
                    local player = PlayerPedId()
                    local Ped = PlayerPedId()
                    TriggerServerEvent('emotion:ticketbuytoguarma')
                    TriggerEvent("vorp:TipBottom", _U("travelto"), 5000)
                    FreezeEntityPosition(Ped,true) -- Freeze person
                    if Config.Transitions == true then ExecuteCommand('hud') end
                    if Config.Transitions == true then DoScreenFadeOut(3000) end
                    Wait(3000)
                    SetEntityCoords(Ped, 2524.167, -1839.067, 44.93) -- Boat Transition area 
                    if Config.Transitions == true then DoScreenFadeIn(500) end
                    if Config.Transitions == true then Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, _U("toguarmatitle"), _U("toguarmasubtitle"), _U("toguarmamessage")) end
                        Citizen.InvokeNative(0xA657EC9DBC6CC900, 1935063277) -- Native setting Minimap by hash, can be either Guarma or World
                        Citizen.InvokeNative(0xE8770EE02AEE45C2, 1) -- Set Guarma Water Type
                        Citizen.InvokeNative(0x74E2261D2A66849A, true) -- Set Guarma Horizon Status
                        Wait(20000)  
                    if spawnroll then
                        SetEntityCoords(Ped, v.spawn.x, v.spawn.y, v.spawn.z, v.spawn.h)
                    end
                        FreezeEntityPosition(Ped,false) -- Unfreeze person
                    if Config.Transitions == true then DoScreenFadeOut(1000) end
                        Wait(900)
                    if Config.Transitions == true then ShutdownLoadingScreen() end
                        Wait(500)
                    if Config.Transitions == true then DoScreenFadeIn(4000) end
                    if Config.Transitions == true then ExecuteCommand('hud') end
                        guarma = true
                end
            end
        end
    end
end)

-------------------------------------------------------------------------
----------------------------    TP Mainland    --------------------------
-------------------------------------------------------------------------

Citizen.CreateThread(function()
    Button_Prompt2()
	while true do
	Citizen.Wait(1)
	local coords = GetEntityCoords(PlayerPedId())
        local chance = math.random(1,5)
        local diceroll = chance
        local spawnroll = diceroll
        for i, v in pairs(Config.BackToMainland) do
            if (Vdist(coords.x, coords.y, coords.z, v.pos.x, v.pos.y, v.pos.z) < 2.0) then
                local BackToMainland = CreateVarString(10, 'LITERAL_STRING', _U("traveltomainlandprice"))
                PromptSetActiveGroupThisFrame(buttons_prompt2, BackToMainland) 
                if IsControlJustReleased(0, Config.Key) then
                    local player = PlayerPedId()
                    local Ped = PlayerPedId()
                        TriggerServerEvent('emotion:ticketbuytomainland')
                        TriggerEvent("vorp:TipBottom", _U("travelfrom"), 5000)
                    if Config.Transitions == true then ExecuteCommand('hud') end
                    if Config.Transitions == true then DoScreenFadeOut(3000) end
                        FreezeEntityPosition(Ped,true)
                        Wait(3000)
                    if Config.Transitions == true then DoScreenFadeIn(500) end
            if Config.Transitions == true then Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, _U("tomainlandtitle"), _U("tomainlandsubtitle"), _U("tomainlandmessage")) end
                        Citizen.InvokeNative(0x74E2261D2A66849A, 0)
                        Citizen.InvokeNative(0xA657EC9DBC6CC900, -1868977180)
                        Citizen.InvokeNative(0xE8770EE02AEE45C2, 0)
                        SetEntityCoords(Ped, 2534.975, -1835.944, 41.93) -- Boat Transition Area 
                        Wait(20000)
                    if spawnroll then
                        SetEntityCoords(Ped, v.spawn.x, v.spawn.y, v.spawn.z, v.spawn.h)
                    end
                    if Config.Transitions == true then DoScreenFadeIn(4000) end
                    if Config.Transitions == true then ShutdownLoadingScreen() end
                        FreezeEntityPosition(Ped,false)
                        Wait(1000)
                    if Config.Transitions == true then ExecuteCommand('hud') end
                        guarma = false
                end
            end
        end
    end
end)

-------------------------------------------------------------------------
--------------------------------    NPC    ------------------------------
-------------------------------------------------------------------------

function LoadModel(model)
    local model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
    end
end

Citizen.CreateThread(function()
    while true do
        for _, npc in pairs(Config.TravelToGuarma) do
            local pcoords = GetEntityCoords(PlayerPedId())
            local dist = GetDistanceBetweenCoords(pcoords, npc.pos.x, npc.pos.y, npc.pos.z, 1)

            if dist < 180 and not DoesEntityExist(npc.NPC) then
                LoadModel(npc.npcmodel)
                local npc_ped = CreatePed(npc.npcmodel, npc.pos, false, true, true, true)
                Citizen.InvokeNative(0x283978A15512B2FE, npc_ped, true)

                if npc.scenario then
                    TaskStartScenarioInPlace(npc_ped, GetHashKey(npc.scenario), 0, true, false, false, false)
                end

                SetEntityCanBeDamaged(npc_ped, false)
                SetEntityInvincible(npc_ped, true)
                FreezeEntityPosition(npc_ped, true)
                SetBlockingOfNonTemporaryEvents(npc_ped, true)
                SetModelAsNoLongerNeeded(npc.npcmodel)
                SetEntityAsMissionEntity(npc_ped, true, true)

                npc.NPC = npc_ped

            elseif dist > 180 and DoesEntityExist(npc.NPC) then
                DeleteEntity(npc.NPC)
            end
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        for _, npc in pairs(Config.BackToMainland) do
            local pcoords = GetEntityCoords(PlayerPedId())
            local dist = GetDistanceBetweenCoords(pcoords, npc.pos.x, npc.pos.y, npc.pos.z, 1)

            if dist < 180 and not DoesEntityExist(npc.NPC) then
                LoadModel(npc.npcmodel)
                local npc_ped = CreatePed(npc.npcmodel, npc.pos, false, true, true, true)
                Citizen.InvokeNative(0x283978A15512B2FE, npc_ped, true)

                if npc.scenario then
                    TaskStartScenarioInPlace(npc_ped, GetHashKey(npc.scenario), 0, true, false, false, false)
                end

                SetEntityCanBeDamaged(npc_ped, false)
                SetEntityInvincible(npc_ped, true)
                FreezeEntityPosition(npc_ped, true)
                SetBlockingOfNonTemporaryEvents(npc_ped, true)
                SetModelAsNoLongerNeeded(npc.npcmodel)
                SetEntityAsMissionEntity(npc_ped, true, true)

                npc.NPC = npc_ped

            elseif dist > 180 and DoesEntityExist(npc.NPC) then
                DeleteEntity(npc.NPC)
            end
        end
        Citizen.Wait(500)
    end
end)

-------------------------------------------------------------------------
--------------------------------    Blip    -----------------------------
-------------------------------------------------------------------------

for i, v in pairs(Config.TravelToGuarma) do
    if v.blip then
        BalloonBlip = N_0x554d9d53f696d002(1664425300, v.pos.x, v.pos.y, v.pos.z)
        SetBlipSprite(BalloonBlip, v.sprite, 1)
        SetBlipScale(BalloonBlip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, BalloonBlip, v.name)
    end
end 

for i, v in pairs(Config.BackToMainland) do
    if v.blip then
        BalloonBlip = N_0x554d9d53f696d002(1664425300, v.pos.x, v.pos.y, v.pos.z)
        SetBlipSprite(BalloonBlip, v.sprite, 1)
        SetBlipScale(BalloonBlip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, BalloonBlip, v.name)
    end
end 

-------------------------------------------------------------------------
----------------------------   Water Fix    -----------------------------
------------------------------------------------------------------------- 

function SetGuarmaWorldhorizonActive(toggle)
	Citizen.InvokeNative(0x74E2261D2A66849A , toggle)
end

function SetWorldWaterType(waterType)
	Citizen.InvokeNative(0xE8770EE02AEE45C2, waterType)
end

function SetWorldMapType(mapType)
	Citizen.InvokeNative(0xA657EC9DBC6CC900, mapType)
end

function IsInGuarma()
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
	return x >= 0 and y <= -4096
end

local GuarmaMode = false

CreateThread(function()
	while true do
		Wait(500)

		if IsInGuarma() then
			if not GuarmaMode then
				SetGuarmaWorldhorizonActive(true);
				SetWorldWaterType(1);
				SetWorldMapType(`guarma`)
				GuarmaMode = true
			end
		else
			if GuarmaMode then
				SetGuarmaWorldhorizonActive(false);
				SetWorldWaterType(0);
				SetWorldMapType(`world`)
				GuarmaMode = false
			end
		end
	end
end)

-------------------------------------------------------------------------
-------------------------------   End    --------------------------------
-------------------------------------------------------------------------

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for i, v in pairs(Config.TravelToGuarma) do
        if v.NPC then
            DeleteEntity(v.NPC)
            DeletePed(v.NPC)
        end
        if v.blip then
            RemoveBlip(BalloonBlip)
        end
    end
    for i, v in pairs(Config.BackToMainland) do
        if v.NPC then
            DeleteEntity(v.NPC)
            DeletePed(v.NPC)
        end
        if v.blip then
            RemoveBlip(BalloonBlip)
        end
    end
end)