-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
    mote_include_version = 2
	include('Mote-Include.lua')

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
    --gear.RAarrow = {name="Eminent Arrow"}
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
    state.HybridMode:options('Normal', 'PDT', 'Killer')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Killer')
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

--[[
-- SC's
Rana > Shoha > Fudo > Kasha > Shoha > Fudo - light
Rana > Shoha > Fudo > Kasha > Rana > Fudo - dark

Kasha > Shoha > Fudo
Fudo > Kasha > Shoha > fudo
Shoha > Fudo > Kasha > Shoha > Fudo

--]]

function init_gear_sets()
	include('Drkstr-Gear.lua') 
	Drkstr_shared_augmented_gear() 

    --------------------------------------
    -- Start defining the sets
    --------------------------------------

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
    --sets.precast.Waltz = {}

    --Don't need any special gear for Healing Waltz.

    --sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.CapacityMantle  = {back="Mecistopins Mantle" 
}
    --sets.Berserker       = {neck="Berserker's Torque"}
    sets.WSDayBonus      = {head="Gavialis Helm" 
}
    sets.LugraMoonshade  = {ear1="Brutal Earring", ear2="Moonshade Earring"
}
    sets.BrutalMoonshade = {ear1="Brutal Earring", ear2="Moonshade Earring" 
}
    sets.LugraFlame      = {ear1="Brutal Earring", ear2="Moonshade Earring"
}
    sets.FlameFlame      = {ear1="Brutal Earring", ear2="Moonshade Earring"
}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined

    sets.precast.WS = {
        head=gear.Raohead.B, -- 32 acc 45 str
        neck="Fotia Gorget",
        ear1="Brutal Earring",
        ear2="Moonshade Earring",
        body="Found. Breastplate",
        hands="Ryuo Tekko",
        ring1="Ifrit Ring",
        ring2="Ifrit Ring",
        back="Smertrios's Mantle",
        waist="Fotia Belt",
        legs= "Rao Haidate",
        feet= "Ryuo Sune-Ate"
    }

    sets.precast.WS.Mid = set_combine(sets.precast.WS, {})

    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
	head="Ryuo Somen",
	ear1= "Zennaroi Earring",
	ear2= "Digni. Earring",
	ring1="Cacoethic Ring",
	ring2=" Cacoethic Ring +1",
	legs="Ryuo Hakama",
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
        ear2="Steelflash Earring",
    })
    sets.precast.WS['Tachi: Rana'].Mid = set_combine(sets.precast.WS.Mid, {
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
    })
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
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
        body="Kyujutsugi", 
        hands="Ryuo Tekko",
        ring1="Cacoethic Ring",
		ring2=" Cacoethic Ring +1",
        back="Sokolski Mantle", 
        waist="Fotia Belt",
        legs= "Ryuo Hakama",
        feet= " Waki. Sune-Ate +1"
}
	sets.precast.WS['Apex Arrow'].Mid = sets.precast.WS['Apex Arrow']
	sets.precast.WS['Apex Arrow'].Acc = sets.precast.WS['Apex Arrow']

    -- Midcast Sets
    sets.midcast.FastRecast = {}
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    
    --sets.resting = {head="",neck="",ear1="",ear2="",body="",hands="",ring1="",ring2="",back="",waist="",legs="",feet="",}
    
    --sets.idle.Town = {}
    --sets.idle.Town.Adoulin = {}
    --sets.idle.Field = {}
    --sets.idle.Weak = {}
    --sets.idle.Yoichi = {}

    sets.idle.Regen = {
	head="Rao Kabuto",	
	neck="Sanctity Necklace", 
	ear1="Infused Earring",
	hands="Rao Kote",
	legs="Rao Haidate",
	feet="Rao Sune-Ate"
    }
    
    --Defense sets
    
    --sets.defense.PDT = {}
    
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
    
    --sets.defense.MDT = {}
    --sets.Kiting = {}
    --sets.Killer = {}
    
    -- Engaged sets
    
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Note, this set assumes use of: Cibitshavore –7STP Bloodrain Strap – 6STP Umaru – 5STP
    sets.engaged = {
	head="Stinger Helm +1", --10% haste
	neck="Ainia Collar",--8STP
	ear1="Tripudio Earring",--5STP
	ear2="Dedition Earring",--8STP
	body="Kasuga Domaru +1",--12STP, 3% Haste
	hands="",
	ring1="Petrov Ring",--5STP
	ring2="Rajas Ring",--5STP
	back="Takaha Mantle",--10STP
	waist="",
	legs="Kasuga Haidate +1",--9STP, 5% Haste
	feet="Sak. Sune-Ate +1",--8STP, 3% Haste
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