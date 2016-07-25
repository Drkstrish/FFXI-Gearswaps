function get_sets()
	mote_include_version = 2
		include('Mote-Include.lua')
		include('sammeh_custom_functions.lua')
end

function user_setup()
	state.IdleMode:options('Normal','PDT')
	state.TPMode = M{['description']='TP Mode', 'Normal','RACC'}
	state.RngMode = M{['description']='Ranger Mode', 'Archery','Gun','XBow'}
	state.Bolt = M{['description']='Bolt Mode','Normal','DefDown','Holy Bolt','Bloody Bolt'}
		send_command('alias tp gs c cycle tpmode')
		send_command('alias rngmode gs c cycle rngmode')
		send_command('alias boltmode gs c cycle Bolt')
		send_command('bind f9 gs c cycle RngMode')
		send_command('bind ^f9 gs c cycle Bolt')
		send_command('bind f10 gs c cycle idlemode')
	select_default_macro_book()

-- Set Common Aliases --
		send_command("alias fc gs equip sets.precast.FastCast")
		send_command("alias preshot gs equip sets.precast.PreShot")
		send_command("alias rngtp gs equip sets.midcast.TP.normal")
		send_command("alias rngtpacc gs equip sets.midcast.TP.RACC")
		send_command("alias sw gs equip sets.precast.WS")
		send_command("alias jr gs equip sets.precast.WS['Jishnu\'s Radiance']")
end

function init_gear_sets()
	TP_Hands = "Meghanada Gloves +1"

	if state.RngMode.value == 'Archery' then
		RNGWeapon = "Steinthor"
		TP_Ammo = "Achiyalabopa Arrow"
		WS_Ammo = "Achiyalabopa Arrow"
			send_command("alias rngws1 input /ws 'Jishnu\'s Radiance' <t>")
			send_command("alias rngws2 input /ws 'Namas Arrow' <t>")
			send_command("alias rngws3 input /ws 'Apex Arrow' <t>")
		TP_Hands = "Meghanada Gloves +1"
		
	elseif state.RngMode.value == 'Gun' then 
		RNGWeapon = "Wochowsen"
		TP_Ammo = "Achiyal. Bolt"
		WS_Ammo = "Achiyal. Bolt"
			send_command("alias rngws1 input /ws 'Slugshot' <t>")
			send_command("alias rngws2 input /ws 'Trueflight' <t>")
			send_command("alias rngws3 input /ws 'Wildfire' <t>")
	
	elseif state.RngMode.value == 'XBow' then
		RNGWeapon = "Imati +1"
		TP_Ammo = "Achiyal. Bolt"
		WS_Ammo = "Achiyal. Bolt"
			if state.Bolt.value == 'DefDown' then 
		TP_Ammo = "Abrasion Bolt"
			elseif state.Bolt.value == 'Holy Bolt' then
		TP_Ammo = "Righteous Bolt"
			elseif state.Bolt.value == 'Bloody Bolt' then
		TP_Ammo = "Bloody Bolt"
			end
			send_command("alias rngws2 input /ws 'Wildfire' <t>")
			send_command("alias rngws3 input /ws 'Slug Shot' <t>")
			send_command("alias rngws1 input /ws 'Trueflight' <t>")
