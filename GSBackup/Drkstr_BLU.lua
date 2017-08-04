-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.

function get_sets()
  
  mote_include_version = 2
  
  --Load and initialize the include file.
  
  include('Mote-Include.lua')
  
end
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
  state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
  state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
  state.Buff.Convergence = buffactive.Convergence or false
  state.Buff.Diffusion = buffactive.Diffusion or false
  state.Buff.Efflux = buffactive.Efflux or false
  
  state.CapacityMode = M(false, 'Capacity Point Mantle')
  state.LearnMode = M(false, 'Learning Mode')
  
  state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
 
  -- All Augmented gear used in sets below
  
  --gear.RunCuisses = {legs=gear.Carmine.legs}
 
  blue_magic_maps = {}
  
  -- Mappings for gear sets to use for various blue magic spells.
  -- While Str isn't listed for each, it's generally assumed as being at least
  -- moderately signficant, even for spells with other mods.

  -- Physical Spells --
  -- Physical spells with no particular (or known) stat mods
blue_magic_maps.Physical = S{'Bilgestorm'}
 
-- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
blue_magic_maps.PhysicalAcc = S{'Heavy Strike',}
 
-- Physical spells with Str stat mod
blue_magic_maps.PhysicalStr = S{
'Battle Dance','Bloodrake','Death Scissors','Dimensional Death','Empty Thrash','Quadrastrike','Spinal Cleave',
'Uppercut','Vertical Cleave'}
  
-- Physical spells with Dex stat mod
blue_magic_maps.PhysicalDex = S{
'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment','Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad','Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault','Vanity Dive'}
  
-- Physical spells with Vit stat mod
blue_magic_maps.PhysicalVit = S{
'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam','Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'}

-- Physical spells with Agi stat mod
blue_magic_maps.PhysicalAgi = S{
'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream','Pinecone Bomb','Spiral Spin','Wild Oats'}
 
-- Physical spells with Int stat mod
blue_magic_maps.PhysicalInt = S{'Mandibular Bite','Queasyshroom'}
 
-- Physical spells with Mnd stat mod
blue_magic_maps.PhysicalMnd = S{'Ram Charge','Screwdriver','Tourbillion'}
 
-- Physical spells with Chr stat mod
blue_magic_maps.PhysicalChr = S{'Bludgeon'}

-- Physical spells with HP stat mod
blue_magic_maps.PhysicalHP = S{'Final Sting'}
 
-- Magical Spells --

-- Magical spells with the typical Int mod
blue_magic_maps.Magical = S{'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
'Droning Whirlwind','Embalming Earth','Firespit','Foul Waters','Ice Break','Leafstorm','Maelstrom','Regurgitation','Rending Deluge','Retinal Glare','Subduction','Tem. Upheaval','Water Bomb','Tenebral Crush','Entomb','Spectral Floe','Blinding Fulgor'}
 
-- Magical spells with a primary Mnd mod
blue_magic_maps.MagicalMnd = S{'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast','Scouring Spate'}

-- Magical spells with a primary Chr mod
blue_magic_maps.MagicalChr = S{'Eyes On Me','Mysterious Light'}

-- Magical spells with a primary AGI mod
blue_magic_maps.MagicalAgi = S{'Silent Storm','Palling Salvo'}
 
-- Magical spells with a primary STR mod
blue_magic_maps.MagicalStr = S{'Searing Tempest'}
 
-- Magical spells with a Vit stat mod (on top of Int)
blue_magic_maps.MagicalVit = S{'Thermal Pulse','Entomb'}
 
-- Magical spells with a Dex stat mod (on top of Int)
blue_magic_maps.MagicalDex = S{'Charged Whisker','Gates of Hades','Anvil Lightning'}

-- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
-- Add Int for damage where available, though.
blue_magic_maps.MagicAccuracy = S{'1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye','Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest','Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar','Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance','Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind','Sandspin','Sandspray','Sheep Song','Spectral Floe','Soporific','Sound Blast','Stinking Gas','Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'}

-- Breath-based spells
blue_magic_maps.Breath = S{'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath','Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct','Thunder Breath','Vapor Spray','Wind Breath'}

-- Stun spells
blue_magic_maps.Stun = S{'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift','Thunderbolt','Whirl of Rage'}

-- Healing spells
blue_magic_maps.Healing = S{'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','White Wind','Wild Carrot'}

-- Buffs that depend on blue magic skill
blue_magic_maps.SkillBasedBuff = S{'Occultation','Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge','Pyric Bulwark','Reactor Cool',}

-- Other general buffs
blue_magic_maps.Buff = S{'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon','Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell','Memento Mori','Nat. Meditation','Orcish Counterstance','Refueling','Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion','Zephyr Mantle'}


-- Spells that require Unbridled Learning to cast.
unbridled_spells = S{'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Droning Whirlwind','Gates of Hades','Harden Shell','Pyric Bulwark','Thunderbolt','Tourbillion'}
end
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  
state.OffenseMode:options('Normal', 'iLvl', 'Acc', 'Acc2', 'Refresh')

