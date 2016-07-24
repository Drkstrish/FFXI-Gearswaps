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
        state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false  
        state.Buff.Convergence = buffactive.Convergence or false
        state.Buff.Diffusion = buffactive.Diffusion or false
        state.Buff.Efflux = buffactive.Efflux or false
    
    include('Mote-TreasureHunter')
    
        state.TreasureMode:set('Tag')
        state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi', 'Trust'}

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
	
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
        state.OffenseMode:options('Normal', 'Acc', 'Refresh', 'Learning')
        state.WeaponskillMode:options('Normal', 'Acc')
        state.CastingMode:options('Normal', 'Resistant')
        state.IdleMode:options('Normal', 'PDT', 'Learning')

-- Additional local binds
        send_command('bind ^` input /ja "Chain Affinity" <me>')
        send_command('bind !` input /ja "Efflux" <me>')
        send_command('bind @` input /ja "Burst Affinity" <me>')
        send_command('bind @f9 gs c cycle HasteMode')

        update_combat_form()
    
        select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind @f9')
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
-- Precast Sets
-- Precast sets to enhance JAs
sets.precast.JA['Azure Lore'] = {} -- Reforged AF Hands +1
sets.precast.JA['Box Step'] = sets.engaged.Acc 
sets.precast.JA['Stutter Step'] = sets.engaged.Acc
sets.precast.JA['Violent Flourish'] = sets.engaged.Acc
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
sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {}) -- Reforged Empy Body +1 for -14% Blue magic casting time.
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
sets.precast.WS = {ammo="Ginsen", 
	head="Lilutu Headpiece",neck="Fotia Gorget",ear1="Zennaroi Earring",ear2="Dignitary's earring ",
	body={ name="Herculean Vest", augments={'Accuracy+28','Crit.hit rate+5','DEX+5','Attack+12',}},
	hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
	ring1="Epona's Ring",ring2="Petrov Ring",
	back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	waist="Fotia Belt",legs="Samnuha Tights",
	feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}
sets.precast.WS.acc = set_combine(sets.precast.WS, {Ammo="Falcon Eye",
	head="Dampening Tam",neck="Decimus Torque",ring1="Cacoethic Ring +1",ring2="Cacoethic Ring",
	waist="Olseni Belt",legs="Carmine Cuisses +1"})
-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
sets.precast.WS['Requiescat'] = {ammo="Ginsen",
	head="Dampening Tam",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
	body="Mekosuchinae harness",hands="Rawhide Gloves",ring1="Rufescent Ring",ring2="Tjukurrpa Annulet",
	back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	waist="Fotia Belt",legs="Carmine Cuisses +1",feet="Carmine Greaves"}
sets.precast.WS['Chant du Cygne'] = {ammo="Falcon Eye",
	head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Moonshade earring",ear2="Brutal Earring",
	body={ name="Herculean Vest", augments={'Accuracy+28','Crit.hit rate+5','DEX+5','Attack+12',}},
	hands={ name="Herculean Gloves", augments={'Accuracy+16','Crit.hit rate+5','DEX+1',}},
	ring1="Epona's ring",ring2="Petrov ring",
	back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}},
	waist="Fotia Belt",legs="Samnuha Tights",feet="Thereoid Greaves"}
sets.precast.WS['Savage Blade'] = {ammo="Mantoptera Eye",
	head="Dampening Tam",neck="Fotia Gorget",ear1="Moonshade Earring",ring2="Brutal Earring",
	body={ name="Herculean Vest", augments={'Accuracy+28','Crit.hit rate+5','DEX+5','Attack+12',}},
	hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
	ring1="Rufescent Ring",ring2="Petrov Ring",
	back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	waist="Fotia Belt",legs="Samnuha Tights",
	feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}
sets.precast.WS['Expiacion'] = sets.precast.WS['Savage Blade']
sets.precast.WS['Vorpal Blade'] = {ammo="Ginsen",
	head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Moonshade earring",ear2="Brutal Earring",
	body={ name="Herculean Vest", augments={'Accuracy+28','Crit.hit rate+5','DEX+5','Attack+12',}},
	hands={ name="Herculean Gloves", augments={'Accuracy+16','Crit.hit rate+5','DEX+1',}},
	ring1="Epona's ring",ring2="Petrov ring",
	back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}},
	waist="Fotia Belt",legs="Samnuha Tights",feet="Thereoid Greaves"}
sets.precast.WS['Realmrazer'] = sets.precast.WS['Requiescat']
sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
	head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12',}},
	neck="Sanctity Necklace",ear1="Moonshade earring",ear2="Friomisi Earring",
	body="Amalric Doublet",hands="Carmine",ring1="Vertigo Ring",ring2="Apate Ring",
	back="Argochampsa Mantle",waist="Eschan Stone",legs="Amalric Slops",
	feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}}
sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {})
-- Midcast Sets
sets.midcast.FastRecast = sets.precast.FC
sets.midcast['Blue Magic'] = {}
-- Physical Spells --
sets.midcast['Blue Magic'].Physical = { ammo="Ginsen",
	head="Dampening Tam",neck="Sanctity Necklace",ear1="Lempo earring",ear2="Digni. Earring",
	body={ name="Herculean Vest", augments={'Accuracy+28','Crit.hit rate+5','DEX+5','Attack+12',}},
	hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
	ring1="Epona's Ring",ring2="Petrov Ring",back="Cornflower Cape",
	waist="Eschan Stone",legs="Samnuha Tights",
	feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}}
sets.midcast['Blue Magic'].PhysicalAcc = sets.midcast['Blue Magic'].Physical
sets.midcast['Blue Magic'].PhysicalStr = sets.midcast['Blue Magic'].Physical
sets.midcast['Blue Magic'].PhysicalDex = sets.midcast['Blue Magic'].Physical
sets.midcast['Blue Magic'].PhysicalVit = sets.midcast['Blue Magic'].Physical
sets.midcast['Blue Magic'].PhysicalAgi = sets.midcast['Blue Magic'].Physical
sets.midcast['Blue Magic'].PhysicalInt = sets.midcast['Blue Magic'].Physical
sets.midcast['Blue Magic'].PhysicalMnd = sets.midcast['Blue Magic'].Physical
sets.midcast['Blue Magic'].PhysicalChr = sets.midcast['Blue Magic'].Physical
sets.midcast['Blue Magic'].PhysicalHP = sets.midcast['Blue Magic'].Physical
-- Magical Spells --
sets.midcast['Blue Magic'].Magical = {Ammo="Pemphredo Tathlum",
	head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12',}},
	neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Dignitary's Earring",
	body="Amalric Doublet",hands="Amalric Gages",ring1="Rahab Ring",ring2="Vertigo Ring",
	back="Cornflower Cape",waist="Eschan Stone",legs="Amalric Slops",
	feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}}
sets.midcast['Blue Magic'].Magical.Resistant = sets.midcast['Blue Magic'].Magical
sets.midcast['Blue Magic'].MagicalMnd = sets.midcast['Blue Magic'].Magical
sets.midcast['Blue Magic'].MagicalChr = sets.midcast['Blue Magic'].Magical
sets.midcast['Blue Magic'].MagicalVit = sets.midcast['Blue Magic'].Magical
sets.midcast['Blue Magic'].MagicalDex = sets.midcast['Blue Magic'].Magical
sets.midcast['Blue Magic'].MagicAccuracy = {Ammo="Pemphredo Tathlum",
	head="Dampening Tam",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Dignitary's Earring",
	body="Amalric Doublet",hands="Leyline Gloves",ring1="Etana Ring",ring2="Vertigo Ring",
	back="Cornflower Cape",waist="Luminary Sash",legs="Psycloth Lappas",
	feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}}
-- Breath Spells --
sets.midcast['Blue Magic'].Breath = sets.midcast['Blue Magic'].MagicAccuracy
-- Other Types --
sets.midcast['Blue Magic'].Stun = sets.midcast['Blue Magic'].MagicAccuracy
sets.midcast['Blue Magic']['White Wind'] = {} -- HP and Cure Potency
sets.midcast['Blue Magic'].Healing = {} -- Cure Potency
sets.midcast['Blue Magic'].SkillBasedBuff = {} -- Put in all Blue Magic Skill stuff
sets.midcast['Blue Magic'].Buff = {}
sets.midcast.Protect = {}
sets.midcast.Protectra = {}
sets.midcast.Shell = {}
sets.midcast.Shellra = {}
-- Sets to return to when not performing an action.
-- Gear for learning spells: +skill and AF hands.
sets.Learning = {hands="Rawhide Gloves",back="Cornflower Cape"}
sets.latent_refresh = {}
-- Resting sets
sets.resting = {}
-- Idle sets
sets.idle = {Ammo="Ginsen",
	head="Rawhide Mask",neck="Sanctity Necklace",ear1="Infused Earring",ear2="Dignitary's Earring",
	body="Mekosuchinae Harness",
	hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
	ring1="Defending Ring",ring2="Warden's Ring",
	back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}},
	waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",
	feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5',}}}
sets.idle.PDT = sets.idle
sets.idle.Town = {ammo="Ginsen",
        head="Dampening Tam",neck="Sanctity Necklace",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Adhemar Jacket",
	hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9',}},
        ring1="Defending Ring",ring2="Warden's Ring",
	back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}},
	waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",
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
sets.engaged = {ammo="",
	head="",neck="",ear1="",ear2="",
	body="",hands="",ring1="",ring2"",
	back="",waist="",legs="",feet""}
