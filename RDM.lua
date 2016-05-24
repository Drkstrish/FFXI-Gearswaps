
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

    state.CastingMode:options('Normal', 'MagicBurst')
    state.IdleMode:options('Normal','PDT')
	send_command('bind f10 gs c cycle idlemode')
	send_command('bind f12 gs c update caster')
    select_default_macro_book()
	
		
	-- Set Common Aliases --
	send_command("alias enh gs equip sets.midcast['Enhancing Magic']")
	send_command("alias ele gs equip sets.midcast['Elemental Magic']")
	send_command("alias magicburst gs equip sets.midcast['Elemental Magic'].MagicBurst")
	send_command("alias enf gs equip sets.midcast['Enfeebling Magic']")
	send_command("alias dark gs equip sets.midcast['Dark Magic']")
	send_command("alias regen gs equip sets.midcast.Regen")
	send_command("alias cureset gs equip sets.midcast.Cure")
	
	
end

	
function init_gear_sets()
      
	RDMJSE_1 = {name="Ghostfyre Cape", augments={'Mag. Acc.+5','Enfb. mag. skill +9','Enha. mag. skill +7','Enh. Mag. eff. dur. +18'}}
	RDMJSE_2 = {name="Ghostfyre Cape", augments={'Enfb. mag. skill +10','Enha. mag. skill +6'}}
	
		-- Idle Sets
	idle_main={ name="Grioavolr", augments={'Enfb.mag. skill +14','MP+51','Mag. Acc.+19','"Mag.Atk.Bns."+1','Magic Damage +6',}}
	idle_sub="Mephitis Grip"
	idle_ranged=""
	idle_ammo="Homiliary"
	idle_head="Vitivation Chapeau +1"
	idle_neck="Loricate Torque +1"
	idle_ear1="Dignitary's Earring"
	idle_ear2="Gwati Earring"
	idle_body="Lethargy Sayon +1"
	idle_hands="Lethargy Gantherots +1"
	idle_ring1={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -5%','Phys. dmg. taken -3%',}}
	idle_ring2={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Magic dmg. taken -4%','Spell interruption rate down -3%',}}
	idle_back="Solemnity Cape"
	idle_waist="Flume Belt +1"
	idle_legs="Carmine Cuisses +1"
	idle_feet="Medium's Sabots"
	
	idle_pdt_main="Earth Staff"

	-- Precast Section
	FC_main={ name="Grioavolr", augments={'Enfb.mag. skill +14','MP+51','Mag. Acc.+19','"Mag.Atk.Bns."+1','Magic Damage +6',}}
	FC_sub="Mephitis Grip"
	FC_ranged=""
	FC_ammo="Impatiens"
	FC_head="Vanya Hood"
	FC_neck="Loricate Torque +1"
	FC_ear1="Loquacious earring"
	FC_ear2="Enchntr. Earring +1"
	FC_body="Vitivation Tabard"
	FC_hands="Lethargy Gantherots +1"
	FC_ring1="Prolix Ring"
	FC_ring2="Weather. Ring"
	FC_back="Swith Cape"
	FC_waist="Witful Belt"
	FC_legs="Psycloth Lappas"
	FC_feet="Medium's Sabots"
	
	FC_enf_head="Lethargy Chappel"
	FC_enh_waist="Siegel Sash"
	
	-- FC_cure_legs=FC_stoneskin_legs
	FC_cure_feet="Vanya Clogs"
	FC_Cure_back="Pahtli Cape"
	
	
	-- Midcast Section
	enh_main={ name="Grioavolr", augments={'Enfb.mag. skill +14','MP+51','Mag. Acc.+19','"Mag.Atk.Bns."+1','Magic Damage +6',}}
	enh_sub="Mephitis Grip"
	enh_ranged=""
	enh_ammo="Impatiens"
	enh_head="Vitivation Chapeau +1"
	enh_neck="Weike Torque"
	enh_ear1=FC_ear1
	enh_ear2=FC_ear2
	enh_body="Vitivation Tabard"
	enh_hands="Vitivation Gloves"
	enh_ring1="Prolix Ring"
	enh_ring2="Weather. Ring"
	enh_back=RDMJSE_1
	enh_waist="Witful Belt"
	enh_legs="Carmine Cuisses +1"
	enh_feet="Leth. Houseaux +1"

	enh_stoneskin_waist="Siegel Sash"
	enh_regen_main="Bolelabunga"
	enh_refresh_legs="Lethargy Fuseau +1"
	
	cure_main="Serenity" 
	cure_sub="Achaq Grip"
	cure_ranged=""
	cure_ammo="Elis Tome"
	cure_head="Vanya Hood" -- 10 -- 
	cure_neck="Loricate Torque +1"
	cure_ear1=FC_ear1
	cure_ear2=FC_ear2
	cure_body="Chironic Doublet"  -- 13 -- 
	cure_hands="Telchine Gloves"  -- 10 -- 
	cure_ring1="Prolix Ring"
	cure_ring2="Weather. Ring" 
	cure_back=RDMJSE_1 -- +6 --
	cure_waist="Witful Belt" 
	cure_legs="Gyve Trousers"  -- +10 --
	cure_feet="Vanya Clogs"    -- +5 --
	
	
	curepotrec_waist="Gishdubar Sash"
	
	ele_main={ name="Grioavolr", augments={'Magic burst mdg.+6%','Mag. Acc.+29','"Mag.Atk.Bns."+6','Magic Damage +7',}}
	ele_sub="Zuuxowu Grip"
	ele_ranged=""
	ele_ammo="Dosis Tathlum"
	ele_head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst mdg.+6%','MND+4','Mag. Acc.+8','"Mag.Atk.Bns."+13',}}
	ele_neck="Sanctity Necklace"
	ele_ear1="Crematio Earring"
	ele_ear2="Hermetic Earring"
	ele_body={ name="Merlinic Jubbah", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Occult Acumen"+10','INT+7','Mag. Acc.+9','"Mag.Atk.Bns."+8',}}
	ele_hands="Amalric Gages"
	ele_ring1="Resonance Ring"
	ele_ring2="Weather. Ring"
	ele_back="Sucellos's Cape"
	ele_waist="Refoccilation Stone"
	ele_legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic Damage +6','INT+10','Mag. Acc.+12','"Mag.Atk.Bns."+7',}}
	ele_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Mag.Atk.Bns."+14',}}
	
	ele_burst_hands="Amalric Gages"
	ele_burst_neck="Mizu. Kubikazari"
	ele_burst_ring1="Locus Ring"
	ele_burst_ring2="Mujin Band"
	ele_burst_ear2="Static Earring"
	ele_burst_head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst mdg.+6%','MND+4','Mag. Acc.+8','"Mag.Atk.Bns."+13',}}
	ele_burst_legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst mdg.+4%','CHR+5',}}
	ele_burst_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+11%','Mag. Acc.+12',}}
	
	dark_ring1="Evanescence Ring"
	dark_ring2="Archon Ring"
	
	enf_main={ name="Grioavolr", augments={'Enfb.mag. skill +14','MP+51','Mag. Acc.+19','"Mag.Atk.Bns."+1','Magic Damage +6',}}
	enf_sub="Mephitis Grip"
	enf_ranged=""
	enf_ammo="Elis Tome"
	enf_head="Vitivation Chapeau +1"
	enf_neck="Weike Torque"
	enf_ear1="Dignitary's Earring"
	enf_ear2="Gwati Earring"
	enf_body="Vanya Robe"
	enf_hands="Lethargy Gantherots +1"
	enf_ring1="Globidonta Ring"
	enf_ring2="Weather. Ring"
	-- enf_back=RDMJSE_1
	enf_back="Sucellos's Cape"
	enf_waist="Rumination Sash"
	enf_legs="Chironic Hose"
	enf_feet="Medium's Sabots"
    
	enf_paralyze_feet="Vitivation Boots +1"
	
	-- Relevant Obis. Add the ones you have.
    sets.obi = {}
    sets.obi.Wind = {waist='Furin Obi'}
    sets.obi.Ice = {waist='Hyorin Obi'}
    sets.obi.Lightning = {waist='Rairin Obi'}
    sets.obi.Light = {waist='Korin Obi'}
    sets.obi.Dark = {waist='Anrin Obi'}
    sets.obi.Water = {waist='Suirin Obi'}
    sets.obi.Earth = {waist='Dorin Obi'}
    sets.obi.Fire = {waist='Karin Obi'}
    
    -- Generic gear for day/weather
	sets.ele = {}
    sets.weather = {back='Twilight Cape'}
    -- sets.day = {ring1='Zodiac Ring'}
    
    -- Various pieces that enhance specific spells/etc **** Mainly for Midcast.
    sets.enh = {}
    sets.enh.BioIII = {legs="Vitivation Tights"}
	sets.enh.DiaIII = {head="Vitivation Chapeau +1"}
 
    ---  PRECAST SETS  ---
    sets.precast = {}
    
    sets.precast.JA = {}
	sets.precast.JA.Chainspell = {body="Vitivation Tabard"}
        
    sets.precast.FastCast = {main=FC_Main,sub=FC_sub,ammo=FC_ammo,head=FC_head,neck=FC_neck,ear1=FC_ear1,ear2=FC_ear2,body=FC_body,hands=FC_hands,ring1=FC_ring1,ring2=FC_ring2,back=FC_back,waist=FC_waist,legs=FC_legs,feet=FC_feet}
    sets.precast.EnhancingMagic = set_combine(sets.precast.Fastcast,{})
    sets.precast.Cure = set_combine(sets.precast.FastCast,{back=FC_cure_back,feet=FC_cure_feet})
    sets.precast.Stoneskin = set_combine(sets.precast.EnhancingMagic,{head=FC_stoneskin_head,legs=FC_stoneskin_legs})
	sets.precast.EnfeeblingMagic = {sets.precast.FastCast,{head=FC_enf_head}}
    
    ---  MIDCAST SETS  ---
    sets.midcast = {}
    
    sets.midcast['Elemental Magic'] = {main=ele_main,sub=ele_sub,ammo=ele_ammo,head=ele_head,neck=ele_neck,ear1=ele_ear1,ear2=ele_ear2,body=ele_body,hands=ele_hands,ring1=ele_ring1,ring2=ele_ring2,back=ele_back,waist=ele_waist,legs=ele_legs,feet=ele_feet}
    sets.midcast['Elemental Magic'].MACC = set_combine(sets.midcast['Elemental Magic'], {sub=ele_macc_sub,ear1=ele_macc_ear1,neck=ele_macc_neck,hands=ele_macc_hands})
	sets.midcast['Elemental Magic'].MATT = sets.midcast['Elemental Magic']
	sets.midcast['Elemental Magic'].MagicBurst = set_combine(sets.midcast['Elemental Magic'].MATT, {head=ele_burst_head,hands=ele_burst_hands,ring1=ele_burst_ring1,ring2=ele_burst_ring2})
	sets.midcast['Dark Magic'] = set_combine(sets.midcast['Elemental Magic'], {ring1=dark_ring1})
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})    
	sets.midcast['Enfeebling Magic'] = {main=enf_main,sub=enf_sub,ammo=enf_ammo,head=enf_head,neck=enf_neck,ear1=enf_ear1,ear2=enf_ear2,body=enf_body,hands=enf_hands,ring1=enf_ring1,ring2=enf_ring2,back=enf_back,waist=enf_waist,legs=enf_legs,feet=enf_feet}
	sets.midcast['Enfeebling Magic'].MACC = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast['Healing Magic'] = {main=cure_main,sub=cure_sub,ammo=cure_ammo,head=cure_head,neck=cure_neck,ear1=cure_ear1,ear2=cure_ear2,body=cure_body,hands=cure_hands,ring1=cure_ring1,ring2=cure_ring2,back=cure_back,waist=cure_waist,legs=cure_legs,feet=cure_feet}
    sets.midcast['Enhancing Magic'] = {main=enh_main,sub=enh_sub,ammo=enh_ammo,head=enh_head,neck=enh_neck,ear1=enh_ear1,ear2=enh_ear2,body=enh_body,hands=enh_hands,ring1=enh_ring1,ring2=enh_ring2,back=enh_back,waist=enh_waist,legs=enh_legs,feet=enh_feet}
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main=enh_regen_main})
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {legs=enh_refresh_legs})
	sets.midcast['Paralyze II'] = set_combine(sets.midcast['Enhancing Magic'], {feet=enf_paralyze_feet})
	sets.midcast.Cure = {main=cure_main,sub=cure_sub,ammo=cure_ammo,head=cure_head,neck=cure_neck,ear1=cure_ear1,ear2=cure_ear2,body=cure_body,hands=cure_hands,ring1=cure_ring1,ring2=cure_ring2,back=cure_back,waist=cure_waist,legs=cure_legs,feet=cure_feet}
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
    
    ---  AFTERCAST SETS  ---
    sets.Idle = {main=idle_main,ammo=idle_ammo,head=idle_head,neck=idle_neck,ear1=idle_ear1,ear2=idle_ear2,body=idle_body,hands=idle_hands,ring1=idle_ring1,ring2=idle_ring2,back=idle_back,waist=idle_waist,legs=idle_legs,feet=idle_feet,sub=idle_sub}
    sets.Idle.Current = sets.Idle
	sets.Idle.Resting = sets.Idle
    
    stuntarg = 'Shantotto'
