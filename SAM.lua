function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
	state.EngagedMode = M{['description']='Engaged Mode', 'Normal','ACC'}
	send_command('bind f9 gs c cycle EngageddMode')
    select_default_macro_book()
	
	-- Set Common Aliases --
	send_command("alias wsset gs equip sets.ws")
	send_command("alias eng gs equip sets.engaged")
	send_command("alias idle gs equip sets.Idle.Current")
	send_command('@wait 1;input /lockstyleset 1')
	
end

	
function init_gear_sets()
    -- Setting up Gear As Variables --

	-- Idle Sets
	
	idle_head="Loess Barbuta +1"
	idle_neck="Loricate Torque +1"
	idle_ear1="Cessance Earring"
	idle_ear2="Dignitary's Earring"
	idle_body="Hiza. Haramaki +1"
	idle_hands={ name="Valorous Mitts", augments={'Accuracy+21 Attack+21','Crit.hit rate+4','Accuracy+10',}}
	idle_ring1="Dark Ring"
	idle_ring2="Defending Ring"
	idle_back="Solemnity Cape"
	idle_waist="Flume Belt +1"
	idle_legs={ name="Valor. Hose", augments={'Accuracy+30','"Store TP"+8','CHR+7',}}
	idle_feet="Danzo Sune-Ate" 
		
		
	engaged_head={ name="Ryuo Somen", augments={'HP+50','Accuracy+15','Attack+15',}}
	engaged_neck="Combatant's Torque"
	engaged_ear1="Cessance Earring"
	engaged_ear2="Dignitary's Earring"
	engaged_body={ name="Valorous Mail", augments={'Accuracy+22 Attack+22','Weapon Skill Acc.+9','STR+2','Accuracy+14','Attack+10',}}
	engaged_hands={ name="Valorous Mitts", augments={'Accuracy+21 Attack+21','Crit.hit rate+4','Accuracy+10',}}
	engaged_ring1="K'ayres Ring"
	engaged_ring2="Rajas Ring"
	engaged_back="Takaha Mantle"
	engaged_waist="Grunfeld Rope"
	engaged_legs={ name="Valor. Hose", augments={'Accuracy+30','"Store TP"+8','CHR+7',}}
	engaged_feet={ name="Valorous Greaves", augments={'Accuracy+23 Attack+23','Enmity+2','STR+8','Accuracy+9','Attack+9',}}
	
	ws_head={ name="Ryuo Somen", augments={'HP+50','Accuracy+15','Attack+15',}}
	ws_neck="Fotia Gorget"
	ws_ear1="Cessance Earring"
	ws_ear2="Digni. Earring"
	ws_body={ name="Valorous Mail", augments={'Accuracy+24 Attack+24','Weapon skill damage +3%','DEX+6','Accuracy+1','Attack+13',}}
	ws_hands={ name="Valorous Mitts", augments={'Accuracy+21 Attack+21','Crit.hit rate+4','Accuracy+10',}}
	ws_ring1="K'ayres Ring"
	ws_ring2="Rajas Ring"
	ws_back="Smertrios's Mantle"
	ws_waist="Fotia Belt"
	ws_legs="Hiza. Hizayoroi +1"
	ws_feet={ name="Valorous Greaves", augments={'Accuracy+23 Attack+23','Enmity+2','STR+8','Accuracy+9','Attack+9',}}
		
	   
	sets.engaged = {ammo=engaged_ammo,head=engaged_head,body=engaged_body,hands=engaged_hands,legs=engaged_legs,feet=engaged_feet,neck=engaged_neck,waist=engaged_waist,ear1=engaged_ear1,ear2=engaged_ear2,ring1=engaged_ring1,ring2=engaged_ring2,back=engaged_back,}
	sets.ws = {ammo=ws_ammo,head=ws_head,body=ws_body,hands=ws_hands,legs=ws_legs,feet=ws_feet,neck=ws_neck,waist=ws_waist,ear1=ws_ear1,ear2=ws_ear2,ring1=ws_ring1,ring2=ws_ring2,back=ws_back,}
	
	
    ---  PRECAST SETS  ---
	sets.precast = {}
    sets.precast.JA = set_combine(sets.midcast.enmity, {})
	sets.precast.JA.Meditate = {back="Smertrios's Mantle",hands={ name="Sakonji Kote", augments={'Enhances "Blade Bash" effect',}},head="Wakido Kabuto +1"}
    
	
	-- WS Sets
	sets.precast.WS = sets.ws
	
    ---  MIDCAST SETS  ---
    sets.midcast = {}
    
    ---  AFTERCAST SETS  ---
    sets.Idle = {ammo=idle_ammo,head=idle_head,neck=idle_neck,ear1=idle_ear1,ear2=idle_ear2,body=idle_body,hands=idle_hands,ring1=idle_ring1,ring2=idle_ring2,back=idle_back,waist=idle_waist,legs=idle_legs,feet=idle_feet}
	sets.Idle.Current = sets.Idle
    sets.Resting = sets.Idle
	
	sets.WakeSleep = {head="Frenzy Sallet"}

end





function job_precast(spell)
    handle_equipping_gear(player.status)
	if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive ['Copy Image (4+)']) then
	  cancel_spell()
	  send_command('@wait 1;')
	  equip(sets.Idle.Current)
	  return
	end
    if sets.precast.JA[spell.name] then
        equip(sets.precast.JA[spell.name])
    elseif string.find(spell.name,'Cur') and spell.name ~= 'Cursna' then
        equip(sets.precast.Cure)
    elseif spell.skill == 'EnhancingMagic' then
        equip(sets.precast.EnhancingMagic)
    elseif spell.action_type == 'Magic' then
        equip(sets.precast.FastCast)
    end
end

function job_post_midcast(spell)
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
    
    handle_equipping_gear(player.status)
    equip(sets.Idle.Current)    
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
    handle_equipping_gear(player.status)
   if (gain_or_loss) then  
     add_to_chat(4,'------- Gained Buff: '..status..'-------')
	 if status == "sleep" then
	   send_command ('input /equip head "Frenzy Sallet"')
	 end
	 if status == "KO" then
	   send_command('input /party These tears... they sting-wing....')
	 end
   else 
     add_to_chat(3,'------- Lost Buff: '..status..'-------')
   end
 end




function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.Idle.Current)
end


function job_handle_equipping_gear(playerStatus, eventArgs)    	
    if buffactive.sleep then
	equip(sets.WakeSleep)
	end

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
	if playerStatus == 'Idle' then
        equip(sets.Idle.Current)
    end
	
end



function select_default_macro_book()
    set_macro_page(2, 1)
end
