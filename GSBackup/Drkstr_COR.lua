-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[    Custom Features:

  QuickDraw Selector    Cycle through available primary and secondary shot types, and trigger with a single macro.
  Haste Detection       Detects current magic haste level and equips corresponding engaged set to optimize delay reduction (automatic)
  Haste Mode            Toggles between Haste II and Haste I recieved, used by Haste Detection [WinKey-H]
  Capacity Pts. Mode    Capacity Points Mode Toggle [WinKey-C]
  Auto. Lockstyle       Automatically locks specified equipset on file load
--]]
-------------------------------------------------------------------------------------------------------------------
--[[

  Custom commands:
  
  gs c qd
  Uses the currently configured shot on the target, with either <t> or <stnpc> depending on setting.

  gs c qd t
  Uses the currently configured shot on the target, but forces use of <t>.
  
  Configuration commands:
  
  gs c cycle mainqd
  Cycles through the available steps to use as the primary shot when using one of the above commands.

  gs c cycle altqd
  Cycles through the available steps to use for alternating with the configured main shot.
  
  gs c toggle usealtqd
  Toggles whether or not to use an alternate shot.
  
  gs c toggle selectqdtarget
  Toggles whether or not to use <stnpc> (as opposed to <t>) when using a shot.
  
  gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
  
  Offense mode is melee or ranged.  
  Used ranged offense mode if you are engaged for ranged weaponskills, but not actually meleeing.
  
  Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
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
  
  -- QuickDraw Selector
  
  state.Mainqd = 
M{['description']='Primary Shot', 'Light Shot', 'Dark Shot'}
  
  state.Altqd = 
M{['description']='Secondary Shot', 'Earth Shot', 'Water Shot', 'Wind Shot', 'Fire Shot', 'Ice Shot', 'Thunder Shot'}
  
  state.UseAltqd = M(false, 'Use Secondary Shot')
  
  state.SelectqdTarget = M(false, 'Select Quick Draw Target')
  
  state.IgnoreTargetting = M(false, 'Ignore Targetting')

  state.FlurryMode = M{['description']='Flurry Mode', 'Flurry II', 'Flurry I'}
  
  state.HasteMode = M{['description']='Haste Mode', 'Haste II', 'Haste I'}

  state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}
  
  -- Whether to use Luzaf's Ring
  state.LuzafRing = M(false, "Luzaf's Ring")
  
  -- Whether a warning has been given for low ammo
  state.warned = M(false)
  
  define_roll_values()
  
  determine_haste_group()

end
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  
  state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  
  state.HybridMode:options('Normal', 'DT')
  
  state.RangedMode:options('STP', 'Normal', 'Acc', 'Critical')
  
  state.WeaponskillMode:options('Normal', 'Acc')
  
  state.CastingMode:options('Normal', 'Resistant')
  
  state.IdleMode:options('Normal', 'DT')

  state.WeaponLock = M(false, 'Weapon Lock')    
  
	state.Gun = M{['description']='Current Gun', 'Fomalhaut', 'Compensator'}
  
  state.CP = M(false, "Capacity Points Mode")

	gear.RAbullet = "Chrono Bullet"
	gear.WSbullet = "Chrono Bullet"
	gear.MAbullet = "Chrono Bullet"
	gear.QDbullet = "Chrono Bullet"
	options.ammo_warning_limit = 20

  -- Additional local binds
  
  send_command('bind ^` input /ja "Double-up" <me>')
  send_command('bind !` input /ja "Bolter\'s Roll" <me>')
  send_command('bind ` gs c toggle LuzafRing')

  send_command('bind ^- gs c cycleback mainqd')
  send_command('bind ^= gs c cycle mainqd')
  
  send_command('bind !- gs c cycle altqd')
  send_command('bind != gs c cycleback altqd')
  
  send_command('bind ^[ gs c toggle selectqdtarget')
  send_command('bind ^] gs c toggle usealtqd')
  
  send_command('bind ^/ gs c qd')

if player.sub_job == 'DNC' then
    send_command('bind ^, input /ja "Spectral Jig" <me>')
    send_command('unbind ^.')
elseif player.sub_job == "RDM" or player.sub_job == "WHM" then
    send_command('bind ^, input /ma "Sneak" <stpc>')
    send_command('bind ^. input /ma "Invisible" <stpc>')
else
    send_command('bind ^, input /item "Silent Oil" <me>')
    send_command('bind ^. input /item "Prism Powder" <me>')
end

	send_command('bind @c gs c toggle CP')
	send_command('bind @r gs c cycle Gun')
	send_command('bind @f gs c cycle FlurryMode')
	send_command('bind @h gs c cycle HasteMode')
	send_command('bind @w gs c toggle WeaponLock')

  send_command('bind ^numlock input /ja "Triple Shot" <me>')

	if player.sub_job == 'WAR' then
		send_command('bind ^numpad/ input /ja "Berserk" <me>')
		send_command('bind ^numpad* input /ja "Warcry" <me>')
		send_command('bind ^numpad- input /ja "Aggressor" <me>')
	elseif player.sub_job == 'RNG' then
		send_command('bind ^numpad/ input /ja "Barrage" <me>')
		send_command('bind ^numpad* input /ja "Sharpshot" <me>')
		send_command('bind ^numpad- input /ja "Shadowbind" <me>')
	end

	send_command('bind ^numpad1 input /ws "Last Stand" <t>')
	send_command('bind ^numpad2 input /ws "Leaden Salute" <t>')
	send_command('bind ^numpad3 input /ws "Wildfire" <t>')

  send_command('bind numpad0 input /ra <t>')

  select_default_macro_book()
  
  set_lockstyle()
  
end
-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind `')
  
	send_command('unbind ^-')
	send_command('unbind ^=')
  
	send_command('unbind !-')
	send_command('unbind !=')
  
	send_command('unbind ^[')
	send_command('unbind ^]')
  send_command('unbind ^/')
  
	send_command('unbind ^,')
	send_command('unbind @c')
	send_command('unbind @g')
	send_command('unbind @f')
	send_command('unbind @h')
	send_command('unbind @w')
	send_command('unbind ^numlock')
	send_command('unbind ^numpad/')
	send_command('unbind ^numpad*')
	send_command('unbind ^numpad3')
	send_command('unbind ^numpad2')
	send_command('unbind ^numpad1')
	send_command('unbind numpad0')
end
-- Define sets and vars used by this job file.
function init_gear_sets()

include('augmented-items.lua')
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.precast.JA['Snake Eye'] = {legs=gear.CORRel.Legs}
  sets.precast.JA['Wild Card'] = {feet=gear.CORRel.Feet}
  sets.precast.JA['Random Deal'] = {body=gear.CORRel.Body}

	sets.precast.CorsairRoll = 
{
  head=gear.CORRel.Head,
  body=gear.Meghanada.Body,
  hands=gear.COREmpy.Hands,
  legs=gear.CORAF.Legs,
  feet=gear.Pursuers.feet,
  neck="Regal Necklace",
  waist="Flume Belt +1",
  ear1="Lempo Earring",
  ear2="Enervating Earring",
  ring1="Defending Ring",
  ring2="Kuchekula Ring",
  back=gear.AmbJSE.CORSnap
}

	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs=gear.COREmpy.Legs})
  sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet=gear.COREmpy.Feet})
  sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head=gear.COREmpy.Head})
  sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body=gear.COREmpy.Body})
  sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands=gear.COREmpy.Hands})
  
  sets.precast.LuzafRing = set_combine(sets.precast.CorsairRoll, {ring1="Luzaf's Ring"})

	sets.precast.FoldDoubleBust = {hands=gear.CORRel.Hands}
  
  sets.precast.CorsairShot = {}

	sets.precast.Waltz = {}

	sets.precast.Waltz['Healing Waltz'] = {}
  
	sets.precast.FC = -- 49 FC
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

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	-- (10% Snapshot from JP Gifts)
	sets.precast.RA =             -- 21 Rapid 68 Snap
{
  ammo=gear.RAbullet,
  head=gear.Pursuers.head,      --          10 Rapid
  body="Oshosi Vest",           -- 12 Snap 
  hands=gear.Carmine.hands,     -- 8 Snap   11 Rapid
  legs=gear.CORAF.Legs,         -- 15 Snap
  feet=gear.Meghanada.Feet,     -- 10 Snap
  neck="Loricate Torque +1",
  waist="Impulse Belt",         -- 3 Snap
  left_ear="Etiolation Earring",
  right_ear="Odnowa Earring +1",
  left_ring="Defending Ring",
  right_ring="Patricius Ring",
  back=gear.AmbJSE.CORSnap      -- 10 Snap
}

	-- (10% Snapshot from JP Gifts) 15 from Flurry
	sets.precast.RA.Flurry1 =     -- 21 Rapid 68 Snap
{
  ammo=gear.RAbullet,
  head=gear.Pursuers.head,      --          10 Rapid
  body="Oshosi Vest",           -- 12 Snap 
  hands=gear.Carmine.hands,     -- 8 Snap   11 Rapid
  legs=gear.CORAF.Legs,         -- 15 Snap
  feet=gear.Meghanada.Feet,     -- 10 Snap
  neck="Loricate Torque +1",
  waist="Impulse Belt",         -- 3 Snap
  left_ear="Etiolation Earring",
  right_ear="Odnowa Earring +1",
  left_ring="Defending Ring",
  right_ring="Patricius Ring",
  back=gear.AmbJSE.CORSnap      -- 10 Snap
}

	-- (10% Snapshot from JP Gifts) 30 from Flurry2
	sets.precast.RA.Flurry2 =     -- 21 Rapid 68 Snap
{
  ammo=gear.RAbullet,
  head=gear.Pursuers.head,      --          10 Rapid
  body="Oshosi Vest",           -- 12 Snap 
  hands=gear.Carmine.hands,     -- 8 Snap   11 Rapid
  legs=gear.CORAF.Legs,         -- 15 Snap
  feet=gear.Meghanada.Feet,     -- 10 Snap
  neck="Loricate Torque +1",
  waist="Impulse Belt",         -- 3 Snap
  left_ear="Etiolation Earring",
  right_ear="Odnowa Earring +1",
  left_ring="Defending Ring",
  right_ring="Patricius Ring",
  back=gear.AmbJSE.CORSnap      -- 10 Snap
}

	sets.precast.WS = 
{
  ammo=gear.WSbullet,
  head=gear.Meghanada.Head,
  body=gear.CORAF.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Meghanada.Legs,
  feet=gear.Meghanada.Feet,
  neck="Fotia Gorget",
  waist="Fotia Belt",       
  left_ear=gear.Moonshade.WS,
  right_ear="Brutal Earring",
  right_ring="Regal Ring",
  left_ring="Ilabrat Ring",
  back=gear.AmbJSE.CORWS
}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, 
{
  left_ear="Neritic Earring",
  right_ring="Regal Ring",
  neck="Iskur Gorget",  
  waist="Kwahu Kachina Belt",
  right_ear="Enervating Earring",
  left_ring="Hajduk Ring +1"
})

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
  right_ring="Regal Ring",
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
  right_ring="Regal Ring",
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
  neck="Sanctity Necklace",
  waist="Eschan Stone",
  ear1="Novio Earring",
  ear2="Friomisi Earring",
  left_ring="Dingir Ring",
  right_ring="Arvina Ringlet +1",
  back=gear.AmbJSE.CORMWS
}
  sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], 
  {head="Pixie Hairpin +1", Ring1="Archon Ring"})

	sets.precast.WS['Leaden Salute'].FullTP = {neck="Sanctity Necklace",waist="Svelt. Gouriz +1"}
  
	sets.precast.WS['Evisceration'] =   sets.precast.WS
	sets.precast.WS['Savage Blade'] =   sets.precast.WS
	sets.precast.WS['Savage Blade'].Acc =   sets.precast.WS
	sets.precast.WS['Requiescat'] =   sets.precast.WS
	sets.precast.WS['Requiescat'].Acc =   sets.precast.WS


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.midcast.FastRecast = sets.precast.FC
	sets.midcast.SpellInterrupt = sets.precast.FC

  sets.midcast.Cure = 
{
  head=gear.CORAF.Head,
  neck="Sanctity Necklace",
  ear1="Mendicant's Earring",
  ear2="Etiolation Earring",
  body=gear.CORAF.Body,
  hands=gear.Meghanada.Hands,
  ring1="Lebeche Ring",
  ring2="Tjukurrpa annulet",
  back="Solemnity cape",
  waist="Gishdubar Sash",
  legs=gear.Carmine.legs,
  feet=gear.Carmine.feet
}  

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

	sets.midcast['Dark Magic'] = --Update
{
  ammo=gear.QDbullet,
  head=gear.Pursuers.head,  --5STP
  body=gear.Pursuers.body,  --6STP
  hands=gear.Carmine.hands, --6STP
  legs=gear.Adhemar.legs,   --7STP
  feet=gear.Carmine.feet,   --8STP
  neck="Iskur Gorget",      --8STP
  ear1="Dedition Earring",  --8STP
  ear2="Tripudio Earring",  --5STP
  ring1="Ilabrat Ring",     --5STP
  ring2="Rajas Ring",       --5STP
  back=gear.AmbJSE.CORSTP,  --10STP
  waist="Yemaya Belt"       --4STP
}                           --90 (3 from shield 10 from gun)

	sets.midcast.CorsairShot =
{
  ammo=gear.QDbullet,
  head=gear.Herculeanhead.Magic,
  body=gear.Herculeanbody.Magic,
  hands=gear.Carmine.hands,
  legs=gear.Herculeanlegs.Magic,
  feet=gear.Herculeanfeet.Magic,
  neck="Sanctity Necklace",
  left_ear="Hermetic Earring",
  ear2="Friomisi Earring",
  left_ring="Dingir Ring",
  right_ring="Regal Ring",
  back=gear.AmbJSE.CORMdmg,
  waist="Eschan Stone",
}

	sets.midcast.CorsairShot.Resistant =  
{
  ammo=gear.QDbullet,
  head=gear.CORAF.Head,
  body="Oshosi Vest",
  hands=gear.CORAF.Hands,
  legs="Oshosi Trousers",
  feet=gear.CORAF.Feet,
  neck="Sanctity Necklace",
  ear1="Dignitary's Earring",
  ear2="Gwati Earring",
  ring1="Etana Ring",
  ring2="Regal Ring",
  waist="Kwahu Kachina Belt",
  back=gear.AmbJSE.CORMdmg
}

	sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Resistant
  
  sets.midcast.CorsairShot['Dark Shot'] = 
  set_combine(sets.midcast.CorsairShot.Resistant,{head="Pixie Hairpin +1", Ring2="Archon Ring"})


  -- Ranged gear
	sets.midcast.RA =             -- 1105 R. Acc 1141 R. Atk
{
  ammo=gear.RAbullet,	
  head=gear.Pursuers.head,      --5STP
  body="Oshosi Vest",           --7STP
  hands=gear.Carmine.hands,     --6STP
  legs=gear.Adhemar.legs,       --7STP
  feet=gear.Carmine.feet,       --8STP
  neck="Iskur Gorget",          --8STP
  ear1="Enervating Earring",    --4STP
  ear2="Neritic Earring",       --4STP
  ring1="Ilabrat Ring",         --5STP
  ring2="Regal Ring",
  back=gear.AmbJSE.CORSTP,      --10STP
  waist="Yemaya Belt",          --4STP
}

	sets.midcast.RA.Acc = -- 1345 R. Acc 1143 R. Atk
{
  ammo=gear.RAbullet,	
  left_ring="Hajduk Ring +1",
  head=gear.CORAF.Head,
  body=gear.CORAF.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.CORAF.Legs,
  feet=gear.Meghanada.Feet,
  neck="Iskur Gorget",
  waist="Kwahu Kachina Belt",
  left_ear="Neritic Earring",
  right_ear="Enervating Earring",
  right_ring="Regal Ring",
  back=gear.AmbJSE.CORSTP
}

	sets.midcast.RA.Critical =  --1238 R. Acc 1015 R. Atk
{
  ammo=gear.RAbullet,	
  head=gear.Mummu.Head,       --4%
  body=gear.Mummu.Body,       --8%
  hands=gear.COREmpy.Hands,   --6%
  legs=gear.Mummu.Legs,       --6%
  feet=gear.Mummu.Feet,       --4%
  neck="Iskur Gorget",        
  ear1="Enervating Earring",  
  ear2="Neritic Earring",    
  ring1="Ilabrat Ring",       
  ring2="Dingir Ring",
  back=gear.AmbJSE.CORSTP,    
  waist="Kwahu Kachina Belt", --4%
}                             --36% (4% from sword)

	sets.midcast.RA.STP =     --1079 R. Acc 1099 R. Atk No Buffs.
{
  ammo=gear.RAbullet,
  head=gear.Pursuers.head,  --5STP
  body=gear.Pursuers.body,  --6STP
  hands=gear.Carmine.hands, --6STP
  legs=gear.COREmpy.Legs,   --10STP
  feet=gear.Carmine.feet,   --8STP
  neck="Iskur Gorget",      --8STP
  ear1="Dedition Earring",  --8STP
  ear2="Tripudio Earring",  --5STP
  ring1="Ilabrat Ring",     --5STP
  ring2="Rajas Ring",       --5STP
  back=gear.AmbJSE.CORSTP,  --10STP
  waist="Yemaya Belt"       --4STP
}                           --93 (3 from shield 10 from gun)

	sets.TripleShot = 
  {body=gear.COREmpy.Body,
  legs="Oshosi Trousers",
  back=gear.AmbJSE.CORSTP} -- Buy Oshosi Head, Hands, Feet



------------------------------------------------------------------------------------------------
----------------------------------------- Idle Sets --------------------------------------------
------------------------------------------------------------------------------------------------

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
  right_ear="Infused Earring",
  left_ring="Defending Ring",
  right_ring="Patricius Ring",
  back="Moonbeam Cape"
}

	sets.idle =
{
  head=gear.Rawhide.head,
  body="Mekosuchinae Harness",
  hands=gear.Floral.Cap,
  legs=gear.Carmine.legs,
  feet=gear.Herculeanfeet.Ranged,
  neck="Loricate Torque +1",
  waist="Flume Belt +1",
  left_ear="Etiolation Earring",
  right_ear="Infused Earring",
  left_ring="Defending Ring",
  right_ring="Patricius Ring",
  back="Moonbeam Cape"
}

	sets.idle.DT =                  --53PDT/26MDT Update
{
  head=gear.Meghanada.Head,       --5PDT
  body=gear.Meghanada.Body,       --8PDT
  hands=gear.Meghanada.Hands,     --4PDT
  legs=gear.Meghanada.Legs,       --6PDT
  feet=gear.Meghanada.Feet,       --3PDT
  neck="Loricate Torque +1",      --          6Dmg
  waist="Flume Belt +1",          --4PDT
  left_ear="Etiolation Earring",  --      3MDT
  right_ear="Odnowa Earring +1",  --      2MDT
  left_ring="Defending Ring",     --          10Dmg
  right_ring="Meghanada Ring",    --2PDT
  back="Moonbeam Cape"            --          5Dmg
}

	sets.idle.Town = 
{    
  head=gear.CORAF.Head,
  body=gear.CORAF.Body,
  hands=gear.CORAF.Hands,
  legs=gear.CORAF.Legs,
  feet=gear.CORAF.Feet,
  neck="Regal Necklace",
  waist="Reiki Yotai",
  left_ear="Etiolation Earring",
  right_ear="Odnowa Earring +1",
  left_ring="Dingir Ring",
  right_ring="Regal Ring",
  back="Moonbeam Cape"
}

------------------------------------------------------------------------------------------------
---------------------------------------- Defense Sets ------------------------------------------
------------------------------------------------------------------------------------------------

	sets.defense.PDT = sets.idle.DT
  
	sets.defense.MDT = sets.idle.DT

	sets.Kiting = {legs=gear.Carmine.legs}


  ------------------------------------------------------------------------------------------------
---------------------------------------- Engaged Sets ------------------------------------------
 ------------------------------------------------------------------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- * DNC Subjob DW Trait: +15%
  -- * NIN Subjob DW Trait: +25%
 
  -- No Magic Haste (74% DW to cap)
	sets.engaged = 
{
  head=gear.Dampening.Cap,
  body=gear.Adhemar.body, --5
  hands=gear.Floral.Cap, --5
  legs=gear.Carmine.legs, --6
  feet=gear.Rawhide.feet, --3
  neck="Lissome Necklace",
  ear1="Heartseeker Earring", --7
  ear2="Dudgeon Earring", 
  ring1="Hetairoi Ring",
  ring2="Epona's Ring",
  back=gear.AmbJSE.CORSTP,
  waist="Reiki Yotai", --7
} -- 33%

	sets.engaged.LowAcc = 
  set_combine(sets.engaged, 
{
  waist="Windbuffet Belt +1",
})

	sets.engaged.MidAcc = 
  set_combine(sets.engaged.LowAcc, 
{
  neck="Combatant's Torque",
  ear1="Cessance Earring",
  ear2="Brutal Earring",
  ring2="Regal Ring",
})

	sets.engaged.HighAcc =
  set_combine(sets.engaged.MidAcc, 
{
  head=gear.Carmine.head.HQ,
  feet=gear.Carmine.feet,
  left_ear="Dignitary's Earring",
  right_ear="Zennaroi Earring",
  ring1="Ramuh Ring +1",
  ring2="Regal Ring",
  waist="Olseni Belt",
})

	sets.engaged.STP = --Update
  set_combine(sets.engaged, 
{
  feet=gear.Carmine.feet,
  neck="Ainia Collar",
  ear1="Dedition Earring",
  ear2="Tripudio Earring",
  ring1="Petrov Ring",
  waist="Kentarch Belt +1",
})

	-- 15% Magic Haste (67% DW to cap)
	sets.engaged.LowHaste = 
{
  head=gear.Dampening.Cap,
  body=gear.Adhemar.body, --5
  hands=gear.Floral.Cap, --5
  legs=gear.Carmine.legs, --6
  feet=gear.Rawhide.feet, --3
  neck="Lissome Necklace",
  ear1="Heartseeker Earring", --7
  ear2="Dudgeon Earring", 
  ring1="Hetairoi Ring",
  ring2="Epona's Ring",
  back=gear.AmbJSE.CORSTP,
  waist="Reiki Yotai", --7
} -- 33%

	sets.engaged.LowAcc.LowHaste = 
  set_combine(sets.engaged.LowHaste, 
{
  waist="Windbuffet Belt +1",
})

	sets.engaged.MidAcc.LowHaste = 
  set_combine(sets.engaged.LowAcc.LowHaste, 
{
  neck="Combatant's Torque",
  ear1="Cessance Earring",
  ear2="Brutal Earring",
  ring2="Regal Ring",
})

	sets.engaged.HighAcc.LowHaste = 
  set_combine(sets.engaged.MidAcc.LowHaste, 
{
  head=gear.Carmine.head.HQ,
  feet=gear.Carmine.feet,
  left_ear="Dignitary's Earring",
  right_ear="Zennaroi Earring",
  ring1="Ramuh Ring +1",
  ring2="Regal Ring",
  waist="Olseni Belt",
})

	sets.engaged.STP.LowHaste =
  set_combine(sets.engaged.LowHaste, 
{
  feet=gear.Carmine.feet,
  neck="Ainia Collar",
  ear1="Dedition Earring",
  ear2="Tripudio Earring",
  ring1="Petrov Ring",
  waist="Kentarch Belt +1",
})

	-- 30% Magic Haste (56% DW to cap)
	sets.engaged.MidHaste = 
{
  head=gear.Dampening.Cap,
  body=gear.Adhemar.body, --5
  hands=gear.Floral.Cap, --5
  legs=gear.Carmine.legs, --6
  feet=gear.Rawhide.feet, --3
  neck="Lissome Necklace",
  ear1="Heartseeker Earring", --7
  ear2="Dudgeon Earring", 
  ring1="Hetairoi Ring",
  ring2="Epona's Ring",
  back=gear.AmbJSE.CORSTP,
  waist="Reiki Yotai", --7
} -- 33%

	sets.engaged.LowAcc.MidHaste = 
  set_combine(sets.engaged.MidHaste, 
{
  waist="Windbuffet Belt +1",
})

	sets.engaged.MidAcc.MidHaste = 
  set_combine(sets.engaged.LowAcc.MidHaste, 
{
  legs=gear.Meghanada.Legs,
  neck="Combatant's Torque",
  ear1="Cessance Earring",
  ear2="Brutal Earring",
  ring2="Regal Ring",
})

	sets.engaged.HighAcc.MidHaste = 
  set_combine(sets.engaged.MidAcc.MidHaste, 
{
  head=gear.Carmine.head.HQ,
  feet=gear.Carmine.feet,
  left_ear="Dignitary's Earring",
  right_ear="Zennaroi Earring",
  ring1="Ramuh Ring +1",
  ring2="Regal Ring",
  waist="Olseni Belt",
})

	sets.engaged.STP.MidHaste = 
  set_combine(sets.engaged.MidHaste, 
{
  feet=gear.Carmine.feet,
  neck="Ainia Collar",
  ear1="Dedition Earring",
  ear2="Tripudio Earring",
  ring1="Petrov Ring",
  waist="Kentarch Belt +1",
})

	-- 35% Magic Haste (51% DW to cap)
	sets.engaged.HighHaste = 
{
  head=gear.Dampening.Cap,
  body=gear.Adhemar.body, --5
  hands=gear.Floral.Cap, --5
  legs=gear.Carmine.legs, --6
  feet=gear.Rawhide.feet, --3
  neck="Lissome Necklace",
  ear1="Heartseeker Earring", --7
  ear2="Dudgeon Earring", 
  ring1="Hetairoi Ring",
  ring2="Epona's Ring",
  back=gear.AmbJSE.CORSTP,
  waist="Reiki Yotai", --7
} -- 33%

	sets.engaged.LowAcc.HighHaste =
  set_combine(sets.engaged.HighHaste, 
{
  waist="Windbuffet Belt +1",
})

	sets.engaged.MidAcc.HighHaste = --Update
  set_combine(sets.engaged.LowAcc.HighHaste, 
{
  legs=gear.Meghanada.Legs,
  neck="Combatant's Torque",
  ear1="Cessance Earring",
  ear2="Brutal Earring",
  ring2="Regal Ring",
})

	sets.engaged.HighAcc.HighHaste = 
  set_combine(sets.engaged.MidAcc.HighHaste, 
{
  head=gear.Carmine.head.HQ,
  feet=gear.Carmine.feet,
  left_ear="Dignitary's Earring",
  right_ear="Zennaroi Earring",
  ring1="Ramuh Ring +1",
  ring2="Regal Ring",
  waist="Olseni Belt",
})

	sets.engaged.STP.HighHaste = 
  set_combine(sets.engaged.HighHaste,
{
  feet=gear.Carmine.feet,
  neck="Ainia Collar",
  ear1="Dedition Earring",
  ear2="Tripudio Earring",
  ring1="Petrov Ring",
  waist="Kentarch Belt +1",
})

	-- 47% Magic Haste (36% DW to cap)
	sets.engaged.MaxHaste = 
{
  head=gear.Dampening.Cap,
  body=gear.Adhemar.body, --5
  hands=gear.Floral.Cap, --5
  legs=gear.Carmine.legs, --6
  feet=gear.Rawhide.feet, --3
  neck="Lissome Necklace",
  ear1="Heartseeker Earring", --7
  ear2="Dudgeon Earring", 
  ring1="Hetairoi Ring",
  ring2="Epona's Ring",
  back=gear.AmbJSE.CORSTP,
  waist="Reiki Yotai", --7
} -- 33%

	sets.engaged.LowAcc.MaxHaste = 
  set_combine(sets.engaged.MaxHaste, 
{
  waist="Windbuffet Belt +1",
})

	sets.engaged.MidAcc.MaxHaste = 
  set_combine(sets.engaged.LowAcc.MaxHaste, 
{
  legs=gear.Meghanada.Legs,
  neck="Combatant's Torque",
  ear1="Cessance Earring",
  ear2="Brutal Earring",
  ring2="Regal Ring",
})

	sets.engaged.HighAcc.MaxHaste = 
  set_combine(sets.engaged.MidAcc.MaxHaste, 
{
  head=gear.Carmine.head.HQ,
  feet=gear.Carmine.feet,
  left_ear="Dignitary's Earring",
  right_ear="Zennaroi Earring",
  ring1="Ramuh Ring +1",
  ring2="Regal Ring",
  waist="Olseni Belt",
})

	sets.engaged.STP.MaxHaste = 
  set_combine(sets.engaged.MaxHaste, 
{
  feet=gear.Carmine.feet,
  neck="Ainia Collar",
  ear1="Dedition Earring",
  ear2="Tripudio Earring",
  ring1="Petrov Ring",
  waist="Kentarch Belt +1",
})

	sets.engaged.Aftermath = {}

------------------------------------------------------------------------------------------------
---------------------------------------- Hybrid Sets -------------------------------------------
------------------------------------------------------------------------------------------------

  sets.engaged.Hybrid = {
  neck="Loricate Torque +1", --6/6
  ring2="Defending Ring", --10/10
  }

sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

sets.engaged.DT.LowHaste = set_combine(sets.engaged.LowHaste, sets.engaged.Hybrid)
sets.engaged.LowAcc.DT.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, sets.engaged.Hybrid)
sets.engaged.MidAcc.DT.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, sets.engaged.Hybrid)
sets.engaged.HighAcc.DT.LowHaste = set_combine(sets.engaged.HighAcc.LowHaste, sets.engaged.Hybrid)    
sets.engaged.STP.DT.LowHaste = set_combine(sets.engaged.STP.LowHaste, sets.engaged.Hybrid)

sets.engaged.DT.MidHaste = set_combine(sets.engaged.MidHaste, sets.engaged.Hybrid)
sets.engaged.LowAcc.DT.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, sets.engaged.Hybrid)
sets.engaged.MidAcc.DT.MidHaste = set_combine(sets.engaged.MidAcc.MidHaste, sets.engaged.Hybrid)
sets.engaged.HighAcc.DT.MidHaste = set_combine(sets.engaged.HighAcc.MidHaste, sets.engaged.Hybrid)    
sets.engaged.STP.DT.MidHaste = set_combine(sets.engaged.STP.MidHaste, sets.engaged.Hybrid)

sets.engaged.DT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.Hybrid)
sets.engaged.LowAcc.DT.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, sets.engaged.Hybrid)
sets.engaged.MidAcc.DT.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, sets.engaged.Hybrid)
sets.engaged.HighAcc.DT.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.engaged.Hybrid)    
sets.engaged.STP.DT.HighHaste = set_combine(sets.engaged.HighHaste.STP, sets.engaged.Hybrid)

sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)
sets.engaged.LowAcc.DT.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, sets.engaged.Hybrid)
sets.engaged.MidAcc.DT.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.Hybrid)
sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Hybrid)    
sets.engaged.STP.DT.MaxHaste = set_combine(sets.engaged.STP.MaxHaste, sets.engaged.Hybrid)


------------------------------------------------------------------------------------------------
---------------------------------------- Special Sets ------------------------------------------
------------------------------------------------------------------------------------------------

	sets.buff.Doom = --Update
  {waist="Gishdubar Sash"}

  sets.Afterglow = {}
  
  sets.Obi = {}
  
  sets.CP = {back="Mecisto. Mantle"}
  
  sets.Reive = {neck="Ygnas's Resolve +1"}

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
    end
    
    if spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
end
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if state.FlurryMode.value == 'Flurry II' and (buffactive[265] or buffactive[581]) then
            equip(sets.precast.RA.Flurry2)
        elseif state.FlurryMode.value == 'Flurry I' and (buffactive[265] or buffactive[581]) then
            equip(sets.precast.RA.Flurry1)
        end
    end    -- Equip obi if weather/day matches for WS/Quick Draw.
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Leaden Salute' then
            if world.weather_element == 'Dark' or world.day_element == 'Dark' then
                equip(sets.Obi)
            end
            if player.tp > 2900 then
                equip(sets.precast.WS['Leaden Salute'].FullTP)
            end    
        elseif spell.english == 'Wildfire' and (world.weather_element == 'Fire' or world.day_element == 'Fire') then
            equip(sets.Obi)
        end
    end
end
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' and buffactive['Triple Shot'] then
        equip(sets.TripleShot)
    end
    if spell.type == 'CorsairShot' then
        if spell.english ~= "Light Shot" and spell.english ~= "Dark Shot" then
            equip(sets.Obi)
        end
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
    if spell.english == "Light Shot" then
        send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
    end
end
function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

--    if buffactive['Reive Mark'] then
--        if gain then           
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

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
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('ranged')
    else
        enable('ranged')
    end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Gun.current == 'Death Penalty' then
        equip({ranged="Death Penalty"})
    elseif state.Gun.current == 'Fomalhaut' then
        equip({ranged="Fomalhaut"})
    elseif state.Gun.current == 'Doomsday' then
        equip({ranged="Doomsday"})
--    elseif state.Gun.current == 'Armageddon' then
--        equip({ranged="Armageddon"})
    end

    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    return idleSet
end
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.Buff.Aftermath and state.Gun.value == "Death Penalty" 
        and state.HybridMode.value ~= 'DT' then
		meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
	end

    return meleeSet
end
-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.

function job_update(cmdParams, eventArgs)
    determine_haste_group()
end
-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end
        
        eventArgs.SelectNPCTargets = state.SelectqdTarget.value
    end
end
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. '[ Offense/Ranged: '..state.OffenseMode.current..'/'..state.RangedMode.current .. ' ]'
    msg = msg .. '[ WS: '..state.WeaponskillMode.current .. ' ]'

    if state.DefenseMode.value ~= 'None' then
        msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
    end
    
    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode: ON ]'
    end

    msg = msg .. '[ ' .. state.HasteMode.value .. ' ]'

    msg = msg .. '[ *'..state.Mainqd.current

    if state.UseAltqd.value == true then
        msg = msg .. '/'..state.Altqd.current
    end
    
    msg = msg .. '* ]'
    
    add_to_chat(060, msg)

    eventArgs.handled = true
end
-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'qd' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doqd = ''
        if state.UseAltqd.value == true then
            doqd = state[state.Currentqd.current..'qd'].current
            state.Currentqd:cycle()
        else
            doqd = state.Mainqd.current
        end        
        
        send_command('@input /ja "'..doqd..'" <t>')
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()

    -- Gearswap can't detect the difference between Haste I and Haste II
    -- so use winkey-H to manually set Haste spell level.

    -- Haste (buffactive[33]) - 15%
    -- Haste II (buffactive[33]) - 30%
    -- Haste Samba - 5~10%
    -- Honor March - 12~16%
    -- Victory March - 15~28%
    -- Advancing March - 10~18%
    -- Embrava - 25%
    -- Mighty Guard (buffactive[604]) - 15%
    -- Geo-Haste (buffactive[580]) - 30~40%

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
function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Drachen Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Puppet Roll"]     = {lucky=3, unlucky=7, bonus="Pet Magic Attack/Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Naturalist's Roll"]       = {lucky=3, unlucky=7, bonus="Enh. Magic Duration"},
        ["Runeist's Roll"]       = {lucky=4, unlucky=8, bonus="Magic Evasion"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end
function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, '[ Lucky: '..tostring(rollinfo.lucky)..' / Unlucky: '..tostring(rollinfo.unlucky)..' ] '..spell.english..': '..rollinfo.bonus..' ('..rollsize..') ')
    end
end
-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.english == 'Wildfire' or spell.english == 'Leaden Salute' then
                -- magical weaponskills
                bullet_name = gear.MAbullet
            else
                -- physical weaponskills
                bullet_name = gear.WSbullet
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
        if spell.type == 'CorsairShotShot' and player.equipment.ammo ~= 'empty' then
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
    if player.sub_job == 'DNC' then
        set_macro_page(1, 5)
    else
        set_macro_page(1, 5)
    end
end
function set_lockstyle()
    send_command('wait 2; input /lockstyleset 2')
end