state.WeaponskillMode:options('Normal', 'Acc', 'Mod')

state.CastingMode:options('Normal', 'Resistant')

state.IdleMode:options('Normal', 'PDT', 'Learning')

update_combat_form()

select_default_macro_book()

send_command('@wait 1;input /lockstyleset 4')

end
-- Set up gear sets.
function init_gear_sets()

  include('augmented-items.lua')
  
--------------------------------------
-- Start defining the sets
--------------------------------------

-- React Sets --
	
sets.React = {}

sets.React.MEVA = {}
sets.React.Light = {}
sets.React.Dark = {}
sets.React.Thunder = {}
sets.React.Ice = {}
sets.React.Water = {}
sets.React.Fire = {}
sets.React.Air = {}
sets.React.Stone = {}
sets.React.Status = {}
sets.React.Paralyze = {}
sets.React.Sleep = {}
sets.React.Charm = {}
sets.React.Stun = {}
sets.React.Silence = {}
sets.React.Slow = {}
sets.React.Death = {}
sets.React.Gravity = {}
sets.React.Bind = {}
sets.React.Petrify = {}
sets.React.PDT = {}
sets.React.MDT = {}
sets.React.BDT = {}
	
-- Blu JA --
 
  sets.buff['Burst Affinity'] = {} -- Reforged Empy Feet +1, Reforged AF Legs +1

  sets.buff['Chain Affinity'] = {} -- Reforged Empy Head +1, Reforged AF Feet +1, Swords - Iris, Acclimator

  sets.buff.Convergence = {} -- Reforged Relic Head +1

  sets.buff.Diffusion = {Feet=gear.BLURel.Feet}

  sets.buff.Enchainment = {body=gear.BLURel.Body}

  sets.buff.Efflux = {back=gear.AmbJSE.BLUcrit}
 
-- Capacity Set
  sets.CapacityMantle = {back="Mecistopins Mantle"}
 
-- Learning Set
  sets.LearnMode = {}
 
-- Precast Sets

-- Precast sets to enhance JAs

  sets.precast.JA['Azure Lore'] = {} -- Reforged AF Hands +1

  sets.precast.JA['Box Step'] = 
  sets.engaged.Acc 

  sets.precast.JA['Stutter Step'] = 
  sets.engaged.Acc

  sets.precast.JA['Violent Flourish'] = 
  sets.engaged.Acc

  sets.precast.JA['Swipe'] = 
{    
  ammo="Pemphredo Tathlum",
  head=gear.Herculeanhead.Magic,
  body=gear.Herculeanbody.Magic,
  hands=gear.Carmine.hands,
  legs=gear.Herculeanlegs.Magic,
  feet=gear.Herculeanfeet.Magic,
  neck="Sanctity Necklace",
  waist="Eschan Stone",
  left_ear="Friomisi Earring",
  right_ear="Regal Earring",
  left_ring="Vertigo Ring",
  right_ring="Etana Ring",
  back="Argochampsa Mantle"
}

  sets.precast.JA['Lunge'] = 
  sets.precast.JA['Swipe']
 
 
-- Waltz set (chr and vit)
  sets.precast.Waltz = {}

-- Don't need any special gear for Healing Waltz.
  sets.precast.Waltz['Healing Waltz'] = {}
 
-- Fast cast sets for spells

  sets.precast.FC = -- 56 FC 11 QM
{ 
	ammo="Impatiens",                 -- 2  QM
	head=gear.Carmine.head,           -- 12 FC
	neck="Orunmila's Torque",         -- 5  FC
	left_ear="Etiolation Earring",    -- 1  FC
	right_ear="Loquacious Earring",   -- 2  FC
	body=gear.BLURel.Body,            -- 7  FC
	hands=gear.Leyline.NotCap,        -- 7  FC
	left_ring="Kishar Ring",          -- 4  FC
	right_ring="Lebeche Ring",        -- 2  QM
	back="Perimede Cape",             -- 4  QM
	waist="Witful Belt",              -- 3  FC 3 QM
	legs=gear.Psycloth.legs,          -- 7  FC
	feet=gear.Carmine.feet            -- 8  FC
} 

  sets.precast.FC['Blue Magic'] = 
  set_combine(sets.precast.FC, {}) -- Reforged Empy Body +1 for -14% Blue magic casting time.

  sets.precast.FC.Utsusemi = 
  set_combine(sets.precast.FC, {})
 
-- Weaponskill sets
-- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = 
{
  ammo="Ginsen", 
	head=gear.Lilitu.Cap,
	body=gear.Herculeanbody.Crit,
	hands=gear.Herculeanhands.Triple,  
  legs=gear.Samnuhalegs,
	feet=gear.Herculeanfeet.Triple,
  neck="Fotia Gorget",
	waist="Fotia Belt",  
  ear1=gear.Moonshade.WS ,
  ear2="Ishvara earring",
	ring1="Epona's Ring",
  ring2="Ilabrat Ring",
	back=gear.AmbJSE.BLUWS,
}

  sets.precast.WS.acc = 
