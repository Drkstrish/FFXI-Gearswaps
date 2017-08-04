-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[    

Custom Features:

Rune Selector       
Cycle through available runes and trigger with a single macro [Ctl-`]

Charm Mode            
Equips charm prevention gear (WinKey-h)

Knockback Mode        
Equips knockback prevention gear (WinKey-k)

Death Mode            
Equips death prevention gear (WinKey-d)

Auto. Doom            
Automatically equips cursna received gear on doom status

Capacity Pts. Mode    
Capacity Points Mode Toggle [WinKey-C]

Auto. Lockstyle        
Automatically locks specified equipset on file load

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
-- Setup vars that are user-independent.
function job_setup()
  
  -- /BLU Spell Maps
  blue_magic_maps = {}

  blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific','Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
  blue_magic_maps.Cure = S{'Wild Carrot'}
  blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}

  rayke_duration = 47
  gambit_duration = 94

  state.Buff.Battuta = buffactive.Battuta or false
  state.Buff['Aftermath'] = buffactive['Aftermath: Lv.3'] or false

end
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
  
  state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.WeaponskillMode:options('Normal', 'Acc')
  state.HybridMode:options('Normal', 'DT')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'DT')
  state.PhysicalDefenseMode:options('PDT', 'Parry', 'HP')
  state.MagicalDefenseMode:options('MDT', 'Status')
  
  state.WeaponLock = M(false, 'Weapon Lock')    
  state.Greatsword = M{['description']='Current Greatsword', 'Epeolatry', 'Lionheart', "Aettir"}
  state.Charm = M(false, 'Charm Resistance')
  state.Knockback = M(false, 'Knockback')
  state.Death = M(false, "Death Resistance")
  --state.CP = M(false, "Capacity Points Mode")

  gear.CurrentWeapon = state.Greatsword.value

  state.Runes = M{['description']='Runes', "Ignis", "Gelus", "Flabra", "Tellus", "Sulpor", "Unda", "Lux", "Tenebrae"}
  
  send_command('bind ^` input //gs c rune')
  send_command('bind !` input /ja "Vivacious Pulse" <me>')
  send_command('bind ^- gs c cycleback Runes')
  send_command('bind ^= gs c cycle Runes')
  send_command('bind ^f11 gs c cycle MagicalDefenseMode')
  send_command('bind @g gs c cycle Greatsword')
  send_command('bind @c gs c toggle Charm')
  send_command('bind @k gs c toggle Knockback')
  send_command('bind @d gs c toggle Death')
  send_command('bind !q input /ma "Temper" <me>')

  if player.sub_job == 'BLU' then
    send_command('bind !w input /ma "Cocoon" <me>')
  elseif player.sub_job == 'WAR' then
    send_command('bind !w input /ja "Defender" <me>')
  elseif player.sub_job == 'DRK' then
    send_command('bind !w input /ja "Last Resort" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind !w input /ja "Hasso" <me>')
  end

  send_command('bind !o input /ma "Regen IV" <stpc>')
  send_command('bind !p input /ma "Shock Spikes" <me>')
  
  if player.sub_job == 'DNC' then
    send_command('bind ^, input /ja "Spectral Jig" <me>')
    send_command('unbind ^.')
  else
    send_command('bind ^, input /item "Silent Oil" <me>')
    send_command('bind ^. input /item "Prism Powder" <me>')
  end
  
  send_command('bind @w gs c toggle WeaponLock')
  --send_command('bind @c gs c toggle CP')

  if player.sub_job == 'WAR' then
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'DRK' then
    send_command('bind ^numlock input /ja "Last Resort" <me>')
    send_command('bind ^numpad/ input /ja "Souleater" <me>')
    send_command('bind ^numpad* input /ja "Arcane Circle" <me>')
    send_command('bind ^numpad- input /ja "Weapon Bash" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind ^numlock input /ja "Hasso" <me>')
    send_command('bind ^numpad/ input /ja "Meditate" <me>')
    send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
    send_command('bind ^numpad- input /ja "Third Eye" <me>')
  end

  send_command('bind ^numpad7 input /ws "Resolution" <t>')
  send_command('bind !numpad7 input /ws "Savage Blade" <t>')
  send_command('bind ^numpad9 input /ws "Dimidiation" <t>')
  send_command('bind !numpad4 input /ws "Requiescat" <t>')
  send_command('bind ^numpad5 input /ws "Ground Strike" <t>')
  send_command('bind ^numpad1 input /ws "Herculean Slash" <t>')
  
  select_default_macro_book()
  set_lockstyle()
  
end
function user_unload()
  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind ^f11')
  send_command('unbind @g')
  send_command('unbind @c')
  send_command('unbind @k')
  send_command('unbind @d')
  send_command('unbind !q')
  send_command('unbind !w')
  send_command('unbind !o')
  send_command('unbind !p')
  send_command('unbind ^,')
  send_command('unbind @w')
  send_command('unbind ^numlock')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad7')
  send_command('unbind !numpad7')
  send_command('unbind ^numpad9')
  send_command('unbind !numpad4')
  send_command('unbind ^numpad5')
  send_command('unbind ^numpad1')
  send_command('unbind @numpad*')
end
-- Define sets and vars used by this job file.
function init_gear_sets()

  include('augmented-items.lua')

------------------------------------------------------------------------------------------------
---------------------------------------- Precast Sets ------------------------------------------
------------------------------------------------------------------------------------------------

-- Enmity set
  sets.Enmity = -- 57 enmity
  
{
  main="",
  sub="", 
  ammo="",
  head="",
  body="Emet Harness +1", --10
  hands="Kurys Gloves", --9
  legs=gear.RUNEmpy.Legs, --7
  feet=gear.RUNEmpy.Feet, --5 (upgrade to +1)
  neck="Unmoving Collar +1", --10
  ear1="Cryptic Earring", --4
  ear2="Friomisi Earring", --2
  ring1="Petrov Ring", --4
  ring2="",
  back="Reiki Cloak", --6
  waist=""
}

sets.precast.JA['Vallation'] = 
set_combine(sets.Enmity, {body=gear.RUNAF.Body, legs=gear.RUNRel.Legs,back=gear.AmbJSE.RUNTP})

sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']

sets.precast.JA['Pflug'] = 
set_combine(sets.Enmity, {feet=gear.RUNAF.Feet})

sets.precast.JA['Battuta'] = 
set_combine(sets.Enmity, {head=gear.RUNRel.Head})

sets.precast.JA['Liement'] = 
set_combine(sets.Enmity, {body=gear.RUNRel.Body})

  sets.precast.JA['Lunge'] = 
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
  right_ear="Novio Earring",
  left_ring="Vertigo Ring",
  right_ring="Etana Ring",
  back="Argochampsa Mantle"
}

  sets.precast.JA['Swipe'] = 
  sets.precast.JA['Lunge']
  
  sets.precast.JA['Gambit'] = 
  set_combine(sets.enmity, {hands=gear.RUNAF.Hands})
  
  sets.precast.JA['Rayke'] = 
  set_combine(sets.enmity, {feet=gear.RUNRel.Feet})
  
  sets.precast.JA['Elemental Sforzo'] = 
  set_combine(sets.enmity, {body=gear.RUNRel.Body})
  
  sets.precast.JA['Swordplay'] = 
  set_combine(sets.enmity, {hands=gear.RUNRel.Hands})
  
  sets.precast.JA['Embolden'] = {back=gear.ReiveJSE.RUN }
  
  sets.precast.JA['Vivacious Pulse'] = 
{
  head=gear.RUNEmpy.Head,
  legs=gear.RUNAF.Legs
}

  sets.precast.JA['One for All'] = sets.enmity
  
  sets.precast.JA['Provoke'] = sets.enmity

  -- Fast cast sets for spells
  sets.precast.FC =               --49FC2QM
{    
  ammo="Impatiens",               --    2QM
  head=gear.Carmine.head,         --12FC
  body=gear.Samnuhabody.FC,       --3FC
  hands=gear.Leyline.NotCap,      --7FC
  legs=gear.Rawhide.legs,         --5FC
  feet=gear.Carmine.feet,         --8FC
  neck="Orunmila's Torque",       --5FC
  right_ear="Etiolation Earring", --1FC
  left_ear="Loquac. Earring",     --2FC
  left_ring="Rahab Ring",         --2FC
  right_ring="Kishar Ring",       --4FC
  back=gear.AmbJSE.RUNTP          --
}

  sets.precast.FC.HP = {}

   sets.precast.FC['Enhancing Magic'] = 
  set_combine(sets.precast.FC, 
  {waist="Siegel Sash",legs=gear.RUNRel.Legs})

  sets.precast.FC.Cure = set_combine(sets.precast.FC, {ammo="Impatiens", ear2="Mendi. Earring"})

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck='Magoraga beads'})

