-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
--Ionis Zones
--Anahera Blade (4 hit): 52
--Tsurumaru (4 hit): 49
--Kogarasumaru (or generic 450 G.katana) (5 hit): 40
--Amanomurakumo/Masamune 437 (5 hit): 46
--
--Non Ionis Zones:
--Anahera Blade (4 hit): 52
--Tsurumaru (5 hit): 24
--Kogarasumaru (5 hit): 40
--Amanomurakumo/Masamune 437 (5 hit): 46
--
--Aftermath sets
-- Koga AM1/AM2 = sets.engaged.Kogarasumaru.AM
-- Koga AM3 = sets.engaged.Kogarasumaru.AM3
-- Amano AM = sets.engaged.Amanomurakumo.AM
-- Using Namas Arrow while using Amano will cancel STPAM set
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
-- Initialization function for this job file.
function get_sets()

-- Load and initialize the include file.

	mote_include_version = 2
	
		include('Mote-Include.lua')
		
		include('organizer-lib')

end

-- Setup vars that are user-independent.

function job_setup()

	get_combat_form()

	--get_combat_weapon()

	update_melee_groups()
    		
    		state.CapacityMode = M(false, 'Capacity Point Mantle')

		state.YoichiAM = M(false, 'Cancel Yoichi AM Mode')

-- list of weaponskills that make better use of otomi helm in low acc situations

	wsList = S{'Tachi: Fudo', 'Tachi: Shoha'}

    	gear.RAarrow = {name="Eminent Arrow"}

    	LugraWSList = S{'Tachi: Fudo', 'Tachi: Shoha', 'Namas Arrow'}
    
    		state.Buff.Sekkanoki = buffactive.sekkanoki or false

    		state.Buff.Sengikori = buffactive.sengikori or false

    		state.Buff['Third Eye'] = buffactive['Third Eye'] or false

    		state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false

end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.

function user_setup()

-- Options: Override default values

	state.OffenseMode:options('Normal', 'Mid', 'Acc')

    	state.HybridMode:options('Normal', 'PDT', 'Reraise')

    	state.WeaponskillMode:options('Normal', 'Mid', 'Acc')

    	state.IdleMode:options('Normal')

    	state.RestingMode:options('Normal')

    	state.PhysicalDefenseMode:options('PDT', 'Reraise')

    	state.MagicalDefenseMode:options('MDT')
    
-- Additional local binds
    	
    	send_command('bind ^[ input /lockstyle on')

    	send_command('bind ![ input /lockstyle off')

    	send_command('bind != gs c toggle CapacityMode')
    
end

-- Called when this job file is unloaded (eg: job change)

function file_unload()
    
	send_command('unbind ^[')

    	send_command('unbind !=')

    	send_command('unbind ![')

end

--[[SC's
Rana > Shoha > Fudo > Kasha > Shoha > Fudo - light
Rana > Shoha > Fudo > Kasha > Rana > Fudo - dark
Kasha > Shoha > Fudo
Fudo > Kasha > Shoha > fudo
Shoha > Fudo > Kasha > Shoha > Fudo
--]]

function init_gear_sets()
    
--------------------------------------
-- Start defining the sets
--------------------------------------
	Hizamaru = {}
		Hizamaru.Head = "Hizamaru Somen +1" 
-- 30 STR. 26 DEX. 38 Acc. 26 Atk. Haste +6%.
		Hizamaru.Body = "Hizamaru Haramaki +1"
-- 37 STR. 33 DEX. 40 Acc. 28 Atk. Haste +4%. 
		Hizamaru.Hands = "Hizamaru Kote +1" 
-- 17 STR. 40 DEX. 37 Acc. 25 Atk. Haste +4%.
		Hizamaru.Legs = "Hizamaru Hizayoroi +1" 
-- 47 STR. 39 Acc. 27 Atk. Haste +9%. WS Dmg +5%.
		Hizamaru.Feet = "Hizamaru Sune-Ate +1" 
-- 25 STR. 28 DEX. 36 Acc. 24 Atk. Haste +3%. 
	Acro = {} 
