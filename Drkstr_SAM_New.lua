-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff.Hasso = buffactive.Hasso or false
	state.Buff.Seigan = buffactive.Seigan or false
	state.Buff.Sekkanoki = buffactive.Sekkanoki or false
	state.Buff.Sengikori = buffactive.Sengikori or false
	
	state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
	
	state.mainweapon = M{['description'] = 'Main Weapon'}
	state.mainweapon:options('Dojikiri Yasutsuna', 'Norifusa')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.

function user_setup()
	sate.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HiAcc')
	state.HybridMode:options('Normal','PDT', 'Reraise')
	state.WeaponskillMode:options('Normal', 'Acc', 'HiAcc')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.IdleMode:options('Normal', 'PDT')
	
	Aeol_weapons = S{'Dojikiri Yasutsuna'}
--	Koga_weapons = S{'Kogarasumaru'}
--	Empy_weapons = S{'Masamune'}
	Proc_weapons = S{'Norifusa'}
	
-- Additional local binds
	
	send_command('bind ^q input /ja "Hasso" <me>')
	send_command('bind !q input /ja "Seigan" <me>')
	send_command('bind !a input /ja "Third Eye" <me>')
	send_command('bind ^z gs c mainweapon')

	update_combat_form()
	select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^q')
	send_command('unbind !q')
	send_command('unbind !a')
	send_command('unbind ^z')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	
	include('Augmented-items.lua')
    
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
    	sets.mainweapon = {}
--	sets.mainweapon.Kogarasumaru = {main="Kogarasumaru",sub=""}
--	sets.mainweapon.Masamune = {main="Masamune",sub=""}
--	sets.mainweapon.Amanomurakumo = {main="Amanomurakumo",	sub=""}
	sets.mainweapon['Dojikiri Yasutsuna'] = {main="Dojikiri Yasutsuna",sub="Bloodrain Strap"}
	sets.mainweapon['Norifusa'] = {main="Norifusa +1",sub="Bloodrain Strap"}
	
-- Precast Sets
-- Precast sets to enhance JAs
	sets.precast.JA.Meditate = {head=gear.SAMAF.Head,hands=gear.SAMRel.Hands,back=gear.AmbJSE.SAMTP}
	sets.precast.JA.Seigan = {}
	sets.precast.JA['Warding Circle'] = gear.SAMAF.Head
	--sets.precast.JA['Blade Bash'] = gear.SAMRel.Hands
	sets.precast.JA['Third Eye'] = gear.SAMRel.Legs
	--sets.precast.JA['Sengikori'] = {feet="Kasuga Sune-ate +1"}
	--sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +1"}

-- Waltz set (chr and vit)
	--sets.precast.Waltz = {}
-- Don't need any special gear for Healing Waltz.
	--sets.precast.Waltz['Healing Waltz'] = {}

       
-- Weaponskill sets
-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Knobkierrie",
  	head=gear.Valoroushead.WS,body=gear.Valorousbody.WS,hands=gear.Valoroushands.WS,legs=gear.Hizamaru.Legs,
	feet=gear.Valorousfeet.WS,neck="Fotia Gorget",waist="Fotia Belt",left_ear="Brutal Earring",
	right_ear=gear.Moonshade.WS,right_ring="Shukuyu Ring",left_ring="Niqmaddu Ring",back=gear.AmbJSE.SAMWS}
	
	--Try to figure out how to get this set to be usable. Does not have "Mid" as an option, has Mod?
    	--sets.precast.WS.Mid = {ammo="Amar Cluster",
	--head=gear.Valoroushead.WS,body=gear.Valorousbody.WS,hands=gear.Valoroushands.WS,legs=gear.Hizamaru.Legs,
	--feet=gear.Valorousfeet.WS,neck="Fotia Gorget",waist="Fotia Belt",left_ear="Zwazo earring +1",
	--right_ear=gear.Moonshade.WS,left_ring="Niqmaddu Ring",right_ring="Cacoethic Ring +1",back=gear.AmbJSE.SAMWS}
	
	sets.precast.WS.Acc ={ammo="Amar Cluster",
	head="Ynglinga Sallet",body=gear.Valorousbody.WS,hands=gear.SAMAF.Hands,legs=gear.SAMAF.Legs,
	feet=gear.Valorousfeet.WS,neck="Fotia Gorget",waist="Olseni Belt",left_ear="Zwazo earring +1",
	right_ear="Zennaroi Earring",left_ring="Cacoethic Ring",right_ring="Cacoethic Ring +1",back=gear.AmbJSE.SAMWS}
	