------------------------------------------------------------------------------------------------
------------------------------------- Weapon Skill Sets ----------------------------------------
------------------------------------------------------------------------------------------------

  sets.precast.WS = 
{
  ammo="Knobkierrie",
  head="Lilitu Headpiece",
  body="Meg. Cuirie +2",
  hands="Meg. Gloves +2",
  legs=gear.Herc_WS_legs,
  feet=gear.Herc_TA_feet,
  neck="Fotia Gorget",
  ear1="Sherida Earring",
  ear2="Moonshade Earring",
  ring1="Ifrit Ring +1",
  ring2="Ilabrat Ring",
  back="Bleating Mantle",
  waist="Fotia Belt",
}

  sets.precast.WS.Acc = 
  set_combine(sets.precast.WS, 
{
  ammo="Seeth. Bomblet +1",
  legs="Meg. Chausses +2",
  ear2="Telos Earring",
  ring1="Ramuh Ring +1",
  ring2="Ramuh Ring +1",
})

  sets.precast.WS['Resolution'] = 
  set_combine(sets.precast.WS, 
{
  head=gear.Adhemar_TP_head,
  body=gear.Herc_TA_body,
  legs="Meg. Chausses +2",
  ring1="Shukuyu Ring",
  ring2="Epona's Ring",
  back=gear.RUN_WS1_Cape,
})

  sets.precast.WS['Resolution'].Acc = 
  set_combine(sets.precast.WS['Resolution'], 
{
  ammo="Seeth. Bomblet +1",
  head="Dampening Tam",
  feet=gear.Herc_Acc_feet,
  ear2="Telos Earring",
  ring1="Rufescent Ring",
})

  sets.precast.WS['Dimidiation'] = 
  set_combine(sets.precast.WS, 
{
  legs="Lustr. Subligar +1",
  feet="Lustra. Leggings +1",
  neck="Caro Necklace",
  ring1="Ramuh Ring +1",
  ring2="Ilabrat Ring",
  back=gear.RUN_WS2_Cape,
  waist="Grunfeld Rope",
})

  sets.precast.WS['Dimidiation'].Acc = 
  set_combine(sets.precast.WS['Dimidiation'], 
{
  ammo="Seeth. Bomblet +1",
  legs="Samnuha Tights",
  feet=gear.Herc_Acc_feet,
  ear2="Telos Earring",
  ring1="Ramuh Ring +1",
})

  sets.precast.WS['Herculean Slash'] = 
  sets.precast.JA['Lunge']

  sets.precast.WS['Savage Blade'] = 
  set_combine(sets.precast.WS, 
{
  legs="Meg. Chausses +2",
  feet=gear.Herc_TA_feet,
  neck="Caro Necklace",
  ring1="Shukuyu Ring",
  ring2="Ifrit Ring +1",
  waist="Prosilio Belt +1",
  back=gear.RUN_WS1_Cape,
})

