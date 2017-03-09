-- Updated 2/21/17

-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
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
  state.HybridMode:options('Normal', 'PDT', 'RiceBall')  
  state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
  state.IdleMode:options('Normal')  
  state.RestingMode:options('Normal')  
  state.PhysicalDefenseMode:options('PDT', 'RiceBall')  
  state.MagicalDefenseMode:options('MDT')
  
  -- Additional local binds
  
  send_command('bind ^[ input /lockstyle on')  
  send_command('bind ![ input /lockstyle off')  
  send_command('bind != gs c toggle CapacityMode')
  
  select_default_macro_book()
  
end
-- Called when this job file is unloaded (eg: job change)
function file_unload()
  
  send_command('unbind ^[')  
  send_command('unbind !=')  
  send_command('unbind ![')
  
end
function init_gear_sets()
  
  include('Augmented-items.lua')
  
  --------------------------------------
  -- Start defining the sets
  --------------------------------------
  
  -- Precast Sets
  
  -- Precast sets to enhance JAs
sets.precast.JA.Meditate = 
{    
  head=gear.SAMAF.Head,
  hands=gear.SAMRel.Hands,
  back=gear.AmbJSE.SAMTP
}
  sets.precast.JA.Seigan = {}
  
  sets.precast.JA['Warding Circle'] = gear.SAMAF.Head
  
  sets.precast.JA['Third Eye'] = gear.SAMRel.Legs
  
  sets.precast.JA['Blade Bash'] = gear.SAMRel.Hands
  
  -- Waltz set (chr and vit)
  
  sets.precast.Waltz = {}

  --sets.Organizer = {}
  
  -- Don't need any special gear for Healing Waltz.
  
  sets.precast.Waltz['Healing Waltz'] = {}
  
  sets.CapacityMantle  = { back="Mecistopins Mantle" }
  
  sets.Berserker       = { neck="Berserker's Torque" }
  
  sets.WSDayBonus      = { head="Gavialis Helm"}
  
  sets.LugraMoonshade  = { ear1="Brutal Earring", ear2=gear.Moonshade.WS}
  
  sets.BrutalMoonshade = { ear1="Brutal Earring", ear2=gear.Moonshade.WS}
  
  sets.LugraFlame      = { ear1="Brutal Earring", ear2="Cessance Earring" }
  
  sets.FlameFlame      = { ear1="Brutal Earring", ear2="Cessance Earring" }
  
  -- Weaponskill sets
  
  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = -- 1040 Acc +233 STR
{
  head=gear.Valoroushead.WS,
  body=gear.Valorousbody.WS,
  hands=gear.Valoroushands.WS,
  legs=gear.Valorouslegs.DMWS,
  feet=gear.Valorousfeet.WS,
  neck="Fotia Gorget",
  waist="Fotia Belt",
  left_ear="Brutal Earring",
  right_ear=gear.Moonshade.WS,
  right_ring="Shukuyu Ring",
  left_ring="Niqmaddu Ring",
  back=gear.AmbJSE.SAMWS
}

sets.precast.WS.Mid = -- 1090 Acc +237 STR
{
  head=gear.Valoroushead.WS,
  body=gear.Valorousbody.WS,
  hands=gear.Valoroushands.WS,
  legs=gear.Hizamaru.Legs,
  feet=gear.Valorousfeet.WS,
  neck="Fotia Gorget",
  waist="Fotia Belt",
  left_ear="Zwazo earring +1",
  right_ear=gear.Moonshade.WS,
  left_ring="Niqmaddu Ring", 
  right_ring="Cacoethic Ring +1",
  back=gear.AmbJSE.SAMWS
}

