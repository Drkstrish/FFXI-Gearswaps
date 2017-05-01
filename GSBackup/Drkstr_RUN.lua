-- updated 2/22/17

function get_sets()
  
  mote_include_version = 2

  include('Mote-Include.lua')

end
function user_setup()
  

  
  state.OffenseMode = M{['description']='Engaged Mode', 'Normal','ACC','DT'} -- f9 to cycle
  select_default_macro_book()
	
	-- Set Common Aliases --
	send_command("alias wsset gs equip sets.ws")
	send_command("alias dt gs equip sets.dt")
	send_command("alias eng gs equip sets.engaged")
	send_command("alias meva gs equip sets.meva")
	send_command("alias idle gs equip sets.Idle.Current")
	send_command('@wait 5;input /lockstyleset 27')
	
end
function init_gear_sets()
	
  include('augmented-items.lua')

	sets.dt = {}
  
	sets.engaged = 
{    
  ammo="Ginsen",
  head=gear.Dampening.Cap,
  body=gear.Adhemar.body,
  hands=gear.Herculeanhands.Triple,
  legs=gear.Samnuhalegs,
  feet=gear.Herculeanfeet.Triple,
  neck="Anu Torque",
  waist="Windbuffet Belt +1",
  left_ear="Cessance Earring",
  right_ear="Sherida Earring",
  left_ring="Niqmaddu Ring",
  right_ring="Epona's Ring",
  back=gear.AmbJSE.RUNTP
}
  
	sets.engaged.DT = {}
  
	sets.ws = 
{    
  ammo="Mantoptera Eye",
  head=gear.Lustratio.head,
  body=gear.Lustratio.body,
  hands=gear.Herculeanhands.Triple,
  legs=gear.Samnuhalegs,
  feet=gear.Lustratio.legs,
  neck="Fotia Gorget",
  waist="Fotia Belt",
  left_ear="Brutal Earring",
  right_ear="Sherida Earring",
  left_ring="Niqmaddu Ring",
  right_ring="Epona's Ring",
  back=gear.AmbJSE.RUNTP
}
	
	sets.enmity = {}
	
  ---  PRECAST SETS  ---
	
  sets.precast = {}
	
	sets.precast.FastCast = 
{    
  ammo="Impatiens",
  head=gear.Carmine.head,
  body=gear.Samnuhabody.FC,
  hands=gear.Leyline.NotCap,
  legs=gear.Rawhide.legs,
  feet=gear.Carmine.feet,
  neck="Orunmila's Torque",
  waist="Windbuffet Belt +1",
  left_ear="Cessance Earring",
  right_ear="Loquac. Earring",
  left_ring="Rahab Ring",
  right_ring="Kishar Ring",
  back=gear.AmbJSE.RUNTP
}
	
  sets.precast.JA = set_combine(sets.enmity, {})
  
  sets.precast.JA['Lunge'] = 
{    
  ammo="Pemphredo Tathlum",
  head=gear.Herculeanhead.Magic,
  body=gear.Herculeanbody.Magic,
  hands=gear.Carmine.hands,
  legs=gear.Herculeanlegs.Magic,
  feet=gear.Herculeanfeet.Magic,
  neck="Sanctity Necklace",
  waist="Luminary Sash",
  left_ear="Friomisi Earring",
  right_ear="Hermetic Earring",
  left_ring="Vertigo Ring",
  right_ring="Etana Ring",
  back=gear.ReiveJSE.RUN
}
  sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']  
  
  sets.precast.JA['Vallation'] = {}
  sets.precast.JA['Valiance'] = {}
  sets.precast.JA['Pflug'] = {}
  sets.precast.JA['Battuta'] = {}
  sets.precast.JA['Liement'] = {}
  sets.precast.JA['Gambit'] = {}
  sets.precast.JA['Rayke'] = {}
  sets.precast.JA['Elemental Sforzo'] = {}
	sets.precast.JA['Swordplay'] = {}
	sets.precast.JA['Embolden'] = {}
	sets.precast.JA['Vivacious Pulse'] = {}
	sets.precast.JA['One For All'] = {}

	sets.meva = {}
	
	-- WS Sets
	sets.precast.WS = sets.ws
	
  ---  MIDCAST SETS  ---
  
  sets.midcast = {}

  ---  AFTERCAST SETS  ---
  sets.Idle = 
{
  ammo="Ginsen",
  head=gear.Dampening.Cap,
  body=gear.Herculeanbody.Crit,
  hands=gear.Carmine.hands,
  legs=gear.Carmine.legs,
  feet=gear.Carmine.feet,
  neck="Loricate Torque +1",
  waist="Flume Belt +1",
  left_ear="Etiolation Earring",
  right_ear="Odnowa Earring +1",
  left_ring="Defending Ring",
  right_ring="Patricius Ring",
  back="Solemnity Cape"
}
	
	sets.Idle.Current = sets.Idle
  
  sets.Resting = sets.Idle
	
	sets.WakeSleep = {head="Frenzy Sallet"}
	
  sets.ProtectBuff = {}

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

function job_post_precast(spell)
	if player.tp < 2750 and spell.type == 'WeaponSkill' then
		windower.add_to_chat(10,"Adding in Moonshade Earring for more TP:"..player.tp)
		equip({left_ear="Moonshade Earring"})
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
--	if state.SpellDebug.value == "On" then 
  --    spelldebug(spell)
--	end
    
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
	   equip(sets.WakeSleep)
	 end
	 if status == "KO" then
	   send_command('input /party These tears... they sting-wing....')
	 end
   else 
     add_to_chat(3,'------- Lost Buff: '..status..'-------')
   end
 end

 function job_self_command(command)

end




function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.Idle.Current)
end


--function job_handle_equipping_gear(playerStatus, eventArgs)    	
--	disable_specialgear()
 --   if buffactive.sleep then
--		equip(sets.WakeSleep)
--	end
--	if playerStatus == 'Idle' then
   --     equip(sets.Idle.Current)
   -- end
	--sets.Idle.Current = sets.Idle
--end
function select_default_macro_book()
    set_macro_page(9, 1)
end
