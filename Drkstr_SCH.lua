function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function user_setup()
-- General Gearswap Commands:
-- F9 cycles Accuracy modes
-- ctrl+F9 cycles Hybrid modes
-- 'Windows Key'+F9 cycles Weapon Skill modes
-- F10 equips Physical Defense
-- alt+F10 toggles Kiting on or off
-- ctrl+F10 cycles Physical Defense modes
-- F11 equips Magical Defense
-- ctrl+f11 = Magical Mode change 
-- alt+F12 turns off Defense modes
-- ctrl+F12 cycles Idle modes

    state.CastingMode:options('Normal', 'MACC', 'MATT', 'MagicBurst','StoreTP')
    state.IdleMode:options('Normal','PDT')
	state.TPMode = M{['description']='TP Mode', 'Normal', 'WeaponLock'}
	send_command('alias tp gs c cycle tpmode')
	send_command('bind f10 gs c cycle idlemode')
	send_command('bind f12 gs c update CastingMode')
	select_default_macro_book()
	
		-- Set Common Aliases --
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
end

	
function init_gear_sets()

	-- Weapon Locks used for TP Mode.  When WeaponLock is set - it locks in the following Main and SUB. 
	weaponlock_main="Serenity"
	weaponlock_sub="Niobid Strap"

	-- Enhances JA 
	--sublimation_head="Acad. Mortar. +1"
	--sublimation_body="Pedagogy Gown +1"
    --enlightenment_body="Pedagogy gown +1"	

	-- Idle Sets
	
	idle_main="Bolelabunga"
	idle_sub="Culminus"
	idle_ranged=""
	idle_ammo="Elis Tome"
	idle_head="Merlinic Hood"
	idle_neck="Sanctity Necklace"
	idle_ear1="Infused Earring"
	idle_ear2="loquacious Earring"
	idle_body="Amalric Doublet"
	idle_hands="Amalric Gages"
	idle_ring1="Warden's Ring"
	idle_ring2="Vertigo Ring"
	idle_back="Solemnity Cape"
	idle_waist="Channeler's Stone"
	idle_legs="Assiduity Pants +1"
	idle_feet="Inspirited Boots"

	idle_pdt_main="Earth Staff"

	-- Precast Section
	FC_main="Bolelabunga"
	FC_sub="Culminus"
	FC_ranged=""
	FC_ammo="Elis Tome"
	FC_head="Merlinic Hood"
	FC_neck="Voltsurge Torque"
	FC_ear1="Loquacious earring"
	FC_ear2="Medicant's Earring"
	FC_body="Shango Robe"
	FC_hands="Amalric Gages"
	FC_ring1="Rahab Ring"
	FC_ring2="Warden's Ring"
	FC_back="Solemnity Cape"
	FC_waist="Channeler's Belt"
	FC_legs="Psycloth Lappas"
	FC_feet="Merlinic Crackows"
	
	--FC_enh_waist="Siegel Sash"
	--FC_stoneskin_legs="Doyen Pants"
	FC_stoneskin_head="Umuthi Hat"
	
	FC_cure_legs="Vanya Slops"
	FC_cure_feet="Medium's Sabots"
	FC_Cure_back="Solemnity Cape"
	
	-- Midcast Section
	enh_main="Bolelabunga"
	enh_sub="Culminus"
	enh_ranged=""
	enh_ammo="Elis Tome"
	enh_head=FC_stoneskin_head
	enh_neck="Sanctity Necklace"
	enh_ear1=FC_ear1
	enh_ear2=FC_ear2
	enh_body="Amalric Doublet"
	enh_hands="Amalric Gages"
	enh_ring1="Vertigo Ring"
	enh_ring2="Warden's Ring"
	enh_back="Bane Cape"
	enh_waist="Refoccilation Stone"
	enh_legs="Psycloth Lappas"
	enh_feet="Inspirited Boots"
	
	--enh_stoneskin_waist="Siegel Sash"
	enh_regen_main="Bolelabunga"
	
	cure_main="Serenity"
	cure_sub="Niobid Strap"
	cure_ranged=""
	cure_ammo="Seraphic Ampulla"
	cure_head="Vanya Hood"
	cure_neck="Sanctity Necklace"
	cure_ear1=FC_ear1
	cure_ear2=FC_ear2
	cure_body="Vanya Robe"
	cure_hands="Vanya cuffs"
	cure_ring1="Vertigo Ring"
	cure_ring2="Warden's Ring"
	cure_back="Solemnity Cape"
	cure_waist="Channeler's Stone"
	cure_legs="Vanya Slops"
	cure_feet="Medium's Sabots"

	--curepotrec_waist="Gishdubar Sash"	
	
	ele_main="Serenity"
	ele_sub="Niobid Strap"
	ele_ranged=""
	ele_ammo="Seraphic Amp'"
	ele_head={ name="Merlinic Hood", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Fast Cast"+6','INT+6','Mag. Acc.+10','"Mag.Atk.Bns."+14',}}
	ele_neck="Sanctity Necklace"
	ele_ear1="Friomisi Earring"
	ele_ear2="Gwati Earring"
	ele_body="Amalric Doublet"
	ele_hands="Amalric Gages"
	ele_ring1="Resonance Ring"
	ele_ring2="Vertigo Ring"
	ele_back="Bane Cape"
	ele_waist="Refoccilation Stone"
	ele_legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Occult Acumen"+9','CHR+5','"Mag.Atk.Bns."+13',}}
	ele_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst mdg.+7%','CHR+2','Mag. Acc.+6','"Mag.Atk.Bns."+14',}}
	
	ele_macc_main="Serenity"
	ele_macc_sub="Niobid Strap"
	ele_macc_ear1="Psystorm Earring"
	ele_macc_ear2="Lifestorm Earring"
	ele_macc_neck="Sanctity Torque"
	ele_macc_hands="Merlinic Dastanas"
	ele_macc_waist="Luminary Sash"

	ele_storetp_legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Occult Acumen"+9','CHR+5','"Mag.Atk.Bns."+13',}}
	--ele_storetp_waist="Oneiros Rope"
	ele_storetp_hands="Merlinic Dastanas"
	ele_storetp_head="Welkin Crown"
	ele_storetp_ammo="Seraphic Ampulla"
	--ele_storetp_feet="Helios Boots"
			
    --ele_burst_main="Grioavolr"
	ele_burst_hands="Amalric Gages"
	ele_burst_neck="Mizu. Kubikazari"
	ele_burst_ring2="Mujin Band"
	--ele_burst_ear2="Static Earring"
	ele_burst_head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+4%','Mag. Acc.+13','"Mag.Atk.Bns."+9',}}
	ele_burst_body={ name="Merlinic Jubbah", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst mdg.+10%','CHR+7',}}
	ele_burst_legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+16','Magic burst mdg.+10%','INT+10','"Mag.Atk.Bns."+12',}}
	ele_burst_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst mdg.+7%','CHR+2','Mag. Acc.+6','"Mag.Atk.Bns."+14',}}

	dark_body="Shango Robe"
	--dark_ring1="Evanescence Ring"
	--dark_ring2="Archon Ring"
	
	enf_main="Serenity"
	enf_sub="Mephitis Grip"
	enf_ranged=""
	enf_ammo="Elis Tome"
	enf_head={ name="Merlinic Hood", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Fast Cast"+6','INT+6','Mag. Acc.+10','"Mag.Atk.Bns."+14',}}
	enf_neck="Sanctity Necklace"
	enf_ear1="Psystorm earring"
	enf_ear2="Lifestorm Earring"
	enf_body="Shango Robe"
	enf_hands="Merlinic Dastanas"
	enf_ring1="Etana Ring"
	enf_ring2="Globidonta Ring"
	enf_back="Bane Cape"
	enf_waist="Luminary Sash"
	enf_legs="Psycloth Lappas"
	enf_feet="Medium's Sabots"
		
	-- Relevant Obis. Add the ones you have.
    sets.obi = {}
    sets.obi.Wind = {}
    sets.obi.Ice = {waist='Hyorin Obi'}
    sets.obi.Lightning = {waist='Rairin obi'}
    sets.obi.Light = {}
    sets.obi.Dark = {waist='Anrin obi'}
    sets.obi.Water = {}
    sets.obi.Earth = {}
    sets.obi.Fire = {}
    
    -- Generic gear for day/weather
	sets.ele = {}
    --sets.weather = {back='Twilight Cape'}
    --sets.day = {ring1='Zodiac Ring'}
    
    -- Various pieces that enhance specific spells/etc **** Mainly for Midcast.
    sets.enh = {}
--    sets.enh.Rapture = {head="Arbatel Bonnet +1"}
--    sets.enh.Ebullience = {head="Arbatel Bonnet +1"}
--    sets.enh.Perpetuance = {hands="Arbatel Bracers +1"}

	myrkr_legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Occult Acumen"+4','MND+2','Mag. Acc.+6','"Mag.Atk.Bns."+5',}}

    ---  PRECAST SETS  ---
    sets.precast = {}
    sets.precast.JA = {}
    -- sets.precast.JA.Enlightenment = {body="Pedagogy gown +1"}
    -- sets.precast.JA['Tabula Rasa'] = {head="Argute Pants +2"}
	sets.precast.FastCast = {main=FC_Main,sub=FC_sub,ammo=FC_ammo,head=FC_head,neck=FC_neck,ear1=FC_ear1,ear2=FC_ear2,body=FC_body,hands=FC_hands,ring1=FC_ring1,ring2=FC_ring2,back=FC_back,waist=FC_waist,legs=FC_legs,feet=FC_feet}
    sets.precast.EnhancingMagic = set_combine(sets.precast.Fastcast,{waist=FC_enh_waist})
    sets.precast.Stoneskin = set_combine(sets.precast.EnhancingMagic,{head=FC_stoneskin_head,legs=FC_stoneskin_legs})
	sets.precast.Cure = set_combine(sets.precast.FastCast,{back=FC_cure_back,legs=FC_cure_legs,feet=FC_cure_feet})
	
	-- WS Sets
	sets.precast.WS = {}
	-- Max MP set
    sets.precast.WS['Myrkr'] = {ammo="Elis Tome",head="Vanya Hood",neck="Voltsurge Torque",ear1="Loquacious Earring",ear2="Moonshade earring",body="Amalric Doublet",
	hands="Vanya Cuffs",ring1="Globidonta Ring",ring2="Etana Ring",back="Bane Cape",waist="Refoccilation Stone",legs=myrkr_legs,feet="Medium's Sabots"} 
	
    ---  MIDCAST SETS  ---
    sets.midcast = {}
    sets.midcast['Elemental Magic'] = {main=ele_main,sub=ele_sub,ammo=ele_ammo,head=ele_head,neck=ele_neck,ear1=ele_ear1,ear2=ele_ear2,body=ele_body,hands=ele_hands,ring1=ele_ring1,ring2=ele_ring2,back=ele_back,waist=ele_waist,legs=ele_legs,feet=ele_feet}
	sets.midcast['Elemental Magic'].MACC = set_combine(sets.midcast['Elemental Magic'], {main=ele_macc_main,sub=ele_macc_sub,ear1=ele_macc_ear1,ear2=ele_macc_ear2,neck=ele_macc_neck,hands=ele_macc_hands,waist=ele_macc_waist})
	sets.midcast['Elemental Magic'].MATT = sets.midcast['Elemental Magic']
	sets.midcast['Elemental Magic'].StoreTP = set_combine(sets.midcast['Elemental Magic'], {legs=ele_storetp_legs,waist=ele_storetp_waist,hands=ele_storetp_hands,head=ele_storetp_head,ammo=ele_storetp_ammo,feet=ele_storetp_feet})
	sets.midcast['Elemental Magic'].MagicBurst = set_combine(sets.midcast['Elemental Magic'].MATT, {main=ele_burst_main,hands=ele_burst_hands,neck=ele_burst_neck,ring1=ele_burst_ring1,ring2=ele_burst_ring2,ear2=ele_burst_ear2,legs=ele_burst_legs,feet=ele_burst_feet})
    sets.midcast['Dark Magic'] = set_combine(sets.midcast['Elemental Magic'], {ring1=dark_ring1,ring2=dark_ring2,body=dark_body})
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})    
    sets.midcast['Dark Magic'].Death = sets.midcast['Dark Magic']
	sets.midcast['Dark Magic'].Death.MagicBurst = sets.midcast['Elemental Magic'].MagicBurst
    sets.midcast['Enfeebling Magic'] = {main=enf_main,sub=enf_sub,ammo=enf_ammo,head=enf_head,neck=enf_neck,ear1=enf_ear1,ear2=enf_ear2,body=enf_body,hands=enf_hands,ring1=enf_ring1,ring2=enf_ring2,back=enf_back,waist=enf_waist,legs=enf_legs,feet=enf_feet}
	sets.midcast['Enfeebling Magic'].MACC = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast['Healing Magic'] = {main=cure_main,sub=cure_sub,ammo=cure_ammo,head=cure_head,neck=cure_neck,ear1=cure_ear1,ear2=cure_ear2,body=cure_body,hands=cure_hands,ring1=cure_ring1,ring2=cure_ring2,back=cure_back,waist=cure_waist,legs=cure_legs,feet=cure_feet}
    sets.midcast['Enhancing Magic'] = {main=enh_main,sub=enh_sub,ammo=enh_ammo,head=enh_head,neck=enh_neck,ear1=enh_ear1,ear2=enh_ear2,body=enh_body,hands=enh_hands,ring1=enh_ring1,ring2=enh_ring2,back=enh_back,waist=enh_waist,legs=enh_legs,feet=enh_feet}
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main=enh_regen_main})
	sets.midcast.Cure = {main=cure_main,sub=cure_sub,ammo=cure_ammo,head=cure_head,neck=cure_neck,ear1=cure_ear1,ear2=cure_ear2,body=cure_body,hands=cure_hands,ring1=cure_ring1,ring2=cure_ring2,back=cure_back,waist=cure_waist,legs=cure_legs,feet=cure_feet}
	sets.midcast.CurePotencyRecieved = set_combine(sets.midcast.Cure, {waist=curepotrec_waist})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist=enh_stoneskin_waist})
    
    ---  AFTERCAST SETS  ---
    sets.Idle = {main=idle_main,ammo=idle_ammo,head=idle_head,neck=idle_neck,ear1=idle_ear1,ear2=idle_ear2,body=idle_body,hands=idle_hands,ring1=idle_ring1,ring2=idle_ring2,back=idle_back,waist=idle_waist,legs=idle_legs,feet=idle_feet,sub=idle_sub}
 	sets.Idle.PDT = set_combine(sets.Idle, {main="Earth Staff"})
    sets.Resting = {sets.Idle}

    stuntarg = 'Shantotto'
