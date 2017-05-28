-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[	Custom Features:
Haste Detection		
Detects current magic haste level and equips corresponding engaged set to optimize delay reduction (automatic)
Haste Mode Toggles between Haste II and Haste I recieved, used by Haste Detection [WinKey-H]
Capacity Pts. Mode	Capacity Points Mode Toggle [WinKey-C]
Auto. Lockstyle Automatically locks specified equipset on file load
--]]
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
  
	state.Buff.Barrage = buffactive.Barrage or false
	state.Buff.Camouflage = buffactive.Camouflage or false
  
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
	state.Buff['Velocity Shot'] = buffactive['Velocity Shot'] or false
	state.Buff['Double Shot'] = buffactive['Double Shot'] or false

	state.FlurryMode = M{['description']='Flurry Mode', 'Flurry II', 'Flurry I'}
	state.HasteMode = M{['description']='Haste Mode', 'Haste II', 'Haste I'}

	-- Whether a warning has been given for low ammo
  
	state.warned = M(false)

	determine_haste_group()
  
end
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  
	state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
	state.RangedMode:options('STP', 'Normal', 'Acc', 'Critical')
  state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
	state.IdleMode:options('Normal', 'DT')
	
	state.CP = M(false, "Capacity Points Mode")
	
	gear.RAbullet = "Chrono Bullet"
	gear.WSbullet = "Chrono Bullet"
	gear.MAbullet = "Chrono Bullet"
	options.ammo_warning_limit = 10

	-- Additional local binds
	send_command('bind ^` input /ja "Velocity Shot" <me>')
	send_command ('bind @` input /ja "Scavenge" <me>')

	if player.sub_job == 'DNC' then
		send_command('bind ^, input /ja "Spectral Jig" <me>')
		send_command('unbind ^.')
	else
		send_command('bind ^, input /item "Silent Oil" <me>')
		send_command('bind ^. input /item "Prism Powder" <me>')
	end

	send_command('bind @f gs c cycle FlurryMode')
	send_command('bind @h gs c cycle HasteMode')
	send_command('bind @c gs c toggle CP')

	send_command('bind ^numlock input /ja "Double Shot" <me>')

	if player.sub_job == 'WAR' then
		send_command('bind ^numpad/ input /ja "Berserk" <me>')
		send_command('bind ^numpad* input /ja "Warcry" <me>')
		send_command('bind ^numpad- input /ja "Aggressor" <me>')
	elseif player.sub_job == 'SAM' then
		send_command('bind ^numpad/ input /ja "Meditate" <me>')
		send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
		send_command('bind ^numpad- input /ja "Third Eye" <me>')
	end
	send_command('bind ^numpad7 input /ws "Trueflight" <t>')
	send_command('bind !numpad7 input /ws "Apex Arrow" <t>')
	send_command('bind @numpad7 input /ws "Exenterator" <t>')
	send_command('bind ^numpad8 input /ws "Last Stand" <t>')
	send_command('bind !numpad8 input /ws "Jishnu\'s Radiance" <t>')
	send_command('bind @numpad8 input /ws "Decimation" <t>')
	send_command('bind ^numpad4 input /ws "Wildfire" <t>')
	send_command('bind @numpad4 input /ws "Evisceration" <t>')
	send_command('bind @numpad5 input /ws "Namas Arrow" <t>')

	send_command('bind numpad0 input /ra <t>')

	select_default_macro_book()
  
	set_lockstyle()
  
