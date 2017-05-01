-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
-- Updated 3/30/17

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    define_roll_values()
    -- Additional local binds
    send_command('bind ` gs c toggle LuzafRing')

    select_default_macro_book()


end
-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind `')

end
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.

function user_setup()
    state.OffenseMode:options('Ranged', 'Melee', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Chrono Bullet"
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15

    -- Additional local binds
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    include('augmented-items.lua')
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
  sets.precast.JA['Wild Card'] = {feet=gear.CORRel.Feet}
  
  sets.precast.CorsairRoll = 
  {
    head=gear.CORRel.Head,
    body=gear.Adhemar.body,
    hands=gear.COREmpy.Hands,
    legs=gear.CORAF.Legs,
    feet=gear.Pursuers.feet,
    neck="Regal Necklace",
    waist="Flume Belt +1",
    left_ear="Lempo Earring",
    right_ear="Enervating Earring",
    left_ring="Defending Ring",
    right_ring="Patricius Ring",
    back=gear.AmbJSE.CORSnap
  }
  
  sets.precast.CorsairRoll["Blitzer's Roll"] = 
  set_combine(sets.precast.CorsairRoll, {head=gear.COREmpy.Head})
  
  sets.precast.CorsairRoll["Tactician's Roll"] = 
  set_combine(sets.precast.CorsairRoll, {body=gear.COREmpy.Body})
  
  sets.precast.CorsairRoll["Caster's Roll"] = 
  set_combine(sets.precast.CorsairRoll, {legs=gear.COREmpy.Legs})
  
  sets.precast.CorsairRoll["Courser's Roll"] = 
  set_combine(sets.precast.CorsairRoll, {})
  
  sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
  
  sets.precast.JA['Random Deal'] = {body=gear.CORRel.Body}
  
  sets.precast.JA['Snake Eye'] = {legs=gear.CORRel.Legs}
  
  sets.precast.FoldDoubleBust = {hands=gear.CORRel.Hands}
  
  sets.precast.JA['Triple Shot'] = {back=gear.AmbJSE.CORSTP} 
  
  -- Add more when i can 

  sets.precast.CorsairShot = 
  {}
  
  -- Waltz set (chr and vit)
  
  -- depricated set REWORK WHEN ABLE
  
  sets.precast.Waltz = 
  {}        
  
  -- Don't need any special gear for Healing Waltz.
  
  sets.precast.Waltz['Healing Waltz'] = 
  {}
  
  -- Fast cast sets for spells
  
  sets.precast.FC =	-- 49 FC
  {
    head=gear.Carmine.head,         --12
    body=gear.Samnuhabody.FC,       --3
    hands=gear.Leyline.NotCap,      --7
    legs=gear.Rawhide.legs,         --5
    feet=gear.Carmine.feet,         --8
    neck="Orunmila's Torque",       --5
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",  --1
    right_ear="Loquac. Earring",    --2
    left_ring="Rahab Ring",         --2 
    right_ring="Kishar Ring",       --4
  back="Moonbeam Cape"
  }
  
  sets.precast.FC.Utsusemi = 
  set_combine(sets.precast.FC, {neck="Magoraga Beads"})
  
  sets.precast.RA = -- 21 Rapid 51 Snap
  {
    head=gear.Pursuers.head, -- 10 Rapid
    body=gear.Pursuers.body, -- 6 Snap 
    hands=gear.Carmine.hands, -- 11 Rapid 8 Snap
    legs=gear.CORAF.Legs, -- 15 Snap
    feet=gear.Meghanada.Feet, -- 10 Snap
    neck="Loricate Torque +1",
    waist="Impulse Belt", -- 2 Snap
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Patricius Ring",
    back=gear.AmbJSE.CORSnap  -- 10 Snap
  }
  
  -- Weaponskill sets
  
  -- Default set for any weaponskill that isn't any more specifically defined
  
  sets.precast.WS = 
  {
    head=gear.Lilitu.Cap,
    body=gear.Herculeanbody.Crit,
    hands=gear.Meghanada.Hands,
    legs=gear.Meghanada.Legs,
    feet=gear.Herculeanfeet.Triple,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear=gear.Moonshade.WS,
    right_ear="Brutal Earring",
    left_ring="Cacoethic Ring",
    right_ring="Cacoethic Ring +1",
    back="Ground. Mantle +1"
  }
  
  -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
  
  sets.precast.WS['Evisceration'] = 
  sets.precast.WS
  
  sets.precast.WS['Exenterator'] = 
  sets.precast.WS
  
  sets.precast.WS['Requiescat'] = 
  sets.precast.WS
  
  sets.precast.WS['Last Stand'] = 
  -- 1173 R. Acc 1145 R. Atk
  {
    ammo=gear.WSbullet,    
    head=gear.Pursuers.head,
    body=gear.CORAF.Body,
    hands=gear.Meghanada.Hands,
    legs=gear.Adhemar.legs,
    feet=gear.Adhemar.feet,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear=gear.Moonshade.WS,
    right_ear="Enervating Earring",
    left_ring="Dingir Ring",
    right_ring="Ilabrat Ring",
    back=gear.AmbJSE.CORWS
  }
  
  sets.precast.WS['Last Stand'].Acc = 
  -- R. Acc 1270 R. Atk 1131
  {
    ammo=gear.WSbullet,    
    head=gear.Meghanada.Head,
    body=gear.CORAF.Body,
    hands=gear.Meghanada.Hands,
    legs=gear.Meghanada.Legs,
    feet=gear.Meghanada.Feet,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Neritic Earring",
    right_ear="Enervating Earring",
    left_ring="Hajduk Ring +1",
    right_ring="Cacoethic Ring +1",
    back=gear.AmbJSE.CORWS
  }
  
  sets.precast.WS['Wildfire'] = 
  {
    ammo=gear.MAbullet,    
    head=gear.Herculeanhead.Magic,
    body=gear.Herculeanbody.Magic,
    hands=gear.Carmine.hands,
    legs=gear.Herculeanlegs.Magic,
    feet=gear.Herculeanfeet.Magic,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Gwati Earring",
    right_ear="Hermetic Earring",
    left_ring="Dingir Ring",
    right_ring="Etana Ring",
    back=gear.AmbJSE.CORMWS
  }
  
  sets.precast.WS['Wildfire'].Brew = 
  sets.precast.WS['Wildfire']
  
  sets.precast.WS['Leaden Salute'] = 
  set_combine(sets.precast.WS['Wildfire'], 
  {head="Pixie Hairpin +1", Ring2="Archon Ring"})
  
  -- Midcast Sets
  
  sets.midcast.FastRecast = 
  sets.precast.FC
  
  -- Specific spells
  
  sets.midcast.Utsusemi = 
  sets.midcast.FastRecast
  
  sets.midcast.CorsairShot = 
  {
    ammo=gear.QDbullet,
    head=gear.Herculeanhead.Magic,
    body=gear.Herculeanbody.Magic,
    hands=gear.Carmine.hands,
    legs=gear.Herculeanlegs.Magic,
    feet=gear.Herculeanfeet.Magic,
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Hermetic Earring",
    right_ear="Friomisi Earring",
    left_ring="Etana Ring",
    right_ring="Dingir Ring",
    back=gear.AmbJSE.CORMdmg
  }
  
  sets.midcast.CorsairShot.Acc = 
  {
    Head=gear.Carmine.head.HQ,
    neck="Sanctity Necklace",
    ear1="Dignitary's Earring",
    ear2="Gwati Earring",
    body=gear.Mummu.Body,
    hands=gear.Mummu.Hands,
    ring1="Etana Ring",
    ring2="Dingir Ring",
    back=gear.AmbJSE.CORMdmg,
    waist="Kwahu Kachina Belt",
    legs=gear.Mummu.Legs,
    feet=gear.Mummu.Feet
  }
  
  sets.midcast.CorsairShot['Light Shot'] = 
  sets.midcast.CorsairShot
  
  sets.midcast.CorsairShot['Dark Shot'] = 
  set_combine(sets.midcast.CorsairShot['Light Shot'], {head="Pixie Hairpin +1", Ring2="Archon Ring"})
  
  -- Ranged gear
  
  sets.midcast.RA = 
  {
    ammo=gear.RAbullet,
    head=gear.Pursuers.head,
    body=gear.Mummu.Body,
    hands=gear.Carmine.hands,
    legs=gear.Adhemar.legs,
    feet=gear.Adhemar.feet,
    neck="Iskur Gorget",
    waist="Reiki Yotai",
    left_ear="Dedition Earring",
    right_ear="Tripudio Earring",
    left_ring="Rajas Ring",
    right_ring="Ilabrat Ring",
    back=gear.AmbJSE.CORSTP
  }
  
  sets.midcast.RA.Acc = 
  -- 1308 R. Acc 1146 R. Atk
  {
    ammo=gear.RAbullet,
    head=gear.Meghanada.Head,
    body=gear.CORAF.Body,
    hands=gear.Meghanada.Hands,
    legs=gear.CORAF.Legs,
    feet=gear.Meghanada.Feet,
    neck="Iskur Gorget",
    waist="Kwahu Kachina Belt",
    left_ear="Neritic Earring",
    right_ear="Enervating Earring",
    left_ring="Hajduk Ring +1",
    right_ring="Cacoethic Ring +1",
    back=gear.AmbJSE.CORSTP
  }
  
  -- Sets to return to when not performing an action.
  
  -- Resting sets
  
  sets.resting = 
  {
    head=gear.Rawhide.head,
    body="Mekosuchinae Harness",
    hands=gear.Floral.Cap,
    legs=gear.Carmine.legs,
    feet=gear.Herculeanfeet.Ranged,
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Patricius Ring",
  back="Moonbeam Cape"
  }
  
  -- Idle sets
  
  sets.idle = 
  sets.resting
  
  sets.idle.Town = 
  {    
    head=gear.Carmine.head.HQ,
    body=gear.CORAF.Body,
    hands=gear.Carmine.hands,
    legs=gear.Carmine.legs,
    feet=gear.Carmine.feet,
    neck="Regal Necklace",
    waist="Reiki Yotai",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Dingir Ring",
    right_ring="Ilabrat Ring",
  back="Moonbeam Cape"
}
  
  -- Defense sets
  
  sets.defense.PDT = 
  {
    head=gear.Meghanada.Head,
    body=gear.Meghanada.Body,
    hands=gear.Meghanada.Hands,
    legs=gear.Meghanada.Legs,
    feet=gear.Meghanada.Feet,
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Patricius Ring",
  back="Moonbeam Cape"
  }
  
  sets.defense.MDT = 
  {
    head=gear.Dampening.Cap,
    body=gear.Meghanada.Body,
    hands=gear.Floral.Cap,
    legs=gear.Mummu.Legs,
    feet=gear.CORRel.Feete,
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Patricius Ring",
  back="Moonbeam Cape"
  }
  
  sets.Kiting = 
  {feet=gear.Carmine.legs}
  
  -- Engaged sets
  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion
  -- Normal melee group
  
  sets.engaged.Melee = 
  {
    head=gear.Dampening.Cap,
    body=gear.Herculeanbody.Crit,
    hands=gear.Herculeanhands.Triple,
    legs=gear.Samnuhalegs,
    feet=gear.Herculeanfeet.Triple,
    neck="Clotharius Torque",
    waist="Windbuffet Belt +1",
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Epona's Ring",
    right_ring="Petrov Ring",
    back="Ground. Mantle +1",
  }
  
  sets.engaged.Acc = 
  {
    head=gear.Carmine.head.HQ,
    body=gear.Herculeanbody.Crit,
    hands=gear.Meghanada.Hands,
    legs=gear.Carmine.legs,
    feet=gear.Meghanada.Feet,
    neck="Decimus Torque",
    waist="Olseni Belt",
    left_ear="Zennaroi Earring",
    right_ear="Digni. Earring",
    left_ring="Cacoethic Ring",
    right_ring="Cacoethic Ring +1",
    back="Ground. Mantle +1"
  }
  
  sets.engaged.Melee.DW = 
  {
    head=gear.Carmine.head.HQ,
    body=gear.Adhemar.body,
    hands=gear.Floral.Cap,
    legs=gear.Carmine.legs,
    feet=gear.Rawhide.feet,
    neck="Clotharius Torque",
    waist="Reiki Yotai",
    left_ear="Heartseeker Earring",
    right_ear="Dudgeon Earring",
    left_ring="Epona's Ring",
    right_ring="Petrov Ring",
    back="Ground. Mantle +1"
  }
  
  sets.engaged.Acc.DW = 
  sets.engaged.Acc
  
  sets.engaged.Ranged = 
  sets.midcast.RA
  
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        state.OffenseMode:set('Ranged')
    end
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    
    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
    
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 5)
end