sets.precast.WS.Acc = -- 1141 acc +196 STR
{
  head="Ynglinga Sallet",
  body=gear.Valorousbody.WS,
  hands=gear.Ryuo.hands,
  legs=gear.Hizamaru.Legs,
  feet=gear.Valorousfeet.WS,
  neck="Fotia Gorget",
  waist="Olseni Belt",
  left_ear="Zwazo earring +1",
  right_ear="Zennaroi Earring",
  left_ring="Cacoethic Ring",
  right_ring="Cacoethic Ring +1",
  back=gear.AmbJSE.SAMWS
}

  sets.precast.WS['Tachi: Fudo'] = sets.precast.WS
  sets.precast.WS['Tachi: Fudo'].Mid = sets.precast.WS.Mid
  sets.precast.WS['Tachi: Fudo'].Acc = sets.precast.WS.Acc
  
  sets.precast.WS['Tachi: Shoha'] = sets.precast.WS
  sets.precast.WS['Tachi: Shoha'].Mid = sets.precast.WS.Mid
  sets.precast.WS['Tachi: Shoha'].Acc = sets.precast.WS.Acc
  
  sets.precast.WS['Tachi: Rana'] = sets.precast.WS
  sets.precast.WS['Tachi: Rana'].Mid = sets.precast.WS.Mid
  sets.precast.WS['Tachi: Rana'].Acc = sets.precast.WS.Acc
  
  --sets.precast.WS['Namas Arrow'] = {}
  --sets.precast.WS['Namas Arrow'].Mid = {}
  --sets.precast.WS['Namas Arrow'].Acc = {}
  
  --sets.precast.WS['Apex Arrow'] = {}
  --sets.precast.WS['Apex Arrow'].Mid = {}
  --sets.precast.WS['Apex Arrow'].Acc = {}
 
  -- CHR Mod
sets.precast.WS['Tachi: Ageha'] = 
{
  head=gear.Flamma.Head,
  body=gear.Flamma.Body,
  hands=gear.Flamma.Hands,
  legs=gear.Flamma.Legs,
  feet=gear.Flamma.Feet,
  neck="Sanctity Necklace",
  waist="Fotia Belt",
  left_ear="Digni. Earring",
  right_ear="Gwati Earring",
  left_ring="Etana Ring",
  right_ring="Vertigo Ring",
  back="Vespid Mantle"
}

  sets.precast.WS['Tachi: Jinpu'] = sets.precast.WS
  
  -- Midcast Sets
  sets.midcast.FastRecast = {}
  
  -- Sets to return to when not performing an action.
  -- Resting sets
  sets.resting = 
{    
  head=gear.Rao.head,
  body=gear.Hizamaru.Body,
  hands=gear.Rao.hands,
  legs=gear.Rao.legs,
  feet=gear.Rao.feet,
  neck="Sanctity Necklace",
  waist="Flume Belt +1",
  left_ear="Infused Earring",
  right_ear="Odnowa Earring +1",
  left_ring="Defending Ring",
  right_ring="Paguroidea Ring",
  back="Xucau Mantle"
}
  sets.idle.Town = sets.resting
  sets.idle.Town.Adoulin = sets.idle.Town
  sets.idle.Field = sets.resting
  sets.idle.Regen = sets.resting
  sets.idle.Weak = sets.resting
  --sets.idle.Yoichi = {}
  
  -- Defense sets
  sets.defense.PDT =
{    
  head="Ynglinga Sallet",
  neck="Loricate torque +1",
  ear1="Cessance Earring",
  ear2="Dignitary's Earring",
  body=gear.SAMAF.Body,
  hands=gear.SAMAF.Hands,
  ring1="Defending Ring",
  ring2="Patricius Ring",
  back=gear.AmbJSE.SAMTP,
  waist="Ioskeha Belt",
  legs="Arjuna Breeches",
  feet=gear.Amm.Cap 
}
  
  sets.defense.MDT =
{    
  head=gear.Founders.head ,
  body=gear.SAMAF.Body,
  hands=gear.SAMAF.Hands,
  legs=gear.Valorouslegs.TP,
  feet=gear.Amm.Cap,
  neck="Loricate Torque +1",
  waist="Flume Belt +1",
  left_ear="Etiolation Earring",
  right_ear="Odnowa Earring +1",
  left_ring="Defending Ring",
  right_ring="Archeron Ring",
  back=gear.AmbJSE.SAMTP
}
    
  sets.defense.RiceBall = {}
  --sets.Kiting = {feet="Danzo Sune-ate"}
  
  sets.RiceBall= {}
  
  -- Engaged sets