-- Potential Augments -- Dusk - STR +7~10. DEX +7 WS Dmg +3%. Leaf - STP +6. DA +3%. Haste +3%. WS Acc. +20. Snow - +20 Acc/Atk. +25 Acc. or Atk.
		Acro.Head = "Acro Helm" 
-- 22 STR. 18 DEX. 15 Atk. Haste +3%. STP +3.  
		Acro.Body = "Acro Surcoat" 
-- 25 STR. 20 DEX. 10 Acc. 10 Atk. Haste +3%. DA +2%
		Acro.Hands = "Acro Gauntlets" 
-- 4 STR. 31 DEX.  7 Atk. Haste +4%. STP +4
		Acro.Legs = "Acro Breeches" 
-- 33 STR. 10 Acc. Haste +5%. STP +4.
		Acro.Feet = "Acro Leggings" 
-- 15 STR. 15 DEX. 7 Acc. Haste +3%. DA +2%
	Founders = {}
		Founders.Head = "Founder's Corona" 
-- 24 STR. 30 DEX. 35 Acc. Haste +7%. DA +2%. 
		Founders.Body = "Founder's Breastplate" 
-- 30 STR. 26 DEX. 35 Acc. 35 Atk. Haste +3%. DA +3%.
		Founders.Hands = "Founder's Gauntlets" 
-- 21 STR. 34 DEX. 35 Atk. Haste +4%. DA +2%.
		Founders.Legs = "Founder's Hose" 
-- 40 STR. 35 Atk. Haste +5%. DA +2%.
		Founders.Feet = "Founder's Greaves" 
-- 19 STR. 21 DEX. 35 Acc. Haste +3%. DA +2%.
	Despair = {}
-- Path A. HP +50. VIT +10%. Cure Recieved. +5%. Path B. STR +12. VIT +7. Haste +2%. Path C. 10 Acc. (Pet Stuff).
		Despair.Head = "Despair Helm" 
-- 21 STR. 21 DEX. Acc. +20. Atk. +20. Haste +8%. - Path D. 15 STR. Enmity +7. STP +3.
		Despair.Body = "Despair Mail" 
-- 30 STR. 29 DEX. Acc. +23. Haste +4% - Path D. 25 Atk. M. Eva +20. DA +3%.
		Despair.Hands = "Despair Finger Gauntlets" 
-- 15 STR. 34 DEX. Acc. +18. Atk. +18. Haste +5%. - Path D. R. Acc +25. R. Atk +20. Recycle +10.
		Despair.Legs = "Despair Cuisses" 
-- 34 STR. Atk. +23. Haste +6%. - Path D. 10 AGI. Eva. +20. SB +7.
		Despair.Feet = "Despair	Greaves" 
-- 19 STR. 16 DEX. Acc. +17. Haste +4%. DA +2%. - Path D. 10 DEX.  7 STR. PDT -3%.
	Naga = {}
-- Path A. 10 STR +15 Acc. SB +7. Path B. HP +50. 10 VIT. Eva. +20. Path C. (Pet Stuff).
		Naga.Head = "Naga Somen" 
-- 17 STR. 24 DEX. Acc. +18. Haste +8%. MDT -3%. - Path D. Acc. +15. R. Acc +25. Enmity -6.
		Naga.Body = "Naga Samue" 
-- 29 STR. 30. DEX. Atk. +15. Haste +4%. STP. +5. - Path D. HP +80 10 DEX Atk. +20.
		Naga.Hands = "Naga Tekko" 
-- 16 STR. 36 DEX. Haste. +5%. Dmg -2%. - Path D. (Pet Stuff)
		Naga.Legs = "Naga Hakama" 
-- 37 STR. Haste +6%. Path D. Atk +20. R. Atk +25. Crit +4%.
		Naga.Feet = "Naga Kyahan" 
-- 14 STR. 15 DEX. Acc. +18. Atk +18. Haste +4%. DA +3%. - Path D. (Pet Stuff)
	Rao = {}
-- Path A. Acc. +10 Atk. +10 Eva. +15. Path B. 10 STR. 10 DEX. Atk. +15. Path C. (Pet Stuff).
		Rao.Head = "Rao Kabuto" 