set_combine(sets.precast.WS, 
{
  Ammo="Falcon Eye",
	head=gear.Carmine.head.HQ,
	hands=gear.Herculeanhands.Triple,
  legs=gear.Carmine.legs,  
  neck="Combatant's Torque",
	ring1="Ramuh Ring +1",
  ear2="Zennaroi Earring",
  ring2="Ramuh Ring +1"
})
 
-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
  sets.precast.WS['Requiescat'] = 
{
  ammo="Mantoptera eye",
	head=gear.Jhakri.Head,
  body=gear.Jhakri.Body,
  hands=gear.Jhakri.Hands,
  legs=gear.Jhakri.Legs,
  feet=gear.Jhakri.Feet,
  neck="Fotia Gorget",
	waist="Fotia Belt",  
  ear1=gear.Moonshade.WS,
  ear2="Regal Earring",
  ring1="Shukuyu Ring",
  ring2="Rufescent Ring",
	back=gear.AmbJSE.BLUWS
}

  sets.precast.WS['Requiescat'].Acc = 
{
  ammo="Mantoptera eye",
	head=gear.Carmine.head.HQ,
  body=gear.Ayanmo.Body,
  hands=gear.Jhakri.Hands,
  legs=gear.Carmine.legs,
  feet=gear.Carmine.feet,
  neck="Combatant's Torque",
	waist="Olseni Belt",  
	ring1="Ramuh Ring +1", 
  ear1="Zennaroi Earring",
  ear2="Regal Earring",
  ring2="Ramuh Ring +1",
	back=gear.AmbJSE.BLUcrit
}

  sets.precast.WS['Savage Blade'] = 
{
  ammo="Mantoptera Eye",
	head="Dampening Tam",
	body=gear.Herculeanbody.Crit,
	hands=gear.Herculeanhands.Triple,  
  legs=gear.Samnuhalegs,
	feet=gear.Herculeanfeet.Triple,
  neck="Caro Necklace",
	waist="Caudata Belt",  
  ear1=gear.Moonshade.WS,
  ear2="Ishvara earring",
  ring1="Shukuyu Ring",
  ring2="Rufescent Ring",
	back=gear.AmbJSE.BLUWS,
}

  sets.precast.WS['Savage Blade'].Acc = 
{
  ammo="Mantoptera Eye",
  head=gear.Carmine.head.HQ,
  body=gear.Herculeanbody.Crit,
	hands=gear.Herculeanhands.Triple,
  legs=gear.Carmine.legs,
  feet=gear.Carmine.feet,
  neck="Combatant's Torque",
  waist="Grunfeld Rope",
  ring1="Ramuh Ring +1", 
  ear1=gear.Moonshade.WS,
  ear2="Ishvara earring",
  ring2="Ramuh Ring +1",
  back=gear.AmbJSE.BLUWS,
}

  sets.precast.WS['Expiacion'] = 
  sets.precast.WS['Savage Blade']
  
  sets.precast.WS['Expiacion'].Acc = 
  sets.precast.WS['Savage Blade'].Acc

  sets.precast.WS['Chant du Cygne'] = 
{
  ammo="Falcon Eye",
  head="Adhemar Bonnet",
	body=gear.Herculeanbody.Crit,
	hands=gear.Herculeanhands.Crit,  
  legs=gear.Samnuhalegs,
  feet="Thereoid Greaves", 
  neck="Fotia Gorget",
	waist="Fotia Belt",  
  ear1=gear.Moonshade.WS ,
  ear2="Brutal Earring",
	ring1="Epona's ring",
  ring2="Hetairoi ring",
	back=gear.AmbJSE.BLUcrit
}

  sets.precast.WS['Chant du Cygne'].Acc = 
{
  ammo="Falcon Eye",
  head="Adhemar Bonnet",
	body=gear.Herculeanbody.Crit,
	hands=gear.Herculeanhands.Crit,  
  legs=gear.Samnuhalegs,
  feet="Thereoid Greaves", 
  neck="Fotia Gorget",
	waist="Fotia Belt",  
  ring1="Ramuh Ring +1", 
  ear1=gear.Moonshade.WS,
  ear2="Brutal Earring",
  ring2="Ramuh Ring +1",
	back=gear.AmbJSE.BLUcrit
}

  sets.precast.WS['Sanguine Blade'] = 
{
  ammo="Pemphredo Tathlum",
	head=gear.Herculeanhead.Magic,
	body=gear.Amalric.body ,
  hands=gear.Carmine.hands,  
  legs=gear.Amalric.legs,
	feet=gear.Herculeanfeet.Magic, 
	neck="Sanctity Necklace",
  waist="Eschan Stone",  
  ear1=gear.Moonshade.WS ,
  ear2="Friomisi Earring",
  ring1="Vertigo Ring",
  ring2="Apate Ring",
	back="Argochampsa Mantle",
}

  sets.precast.WS['Realmrazer'] = 
  sets.precast.WS['Requiescat']

  sets.precast.WS['Circle Blade'] = 
  sets.precast.WS['Savage Blade']

  sets.precast.WS['Vorpal Blade'] = 
  sets.precast.WS['Chant du Cygne']

  sets.precast.WS['Flash Nova'] = 
  set_combine(sets.precast.WS['Sanguine Blade'], {})

