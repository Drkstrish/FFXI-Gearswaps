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
	TP_Hands = "Adhemar Wristbands"

	if state.RngMode.value == 'Archery' then
		RNGWeapon = "Steinthor"
		TP_Ammo = "Achiyalabopa Arrow"
		WS_Ammo = "Achiyalabopa Arrow"
			send_command("alias rngws1 input /ws 'Jishnu\'s Radiance' <t>")
			send_command("alias rngws2 input /ws 'Namas Arrow' <t>")
			send_command("alias rngws3 input /ws 'Apex Arrow' <t>")
		TP_Hands = "Adhemar Wristbands"
		
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
-- Snapshot 10% merits = 6 + 7 + 8 + 3 = 34%
-- Rapid Shot 30% traits 5% merits = 10 + 10 + 19 + 3 = 77% 
	sets.precast.PreShot = {
		range=RNGWeapon,
		ammo=TP_Ammo,
		head={ name="Pursuer's Beret", augments={'AGI+10','"Rapid Shot"+10','"Subtle Blow"+7',}}, -- 10R
		body={ name="Pursuer's Doublet", augments={'HP+50','Crit. hit rate+4%','"Snapshot"+6',}}, -- 6S
		hands={ name="Carmine Fin. Ga.", augments={'Rng.Atk.+15','"Mag.Atk.Bns."+10','"Store TP"+5',}}, -- 10R 7S
		legs={ name="Pursuer's Pants", augments={'AGI+10','"Rapid Shot"+10','"Subtle Blow"+7',}}, -- 19R
		feet="Meg. Jam. +1", -- 8S
		neck="Marked Gorget",
		waist="Ponente Sash", -- 3R
		left_ear="Enervating Earring",
		right_ear="Neritic Earring",
		left_ring="Cacoethic Ring",
		right_ring="Cacoethic Ring +1",
		back="Lutian Cape" -- 3S
		}

	sets.precast.PreShot.Overkill = set_combine(sets.precast.PreShot, {})
	
	sets.midcast.TP = {} 
	
	sets.midcast.TP.normal = {
	    	range=RNGWeapon,
		ammo=TP_Ammo,
		head="Meghanada Visor +1",
		body={ name="Pursuer's Doublet", augments={'HP+50','Crit. hit rate+4%','"Snapshot"+6',}},
		hands=TP_Hands,
		legs={ name="Herculean Trousers", augments={'Rng.Acc.+23 Rng.Atk.+23','Enmity-1','AGI+7','Rng.Atk.+15',}},
		feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
		neck="Marked Gorget",
		waist="Ponente Sash",
		left_ear="Enervating Earring",
		right_ear="Neritic Earring",
		left_ring="Rajas Ring",
		right_ring="Apate Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
		}

	sets.midcast.TP.RACC = {
		head="Meghanada Visor +1",
		body="Meg. Cuirie +1",
		hands="Meg. Gloves +1",
		legs="Meg. Chausses +1",
		feet="Meg. Jam. +1",
		neck="Marked Gorget",
		waist="Eschan Stone",
		left_ear="Enervating Earring",
		right_ear="Neritic Earring",
		left_ring="Cacoethic Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
		}
	
	sets.Barrage = sets.midcast.TP.RACC
    
	--Job Abilities
	sets.precast.JA = {}
		--sets.precast.JA.Scavenge = {feet="Orion Socks +1"}
		--sets.precast.JA.Sharpshot = {hands="Orion Braccae +1"}
		--sets.precast.JA['Bounty Shot'] = { hands="Amini Glove. +1"}
		--sets.precast.JA.Camouflage = {body="Orion Jerkin +1"}
		--sets.precast.JA['Eagle Eye Shot'] = {}
		--sets.precast.JA.Shadowbind = {}
		--sets.precast.JA.Sharpshot = {}
     
	-- sets.precast.FastCast = {main=FC_Main,sub=FC_sub,ammo=FC_ammo,head=FC_head,neck=FC_neck,ear1=FC_ear1,ear2=FC_ear2,body=FC_body,hands=FC_hands,ring1=FC_ring1,ring2=FC_ring2,back=FC_back,waist=FC_waist,legs=FC_legs,feet=FC_feet}
    
