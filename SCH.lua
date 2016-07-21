function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
    state.CastingMode:options('Normal', 'MACC', 'MATT', 'MagicBurst','StoreTP')
    state.IdleMode:options('Normal','PDT','OncaSuit')
	state.TPMode = M{['description']='TP Mode', 'Normal', 'WeaponLock'}
	send_command('alias tp gs c cycle tpmode')
    send_command('bind f10 gs c cycle idlemode')
	send_command('bind f12 gs c update caster')
	select_default_macro_book()
	send_command('@wait 1;input /lockstyleset 5')
	
	-- Set Common Aliases --
	send_command("alias idle gs equip sets.Idle.Current")
	send_command("alias fc gs equip sets.precast.FastCast")
	send_command("alias enh gs equip sets.midcast['Enhancing Magic']")
	send_command("alias ele gs equip sets.midcast['Elemental Magic']")
	send_command("alias macc gs equip sets.midcast['Elemental Magic'].MACC")
	send_command("alias matt gs equip sets.midcast['Elemental Magic'].MATT")
	send_command("alias storetp gs equip sets.midcast['Elemental Magic'].StoreTP")
	send_command("alias magicburst gs equip sets.midcast['Elemental Magic'].MagicBurst")
	send_command("alias enf gs equip sets.midcast['Enfeebling Magic']")
	send_command("alias dark gs equip sets.midcast['Dark Magic']")
	send_command("alias regen gs equip sets.midcast.Regen")
	send_command("alias cureset gs equip sets.midcast.Cure")
	send_command("alias impactset gs equip sets.midcast.Impact")
	send_command("alias stunset gs equip sets.midcast.Stun")
	send_command("alias myrkrset gs equip sets.precast.WS['Myrkr']")	