-- Midcast Sets
  sets.midcast.FastRecast = sets.precast.FC

  sets.midcast['Blue Magic'] = {}

-- Physical Spells --

  sets.midcast['Blue Magic'].Physical = 
{ 
  ammo="Ginsen",
	head=gear.Jhakri.Head,
  body=gear.Jhakri.Body,
  hands=gear.Jhakri.Hands,
  legs=gear.Jhakri.Legs,
  feet=gear.Jhakri.Feet,
  neck="Sanctity Necklace",
	waist="Eschan Stone",  
  ear1="Lempo earring",
  ear2="Digni. Earring",
	ring1="Epona's Ring",
  ring2="Petrov Ring",
  back=gear.ReiveJSE.BLU
}
 
  sets.midcast['Blue Magic'].PhysicalAcc = 
  sets.midcast['Blue Magic'].Physical

  sets.midcast['Blue Magic'].PhysicalStr = 
  sets.midcast['Blue Magic'].Physical

  sets.midcast['Blue Magic'].PhysicalDex = 
  sets.midcast['Blue Magic'].Physical

  sets.midcast['Blue Magic'].PhysicalVit =
  sets.midcast['Blue Magic'].Physical
   
  sets.midcast['Blue Magic'].PhysicalAgi = 
  sets.midcast['Blue Magic'].Physical

  sets.midcast['Blue Magic'].PhysicalInt = 
  sets.midcast['Blue Magic'].Physical

  sets.midcast['Blue Magic'].PhysicalMnd = 
  sets.midcast['Blue Magic'].Physical
   
  sets.midcast['Blue Magic'].PhysicalChr = 
  sets.midcast['Blue Magic'].Physical

  sets.midcast['Blue Magic'].PhysicalHP = 
  sets.midcast['Blue Magic'].Physical
 
 
-- Magical Spells --

  sets.midcast['Blue Magic'].Magical = 
{
  Ammo="Pemphredo Tathlum",
	head=gear.Herculeanhead.Magic,
	body=gear.Amalric.body,
  hands=gear.Amalric.hands,  
  legs=gear.Amalric.legs,
	feet=gear.Herculeanfeet.Magic,
  neck="Sanctity Necklace",
  waist="Eschan Stone",  
  ear1="Friomisi Earring",
  ear2="Dignitary's Earring",
  ring1="Rahab Ring",
  ring2="Vertigo Ring",
	back=gear.ReiveJSE.BLU
}
 
  sets.midcast['Blue Magic'].Magical.Resistant = 
  sets.midcast['Blue Magic'].Magical

  sets.midcast['Blue Magic'].MagicalMnd = 
  sets.midcast['Blue Magic'].Magical
   
  sets.midcast['Blue Magic'].MagicalChr = 
  sets.midcast['Blue Magic'].Magical
   
  sets.midcast['Blue Magic'].MagicalVit = 
  sets.midcast['Blue Magic'].Magical
 
  sets.midcast['Blue Magic'].MagicalDex = 
  sets.midcast['Blue Magic'].Magical

  sets.midcast['Blue Magic'].MagicalStr = 
  sets.midcast['Blue Magic'].Magical
   
  sets.midcast['Blue Magic'].MagicalAgi = 
  sets.midcast['Blue Magic'].Magical

  sets.midcast['Blue Magic'].MagicAccuracy = 
{
  Ammo="Pemphredo Tathlum",
	head=gear.Herculeanhead.Magic,
	body=gear.Amalric.body ,
  hands=gear.Leyline.NotCap,  
  legs=gear.Psycloth.legs,
	feet=gear.Herculeanfeet.Magic,
  neck="Sanctity Necklace",
  waist="Luminary Sash",  
  ear1="Gwati Earring",
  ear2="Dignitary's Earring",
  ring1="Etana Ring",
  ring2="Vertigo Ring",
	back=gear.ReiveJSE.BLU
}

-- Breath Spells --

  sets.midcast['Blue Magic'].Breath = 
  sets.midcast['Blue Magic'].MagicAccuracy
 