-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Tachi: Fudo'] =sets.precast.WS
	sets.precast.WS['Tachi: Fudo'].Acc = sets.precast.WS.Acc
	--sets.precast.WS['Tachi: Fudo'].Mod = sets.precast.WS.Mid

	sets.precast.WS['Tachi: Shoha'] = sets.precast.WS
	sets.precast.WS['Tachi: Shoha'].Acc = sets.precast.WS.Acc
	--sets.precast.WS['Tachi: Shoha'].Mod = sets.precast.WS.Mid

	sets.precast.WS['Tachi: Rana'] = sets.precast.WS
	sets.precast.WS['Tachi: Rana'].Acc = sets.precast.WS.Acc
	--sets.precast.WS['Tachi: Rana'].Mod = sets.precast.WS.Mid
	
	sets.precast.WS['Tachi: Jinpu'] = sets.precast.WS
	sets.precast.WS['Tachi: Kasha'] = sets.precast.WS
	sets.precast.WS['Tachi: Gekko'] = sets.precast.WS
	sets.precast.WS['Tachi: Yukikaze'] = sets.precast.WS
		
	sets.precast.WS['Tachi: Ageha'] = {ammo="Knobkierrie",
	head=gear.Flamma.Head,body=gear.Flamma.Body,hands=gear.Flamma.Hands,legs=gear.Flamma.Legs,
	feet=gear.Flamma.Feet,neck="Sanctity Necklace",waist="Fotia Belt",left_ear="Digni. Earring",
	right_ear="Gwati Earring",left_ring="Etana Ring",right_ring="Vertigo Ring",back="Vespid Mantle"}
	
-- Midcast Sets
	sets.midcast.FastRecast = {}
		
-- Sets to return to when not performing an action.
-- Resting sets
	sets.resting = {ammo="Knobkierrie",
	head=gear.Rao.head,body=gear.Hizamaru.Body,hands=gear.Rao.hands,legs=gear.Rao.legs,
	feet=gear.Rao.feet,neck="Sanctity Necklace",waist="Flume Belt +1",left_ear="Infused Earring",
	right_ear="Odnowa Earring +1",left_ring="Defending Ring",right_ring="Paguroidea Ring",back="Moonbeam Cape"}

-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = sets.resting
	sets.idle.Regen = sets.resting
	sets.idle.Weak = sets.resting
	sets.idle.PDT = sets.resting
	sets.idle.Town = {ammo="Knobkierrie",
	head=gear.SAMAF.Head,body=gear.SAMAF.Body,hands=gear.SAMAF.Hands,legs=gear.SAMAF.Legs,
	feet=gear.SAMAF.Feet,neck="Moonbeam Nodowa",waist="Ioskeha Belt",left_ear="Cessance Earring",
	right_ear="Brutal Earring",right_ring="Ilabrat Ring",left_ring="Niqmaddu Ring",back="Moonbeam Cape"}
	
-- Defense sets
	sets.defense.PDT = {ammo="Amar Cluster",
	head="Ynglinga Sallet",neck="Loricate torque +1",ear1="Cessance Earring",ear2="Dignitary's Earring",
	body=gear.SAMAF.Body,hands=gear.SAMAF.Hands,ring1="Defending Ring",ring2="Patricius Ring",
	back=gear.AmbJSE.SAMTP,waist="Ioskeha Belt",legs="Arjuna Breeches",feet=gear.Amm.Cap}
	
	sets.defense.MDT = {ammo="Amar Cluster",
	head=gear.Founders.head ,body=gear.SAMAF.Body,hands=gear.SAMAF.Hands,legs=gear.Valorouslegs.TP,
	feet=gear.Amm.Cap,neck="Loricate Torque +1",waist="Ioskeha Belt",left_ear="Etiolation Earring",
	right_ear="Odnowa Earring +1",left_ring="Defending Ring",right_ring="Archon Ring",back=gear.AmbJSE.SAMTP}
	
	--sets.Kiting = {feet="Danzo Sune-ate"}
	sets.Reraise = {}
	sets.defense.Reraise = {}
	
