-- updated 2/22/17

-- Owner: AlanWarren, aka ~ Orestes 
-- current file resides @ https://github.com/AlanWarren/gearswap
--[[ 

 === Notes ===
 -- Set format is as follows:
    sets.midcast.RA.[CustomClass][CombatForm][CombatWeapon][RangedMode][CustomRangedGroup]
    ex: sets.midcast.RA.SAM.Bow.Mid.SamRoll = {}
    you can also append CustomRangedGroups to each other
 
 -- These are the available sets per category
 -- CustomClass = SAM
 -- CombatForm = DW
 -- CombatWeapon = weapon name, ex: Yoichinoyumi  (you can make new sets for any ranged weapon)
 -- RangedMode = Normal, Mid, Acc
 -- CustomRangedGroup = SamRoll

 -- SamRoll is applied automatically whenever you have the roll on you. 
 -- SAM is used when you're RNG/SAM 

 * Auto RA
 - You can use the built in hotkey (CTRL -) or create a macro. (like below) Note "AutoRA" is case sensitive
   /console gs c toggle AutoRA
 - You have to shoot once after toggling autora for it to begin.
 - AutoRA will use weaponskills @ 1000TP, depending on which weapon you're using. However, this will only
   work if you set gear.Gun or gear.Bow to the weapon you're using. You also have to specify the desired
   ws it should use, with the settings auto_gun_ws and auto_bow_ws. 
 
 === Helpful Commands ===
    //gs validate
    //gs showswaps
    //gs debugmode

--]]
 
function get_sets()
  mote_include_version = 2
  -- Load and initialize the include file.
  include('Mote-Include.lua')
  include('organizer-lib')
end
-- setup vars that are user-independent.
function job_setup()
end
-- setup vars that are user-dependent. 
function user_setup()
  -- Options: Override default values
  state.OffenseMode:options('Normal', 'Melee')
  state.RangedMode:options('Normal', 'Mid', 'Acc')
  state.HybridMode:options('Normal', 'PDT')
  state.IdleMode:options('Normal', 'PDT')
  state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
  state.PhysicalDefenseMode:options('PDT')
  state.MagicalDefenseMode:options('MDT')

  state.Buff.Barrage = buffactive.Barrage or false
  state.Buff.Camouflage = buffactive.Camouflage or false
  state.Buff.Overkill = buffactive.Overkill or false
  
  -- settings
  state.CapacityMode = M(false, 'Capacity Point Mantle')
  
  state.AutoRA = M{['description']='Auto RA', 'Normal', 'Shoot', 'WS' }
  auto_gun_ws = "Last Stand"
  auto_bow_ws = "Apex Arrow"
  
  gear.Gun = "Fomalhaut"
  gear.Bow = "Steinthor"
  --gear.Bow = "Hangaku-no-Yumi"
  
  rng_sub_weapons = S{}
  sam_sj = player.sub_job == 'SAM' or false
  DefaultAmmo = {[gear.Bow] = "Achiyalabopa arrow", [gear.Gun] = "Chrono bullet"}
  U_Shot_Ammo = {[gear.Bow] = "Achiyalabopa arrow", [gear.Gun] = "Chrono bullet"}

  get_combat_form()
  get_custom_ranged_groups()
  select_default_macro_book()

  send_command('bind != gs c toggle CapacityMode')
  send_command('bind f9 gs c cycle RangedMode')
  send_command('bind !f9 gs c cycle OffenseMode')
  send_command('bind ^f9 gs c cycle HybridMode')
  send_command('bind ^] gs c cycle WeaponskillMode')
  send_command('bind ^- gs c cycle AutoRA')
  send_command('bind ^[ input /lockstyle on')
  send_command('bind ![ input /lockstyle off')
  
  -- Testing 
  --windower.register_event('incoming text', detect_cor_rolls)