-- Other Types --

  sets.midcast['Blue Magic'].Stun = 
  sets.midcast['Blue Magic'].MagicAccuracy

  sets.midcast['Blue Magic']['White Wind'] = 
{
  ammo="Mavi Tathlum",
  head=gear.Ayanmo.Head,
  body=gear.Samnuhabody.FC,
  hands=gear.Leyline.NotCap,
  legs=gear.Carmine.legs,
  feet=gear.Mediums.NotCap,
  neck="Phalaina locket",
  waist="Gishdubar Sash",
  ear1="Mendicant's Earring",
  ear2="Etiolation Earring",
  ring1="Lebeche Ring",
  ring2="Etana Ring",
  back="Solemnity Cape"
}
 
  sets.midcast['Blue Magic']['Subduction'] = 
  sets.midcast['Blue Magic'].Magical

  sets.midcast['Blue Magic']['Subduction'].Resistant = 
  sets.midcast['Blue Magic'].MagicAccuracy

  sets.midcast['Blue Magic']['Searing Tempest'] = 
  sets.midcast['Blue Magic'].Magical

  sets.midcast['Blue Magic']['Spectral Floe'] = 
  sets.midcast['Blue Magic'].Magical

  sets.midcast['Blue Magic']['Spectral Floe'].Resistant = 
  sets.midcast['Blue Magic'].MagicAccuracy

  sets.midcast['Blue Magic']['Entomb'] = 
  sets.midcast['Blue Magic'].Magical

  sets.midcast['Blue Magic']['Tenebral Crush'] = 
  sets.midcast['Blue Magic'].Magical

  sets.midcast['Blue Magic']['Magic Hammer'] = 
  sets.midcast['Blue Magic'].Magical

  sets.midcast['Blue Magic']['Dream Flower'] = 
  sets.midcast['Blue Magic'].MagicAccuracy

  sets.midcast['Blue Magic'].Healing = 
  sets.midcast['Blue Magic']['White Wind']

  sets.midcast['Blue Magic'].SkillBasedBuff = {}

  sets.midcast['Blue Magic']['Occultation'] = 
  sets.precast.FC
 
  sets.midcast['Blue Magic'].Buff = {}

  sets.midcast.Protect = 
  set_combine(sets.midcast['Blue Magic'].Buff, {})
  
  sets.midcast.Protectra = 
  set_combine(sets.midcast['Blue Magic'].Buff, {})
  
  sets.midcast.Shell = 
  set_combine(sets.midcast['Blue Magic'].Buff, {})
  
  sets.midcast.Shellra = 
  set_combine(sets.midcast['Blue Magic'].Buff, {})
  
  sets.midcast.Stoneskin = 
  set_combine(sets.midcast['Blue Magic'].Buff, {waist="Siegel Sash"})
  
  sets.midcast.Refresh = 
  set_combine(sets.midcast['Blue Magic'].Buff, {waist="Gishdubar sash"})
  
  sets.midcast['Blue Magic']['Battery Charge'] = 
  set_combine(sets.midcast['Blue Magic'].Buff, {waist="Gishdubar sash"})

-- Sets to return to when not performing an action.

-- Gear for learning spells: +skill and AF hands.
  sets.Learning = 
{
  hands=gear.Rawhide.hands,
  back=gear.ReiveJSE.BLU
}
 
  sets.latent_refresh = {waist="Fucho-no-obi"}

-- Resting sets
  sets.resting = 
{
  Ammo="Ginsen",
	head=gear.Rawhide.head,
	body="Mekosuchinae Harness",
	hands=gear.Carmine.hands,  
  legs=gear.Carmine.legs,
	feet=gear.Carmine.feet,
  neck="Bathy Choker +1",
	waist="Windbuffet Belt +1",  
  ear1="Infused Earring",
  ear2="Etiolation Earring",
	ring1="Defending Ring",
  ring2="Paguroidea Ring",
  back="Moonbeam Cape",
}

