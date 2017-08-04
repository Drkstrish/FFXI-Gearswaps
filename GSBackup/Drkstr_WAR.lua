-- Initialization function for this job file.
function get_sets()
  
  mote_include_version = 2
  
  include('Mote-Include.lua')
  
end
-- //gs debugmode
-- //gs showswaps

function binds_on_load()
-- F9-F12
  send_command('bind f9 gs c cycle OffenseMode')
  send_command('bind f10 gs c cycle HybridMode')
  send_command('bind f11 gs c cycle CastingMode')
  send_command('bind f12 gs c update user')
-- CTRL F9-F12
  send_command('bind ^q gs c mainweapon')
  send_command('bind ^f9 gs c cycle WeaponskillMode')
-- ALT F9-12
  send_command('bind !f9 gs c cycle IdleMode')
  send_command('bind !f10 gs c cycle RangedMode')
  send_command('bind !f12 gs c cycle Kiting')
end
function job_setup()
  state.mainweapon = M{['description'] = 'Main Weapon'}
  state.mainweapon:options('Ragnarok','Reikiko')
end
function user_setup()
-- Options: Override default values
  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  
  state.WeaponskillMode:options('Normal', 'Acc')
  
  state.HybridMode:options('Normal', 'PDT')
  
  state.CastingMode:options('Normal', 'Resistant')
  
  state.IdleMode:options('Normal','PDT')
  
  state.PhysicalDefenseMode:options('PDT', 'MDT')
  
  Rag_weapons = S{'Ragnarok'}
  
  Shield_weapons = S{'Blurred Shield'}

  update_combat_form()
  
  select_default_macro_book()
  
end
-- Called when this job file is unloaded (eg: job change)
function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end
end

sets.mainweapon = {}

sets.mainweapon.Ragnarok = {main="Shukuyu\'s Scythe",sub="Utu Grip"}

sets.mainweapon.Reikiko = {main="Reikiko",sub="Blurred Shield"}


-- Define sets and vars used by this job file.

function init_gear_sets()
-- Precast sets
    sets.precast.JA['Berserk'] = {}
    sets.precast.JA['Warcry'] = {}
    sets.precast.JA['Aggressor'] = {}
    sets.precast.JA['Blood Rage'] = {}
    sets.precast.JA['Retaliation'] = {}
    sets.precast.JA['Restraint'] = {}
    sets.precast.JA['Mighty Strikes'] = {}
    sets.precast.JA["Warrior's Charge"] = {}
    sets.precast.JA['Provoke'] = {}
-- Fast cast sets for spells
    sets.precast.FC = {}
  
-- Midcast Sets
    sets.midcast.FastRecast = {}
    sets.midcast.Flash = {}

-- Resting sets
    sets.resting = {}

-- Idle sets
    sets.idle = {}
    sets.idle.PDT = {}
    sets.idle.Town = {}
    sets.idle.Weak = {}

--Engaged Ragnarok   
    sets.engaged.Ragnarok = {}   
    sets.engaged.Ragnarok.LowAcc = {}
    sets.engaged.Ragnarok.HighAcc = {}

-- Sword and Board Sets
    sets.engaged.Blurred = {}
    sets.engaged.Blurred.PDT = {}

-- Weaponskill sets
    sets.precast.WS = {}
    sets.precast.WS.Acc = {}
    sets.precast.WS['Resolution'] = {}
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Savage Blade'] = {}
    sets.precast.WS['Savage Blade'].Acc = {}

-- Mighty Strikes WS Set --
    sets.MS_WS = {ammo="Yetshila", feet="Boii Calligae +1"}

end
-- Job-specific hooks for standard casting events.
function job_midcast(spell, action, spellMap, eventArgs)

end

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)

end

function update_combat_form()
-- Check Weapontype
    if Rag_weapons:contains(player.equipment.main) then
        state.CombatForm:set('Ragnarok')
    elseif
        Shield_weapons:contains(player.equipment.sub) then
        state.CombatForm:set('Blurred')
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

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- eventArgs is the same one used in job_precast, in caseb information needs to be persisted.
    moonshade_WS = S{"Resolution","Torcleaver", "Savage Blade"}

function job_post_precast(spell, action, spellMap,eventArgs)
    if spell.type =='WeaponSkill' then
        if world.time >= (17*60) or world.time <= (7*60) then          
            equip({ear1="Lugra Earring +1",ear2="Lugra Earring"})
        end
        if moonshade_WS:contains(spell.english) and player.tp<2950 then  
            equip({ear2="Moonshade Earring"})
        end
        if buffactive['Mighty Strikes'] then 
            if sets.precast.WS[spell] then              
                equipSet = sets.precast.WS[spell]
                equipSet = set_combine(equipSet,sets.MS_WS)
                equip(equipSet)
            else
                equipSet = sets.precast.WS
                equipSet = set_combine(equipSet,sets.MS_WS)
                equip(equipSet)
            end
        end
    end
end

function customize_idle_set(idleSet)
    if mainswap then
        mainswap=0
        enable('main','sub')
        equip(sets.mainweapon[state.mainweapon.value])
        disable('main','sub')
    end
    if player.mpp <51 then
        return set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom or state.Buff.Curse then
        return set_combine(idleSet, sets.Doom)
    else
        return idleSet
    end
end

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

-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap,eventArgs)
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'RDM' then       
        set_macro_page(1, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 1)
    else
        set_macro_page(1, 1)
    end
end