end
-- Called when this job file is unloaded (eg: job change)
function file_unload()
  send_command('unbind f9')
  send_command('unbind ^f9')
  send_command('unbind ^[')
  send_command('unbind ![')
  send_command('unbind !=')
  send_command('unbind ^=')
  send_command('unbind @=')
  send_command('unbind ^-')
end
function init_gear_sets()
  -- Augmented gear

  include('augmented-items.lua')
  
  sets.Organizer = {}

  -- Misc. Job Ability precasts
  --sets.precast.JA['Bounty Shot'] = {}
  sets.precast.JA['Double Shot'] = {head=gear.RNGAF3.Head}
  --sets.precast.JA['Camouflage'] = {body=gear.RNGAF.Body}
  sets.precast.JA['Sharpshot'] = {legs=gear.RNGAF.Legs}
  sets.precast.JA['Velocity Shot'] = {body=gear.RNGAF3.Body}
  --sets.precast.JA['Scavenge'] = {feet=gear.RNGAF.Feet}

  sets.CapacityMantle = {back="Mecistopins Mantle"}

  sets.precast.JA['Eagle Eye Shot'] = set_combine(sets.midcast.RA, {legs=gear.RNGRel.Legs})
  sets.precast.JA['Eagle Eye Shot'].Mid = set_combine(sets.precast.JA['Eagle Eye Shot'], {})
  sets.precast.JA['Eagle Eye Shot'].Acc = set_combine(sets.precast.JA['Eagle Eye Shot'].Mid, {})

  sets.precast.FC =             -- 45 FC 
{
  head=gear.Carmine.head,     --12
  neck="Orunmila's Torque",   --5
  ear1="Etiolation Earring",  --1
  ear2="Loquacious Earring",  --2
  body=gear.Samnuhabody.FC,   --3
  hands=gear.Leyline.NotCap,  --7
  ring1="Rahab Ring",         --2
  ring2="Lebeche Ring",       --
  legs=gear.Rawhide.legs,     --5
  feet=gear.Carmine.feet      --8
}

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads" })
  
sets.idle = 
{
  head=gear.Carmine.head.HQ,
  body=gear.Herculeanbody.Magic,
  hands=gear.Carmine.hands,
  legs=gear.Carmine.legs,
  feet=gear.Carmine.feet,
  neck="Anu Torque",
  waist="Flume Belt +1",
  left_ear="Etiolation Earring",
  right_ear="Sherida Earring",
  left_ring="Ilabrat Ring",
  right_ring="Dingir Ring",
  back="Solemnity Cape"
}

  sets.idle.Regen = sets.idle
  sets.idle.PDT = sets.idle
  sets.idle.Town = sets.idle
 
  -- Engaged sets
sets.engaged =  
{ -- 51% snap. need to get to 70
  head=gear.RNGAF3.Head,          -- 7 Snap
  body=gear.Pursuers.body,        -- 6 Snap
  hands=gear.Carmine.hands,       -- 8 Snap
  legs=gear.Adhemar.legs,         -- 9 Snap
  feet=gear.Meghanada.Feet,       -- 8 Snap
  neck="Loricate Torque +1",
  waist="Impulse Belt",           -- 3 Snap
  left_ear="Etiolation Earring",
  right_ear="Odnowa Earring +1",
  left_ring="Defending Ring",
  right_ring="Patricius Ring",
  back=gear.AmbJSE.RNGSnap        --10 Snap
}
  
  sets.engaged.PDT = sets.engaged
  sets.engaged.Bow = sets.engaged

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
  back="Ground. Mantle +1"
}
  
  sets.engaged.Bow.Melee = sets.engaged.Melee
  sets.engaged.Melee.PDT = sets.engaged.Melee
  sets.engaged.DW = sets.engaged