-- Idle sets
  sets.idle = 
{
  Ammo="Ginsen",
	head=gear.Rawhide.head,
	body="Mekosuchinae Harness",
	hands=gear.Carmine.hands,  
  legs=gear.Carmine.legs,
	feet=gear.Carmine.feet,
  neck="Bathy Choker +1",
	waist="Windbuffet Belt +1",  
  ear1="Infused Earring",
  ear2="Etiolation Earring",
	ring1="Defending Ring",
  ring2="Paguroidea Ring",
  back="Moonbeam Cape",
}
 
  sets.idle.PDT =               --45/39
{
  head=gear.Ayanmo.Head,      --2/2
  body=gear.Ayanmo.Body,      --5/5
  hands=gear.Ayanmo.Hands,    --2/2
  legs=gear.Ayanmo.Legs,      --4/4
  feet=gear.Ayanmo.Feet,      --2/2
  neck="Loricate Torque +1",  --6/6
  waist="Flume Belt +1",       --4/0
  ear1="Infused Earring",     --0/0 
  ear2="Etiolation Earring",  --0/3
  ring1="Defending Ring",     --10/10
  ring2="Patricius Ring",     --5/0 
  back="Moonbeam Cape",       --5/5
}

  sets.idle.MDT =               --38/48
{
  head=gear.Dampening.Cap,    --0/4
  body=gear.Ayanmo.Body,      --5/5
  hands=gear.Ayanmo.Hands,    --2/2
  legs=gear.Ayanmo.Legs,      --4/4
  feet=gear.Ayanmo.Feet,      --2/2
  neck="Loricate Torque +1",  --6/6
  waist="Flume Belt +1",       --4/0
  ear1="Odnowa Earring +1",   --0/2 
  ear2="Etiolation Earring",  --0/3
  ring1="Defending Ring",     --10/10
  ring2="Fortified Ring",     --0/5
  back="Moonbeam Cape",       --5/5
}

  sets.idle.Town = 
{
  ammo="Ginsen",
  head=gear.Carmine.head.HQ,
  body=gear.Jhakri.Body,
  hands=gear.Carmine.hands,  
  legs=gear.Carmine.legs,
  feet=gear.Carmine.feet,
  neck="Loricate Torque +1",
  waist="Flume Belt +1",    
  ear1="Odnowa Earring +1", 
  ear2="Etiolation Earring",
  ring1="Defending Ring",
  ring2="Patricius Ring",
  back="Moonbeam Cape",
}
 
  sets.idle.Learning = 
set_combine(sets.idle, sets.Learning)
 

-- Defense sets
  sets.defense.MDT =                --29/39
{
  ammo="Falcon Eye",
  head=gear.Dampening.Cap,          --0/4
  body=gear.Ayanmo.Body,            --5/5
  hands=gear.Herculeanhands.Triple, --2/0
  legs=gear.Ayanmo.Legs,            --4/4
  feet=gear.Herculeanfeet.Triple,   --2/0
  neck="Loricate Torque +1",        --6/6
  waist="Windbuffet Belt +1",       --0/0
  ear1="Odnowa Earring +1",         --0/2 
  ear2="Etiolation Earring",        --0/3
  ring1="Defending Ring",           --10/10
  ring2="Fortified Ring",           --0/5
  back=gear.AmbJSE.BLUDW
}
 
  sets.defense.PDT =                --40/27
{
  ammo="Ginsen",
  head=gear.Ayanmo.Head,            --2/2
  body=gear.Ayanmo.Body,            --5/5
  hands=gear.Herculeanhands.Triple, --2/0
  legs=gear.Ayanmo.Legs,            --4/4
  feet=gear.Herculeanfeet.Triple,   --2/0
  neck="Loricate Torque +1",        --6/6
  waist="Flume Belt +1",            --4/0
  ear1="Cessance Earring",
  ear2="Dignitary's earring",
  ring1="Defending Ring",           --10/10
  ring2="Patricius Ring",           --5/0
  back=gear.AmbJSE.BLUDW
}
 

  sets.Kiting = {legs=gear.Carmine.legs}
 
  sets.defense.Turtle =       --45/41
{
  head=gear.Ayanmo.Head,      --2/2
  body=gear.Ayanmo.Body,      --5/5
  hands=gear.Ayanmo.Hands,    --2/2
  legs=gear.Ayanmo.Legs,      --4/4
  feet=gear.Ayanmo.Feet,      --2/2
  neck="Loricate Torque +1",  --6/6
  waist="Flume Belt +1",       --4/0
  ear1="Odnowa Earring +1",   --0/2 
  ear2="Etiolation Earring",  --0/3
  ring1="Defending Ring",     --10/10
  ring2="Patricius Ring",     --5/0 
  back="Moonbeam Cape",       --5/5
}


-- Engaged sets

-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
-- sets if more refined versions aren't defined.
-- If you create a set with both offense and defense modes, the offense mode should be first.
-- EG: sets.engaged.Dagger.Accuracy.Evasion

-- Normal melee group

--1155 acc--
  sets.engaged =
{
  Ammo="Ginsen",
	head=gear.Dampening.Cap,
	body=gear.Adhemar.body,
	hands=gear.Herculeanhands.Triple,  
  legs=gear.Samnuhalegs,
	feet=gear.Herculeanfeet.Triple,
  neck="Ainia Collar",
	waist="Windbuffet Belt +1",  
  ear1="Cessance Earring",
  ear2="Dedition earring",
	ring1="Epona's Ring",
  ring2="Ilabrat Ring",
	back=gear.AmbJSE.BLUcrit
}

--Acc 1311--
  sets.engaged.Acc = 
{
  ammo="Falcon Eye",
  head=gear.Carmine.head.HQ,
  body=gear.Herculeanbody.Crit,
  hands=gear.Herculeanhands.Triple,
  legs=gear.Carmine.legs ,
  feet=gear.Carmine.feet,
  neck="Combatant's Torque",
  waist="Olseni Belt",
  ring1="Ramuh Ring +1",
  left_ear="Zennaroi Earring",
  right_ear="Digni. Earring",
  ring2="Ramuh Ring +1",
  back=gear.AmbJSE.BLUcrit
}

