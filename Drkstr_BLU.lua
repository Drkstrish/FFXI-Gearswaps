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
		state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
		state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
		state.Buff.Convergence = buffactive.Convergence or false
		state.Buff.Diffusion = buffactive.Diffusion or false
		state.Buff.Efflux = buffactive.Efflux or false
      
		state.CapacityMode = M(false, 'Capacity Point Mantle')
		state.LearnMode = M(false, 'Learning Mode')
		state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
          
		gear.AccAmmo = {name="Ginsen"}
		--gear.AccAmmoDay = "Tengu-no-Hane"
		--gear.AccAmmoNight = "Honed Tathlum"
    
-- All Augmented gear used in sets below
		blue_magic_maps = {}

-- Physical Spells --
      
-- Physical spells with no particular (or known) stat mods
		blue_magic_maps.Physical = S{'Bilgestorm'}
-- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
		blue_magic_maps.PhysicalAcc = S{'Heavy Strike'}
-- Physical spells with Str stat mod
		blue_magic_maps.PhysicalStr = S{'Battle Dance',
	'Bloodrake','Death Scissors','Dimensional Death','Empty Thrash',
	'Quadrastrike','Spinal Cleave','Uppercut','Vertical Cleave'}
-- Physical spells with Dex stat mod
		blue_magic_maps.PhysicalDex = S{'Amorphic Spikes',
	'Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment','Foot Kick',
	'Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
	'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault','Vanity Dive'}
-- Physical spells with Vit stat mod
		blue_magic_maps.PhysicalVit = S{'Body Slam',
	'Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
	'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'}
-- Physical spells with Agi stat mod
		blue_magic_maps.PhysicalAgi = S{'Benthic Typhoon',
	'Feather Storm','Helldive','Hydro Shot','Jet Stream',
	'Pinecone Bomb','Spiral Spin','Wild Oats'}
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
		blue_magic_maps.Magical = S{'Blastbomb',
	'Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
	'Droning Whirlwind','Embalming Earth','Firespit','Foul Waters','Ice Break',
	'Leafstorm','Maelstrom','Regurgitation','Rending Deluge','Retinal Glare',
	'Subduction','Tem. Upheaval','Water Bomb','Tenebral Crush','Entomb','Spectral Floe',
	'Blinding Fulgor'}
-- Magical spells with a primary Mnd mod
		blue_magic_maps.MagicalMnd = S{'Acrid Stream',
	'Evryone. Grudge','Magic Hammer','Mind Blast','Scouring Spate'}
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
		blue_magic_maps.MagicAccuracy = S{'1000 Needles',
	'Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
	'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
	'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
	'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
	'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
	'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
	'Sandspin','Sandspray','Sheep Song','Spectral Floe','Soporific','Sound Blast','Stinking Gas',
	'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'}
-- Breath-based spells
		blue_magic_maps.Breath = S{'Bad Breath',
	'Flying Hip Press','Frost Breath','Heat Breath','Hecatomb Wave',
	'Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
	'Thunder Breath','Vapor Spray','Wind Breath'}
-- Stun spells
		blue_magic_maps.Stun = S{'Blitzstrahl',
	'Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
	'Thunderbolt','Whirl of Rage'}

-- Healing spells
		blue_magic_maps.Healing = S{'Healing Breeze',
	'Magic Fruit','Plenilune Embrace','Pollen','White Wind','Wild Carrot'}

-- Buffs that depend on blue magic skill
		blue_magic_maps.SkillBasedBuff = S{'Barrier Tusk',
	'Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
	'Pyric Bulwark','Reactor Cool',}
    
-- Other general buffs
		blue_magic_maps.Buff = S{'Amplification',
	'Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
	'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
	'Memento Mori','Nat. Meditation','Occultation','Orcish Counterstance','Refueling',
	'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
	'Zephyr Mantle'}
      
-- Spells that require Unbridled Learning to cast.
		unbridled_spells = S{'Absolute Terror',
	'Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
	'Droning Whirlwind','Gates of Hades','Harden Shell','Pyric Bulwark','Thunderbolt',
	'Tourbillion'}
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
    
