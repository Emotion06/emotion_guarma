local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

-------------------------------------------------------------------------
--------------------------   Ticket Guarma    ---------------------------
-------------------------------------------------------------------------

RegisterServerEvent('emotion:ticketbuytoguarma')
AddEventHandler("emotion:ticketbuytoguarma", function()
    local User = VorpCore.getUser(source)
    local _source = source
    local Character = User.getUsedCharacter
    local _ticket = Config.PriceToGuarma
    Character.removeCurrency(0, _ticket)

end)

-------------------------------------------------------------------------
-------------------------   Ticket Mainland    --------------------------
-------------------------------------------------------------------------

RegisterServerEvent('emotion:ticketbuytomainland')
AddEventHandler("emotion:ticketbuytomainland", function()
    local User = VorpCore.getUser(source)
    local _source = source
    local Character = User.getUsedCharacter
    local _ticket = Config.PriceForReturn
    Character.removeCurrency(0, _ticket)

end)

-------------------------------------------------------------------------
-------------------------------   End    --------------------------------
-------------------------------------------------------------------------

--This handles the version check
local versioner = exports['bcc-versioner'].initiate()
local repo = 'https://github.com/Emotion06/emotion_guarma'
versioner.checkRelease(GetCurrentResourceName(), repo)