sets.engaged.DW.Melee = 
{
  head=gear.Dampening.Cap,
  body=gear.Adhemar.body,
  hands=gear.Floral.Cap,
  legs=gear.Carmine.legs,
  feet=gear.Rawhide.feet,
  neck="Clotharius Torque",
  waist="Windbuffet Belt +1",
  left_ear="Heartseeker Earring",
  right_ear="Dudgeon Earring",
  left_ring="Epona's Ring",
  right_ring="Hetairoi Ring",
  back="Ground. Mantle +1",
}

  ------------------------------------------------------------------
  -- Preshot / Snapshot sets
  ------------------------------------------------------------------
  sets.precast.RA = 
{ -- 51% snap. need to get to 70
  head=gear.RNGAF3.Head,          -- 7 Snap
  body=gear.Pursuers.body,        -- 6 Snap
  hands=gear.Carmine.hands,       -- 8 Snap
  legs=gear.Adhemar.legs,         -- 9 Snap
  feet=gear.Meghanada.Feet,       -- 8 Snap
  neck="Loricate Torque +1",
  waist="Impulse Belt",           -- 3 Snap
  left_ear="Etiolation Earring",
  right_ear="Odnowa Earring +1",
  left_ring="Defending Ring",
  right_ring="Patricius Ring",
  back=gear.AmbJSE.RNGSnap        --10 Snap
}
  
------------------------------------------------------------------
  -- Default Base Gear Sets for Ranged Attacks. Geared for Gun
  ------------------------------------------------------------------
  sets.midcast.RA = 
{ 
--1113 r. acc no food. 56 STP without weapons. 
  head=gear.RNGRel.Head,
  body=gear.Pursuers.body,      -- 6STP
  hands=gear.Carmine.hands,     -- 6STP
  legs=gear.Adhemar.legs,       -- 7STP
  feet=gear.Adhemar.feet,
  neck="Iskur Gorget",          -- 8STP
  waist="Kwahu Kachina Belt",
  left_ear="Sherida Earring",   -- 5STP
  right_ear="Tripudio Earring", -- 5STP
  left_ring="Petrov Ring",      -- 5STP
  right_ring="Ilabrat Ring",    -- 5STP
  back=gear.AmbJSE.RNGSTP       -- 10 STP
}
  
  sets.midcast.RA.Mid = 
{ 
  -- 1233 R. Acc no food. 40 STP without weapons.
  head=gear.RNGRel.Head,
  body=gear.Mummu.Body,           -- 5STP
  hands=gear.Adhemar.hands,       -- 6STP
  legs=gear.Herculeanlegs.Ranged, -- 4STP
  feet=gear.Herculeanfeet.Ranged, 
  neck="Iskur Gorget",            -- 8STP
  waist="Kwahu Kachina Belt",
  left_ear="Enervating Earring",  -- 4STP
  right_ear="Neritic Earring",    -- 4STP
  left_ring="Dingir Ring",
  right_ring="Ilabrat Ring",      -- 5STP
  back=gear.AmbJSE.RNGSTP         -- 10STP
}
  
  sets.midcast.RA.Acc = 
{
  --1322 R. Acc
  head=gear.Meghanada.Head,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Meghanada.Feet,
  neck="Iskur Gorget",
  waist="Kwahu Kachina Belt",
  left_ear="Neritic Earring",
  right_ear="Enervating Earring",
  left_ring="Cacoethic Ring +1",
  left_ring="Hajduk Ring +1",
  back=gear.AmbJSE.RNGSTP
}
  
  -- Samurai Roll sets 
  --sets.midcast.RA.SamRoll = {}
  --sets.midcast.RA.Mid.SamRoll = {}
  --sets.midcast.RA.Acc.SamRoll = {}
  -- SAM Subjob
  --sets.midcast.RA.SAM = {}
  --sets.midcast.RA.SAM.Mid = {}
  --sets.midcast.RA.SAM.Acc = {}
  -- Samurai Roll for /sam, assume we're using a staff
  --sets.midcast.RA.SAM.SamRoll = {}
  --sets.midcast.RA.SAM.Mid.SamRoll = {}
  --sets.midcast.RA.SAM.Acc.SamRoll = {}
  -- Bow base set.
  --sets.midcast.RA.Bow = {}
  --sets.midcast.RA.Bow.Mid = {}
  --sets.midcast.RA.Bow.Acc = {}
  -- Bow Sam roll
  --sets.midcast.RA.Bow.SamRoll = {}
  --sets.midcast.RA.Bow.Mid.SamRoll = {}
  --sets.midcast.RA.Bow.Acc.SamRoll = {}
  -- Sam SJ / Bow 
  --sets.midcast.RA.SAM.Bow = {}
  --sets.midcast.RA.SAM.Bow.Mid = {}
  --sets.midcast.RA.SAM.Bow.Acc = {}
  -- Sam SJ / Bow / Sam's Roll
  --sets.midcast.RA.SAM.Bow.SamRoll = {}
  --sets.midcast.RA.SAM.Bow.Mid.SamRoll = {}
  --sets.midcast.RA.SAM.Bow.Acc.SamRoll = {}
  
  -- Weaponskill sets  