end

function job_precast(spell)
    handle_equipping_gear(player.status)
	if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive ['Copy Image (4+)']) then
	  cancel_spell()
	  send_command('@wait 1;')
	  equip(sets.Idle.Current)
	  return
	end
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
    if spell.name == 'Impact' then
        equip({head=empty,body="Twilight Cloak"})
    end
end

function job_post_midcast(spell)
    if string.find(spell.english,'Cur') then 
        equip(sets.midcast.Cure)
        weathercheck(spell.element)
    elseif spell.skill=="Elemental Magic" then
		if state.CastingMode.value == "MACC" then
	      equip(sets.midcast['Elemental Magic'].MACC)
		elseif state.CastingMode.value == "MagicBurst" then
	        equip(sets.midcast['Elemental Magic'].MagicBurst)
		else 
          equip(sets.midcast['Elemental Magic'])
		end
        if sets.ele[spell.element] then equip(sets.ele[spell.element]) end
          weathercheck(spell.element)
    elseif spell.english == 'Impact' then
        equip(sets.midcast[spell.skill],{head=empty,body="Twilight Cloak"})
        weathercheck(spell.element)
    elseif spell.english == 'Stoneskin' then
        equip(sets.midcast.Stoneskin)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingMagic)
        if string.find(spell.english,'Regen') then
          equip(sets.midcast.Regen)
        end
    elseif spell.skill == 'Enfeebling Magic' then
	    if state.CastingMode.value == "MACC" then
		equip(sets.midcast['Enfeebling Magic'].MACC)
		else
        equip(sets.midcast['Enfeebling Magic'])
		end
		weathercheck(spell.element)
		if spell.english == 'Paralyze II' then
		  equip(sets.midcast['Paralyze II'])
		end
    else
        equip(sets.midcast[spell.skill])
        weathercheck(spell.element)
    end
    if spell.name == 'Utsusemi: Ichi' then
	  send_command('cancel Copy Image|Copy Image (2)')
	end
