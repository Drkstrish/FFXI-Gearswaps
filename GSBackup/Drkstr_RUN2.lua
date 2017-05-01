-- NOTE: I do not play run, so this will not be maintained for 'active' use. 
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'DT')
    state.MagicalDefenseMode:options('MDT', 'Cursna', 'MEva')
    state.IdleMode:options('Regen', 'Refresh')

    -- Keybind Ctrl+F11 to cycle Magical Defense Modes
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')

    --send_command('@wait 5;input /lockstyleset 20')
end


function init_gear_sets()
  
    include('augmented-items.lua')
  
	--------------------------------------
	-- Augmented Gear
	--------------------------------------
  sets.enmity = {}

  sets.interrupt = {}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
  sets.precast.JA['Vallation'] = 
  set_combine(sets.enmity, {body="Runeist Coat +1",back="Ogma's Cape",legs="Futhark Trousers +1"})

  sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']

  sets.precast.JA['Pflug'] = 
  set_combine(sets.enmity, {feet="Runeist Bottes +1"})

  sets.precast.JA['Battuta'] = 
  set_combine(sets.enmity, {head="Futhark Bandeau +1"})

  sets.precast.JA['Liement'] = 
  set_combine(sets.enmity, {body="Futhark Coat +1"})

  sets.precast.JA['Lunge'] = 
{    
  ammo="Pemphredo Tathlum",
  head=gear.Herculeanhead.Magic,
  body=gear.Herculeanbody.Magic,
  hands=gear.Carmine.hands,
  legs=gear.Herculeanlegs.Magic,
  feet=gear.Herculeanfeet.Magic,
  neck="Sanctity Necklace",
  waist="Luminary Sash",
  left_ear="Friomisi Earring",
  right_ear="Hermetic Earring",
  left_ring="Vertigo Ring",
  right_ring="Etana Ring",
  back=gear.ReiveJSE.RUN
}

  sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

  sets.precast.JA['Gambit'] = 
  set_combine(sets.enmity, {hands="Runeist Mitons +1"})

  sets.precast.JA['Rayke'] = 
  set_combine(sets.enmity, {feet="Futhark Boots +1"})

  sets.precast.JA['Elemental Sforzo'] = 
  set_combine(sets.enmity, {body="Futhark Coat +1"})

  sets.precast.JA['Swordplay'] = 
  set_combine(sets.enmity, {hands="Futhark Mitons +1"})

  sets.precast.JA['Embolden'] = 
  {back="Evasionist's Cape"}

  sets.precast.JA['Vivacious Pulse'] = 
  {head="Erilaz Galea +1",neck="Incanter's Torque",ear1="Beatific Earring",legs="Runeist Trousers +1"}

  sets.precast.JA['One for All'] = sets.enmity

  sets.precast.JA['Provoke'] = sets.enmity

	-- Fast cast sets for spells
  sets.precast.FC =
{    
  ammo="Impatiens",
  head=gear.Carmine.head,
  body=gear.Samnuhabody.FC,
  hands=gear.Leyline.NotCap,
  legs=gear.Rawhide.legs,
  feet=gear.Carmine.feet,
  neck="Orunmila's Torque",
  waist="Windbuffet Belt +1",
  left_ear="Cessance Earring",
  right_ear="Loquac. Earring",
  left_ring="Rahab Ring",
  right_ring="Kishar Ring",
  back=gear.AmbJSE.RUNTP
}

  sets.precast.FC['Enhancing Magic'] = 
  set_combine(sets.precast.FC, {waist="Siegel Sash",legs="Futhark Trousers +1"})
  
  sets.precast.FC['Utsusemi: Ichi'] = 
  set_combine(sets.precast.FC, {neck='Magoraga beads',body="Passion Jacket"})
  
  sets.precast.FC['Utsusemi: Ni'] = 
  set_combine(sets.precast.FC['Utsusemi: Ichi'], {})

	-- Weaponskill sets
  sets.precast.WS['Resolution'] = 
{
  ammo="Seething Bomblet +1",
  head="Skormoth Mask",
  neck="Fotia Gorget",
  ear1="Sherida Earring",
  ear2="Moonshade Earring",
  body="Rawhide Vest",
  hands="Herculean Gloves",
  ring1="Epona's Ring",
  ring2="Shukuyu Ring",
  back=Ogma_DA,
  waist="Fotia Belt",
  legs="Meghanada Chausses +1",
  feet="Erilaz Greaves +1"
}
  
  sets.precast.WS['Resolution'].Acc = 
  set_combine(sets.precast.WS['Resolution'], 
{
  ammo="Falcon Eye",
  hands="Umuthi Gloves",
  back="Evasionist's Cape"
})

  sets.precast.WS['Dimidiation'] = 
{
  ammo="Cheruski Needle",
  head="Lilitu Headpiece",neck="Fotia Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
  body="Rawhide Vest",hands="Erilaz Gauntlets +1",ring1="Epona's Ring",ring2="Shukuyu Ring",
  back=Ogma_DA,waist="Windbuffet Belt +1",legs=STR_legs,feet="Erilaz Greaves +1"
  }
  
  sets.precast.WS['Dimidiation'].Acc = 
  set_combine(sets.precast.WS['Dimidiation'], 
{
  ammo="Falcon Eye",head="Whirlpool Mask",hands="Buremte Gloves", back="Evasionist's Cape", waist="Fotia Belt"
})

  sets.precast.WS['Herculean Slash'] = 
  set_combine(sets.precast['Lunge'], {hands="Umuthi Gloves"})
  
  sets.precast.WS['Herculean Slash'].Acc = 
  set_combine(sets.precast.WS['Herculean Slash'], {})

  sets.precast.WS['Freezebite'] = sets.precast.JA['Lunge']

  sets.precast.WS['Sanguine Blade'] = sets.precast.JA['Lunge']

	--------------------------------------
	-- Midcast sets
	--------------------------------------

  sets.midcast.FastRecast = 
  set_combine(sets.interrupt, {ear2="Enchanter Earring +1",back=Ogma_FastCast,ring2="Rahab Ring"})

  --sets.midcast['Enhancing Magic'] = {head="Erilaz Galea +1",
  --    hands="Runeist Mitons +1",
  --    back=Ogma_FastCast,legs="Futhark Trousers +1"}
  sets.midcast['Phalanx'] = 
  set_combine(sets.midcast['Enhancing Magic'], sets.interrupt, {head="Futhark Bandeau +1"})

  sets.midcast['Regen'] = 
  set_combine(sets.precast.FC, sets.interrupt)

  sets.midcast['Refresh'] = 
  set_combine(sets.precast.FC, sets.interrupt)

  sets.midcast['Flash'] = sets.enmity

  sets.midcast['Foil'] = sets.enmity

  sets.midcast['Crusade'] = 
  set_combine(sets.enmity, sets.interrupt)

  sets.midcast['Stoneskin'] = 
  set_combine(sets.interrupt, {back=Ogma_FastCast})

  sets.midcast.Cure = 
  set_combine(sets.precast.FC, sets.interrupt)

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

  sets.idle = 
{
  ammo="Homiliary",
  head="Rawhide Mask",
  neck="Bathy Choker +1",
  ear1="Infused Earring",
  ear2="Dawn Earring",
  body="Futhark Coat +1",
  hands="Garden Bangles",
  ring1="Paguroidea ring",
  ring2="Sheltered Ring",
  back="Evasionist's Cape",
  waist="Flume Belt +1",
  legs="Rawhide Trousers",
  feet="Skadi's Jambeaux +1"
}

  sets.idle.Refresh = 
  set_combine(sets.idle, 
{
  body="Runeist Coat +1",waist="Fucho-no-obi",legs="Rawhide Trousers"
})

	sets.defense.PDT = 
{
  main="Epeolatry",sub="Refined Grip +1",ammo="Staunch Tathlum",
  head="Futhark Bandeau +1",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Genmei Earring",
  body="Erilaz Surcoat +1",hands="Kurys Gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
  back=Ogma_Enmity,waist="Flume Belt +1",legs="Erilaz Leg Guards +1",feet="Erilaz Greaves +1"
}

	sets.defense.DT = 
{
  main="Epeolatry",sub="Refined Grip +1",ammo="Staunch Tathlum",
  head="Ayanmo Zucchetto +1",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Genmei Earring",
  body="Futhark Coat +1",hands="Kurys Gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
  back="Evasionist's Cape",waist="Lieutenant's Sash",legs="Ayanmo Cosciales +1",feet="Ayanmo Gambieras +1"
}

  sets.defense.ResistCharm = 
  set_combine(sets.defense.PDT, 
{
  neck="Unmoving Collar +1",ear1="Hearty Earring",ear2="Genmei Earring",
  hands="Erilaz Gauntlets +1",ring1="Dusksoul Ring",
  back="Solemnity Cape",waist="Engraved Belt",legs="Runeist Trousers +1"
})

  sets.defense.ResistDeath = 
  set_combine(sets.defense.PDT, 
{
  body="Samnuha Coat",ring1="Warden's Ring",ring2="Eihwaz Ring"
})

  sets.defense.ResistStun = 
{
  ammo="Vanir Battery",
  head="Flawless Ribbon",neck="Loricate Torque +1",ear1="Arete Del Luna",ear2="Arete Del Luna +1",
  body="Onca Suit",hands=empty,ring1="Icecrack Ring",ring2="Terrasoul Ring",
  back="Tantalic Cape",waist="Flume Belt +1",legs=empty,feet=empty
}

	sets.defense.MDT = 
{
  ammo="Vanir Battery",
  head="Erilaz Galea +1",neck="Inquisitor Bead Necklace",ear1="Sanare Earring",ear2="Etiolation Earring",
  body="Erilaz Surcoat +1",hands="Erilaz Gauntlets +1",ring1="Shadow Ring",ring2="Defending Ring",
  back="Engulfer Cape +1",waist="Engraved Belt",legs="Erilaz Leg Guards +1",feet="Erilaz Greaves +1"
}

  sets.defense.Cursna = 
  set_combine(sets.defense.MDT, 
{
  ring1="Eshmun's Ring",ring2="Purity Ring",waist="Gishdubar Sash"
})

  sets.defense.MEva = 
  set_combine(sets.defense.MDT, 
{
  ammo="Staunch Tathlum",
  head="Erilaz Galea +1",neck="Warder's Charm +1",ear1="Hearty Earring",ear2="Eabani Earring",
  body="Erilaz Surcoat +1",hands="Erilaz Gauntlets +1",ring1="Vengeful Ring",ring2="Purity Ring",
  back=Ogma_Enmity,waist="Engraved Belt",legs="Runeist Trousers +1",feet="Erilaz Greaves +1"
})

	sets.Kiting = {feet="Skadi's Jambeaux +1"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {ammo="Ginsen",
        head="Dampening Tam", neck="Clotharius Torque", ear1="Sherida Earring", ear2="Dedition Earring",
        body="Thaumas Coat", hands="Herculean Gloves", ring1="Epona's Ring", ring2="Niqmaddu Ring",
        back=Ogma_DA, waist="Windbuffet Belt +1",legs="Samnuha Tights", feet="Futhark Boots +1"}
      
    sets.engaged.Acc = set_combine(sets.engaged, {ammo="Falcon Eye",
        head="Dampening Tam",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Zennaroi Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Grounded Mantle +1",waist="Eschan Stone",legs="Samnuha Tights", feet="Erilaz Greaves +1"})
    
    sets.engaged.repulse = {back="Repulse Mantle"}
end
------------------------------------------------------------------
-- Action events
------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_precast(spell, action, spellMap, eventArgs)

end
function job_aftercast(spell)

end