end





function job_precast(spell)
    handle_equipping_gear(player.status)
	if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive ['Copy Image (4+)']) then
	  cancel_spell()
	  send_command('@wait 1;')
	  equip(sets.Idle)
	  return
	end
    -- if spell.name == 'Celerity' then
    --    equip({head="Vanya Hood"})
    -- end
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
        if stuntarg ~= 'Shantotto' then
            send_command('@input /t '..stuntarg..' ---- Stunned!!! ---- ')
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
        if buffactive.rapture then 
		 equip(sets.enh.Rapture) 
		end
    elseif spell.skill=="Elemental Magic" or spell.name == "Kaustra" then
		if state.CastingMode.value == "MACC" then
	     equip(sets.midcast['Elemental Magic'].MACC)
		elseif state.CastingMode.value == "MATT" then
	     equip(sets.midcast['Elemental Magic'].MATT)
		elseif state.CastingMode.value == "StoreTP" then
	     equip(sets.midcast['Elemental Magic'].StoreTP)
		elseif state.CastingMode.value == "MagicBurst" then
	     equip(sets.midcast['Elemental Magic'].MagicBurst)
		else 
         equip(sets.midcast['Elemental Magic'])
		end
        if sets.ele[spell.element] then equip(sets.ele[spell.element]) end
          weathercheck(spell.element)
        if buffactive.ebullience then equip(sets.enh.Ebullience) end
        if buffactive.klimform then equip(sets.enh.Klimaform) end
	elseif spell.english == 'Death' then
		if state.CastingMode.value == "MagicBurst" then
	      equip(sets.midcast['Dark Magic'].Death.MagicBurst)
		else
          equip(sets.midcast['Dark Magic'].Death)
		end
        weathercheck(spell.element)		
    elseif spell.english == 'Impact' then
        equip(sets.midcast[spell.skill],{head=empty,body="Twilight Cloak"})
        weathercheck(spell.element)
    elseif spell.english == 'Stoneskin' then
        equip(sets.midcast.Stoneskin)
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
end        