sets.precast.WS = 
{
  head=gear.Pursuers.head,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Adhemar.legs,
  feet=gear.Adhemar.feet,
  neck="Fotia Gorget",
  waist="Fotia Belt",
  left_ear="Enervating Earring",
  right_ear=gear.Moonshade.WS,
  left_ring="Dingir Ring",
  right_ring="Ilabrat Ring",
  back=gear.AmbJSE.RNGMWS
}
  
  sets.precast.WS.Mid = 
{
  head=gear.Meghanada.Head,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Adhemar.feet,
  neck="Fotia Gorget",
  waist="Fotia Belt",
  left_ear="Enervating Earring",
  right_ear=gear.Moonshade.WS,
  left_ring="Cacoethic Ring +1",
  right_ring="Dingir Ring",
  back=gear.AmbJSE.RNGWS
}

  sets.precast.WS.Acc = 
{
  head=gear.Meghanada.Head,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Meghanada.Feet,
  neck="Iskur Gorget",
  waist="Kwahu Kachina Belt",
  left_ear="Neritic Earring",
  right_ear="Enervating Earring",
  left_ring="Cacoethic Ring +1",
  left_ring="Hajduk Ring +1",
  back=gear.AmbJSE.RNGWS
}

  -- WILDFIRE
  sets.Wildfire = 
{
  head=gear.Herculeanhead.Magic,
  body=gear.Herculeanbody.Magic,
  hands=gear.Carmine.hands,
  legs=gear.Herculeanlegs.Magic,
  feet=gear.Herculeanfeet.Magic,
  neck="Sanctity Necklace",
  waist="Kwahu Kachina Belt",
  left_ear="Hermetic Earring",
  right_ear="Friomisi Earring",
  left_ring="Dingir Ring",
  right_ring="Ilabrat Ring",
  back=gear.AmbJSE.RNGMWS
}

  sets.precast.WS['Wildfire'] = sets.Wildfire

  sets.precast.WS['Wildfire'].Mid = 
{
  head=gear.Herculeanhead.Magic,
  body=gear.Herculeanbody.Magic,
  hands=gear.Mummu.Hands,
  legs=gear.Mummu.Legs,
  feet=gear.Herculeanfeet.Magic,
  neck="Sanctity Necklace",
  waist="Kwahu Kachina Belt",
  left_ear="Gwati Earring",
  right_ear="Digni. Earring",
  left_ring="Dingir Ring",
  right_ring="Ilabrat Ring",
  back=gear.AmbJSE.RNGMWS
}
  
  sets.precast.WS['Wildfire'].Acc = 
{
  head=gear.Mummu.Head,
  body=gear.Mummu.Body,
  hands=gear.Mummu.Hands,
  legs=gear.Mummu.Legs,
  feet=gear.Mummu.Feet,
  neck="Sanctity Necklace",
  waist="Kwahu Kachina Belt",
  left_ear="Gwati Earring",
  right_ear="Digni. Earring",
  left_ring="Etana Ring",
  right_ring="Vertigo Ring",
  back=gear.AmbJSE.RNGMWS
}  
  
  sets.Trueflight = sets.Wildfire
  sets.precast.WS['Trueflight'] = sets.precast.WS['Wildfire']
  sets.precast.WS['Trueflight'].Mid = sets.precast.WS['Wildfire'].Mid
  sets.precast.WS['Trueflight'].Acc = sets.precast.WS['Wildfire'].Acc
  
  -- CORONACH
  --sets.Coronach = {}
  --sets.precast.WS['Coronach'] = {}
  --sets.precast.WS['Coronach'].Mid = {}
  --sets.precast.WS['Coronach'].Acc = {}
  --sets.precast.WS['Coronach'].SAM = {}
  
  -- LAST STAND
  sets.LastStand = 
{
  head=gear.Herculeanhead.Ranged,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Adhemar.legs,
  feet=gear.Adhemar.feet,
  neck="Fotia Gorget",
  waist="Fotia Belt",
  left_ear="Enervating Earring",
  right_ear=gear.Moonshade.WS,
  left_ring="Dingir Ring",
  right_ring="Ilabrat Ring",
  back=gear.AmbJSE.RNGWS
}
  
  sets.precast.WS['Last Stand'] = sets.LastStand
  
  sets.precast.WS['Last Stand'].Mid = 
{
  head=gear.Meghanada.Head,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Adhemar.feet,
  neck="Fotia Gorget",
  waist="Fotia Belt",
  left_ear="Enervating Earring",
  right_ear=gear.Moonshade.WS,
  left_ring="Cacoethic Ring +1",
  right_ring="Dingir Ring",
  back=gear.AmbJSE.RNGWS
}
  
  sets.precast.WS['Last Stand'].Acc = 
{
  head=gear.Meghanada.Head,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Meghanada.Feet,
  neck="Iskur Gorget",
  waist="Kwahu Kachina Belt",
  left_ear="Neritic Earring",
  right_ear="Enervating Earring",
  left_ring="Cacoethic Ring +1",
  left_ring="Hajduk Ring +1",
  back=gear.AmbJSE.RNGWS
}
  
  --sets.precast.WS['Last Stand'].SAM = {}
  -- DETONATOR
  --sets.Detonator = {}
  --sets.precast.WS['Detonator'] = {}
  --sets.precast.WS['Detonator'].Mid = {}
  --sets.precast.WS['Detonator'].Acc = {}
  -- SLUG SHOT
  --sets.SlugShot = {}
  --sets.precast.WS['Slug Shot'] = {}
  --sets.precast.WS['Slug Shot'].Mid = {}
  --sets.precast.WS['Slug Shot'].Acc = {}
  --sets.precast.WS['Heavy Shot'] = {}
  --sets.precast.WS['Heavy Shot'].Mid = {}
  --sets.precast.WS['Heavy Shot'].Acc = {}
  -- NAMAS
  --sets.Namas = {}
  --sets.precast.WS['Namas Arrow'] = {}
  --sets.precast.WS['Namas Arrow'].Mid = {}
  --sets.precast.WS['Namas Arrow'].Acc = {}
 -- sets.precast.WS['Namas Arrow'].SAM = {}
  -- JISHNUS
  --sets.Jishnus = {}
  --sets.precast.WS['Jishnu\'s Radiance'] = {}
  --sets.precast.WS['Jishnu\'s Radiance'].Mid = {}
  --sets.precast.WS['Jishnu\'s Radiance'].Acc = {}
  -- SIDEWINDER
  --sets.Sidewinder = {}
  --sets.precast.WS['Sidewinder'] = set_combine(sets.precast.WS, sets.Sidewinder)
  --sets.precast.WS['Sidewinder'].Mid = set_combine(sets.precast.WS.Mid, sets.Sidewinder)
  --sets.precast.WS['Sidewinder'].Acc = set_combine(sets.precast.WS.Acc, sets.Sidewinder)
  
  --sets.precast.WS['Refulgent Arrow'] = sets.precast.WS['Sidewinder']
  --sets.precast.WS['Refulgent Arrow'].Mid = sets.precast.WS['Sidewinder'].Mid
  --sets.precast.WS['Refulgent Arrow'].Acc = sets.precast.WS['Sidewinder'].Acc
 
  -- Resting sets
  sets.resting = {}
 
  -- Defense sets
  sets.defense.PDT = set_combine(sets.idle, {})
  sets.defense.MDT = set_combine(sets.idle, {})
  
  sets.Kiting = {legs=gear.Carmine.legs  }
  
  sets.buff.Barrage = 
{ 
--53 STP + 7 DW Perun + 10 Aeonic gun. 1146 acc no food
  head=gear.RNGRel.Head,
  body=gear.Mummu.Body,             -- 5STP
  hands=gear.RNGAF.Hands,
  legs=gear.Adhemar.legs,           -- 7STP
  feet=gear.Adhemar.feet,  
  neck="Iskur Gorget",              -- 8STP
  waist="Kwahu Kachina Belt", 
  left_ear="Enervating Earring",    -- 4STP
  right_ear="Neritic Earring",      -- 4STP
  left_ring="Rajas Ring",           -- 5STP
  right_ring="Ilabrat Ring",        -- 5STP
  back=gear.AmbJSE.RNGSTP,          -- 10 STP
}
  
  sets.buff.Barrage.Mid = 
{    
  head=gear.RNGRel.Head,
  body=gear.Mummu.Body,
  hands=gear.RNGAF.Hands,
  legs=gear.Herculeanlegs.Ranged,
  feet=gear.Herculeanfeet.Ranged,
  neck="Iskur Gorget",
  waist="Kwahu Kachina Belt",
  left_ear="Enervating Earring",
  right_ear="Neritic Earring",
  left_ring="Dingir Ring",
  right_ring="Ilabrat Ring",
  back=gear.AmbJSE.RNGSTP
}
  
  sets.buff.Barrage.Acc = 
{    
  head=gear.Meghanada.Head,
  body=gear.Meghanada.Body,
  hands=gear.RNGAF.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Meghanada.Legs,
  neck="Iskur Gorget",
  waist="Kwahu Kachina Belt",
  left_ear="Enervating Earring",
  right_ear="Neritic Earring",
  left_ring="Cacoethic Ring +1",
  left_ring="Hajduk Ring +1",
  back=gear.AmbJSE.RNGSTP
}
  
  --sets.buff.Camouflage =  {body="Orion Jerkin +1"}
  
  sets.Overkill =  {body=gear.RNGRel.Body}
  sets.Overkill.Preshot = set_combine(sets.precast.RA, sets.Overkill)