sets.precast.WS['Sanguine Blade'] = 
{
  ammo="Seeth. Bomblet +1",
  head="Pixie Hairpin +1",
  body="Samnuha Coat",
  hands="Carmine Fin. Ga. +1",
  legs=gear.Herc_MAB_legs,
  feet=gear.Herc_MAB_feet,
  neck="Baetyl Pendant",
  ear1="Moonshade Earring",
  ear2="Friomisi Earring",
  ring1="Archon Ring",
  ring2="Levia. Ring +1",
  back="Argocham. Mantle",
  waist="Eschan Stone",
}

  sets.precast.WS['True Strike']= 
  sets.precast.WS['Resolution']

  sets.precast.WS['True Strike']= 
  sets.precast.WS['Savage Blade']
  
  sets.precast.WS['Judgment'] =
  sets.precast.WS['Savage Blade']
  
  sets.precast.WS['Black Halo'] = 
  sets.precast.WS['Savage Blade']

  sets.precast.WS['Flash Nova'] = 
  set_combine(sets.precast.WS['Sanguine Blade'], 
{
  head=gear.Herc_MAB_head,
  ring1="Shiva Ring +1",
  ring2="Weather. Ring +1",
})


------------------------------------------------------------------------------------------------
---------------------------------------- Midcast Sets ------------------------------------------
------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = 
sets.precast.FC

  sets.midcast.SpellInterrupt = 
{
  ammo="Impatiens", --10
  hands=gear.Rawhide.hands, --15
  legs=gear.Carmine.legs, --20
}

  sets.midcast.Cure = 
  set_combine(sets.precast.FC, sets.interrupt)

  sets.midcast['Enhancing Magic'] = 
{
  head=gear.RUNEmpy.Head,
  hands=gear.RUNAF.Hands,
  back=gear.AmbJSE.RUNTP,
  legs=gear.RUNRel.Legs
}

  sets.midcast.EnhancingDuration = 
{
  head=gear.RUNEmpy.Head,
  legs=gear.RUNRel.Legs,
}