end

	
function init_gear_sets()
    -- Setting up Gear As Variables --
	
	-- Weapon Locks used for TP Mode.  When WeaponLock is set - it locks in the following Main and SUB. 
	-- weaponlock_main="Akademos"
	weaponlock_main="Khatvanga"
	weaponlock_sub="Niobid Strap"
	
	-- Enhances JA 
	sublimation_head="Acad. Mortar. +1"
	sublimation_body="Pedagogy Gown +1"
    enlightenment_body="Pedagogy gown +1"	
	sublimation_ear2="Savant's Earring"
	
	-- Idle Sets
	idle_main="Akademos"
	idle_sub="Niobid Strap"
	idle_ranged=""
	idle_ammo="Homiliary"
	idle_head="Befouled Crown"
	idle_neck="Loricate Torque +1"
	idle_ear1="Genmei Earring"
	idle_ear2="Handler's Earring +1"
	idle_body="Gende. Bilaut +1"
	idle_hands="Gende. Gages +1"
	idle_ring1="Dark Ring"
	idle_ring2="Defending Ring"
	idle_back="Solemnity Cape"
	idle_waist="Fucho-no-obi"
	idle_legs="Assiduity Pants +1"
	idle_feet="Herald's Gaiters"
	
	idle_pdt_main="Earth Staff"  -- 20 pdt -- 
	idle_pdt_sub="Alber Strap" -- 2 pdt --
	idle_pdt_ranged=""
	idle_pdt_ammo="Homiliary"
	idle_pdt_head={ name="Merlinic Hood", augments={'Attack+1','Magic dmg. taken -4%','Mag. Acc.+9',}}   -- 4 mdt --
	idle_pdt_neck="Loricate Torque +1" -- 6dt --
	idle_pdt_ear1="Genmei Earring"
	idle_pdt_ear2="Handler's Earring +1"
	idle_pdt_body={ name="Gende. Bilaut +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -4%','"Cure" potency +4%',}} -- 4pdt, 4mdt-- 
	idle_pdt_hands={ name="Merlinic Dastanas", augments={'Magic dmg. taken -4%','INT+3','"Mag.Atk.Bns."+7',}}  --4mdt --
	idle_pdt_ring1="Dark Ring" -- 6pdt, 3mdt -- 
	idle_pdt_ring2="Defending Ring" -- 10dt --
	idle_pdt_back="Solemnity Cape" -- 4dt --
	idle_pdt_waist="Slipor Sash" -- 3mdt --
	idle_pdt_legs={ name="Hagondes Pants +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -3%','"Avatar perpetuation cost" -5',}} -- 3pdt, 3mdt --
	idle_pdt_feet="Herald's Gaiters"
	-- total: 20 DT, 35 pdt, 21mdt
	
	-- Precast Section
	FC_main={ name="Grioavolr", augments={'Magic burst mdg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}}
	FC_sub="Niobid Strap"
	FC_ranged=""
	FC_ammo="Incantor Stone"
	FC_head="Vanya Hood"
	FC_neck="Voltsurge Torque"
	FC_ear1="Loquacious earring"
	FC_ear2="Enchntr. Earring +1"
	FC_body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+16','"Fast Cast"+6','INT+4',}}
	FC_hands="Gende. Gages +1"
	FC_ring1="Prolix Ring"
	FC_ring2="Weather. Ring"
	FC_back="Perimede Cape"
	FC_waist="Witful Belt"
	FC_legs="Psycloth Lappas"
	FC_feet="Regal Pumps +1"
	
	FC_enh_waist="Siegel Sash"
	FC_stoneskin_legs="Doyen Pants"
	FC_stoneskin_head="Umuthi Hat"
	
	FC_cure_legs=FC_stoneskin_legs
	FC_cure_feet="Vanya Clogs"
	FC_Cure_back="Pahtli Cape"
	
	FC_weather_feet="Pedagogy Loafers"
    
	
	-- Midcast Section
	-- enh_main="Gada"
	-- enh_sub="Chanter's Shield"
	enh_main={ name="Grioavolr", augments={'Enh. Mag. eff. dur. +9','MP+74',}}
	enh_sub="Niobid Strap"
	enh_ranged=""
	enh_ammo="Savant's Treatise"
	enh_head="Befouled Crown"
	enh_neck="Incanter's Torque"
	enh_ear1=FC_ear1
	enh_ear2=FC_ear2
	enh_body="Telchine Chasuble"
	enh_hands="Chironic Gloves"
	enh_ring1="Prolix Ring"
	enh_ring2="Weather. Ring"
	enh_back="Lugh's Cape"
	enh_waist="Witful Belt"
	enh_legs="Psycloth Lappas"
	enh_feet="Telchine Pigaches"
	
	enh_stoneskin_waist="Siegel Sash"
	enh_stoneskin_neck="Nodens Gorget"
	enh_regen_main="Bolelabunga"
	enh_regen_head="Arbatel Bonnet +1"
	enh_regen_feet="Telchine Pigaches"
	
	cure_main="Akademos"
	cure_sub="Niobid Strap"
	cure_ranged=""
	cure_ammo="Incantor Stone"
	cure_head="Vanya Hood"
	cure_neck="Loricate Torque +1"
	cure_ear1=FC_ear1
	cure_ear2=FC_ear2
	cure_body="Chironic Doublet"
	cure_hands="Telchine Gloves"
	cure_ring1="Dark Ring"
	cure_ring2="Defending Ring"
	cure_back="Bookworm's Cape"
	cure_waist="Witful Belt"
	cure_legs="Gyve Trousers"
	cure_feet="Vanya Clogs"

	curepotrec_waist="Gishdubar Sash"
	
	refreshpotrec_waist="Gishdubar Sash"	
	refreshpotrec_back="Grapevine Cape"	
	refreshpotrec_feet="Inspirited Boots"

	
	
	ele_main={ name="Grioavolr", augments={'Magic burst mdg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}}
	ele_sub="Zuuxowu Grip"
	ele_ranged=""
	ele_ammo="Pemphredo Tathlum"
	ele_head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','Mag. Acc.+11','"Mag.Atk.Bns."+14',}}
	ele_neck="Sanctity Necklace"
	ele_ear1="Crematio Earring"
	ele_ear2="Barkarole Earring"
	ele_body={ name="Merlinic Jubbah", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Drain" and "Aspir" potency +3','MND+5','Mag. Acc.+10','"Mag.Atk.Bns."+13',}}
	ele_hands="Chironic Gloves"
	ele_ring1="Resonance Ring"
	ele_ring2="Weather. Ring"
	ele_back="Lugh's Cape"
	ele_waist="Refoccilation Stone"
	ele_legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Haste+1','INT+4','Mag. Acc.+14','"Mag.Atk.Bns."+15',}}
	ele_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}}
		
	ele_macc_main="Coeus" -- int+12, mnd+12, macc skill +228, macc +50, mab +34
	ele_macc_sub="Niobid Strap"
	ele_macc_ear1="Hermetic Earring"
	ele_macc_neck="Incanter's Torque"
	ele_macc_hands={ name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+13','Mag. Acc.+10','"Mag.Atk.Bns."+4',}}
	ele_macc_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}}
	
	ele_storetp_legs="Perdition Slops"
	ele_storetp_waist="Oneiros Rope"
	ele_storetp_hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Occult Acumen"+8','INT+11','Mag. Acc.+9','"Mag.Atk.Bns."+6',}}
	ele_storetp_head="Helios Band"
	ele_storetp_ammo="Seraphic Ampulla"
	ele_storetp_feet="Helios Boots"
	
    ele_burst_main="Akademos"  -- 10 --
	ele_burst_hands="Amalric Gages" -- 5 -- (over cap)
	ele_burst_neck="Mizu. Kubikazari" -- 10 -- 
	ele_burst_ring1="Locus Ring" -- 5 -- (over cap)
	ele_burst_ring2="Mujin Band" -- 5 -- 
	ele_burst_ear1="Barkarole Earring"
	ele_burst_ear2="Static Earring" -- 5 -- 
	ele_burst_body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+28','Magic burst mdg.+11%','VIT+8','Mag. Acc.+14',}} -- 11 -- 
	ele_burst_legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+15',}}
	ele_burst_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}}
	-- 51 Magic Burst DMG 
	-- When using Khatvanga; - we lose 10 from the Akademos,  Below we check for that in mid-cast and equip legs (+7)  
	
	dark_main="Rubicundity"
	dark_sub="Culminus"
	dark_body="Shango Robe"
	dark_ring1="Evanescence Ring"
	dark_ring2="Archon Ring"
	dark_waist="Fucho-no-obi"
	dark_feet={ name="Chironic Slippers", augments={'Mag. Acc.+29','"Drain" and "Aspir" potency +10','"Mag.Atk.Bns."+10',}}
	
	stun_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}}
	stun_sub="Chanter's Shield"
	stun_ear1="Digni. Earring"
	stun_waist="Luminary Sash"
    
	
	enf_main="Gada"
	enf_sub="Chanter's Shield"
	enf_ranged=""
	enf_ammo="Savant's Treatise"
	enf_head="Befouled Crown"
	enf_neck="Incanter's Torque"
	enf_ear1="Digni. Earring"
	enf_ear2="Barkarole Earring"
	enf_body="Shango Robe"
	enf_hands="Lurid Mitts"
	enf_ring1="Globidonta Ring"
	enf_ring2="Weather. Ring"
	enf_back="Lugh's Cape"
	enf_waist="Rumination Sash"
	enf_legs="Chironic Hose"
	enf_feet="Skaoi Boots"
	
	-- array for specific elemental magic - Ex: as sets.ele.Wind = {back="Back Armor with +wind"}
	sets.ele = {}

	
    
    -- Various pieces that enhance specific spells/etc **** Mainly for Midcast.
    sets.enh = {}
    sets.enh.Rapture = {head="Arbatel Bonnet +1"}
    sets.enh.Ebullience = {head="Arbatel Bonnet +1"}
    sets.enh.Perpetuance = {hands="Arbatel Bracers +1"}