end
function job_pretarget(spell, action, spellMap, eventArgs)
    -- If autora enabled, use WS automatically at 100+ TP
    if spell.action_type == 'Ranged Attack' then
        if player.tp >= 1000 and state.AutoRA.value == 'WS' and not buffactive.amnesia then
            cancel_spell()
            use_weaponskill()
        end
    end
end 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
        if state.Buff[spell.english] ~= nil then
            state.Buff[spell.english] = true
        end
        --add_to_chat(8, state.CombatForm)
        if sam_sj then
            classes.CustomClass = 'SAM'
        end

        if spell.action_type == 'Ranged Attack' and player.equipment.range == gear.Bow then
            state.CombatWeapon:set('Bow')
        end
        -- add support for RangedMode toggles to EES
        if spell.english == 'Eagle Eye Shot' then
            classes.JAMode = state.RangedMode.value
        end
        -- Safety checks for weaponskills 
        if spell.type:lower() == 'weaponskill' then
            if player.tp < 1000 then
                    eventArgs.cancel = true
                    return
            end
            if ((spell.target.distance >8 and spell.skill ~= 'Archery' and spell.skill ~= 'Marksmanship') or (spell.target.distance >21)) then
                -- Cancel Action if distance is too great, saving TP
                add_to_chat(122,"Outside WS Range! /Canceling")
                eventArgs.cancel = true
                return
            
            elseif state.DefenseMode.value ~= 'None' then
                -- Don't gearswap for weaponskills when Defense is on.
                eventArgs.handled = true
            end
        end
        -- Ammo checks
	    if spell.action_type == 'Ranged Attack' or
          (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
            check_ammo(spell, action, spellMap, eventArgs)
        end
end
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
-- This is where you place gear swaps you want in precast but applied on top of the precast sets
function job_post_precast(spell, action, spellMap, eventArgs)
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
    elseif state.Buff.Overkill then
        equip(sets.Overkill.Preshot)
    end
    if spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    -- Barrage
    if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
        if state.RangedMode.current == 'Mid' then
            equip(sets.buff.Barrage.Mid)
        elseif state.RangedMode.current == 'Acc' then
            equip(sets.buff.Barrage.Acc)
        else
            equip(sets.buff.Barrage.Acc)
        end
        eventArgs.handled = true
    end
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
    end
    if state.Buff.Overkill then
        equip(sets.Overkill)
    end
    if spell.action_type == 'Ranged Attack' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- autora
    if state.AutoRA.value ~= 'Normal' then
        use_ra(spell)
    end
    if state.Buff[spell.name] ~= nil then
        state.Buff[spell.name] = not spell.interrupted or buffactive[spell.english]
    end
end
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    --if S{"courser's roll"}:contains(buff:lower()) then
    --if string.find(buff:lower(), 'samba') then
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
        handle_equipping_gear(player.status)
    end
    if buff == 'Velocity Shot' and gain then
        windower.send_command('wait 290;input /echo **VELOCITY SHOT** Wearing off in 10 Sec.')
    elseif buff == 'Double Shot' and gain then
        windower.send_command('wait 90;input /echo **DOUBLE SHOT OFF**;wait 90;input /echo **DOUBLE SHOT READY**')
    elseif buff == 'Decoy Shot' and gain then
        windower.send_command('wait 170;input /echo **DECOY SHOT** Wearing off in 10 Sec.];wait 120;input /echo **DECOY SHOT READY**')
    end
    if  buff == "Samurai Roll" or buff == "Courser's Roll" or string.find(buff:lower(), 'flurry') then
        classes.CustomRangedGroups:clear()
        if (buff == "Samurai Roll" and gain) or buffactive['Samurai Roll'] then
            classes.CustomRangedGroups:append('SamRoll')
        end
    end
    if buff == "Camouflage" then
        if gain then
            equip(sets.buff.Camouflage)
            disable('body')
        else
            enable('body')
        end
    end
    if buff == "Camouflage" or buff == "Overkill" or buff == "Samurai Roll" or buff == "Courser's Roll" then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
    --select_earring()
end
function customize_idle_set(idleSet)
    if state.HybridMode.value == 'PDT' then
        state.IdleMode.value = 'PDT'
    elseif state.HybridMode.value ~= 'PDT' then
        state.IdleMode.value = 'Normal'
    end
	if state.Buff.Camouflage then
		idleSet = set_combine(idleSet, sets.buff.Camouflage)
	end
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    return idleSet
end
function customize_melee_set(meleeSet)
    if state.Buff.Camouflage then
    	meleeSet = set_combine(meleeSet, sets.buff.Camouflage)
    end
    if state.Buff.Overkill then
    	meleeSet = set_combine(meleeSet, sets.Overkill)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" and player.equipment.range == gear.Bow then
         state.CombatWeapon:set('Bow')
    end

    if camo_active() then
        disable('body')
    else
        enable('body')
    end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
    get_custom_ranged_groups()
    sam_sj = player.sub_job == 'SAM' or false
    -- called here incase buff_change failed to update value
    state.Buff.Camouflage = buffactive.camouflage or false
    state.Buff.Overkill = buffactive.overkill or false

    if camo_active() then
        disable('body')
    else
        enable('body')
    end
end
 
---- Job-specific toggles.
--function job_toggle_state(field)
--    if field:lower() == 'autora' then
--        state.AutoRA = not state.AutoRA
--        return state.AutoRA
--    end
--end
 
---- Request job-specific mode lists.
---- Return the list, and the current value for the requested field.
--function job_get_option_modes(field)
--    if field:lower() == 'autora' then
--        return state.AutoRA
--    end
--end
-- 
---- Set job-specific mode values.
---- Return true if we recognize and set the requested field.
--function job_set_option_mode(field, val)
--    if field:lower() == 'autora' then
--        state.AutoRA = val
--        return true
--    end
--end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    if state.AutoRA.value ~= 'Normal' then
        msg = '[Auto RA: ON]['..state.AutoRA.value..']'
    else
        msg = '[Auto RA: OFF]'
    end

    add_to_chat(122, 'Ranged: '..state.RangedMode.value..'/'..state.HybridMode.value..', WS: '..state.WeaponskillMode.value..', '..msg)
    
    eventArgs.handled = true
 
end
-- Special WS mode for Sam subjob
function get_custom_wsmode(spell, spellMap, ws_mode)
    if spell.skill == 'Archery' or spell.skill == 'Marksmanship' then
        if player.sub_job == 'SAM' then
            return 'SAM'
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    if S{'NIN', 'DNC'}:contains(player.sub_job) and rng_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
    else
        state.CombatForm:reset()
    end
end

function get_custom_ranged_groups()
	classes.CustomRangedGroups:clear()
    
    if buffactive['Samurai Roll'] then
        classes.CustomRangedGroups:append('SamRoll')
    end

end

function use_weaponskill()
    if player.equipment.range == gear.Bow then
        send_command('input /ws "'..auto_bow_ws..'" <t>')
    elseif player.equipment.range == gear.Gun then
        send_command('input /ws "'..auto_gun_ws..'" <t>')
    end
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Auto RA' then
        if newValue ~= 'Normal' then
            send_command('@wait 2.5; input /ra <t>')
        end
    end
end

function use_ra(spell)
    
    local delay = '2.2'
    -- BOW
    if player.equipment.range == gear.Bow then
        if spell.type:lower() == 'weaponskill' then
            delay = '2.25'
         else
             if buffactive["Courser's Roll"] then
                 delay = '0.7' -- MAKE ADJUSTMENT HERE
             elseif buffactive["Flurry II"] or buffactive.Overkill then
                 delay = '0.5'
             else
                delay = '1.05' -- MAKE ADJUSTMENT HERE
            end
        end
    else
    -- GUN 
        if spell.type:lower() == 'weaponskill' then
            delay = '2.25' 
        else
            if buffactive["Courser's Roll"] then
                delay = '0.7' -- MAKE ADJUSTMENT HERE
            elseif buffactive.Overkill or buffactive['Flurry II'] then
                delay = '0.5'
            else
                delay = '1.05' -- MAKE ADJUSTMENT HERE
            end
        end
    end
    send_command('@wait '..delay..'; input /ra <t>')
end

function camo_active()
    return state.Buff['Camouflage']
end
-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
	-- Filter ammo checks depending on Unlimited Shot
	if state.Buff['Unlimited Shot'] then
		if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
			if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
				equip({ammo=U_Shot_Ammo[player.equipment.range]})
			elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
				equip({ammo=DefaultAmmo[player.equipment.range]})
			else
				add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
			end
		end
	else
		if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
					equip({ammo=empty})
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
				equip({ammo=empty})
			end
		elseif player.equipment.ammo == 'empty' then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
			end
		elseif player.inventory[player.equipment.ammo].count < 15 then
			add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
		end
	end
end
-- Orestes uses Samurai Roll. The total comes to 5!
--function detect_cor_rolls(old,new,color,newcolor)
--    if string.find(old,'uses Samurai Roll. The total comes to') then
--        add_to_chat(122,"SAM Roll")
--    end
--end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR'then
		    set_macro_page(3, 5)
	elseif player.sub_job == 'SAM' then
		    set_macro_page(4, 5)
	else
		set_macro_page(3, 5)
	end
end