sets.midcast['Phalanx'] = 
set_combine(sets.midcast['Enhancing Magic'], 
{
  head=gear.RUNRel.Head,
})

  sets.midcast['Regen'] = 
  set_combine(sets.midcast.EnhancingDuration, 
{
  head=gear.RUNAF.Head
})

  sets.midcast['Crusade'] = 
set_combine(sets.enmity, sets.interrupt)

  sets.midcast.Refresh = 
  set_combine(sets.midcast.EnhancingDuration, 
{
  waist="Gishdubar Sash"
})

  sets.midcast.Stoneskin = 
  set_combine(sets.midcast['Enhancing Magic'], 
{
  waist="Siegel Sash"
})
  
  sets.midcast.Protect = 
  set_combine(sets.midcast.EnhancingDuration, {})
  
  sets.midcast.Shell = sets.midcast.Protect

  sets.midcast['Divine Magic'] = {}

  sets.midcast.Flash = sets.Enmity
  
  sets.midcast.Foil = sets.Enmity
  
  sets.midcast.Diaga = sets.Enmity
  
  sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
  
  sets.midcast['Blue Magic'] = {}
  
  sets.midcast['Blue Magic'].Enmity = 
  sets.Enmity
  
  sets.midcast['Blue Magic'].Cure = 
  sets.midcast.Cure
  
  sets.midcast['Blue Magic'].Buff = 
  sets.midcast['Enhancing Magic']

------------------------------------------------------------------------------------------------
----------------------------------------- Idle Sets --------------------------------------------
------------------------------------------------------------------------------------------------

  sets.idle = 
{
  ammo="Impatiens",
  head=gear.Rawhide.head,
  body=gear.Meghanada.Body,
  hands=gear.Meghanada.Hands,
  legs=gear.Carmine.legs,
  feet=gear.Meghanada.feet,
  neck="Bathy Choker +1",
  waist="Flume Belt +1",
  ear1="Infused Earring",
  ear2="Etiolation Earring",
  ring1="Paguroidea ring",
  ring2="Meghanada Ring",
  back="Moonbeam Cape"
}

  sets.idle.DT =                --41/38
{
  sub="Refined Grip +1",        --3/3
  --ammo="Staunch Tathlum",     --2/2
  head=gear.Dampening.Cap,      --0/4
  body=gear.Meghanada.Body,     --8/0
  legs=gear.Carmine.legs,       --0/0
  feet=gear.RUNEmpy.Feet,       --5/0
  neck="Loricate Torque +1",    --6/6
  waist="Flume Belt +1",        --4/0
  ear1="Etiolation Earring",    --0/3
  ear2="Odnowa Earring +1",     --0/2
  ring1="Defending Ring",       --10/10
  ring2="Fortified Ring",       --0/5
  back="Moonbeam Cape",         --5/5

}

  sets.idle.Town = 
{
  ammo="Knobkierrie",
  head=gear.Carmine.head.HQ,
  body=gear.RUNRel.Body,
  hands=gear.Carmine.hands,
  legs=gear.Carmine.legs,
  feet=gear.Carmine.feet,
  neck="Loricate Torque +1",
  waist="Ioskeha Belt",
  ear1="Sherida Earring",
  ear2="Cessance Earring",
  ring1="Regal Ring",
  ring2="Niqmaddu Ring",
  back="Moonbeam Cape"
}

  sets.idle.Weak = sets.idle
  
  sets.Kiting = {legs=gear.Carmine.legs}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

  sets.defense.Charm = 
{
  neck="Unmoving Collar +1",
  back="Solemnity Cape",
}

  sets.defense.Battuta = {}
  
  sets.defense.Knockback = {back="Repulse Mantle"}
  
  sets.defense.Death = 
{
  body="Samnuha Coat", ring1="Warden's Ring"
}

  sets.defense.PDT =              --50/33
{
  sub="Refined Grip +1",          --3/3
  --ammo="Staunch Tathlum",       --2/2
  head=gear.Meghanada.Head,       --5/0
  body=gear.RUNRel.Body,          --7/7
  hands=gear.Ayanmo.Hands,        --2/2
  legs=gear.Meghanada.Legs,       --6/0
  feet=gear.Herculeanfeet.Triple, --2/0
  neck="Loricate Torque +1",      --6/6
  waist="Flume Belt +1",          --4/0
  ear1="Sherida Earring",         --0/0
  ear2="Brutal Earring",          --0/0
  ring1="Defending Ring",         --10/10
  ring2="Niqmaddu Ring",          --0/0
  back="Moonbeam Cape",           --5/5
}