-- 35 STR. 19 DEX. Acc. +32. Haste +8%. Crit +4%. - Path D. 10 VIT. Atk. +20. Counter +3
		Rao.Body = "Rao Togi" 
-- 28 STR. 25 DEX. Acc. +22. Atk. +22. Haste +4%. DA +4%. - Path D. Atk +15. SB +7. PDT -3%.
		Rao.Hands = "Rao Kote" 
-- 14 STR. 34 DEX. Atk. +32. Haste +5%. Counter +4. - Path D. 10 MND. M. Eva. +15. MDT - 3%.
		Rao.Legs = "Rao Haidate" 
-- 45 STR. Atk. +33. Haste +6%. STP +7. - Path D. Acc. +20. DA +3. (Pet stat).
		Rao.Feet = "Rao Sune-Ate" 
-- 17 STR. 25 DEX. Acc. +31. Haste +4%. SB +7. - Path D. HP +50.Crit. +3. DA +2%.
	Ryuo = {}
-- Path A. 10 STR. 10 DEX Acc. +15. Path B. HP +50. Acc +15. Atk. +15. Path C. HP. +50. STP. +4. SB. +7.
		Ryuo.Head = "Ryuo Somen" 
-- 21 STR. 17 DEX. Acc. +25. R. Acc +25. Haste +7%. Enmity -5. STP. +6. - Path D. Ninjutsu Skill +15. M. Acc. +20. M. Atk. +20.
		Ryuo.Body = "Ryuo Domaru" 
-- 28 STR. 24 DEX. Acc. +27. Atk. +27. Haste +3%. Crit +4%. PDT -4%. - Path D. HP +50. STP. +5. DA +2%.
		Ryuo.Hands = "Ryuo Tekko" 
-- 12 STR. 38 DEX. Acc. +23. R. Acc. +23. Haste +4%. Crit +4%. Crit. Dmg. +4%. - Path D. 10 DEX. Acc. +20. DA. +3%.
		Ryuo.Legs = "Ryuo Hakama" 
-- 29 STR. Atk. +23. R. Atk +23. Haste +5%. DA +3%. STP. +7. SC Dmg. +10%. - Path D. Acc. +20. STP. +4. PDT -3%.
		Ryuo.Feet = "Ryuo Sune-Ate" 
-- 26 STR. 19 Dex. Atk. +22. R. Atk. +22. Haste +3%. Zanshin +4. Zanshin: OAT +10%. - Path D. 10 STR. Atk. +20. Crit +3%.
	Valorous = {}
		Valorous.Head = {}
		Valorous.Body = {}
		Valorous.Hands = {}
		Valorous.Legs = {}
		Valorous.Feet = {}	
	Wakido = {}
		Wakido.Head = "Wakido Kabuto +1" 
-- 27 STR. 23 DEX. Atk. +21. Haste +7%. Warding Circle +1. Meditate Duration +4
		Wakido.Body = "Wakido Domaru" 
-- 32 STR. 21 DEX. Acc. +15. STP +7. Haste +3%. Occ. Boosts TP when Damaged.
		Wakido.Hands = "Wakido Kote +1" 
-- 14 STR. 30 DEX. STP +5. Haste +4%. Hasso +2. Enhances effects of Rice Balls.
		Wakido.Legs = "Wakido Haidate +1" 
-- 33 STR. Atk. +20. R. Atk +20. Parry +15. STP +7. Haste +5%.
		Wakido.Feet = "Wakido Sune-Ate +1" 
-- 15 STR. 17 DEX. Acc. +20. Atk +18. R. Acc. +20. R. Atk +18. Haste +3%. Zanshin +3.
	Sakonji = {}
		Sakonji.Head = "Sakonji Kabuto" 
-- 24 STR. 20 DEX. Acc. +17. Atk. +17. R. Acc. +17. R. Atk. +17. Haste +7%. STP +6. Enhances Ikishoten.
		Sakonji.Body = "Sakonji Domaru" 
-- 32 STR. 27 DEX. Acc. +15. Atk. +15. Haste +3%. STP +8. Enhances Overwhelm.
		Sakonji.Hands = "Sakonji Kote +1" 