-- Engaged sets

-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
-- sets if more refined versions aren't defined.
-- If you create a set with both offense and defense modes, the offense mode should be first.
-- EG: sets.engaged.Dagger.Accuracy.Evasion
    
-- Normal melee group
-- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
	sets.engaged.Dojikiri = {}
	sets.engaged.Dojikiri.LowAcc = {}
	sets.engaged.Dojikiri.MidAcc = {}
	sets.engaged.Dojikiri.HiAcc = {}
	sets.engaged.Dojikiri.PDT = {}
	
--	sets.engaged.Kogarasumaru = {}
--	sets.engaged.Kogarasumaru.LowAcc = {}
--	sets.engaged.Kogarasumaru.MidAcc = {}
--	sets.engaged.Kogarasumaru.HiAcc = {}
		
--	sets.engaged.Masamune = {}
--	sets.engaged.Masamune.LowAcc = {}
--	sets.engaged.Masamune.HighAcc	= {}
--	sets.engaged.Masamune.HiAcc = {}
--	sets.engaged.Masamune.PDT = {}
	
	sets.engaged.Norifusa = {}
		
	sets.engaged.Archery = {}
 	
	sets.engaged.PDT = {}
		
-- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
-- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
	sets.engaged.Adoulin = {}
 	sets.engaged.Adoulin.Acc = {}
	sets.engaged.Adoulin.PDT = {}
	sets.engaged.Adoulin.Acc.PDT = {}
	sets.engaged.Adoulin.Reraise = {}
	sets.engaged.Adoulin.Acc.Reraise = {}

	sets.buff.Sekkanoki = {}
	sets.buff.Sengikori = {}
	sets.buff['Meikyo Shisui'] = {}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function update_combat_form()
-- Check Weapontype
	if  Aeol_weapons:contains(player.equipment.main) then
		state.CombatForm:set('Dojikiri')
	elseif
--		Koga_weapons:contains(player.equipment.main) then
--		state.CombatForm:set('Kogarasumaru')
--	elseif
--		Empy_weapons:contains(player.equipment.main) then
--		state.CombatForm:set('Masamune')
--	elseif
		Proc_weapons:contains(player.equipment.main) then
		state.CombatForm:set('Norifusa')
	else
		state.CombatForm:reset()
    end
end

function job_self_command(cmdParams, eventArgs)
	command = cmdParams[1]:lower()
	if command=='mainweapon' then
		enable('main','sub')
		mainswap=1
		send_command('gs c cycle mainweapon')
	end
end

function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
        if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
            if spell.english:startswith("Tachi:") then
                send_command('@input /ws "Penta Thrust" '..spell.target.raw)
                eventArgs.cancel = true
            end
        end
    end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.

	moonshade_WS = S{"Tachi: Fudo", "Tachi: Kasha", "Tachi: Shoha", "Tachi: Rana", "Tachi: Gekko"}

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end
		if moonshade_WS:contains(spell.english) and player.tp<2950 then	
			equip({ear2="Moonshade Earring"})	
		end
	end
end



-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.

-- Set eventArgs.handled to true if we don't want the automatic display to be run.

function display_current_job_state(eventArgs)
local msg = 'Melee'
	if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
	end
end

-- Modify the default idle set
function customize_idle_set(idleSet)
	if mainswap then
		mainswap=0
		enable('main','sub')
		equip(sets.mainweapon[state.mainweapon.value])
		disable('main','sub')
	end
		return idleSet
end

--add_to_chat(122,'Idle Set ')
	
function customize_melee_set(meleeSet)
	if mainswap then
		mainswap=0
		enable('main','sub')
		equip(sets.mainweapon[state.mainweapon.value])
		disable('main','sub')
	end
    if state.Buff.Aftermath then
		return set_combine(meleeSet, sets.Aftermath)
    end
	if state.Buff.Doom then
		return set_combine(meleeSet, sets.Doom)
	end
	if state.Buff.Curse then
		return set_combine(meleeSet, sets.Curse)
	else
		return meleeSet
	end
end
	

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 1)
    else
        set_macro_page(1, 1)
    end
end
