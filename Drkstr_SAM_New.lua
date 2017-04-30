-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff.Hasso = buffactive.Hasso or false
	state.Buff.Seigan = buffactive.Seigan or false
	state.Buff.Sekkanoki = buffactive.Sekkanoki or false
	state.Buff.Sengikori = buffactive.Sengikori or false
	state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
	state.mainweapon = M{['description'] = 'Main Weapon'}
	state.mainweapon:options('Kogarasumaru','Masamune','Amanomurakumo','Dojikiri Yasutsuna', 'Tachi')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
	sate.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HiAcc')
	state.HybridMode:options('Normal','PDT', 'Reraise')
	state.WeaponskillMode:options('Normal', 'Acc', 'HiAcc')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.IdleMode:options('Normal', 'PDT')
	
	Aeol_weapons = S{'Dojikiri Yasutsuna'}
	Koga_weapons = S{'Kogarasumaru'}
	Empy_weapons = S{'Masamune'}
	Proc_weapons = S{'Tachi'}
-- Additional local binds
	send_command('bind ^q input /ja "Hasso" <me>')
	send_command('bind !q input /ja "Seigan" <me>')
	snd_command('bind !a input /ja "Third Eye" <me>')
	send_command('bind ^z gs c mainweapon')

	update_combat_form()
	select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^q')
	send_command('unbind !q')
	send_command('unbind !a')
	send_command('unbind ^z')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    sets.mainweapon = {}
	sets.mainweapon.Kogarasumaru = {main="Kogarasumaru",sub="Utu Grip"}
	sets.mainweapon.Masamune = {main="Masamune",sub="Utu Grip"}
	sets.mainweapon.Amanomurakumo = {main="Amanomurakumo",	sub="Utu Grip"	}
	sets.mainweapon['Dojikiri Yasutsuna'] = {
		main="Dojikiri Yasutsuna",
		sub="Utu Grip"
	}
	sets.mainweapon['Tachi'] = {
		main="Tachi",
		sub="Utu Grip"
	}
	
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +2",hands="Sakonji Kote +1",back="Smertrios's Mantle"}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +2"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +1"}
	sets.precast.JA['Sengikori'] = {feet="Kasuga Sune-ate +1"}
	sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Yaoyotl Helm",
        body="Otronif Harness +1",hands="Buremte Gloves",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Karieyh Brayettes +1",feet="Otronif Boots +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Knobkierrie",
    head="Flam. Zucchetto +1",
    body={ name="Valorous Mail", augments={'Accuracy+28','Weapon skill damage +5%',}},
    hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','AGI+8','Accuracy+9','Attack+12',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','Weapon skill damage +5%','STR+8','Accuracy+2','Attack+6',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Telos Earring",
    left_ring="Regal Ring",
    right_ring="Karieyh Ring +1",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {back="Letalis Mantle"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] ={ ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Accuracy+25','Weapon skill damage +5%','DEX+6',}},
    body={ name="Valorous Mail", augments={'Accuracy+28','Weapon skill damage +5%',}},
    hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','AGI+8','Accuracy+9','Attack+12',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','Weapon skill damage +5%','STR+8','Accuracy+2','Attack+6',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Telos Earring",
    left_ring="Regal Ring",
    right_ring="Karieyh Ring +1",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS['Tachi: Fudo'], {ring2="Rufescent Ring",waist="Prosilio Belt +1",legs="Hizamaru Hizayoroi +1"})
    sets.precast.WS['Tachi: Fudo'].Mod = set_combine(sets.precast.WS['Tachi: Fudo'], {waist="Snow Belt"})

    sets.precast.WS['Tachi: Shoha'] = {
        head={ name="Valorous Mask", augments={'Accuracy+25','Weapon skill damage +5%','DEX+6',}},neck="Fotia Gorget",ear1="Cessance Earring",ear2="Brutal Earring",
        body={ name="Valorous Mail", augments={'Accuracy+28','Weapon skill damage +5%',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','AGI+8','Accuracy+9','Attack+12',}},
		ring1="Regal Ring",ring2="Karieyh Ring +1",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		waist="Windbuffet Belt +1",legs={ name="Valor. Hose", augments={'Accuracy+28','Weapon skill damage +5%','STR+10','Attack+5',}},
		feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','Weapon skill damage +5%','STR+8','Accuracy+2','Attack+6',}}}
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {neck="Thunder Gorget"})
    sets.precast.WS['Tachi: Shoha'].Mod = set_combine(sets.precast.WS['Tachi: Shoha'], {waist="Thunder Belt"})

    sets.precast.WS['Tachi: Rana'] = {
        head={ name="Valorous Mask", augments={'Accuracy+25','Weapon skill damage +5%','DEX+6',}},neck="Fotia Gorget",ear1="Cessance Earring",ear2="Telos Earring",
        body={ name="Valorous Mail", augments={'Accuracy+28','Weapon skill damage +5%',}},hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','AGI+8','Accuracy+9','Attack+12',}},ring1="Niqmaddu Ring",ring2="Regal Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},waist="Fotia Belt",legs={ name="Valor. Hose", augments={'Accuracy+28','Weapon skill damage +5%','STR+10','Attack+5',}},feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','Weapon skill damage +5%','STR+8','Accuracy+2','Attack+6',}}}
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {neck="Snow Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",})
    sets.precast.WS['Tachi: Rana'].Mod = set_combine(sets.precast.WS['Tachi: Rana'], {waist="Snow Belt"})

    sets.precast.WS['Tachi: Kasha'] = {ammo="Knobkierrie",
    head="Flam. Zucchetto +1",
    body={ name="Valorous Mail", augments={'Accuracy+28','Weapon skill damage +5%',}},
    hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','AGI+8','Accuracy+9','Attack+12',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','Weapon skill damage +5%','STR+8','Accuracy+2','Attack+6',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Telos Earring",
    left_ring="Regal Ring",
    right_ring="Karieyh Ring +1",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}

    sets.precast.WS['Tachi: Gekko'] = {ammo="Knobkierrie",
    head="Flam. Zucchetto +1",
    body={ name="Valorous Mail", augments={'Accuracy+28','Weapon skill damage +5%',}},
    hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','AGI+8','Accuracy+9','Attack+12',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','Weapon skill damage +5%','STR+8','Accuracy+2','Attack+6',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Telos Earring",
    left_ring="Regal Ring",
    right_ring="Karieyh Ring +1",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
        }

    sets.precast.WS['Tachi: Yukikaze'] = {ammo="Knobkierrie",
    head="Flam. Zucchetto +1",
    body={ name="Valorous Mail", augments={'Accuracy+28','Weapon skill damage +5%',}},
    hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','AGI+8','Accuracy+9','Attack+12',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','Weapon skill damage +5%','STR+8','Accuracy+2','Attack+6',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Telos Earring",
    left_ring="Regal Ring",
    right_ring="Karieyh Ring +1",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}

    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS)

    sets.precast.WS['Tachi: Jinpu'] = {ammo="Knobkierrie",
    head="Flam. Zucchetto +1",
    body={ name="Valorous Mail", augments={'Accuracy+28','Weapon skill damage +5%',}},
    hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','AGI+8','Accuracy+9','Attack+12',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','Weapon skill damage +5%','STR+8','Accuracy+2','Attack+6',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Telos Earring",
    left_ring="Regal Ring",
    right_ring="Karieyh Ring +1",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}


    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Yaoyotl Helm",
        body="Otronif Harness +1",hands="Otronif Gloves",
        legs="Phorcys Dirs",feet="Otronif Boots +1"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
        head="Wakido Kabuto +2",neck="Bathy Choker +1",ammo="Staunch Tathlum",ear1="Dawn Earring",ear2="Infused Earring",
        body="Hizamaru Haramaki +1",hands="Rao Kote +1",ring1="Chirich Ring +1",ring2="Karieyh Ring +1",
        back="Mollusca Mantle",waist="Flume Belt +1",legs="Rao Haidate +1",feet="Rao Sune-ate +1"}
		
	sets.idle.Regen = {
        head="Rao Kabuto +1",neck="Bathy Choker +1",ear1="Dawn Earring",ear2="Infused Earring",
        body="Hizamaru Haramaki +1",hands="Rao Kote +1",ring1="Chirich Ring +1",ring2="Paguroidea Ring",
        back="Mollusca Mantle",waist="Flume Belt +1",legs="Rao Haidate +1",feet="Rao Sune-ate +1"}
		
	sets.idle.PDT = {
        head="Loess Barbuta +1",
    body="Chozor. Coselete",
    hands={ name="Ryuo Tekko +1", augments={'DEX+12','Accuracy+25','"Dbl.Atk."+4',}},
    legs="Hiza. Hizayoroi +1",
    feet={ name="Amm Greaves", augments={'HP+50','VIT+10','Accuracy+15','Damage taken-2%',}},
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Dawn Earring",
    right_ear="Infused Earring",
    left_ring="Defending Ring",
    right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -5%','Magic dmg. taken -5%',}},
    back="Mollusca Mantle"
	}

    sets.idle.Weak = {
        head="Rao Kabuto +1",neck="Bathy Choker +1",ammo="Staunch Tathlum",ear1="Dawn Earring",ear2="Infused Earring",
        body="Hizamaru Haramaki +1",hands="Rao Kote +1",ring1="Chirich Ring +1",ring2="Paguroidea Ring",
        back="Mollusca Mantle",waist="Flume Belt +1",legs="Rao Haidate +1",feet="Rao Sune-ate +1"}
    
    -- Defense sets
    sets.defense.PDT = {ammo="Iron Gobbet",
        head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Karieyh Brayettes +1",feet="Otronif Boots +1"}

    sets.defense.Reraise = {
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Buremte Gloves",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Karieyh Brayettes +1",feet="Otronif Boots +1"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Karieyh Brayettes +1",feet="Otronif Boots +1"}

    sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged.Dojikiri = {
        head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+17','Accuracy+17','Haste+3',}},neck="Ganesha's Mala",
		ear1="Telos Earring",ear2="Brutal Earring",
        body="Kasuga Domaru +1",
		hands={ name="Valorous Mitts", augments={'Accuracy+22 Attack+22','Weapon Skill Acc.+5','DEX+10','Accuracy+11','Attack+15',}},
		ring1="Hetairoi Ring",ring2="Petrov Ring",
        back={ name="Takaha Mantle", augments={'STR+4','"Zanshin"+5','"Store TP"+3',}},waist="Windbuffet Belt +1",
		legs="Kasuga Haidate +1",feet="Ryuo Sune-Ate +1"}
    sets.engaged.Dojikiri.LowAcc = {
        ammo="Ginsen",
    head="Flam. Zucchetto +1",
    body="Kasuga Domaru +1",
    hands="Wakido Kote +3",
    legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
    feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','"Store TP"+7','DEX+4','Accuracy+12',}},
    neck="Lissome Necklace",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Hetairoi Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	}
	sets.engaged.Dojikiri.MidAcc = {
        head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+17','Accuracy+17','Haste+3',}},neck="Combatant's Torque",ear1="Telos Earring",ear2="Brutal Earring",
        body="Rao Togi +1",hands="Ryuo Tekko +1",ring1="Chirich Ring +1",ring2="Ramuh Ring +1",
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},waist="Kentarch Belt +1",legs="Kasuga Haidate +1",feet="Rao Sune-ate +1"}
	sets.engaged.Dojikiri.HiAcc = {
        head="Ryuo Somen +1",neck="Combatant's Torque",ear1="Telos Earring",ear2="Mache Earring +1",
        body="Ryuo Domaru +1",hands="Ryuo Tekko +1",ring1="Ramuh Ring +1",ring2="Chirich Ring +1",
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},waist="Olseni Belt",legs="Hizamaru Hizayoroi +1",feet="Rao Sune-ate +1"}
	sets.engaged.Kogarasumaru = {
        head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+17','Accuracy+17','Haste+3',}},neck="Ganesha's Mala",ear1="Telos Earring",ear2="Dedition Earring",
        body="Kasuga Domaru +1",hands={ name="Valorous Mitts", augments={'Accuracy+24 Attack+24','"Store TP"+4','DEX+1','Accuracy+7',}},ring1="Hetairoi Ring",ring2="Petrov Ring",
        back={ name="Takaha Mantle", augments={'STR+4','"Zanshin"+5','"Store TP"+3',}},waist="Windbuffet Belt +1",legs="Kasuga Haidate +1",feet="Ryuo Sune-Ate +1"}
	sets.engaged.Kogarasumaru.LowAcc = {
        head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+17','Accuracy+17','Haste+3',}},neck="Combatant's Torque",ear1="Telos Earring",ear2="Tripudio Earring",
        body="Kasuga Domaru +1",hands="Ryuo Tekko +1",ring1="Hetairoi Ring",ring2="Petrov Ring",
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},waist="Windbuffet Belt +1",legs="Kasuga Haidate +1",feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','"Store TP"+7','DEX+4','Accuracy+12',}}}
	sets.engaged.Kogarasumaru.MidAcc = {
        head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+17','Accuracy+17','Haste+3',}},neck="Combatant's Torque",ear1="Telos Earring",ear2="Cessance Earring",
        body="Ryuo Domaru +1",hands="Ryuo Tekko +1",ring1="Hetairoi Ring",ring2="Ramuh Ring +1",
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},waist="Kentarch Belt +1",legs="Kasuga Haidate +1",feet="Rao Sune-ate +1"}
	sets.engaged.KogarasumaruHiAcc = {
        head="Ryuo Somen +1",neck="Combatant's Torque",ear1="Telos Earring",ear2="Mache Earring +1",
        body="Ryuo Domaru +1",hands="Ryuo Tekko +1",ring1="Ramuh Ring +1",ring2="Chirich Ring +1",
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},waist="Olseni Belt",legs="Hizamaru Hizayoroi +1",feet="Rao Sune-ate +1"}
	sets.engaged.Masamune = {
    ammo="Paeapua",
    head="Flam. Zucchetto +1",
    body="Kasuga Domaru +1",
    hands="Wakido Kote +3",
    legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
    feet={ name="Valorous Greaves", augments={'Accuracy+24 Attack+24','"Dbl.Atk."+4','Accuracy+3','Attack+7',}},
    neck="Ganesha's Mala",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Hetairoi Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
	sets.engaged.Masamune.LowAcc = {ammo="Paeapua",
    head="Flam. Zucchetto +1",
    body="Kasuga Domaru +1",
    hands="Wakido Kote +3",
    legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
    feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','"Store TP"+7','DEX+4','Accuracy+12',}},
    neck="Lissome Necklace",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Hetairoi Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}}
	sets.engaged.Masamune.HighAcc	= {ammo="Ginsen",
    head={ name="Ryuo Somen +1", augments={'STR+12','DEX+12','Accuracy+20',}},
    body="Kasuga Domaru +1",
    hands="Wakido Kote +3",
    legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
    feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','"Store TP"+7','DEX+4','Accuracy+12',}},
    neck="Lissome Necklace",
    waist="Ioskeha Belt +1",
    left_ear="Mache Earring +1",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
	sets.engaged.Masamune.HiAcc = { ammo="Ginsen",
        head="Ryuo Somen +1",neck="Combatant's Torque",ear1="Telos Earring",ear2="Mache Earring +1",
        body="Ryuo Domaru +1",hands="Ryuo Tekko +1",ring1="Chirich Ring +1",ring2="Ramuh Ring +1",
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
		waist="Olseni Belt",
		legs="Flamma Dirs +1",feet="Rao Sune-ate +1"}
		
	sets.engaged.Masamune.PDT = set_combine(sets.engaged.Masamune, {ammo="Staunch Tathlum",
    head="Loess Barbuta +1",
    body="Chozor. Coselete",
    hands={ name="Sakonji Kote +1", augments={'Enhances "Blade Bash" effect',}},
    legs="Arjuna Breeches",
    feet={ name="Amm Greaves", augments={'HP+50','VIT+10','Accuracy+15','Damage taken-2%',}},
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ring="Chirich Ring +1",
    right_ring="Defending Ring"})
	sets.engaged.Tachi = {
        ammo="Ginsen",
    head="Flam. Zucchetto +1",
    body="Kasuga Domaru +1",
    hands="Wakido Kote +3",
    legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
    feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','"Store TP"+7','DEX+4','Accuracy+12',}},
    neck="Moonbeam Nodowa",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Hetairoi Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	}
	sets.engaged.Archery = {sub="Bloodrain Strap",
        head={ name="Valorous Mask", augments={'Accuracy+30','"Store TP"+6','DEX+5','Attack+12',}},neck="Ganesha's Mala",ear1="Telos Earring",ear2="Brutal Earring",
        body="Kasuga Domaru +1",hands={ name="Valorous Mitts", augments={'Accuracy+22 Attack+22','Weapon Skill Acc.+5','DEX+10','Accuracy+11','Attack+15',}},ring1="Hetairoi Ring",ring2="Petrov Ring",
        back={ name="Takaha Mantle", augments={'STR+4','"Zanshin"+5','"Store TP"+3',}},waist="Ioskeha Belt +1",legs="Kasuga Haidate +1",feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','"Store TP"+7','DEX+4','Accuracy+12',}}}
    sets.engaged.PDT = {ammo="Thew Bomblet",
        head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="K'ayres Ring",
        back="Iximulew Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
    sets.engaged.Adoulin = {range="Cibitshavore",
        head="Acro Helm",neck="Ganesha's Mala",ear1="Brutal Earring",ear2="Telos Earring",
        body="Kasuga Domaru +1",hands={ name="Valorous Mitts", augments={'Accuracy+22 Attack+22','Weapon Skill Acc.+5','DEX+10','Accuracy+11','Attack+15',}},ring1="Hetairoi Ring",ring2="Petrov Ring",
        back={ name="Takaha Mantle", augments={'STR+4','"Zanshin"+5','"Store TP"+3',}},waist="Windbuffet Belt +1",legs="Kasuga Haidate +1",feet={ name="Valorous Greaves", augments={'Accuracy+5 Attack+5','"Dbl.Atk."+2','DEX+14','Accuracy+15','Attack+12',}}}
    sets.engaged.Adoulin.Acc = {ammo="Thew Bomblet",
        head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Unkai Domaru +2",hands="Otronif Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
    sets.engaged.Adoulin.PDT = {ammo="Thew Bomblet",
        head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="K'ayres Ring",
        back="Iximulew Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
    sets.engaged.Adoulin.Acc.PDT = {ammo="Honed Tathlum",
        head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="K'ayres Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
    sets.engaged.Adoulin.Reraise = {ammo="Thew Bomblet",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="K'ayres Ring",
        back="Ik Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
    sets.engaged.Adoulin.Acc.Reraise = {ammo="Thew Bomblet",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="K'ayres Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}


    sets.buff.Sekkanoki = {hands="Kasuga Kote +1"}
    sets.buff.Sengikori = {feet="Kasuga Sune-ate +1"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function update_combat_form()
    -- Check Weapontype
	if  Aeol_weapons:contains(player.equipment.main) then
		state.CombatForm:set('Dojikiri')
	elseif
		Koga_weapons:contains(player.equipment.main) then
		state.CombatForm:set('Kogarasumaru')
	elseif
		Empy_weapons:contains(player.equipment.main) then
		state.CombatForm:set('Masamune')
	elseif
		Proc_weapons:contains(player.equipment.main) then
		state.CombatForm:set('Tachi')
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

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
        if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
            if spell.english:startswith("Tachi:") then
                send_command('@input /ws "Penta Thrust" '..spell.target.raw)
                eventArgs.cancel = true
            end
        end
    end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
moonshade_WS = S{"Tachi: Fudo", "Tachi: Kasha", "Tachi: Shoha", "Tachi: Rana", "Tachi: Gekko"}
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end
		if moonshade_WS:contains(spell.english) and player.tp<2950 then	
			equip({ear2="Moonshade Earring"})	
		end
	end
end



-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
local msg = 'Melee'
	if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
	end
end

-- Modify the default idle set
function customize_idle_set(idleSet)
	if mainswap then
		mainswap=0
		enable('main','sub')
		equip(sets.mainweapon[state.mainweapon.value])
		disable('main','sub')
	end
		return idleSet
end
	--add_to_chat(122,'Idle Set ')
	
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
	

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(8, 1)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 11)
    elseif player.sub_job == 'THF' then
        set_macro_page(8, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 11)
    else
        set_macro_page(8, 1)
    end
end