-- 6 STR. 30 DEX. Acc. +18. Atk. +18. Haste +4%. Meditate Duration +2. PDT -4%. Enhances Blade Bash.
		Sakonji.Legs = "Sakonji Haidate +1" 
-- 33 STR. Atk. +18. Haste +5%. Third Eye Counter +35. Counter Dmg +19. Enhances Shikikoyo.
		Sakonji.Feet = "Sakonji Sune-Ate +1" 
-- 21 STR. 17 DEX. Atk. +23. Haste +3%. STP +8. Enhances Meikyo Shisui.
	Kasuga = {}
		Kasuga.Head = {}
		Kasuga.Body = {}
		Kasuga.Hands = {}
		Kasuga.Legs = {}
		Kasuga.Feet = {}
-- Precast Sets
-- Precast sets to enhance jas

	sets.precast.JA.Meditate = {
head="Wakido Kabuto +1",
hands="Sakonji Kote",
back="Smertrios's Mantle"
}
    
	sets.precast.JA.Seigan = {head="Unkai Kabuto +1"}
    
	sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +1"}
    
	sets.precast.JA['Third Eye'] = {legs="Sakonji Haidate +1"}
    
	sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote"}

-- Waltz set (chr and vit)
    
	sets.precast.Waltz = {}

	--sets.Organizer = {}
	
-- Don't need any special gear for Healing Waltz.

	sets.precast.Waltz['Healing Waltz'] = {}
	sets.CapacityMantle  = {back="Mecistopins Mantle"}
	--sets.Berserker       = {neck="Berserker's Torque"}
	--sets.WSDayBonus      = {head="Gavialis Helm"}

	sets.LugraMoonshade  = {ear1="Brutal Earring", ear2="Moonshade Earring"}
	sets.BrutalMoonshade = {ear1="Brutal Earring", ear2="Moonshade Earring"}
	sets.LugraFlame      = {ear1="Brutal Earring", ear2="Moonshade Earring"}
	sets.FlameFlame      = {ear1="Brutal Earring", ear2="Moonshade Earring"}
       
-- Weaponskill sets
-- Default set for any weaponskill that isn't any more specifically defined

	sets.precast.WS = {
		head={name="Rao Kabuto", augments={'STR+10','DEX+10','Attack+15',}},
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body=" Found. Breastplate",
		hands="Hizamaru Kote +1",
		ring1="Ifrit Ring",
		ring2="Ifrit Ring",
		back="Smertrios's Mantle",
		waist="Fotia Belt",
		legs={name="Rao Haidate", augments={'STR+10','DEX+10','Attack+15',}},
		feet={name="Ryuo Sune-Ate", augments={'STR+10','DEX+10','Accuracy+15'}}
		}

sets.precast.WS.Mid = set_combine(sets.precast.WS, {
})

sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
head="Ryuo Somen",
ear1= "Zennaroi Earring",
ear2= "Digni. Earring",
ring1="Cacoethic Ring",
ring2=" Cacoethic Ring +1",
feet= "Rao Sune-Ate"
})
    
sets.precast.WS['Tachi: Fudo'] = sets.precast.WS
    
sets.precast.WS['Tachi: Fudo'].Mid = sets.precast.WS.Mid
    
sets.precast.WS['Tachi: Fudo'].Acc = sets.precast.WS.Acc
    
sets.precast.WS['Tachi: Shoha'] = sets.precast.WS
    
sets.precast.WS['Tachi: Shoha'].Mid = sets.precast.WS.Mid
    
sets.precast.WS['Tachi: Shoha'].Acc = sets.precast.WS.Acc
    
    
sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {
ear1="Bladeborn Earring",
ear2="Steelflash Earring"
})

sets.precast.WS['Tachi: Rana'].Mid = set_combine(sets.precast.WS.Mid, {
ear1="Bladeborn Earring",
ear2="Steelflash Earring"
})

sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {
ear1="Bladeborn Earring",
ear2="Steelflash Earring"
})

-- CHR Mod
    
sets.precast.WS['Tachi: Ageha'] = sets.precast.WS
    
sets.precast.WS['Tachi: Ageha'].Mid = sets.precast.WS.Mid
    