--Acc 1319--
  sets.engaged.Acc2 = 
{
  ammo="Falcon Eye",
  head=gear.Carmine.head.HQ,
  body=gear.Herculeanbody.Crit,
  hands=gear.Herculeanhands.Triple,
  legs=gear.Carmine.legs ,
  feet=gear.Carmine.feet,
  neck="Combatant's Torque",
  waist="Olseni Belt",
  ring1="Ramuh Ring +1",
  left_ear="Zennaroi Earring",
  right_ear="Digni. Earring",
  ring2="Ramuh Ring +1",
  back=gear.AmbJSE.BLUcrit
}

--Acc 1206--
  sets.engaged.iLvl = 
{
  Ammo="Ginsen",
	head=gear.Dampening.Cap,
	body=gear.Adhemar.body,
	hands=gear.Herculeanhands.Triple,  
  legs=gear.Samnuhalegs,
	feet=gear.Herculeanfeet.Triple,  
  neck="Clotharius Torque",
	waist="Kentarch Belt +1",  
  ear1="Cessance Earring",
  ear2="Dignitary's earring",
	ring1="Epona's Ring",
  ring2="Ilabrat Ring",
	back=gear.AmbJSE.BLUcrit
}

--Acc X--
  sets.engaged.Refresh = 
set_combine(sets.engaged.Acc, 
{
  Head=gear.Rawhide.head,
  body="Mekosuchinae Harness",
  legs=gear.Rawhide.legs
})


--Acc 1152--               
  sets.engaged.DW = 
{
  Ammo="Ginsen",
	head=gear.Dampening.Cap,
	body=gear.Adhemar.body,
	hands=gear.Herculeanhands.Triple,  
  legs=gear.Samnuhalegs,
	feet=gear.Herculeanfeet.Triple,
  neck="Ainia Collar",
	waist="Windbuffet Belt +1",  
  ear1="Cessance Earring",
  ear2="Dedition earring",
	ring1="Epona's Ring",
  ring2="Ilabrat Ring",
	back=gear.AmbJSE.BLUcrit
}


--Acc 1204--
  sets.engaged.DW.iLvl = 
{
  Ammo="Ginsen",
	head=gear.Dampening.Cap,
	body=gear.Adhemar.body,
	hands=gear.Herculeanhands.Triple,  
  legs=gear.Samnuhalegs,
	feet=gear.Herculeanfeet.Triple,  
  neck="Clotharius Torque",
	waist="Kentarch Belt +1",  
  ear1="Cessance Earring",
  ear2="Dignitary's earring",
	ring1="Epona's Ring",
  ring2="Ilabrat Ring",
	back=gear.AmbJSE.BLUcrit
}
  
  sets.engaged.DW.Acc = 
{
  ammo="Falcon Eye",
  head=gear.Carmine.head.HQ,
  body=gear.Herculeanbody.Crit,
  hands=gear.Herculeanhands.Triple,
  legs=gear.Carmine.legs ,
  feet=gear.Carmine.feet,
  neck="Combatant's Torque",
  waist="Olseni Belt",
  ring1="Ramuh Ring +1",
  left_ear="Zennaroi Earring",
  right_ear="Digni. Earring",
  ring2="Ramuh Ring +1",
  back=gear.AmbJSE.BLUcrit
}
  
--Acc 1385--
  sets.engaged.DW.Acc2 = 
{
  ammo="Falcon Eye",
  head=gear.Carmine.head.HQ,
  body=gear.Herculeanbody.Crit,
  hands=gear.Herculeanhands.Triple,
  legs=gear.Carmine.legs ,
  feet=gear.Carmine.feet,
  neck="Combatant's Torque",
  waist="Olseni Belt",
  ring1="Ramuh Ring +1",
  left_ear="Zennaroi Earring",
  right_ear="Digni. Earring",
  ring2="Ramuh Ring +1",
  back=gear.AmbJSE.BLUcrit
}
  
--Acc X--
  sets.engaged.DW.Refresh = 
  sets.engaged.Refresh

  sets.engaged.Learning = 
  set_combine(sets.engaged, sets.Learning)

  sets.engaged.DW.Learning = 
  set_combine(sets.engaged.DW, sets.Learning)
 
-- AM 3 MaxHaste Group
--Acc 1136--
  sets.engaged.MaxHaste = sets.engaged
  
--Acc 1306--
  sets.engaged.Acc.MaxHaste = sets.engaged.Acc

--Acc 1385--
  sets.engaged.Acc2.MaxHaste = sets.engaged.Acc2
  
--Acc 1202--
  sets.engaged.iLvl.MaxHaste = sets.engaged.iLvl

--MaxHaste Group
--Acc 1152--
  sets.engaged.DW.MaxHaste =  sets.engaged
  
--Acc 1313--
  sets.engaged.DW.Acc.MaxHaste = sets.engaged.Acc