--    sets.enh.Storm = {feet="Pedagogy Loafers"}

	myrkr_ammo="Incantor Stone"
	myrkr_head="Vanya Hood"
	myrkr_neck="Voltsurge Torque"
	myrkr_ear1="Loquac. Earring"
	myrkr_ear2="Moonshade Earring"
	myrkr_body="Amalric Doublet"
	myrkr_hands="Telchine Gloves"
	myrkr_ring1="Mephitas's Ring +1"
	myrkr_ring2="Etana Ring"
	myrkr_back="Pahtli Cape"
	myrkr_waist="Luminary Sash"
	myrkr_legs="Perdition Slops"
	myrkr_feet="Telchine Pigaches"
	
	
	
    ---  PRECAST SETS  ---
    sets.precast = {}
    sets.precast.JA = {}
    sets.precast.JA.Enlightenment = {body=enlightenment_body}
    sets.precast.JA['Tabula Rasa'] = {head="Pedagogy Pants"}
	 -- sets.precast.JA['Modus Veritas'] = sets.midcast['Elemental Magic'].MACC
	 sets.precast.JA.Sublimation = {head=sublimation_head,body=sublimation_body,ear2=sublimation_ear2}
	
    sets.precast.FastCast = {main=FC_Main,sub=FC_sub,ammo=FC_ammo,head=FC_head,neck=FC_neck,ear1=FC_ear1,ear2=FC_ear2,body=FC_body,hands=FC_hands,ring1=FC_ring1,ring2=FC_ring2,back=FC_back,waist=FC_waist,legs=FC_legs,feet=FC_feet}
    sets.precast.EnhancingMagic = set_combine(sets.precast.FastCast,{waist=FC_enh_waist})
    sets.precast.Stoneskin = set_combine(sets.precast.EnhancingMagic,{head=FC_stoneskin_head,legs=FC_stoneskin_legs})
	sets.precast.Cure = set_combine(sets.precast.FastCast,{back=FC_cure_back,legs=FC_cure_legs,feet=FC_cure_feet})
	sets.precast.FC_Weather = {feet=FC_weather_feet}

	-- WS Sets
	sets.precast.WS = {
	ammo="Homiliary",
    head="Alhazen Hat +1",
    body="Onca Suit",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Cessance Earring",
    right_ear="Digni. Earring",
    left_ring="Etana Ring",
    right_ring="Rajas Ring",
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	}
	-- Max MP set
    sets.precast.WS['Myrkr'] = {main=myrkr_main,sub=myrkr_sub,ammo=myrkr_ammo,head=myrkr_head,neck=myrkr_neck,ear1=myrkr_ear1,ear2=myrkr_ear2,body=myrkr_body,hands=myrkr_hands,ring1=myrkr_ring1,ring2=myrkr_ring2,back=myrkr_back,waist=myrkr_waist,legs=myrkr_legs,feet=myrkr_feet} 
	
    ---  MIDCAST SETS  ---
    sets.midcast = {}
	sets.midcast['Elemental Magic'] = {main=ele_main,sub=ele_sub,ammo=ele_ammo,head=ele_head,neck=ele_neck,ear1=ele_ear1,ear2=ele_ear2,body=ele_body,hands=ele_hands,ring1=ele_ring1,ring2=ele_ring2,back=ele_back,waist=ele_waist,legs=ele_legs,feet=ele_feet}
	sets.midcast['Elemental Magic'].MACC = set_combine(sets.midcast['Elemental Magic'], {main=ele_macc_main,sub=ele_macc_sub,ear1=ele_macc_ear1,neck=ele_macc_neck,hands=ele_macc_hands,feet=ele_macc_feet})
	sets.midcast['Elemental Magic'].MATT = sets.midcast['Elemental Magic']
	sets.midcast['Elemental Magic'].StoreTP = set_combine(sets.midcast['Elemental Magic'], {legs=ele_storetp_legs,waist=ele_storetp_waist,hands=ele_storetp_hands,head=ele_storetp_head,ammo=ele_storetp_ammo,feet=ele_storetp_feet})
	sets.midcast['Elemental Magic'].MagicBurst = set_combine(sets.midcast['Elemental Magic'].MATT, {main=ele_burst_main,hands=ele_burst_hands,neck=ele_burst_neck,ring1=ele_burst_ring1,ring2=ele_burst_ring2,body=ele_burst_body,ear2=ele_burst_ear2,legs=ele_burst_legs,feet=ele_burst_feet})
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'].StoreTP, {head=empty,body="Twilight Cloak",ring1="K'ayres Ring",ring2="Rajas Ring",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Enervating Earring"})
	
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.MACC = sets.midcast['Elemental Magic'].MACC
    sets.midcast.Helix.MATT = sets.midcast.Helix
	sets.midcast.Helix.StoreTP = sets.midcast['Elemental Magic'].StoreTP
	sets.midcast.Helix.MagicBurst = sets.midcast['Elemental Magic'].MagicBurst
    sets.midcast['Dark Magic'] = set_combine(sets.midcast['Elemental Magic'], {main=dark_main,sub=dark_sub,ring1=dark_ring1,ring2=dark_ring2,body=dark_body,waist=dark_waist,feet=dark_feet})
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {feet=stun_feet,sub=stun_sub,ear1=stun_ear1,waist=stun_waist})    
    sets.midcast['Enfeebling Magic'] = {main=enf_main,sub=enf_sub,ammo=enf_ammo,head=enf_head,neck=enf_neck,ear1=enf_ear1,ear2=enf_ear2,body=enf_body,hands=enf_hands,ring1=enf_ring1,ring2=enf_ring2,back=enf_back,waist=enf_waist,legs=enf_legs,feet=enf_feet}
	sets.midcast['Enfeebling Magic'].MACC = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast['Healing Magic'] = {main=cure_main,sub=cure_sub,ammo=cure_ammo,head=cure_head,neck=cure_neck,ear1=cure_ear1,ear2=cure_ear2,body=cure_body,hands=cure_hands,ring1=cure_ring1,ring2=cure_ring2,back=cure_back,waist=cure_waist,legs=cure_legs,feet=cure_feet}
    sets.midcast['Enhancing Magic'] = {main=enh_main,sub=enh_sub,ammo=enh_ammo,head=enh_head,neck=enh_neck,ear1=enh_ear1,ear2=enh_ear2,body=enh_body,hands=enh_hands,ring1=enh_ring1,ring2=enh_ring2,back=enh_back,waist=enh_waist,legs=enh_legs,feet=enh_feet}
    sets.midcast.Embrava = sets.midcast['Enhancing Magic']
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main=enh_regen_main,head=enh_regen_head,feet=enh_regen_feet})
	sets.midcast.Cure = {main=cure_main,sub=cure_sub,ammo=cure_ammo,head=cure_head,neck=cure_neck,ear1=cure_ear1,ear2=cure_ear2,body=cure_body,hands=cure_hands,ring1=cure_ring1,ring2=cure_ring2,back=cure_back,waist=cure_waist,legs=cure_legs,feet=cure_feet}
	sets.midcast.CurePotencyRecieved = set_combine(sets.midcast.Cure, {waist=curepotrec_waist})
	sets.midcast.RefreshRecieved = set_combine(sets.midcast['Enhancing Magic'], {back=refreshpotrec_back,waist=refreshpotrec_waist,feet=refreshpotrec_feet})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist=enh_stoneskin_waist,neck=enh_stoneskin_neck})
    
    ---  AFTERCAST SETS  ---
    sets.Idle = {}
	sets.Idle.Main = {main=idle_main,ammo=idle_ammo,head=idle_head,neck=idle_neck,ear1=idle_ear1,ear2=idle_ear2,body=idle_body,hands=idle_hands,ring1=idle_ring1,ring2=idle_ring2,back=idle_back,waist=idle_waist,legs=idle_legs,feet=idle_feet,sub=idle_sub}
	sets.Idle.PDT = {main=idle_pdt_main,ammo=idle_pdt_ammo,head=idle_pdt_head,neck=idle_pdt_neck,ear1=idle_pdt_ear1,ear2=idle_pdt_ear2,body=idle_pdt_body,hands=idle_pdt_hands,ring1=idle_pdt_ring1,ring2=idle_pdt_ring2,back=idle_pdt_back,waist=idle_pdt_waist,legs=idle_pdt_legs,feet=idle_pdt_feet,sub=idle_pdt_sub}
	sets.Idle.NoSubl = sets.Idle.Main
	sets.Idle.Subl = set_combine(sets.Idle.NoSubl, {head=sublimation_head,body=sublimation_body,ear2=sublimation_ear2})
    sets.Idle.Current = sets.Idle.NoSubl
    sets.Resting = sets.Idle.Main
