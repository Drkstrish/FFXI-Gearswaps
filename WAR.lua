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

	idle_head=
	idle_neck=
	idle_ear1=
	idle_ear2=
	idle_body=
	idle_hands=
	idle_ring1=
	idle_ring2=
	idle_back=
	idle_waist=
	idle_legs=
	idle_feet=
	

	sets.engaged = {}

	sets.ws = {}


---  PRECAST SETS  ---
	sets.precast = {}

	sets.precast.JA = set_combine(sets.midcast.enmity, {})

	sets.precast.JA.Meditate = {}

	sets.precast.JA.Tomahawk = {ammo="Thr. Tomahawk"}

-- WS Sets
	sets.precast.WS = sets.ws

---  MIDCAST SETS  ---
	sets.midcast = {}

---  AFTERCAST SETS  ---
	sets.Idle = {}

	sets.Idle.Current = sets.Idle

	sets.Resting = sets.Idle

	--sets.WakeSleep = {head="Frenzy Sallet"}

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