sets.engaged.Acc = {ammo="",
	head="",neck="",ear1="",ear2="",
	body="",hands="",ring1="",ring2"",
	back="",waist="",legs="",feet""}
sets.engaged.Refresh = {ammo="",
	head="",neck="",ear1="",ear2="",
	body="",hands="",ring1="",ring2"",
	back="",waist="",legs="",feet""}
sets.engaged.DW = {ammo="",
	head="",neck="",ear1="",ear2="",
	body="",hands="",ring1="",ring2"",
	back="",waist="",legs="",feet""}
sets.engaged.DW.Acc = {ammo="",
	head="",neck="",ear1="",ear2="",
	body="",hands="",ring1="",ring2"",
	back="",waist="",legs="",feet""}
sets.engaged.DW.Refresh = {ammo="",
	head="",neck="",ear1="",ear2="",
	body="",hands="",ring1="",ring2"",
	back="",waist="",legs="",feet""}
sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)
sets.engaged.MaxHaste = set_combine(sets.engaged, {})--put gear here
sets.engaged.Mid.MaxHaste = set_combine(sets.engaged.MaxHaste, {})--put gear here
sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, {})--put gear here
sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, {})
sets.engaged.Mid.PDT.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, {})
sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged.Acc.MaxHaste, {})
sets.engaged.Haste_35 = set_combine(sets.engaged.MaxHaste, {})
sets.engaged.Mid.Haste_35 = set_combine(sets.engaged.Mid.MaxHaste, {})
sets.engaged.Acc.Haste_35 = set_combine(sets.engaged.Acc.MaxHaste, {})
sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.Haste_35, {})
sets.engaged.Mid.PDT.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, {})
sets.engaged.Acc.PDT.Haste_35 = set_combine(sets.engaged.Acc.Haste_35, {})
sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_35, {})
sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Low.Haste_30, {})
sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, {})
sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, {})
sets.engaged.Mid.PDT.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, {})
sets.engaged.Acc.PDT.Haste_30 = set_combine(sets.engaged.Acc.Haste_30, {})
sets.engaged.Haste_15 = set_combine(sets.engaged.Haste_30, {})
sets.engaged.Mid.Haste_15 = set_combine(sets.engaged.Low.Haste_15, {})
sets.engaged.Acc.Haste_15 = sets.engaged.Acc.Haste_30
sets.engaged.PDT.Haste_15 = set_combine(sets.engaged.Haste_15, {})
sets.engaged.Mid.PDT.Haste_15 = set_combine(sets.engaged.Mid.Haste_15, {})
sets.engaged.Acc.PDT.Haste_15 = set_combine(sets.engaged.Acc.Haste_15, {})
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
    if spell.name == 'Spectral Jig' and buffactive.sneak then
        -- If sneak is active when using, cancel before completion
        send_command('cancel 71')
    end
    if string.find(spell.english, 'Utsusemi') then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
            cancel_spell()
            eventArgs.cancel = true
            return
        end
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
    end
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    if buff:startswith('Aftermath') then
        if player.equipment.main == 'Tizona' then
            classes.CustomMeleeGroups:clear()

            if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('AM3')
                add_to_chat(8, '-------------AM3 UP-------------')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
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
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    determine_haste_group()
    th_update(cmdParams, eventArgs)
end

function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then 
            return true
    end
end

function determine_haste_group()

    classes.CustomMeleeGroups:clear()
    -- mythic AM	
    if player.equipment.main == 'Tizona' then
        if buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end
    end
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
    -- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
    -- Embrava 30% with 500 enhancing skill
    -- Mighty Guard - 15%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- buffactive[604] = mighty guard
    -- state.HasteMode = toggle for when you know Haste II is being cast on you
    -- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
    if state.HasteMode.value == 'Hi' then
        if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
             ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
             ( buffactive.march == 2 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( (buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba'] ) then
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
        elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
                 ( buffactive.march == 1 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif ( buffactive.march == 1 or buffactive[604] ) then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    else
        if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
           ( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
           ( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
           ( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
            add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( (buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or -- MG or haste + samba with 1 march
               ( buffactive.march == 2 and buffactive['haste samba'] ) or
               ( buffactive[580] and buffactive['haste samba'] ) then 
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
        elseif ( buffactive.march == 2 ) or -- two marches from ghorn
               ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
               ( buffactive[580] ) or  -- geo haste
               ( buffactive[33] and buffactive[604] ) then  -- haste with MG
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    end

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    --if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
    --    state.CombatForm:reset()
    --else
    --    state.CombatForm:set('DW')
    --end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 1)
    else
        set_macro_page(1, 1)
    end
end