sets.precast.WS['Tachi: Ageha'].Acc = sets.precast.WS.Acc
    
sets.precast.WS['Tachi: Jinpu'] = sets.precast.WS
    
sets.precast.WS['Tachi: Jinpu'].Mid = sets.precast.WS.Mid
    
sets.precast.WS['Tachi: Jinpu'].Acc = sets.precast.WS.Acc
        
sets.precast.WS['Tachi: Kasha'] = sets.precast.WS
    
sets.precast.WS['Tachi: Kasha'].Mid = sets.precast.WS.Mid
    
sets.precast.WS['Tachi: Kasha'].Acc = sets.precast.WS.Acc

sets.precast.WS['Tachi: Gekko'] = sets.precast.WS
    
sets.precast.WS['Tachi: Gekko'].Mid = sets.precast.WS.Mid
    
sets.precast.WS['Tachi: Gekko'].Acc = sets.precast.WS.Acc

sets.precast.WS['Tachi: Yukikaze'] = sets.precast.WS
    
sets.precast.WS['Tachi: Yukikaze'].Mid = sets.precast.WS.Mid
    
sets.precast.WS['Tachi: Yukikaze'].Acc = sets.precast.WS.Acc
        
--sets.precast.WS['Namas Arrow'] = {}
    
--sets.precast.WS['Namas Arrow'].Mid = {}
    
--sets.precast.WS['Namas Arrow'].Acc = {}
    
sets.precast.WS['Apex Arrow'] = {
head="Ryuo Somen",
neck="Fotia Gorget",
ear1="Hollow Earring",
ear2="Moonshade Earring",
body="Kyujutsugi", - On Mule
hands="Ryuo Tekko",
ring1="Cacoethic Ring",
ring2="Cacoethic Ring +1",
back="Sokolski Mantle",
waist="Fotia Belt",
legs= "Ryuo Hakama",
feet= " Waki. Sune-Ate +1"
}

sets.precast.WS['Apex Arrow'].Mid = sets.precast.WS['Apex Arrow']
	
sets.precast.WS['Apex Arrow'].Acc = sets.precast.WS['Apex Arrow']

-- Midcast Sets
    
sets.midcast.FastRecast = {
}
    
-- Sets to return to when not performing an action.
    
-- Resting sets
    
sets.resting = {
head="",
neck="",
ear1="",
ear2="",
body="",
hands="",
ring1="",
ring2="",
back="",
waist="",
legs="",
feet="”
}
    
sets.idle.Town = {}
   
sets.idle.Town.Adoulin = {}
    
sets.idle.Field = {}
    
sets.idle.Weak = {}
    
sets.idle.Yoichi = {}

sets.idle.Regen = {
head="Rao Kabuto",	
neck="Sanctity Necklace", 
ear1="Infused Earring",
hands="Rao Kote",
feet="Rao Sune-Ate"
}
    
--Defense sets
    
sets.defense.PDT = {
}
    
sets.defense.Killer = {
head="Founder’s Corona",
neck="Twilight Torque",
ear1="Bladeborn Earring",
ear2="Steelflash Earring",
body="Found. Breastplate",
hands="Founder’s Gauntlets",
ring1="Petrov Ring",
ring2="Rajas Rign",
back="Takaha Mantle",
waist="Windbuffet Belt +1",
legs="Founder’s Hose",
feet="Founder’s Greaves",
}
    
sets.defense.MDT = {
}
    
sets.Kiting = {
}
    
sets.Killer = {
}
    
-- Engaged sets
    
-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous

-- sets if more refined versions aren't defined.

-- If you create a set with both offense and defense modes, the offense mode should be first.

-- EG: sets.engaged.Dagger.Accuracy.Evasion
    
-- Note, this set assumes use of:
sets.engaged = {
head="",
neck="",
ear1="",
ear2="",
body="",
hands="",
ring1="",
ring2="",
back="",
waist="",
legs="",
feet=""
}
    
sets.engaged.Mid = {
head="",
neck="",
ear1="",
ear2="",
body="",
hands="",
ring1="",
ring2="",
back="",
waist="",
legs="",
feet="",
}
    