end

function job_precast(spell)
	handle_equipping_gear(player.status)
	checkblocking(spell)
    if string.find(spell.name,'Stoneskin') then 
	  equip(sets.precast.Stoneskin) 
    elseif sets.precast.JA[spell.name] then
        equip(sets.precast.JA[spell.name])
    elseif string.find(spell.name,'Cur') and spell.name ~= 'Cursna' then
        equip(sets.precast.Cure)
    elseif spell.skill == 'EnhancingMagic' then
        equip(sets.precast.EnhancingMagic)
    elseif spell.action_type == 'Magic' then
        equip(sets.precast.FastCast)
    end

    if (buffactive.alacrity or buffactive.celerity) and world.weather_element == spell.element and not (spell.skill == 'ElementalMagic' and spell.casttime <3 and buffactive.Klimaform) then
        equip(sets.precast.FC_Weather)
    end
    
    if spell.name == 'Impact' then
        if not buffactive['Elemental Seal'] then
            add_to_chat(8,'--------- Elemental Seal is down ---------')
        end
        equip({head=empty,body="Twilight Cloak"})
    elseif spell.name == 'Stun' then
        if not buffactive.thunderstorm then
            add_to_chat(8,'--------- Thunderstorm is down ---------')
        elseif not buffactive.klimaform then
            add_to_chat(8,'----------- Klimaform is down -----------')
        end
    end