-- Additional local binds
		send_command('bind ^` input /ja "Chain Affinity" <me>')
		send_command('bind !` input /ja "Burst Affinity" <me>')
          
		update_combat_form()
		select_acc_ammo()
		select_default_macro_book()
	end
    
    
-- Called when this job file is unloaded (eg: job change)
	function user_unload()
		send_command('unbind ^`')
		send_command('unbind !`')
	end
    
    
-- Set up gear sets.
	function init_gear_sets()
--------------------------------------
-- Start defining the sets
--------------------------------------
    
sets.buff['Burst Affinity'] = {} -- Reforged Empy Feet +1, Reforged AF Legs +1
sets.buff['Chain Affinity'] = {} -- Reforged Empy Head +1, Reforged AF Feet +1, Swords - Iris, Acclimator
sets.buff.Convergence = {} -- Reforged Relic Head +1
sets.buff.Diffusion = {Feet="Luhlaza Charuqs +1"}
sets.buff.Enchainment = {body="Luhlaza Jubbah +1"}
sets.buff.Efflux = {back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10'}}} -- Reforged Empy Legs +1
-- Capacity Set
sets.CapacityMantle = {back="Mecistopins Mantle"}
-- Learning Set
sets.LearnMode = {hands="Rawhide Gloves",back="Cornflower Cape"} -- Update with all my misc. Blue Magic Skill gear.
-- Precast Sets
-- Precast sets to enhance JAs
sets.precast.JA['Azure Lore'] = {} -- Reforged AF Hands +1
sets.precast.JA['Box Step'] = sets.engaged.Acc 
sets.precast.JA['Stutter Step'] = sets.engaged.Acc
sets.precast.JA['Violent Flourish'] = sets.engaged.Acc
-- Waltz set (chr and vit)
sets.precast.Waltz = {}
-- Don't need any special gear for Healing Waltz.
sets.precast.Waltz['Healing Waltz'] = {}
 -- Fast cast sets for spells 
sets.precast.FC = { -- 50 FC 6 QM
	head="Carmine Mask" -- 12 FC
	neck="Orunmila's Torque", -- 5 FC
	left_ear="Etiolation Earring", -- 1 FC
	right_ear="Loquacious Earring" -- 2 FC
	body="Luhlaza Jubbah +1", -- 7 FC
	hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, -- 7 FC
	left_ring="Rahab Ring", -- 2 FC
	right_ring="Lebeche Ring", -- 2 QM
	back="Perimede Cape", -- 4 QM
	legs="Psycloth Lappas", -- 7 FC
	feet="Carmine Greaves"} -- 7 FC
                  
		sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {})
    
          
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    
		sets.precast.WS = {ammo="Ginsen",
	head="Adhemar Bonnet",
	neck="Fotia Gorget",
	ear1="Moonshade Earring",
	ear2="Digni. Earring",
	body="Herculean Vest",
	hands={ name="Herculean Gloves", augments={'Accuracy+16','Crit.hit rate+5','DEX+1',}},
	ring1="Epona's Ring",
	ring2="Petrov Ring",
	back="Rosmerta's Cape",
	waist="Fotia Belt",
	legs="Samnuha Tights",
	feet="Thereoid Greaves",}
      
		sets.precast.WS.acc = {}
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

        sets.precast.WS['Requiescat'] = {ammo="Ginsen",
	head="Dampening Tam",
	neck="Fotia Gorget",
	ear1="Moonshade earring",
	ear2="Brutal Earring",
	body="Herculean Vest",
	hands= { name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
	ring1="Epona's ring",
	ring2="Petrov ring",
	back="Vespid Mantle",
	waist="Fotia Belt",
	legs="Carmine Cuisses +1",
	feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}

        sets.precast.WS['Realmrazer'] = sets.precast.WS['Requiescat']

        sets.precast.WS['Circle Blade'] = {ammo="Ginsen",
	head="Adhemar Bonnet",
	neck="Fotia Gorget",
	ear1="Moonshade earring",
	ear2="Brutal Earring",
	body="Despair Mail",
	hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
	ring1="Apate ring",
	ring2="Petrov ring",
	back="Vespid Mantle",
	waist="Fotia Belt",
	legs="Samnuha Tights",
	feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}
         
		sets.precast.WS['Vorpal Blade'] = {ammo="Ginsen",
	head="Adhemar Bonnet",
	neck="Fotia Gorget",
	ear1="Moonshade earring",
	ear2="Brutal Earring",
	body="Herculean Vest",
	hands={ name="Herculean Gloves", augments={'Accuracy+16','Crit.hit rate+5','DEX+1',}},
	ring1="Apate ring",
	ring2="Petrov ring",
	back="Rosmerta's Cape",
	waist="Fotia Belt",
	legs="Samnuha Tights",
	feet="Thereoid Greaves"}
         
		sets.precast.WS['Chant du Cygne'] = {ammo="Ginsen",
	head="Adhemar Bonnet",
	neck="Fotia Gorget",
	ear1="Moonshade earring",
	ear2="Brutal Earring",
	body="Herculean Vest",
	hands={ name="Herculean Gloves", augments={'Accuracy+16','Crit.hit rate+5','DEX+1',}},
	ring1="Apate ring",
	ring2="Petrov ring",
	back="Rosmerta's Cape",
	waist="Fotia Belt",
	legs="Samnuha Tights",
	feet="Thereoid Greaves"}
         
		sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
	head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12',}},
	neck="Fotia Gorget",
	ear1="Moonshade earring",
	ear2="Friomisi Earring",
	body="Amalric Doublet",
	hands="Amalric Gages",
	ring1="Vertigo Ring",
	ring2="Apate Ring",
	back="Argochampsa Mantle",
	waist="Eschan Stone",
	legs="Amalric Slops",
	feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}}
         
    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {})
      
      
    -- Midcast Sets
		   
        sets.midcast.FastRecast = sets.precast.FC
	    sets.midcast['Blue Magic'] = {}
      
    -- Physical Spells --
          
        sets.midcast['Blue Magic'].Physical = { ammo="Ginsen",
	head="Dampening Tam",
	neck="Fotia Gorget",
	ear1="Lempo earring",
	ear2="Digni. Earring",
	body="Herculean Vest",
	hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
	ring1="Epona's Ring",
	ring2="Petrov Ring",
	back="Cornflower Cape",
	waist="Eschan Stone",
	legs="Samnuha Tights",
	feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}


        sets.midcast['Blue Magic'].PhysicalAcc = { ammo="Ginsen",
    head="Dampening Tam",
	neck="Sanctity necklace",
	ear1="Lempo earring",
	ear2="Digni. Earring",
	body="Herculean Vest",
	hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
	ring1="Epona's Ring",
	ring2="Petrov Ring",
	back="Cornflower Cape",
	waist="Olseni Belt",
	legs="Carmine Cuisses +1",
	feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}

		sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})
        sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {})
        sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})
        sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})
        sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})
        sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})
        sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})
        sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)
    
    
    -- Magical Spells --
      
        sets.midcast['Blue Magic'].Magical = { Ammo="Pemphredo Tathlum",
	head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12',}},
	neck="Sanctity Necklace",
	ear1="Friomisi Earring",
	ear2="Dignitary's Earring",
	body="Amalric Doublet",
	hands="Amalric Gages",
	ring1="Rahab Ring",
	ring2="Vertigo Ring",
	back="Cornflower Cape",
	waist="Eschan Stone",
	legs="Amalric Slops",
	feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}}
        sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {})
        sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {})
        sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)
        sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})
        sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)
        sets.midcast['Blue Magic'].MagicalStr = set_combine(sets.midcast['Blue Magic'].Magical)
        sets.midcast['Blue Magic'].MagicalAgi = set_combine(sets.midcast['Blue Magic'].Magical)
        sets.midcast['Blue Magic'].MagicAccuracy = { Ammo="Pemphredo Tathlum",
  head="Dampening Tam",
  neck="Sanctity Necklace",
  ear1="Gwati Earring",
  ear2="Dignitary's Earring",
  body="Amalric Doublet",
  hands="Leyline Gloves",
  ring1="Etana Ring",
  ring2="Vertigo Ring",
  back="Cornflower Cape",
  waist="Luminary Sash",
  legs="Psycloth Lappas",
  feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}}
                
    -- Breath Spells --
    
		sets.midcast['Blue Magic'].Breath = {}
    
    -- Other Types --
          
		sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})
        sets.midcast['Blue Magic']['White Wind'] = {}
		sets.midcast['Blue Magic']['Subduction'] = { Ammo="Pemphredo Tathlum",
	head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12',}},
	neck="Sanctity Necklace",
	ear1="Friomisi Earring",
	ear2="Dignitary's Earring",
	body="Amalric Doublet",
	hands="Amalric Gages",
	ring1="Rahab Ring",
	ring2="Vertigo Ring",
	back="Cornflower Cape",
	waist="Eschan Stone",
	legs="Amalric Slops",
	feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}}
        sets.midcast['Blue Magic']['Searing Tempest'] = { Ammo="Pemphredo Tathlum",
	head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12',}},
	neck="Sanctity Necklace",
	ear1="Friomisi Earring",
	ear2="Dignitary's Earring",
	body="Amalric Doublet",
	hands="Amalric Gages",
	ring1="Rahab Ring",
	ring2="Vertigo Ring",
	back="Cornflower Cape",
	waist="Eschan Stone",
	legs="Amalric Slops",
	feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}}
        sets.midcast['Blue Magic']['Spectral Floe'] = { Ammo="Pemphredo Tathlum",
	head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12',}},
	neck="Sanctity Necklace",
	ear1="Friomisi Earring",
	ear2="Dignitary's Earring",
	body="Amalric Doublet",
	hands="Amalric Gages",
	ring1="Rahab Ring",
	ring2="Vertigo Ring",
	back="Cornflower Cape",
	waist="Eschan Stone",
	legs="Amalric Slops",
	feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}}
	   sets.midcast['Blue Magic']['Entomb'] = { Ammo="Pemphredo Tathlum",
    head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12',}},
    neck="Sanctity Necklace",
    ear1="Friomisi Earring",
    ear2="Dignitary's Earring",
    body="Amalric Doublet",
    hands="Amalric Gages",
    ring1="Rahab Ring",
    ring2="Vertigo Ring",
    back="Cornflower Cape",
    waist="Eschan Stone",
    legs="Amalric Slops",
    feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}}
        sets.midcast['Blue Magic']['Tenebral Crush'] = { Ammo="Pemphredo Tathlum",
    head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12',}},
    neck="Sanctity Necklace",
    ear1="Friomisi Earring",
    ear2="Dignitary's Earring",
    body="Amalric Doublet",
    hands="Amalric Gages",
    ring1="Rahab Ring",
    ring2="Vertigo Ring",
    back="Cornflower Cape",
    waist="Eschan Stone",
    legs="Amalric Slops",
    feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}}
        sets.midcast['Blue Magic']['Palling Salvo'] = { Ammo="Pemphredo Tathlum",
    head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12',}},
    neck="Sanctity Necklace",
    ear1="Friomisi Earring",
    ear2="Dignitary's Earring",
    body="Amalric Doublet",
    hands="Amalric Gages",
    ring1="Rahab Ring",
    ring2="Vertigo Ring",
    back="Cornflower Cape",
    waist="Eschan Stone",
    legs="Amalric Slops",
    feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}}
        sets.midcast['Blue Magic']['Magic Hammer'] = { Ammo="Pemphredo Tathlum",
    head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12',}},
    neck="Sanctity Necklace",
    ear1="Friomisi Earring",
    ear2="Dignitary's Earring",
    body="Amalric Doublet",
    hands="Amalric Gages",
    ring1="Rahab Ring",
    ring2="Vertigo Ring",
    back="Cornflower Cape",
    waist="Eschan Stone",
    legs="Amalric Slops",
    feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}}
        sets.midcast['Blue Magic'].Healing = { Ammo="Pemphredo Tathlum",
    head="Dampening Tam",
    neck="Sanctity Necklace",
    ear1="Infused Earring",
    ear2="Mendicant's Earring",
    body="Amalric Doublet",
    hands="Amalric Gages",
    ring1="Etana Ring",
    ring2="Vertigo Ring",
    back="Solemnity Cape",
    waist="Luminary Sash",
    legs="Psycloth Lappas",
    feet="Medium's Sabots"}
        sets.midcast['Blue Magic'].SkillBasedBuff = {}
        sets.midcast['Blue Magic'].Buff = {}
      
        sets.midcast.Protect = {}
        sets.midcast.Protectra = {}
        sets.midcast.Shell = {}
        sets.midcast.Shellra = {}
        sets.midcast.Stoneskin = {}
        sets.midcast.Refresh = {}
        sets.midcast['Blue Magic']['Battery Charge'] = {}

    -- Sets to return to when not performing an action.
    
    -- Gear for learning spells: +skill and AF hands.
        sets.Learning = {hands="Rawhide Gloves",back="Cornflower Cape"}
        sets.latent_refresh = {}
    
    -- Resting sets
        sets.resting = {}
      
    -- Idle sets
        sets.idle = { Ammo="Ginsen",
    head="Rawhide Mask",
    neck="Sanctity Necklace",
    ear1="Infused Earring",
    ear2="Dignitary's Earring",
    body="Mekosuchinae Harness",
    hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
    ring1="Warden's Ring",
    ring2="Petrov Ring",
    back="Grounded Mantle +1",
    waist="Windbuffet Belt +1",
    legs="Carmine Cuisses +1",
    feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}
    
        sets.idle.PDT = { Ammo="Ginsen",
    head="Rawhide Mask",
    neck="Sanctity Necklace",
    ear1="Infused Earring",
    ear2="Dignitary's Earring",
    body="Mekosuchinae Harness",
    hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
    ring1="Warden's Ring",
    ring2="Petrov Ring",
    back="Grounded Mantle +1",
    waist="Windbuffet Belt +1",
    legs="Carmine Cuisses +1",
    feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}
    
        sets.idle.MDT = { Ammo="Ginsen",
    head="Rawhide Mask",
    neck="Sanctity Necklace",
    ear1="Infused Earring",
    ear2="Dignitary's Earring",
    body="Mekosuchinae Harness",
    hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
    ring1="Warden's Ring",
    ring2="Petrov Ring",
    back="Grounded Mantle +1",
    waist="Windbuffet Belt +1",
    legs="Carmine Cuisses +1",
    feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}
                  
        sets.idle.Town = { Ammo="Ginsen",
    head="Dampening Tam",
    neck="Clotharius Torque",
    ear1="Bladeborn Earring",
    ear2="Steelflash Earring",
    body="Adhemar Jacket",
    hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
    ring1="Epona's Ring",
    ring2="Petrov Ring",
    back="Grounded Mantle +1",
    waist="Windbuffet Belt +1",
    legs="Carmine Cuisses +1",
    feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}
    
        sets.idle.Learning = set_combine(sets.idle, sets.Learning)
    
    -- Defense sets
  
		sets.defense.PDT = {}
    
        sets.defense.MDT = {}
    
        sets.Kiting = {legs="Carmine Cuisses +1"}
    
    -- Engaged sets
    
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
      
    -- Normal melee group
           
    sets.engaged = {}
           
           sets.engaged.Acc =  { Ammo="Ginsen",
  head="Dampening Tam",
  neck="Decimus Torque",
  ear1="Dignitary's Earring",
  ear2="Zennaroi Earring",
  body="Herculean Vest",
  hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
  ring1="Etana Ring",
  ring2="Beeline Ring",
  back="Grounded Mantle +1",
  waist="Olseni Belt",
  legs="Carmine Cuisses +1",
  feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}
          
        sets.engaged.Refresh = set_combine(sets.engaged.Acc, {Head="Rawhide Mask",body="Mekosuchinae Harness",legs="Rawhide Trousers"})
                  
        sets.engaged.DW = { Ammo="Ginsen",
  head="Dampening Tam",
  neck="Clotharius Torque",
  ear1="Bladeborn Earring",
  ear2="Steelflash Earring",
  body="Adhemar Jacket",
  hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
  ring1="Epona's Ring",
  ring2="Petrov Ring",
  back="Grounded Mantle +1",
  waist="Windbuffet Belt +1",
  legs="Samnuha Tights",
  feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}

 

        sets.engaged.DW.iLvl = { Ammo="Ginsen",
  head="Dampening Tam",
  neck="Clotharius Torque",
  ear1="Bladeborn Earring",
  ear2="Steelflash Earring",
  body="Adhemar Jacket",
  hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
  ring1="Epona's Ring",
  ring2="Petrov Ring",
  back="Grounded Mantle +1",
  waist="Windbuffet Belt +1",
    legs="Samnuha Tights",
    feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}
   
        sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {})
        sets.engaged.DW.Acc2 = set_combine(sets.engaged.DW.Acc, {})
    
        sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
        sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)
    
    -- Haste Group
        sets.engaged.DW.Haste = set_combine(sets.engaged.DW, {})
        sets.engaged.DW.Acc.Haste = set_combine(sets.engaged.DW.Haste, {})
		sets.engaged.DW.Acc2.Haste = set_combine(sets.engaged.DW.Acc.Haste, {})
          
    -- MaxHaste Group
        sets.engaged.DW.MaxHaste = set_combine(sets.engaged.DW, {ear1="Bladeborn Earring",ear2="Steelflash Earring"})
        sets.engaged.DW.Acc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {})
        sets.engaged.DW.Acc2.MaxHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, {})
         
        sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
        sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)
    
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
   
   -- Called when a player gains or loses a buff.
   -- buff == buff gained or lost
   -- gain == true if the buff was gained, false if it was lost.
   function job_buff_change(buff, gain)
       if state.Buff[buff] ~= nil then
           state.Buff[buff] = gain
                   select_acc_ammo()
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
           set_combine(idleSet, sets.latent_refresh)
       end
       if state.CapacityMode.value then
           idleSet = set_combine(idleSet, sets.CapacityMantle)
       end
       if state.LearnMode.value then
           idleSet = set_combine(idleSet, sets.LearnMode)
       end
           select_acc_ammo()
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
    
   -- Called by the 'update' self-command, for common needs.
   -- Set eventArgs.handled to true if we don't want automatic equipping of gear.
   function job_update(cmdParams, eventArgs)
       update_combat_form()
           select_acc_ammo()
   end
    
    
   -------------------------------------------------------------------------------------------------------------------
  -- Utility functions specific to this job.
   -------------------------------------------------------------------------------------------------------------------
   
   function update_combat_form()
       -- Check for H2H or single-wielding
       if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
           state.CombatForm:reset()
       else
           state.CombatForm:set('DW')
       end
   end
    
   -- Select Correct Ammo for Day or Night --
  function select_acc_ammo()
           if world.time >= (18*60) or world.time <= (6*60) then
                   gear.AccAmmo.name = gear.AccAmmoNight
           else
                   gear.AccAmmo.name = gear.AccAmmoDay
           end
   end
    
   -- Select default macro book on initial load or subjob change.
   function select_default_macro_book()
       -- Default macro set/book
       if player.sub_job == 'DNC' then
           set_macro_page(1, 7)
       else
           set_macro_page(1, 7)
       end
   end