end
-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind @`')
	send_command('unbind ^,')
	send_command('unbind @f')
	send_command('unbind @h')
	send_command('unbind @c')
	send_command('unbind ^numlock')
	send_command('unbind ^numpad/')
	send_command('unbind ^numpad*')
	send_command('unbind ^numpad-')
	send_command('unbind ^numpad7')
	send_command('unbind !numpad7')
	send_command('unbind @numpad7')
	send_command('unbind ^numpad8')
	send_command('unbind !numpad8')
	send_command('unbind @numpad8')
	send_command('unbind ^numpad4')
	send_command('unbind @numpad4')
	send_command('unbind @numpad5')
	send_command('unbind numpad0')
end
-- Set up all gear sets.
function init_gear_sets()

	include('augmented-items.lua')

	------------------------------------------------------------------------------------------------
	---------------------------------------- Precast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Eagle Eye Shot'] = {legs=gear.RNGRel.Legs}
	sets.precast.JA['Bounty Shot'] = {hands=gear.RNGAF3.Hands}
  sets.precast.JA['Camouflage'] = {body=gear.RNGAF.Body}
  sets.precast.JA['Scavenge'] = {feet=gear.RNGAF.Feet}
  sets.precast.JA['Shadowbind'] = {hands=gear.RNGAF.Hands}
  sets.precast.JA['Sharpshot'] = {legs=gear.RNGAF.Legs}


	-- Fast cast sets for spells

	sets.precast.Waltz = {}

	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.FC =     -- 45 FC 
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

	-- (10% Snapshot, 5% Rapid from Merits)
	sets.precast.RA = -- 63% snap. need to get to 70. 26 Rapid.
{
  head=gear.RNGAF3.Head,          -- 7 Snap 0 Rapid
  body=gear.Pursuers.body,        -- 6 Snap 0 Rapid
  hands=gear.Carmine.hands,       -- 8 Snap 11 Rapid
  legs=gear.Adhemar.legs,         -- 9 Snap 10 Rapid
  feet=gear.Meghanada.Feet,       -- 10 Snap
  neck="Loricate Torque +1",
  waist="Impulse Belt",           -- 3 Snap
  left_ear="Etiolation Earring",
  right_ear="Odnowa Earring +1",
  left_ring="Defending Ring",
  right_ring="Patricius Ring",
  back=gear.AmbJSE.RNGSnap        --10 Snap
}

	-- (10% Snapshot, 5% Rapid from Merits 15% from Flurry I) Shoot for 45 Snap 
	sets.precast.RA.Flurry1 =       -- 44 Snap 38 Rapid
{
  head=gear.RNGAF3.Head,          -- 7 Snap  0 Rapid
  body=gear.RNGRel.Body,          --         12 Rapid
  hands=gear.Carmine.hands,       -- 8 Snap  11 Rapid
  legs=gear.Adhemar.legs,         -- 9 Snap  10 Rapid
  feet=gear.Meghanada.Feet,       -- 10 Snap
  neck="Loricate Torque +1",
  waist="Yemaya Belt",            --         5 Rapid
  left_ear="Etiolation Earring",
  right_ear="Odnowa Earring +1",
  left_ring="Defending Ring",
  right_ring="Patricius Ring",
  back=gear.AmbJSE.RNGSnap        --10 Snap
}

	-- (10% Snapshot, 5% Rapid from Merits 30% from Flurry I) Shoot for 30 Snap 
	sets.precast.RA.Flurry2 =       -- 34 Snap 48 Rapid
{
  head=gear.RNGAF3.Head,          -- 7 Snap 0 Rapid
  body=gear.RNGRel.Body,          --        12 Rapid
  hands=gear.Carmine.hands,       -- 8 Snap 11 Rapid
  legs=gear.Adhemar.legs,         -- 9 Snap 10 Rapid
  feet=gear.Pursuers.feet,        --        10 Rapid
  neck="Loricate Torque +1",
  waist="Yemaya Belt",            --         5 Rapid
  left_ear="Etiolation Earring",
  right_ear="Odnowa Earring +1",
  left_ring="Defending Ring",
  right_ring="Patricius Ring",
  back=gear.AmbJSE.RNGSnap        --10 Snap
}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = 
{
  ammo=gear.RAbullet,
  left_ear="Enervating Earring", 
  left_ring="Dingir Ring",  
  head=gear.RNGAF.Head,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Adhemar.legs,
  feet=gear.Adhemar.feet,
  neck="Fotia Gorget",
  waist="Fotia Belt",
  right_ear=gear.Moonshade.WS,
  right_ring="Ilabrat Ring",
  back=gear.AmbJSE.RNGMWS
}

  sets.precast.WS.Mid = 
{
  ammo=gear.RAbullet,
  left_ear="Enervating Earring",
  left_ring="Dingir Ring",    
  head=gear.RNGAF.Head,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Adhemar.feet,
  neck="Fotia Gorget",
  waist="Fotia Belt",
  right_ear=gear.Moonshade.WS,
  right_ring="Hajduk Ring +1",
  back=gear.AmbJSE.RNGWS
}

  sets.precast.WS.Acc = 
{
  ammo=gear.RAbullet,
  left_ear="Enervating Earring",
  left_ring="Hajduk Ring +1",  
  head=gear.Meghanada.Head,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Meghanada.Feet,
  neck="Iskur Gorget",
  waist="Kwahu Kachina Belt",
  right_ear="Neritic Earring",  
  right_ring="Hajduk Ring +1",
  back=gear.AmbJSE.RNGWS
}


	------------------------------------------------------------------------------------------------
	------------------------------------- Weapon Skill Sets ----------------------------------------
	------------------------------------------------------------------------------------------------

	sets.precast.WS['Apex Arrow'] = {}
  sets.precast.WS['Apex Arrow'].Mid = {}
	sets.precast.WS['Apex Arrow'].Acc = {}

  sets.precast.WS['Jishnu\'s Radiance'] = {}
  sets.precast.WS['Jishnu\'s Radiance'].Mid = {}
  sets.precast.WS['Jishnu\'s Radiance'].Acc = {}
  
  sets.precast.WS['Namas Arrow'] = 
{
  left_ear="Enervating Earring",
  left_ring="Dingir Ring", 
  head=gear.RNGAF.Head,
  body=gear.RNGAF.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Meghanada.Feet,
  neck="Fotia Gorget",
  waist="Fotia Belt",
  right_ear="Sherida Earring",
  right_ring="Ilabrat Ring",  
  back=gear.AmbJSE.RNGWS
}

  sets.precast.WS['Namas Arrow'].Mid = 
{
  left_ear="Enervating Earring",
  left_ring="Dingir Ring", 
  head=gear.RNGAF.Head,
  body=gear.RNGAF.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Meghanada.Feet,
  neck="Fotia Gorget",
  waist="Fotia Belt",
  right_ear="Sherida Earring",
  right_ring="Ilabrat Ring",  
  back=gear.AmbJSE.RNGWS
}

  sets.precast.WS['Namas Arrow'].Acc = 
{
  left_ear="Enervating Earring",
  left_ring="Hajduk Ring +1",
  head=gear.RNGAF.Head,
  body=gear.RNGAF.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Meghanada.Feet,
  neck="Fotia Gorget",
  waist="Fotia Belt",
  right_ear="Neritic Earring",
  right_ring="Hajduk Ring +1",
  back=gear.AmbJSE.RNGWS
}

	sets.precast.WS['Last Stand'] = 
{
  ammo=gear.RAbullet,
  left_ear="Enervating Earring",
  left_ring="Dingir Ring", 
  head=gear.RNGAF.Head,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Adhemar.legs,
  feet=gear.Adhemar.feet,
  neck="Fotia Gorget",
  waist="Fotia Belt",
  right_ear=gear.Moonshade.WS,
  right_ring="Ilabrat Ring",  
  back=gear.AmbJSE.RNGWS
}

  sets.precast.WS['Last Stand'].Mid = 
{
  ammo=gear.RAbullet,
  left_ear="Enervating Earring",
  left_ring="Dingir Ring",    
  head=gear.RNGAF.Head,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Adhemar.feet,
  neck="Fotia Gorget",
  waist="Fotia Belt",
  right_ear=gear.Moonshade.WS,
  right_ring="Hajduk Ring +1",
  back=gear.AmbJSE.RNGWS
}

	sets.precast.WS['Last Stand'].Acc = 
{
  ammo=gear.RAbullet,
  left_ear="Enervating Earring",
  left_ring="Hajduk Ring +1",
  head=gear.Meghanada.Head,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Meghanada.Feet,
  neck="Iskur Gorget",
  waist="Kwahu Kachina Belt",
  right_ear="Neritic Earring",  
  right_ring="Hajduk Ring +1",
  back=gear.AmbJSE.RNGWS
}

	sets.precast.WS['Wildfire'] = 
{
  ammo=gear.MAbullet,
  left_ear="Hermetic Earring",  
  left_ring="Dingir Ring",  
  head=gear.Herculeanhead.Magic,
  body=gear.Herculeanbody.Magic,
  hands=gear.Carmine.hands,
  legs=gear.Herculeanlegs.Magic,
  feet=gear.Herculeanfeet.Magic,
  neck="Sanctity Necklace",
  waist="Kwahu Kachina Belt",
  right_ear="Friomisi Earring",
  right_ring="Ilabrat Ring",
  back=gear.AmbJSE.RNGMWS
}

  sets.precast.WS['Wildfire'].Mid = 
{
  ammo=gear.MAbullet,
  left_ear="Gwati Earring",  
  left_ring="Dingir Ring",  
  head=gear.Herculeanhead.Magic,
  body=gear.Herculeanbody.Magic,
  hands=gear.Mummu.Hands,
  legs=gear.Mummu.Legs,
  feet=gear.Herculeanfeet.Magic,
  neck="Sanctity Necklace",
  waist="Kwahu Kachina Belt",
  right_ear="Digni. Earring",
  right_ring="Ilabrat Ring",
  back=gear.AmbJSE.RNGMWS
}

  sets.precast.WS['Wildfire'].Acc = 
{
  ammo=gear.MAbullet,
  left_ear="Gwati Earring",  
  left_ring="Etana Ring",  
  head=gear.Mummu.Head,
  body=gear.Mummu.Body,
  hands=gear.Mummu.Hands,
  legs=gear.Mummu.Legs,
  feet=gear.Mummu.Feet,
  neck="Sanctity Necklace",
  waist="Kwahu Kachina Belt",
  right_ear="Digni. Earring",
  right_ring="Vertigo Ring",
  back=gear.AmbJSE.RNGMWS
}  

	sets.precast.WS['Trueflight'] = sets.precast.WS['Wildfire']
	sets.precast.WS['Trueflight'].Mid = sets.precast.WS['Wildfire'].Mid
  sets.precast.WS['Trueflight'].Acc = sets.precast.WS['Wildfire'].Acc
	sets.precast.WS['Trueflight'].FullTP = {}
  
  -- Other WS --
	sets.precast.WS['Rampage'] = {}
	sets.precast.WS['Rampage'].Mid = {}
  sets.precast.WS['Rampage'].Acc = {}
  
  sets.precast.WS['Decimation'] = {}
	sets.precast.WS['Decimation'].Mid = {}
  sets.precast.WS['Decimation'].Acc = {} 
  
  sets.precast.WS['Evisceration'] = {}
	sets.precast.WS['Evisceration'].Mid = {}
  sets.precast.WS['Evisceration'].Acc ={}

------------------------------------------------------------------------------------------------
	---------------------------------------- Midcast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

	-- Fast recast for spells
	
	sets.midcast.FastRecast = sets.precast.FC
	sets.midcast.SpellInterrupt = {}
	sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
  
	-- Ranged sets

	sets.midcast.RA = -- 1233 R. Acc no food. 40 STP without weapons.
{ 
  ammo=gear.RAbullet,
  left_ear="Enervating Earring",  -- 4STP  
  left_ring="Dingir Ring",  
  head=gear.RNGRel.Head,
  body=gear.Mummu.Body,           -- 5STP
  hands=gear.Adhemar.hands,       -- 6STP
  legs=gear.Herculeanlegs.Ranged, -- 4STP
  feet=gear.Herculeanfeet.Ranged, 
  neck="Iskur Gorget",            -- 8STP
  waist="Yemaya Belt",            -- 4STP
  right_ear="Neritic Earring",    -- 4STP
  right_ring="Ilabrat Ring",      -- 5STP
  back=gear.AmbJSE.RNGSTP         -- 10STP
}	
	
	sets.midcast.RA.Acc = 
{ --1322 R. Acc
  ammo=gear.RAbullet,
  left_ear="Enervating Earring",  
  left_ring="Hajduk Ring +1",  
  head=gear.Meghanada.Head,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Meghanada.Feet,
  neck="Iskur Gorget",
  waist="Kwahu Kachina Belt",
  right_ear="Neritic Earring",
  right_ring="Hajduk Ring +1",
  back=gear.AmbJSE.RNGSTP
}

	sets.midcast.RA.Critical =
{    
  ammo=gear.RAbullet,
  left_ear="Enervating Earring",  
  left_ring="Dingir Ring",  
  head=gear.Mummu.Head,
  body=gear.Mummu.Body,
  hands="Kobo Kote",
  legs=gear.Mummu.Legs,
  feet=gear.Adhemar.feet,
  neck="Iskur Gorget",
  waist="Kwahu Kachina Belt",
  right_ear="Neritic Earring",
  right_ring="Ilabrat Ring",
  back=gear.AmbJSE.RNGSTP
}
		
	sets.midcast.RA.STP = --1113 r. acc no food. 56 STP without weapons. 
{ 
  ammo=gear.RAbullet,
  right_ear="Sherida Earring",   -- 5STP  
  left_ring="Petrov Ring",      -- 5STP  
  head=gear.RNGRel.Head,
  body=gear.Pursuers.body,      -- 6STP
  hands=gear.Carmine.hands,     -- 6STP
  legs=gear.Adhemar.legs,       -- 7STP
  feet=gear.Adhemar.feet,
  neck="Iskur Gorget",          -- 8STP
  waist="Yemaya Belt",          -- 4STP
  left_ear="Tripudio Earring", -- 5STP
  right_ring="Ilabrat Ring",    -- 5STP
  back=gear.AmbJSE.RNGSTP       -- 10 STP
}
  
	------------------------------------------------------------------------------------------------
	----------------------------------------- Idle Sets --------------------------------------------
	------------------------------------------------------------------------------------------------

	sets.resting = {}

	-- Idle sets
  sets.idle = 
{
  left_ear="Etiolation Earring",  
  left_ring="Dingir Ring", 
  head=gear.Carmine.head.HQ,
  body=gear.Herculeanbody.Magic,
  hands=gear.Carmine.hands,
  legs=gear.Carmine.legs,
  feet=gear.Carmine.feet,
  neck="Iskur Gorget",
  waist="Flume Belt +1",
  right_ear="Sherida Earring",
  right_ring="Ilabrat Ring", 
  back="Moonbeam Cape"
}

	sets.idle.DT = sets.idle 
	sets.idle.Town = sets.idle
  
	------------------------------------------------------------------------------------------------
	---------------------------------------- Defense Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

	sets.defense.PDT = sets.idle.DT
	sets.defense.MDT = sets.idle.DT
	sets.Kiting = {legs=gear.Carmine.legs}


	------------------------------------------------------------------------------------------------
	---------------------------------------- Engaged Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- * DNC Subjob DW Trait: +15%
	-- * NIN Subjob DW Trait: +25%
	
	-- No Magic Haste (74% DW to cap)	
	sets.engaged =  -- 41%
{
  left_ear="Cessance Earring",  
  left_ring="Epona's Ring",  
  head=gear.Dampening.Cap,
  body=gear.Herculeanbody.Crit,
  hands=gear.Herculeanhands.Triple,
  legs=gear.Samnuhalegs,
  feet=gear.Herculeanfeet.Triple,
  neck="Clotharius Torque",
  waist="Windbuffet Belt +1",
  right_ear="Brutal Earring",
  right_ring="Petrov Ring",
  back="Ground. Mantle +1"
}
	sets.engaged.LowAcc = {}
	sets.engaged.MidAcc = {}
	sets.engaged.HighAcc = {}
	sets.engaged.STP = {}
  
		-- 15% Magic Haste (67% DW to cap)
	sets.engaged.LowHaste = {}
	sets.engaged.LowAcc.LowHaste = {}
	sets.engaged.MidAcc.LowHaste = {}
	sets.engaged.HighAcc.LowHaste = {}
	sets.engaged.STP.LowHaste = {}

	-- 30% Magic Haste (56% DW to cap)
	sets.engaged.MidHaste = {}
	sets.engaged.LowAcc.MidHaste = {}
	sets.engaged.MidAcc.MidHaste = {}
	sets.engaged.HighAcc.MidHaste = {}
	sets.engaged.STP.MidHaste = {}

	-- 35% Magic Haste (51% DW to cap)
	sets.engaged.HighHaste = {}
	sets.engaged.LowAcc.HighHaste = {}
	sets.engaged.MidAcc.HighHaste = {}
	sets.engaged.HighAcc.HighHaste = {}
	sets.engaged.STP.HighHaste = {}

	-- 47% Magic Haste (36% DW to cap)
	sets.engaged.MaxHaste = {}
	sets.engaged.LowAcc.MaxHaste = {}
	sets.engaged.MidAcc.MaxHaste = {}
	sets.engaged.HighAcc.MaxHaste = {}
	sets.engaged.STP.MaxHaste = {}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = 
{    
  ammo=gear.RAbullet,
  left_ear="Enervating Earring",  
  left_ring="Hajduk Ring +1",  
  head=gear.Meghanada.Head,
  body=gear.Meghanada.Body,
  hands=gear.RNGAF.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Meghanada.Legs,
  neck="Iskur Gorget",
  waist="Kwahu Kachina Belt",
  right_ear="Neritic Earring",
  right_ring="Hajduk Ring +1", 
  back=gear.AmbJSE.RNGSTP
}
	sets.buff['Velocity Shot'] = 
  set_combine(sets.midcast.RA, {body=gear.RNGAF3.Body, back=gear.AmbJSE.RNGSTP})
  
	sets.buff['Double Shot'] = 
  set_combine(sets.midcast.RA, {head=gear.RNGAF3.Head,back=gear.AmbJSE.RNGSTP})
  
  sets.buff.Camouflage = 
{    
  ammo=gear.RAbullet,
  left_ear="Enervating Earring",  
  left_ring="Dingir Ring",  
  head=gear.Mummu.Head,
  body=gear.RNGAF.Body,
  hands="Kobo Kote",
  legs=gear.Mummu.Legs,
  feet=gear.Adhemar.feet,
  neck="Iskur Gorget",
  waist="Kwahu Kachina Belt",
  right_ear="Neritic Earring",
  right_ring="Ilabrat Ring",
  back=gear.AmbJSE.RNGSTP
}

	sets.buff.Doom = {}

	sets.Obi = {}
	sets.Reive = {}
	sets.CP = {back="Mecisto. Mantle"}

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
end

function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
--		if state.Buff['Velocity Shot'] then
--			equip( sets.buff['Velocity Shot'])
--		end
		if state.FlurryMode.value == 'Flurry II' and (buffactive[265] or buffactive[581]) then
			equip(sets.precast.RA.Flurry2)
		elseif state.FlurryMode.value == 'Flurry I' and (buffactive[265] or buffactive[581]) then
			equip(sets.precast.RA.Flurry1)
		end
	end
	-- Equip obi if weather/day matches for WS.
    if spell.type == 'WeaponSkill' then
		if spell.english == 'Trueflight' then
			if world.weather_element == 'Light' or world.day_element == 'Light' then
				equip(sets.Obi)
			end
			if player.tp > 2900 then
				equip(sets.precast.WS['Trueflight'].FullTP)
			end	
		elseif spell.english == 'Wildfire' and (world.weather_element == 'Fire' or world.day_element == 'Fire') then
			equip(sets.Obi)
		end
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
		equip(sets.buff.Barrage)
	end
--	if spell.action_type == 'Ranged Attack' and state.Buff['Velocity Shot'] and state.RangedMode.value == 'STP' then
--		equip(sets.buff['Velocity Shot'])
--	end
end


function job_aftercast(spell, action, spellMap, eventArgs)
	if spell.english == "Shadowbind" then
		send_command('@timers c "Shadowbind ['..spell.target.name..']" 42 down abilities/00122.png')
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
		determine_haste_group()
		if not midaction() then
			handle_equipping_gear(player.status)
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

--	if buffactive['Reive Mark'] then
--		if gain then		   
--			equip(sets.Reive)
--			disable('neck')
--		else
--			enable('neck')
--		end
--	end

	if buff == "doom" then
		if gain then		   
			equip(sets.buff.Doom)
			send_command('@input /p Doomed.')
			disable('ring1','ring2','waist')
		else
			enable('ring1','ring2','waist')
			handle_equipping_gear(player.status)
		end
	end

end

function job_status_change(new_status, old_status)
	if new_status == 'Engaged' then
		determine_haste_group()
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if state.CP.current == 'on' then
		equip(sets.CP)
		disable('back')
	else
		enable('back')
	end
	
	return idleSet
end

function job_update(cmdParams, eventArgs)
	determine_haste_group()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.

function job_update(cmdParams, eventArgs)
	determine_haste_group()
end

function display_current_job_state(eventArgs)
	local msg = ''
	
	msg = msg .. '[ Offense/Ranged: '..state.OffenseMode.current..'/'..state.RangedMode.current
	msg = msg .. ' ][ WS: '..state.WeaponskillMode.current

	if state.DefenseMode.value ~= 'None' then
		msg = msg .. ' ][ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
	end
	
	if state.Kiting.value then
		msg = msg .. ' ][ Kiting Mode: ON'
	end

	msg = msg .. ' ]'
	
	add_to_chat(060, msg)

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()

	-- Gearswap can't detect the difference between Haste I and Haste II
	-- so use winkey-H to manually set Haste spell level.

	-- Haste (buffactive[33]) - 15%
	-- Haste II (buffactive[33]) - 30%
	-- Haste Samba - 5%/10%
	-- Victory March +0/+3/+4/+5	9.4%/14%/15.6%/17.1%
	-- Advancing March +0/+3/+4/+5  6.3%/10.9%/12.5%/14% 
	-- Embrava - 30%
	-- Mighty Guard (buffactive[604]) - 15%
	-- Geo-Haste (buffactive[580]) - 40%

	classes.CustomMeleeGroups:clear()

	if state.HasteMode.value == 'Haste II' then
		if(((buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604])) or
			(buffactive[33] and (buffactive[580] or buffactive.embrava)) or
			(buffactive.march == 2 and buffactive[604]) or buffactive.march == 3) then
			add_to_chat(122, 'Magic Haste Level: 43%')
			classes.CustomMeleeGroups:append('MaxHaste')
		elseif ((buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba']) then
			add_to_chat(122, 'Magic Haste Level: 35%')
			classes.CustomMeleeGroups:append('HighHaste')
		elseif ((buffactive[580] or buffactive[33] or buffactive.march == 2) or
			(buffactive.march == 1 and buffactive[604])) then
			add_to_chat(122, 'Magic Haste Level: 30%')
			classes.CustomMeleeGroups:append('MidHaste')
		elseif (buffactive.march == 1 or buffactive[604]) then
			add_to_chat(122, 'Magic Haste Level: 15%')
			classes.CustomMeleeGroups:append('LowHaste')
		end
	else
		if (buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or
			(buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604])) or
			(buffactive.march == 2 and (buffactive[33] or buffactive[604])) or
			(buffactive[33] and buffactive[604] and buffactive.march ) or buffactive.march == 3 then
			add_to_chat(122, 'Magic Haste Level: 43%')
			classes.CustomMeleeGroups:append('MaxHaste')
		elseif ((buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or
			(buffactive.march == 2 and buffactive['haste samba']) or
			(buffactive[580] and buffactive['haste samba'] ) then
			add_to_chat(122, 'Magic Haste Level: 35%')
			classes.CustomMeleeGroups:append('HighHaste')
		elseif (buffactive.march == 2 ) or
			((buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
			(buffactive[580] ) or  -- geo haste
			(buffactive[33] and buffactive[604]) then
			add_to_chat(122, 'Magic Haste Level: 30%')
			classes.CustomMeleeGroups:append('MidHaste')
		elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
			add_to_chat(122, 'Magic Haste Level: 15%')
			classes.CustomMeleeGroups:append('LowHaste')
		end
	end
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
		elseif player.inventory[player.equipment.ammo].count < 10 then
			add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
		end
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
	elseif spell.action_type == 'Ranged Attack' then
		bullet_name = gear.RAbullet
		if buffactive['Double Shot'] then
			bullet_min_count = 2
		end
	end
	
	local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
	
	-- If no ammo is available, give appropriate warning and end.
	if not available_bullets then
		if spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
			add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
			return
		else
			add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
			eventArgs.cancel = true
			return
		end
	end
	
	-- Low ammo warning.
	if state.warned.value == false
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
	-- Default macro set/book: (set, book)
	if player.sub_job == 'DNC' then
		set_macro_page(1, 6)	
	else
		set_macro_page(2, 6)	
	end
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 5')
end