sets.defense.MDT =                --34/50
{
  sub="Refined Grip +1",          --3/3
  --ammo="Staunch Tathlum",       --2/2
  head=gear.Dampening.Cap,        --0/4
  body=gear.RUNRel.Body,          --7/7
  hands=gear.Ayanmo.Hands,        --2/2
  legs=gear.Ayanmo.Legs,          --4/4
  feet=gear.Ayanmo.Feet,          --2/2
  neck="Warder's Charm +1",
  waist="Flume Belt +1",          --4/0
  ear1="Etiolation Earring",      --0/3
  ear2="Odnowa Earring +1",       --0/2
  ring1="Defending Ring",         --10/10
  ring2="Fortified Ring",         --0/5
  back="Reiki Cloak",             --0/8
}

  sets.defense.Status = 
{
  sub="Refined Grip +1",          --3/3
  --ammo="Staunch Tathlum",       --2/2
  head=gear.Meghanada.Head,       --5/0
  body=gear.RUNRel.Body,          --7/7
  hands=gear.RUNEmpy.Hands ,      --0/0
  legs=gear.Ayanmo.Legs,          --4/4
  feet=gear.Ayanmo.Feet,          --4/4
  neck="Loricate Torque +1",      --6/6
  waist="Flume Belt +1",          --4/0    
  ear1="Etiolation Earring",      --0/3
  ear2="Odnowa Earring +1",       --0/2
  ring1="Defending Ring",         --10/10
  ring2="Fortified Ring",         --0/5
  back="Moonbeam Cape",           --5/5
}

 --[[ sets.defense.HP = 
{
  sub="Refined Grip +1", --3/3
  --ammo="Staunch Tathlum", --2/2
  head=, 
  body=,
  hands=,
  legs=,
  feet=,
  neck="Loricate Torque +1", --6/6
  waist="Flume Belt +1", --4/0
  ear1=,
  ear2="Odnowa Earring +1", --0/2
  ring1=,
  ring2="Defending Ring", --10/10
  back="Moonbeam Cape", --5/5
}


sets.defense.Parry = 
{
  main="Epeolatry", --(25)/0
  sub="Refined Grip +1", --3/3
  ammo="Staunch Tathlum", --2/2
  head=gear.Herc_DT_head, --3/3
  body="Meg. Cuirie +2", --8/0
  hands="Turms Mittens",
  legs="Eri. Leg Guards +1", --7/0
  feet="Turms Leggings",
  neck="Loricate Torque +1", --6/6
  ear1="Odnowa Earring", --0/1
  ear2="Odnowa Earring +1", --0/2
  ring1="Gelatinous Ring +1", --7/(-1)
  ring2="Defending Ring", --10/10
  back=gear.RUN_HP_Cape,
  waist="Flume Belt +1", --4/0
}
--]]
------------------------------------------------------------------------------------------------
---------------------------------------- Engaged Sets ------------------------------------------
------------------------------------------------------------------------------------------------
-- UPDATE ALL 

