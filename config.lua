-------------------------------------------------------------------------
--------------------     Author 'Emotion#7958'     ----------------------
-------------------------------------------------------------------------

Config = {}

Config.Defaultlang = "de" 

Config.Transitions = true -- If you want a transition
Config.Key = 0x760A9C6F -- You can change the Prompt key here
Config.PriceToGuarma = 2 -- Set the Price to Guarma
Config.PriceForReturn = 0 -- Set the Price For Return

Config.TravelToGuarma = {
    {        
        name = "Travel To Guarma", -- Blip name
        blip = true, -- True if you want a blip, false if not
        sprite = -1018164873, -- Blip sprite
        npcmodel = "loansharking_horsechase1_males_01", 
        scenario = "WORLD_HUMAN_SMOKE", -- Scenario for NPC if you don't want to use it do false
        pos = vector4(-1165.46, -1943.78, 41.39, 27.24), -- For the NPC, Blip and the Prompt
        spawn = vector4(1272.01, -6855.57, 43.37, 239.37)
    },
}

Config.BackToMainland = {
    {
        name = "Back To Mainland",
        blip = true,
        sprite = -1018164873,
        npcmodel = "loansharking_horsechase1_males_01",
        scenario = "WORLD_HUMAN_SMOKE", 
        pos = vector4(1265.77, -6852.12, 42.37, 227.31),
        spawn = vector4(2792.2, -1501.17, 42.67, 33.56)
    }, 
}

-------------------------------------------------------------------------
-------------------------------   End    --------------------------------
-------------------------------------------------------------------------