--Acc 1385--
  sets.engaged.DW.Acc2.MaxHaste = sets.engaged.Acc2
  
--Acc 1204--
  sets.engaged.DW.iLvl.MaxHaste = sets.engaged.iLvl

  sets.engaged.Learning = 
  set_combine(sets.engaged, sets.Learning)

  sets.engaged.DW.Learning = 
  set_combine(sets.engaged.DW, sets.Learning)
 
sets.self_healing = {}

end 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)

    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
end
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
    end
    if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
    	equip(sets.self_healing)
    end
end
 
    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(status,gain_or_loss)
	handle_equipping_gear(player.status)
   	if (gain_or_loss) then  
     	add_to_chat(4,'------- Gained Buff: '..status..'-------')
     	if status == "Aftermath: Lv.3" then
       		add_to_chat(4,'------- AM3 Mode -------')
       		job_update(cmdParams, eventArgs)
			if not midaction() then handle_equipping_gear(player.status)
			end
    	end
    	if status == "KO" then
       		add_to_chat('GAME OVER')
    	end
		if status == "sleep" then
       		--send_command('input /party ZZZ please CURE')
			equip(sets.defense.Turtle)
			disable('ammo','head','neck','ear1','ear2','body','hands','ring1','ring2','back','waist','legs','feet')
		end
		if status == "terror" then
			equip(sets.defense.Turtle)
			disable('ammo','head','neck','ear1','ear2','body','hands','ring1','ring2','back','waist','legs','feet')
		end
		if status == "doom" then
       		--send_command('input /party DOOM please CURSNA')
        	equip({waist="Gishdubar Sash"})
        	disable('waist')
		end
--		if status == "slow" then
--       		send_command('input /party SLOW please ERASE')
--		end
--		if status == "curse" then
--       		send_command('input /party CURSE please CURSNA')
--		end
--		if status == "blind" then
--       		send_command('input /party BLIND please BLINDNA')
--		end
		if status == "charm" then
			equip(sets.defense.Turtle)
			disable('ammo','head','neck','ear1','ear2','body','hands','ring1','ring2','back','waist','legs','feet')
		end
--		if status == "paralysis" then
--       		send_command('input /party PARALYZED please PARALYNA')
--		end
	else
     	add_to_chat(3,'------- Lost Buff: '..status..'-------')
    	if status == "Aftermath: Lv.3" then
       		add_to_chat(4,'------- Normal Mode -------')
			job_update(cmdParams, eventArgs)
			if not midaction() then handle_equipping_gear(player.status)
			end
		end
		if status == "sleep" then
       		--send_command('input /party Awake')
			enable('ammo','head','neck','ear1','ear2','body','hands','ring1','ring2','back','waist','legs','feet')
		end
		if status == "terror" then
			enable('ammo','head','neck','ear1','ear2','body','hands','ring1','ring2','back','waist','legs','feet')
		end
		if status == "doom" then
        	enable('waist','ring1')
            --send_command('input /party Doom off')
		end
		if status == "slow" then
		end
		if status == "charm" then
			enable('ammo','head','neck','ear1','ear2','body','hands','ring1','ring2','back','waist','legs','feet')
		end
    end

--If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba','mighty guard'}:contains(status:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[status] ~= nil then
        handle_equipping_gear(player.status)
    end
end

 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.CapacityMode.value then
        idleSet = set_combine(idleSet, sets.CapacityMantle)
    end
    if state.LearnMode.value then
        idleSet = set_combine(idleSet, sets.LearnMode)
    end
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if state.LearnMode.value then
        meleeSet = set_combine(meleeSet, sets.LearnMode)
    end
    return meleeSet
end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)    
    if player.equipment.back == 'Nexus Cape' then
        disable('back')
    else
        enable('back')
    end
        if player.equipment.ring1 == 'Warp Ring' or player.equipment.ring1 == 'Dim. Ring (Holla)' or player.equipment.ring1 == 'Vocation Ring' or player.equipment.ring1 == 'Capacity Ring' then
        disable('ring1')
    else
        enable('ring1')
    end
    if player.equipment.ring2 == 'Warp Ring' or player.equipment.ring2 == 'Vocation Ring' or player.equipment.ring2 == 'Capacity Ring' then
        disable('ring2')
    else
        enable('ring2')
    end
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    determine_haste_group()
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function update_combat_form()
    -- Check for AM3
    if player.equipment.main == 'Tizona' and state.Buff['Aftermath: Lv.3'] then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
     
    if ( ( buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) ) or
         ( buffactive.march == 2 and buffactive.haste ) or
         ( buffactive['Mighty Guard'] and buffactive.haste ) or
         ( buffactive.haste == 2 ) ) then
        add_to_chat(8, '[[ Max-Haste Mode Enabled ]]')
        classes.CustomMeleeGroups:append('MaxHaste')
	else add_to_chat(8, '[[]]')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
        set_macro_page(1, 7)
end