sets.engaged = 
{
  sub="Utu Grip",
  ammo="Ginsen",
  head="Dampening Tam",
  body=gear.Herc_TA_body,
  hands=gear.Adhemar_TP_hands,
  legs="Samnuha Tights",
  feet=gear.Herc_TA_feet,
  neck="Asperity Necklace",
  ear1="Sherida Earring",
  ear2="Brutal Earring",
  ring1="Petrov Ring",
  ring2="Epona's Ring",
  back=gear.RUN_TP_Cape,
  waist="Ioskeha Belt",
}

  sets.engaged.LowAcc = 
  set_combine(sets.engaged, 
{
  neck="Combatant's Torque",
})

  sets.engaged.MidAcc = 
  set_combine(sets.engaged.LowAcc, 
{
  sub="Bloodrain Strap",
  ammo="Falcon Eye",
  ear2="Telos Earring",
  ring2="Ilabrat Ring",
})

  sets.engaged.HighAcc = 
  set_combine(sets.engaged.MidAcc, 
{
  head="Carmine Mask +1",
  legs="Carmine Cuisses +1",
  feet=gear.Herc_Acc_feet,
  ring1="Ramuh Ring +1",
  ring2="Ramuh Ring +1",
  ear1="Cessance Earring",
  waist="Kentarch Belt +1",
})

  sets.engaged.STP = 
  set_combine(sets.engaged, 
{
  feet="Carmine Greaves +1",
  neck="Anu Torque",
  ear2="Telos Earring",
  waist="Kentarch Belt +1",
})

  sets.engaged.Aftermath = 
{
  head="Aya. Zucchetto +1",
  body="Turms Harness",
  neck="Anu Torque",
  ear2="Telos Earring",
  ring2="Ilabrat Ring",
  waist="Kentarch Belt +1",
}


------------------------------------------------------------------------------------------------
---------------------------------------- Hybrid Sets -------------------------------------------
------------------------------------------------------------------------------------------------

  sets.engaged.DT = 
{
  --sub="Mensch Strap +1", --5/0
  ammo="Staunch Tathlum", --2/2
  head="Dampening Tam",
  --head=gear.Adhemar_DT_head, --3/0
  body="Ayanmo Corazza +1", --5/5
  --hands=gear.Herc_DT_hands, --6/4
  hands=gear.Adhemar_TP_hands,
  legs="Meg. Chausses +2", --6/0
  feet=gear.Herc_TA_feet,
  neck="Loricate Torque +1", --6/6
  ear1="Sherida Earring",
  ear2="Brutal Earring",
  ring1="Moonbeam Ring",  --4/4
  ring2="Defending Ring", --10/10
  back=gear.RUN_TP_Cape,
  waist="Ioskeha Belt",
}

  sets.engaged.LowAcc.DT = 
  set_combine(sets.engaged.DT, 
{
  ear2="Telos Earring",
})

  sets.engaged.MidAcc.DT =
  set_combine(sets.engaged.LowAcc.DT,
{
  head="Meghanada Visor +2", --5/0
  hands="Meg. Gloves +2", --4/0
})

  sets.engaged.HighAcc.DT = 
  set_combine(sets.engaged.MidAcc.DT, 
{
  feet=gear.Herc_Acc_feet,
  ear1="Cessance Earring",
})

    sets.engaged.STP.DT = set_combine(sets.engaged.DT, {
        ear1="Sherida Earring",
        ear2="Telos Earring",
        })

    sets.engaged.Aftermath.DT = {
        head="Aya. Zucchetto +1",
        body="Turms Harness",
		legs="Samnuha Tights",
		feet="Carmine Greaves +1",
        neck="Loricate Torque +1",
        ear2="Telos Earring",
        waist="Flume Belt +1",
        }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {ring1="Saida Ring", ring2="Saida Ring", waist="Gishdubar Sash"}

    sets.Embolden = set_combine(sets.midcast.EnhancingDuration, {back="Evasionist's Cape"})
    sets.CP = {back="Mecisto. Mantle"}
    sets.Reive = {neck="Ygnas's Resolve +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.PhysicalDefenseMode.value == 'HP' then
        eventArgs.handled = true
        equip(sets.precast.FC.HP)
    end
    if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
--            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
        end
    end
    if spell.english == 'Valiance' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Vallation" <me>')
            eventArgs.cancel = true
            return
        elseif spell.english == 'Valiance' and buffactive['vallation'] then
            cast_delay(0.2)
            send_command('cancel Vallation') -- command requires 'cancel' add-on to work
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        local obi = get_obi(get_rune_obi_element())
        if obi then
            equip({waist=obi})
        end
    end
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    --if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
    --    handle_equipping_gear(player.status)
    --    eventArgs.handled = true
    --end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.name == 'Rayke' and not spell.interrupted then
        send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png')
        send_command('wait '..rayke_duration..';input /p Rayke: OFF <call21>;')
    elseif spell.name == 'Gambit' and not spell.interrupted then
        send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png')
        send_command('wait '..gambit_duration..';input /p Gambit: OFF <call21>;')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.Charm.current)
    classes.CustomDefenseGroups:append(state.Knockback.current)
    classes.CustomDefenseGroups:append(state.Death.current)

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.Charm.current)
    classes.CustomMeleeGroups:append(state.Knockback.current)
    classes.CustomMeleeGroups:append(state.Death.current)
