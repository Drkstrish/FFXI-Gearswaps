
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function user_setup()
    state.IdleMode:options('Normal','PDT')
	state.TPMode = M{['description']='TP Mode', 'Normal','RACC'}
	state.RngMode = M{['description']='Ranger Mode', 'Archery','Gun','XBow','MagicGun'}
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
	send_command("alias rngtpacc gs equip sets.midcast.TP.ACC")
	send_command("alias sw gs equip sets.ws.SideWinder")
	send_command("alias jr gs equip sets.ws.JishnuRadiance")
	
	
	
end

	
function init_gear_sets()
	
	
	TP_Hands = "Floral Gauntlets"
	
	if state.RngMode.value == 'Archery' then
	  RNGWeapon = "Nobility"
	  TP_Ammo = "Achiyal. Arrow"
	  WS_Ammo = "Achiyal. Arrow"
	  send_command("alias rngws1 input /ws 'Jishnu\'s Radiance' <t>")
	  send_command("alias rngws2 input /ws 'Sidewinder' <t>")
	  send_command("alias rngws3 input /ws 'Apex Arrow' <t>")
	  TP_Hands = "Floral Gauntlets"
	elseif state.RngMode.value == 'Gun' then 
	  RNGWeapon = ""
	  TP_Ammo = ""
	  WS_Ammo = ""
	  send_command("alias rngws1 input /ws 'Slugshot' <t>")
	  send_command("alias rngws2 input /ws 'Trueflight' <t>")
	  send_command("alias rngws3 input /ws 'Wildfire' <t>")
	elseif state.RngMode.value == 'MagicGun' then 
	  RNGWeapon = ""
	  TP_Ammo = ""
	  WS_Ammo = ""
	  send_command("alias rngws1 input /ws 'Trueflight' <t>")
	  send_command("alias rngws2 input /ws 'Wildfire' <t>")
	  send_command("alias rngws3 input /ws 'Slugshot' <t>")
	elseif state.RngMode.value == 'XBow' then
	  RNGWeapon = "Tsoa. Crossbow"
	  TP_Ammo = "Achiyal. Bolt"
	  WS_Ammo = "Achiyal. Bolt"
	  if state.Bolt.value == 'DefDown' then 
		TP_Ammo = "Abrasion Bolt"
	  elseif state.Bolt.value == 'Holy Bolt' then
	    TP_Ammo = "Holy Bolt"
	  elseif state.Bolt.value == 'Bloody Bolt' then
	    TP_Ammo = "Bloody Bolt"
	  end
	  send_command("alias rngws1 input /ws 'Wildfire' <t>")
	  send_command("alias rngws2 input /ws 'Slug Shot' <t>")
	  send_command("alias rngws3 input /ws 'Trueflight' <t>")
	end
	
			
    ---  PRECAST SETS  ---
    sets.precast = {}
	sets.precast.PreShot = {
	    --main="Perun +1",
		--sub="Perun",
		range=RNGWeapon,ammo=TP_Ammo,head="Pursuer's Beret",body= "Pursuer's Doublet",
		hands="Pursuer's Cuffs",legs="Pursuer's Pants",feet="Pursuer's Gaiters",neck="Sanctity Necklace",waist="Impulse Belt",
		left_ear="Neritic Earring",right_ear="Tripudio Earring",left_ring="K'ayres Ring",right_ring="Rajas Ring",back="Lutian Cape",
    }
	sets.precast.PreShot.Overkill = set_combine(sets.precast.PreShot, {})
	
	sets.midcast.TP = {} 
	sets.midcast.TP.normal = {
	--  main="Perun +1",
	--	sub="Perun",
		range=RNGWeapon,ammo=TP_Ammo,head="Adhemar Bonnet",
		body="Adhemar Jacket",hands=TP_Hands,
		legs={ name="Herculean Trousers", augments={'Rng.Acc.+23 Rng.Atk.+23','Enmity-1','AGI+7','Rng.Atk.+15',}},
		feet={ name="Herculean Boots", augments={'Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+2','Rng.Acc.+12','Rng.Atk.+9',}},
		neck="Sanctity Necklace",waist="Eschan Stone",left_ear="Neritic Earring",right_ear="Tripudio Earring",
		left_ring="K'ayres Ring",right_ring="Rajas Ring",back="Lutian Cape"
	}
	sets.midcast.TP.RACC =  set_combine(sets.midcast.TP.Normal, {head="Dampening Tam"})
	sets.Barrage = {}
    
	--Job Abilities
	sets.precast.JA = {}
    sets.precast.JA.Scavenge = {}
	sets.precast.JA['Bounty Shot'] = {}
    sets.precast.JA.Camouflage = {}
    sets.precast.JA['Eagle Eye Shot'] = {}
    sets.precast.JA.Shadowbind = {}
    sets.precast.JA.Sharpshot = {}
     
	-- sets.precast.FastCast = {main=FC_Main,sub=FC_sub,ammo=FC_ammo,head=FC_head,neck=FC_neck,ear1=FC_ear1,ear2=FC_ear2,body=FC_body,hands=FC_hands,ring1=FC_ring1,ring2=FC_ring2,back=FC_back,waist=FC_waist,legs=FC_legs,feet=FC_feet}
    
	-- WS Sets
	sets.precast.WS = {
	    --main="Perun +1",
		--sub="Perun",
		range=RNGWeapon,ammo=TP_Ammo,head="Adhemar Bonnet",body="Adhemar Jacket",
		hands="Floral Gauntlets",
		legs={ name="Herculean Trousers", augments={'Rng.Acc.+23 Rng.Atk.+23','Enmity-1','AGI+7','Rng.Atk.+15',}},
		feet={ name="Herculean Boots", augments={'Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+2','Rng.Acc.+12','Rng.Atk.+9',}},
		neck="Fotia Gorget",waist="Fotia Belt",
		left_ear="Moonshade Earring",right_ear="Neritic Earring",left_ring="K'ayres Ring",right_ring="Rajas Ring",back="Lutian Cape",
	}
	sets.precast.WS['Jishnu\'s Radiance'] = set_combine(sets.precast.WS, {feet="Thereoid Greaves"})
	sets.precast.WS['Sidewinder'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Slug Shot'] = sets.precast.WS['Sidewinder']
	sets.precast.WS['Trueflight'] = {
	    head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12',}},
		body="Herculean Vest",
		hands="Samnuha Coat",
		legs="Pursuer's Pants",
		feet={ name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		neck="Sanctity Necklace",waist="Eschan Stone",left_ear="Friomisi Earring",
		left_ear="Moonshade Earring",
		left_ring="Nekhen Ring",right_ring="Longshot Ring",back="Lutian Cape",
	}
    sets.precast.WS['Wildfire'] = sets.precast.WS['Trueflight']
	
    ---  AFTERCAST SETS  ---
    sets.idle = set_combine(sets.precast.PreShot, {})

	
end

function job_precast(spell)
    handle_equipping_gear(player.status)
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
end        

function job_aftercast(spell)
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


function job_buff_change(status,gain_or_loss)
   if (gain_or_loss) then  
   add_to_chat(4,'------- Gained Buff: '..status..'-------')
   else 
   add_to_chat(3,'------- Lost Buff: '..status..'-------')
   end
    handle_equipping_gear(player.status)
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