sets.engaged.Acc = {
head="",
neck="",
ear1="",
ear2="",
body="",
hands="",
ring1="",
ring2="",
back="",
waist="",
legs="",
feet="",
}
    
--sets.engaged.Yoichi = {}

--sets.engaged.Yoichi.Mid = {}

--sets.engaged.Yoichi.Acc = {}

--sets.engaged.PDT = {}

--sets.engaged.Yoichi.PDT = {}

--sets.engaged.Acc.PDT = {}

--sets.engaged.Killer = {}

--sets.engaged.Killer.Yoichi = {}

--sets.engaged.Acc.Killer = {}

--sets.engaged.Acc.Killer.Yoichi = {}

-- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills and 1% gear haste. 

-- Game flipped upside down. 31 STP needed to 4-hit?
    
-- This set aims for Tsurumaru 4-hit. 21% DA, 4% TA, 1% QA 27% haste

-- Assumes use of Cibitshavore
   
sets.engaged.Adoulin = {}
    
sets.engaged.Adoulin.Mid = {}
    
sets.engaged.Adoulin.Acc = {}
    
--sets.engaged.Adoulin.PDT = {}
    
--sets.engaged.Adoulin.Acc.PDT = {}
    
--sets.engaged.Adoulin.Yoichi = {}
    
--sets.engaged.Adoulin.Yoichi.Mid = {}
    
--sets.engaged.Adoulin.Yoichi.Acc = {}
    
--sets.engaged.Adoulin.Yoichi.PDT = {}
    
--sets.engaged.Adoulin.Yoichi.Acc.PDT = {}
    
--sets.engaged.Adoulin.Killer = {}
   
--sets.engaged.Adoulin.Yoichi.Killer = {}
    
--sets.engaged.Adoulin.Yoichi.Acc.Killer = {}
    
--sets.engaged.Amanomurakumo = {}
    
--sets.engaged.Amanomurakumo.AM = {}
    
--sets.engaged.Adoulin.Amanomurakumo = {}
    
--sets.engaged.Kogarasumaru = {}
    
--sets.engaged.Kogarasumaru.AM = {}
    
--sets.engaged.Kogarasumaru.AM3 = {}
    
--sets.engaged.Adoulin.Kogarasumaru = {}
    
--sets.engaged.Adoulin.Kogarasumaru.AM = {}

--sets.engaged.Adoulin.Kogarasumaru.AM3 = {}

sets.buff.Sekkanoki = {hands="Unkai Kote +1"}
    
sets.buff.Sengikori = {}
    
sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate +1"}
    
sets.thirdeye = {head="Unkai Kabuto +1", legs="Sakonji Haidate +1"}
    
sets.seigan = {hands="Unkai Kabuto +1"}
    
--sets.bow = {}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		-- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
		if player.equipment.main =='Nativus Halberd' or player.equipment.main =='Quint Spear' then
			if spell.english:startswith("Tachi:") then
				send_command('@input /ws "Stardiver" '..spell.target.raw)
				eventArgs.cancel = true
			end
		end
	end
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    --if spell.english == 'Third Eye' and not buffactive.Seigan then
    --    cancel_spell()
    --    send_command('@wait 0.5;input /ja Seigan <me>')
    --    send_command('@wait 1;input /ja "Third Eye" <me>')
    --end
