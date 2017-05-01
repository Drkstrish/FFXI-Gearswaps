-- not using atm, mostly sitting here

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
      state.Arrow = M{['description']='Arrow Mode','Normal','Bodkin'}
      state.Bullet = M{['description']='Bullet','Normal','Stun'}
	
  send_command('alias tp gs c cycle tpmode')
	send_command('alias rngmode gs c cycle rngmode')
	send_command('alias boltmode gs c cycle Bolt')
	
  send_command('bind f9 gs c cycle RngMode')
	send_command('bind !f9 gs c cycle Arrow')
	send_command('bind ^f9 gs c cycle Bolt')
	send_command('bind ^f10 gs c cycle Bullet')
  
  send_command('bind f10 gs c cycle idlemode')
	
  select_default_macro_book()
	
  if player.sub_job == 'NIN' then
    send_command('@wait 1;input /equip sub "Perun"')   
	end
    send_command('@wait 1;input /lockstyleset 2')
	
	
	-- Set Common Aliases --
  
  send_command("alias fc gs equip sets.precast.FastCast")
	send_command("alias preshot gs equip sets.precast.PreShot")
	send_command("alias rngtp gs equip sets.midcast.TP.normal")
	send_command("alias rngtpacc gs equip sets.midcast.TP.RACC")
	send_command("alias wsset gs equip sets.precast.WS")
	send_command("alias mwsset gs equip sets.precast.WS['Trueflight']")
	send_command("alias jr gs equip sets.precast.WS['Jishnu\'s Radiance']")
	add_to_chat(2,'Ranged Weapon:'..player.equipment.range)
	
  if player.equipment.range == "Steinthor" then
		send_command("gs c set RngMode Archery")
		send_command("dp bow")
	elseif player.equipment.range == "Fomalhaut" then
		send_command("gs c set RngMode Gun")
		send_command("dp gun")
	elseif player.equipment.range == "Wochowsen" then
		send_command("gs c set RngMode XBow")
		send_command("dp marksmanship")
	end
	