sets.engaged = 
-- 1095 Acc - Weapon 10 STP Grip 6 STP Ranged 7 STP = 23 STP
{
  head=gear.Flamma.Head,        -- 4TA      5STP
  body=gear.SAMEmpy.Body,       --          12STP
  hands=gear.SAMAF.Hands,       --          7STP
  legs=gear.Ryuo.legs,          --     3DA  11STP
  feet=gear.Valorousfeet.TP,    --     5DA  5STP
  neck="Clotharius Torque",     -- 1TA
  waist="Ioskeha Belt",         --     8DA
  left_ear="Cessance Earring",  --     3DA  3STP
  right_ear="Brutal Earring",   --     5DA  1STP
  left_ring="Hetairoi Ring",    -- 2TA
  right_ring="Niqmaddu Ring",   --                3QA
  back=gear.AmbJSE.SAMDA        --     10DA
}                               -- 7TA 34DA 67STP 3QA 

sets.engaged.Mid = -- 1118 Acc
{    
  head=gear.Flamma.Head,          -- 4TA        5STP
  body=gear.SAMEmpy.Body,         --            12STP
  hands=gear.SAMAF.Hands,         --            7STP
  legs=gear.Ryuo.legs,            --     3DA    11STP
  feet=gear.Valorousfeet.TP,      --     5DA    5STP
  neck="Agelast Torque",
  waist="Ioskeha Belt",           --     8DA
  left_ear="Dignitary's earring", --            3TP
  right_ear="Zennaroi Earring",
  left_ring="Hetairoi Ring",      -- 2TA
  right_ring="Niqmaddu Ring",     --                  3QA
  back=gear.AmbJSE.SAMDA          --            10STP
}                                 -- 6TA  16DA  76STP  3DA

sets.engaged.Acc = -- 1175 Acc
{    
  head=gear.Ryuo.head,             --            6STP
  body=gear.Hizamaru.Body,
  hands=gear.Ryuo.hands,
  legs=gear.Flamma.Legs,           --            7STP
  feet=gear.Valorousfeet.TP,       --       5DA  5STP
  neck="Agelast Torque",
  waist="Ioskeha Belt",            --       8DA
  left_ear="Dignitary's earring",  --             3STP
  right_ear="Zennaroi Earring",
  left_ring="Cacoethic Ring",
  right_ring="Cacoethic Ring +1",
  back=gear.AmbJSE.SAMTP           --              10STP
}                                  --        13DA  55STP

sets.engaged.PDT = 
{
  head=gear.Flamma.Head,
  body=gear.SAMAF.Body,           -- 4Dmg
  hands=gear.SAMAF.Hands,
  legs="Arjuna Breeches",         -- 4PDT
  feet=gear.Valorousfeet.TP,      -- 2MDT
  neck="Loricate Torque +1",      -- 6Dmg
  waist="Ioskeha Belt",
  left_ear="Cessance Earring",
  right_ear="Brutal Earring",
  left_ring="Hetairoi Ring",
  right_ring="Defending Ring",    -- 10Dmg
  back="Solemnity Cape"           -- 4Dmg
}
sets.engaged.Acc.PDT = 
{
  head=gear.Flamma.Head,
  body=gear.SAMAF.Body,           -- 4Dmg
  hands=gear.SAMAF.Hands,
  legs="Arjuna Breeches",         -- 4PDT
  feet=gear.Valorousfeet.TP,      -- 2MDT
  neck="Loricate Torque +1",      -- 6Dmg
  waist="Ioskeha Belt",
  left_ear="Digni. Earring",
  right_ear="Zennaroi Earring",
  left_ring="Cacoethic Ring +1",
  right_ring="Defending Ring",    -- 10Dmg
  back="Solemnity Cape"           -- 4Dmg
}