end

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
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

    if buff == 'Embolden' then
        if gain then 
            equip(sets.Embolden)
            disable('head','legs','back')            
        else
            enable('head','legs','back')            
            status_change(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end

    if buff == 'Battuta' and not gain then
        status_change(player.status)
    end

end
    
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Greatsword.current == 'Epeolatry' then
        equip({main="Epeolatry"})
    elseif state.Greatsword.current == 'Lionheart' then
        equip({main="Lionheart"})
    elseif state.Greatsword.current == 'Aettir' then
        equip({main="Aettir"})
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Charm.value == true then
        idleSet = set_combine(idleSet, sets.defense.Charm)
    end    
    if state.Knockback.value == true then
        idleSet = set_combine(idleSet, sets.defense.Knockback)
    end
    if state.Death.value == true then
        idleSet = set_combine(idleSet, sets.defense.Death)
    end
    if state.Buff.Battuta then
        idleSet = set_combine(idleSet, sets.defense.Battuta)
    end
    --if state.CP.current == 'on' then
    --    equip(sets.CP)
    --    disable('back')
    --else
    --    enable('back')
    --end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Charm.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Charm)
    end
    if state.Knockback.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Knockback)
    end
    if state.Death.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Death)
    end
    if state.Buff.Aftermath and state.Greatsword.value == "Epeolatry" then
        if state.HybridMode.value == "DT" then
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath.DT)
        else
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
        end
    end
    if state.Buff.Battuta then
        meleeSet = set_combine(meleeSet, sets.defense.Battuta)
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.Charm.value == true then
        defenseSet = set_combine(defenseSet, sets.defense.Charm)
    end
    if state.Knockback.value == true then
        defenseSet = set_combine(defenseSet, sets.defense.Knockback)
    end
    if state.Death.value == true then
        defenseSet = set_combine(defenseSet, sets.defense.Death)
    end
    if state.Buff.Battuta then
        defenseSet = set_combine(defenseSet, sets.defense.Battuta)
    end

    return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = '[ Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value 
    end
    msg = msg .. ' ][ WS: ' .. state.WeaponskillMode.value .. ' ]'
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
    end
    
    if state.Charm.value == true then
        msg = msg .. '[ Charm ]'
    end

    if state.Knockback.value == true then
        msg = msg .. '[ Knockback ]'
    end
    
    if state.Death.value == true then
        msg = msg .. '[ Death ]'
    end

    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode ]'
    end
    
    msg = msg .. '[ *' .. state.Runes.current .. '* ]'
    
    add_to_chat(060, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function get_rune_obi_element()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    local found_rune_element
    
    if weather_rune and day_rune then
        if weather_rune > day_rune then
            found_rune_element = world.weather_element
        else
            found_rune_element = world.day_element
        end
    elseif weather_rune then
        found_rune_element = world.weather_element
    elseif day_rune then
        found_rune_element = world.day_element
    end
    
    return found_rune_element
end

function get_obi(element)
    if element and elements.obi_of[element] then
        return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book: (set, book)
    if player.sub_job == 'BLU' then
        set_macro_page(2, 12)
    elseif player.sub_job == 'DRK' then
        set_macro_page(3, 12)
    elseif player.sub_job == 'WHM' then
        set_macro_page(4, 12)
    else
        set_macro_page(1, 12)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 6')
end