-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Eva', 'HighHaste', 'MaxHaste', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    
    gear.MovementFeet = {name="Danzo Sune-ate"}
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Hachiya Kyahan"
    
	select_default_macro_book()
	select_movement_feet()

    send_command("alias tp gs equip sets.engaged")
	send_command("alias acc gs equip sets.engaged.Acc")
	send_command("alias eva gs equip sets.engaged.Evasion")
	send_command("alias highhaste gs equip sets.engaged.HighHaste")
	send_command("alias maxhaste gs equip sets.engaged.MaxHaste")
	send_command("alias pdt gs equip sets.engaged.PDT")
	
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama"}
    sets.precast.JA['Futae'] = {legs="Iga Tekko +2"}
    sets.precast.JA['Sange'] = {legs="Mochizuki Chainmail +1"}

	-- Ammo For Shuriken
	Ammo_Shuriken = "Hachiya Shuriken"
	
	-- JSE Back
	jse_back=jse_back
	
	-- FastCast
	fc_neck="Voltsurge Torque"
	fc_ear1="Enchntr. Earring +1"
	fc_ear2="Loquacious Earring"
	fc_hands="Leyline Gloves"
	fc_ring1="Prolix Ring"
	fc_ring2="Weather. Ring"
	fc_head="Herculean Helm"
	fc_utsusemi_body="Mochizuki Chainmail +1"
	
    ws_ammo=Ammo_Shuriken
    ws_head="Herculean Helm"
	ws_body={ name="Rawhide Vest", augments={'HP+50','System: 2 ID: 182 Val: 6','System: 2 ID: 179 Val: 1',}}
	ws_hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','Crit. hit damage +4%','Attack+9',}}
	ws_legs="Herculean Trousers"
	ws_feet="Herculean Boots"
	ws_neck="Yarak Torque"
	ws_waist="Fotia Belt"
	ws_ear1="Brutal Earring"
	ws_ear2="Cessance Earring"
	ws_ring1="Begrudging Ring"
	ws_ring2="Etana Ring"
	ws_back=jse_back

	ws_belt="Fotia Belt"
	
	-- Idle Sets - Focus on Regen / Defensive
	idle_ranged=""
	idle_ammo=Ammo_Shuriken
	idle_head="Skormoth Mask"
	idle_neck="Twilight Torque"
	idle_ear1="Brutal Earring"
	idle_ear2="Suppanomimi"
	idle_body="Rawhide Vest"
	idle_hands={ name="Herculean Gloves", augments={'Attack+4','"Triple Atk."+4','DEX+1','Accuracy+14',}}
	idle_ring1="Dark Ring"
	idle_ring2="Defending Ring"
	idle_back="Yokaze Mantle"
	idle_waist="Anguinus Belt"
	idle_legs="Samnuha Tights"
	idle_feet=gear.MovementFeet
	
	utsusemi_feet="Hattori Kyahan"
	
	eva_ammo=Ammo_Shuriken
    eva_head="Skormoth Mask"
	eva_neck="Yarak Torque"
	eva_ear1="Brutal Earring"
	eva_ear2="Suppanomimi"
    eva_body="Mochizuki Chainmail +1"
	eva_hands={ name="Herculean Gloves", augments={'Attack+4','"Triple Atk."+4','DEX+1','Accuracy+14',}}
	eva_ring1="Epona's Ring"
    eva_ring2="Hetairoi Ring"
	eva_back="Yokaze Mantle"
	eva_waist="Anguinus Belt"
	eva_legs="Samnuha Tights"
	eva_feet="Taeon Boots"
	
	pdt_ammo=Ammo_Shuriken
    pdt_head="Skormoth Mask"
	pdt_neck="Yarak Torque"
	pdt_ear1="Brutal Earring"
	pdt_ear2="Suppanomimi"
    pdt_body="Mochizuki Chainmail +1"
	pdt_hands={ name="Herculean Gloves", augments={'Attack+4','"Triple Atk."+4','DEX+1','Accuracy+14',}}
	pdt_ring1="Epona's Ring"
    pdt_ring2="Hetairoi Ring"
	pdt_back="Yokaze Mantle"
	pdt_waist="Flume Belt +1"
	pdt_legs="Samnuha Tights"
	pdt_feet="Taeon Boots"	
	
	-- Engaged Sets
	eng_ammo=Ammo_Shuriken
	eng_head="Skormoth Mask"
	eng_body={ name="Rawhide Vest", augments={'HP+50','System: 2 ID: 182 Val: 6','System: 2 ID: 179 Val: 1',}}
	eng_hands={ name="Herculean Gloves", augments={'Attack+4','"Triple Atk."+4','DEX+1','Accuracy+14',}}
	eng_legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}
	eng_feet="Herculean Boots"
	eng_neck="Yarak Torque"
	eng_waist="Anguinus Belt"
	eng_ear1="Trux Earring"
	eng_ear2="Cessance Earring"
	eng_ring1="Epona's Ring"
	eng_ring2="Hetairoi Ring"
	eng_back=jse_back
	
	eng_acc_body="Mochizuki Chainmail +1"
	eng_acc_hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','Crit. hit damage +4%','Attack+9',}}
	
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
	    ammo="Sonia's Plectrum",
        head="Felistris Mask",
        body="Hachiya Chainmail +1",hands="Buremte Gloves",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Otronif Boots +1"
	}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {}
	sets.precast.Flourish1 = {}

    -- Fast cast sets for spells
    sets.precast.FC = {neck=fc_neck,ear1=fc_ear1,ear2=fc_ear2,hands=fc_hands,ring1=fc_ring1,ring2=fc_ring2,head=fc_head}
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body=fc_utsusemi_body})

    -- Snapshot for ranged
    --sets.precast.RA = {hands="Manibozho Gloves",legs="Nahtirah Trousers",feet="Wurrukatte Boots"}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo=ws_ammo,head=ws_head,body=ws_body,hands=ws_hands,legs=ws_legs,feet=ws_feet,neck=ws_neck,waist=ws_waist,ear1=ws_ear1,ear2=ws_ear2,ring1=ws_ring1,ring2=ws_ring2,back=ws_back,}
    
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS,{waist=ws_belt,neck="Breeze Gorget"})
	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS,{waist=ws_belt})
	sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS,{waist=ws_belt,neck="Flame Gorget"})
	sets.precast.WS['Aeolian Edge'] = {}

    --------------------------------------
    -- Midcast sets
    --------------------------------------
        
    sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {feet=utsusemi_feet})

    sets.midcast.ElementalNinjutsu = {
        head="Hachiya Hatsuburi",
		-- neck="Stoicheion Medal",
		ear1="Friomisi Earring",
		ear2="Halasz Earring",
        body="Hachiya Chainmail +1",
		hands="Leyline Gloves",
		ring1="Weather. Ring",
		ring2="Etana Ring",
        back=jse_back,
		-- waist=gear.ElementalObi,
		-- legs="Nahtirah Trousers",
		feet="Hachiya Kyahan"
	}

    sets.midcast.NinjutsuDebuff = {
        head="Hachiya Hatsuburi",
		ear1="Lifestorm Earring",
		ear2="Psystorm Earring",
        hands="Mochizuki Tekko +1",
		ring1="Weather. Ring",
		ring2="Etana Ring",
        back="Yokaze Mantle",
		feet="Hachiya Kyahan"
		}

    sets.midcast.NinjutsuBuff = {
		hands="Mochizuki Tekko +1",
	    head="Hachiya Hatsuburi",
		feet=utsusemi_feet,
		back=jse_back,
		}

    sets.midcast.RA = {
		body="Hachiya Chainmail +1",
		hands="Herculean Gloves",
		ring1="Paqichikaji Ring",
		ring2="Hajduk Ring",
		neck="Peacock Amulet",
        back="Yokaze Mantle",
		legs="Feast Hose",
		feet={ name="Taeon Boots", augments={'Attack+12','"Triple Atk."+2','STR+3 VIT+3',}},
		}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Idle sets
	sets.idle = {ammo=idle_ammo,head=idle_head,neck=idle_neck,ear1=idle_ear1,ear2=idle_ear2,body=idle_body,hands=idle_hands,ring1=idle_ring1,ring2=idle_ring2,back=idle_back,waist=idle_waist,legs=idle_legs,feet=idle_feet}
   

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo=eng_ammo,head=eng_head,body=eng_body,hands=eng_hands,legs=eng_legs,feet=eng_feet,neck=eng_neck,waist=eng_waist,ear1=eng_ear1,ear2=eng_ear2,ring1=eng_ring1,ring2=eng_ring2,back=jse_back,}
    sets.engaged.Acc = set_combine(sets.engaged, {})
	sets.engaged.Evasion = set_combine(sets.engaged, {})
    sets.engaged.PDT = {ammo=Ammo_Shuriken,head=pdt_head,body=pdt_body,hands=pdt_hands,legs=pdt_legs,feet=pdt_feet,neck=pdt_neck,waist=pdt_waist,ear1=pdt_ear1,ear2=pdt_ear2,ring1=pdt_ring1,ring2=pdt_ring2,back=jse_back,}
	sets.engaged.HighHaste = set_combine(sets.engaged, {})
    sets.engaged.MaxHaste = set_combine(sets.engaged, {})
	
	--------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {body="Hattori Ningi"}
    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

function job_status_change(new_status, old_status)
   if player.equipment.back == 'Mecisto. Mantle' or player.equipment.back == 'Aptitude Mantle' or player.equipment.back == 'Aptitude Mantle +1' or player.equipment.back == 'Nexus Cape' then
        disable('back')
    else
        enable('back')
    end
        if player.equipment.ring1 == 'Warp Ring' or player.equipment.ring1 == 'Vocation Ring' or player.equipment.ring1 == 'Capacity Ring' then
        disable('ring1')
    else
        enable('ring1')
    end
    if player.equipment.ring2 == 'Warp Ring' or player.equipment.ring2 == 'Vocation Ring' or player.equipment.ring2 == 'Capacity Ring' then
        disable('ring2')
    else
        enable('ring2')
    end
    if new_status == 'Idle' then
        select_movement_feet()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end

function select_default_macro_book()
    set_macro_page(3, 1)
end