--sets.engaged.Yoichi = {}
--sets.engaged.Yoichi.Mid = {}
--sets.engaged.Yoichi.Acc = {}
--sets.engaged.Yoichi.PDT = {}
sets.engaged.RiceBall = {}
--sets.engaged.RiceBall.Yoichi = {}
--sets.engaged.Acc.RiceBall = {}
--sets.engaged.Acc.RiceBall.Yoichi = {}

    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills and 1% gear haste. 
    -- Game flipped upside down. 31 STP needed to 4-hit?
    
    -- Assumes use of Cibitshavore
    --sets.engaged.Adoulin = {}
    --sets.engaged.Adoulin.Mid = {}    
    --sets.engaged.Adoulin.Acc = {}    
    --sets.engaged.Adoulin.PDT = {}    
    --sets.engaged.Adoulin.Acc.PDT = {}
    
    -- Tsurumaru 4-hit 19% DA, 28% haste 
    --sets.engaged.Adoulin.Yoichi = {}
    --sets.engaged.Adoulin.Yoichi.Mid = {}
    --sets.engaged.Adoulin.Yoichi.Acc = {}    
    --sets.engaged.Adoulin.Yoichi.PDT = {}
    --sets.engaged.Adoulin.Yoichi.Acc.PDT = {}    
    --sets.engaged.Adoulin.RiceBall = {}
    --sets.engaged.Adoulin.Yoichi.RiceBall = {}
    --sets.engaged.Adoulin.Acc.RiceBall = {}
    --sets.engaged.Adoulin.Yoichi.Acc.RiceBall = {}    
    --sets.engaged.Amanomurakumo = {}
    --sets.engaged.Amanomurakumo.AM = {}
    --sets.engaged.Adoulin.Amanomurakumo = {}
    --sets.engaged.Adoulin.Amanomurakumo.AM = {}    
    --sets.engaged.Kogarasumaru = {}
    --sets.engaged.Kogarasumaru.AM = {}
    --sets.engaged.Kogarasumaru.AM3 = {}
    --sets.engaged.Adoulin.Kogarasumaru = {}
    --sets.engaged.Adoulin.Kogarasumaru.AM = {}
    --sets.engaged.Adoulin.Kogarasumaru.AM3 = {}
    
    --sets.buff.Sekkanoki = {}
    --sets.buff.Sengikori = {}
    sets.buff['Meikyo Shisui'] = {feet=gear.SAMRel.Feet}
    sets.thirdeye = {}
    sets.seigan = {}
    sets.bow = {}
    
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
    if spell.english == 'Third Eye' and not buffactive.Seigan then
        cancel_spell()
     send_command('@wait 0.5;input /ja Seigan <me>')
     send_command('@wait 1;input /ja "Third Eye" <me>')
    end
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
--          if is_sc_element_today(spell) then
--            if state.OffenseMode.current == 'Normal' and wsList:contains(spell.english) then
--                 do nothing
--            else
--                equip(sets.WSDayBonus)
--            end
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
    --if spell.english == "Seigan" then
        -- Third Eye gearset is only called if we're in PDT mode
     --   if state.HybridMode.value == 'PDT' or state.PhysicalDefenseMode.value == 'PDT' then
    --        equip(sets.thirdeye)
    --    else
   --         equip(sets.seigan)
    --    end
   -- end
   -- if spell.name == 'Spectral Jig' and buffactive.sneak then
            -- If sneak is active when using, cancel before completion
    --        send_command('cancel 71')
   -- end
   -- update_am_type(spell)
--end
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
	if state.HybridMode.value == 'RiceBall' or
      (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'RiceBall') then
        equip(sets.RiceBall)
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