end
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if state.Buff.Sekkanoki then
			equip(sets.buff.Sekkanoki)
		end
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        if is_sc_element_today(spell) then
            if state.OffenseMode.current == 'Normal' and wsList:contains(spell.english) then
                -- do nothing
            else
                equip(sets.WSDayBonus)
            end
        end
        if LugraWSList:contains(spell.english) then
            if world.time >= (17*60) or world.time <= (7*60) then
                if spell.english:lower() == 'namas arrow' then
                    equip(sets.LugraFlame)
                else
                    equip(sets.LugraMoonshade)
                end
            else
                if spell.english:lower() == 'namas arrow' then
                    equip(sets.FlameFlame)
                else
                    equip(sets.BrutalMoonshade)
                end
            end
        end
		if state.Buff['Meikyo Shisui'] then
			equip(sets.buff['Meikyo Shisui'])
		end
	end
    if spell.english == "Seigan" then
        -- Third Eye gearset is only called if we're in PDT mode
        if state.HybridMode.value == 'PDT' or state.PhysicalDefenseMode.value == 'PDT' then
            equip(sets.thirdeye)
        else
            equip(sets.seigan)
        end
    end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
            -- If sneak is active when using, cancel before completion
            send_command('cancel 71')
    end
    update_am_type(spell)
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Effectively lock these items in place.
	if state.HybridMode.value == 'Killer' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Killer') then
		equip(sets.Killer)
	end
    if state.Buff['Seigan'] then
        if state.DefenseMode.value == 'PDT' then
            equip(sets.thirdeye)
        else
            equip(sets.seigan)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff['Seigan'] then
        if state.DefenseMode.value == 'PDT' then
    	    meleeSet = set_combine(meleeSet, sets.thirdeye)
        else
            meleeSet = set_combine(meleeSet, sets.seigan)
        end
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if player.equipment.range == 'Yoichinoyumi' then
        meleeSet = set_combine(meleeSet, sets.bow)
    end
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        if player.inventory['Eminent Arrow'] then
            gear.RAarrow.name = 'Eminent Arrow'
        elseif player.inventory['Tulfaire Arrow'] then
            gear.RAarrow.name = 'Tulfaire Arrow'
        elseif player.equipment.ammo == 'empty' then
            add_to_chat(122, 'No more Arrows!')
        end
    elseif newStatus == 'Idle' then
        determine_idle_group()
    end
end
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
    	state.Buff[buff] = gain
        handle_equipping_gear(player.status)
    end

    if S{'aftermath'}:contains(buff:lower()) then
        classes.CustomMeleeGroups:clear()
       
        if player.equipment.main == 'Amanomurakumo' and state.YoichiAM.value then
            classes.CustomMeleeGroups:clear()
        elseif player.equipment.main == 'Kogarasumaru'  then
            if buff == "Aftermath: Lv.3" and gain or buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('AM3')
            end
        elseif buff == "Aftermath" and gain or buffactive.Aftermath then
            classes.CustomMeleeGroups:append('AM')
        end
    end
    
    if not midaction() then
        handle_equipping_gear(player.status)
    end

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	get_combat_form()
    update_melee_groups()
    --get_combat_weapon()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
--function get_combat_weapon()
--    if player.equipment.range == 'Yoichinoyumi' then
--        if player.equipment.main == 'Amanomurakumo' then
--            state.CombatWeapon:set('AmanoYoichi')
--        else
--            state.CombatWeapon:set('Yoichi')
--        end
--    else
--        state.CombatWeapon:set(player.equipment.main)
--    end
--end
-- Handle zone specific rules
windower.register_event('Zone change', function(new,old)
    determine_idle_group()
end)

function determine_idle_group()
    classes.CustomIdleGroups:clear()
    if areas.Adoulin:contains(world.area) then
    	classes.CustomIdleGroups:append('Adoulin')
    end
end

function get_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
    	state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

function seigan_thirdeye_active()
    return state.Buff['Seigan'] or state.Buff['Third Eye']
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()

    if player.equipment.main == 'Amanomurakumo' and state.YoichiAM.value then
        -- prevents using Amano AM while overriding it with Yoichi AM
        classes.CustomMeleeGroups:clear()
    elseif player.equipment.main == 'Kogarasumaru' then
        if buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end
    else
        if buffactive['Aftermath'] then
            classes.CustomMeleeGroups:append('AM')
        end
    end
end
-- call this in job_post_precast() 
function update_am_type(spell)
    if spell.type == 'WeaponSkill' and spell.skill == 'Archery' and spell.english == 'Namas Arrow' then
        if player.equipment.main == 'Amanomurakumo' then
            -- Yoichi AM overwrites Amano AM
            state.YoichiAM:set(true)
        end
    else
        state.YoichiAM:set(false)
    end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(1, 1)
    elseif player.sub_job == 'DNC' then
    	set_macro_page(1, 2)
    else
    	set_macro_page(1, 1)
    end
end


tents here