function job_aftercast(spell)
    handle_equipping_gear(player.status)
    equip(sets.Idle)    
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
        equip(sets.Idle)
    end
end


function job_buff_change(status,gain_or_loss)
    handle_equipping_gear(player.status)
	equip(sets.Idle)
end


function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.Idle)
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
	if player.equipment.body == "Twilight Cloak" then
	    disable('body')
		disable('head')
	else
	    enable('head')
		enable('body')
	end
	if state.IdleMode.value == "PDT" then
	   sets.Idle = set_combine(sets.Idle,{main=idle_pdt_main})   
	else 
	   sets.Idle = set_combine(sets.Idle,{main=idle_main})
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



function self_command(command)
    if command == 'stuntarg' then
        stuntarg = target.name
    end
end

-- This function is user defined, but never called by GearSwap itself. It's just a user function that's only called from user functions. I wanted to check the weather and equip a weather-based set for some spells, so it made sense to make a function for it instead of replicating the conditional in multiple places.

function weathercheck(spell_element)
    if spell_element == world.weather_element then
        equip(sets.weather)
        if sets.obi[spell_element] then
            equip(sets.obi[spell_element])
        end
    end
    if spell_element == world.day_element then
        equip(sets.day)
        if sets.obi[spell_element] then
            equip(sets.obi[spell_element])
        end
    end
end


function select_default_macro_book()
    set_macro_page(3, 2)
end