-- WS Sets

--Marksmanship 

--Wildfire – 60% AGI. Enmity generation varies with TP. Magic WS needing M. Atk. Bonus and Fire Affinity Magic Damage.
--(COR) Leaden Salute – 100% AGI. Damage varies with TP. Magic WS needing M. Atk. Bonus and Dark Affinity Magic Damage.
--Trueflight – 100% AGI. Damage Varies with TP. Magic WS needing M. Atk. Bonus and Light Affinity Magic Damage.
--(Relic) Coronach – 40% AGI/40% DEX. Temporarily lowers Enmity.
--Last Stand – 73%~85% AGI. Damage varies with TP. 
--Detonator – 70% AGI. Damage Varies with TP.
--Heavy Shot – 70% AGI. Chance of Crit varies with TP.
--Slug Shot – 70% AGI. Accuracy varies with TP.

--Archery

--Jishnu’s Radiance – 80% DEX. Chance to crit varies with TP.
--(Relic) Namas Arrow – 40% STR/40% AGI. Temporarily increases ranged accuracy.
--Apex Arrow – 73~85% AGI. Defense ignored varies with TP.
--Refulgent Arrow – 60% STR. Damage Varies with TP.
--Empyreal Arrow – 50% AGI/20% STR. Damage Varies with TP.
--Arching Arrow – 50% AGI/20% STR. Chance to crit varies with TP.
--Sidewinder – 50% AGI/20% STR. Accuracy varies with TP.

--General WS build, Stack R. Acc and AGI with some STR mixed in to cover most WS

	sets.precast.WS = {
		ammo=TP_Ammo,
		head="Meghanada Visor +1",
		body="Sayadio's Kaftan",
		hands="Meg. Gloves +1",
		legs={ name="Herculean Trousers", augments={'Rng.Acc.+23 Rng.Atk.+23','Enmity-1','AGI+7','Rng.Atk.+15',}},
		feet={ name="Herculean Boots", augments={'Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+2','Rng.Acc.+12','Rng.Atk.+9',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Enervating Earring",		
		right_ear="Moonshade Earring",
		left_ring="Rajas Ring",
		right_ring="Apate Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
		}

--Jishnu’s Radiance – 80% DEX. Chance to crit varies with TP.	
	sets.precast.WS['Jishnu\'s Radiance'] = {
	    	head="Meghanada Visor +1",
		body="Meghanada Cuirie +1",
		hands="Meg. Gloves +1",
		legs={ name="Herculean Trousers", augments={'Rng.Acc.+23 Rng.Atk.+23','Enmity-1','AGI+7','Rng.Atk.+15',}},
		feet="Thereoid Greaves",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Enervating Earring",
		right_ear="Moonshade Earring",
		left_ring="Cacoethic Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
		}
--Sidewinder – 50% AGI/20% STR. Accuracy varies with TP.
	-- sets.precast.WS['Sidewinder'] = set_combine(sets.precast.WS, {neck="Fotia Gorget"})
--Slug Shot – 70% AGI. Accuracy varies with TP.
	-- sets.precast.WS['Slug Shot'] = sets.precast.WS['Sidewinder']
	
--Trueflight – 100% AGI. Damage Varies with TP. Magic WS needing M. Atk. Bonus and Light Affinity Magic Damage.
	sets.precast.WS['Trueflight'] = {
	    	head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12',}},
		body="Samnuha Coat",
		hands="Leyline Gloves",
		legs={ name="Herculean Trousers", augments={'Rng.Acc.+23 Rng.Atk.+23','Enmity-1','AGI+7','Rng.Atk.+15',}},
		feet="Adhemar Gamashes",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Friomisi Earring",
		right_ear="Moonshade Earring",
		left_ring="Apate Ring",
		right_ring="Etana Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
		}	
	
--Wildfire – 60% AGI. Enmity generation varies with TP. Magic WS needing M. Atk. Bonus and Fire Affinity Magic Damage.
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