end        

function job_aftercast(spell)
    handle_equipping_gear(player.status)
    equip(sets.Idle.Current)    
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


function job_buff_change(status,gain_or_loss)
   if (gain_or_loss) then  
   add_to_chat(4,'------- Gained Buff: '..status..'-------')
   else 
   add_to_chat(3,'------- Lost Buff: '..status..'-------')
   end
    handle_equipping_gear(player.status)
 --  equip(sets.Idle.Current)
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
        if player.equipment.ring1 == 'Warp Ring' or player.equipment.ring1 == 'Trizek Ring' or player.equipment.ring1 == 'Capacity Ring' then
        disable('ring1')
    else
        enable('ring1')
    end
    if player.equipment.ring2 == 'Warp Ring' or player.equipment.ring2 == 'Trizek Ring' or player.equipment.ring2 == 'Capacity Ring' then
        disable('ring2')
    else
        enable('ring2')
    end
	if player.equipment.main == 'Malevolence' or player.equipment.main == 'Vampirism' or player.equipment.main == 'Emissary' or player.equipment.main == 'Colada' then
        disable('main')
		disable('sub')
    else
        enable('main')
		enable('sub')
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
        if sets.obi[spell_element] then
            equip(sets.obi[spell_element])
        end
    end
end


function select_default_macro_book()
    set_macro_page(1, 10)
end
