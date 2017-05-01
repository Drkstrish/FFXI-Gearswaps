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
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'War')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()
    
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end


 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Augmented Gear
    --------------------------------------
	
	ValorFeet = {}
	
	ValorFeet.Idle = { name="Valorous Greaves", augments={'Phys. dmg. taken -4%','"Dbl.Atk."+1','"Refresh"+1',}}
	
	ValorFeet.TP = { name="Valorous Greaves", augments={'Attack+12','"Store TP"+7',}}
	

    --------------------------------------
    -- Start defining the sets
    --------------------------------------
     
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Angon = {ammo="Angon",hands="Pteroslaver Finger Gauntlets",ear1="Dragoon's Earring"}
    sets.precast.JA.Jump = {ammo="Ginsen",
        head="Flamma Zucchetto +1",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
        body="Peltast's Plackart +1",hands="Emicho Gauntlets",ring1="Hetairoi Ring",ring2="Petrov Ring",
        back="Brigantia's Mantle",waist="Windbuffet Belt +1",legs="Sulevia's Cuisses +1",feet="Flamma Gambieras +1"}
    sets.precast.JA['Ancient Circle'] = {legs="Vishap Brais"}
    sets.precast.JA['High Jump'] = {ammo="Ginsen",
        head="Flamma Zucchetto +1",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
        body="Peltast's Plackart +1",hands="Emicho Gauntlets",ring1="Hetairoi Ring",ring2="Petrov Ring",
        back="Brigantia's Mantle",waist="Windbuffet Belt +1",legs="Sulevia's Cuisses +1",feet="Flamma Gambieras +1"}
    sets.precast.JA['Soul Jump'] = {ammo="Ginsen",
        head="Sulevia's Mask +2",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
        body="Peltast's Plackart +1",hands="Valorous Mitts",ring1="Hetairoi Ring",ring2="Petrov Ring",
        back="Brigantia's Mantle",waist="Windbuffet Belt +1",legs="Sulevia's Cuisses +1",feet=ValorFeet.TP}
    sets.precast.JA['Spirit Jump'] = {ammo="Ginsen",
        head="Sulevia's Mask +2",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
        body="Peltast's Plackart +1",hands="Valorous Mitts",ring1="Hetairoi Ring",ring2="Petrov Ring",
        back="Brigantia's Mantle",waist="Windbuffet Belt +1",legs="Sulevia's Cuisses +1",feet=ValorFeet.TP}
    sets.precast.JA['Super Jump'] = {ammo="Ginsen",
        head="Flamma Zucchetto +1",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
        body="Peltast's Plackart +1",hands="Emicho Gauntlets",ring1="Hetairoi Ring",ring2="Petrov Ring",
        back="Brigantia's Mantle",waist="Windbuffet Belt +1",legs="Sulevia's Cuisses +1",feet="Flamma Gambieras +1"}
    sets.precast.JA['Spirit Link'] = {hands="Lnc. Vmbrc. +2"}
    sets.precast.JA['Call Wyvern'] = {body="Wyrm Mail +2"}
    sets.precast.JA['Deep Breathing'] = {hands="Pteroslaver Finger Gauntlets"}
    sets.precast.JA['Spirit Surge'] = {body="Wyrm Mail +2"}
 
     
    -- Healing Breath sets
    sets.precast.JA['Restoring Breath'] = {
		head="Wyrm Armet +2",neck="Lancer's Torque",ear1="Dragoon's Earring",
		hands="Crusher's Gauntlets",back="Updraft Mantle",waist="Glassblower's Belt"}
	
	sets.precast.JA['Smiting Breath'] = {
		head="Wyrm Armet +2",neck="Lancer's Torque",ear1="Dragoon's Earring",
		hands="Crusher's Gauntlets",back="Brigantia's Mantle",waist="Glassblower's Belt"}
		
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
         
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
     
    -- Fast cast sets for spells
     
    sets.precast.FC = {sub="Sapience Orb",
		head="Carmine Mask",ear1="Etiolation Earring",ear2="Loquacious Earring",body="Emet Harness +1",
		hands="Leyline Gloves",back="Grounded Mantle +1",legs="Founder's Hose"}
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {neck="Diemer Gorget",body="Jumalik Mail",
		ear1="Mendicant's Earring"})

     
    -- Midcast Sets
    sets.midcast.FastRecast = {sub="Sapience Orb",
		head="Carmine Mask",ear1="Etiolation Earring",ear2="Loquacious Earring",body="Emet Harness +1",
		hands="Leyline Gloves",back="Grounded Mantle +1",legs="Founder's Hose"}
		
	sets.midcast.Cure = {sub="Sapience Orb",
		neck="Phalaina Locket",ear1="Mendicant's Earring",ear2="Loquacious Earring",body="Jumalik Mail",
		ring1="Ephedra Ring",ring2="Globidonta Ring",back="Solemnity Cape",waist="Gishdubar Sash"}
	
	sets.midcast.Refresh = {waist="Gishdubar Sash"}
         
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
 
    sets.precast.WS = {ammo="Knobkierrie",
        head="Sulevia's Mask +2",neck="Caro Necklace",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Valorous Mail",hands="Valorous Mitts",ring1="Shukuyu Ring",ring2="Niqmaddu Ring",
        back="Brigantia's Mantle",waist="Fotia Belt",legs="Sulevia's Cuisses +1",feet="Sulevia's Leggings +1"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
     
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {ammo="Knobkierrie",
        head="Sulevia's Mask +2",neck="Soil Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Valorous Mail",hands="Sulevia's Gauntlets +1",ring1="Shukuyu Ring",ring2="Niqmaddu Ring",
        back="Brigantia's Mantle",waist="Fotia Belt",legs="Sulevia's Cuisses +1",feet="Sulevia's Leggings +1"})
    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {ammo="Knobkierrie",
        head="Sulevia's Mask +2",neck="Soil Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Valorous Mail",hands="Sulevia's Gauntlets +1",ring1="Shukuyu Ring",ring2="Niqmaddu Ring",
        back="Brigantia's Mantle",waist="Fotia Belt",legs="Sulevia's Cuisses +1",feet="Sulevia's Leggings +1"})
 
    sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {ammo="Knobkierrie",
        head="Sulevia's Mask +2",neck="Caro Necklace",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Valorous Mail",hands="Valorous Mitts",ring1="Shukuyu Ring",ring2="Niqmaddu Ring",
        back="Brigantia's Mantle",waist="Fotia Belt",legs="Sulevia's Cuisses +1",feet="Thereoid Greaves"})
    sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS.Acc, {ammo="Knobkierrie",
        head="Sulevia's Mask +2",neck="Caro Necklace",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Valorous Mail",hands="Valorous Mitts",ring1="Shukuyu Ring",ring2="Niqmaddu Ring",
        back="Brigantia's Mantle",waist="Fotia Belt",legs="Sulevia's Cuisses +1",feet="Thereoid Greaves"})
	
	sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS, {ammo="Knobkierrie",
        head="Sulevia's Mask +2",neck="Caro Necklace",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Valorous Mail",hands="Valorous Mitts",ring1="Shukuyu Ring",ring2="Niqmaddu Ring",
        back="Brigantia's Mantle",waist="Fotia Belt",legs="Lustratio Subligar",feet="Lustratio Leggings"})
    sets.precast.WS['Sonic Thrust'].Acc = set_combine(sets.precast.WS.Acc, {ammo="Knobkierrie",
        head="Sulevia's Mask +2",neck="Caro Necklace",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Valorous Mail",hands="Valorous Mitts",ring1="Shukuyu Ring",ring2="Niqmaddu Ring",
        back="Brigantia's Mantle",waist="Fotia Belt",legs="Lustratio Subligar",feet="Flamma Gambieras +1"})
 
 
     
    -- Sets to return to when not performing an action.
     
    -- Resting sets
    sets.resting = {main="Ryunohige",sub="Utu Grip",ammo="Brigantia Pebble",
        head="Valorous Mask",neck="Bathy Choker +1",ear1="Enmerkar Earring",ear2="Infused Earring",
        body="Sulevia's Platemail +1",hands="Sulevia's Gauntlets +1",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Mecistopins Mantle",waist="Nierenschutz",legs="Carmine Cuisses +1",feet=ValorFeet.Idle}

    -- Idle sets
    sets.idle = {main="Ryunohige",sub="Utu Grip",ammo="Brigantia Pebble",
        head="Valorous Mask",neck="Bathy Choker +1",ear1="Enmerkar Earring",ear2="Infused Earring",
        body="Sulevia's Platemail +1",hands="Sulevia's Gauntlets +1",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Mecistopins Mantle",waist="Nierenschutz",legs="Carmine Cuisses +1",feet=ValorFeet.Idle}
 
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {main="Ryunohige",sub="Utu Grip",ammo="Brigantia Pebble",
        head="Valorous Mask",neck="Bathy Choker +1",ear1="Enmerkar Earring",ear2="Infused Earring",
        body="Sulevia's Platemail +1",hands="Sulevia's Gauntlets +1",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Mecistopins Mantle",waist="Nierenschutz",legs="Carmine Cuisses +1",feet=ValorFeet.Idle}
     
    -- Defense sets
    sets.defense.PDT = {ammo="Brigantia Pebble",
        head="Sulevia's Mask +2",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Enmerkar Earring",
        body="Sulevia's Platemail +1",hands="Sulevia's Gauntlets +1",ring1="Vocane Ring",ring2="Defending Ring",
        back="Solemnity Cape",waist="Sailfi Belt +1",legs="Sulevia's Cuisses +1",feet="Amm Greaves"}
 
    sets.defense.Reraise = {ammo="Brigantia Pebble",
        head="Sulevia's Mask +2",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Enmerkar Earring",
        body="Sulevia's Platemail +1",hands="Sulevia's Gauntlets +1",ring1="Vocane Ring",ring2="Defending Ring",
        back="Solemnity Cape",waist="Sailfi Belt +1",legs="Sulevia's Cuisses +1",feet="Amm Greaves"}
 
    sets.defense.MDT = {ammo="Brigantia Pebble",
        head="Sulevia's Mask +2",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Enmerkar Earring",
        body="Sulevia's Platemail +1",hands="Sulevia's Gauntlets +1",ring1="Vocane Ring",ring2="Defending Ring",
        back="Solemnity Cape",waist="Sailfi Belt +1",legs="Sulevia's Cuisses +1",feet="Amm Greaves"}
 
    sets.Kiting = {legs="Blood Cuisses"}
 
    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
     
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
        head="Sulevia's Mask +2",neck="Lissome Necklace",ear1="Telos Earring",ear2="Sherida Earring",
        body="Peltast's Plackart +1",hands="Emicho Gauntlets",ring1="Niqmaddu Ring",ring2="Petrov Ring",
        back="Brigantia's Mantle",waist="Goading Belt",legs="Valorous Hose",feet=ValorFeet.TP}
    sets.engaged.Acc = {ammo="Ginsen",
        head="Sulevia's Mask +2",neck="Lissome Necklace",ear1="Telos Earring",ear2="Sherida Earring",
        body="Peltast's Plackart +1",hands="Emicho Gauntlets",ring1="Niqmaddu Ring",ring2="Petrov Ring",
        back="Brigantia's Mantle",waist="Goading Belt",legs="Sulevia's Cuisses +1",feet=ValorFeet.TP}
   
    -- Melee sets for non SAM sub 84 STP
    sets.engaged.War = {ammo="Ginsen",
        head="Sulevia's Mask +2",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
        body="Peltast's Plackart +1",hands="Emicho Gauntlets",ring1="Niqmaddu Ring",ring2="Petrov Ring",
        back="Brigantia's Mantle",waist="Goading Belt",legs="Acro Breeches",feet=ValorFeet.TP}
		
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

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
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
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
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

function select_default_macro_book()
	set_macro_page(1, 12)
end