end

function job_post_midcast(spell)
    if string.find(spell.english,'Cur') then 
        equip(sets.midcast.Cure)
		if spell.target.type == 'SELF' then
		 equip(sets.midcast.CurePotencyRecieved)
		end
        weathercheck(spell.element)
        if buffactive.rapture then equip(sets.enh.Rapture) end
    elseif spell.skill=="Elemental Magic" or spell.name == "Kaustra" then
        if string.find(spell.english,'helix') or spell.name == 'Kaustra' then
            if state.CastingMode.value == "MACC" then
			  equip(sets.midcast.Helix.MACC)
			elseif state.CastingMode.value == "MATT" then
			  equip(sets.midcast.Helix.MATT)
			elseif state.CastingMode.value == "MagicBurst" then
			 if player.equipment.main == 'Khatvanga' then
			   equip(sets.midcast.Helix.MagicBurst,{feet={name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+7%','Mag. Acc.+13','"Mag.Atk.Bns."+3',}}})
			 else 
	           equip(sets.midcast.Helix.MagicBurst)
			 end
			elseif state.CastingMode.value == "StoreTP" then
			  equip(sets.midcast.Helix.StoreTP)
			else 
	          equip(sets.midcast.Helix)
			end
            if sets.ele[spell.element] then equip(sets.ele[spell.element]) end
            if spell.element == world.weather_element then
                equip(sets.weather)
            end
            if spell.element == world.day_element then
                equip(sets.day)
            end
        else
		    if state.CastingMode.value == "MACC" then
	        equip(sets.midcast['Elemental Magic'].MACC)
			elseif state.CastingMode.value == "MATT" then
	        equip(sets.midcast['Elemental Magic'].MATT)
			elseif state.CastingMode.value == "StoreTP" then
	        equip(sets.midcast['Elemental Magic'].StoreTP)
			elseif state.CastingMode.value == "MagicBurst" then
			 if player.equipment.main == 'Khatvanga' then
			   equip(sets.midcast['Elemental Magic'].MagicBurst,{feet={name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+7%','Mag. Acc.+13','"Mag.Atk.Bns."+3',}}})
			 else 
	           equip(sets.midcast['Elemental Magic'].MagicBurst)
			 end
			else 
            equip(sets.midcast['Elemental Magic'])
			end
			if spell.english == 'Impact' then
			  equip(sets.midcast.Impact)
			  weathercheck(spell.element)
			end
            if sets.ele[spell.element] then equip(sets.ele[spell.element]) end
            weathercheck(spell.element)
        end
        if buffactive.ebullience then equip(sets.enh.Ebullience) end
        if buffactive.klimaform then equip(sets.enh.Klimaform) end
    elseif spell.english == 'Impact' then
        equip(sets.midcast[spell.skill],{head=empty,body="Twilight Cloak"})
        weathercheck(spell.element)
    elseif spell.english == 'Stoneskin' then
        equip(sets.midcast.Stoneskin)
	elseif spell.english == 'Refresh' then
		if spell.target.type == 'SELF' then
		 equip(sets.midcast.RefreshRecieved)
		end
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingMagic)
        if spell.english == 'Embrava' then
            equip(sets.midcast.Embrava)
            if not buffactive.perpetuance then
                add_to_chat(8,'--------- Perpetuance is down ---------')
            end
            if not buffactive.accession then
                add_to_chat(8,'--------- Accession is down ---------')
            end
            if not buffactive.penury then
                add_to_chat(8,'--------- Penury is down ---------')
            end
        else
            if string.find(spell.english,'Regen') then
                equip(sets.midcast.Regen)
            end
            if buffactive.penury then equip(sets.enh.Penury) end
        end
        if buffactive.perpetuance then equip(sets.enh.Perpetuance) end
    elseif spell.skill == 'Enfeebling Magic' then
	    if state.CastingMode.value == "MACC" then
		equip(sets.midcast['Enfeebling Magic'].MACC)
		else
        equip(sets.midcast['Enfeebling Magic'])
		end
		weathercheck(spell.element)
        if spell.type == 'WhiteMagic' and buffactive.altruism then equip(sets.enh.Altruism) end
        if spell.type == 'BlackMagic' and buffactive.focalization then equip(sets.enh.Focalization) end
    else
        equip(sets.midcast[spell.skill])
        weathercheck(spell.element)
    end
    
    if spell.english == 'Sneak' and buffactive.sneak and spell.target.type == 'SELF' then
        send_command('@wait 1;cancel 71;')
    end
	
	if spell.name == 'Utsusemi: Ichi' then
	  send_command('cancel Copy Image|Copy Image (2)')
	end
	if spell.type == "WeaponSkill" then
	  tpspent = spell.tp_cost
	end

end        

function job_aftercast(spell)
	if state.SpellDebug.value == "On" then 
      spelldebug(spell)
	end
    if spell.interrupted then
	  add_to_chat(8,'--------- Casting Interupted: '..spell.english..'---------')
	end 
	if spell.english ~= 'Sublimation' then
	  handle_equipping_gear(player.status)
      equip(sets.Idle.Current)    
	end 
	if spell.english == 'Sublimation' and not buffactive["Sublimation: Activated"] and not buffactive["Sublimation: Complete"] then
	  sets.Idle.Current = sets.Idle.Subl
      equip(sets.Idle.Current)
    elseif spell.english == 'Sublimation' and (buffactive["Sublimation: Activated"] or buffactive["Sublimation: Complete"]) then
	  
	  sets.Idle.Current = sets.Idle.NoSubl
	  equip(sets.Idle.Current)
	end
    if spell.english == 'Sleep' or spell.english == 'Sleepga' then
        send_command('@wait 50;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
    elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
        send_command('@wait 80;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
    elseif spell.english == 'Break' or spell.english == 'Breakga' then
        send_command('@wait 20;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
    end
end



function status_change(new,tab)
    handle_equipping_gear(player.status)
    if new == 'Resting' then
        equip(sets.Resting)
    else
        equip(sets.Idle.Current)
    end
end




function job_self_command(cmdParams, eventArgs)
	--if cmdParams[1]:lower() == 'showinventory' then
	--  sammehinv()
	--end
end


function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.Idle.Current)
end


function job_handle_equipping_gear(playerStatus, eventArgs)    	
    if player.equipment.back == 'Mecisto. Mantle' or player.equipment.back == 'Aptitude Mantle' or player.equipment.back == 'Aptitude Mantle +1' or player.equipment.back == 'Nexus Cape' then
        disable('back')
    else
        enable('back')
    end
        if player.equipment.ring1 == 'Warp Ring' or player.equipment.ring1 == 'Trizek Ring' or player.equipment.ring1 == 'Capacity Ring' or player.equipment.ring1 == "Vocation Ring" then
        disable('ring1')
    else
        enable('ring1')
    end
    if player.equipment.ring2 == 'Warp Ring' or player.equipment.ring2 == 'Trizek Ring' or player.equipment.ring2 == 'Capacity Ring' or player.equipment.ring2 == "Vocation Ring" then
        disable('ring2')
    else
        enable('ring2')
    end
	if player.equipment.neck == "Arciela's Grace +1" then
        disable('neck')
    else
        enable('neck')
    end
	sets.Idle.Current = sets.Idle.NoSubl
	if buffactive["Sublimation: Activated"] then
        sets.Idle.Current = sets.Idle.Subl
    end
	if state.IdleMode.value == "PDT" then
	   sets.Idle.Current = sets.Idle.PDT
	elseif state.IdleMode.value == "OncaSuit" then
	   sets.Idle.Current = set_combine(sets.Idle.PDT,{main=idle_pdt_main,body="Onca Suit",ear1="Dominance Earring",back="Tantalic Cape",hands="",legs="",feet=""})     
	end
	
	if state.TPMode.value == "WeaponLock" then
	  equip({main=weaponlock_main,sub=weaponlock_sub})
	  disable("main")
	  disable("sub")
	else
	  enable("main")
	  enable("sub")
	end
end





function select_default_macro_book()
    set_macro_page(3, 2)
end