end

	
function init_gear_sets()
	
	if state.RngMode.value == 'Archery' then
		RNGWeapon = "Steinthor"
		TP_Ammo = "Eminent Arrow"
		WS_Ammo = "Achiyalabopa Arrow"
    
      if state.Arrow.value == 'Bodkin' then
        TP_Ammo = "Bodkin Arrow"
        WS_Ammo = "Bodkin Arrow"
        
	  end
    
	  send_command("alias rngws1 input /ws 'Jishnu\'s Radiance' <t>")
	  send_command("alias rngws2 input /ws 'Namas Arrow' <t>")
	  send_command("alias rngws3 input /ws 'Apex Arrow' <t>")
	  
	elseif state.RngMode.value == 'Gun' then 
	  RNGWeapon = "Fomalhaut"
	  TP_Ammo="Chrono Bullet"
	  WS_Ammo="Chrono Bullet"
	  
      if state.Bullet.value == 'Stun' then
        TP_Ammo="Spartan Bullet"
        WS_Ammo="Spartan Bullet"
	  
    end
	  
    send_command("alias rngws1 input /ws 'Trueflight' <t>")
	  send_command("alias rngws2 input /ws 'Last Stand' <t>")
	  send_command("alias rngws3 input /ws 'Trueflight' <t>")
    
	elseif state.RngMode.value == 'XBow' then
	  RNGWeapon = "Wochowsen"
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
    head="Amini Gapette +1", -- 7 Snapshot
    body="Amini Caban +1", -- 7 Velocity Shot, Set bonus with hat for Rapid Shot
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, -- 11 Rapid 8 Snap
    legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}}, -- 10 Rapid 9 Snap 
    feet="Meg. Jam. +1", -- 8 Snapshot
    neck="Marked Gorget",
    waist="Impulse Belt", -- 3 Snapshot
    left_ear="Neritic Earring",
    right_ear="Enervating Earring",
    left_ring="Cacoethic Ring",
    right_ring="Cacoethic Ring +1",
    back={ name="Lutian Cape", augments={'STR+3','AGI+5','"Store TP"+1','"Snapshot"+3',}} -- 3 Snapshot
		}
	
  sets.precast.PreShot.Overkill = set_combine(sets.precast.PreShot, {})
	
	sets.midcast.TP = {} 
	sets.midcast.TP.normal =   {
    range=RNGWeapon,
    ammo=TP_Ammo,
    head="Meghanada Visor +1",
    body="Meg. Cuirie +1",
    hands="Meg. Gloves +1",
    legs="Meg. Chausses +1",
    feet="Meg. Jam. +1",
    neck="Marked Gorget",
    waist="Eschan Stone",
    left_ear="Neritic Earring",
    right_ear="Enervating Earring",
    left_ring="Cacoethic Ring",
    right_ring="Cacoethic Ring +1",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}}
  }

	sets.midcast.TP.RACC = 
  {
    range=RNGWeapon,
    ammo=TP_Ammo,
    head={ name="Arcadian Beret +1", augments={'Enhances "Recycle" effect',}},
    body={ name="Pursuer's Doublet", augments={'HP+50','Crit. hit rate+4%','"Snapshot"+6',}},
    hands="Adhemar Wristbands",
    legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}}, 
    feet={ name="Adhemar Gamashes", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},  
    neck="Ocachi Gorget",
    waist="Eschan Stone",
    left_ear="Neritic Earring",
    right_ear="Enervating Earring",
    left_ring="Rajas Ring",
    right_ring="Apate Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}}
  }
  
	sets.Barrage = {hands="Orion Bracers +1"}
    
	--Job Abilities
	sets.precast.JA = {}
  --sets.precast.JA.Scavenge = {feet="Orion Socks +1"}
	sets.precast.JA.Sharpshot = {hands="Orion Braccae +1"}
	--sets.precast.JA['Bounty Shot'] = { hands="Amini Glove. +1"}
  --sets.precast.JA.Camouflage = {body="Orion Jerkin +1"}
  sets.precast.JA['Eagle Eye Shot'] = {legs="Arcadian Braccae +1"}
  sets.precast.JA.Shadowbind = sets.Barrage
     
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
    body="Meg. Cuirie +1",
    hands="Mummu Wrists +1",
    legs="Meg. Chausses +1",
    feet="Meg. Jam. +1",
    neck="Marked Gorget",
    waist="Eschan Stone",
    left_ear="Neritic Earring",
    right_ear="Enervating Earring",
    left_ring="Cacoethic Ring",
    right_ring="Cacoethic Ring +1",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	}
  
  sets.precast.WS.RACC = {}
  --{
  --ammo=TP_Ammo,
  --head="Meghanada Visor +1",
  --body="Meg. Cuirie +1",
  --hands="Meg. Gloves +1",
  --legs={ name="Herculean Trousers", augments={'Rng.Acc.+23 Rng.Atk.+23','Enmity-1','AGI+7','Rng.Atk.+15',}},
  --feet={ name="Herculean Boots", augments={'Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+2','Rng.Acc.+12','Rng.Atk.+9',}},
  --neck="Fotia Gorget",
  --waist="Fotia Belt",
  --left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
  --right_ear="Enervating Earring",
  --left_ring="Cacoethic Ring +1",
  --right_ring="Apate Ring",
  --back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
  --}

  
	sets.precast.WS['Jishnu\'s Radiance'] = {
		ammo=TP_Ammo,
    head="Meghanada Visor +1",
		body="Meg. Cuirie +1",
		hands="Meg. Gloves +1",
    legs="Meg. Chausses +1",
		feet="Thereoid Greaves",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Enervating Earring",
		left_ring="Apate Ring",
		right_ring="Rajas Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	}
  
	sets.precast.WS['Trueflight'] = {
    head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12',}},
    body={ name="Herculean Vest", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','STR+10','Mag. Acc.+15','"Mag.Atk.Bns."+12',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Enmity-5','AGI+3','Mag. Acc.+12','"Mag.Atk.Bns."+11',}},
    feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    right_ear="Friomisi Earring",
    left_ring="Etana Ring",
    right_ring="Vertigo Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	}
  
    sets.precast.WS['Wildfire'] = sets.precast.WS['Trueflight']
	
    ---  AFTERCAST SETS  ---
  sets.idle = {
    head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
    body="Sayadio's Kaftan",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring",
    left_ring="Defending Ring",
    right_ring="Patricius Ring",
    back="Solemnity Cape"
  }
	sets.Idle = sets.idle
	sets.Idle.Current = sets.Idle

	
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
	if spell.type == "WeaponSkill" and state.TPMode.value == 'RACC' then
		if sets.precast.WS[spell.name].RACC then 
			equip(sets.precast.WS[spell.name].RACC)
		else
			equip(sets.precast.WS.RACC)
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
	disable_specialgear()
end



function select_default_macro_book()
    set_macro_page(4, 1)
end