end
	
			
    ---  PRECAST SETS  ---
	sets.precast = {}

	sets.precast.PreShot = {
		range=RNGWeapon,
		ammo=TP_Ammo,
		head="Amini Gapette",  -- 6 --
		body={ name="Pursuer's Doublet", augments={'HP+50','Crit. hit rate+4%','"Snapshot"+6',}}, -- 6 --
		hands="Alruna's Gloves +1",  -- 5 --
		legs="Adhemar Kecks",  -- 9 -- 
		feet="Adhemar Gamashes", -- 8 -- 
		neck="Combatant's Torque",
		waist="Yemaya Belt",    -- 3 from impulse belt --
		left_ear="Neritic Earring",
		right_ear="Enervating Earring",
		left_ring="K'ayres Ring",
		right_ring="Rajas Ring",
		back="Lutian Cape", -- 2 -- 
		}
	sets.precast.PreShot.Overkill = set_combine(sets.precast.PreShot, {})
	
	sets.midcast.TP = {} 
	sets.midcast.TP.normal = {
	    range=RNGWeapon,
		ammo=TP_Ammo,
		head="Arcadian Beret +1",
		body={ name="Pursuer's Doublet", augments={'HP+50','Crit. hit rate+4%','"Snapshot"+6',}},
		hands=TP_Hands,
		legs="Adhemar Kecks",
		feet="Adhemar Gamashes",
		neck="Combatant's Torque",
		waist="Yemaya Belt",
		left_ear="Neritic Earring",
		right_ear="Enervating Earring",
		left_ring="K'ayres Ring",
		right_ring="Rajas Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	sets.midcast.TP.RACC = {
		head="Meghanada Visor +1",
		body="Meg. Cuirie +1",
		hands="Meg. Gloves +1",
		legs="Meg. Chausses +1",
		feet="Meg. Jam. +1",
		neck="Combatant's Torque",
		waist="Yemaya Belt",
		left_ear="Neritic Earring",
		right_ear="Enervating Earring",
		left_ring="Paqichikaji Ring",
		right_ring="Hajduk Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	sets.Barrage = {hands="Orion Bracers +1"}
    
	--Job Abilities
	sets.precast.JA = {}
    sets.precast.JA.Scavenge = {feet="Orion Socks +1"}
	sets.precast.JA.Sharpshot = {hands="Orion Braccae +1"}
	sets.precast.JA['Bounty Shot'] = { hands="Amini Glove. +1"}
    sets.precast.JA.Camouflage = {body="Orion Jerkin +1"}
    sets.precast.JA['Eagle Eye Shot'] = {}
    sets.precast.JA.Shadowbind = {}
    sets.precast.JA.Sharpshot = {}
     
	-- sets.precast.FastCast = {main=FC_Main,sub=FC_sub,ammo=FC_ammo,head=FC_head,neck=FC_neck,ear1=FC_ear1,ear2=FC_ear2,body=FC_body,hands=FC_hands,ring1=FC_ring1,ring2=FC_ring2,back=FC_back,waist=FC_waist,legs=FC_legs,feet=FC_feet}
    
	-- WS Sets
	sets.precast.WS = {
	    ammo=TP_Ammo,
		head={ name="Herculean Helm", augments={'Rng.Acc.+28','Weapon skill damage +3%','DEX+11','Rng.Atk.+12',}},
		body={ name="Herculean Vest", augments={'Rng.Acc.+23 Rng.Atk.+23','Weapon skill damage +3%','Rng.Atk.+9',}},
		hands={ name="Herculean Gloves", augments={'Rng.Acc.+15 Rng.Atk.+15','Weapon skill damage +2%','DEX+9','Rng.Atk.+15',}},
		--legs="Adhemar Kecks",
		legs="Amini Brague +1",
		feet={ name="Herculean Boots", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +2%','Rng.Acc.+1','Rng.Atk.+9',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Enervating Earring",
		left_ring="K'ayres Ring",
		right_ring="Rajas Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}
	sets.precast.WS['Jishnu\'s Radiance'] = {
		ammo=TP_Ammo,
		head={ name="Herculean Helm", augments={'Rng.Acc.+28','Weapon skill damage +3%','DEX+11','Rng.Atk.+12',}},
		body={ name="Herculean Vest", augments={'Rng.Acc.+23 Rng.Atk.+23','Weapon skill damage +3%','Rng.Atk.+9',}},
		hands={ name="Herculean Gloves", augments={'Rng.Acc.+15 Rng.Atk.+15','Weapon skill damage +2%','DEX+9','Rng.Atk.+15',}},
		--legs="Adhemar Kecks",
		legs="Amini Brague +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Enervating Earring",
		left_ring="K'ayres Ring",
		right_ring="Rajas Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
		feet="Thereoid Greaves",
	}
	-- sets.precast.WS['Sidewinder'] = set_combine(sets.precast.WS, {neck="Fotia Gorget"})
	-- sets.precast.WS['Slug Shot'] = sets.precast.WS['Sidewinder']
	sets.precast.WS['Trueflight'] = {
	    head={ name="Herculean Helm", augments={'Rng.Acc.+28','Weapon skill damage +3%','DEX+11','Rng.Atk.+12',}},
		body="Orion Jerkin +1",
		hands="Leyline Gloves",
		legs="Gyve Trousers",
		feet={ name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Crematio Earring",
		right_ear={ name="Moonshade Earring", augments={'MP+25','TP Bonus +25',}},
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Weather. Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}
    sets.precast.WS['Wildfire'] = sets.precast.WS['Trueflight']
	
    ---  AFTERCAST SETS  ---
    sets.idle = set_combine(sets.precast.PreShot, {})

	
end

function job_precast(spell)
    handle_equipping_gear(player.status)
	checkblocking(spell)
	if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive ['Copy Image (4+)']) then
	  cancel_spell()
	  send_command('@wait 1;')
	  return
	end
    if spell.name == 'Ranged' then
        equip(sets.precast.PreShot)
        if buffactive.Overkill then
            equip(sets.precast.PreShot.Overkill)
        end
    end
	if spell.type == "WeaponSkill" and buffactive["Velocity Shot"] then
	    if sets.precast.WS[spell.name] then 
			equip(set_combine(sets.precast.WS[spell.name], {body="Amini Caban +1"}))
		else
			equip(set_combine(sets.precast.WS, {body="Amini Caban +1"}))
		end
	end
end

function job_post_midcast(spell)
    if spell.english == 'Sneak' and buffactive.sneak and spell.target.type == 'SELF' then
        send_command('@wait 1;cancel 71;')
    end
	if spell.name == 'Utsusemi: Ichi' then
	  send_command('cancel Copy Image|Copy Image (2)')
	end
	
	if spell.name == 'Ranged' then
	 if state.TPMode.value == 'Normal' then
	   equip(sets.midcast.TP.normal)
	 elseif state.TPMode.Value == 'RACC' then
	   equip(sets.midcast.TP.RACC)
	 end
     if buffactive.Barrage then
        equip(sets.Barrage)
     end
    end
	if spell.type == "WeaponSkill" then
	  tpspent = spell.tp_cost
	end

end        

function job_aftercast(spell)
	if state.SpellDebug.value == "On" then 
      spelldebug(spell)
	end

    handle_equipping_gear(player.status)
    equip(sets.idle)
end

function status_change(new,tab)
	handle_equipping_gear(player.status)
    if new == 'Resting' then
        equip(sets.Resting)
    else
        equip(sets.idle)
    end
end

function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.idle)
end


function job_handle_equipping_gear(playerStatus, eventArgs)    	
init_gear_sets()
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
end



function select_default_macro_book()
    set_macro_page(4, 1)
end
