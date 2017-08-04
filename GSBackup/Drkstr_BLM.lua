function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end
function user_setup()
-- General Gearswap Commands:
-- F10 Changes Idle Mode
-- Ctrl+F11 = Magical Mode Change

  state.CastingMode:options('Normal', 'MACC','MagicBurst','StoreTP')
  
  state.IdleMode:options('Normal','PDT','Death')
  
	state.TPMode = M{['description']='TP Mode', 'Normal', 'WeaponLock'}
  
	state.SuperTank = M{['description']='Super Tank Mode','Off','On'}
  
	send_command('alias tank gs c cycle SuperTank')
	send_command('alias tp gs c cycle tpmode')
	send_command('bind f10 gs c cycle idlemode')
	send_command('bind f12 gs c update CastingMode')
  
	select_default_macro_book()
	send_command('@wait 1;input /lockstyleset 20')
  
	-- Set Common Aliases --
	send_command("alias idle gs equip sets.Idle.Current")
	send_command("alias fc gs equip sets.precast.FastCast")
	send_command("alias enh gs equip sets.midcast['Enhancing Magic']")
	send_command("alias ele gs equip sets.midcast['Elemental Magic'].Main")
	send_command("alias macc gs equip sets.midcast['Elemental Magic'].MACC")
	send_command("alias storetp gs equip sets.midcast['Elemental Magic'].StoreTP")
	send_command("alias magicburst gs equip sets.midcast['Elemental Magic'].MagicBurst")
	send_command("alias enf gs equip sets.midcast['Enfeebling Magic']")
	send_command("alias dark gs equip sets.midcast['Dark Magic']")
	send_command("alias deathset gs equip sets.midcast['Dark Magic'].DeathMagicBurst")
	send_command("alias cureset gs equip sets.midcast['Healing Magic']")
	send_command("alias regen gs equip sets.midcast.Regen")
	send_command("alias myrkrset gs equip sets.precast.WS['Myrkr']")
	send_command("alias manawallset gs equip sets.precast.JA['Mana Wall']")

end
function init_gear_sets()
  include('augmented-items.lua')

	-- Weapon Locks used for TP Mode.  When WeaponLock is set - it locks in the following Main and SUB. 
	weaponlock_main=gear.Grioavolr
	weaponlock_sub="Enki Strap"

  sets.ele = {}
  sets.enh = {}
  sets.precast = {}
  sets.precast.JA = {}
  
  sets.precast.JA['Mana Wall'] = 
{
  main=gear.Grioavolr,
  sub="Enki Strap", 
  ammo="Elis Tome",
  head=gear.Vanya.head,
  body=gear.Mallquis.Body,
  hands=gear.Vanya.hands,
  legs=gear.Amalric.legs,
  feet=gear.BLMEmpy.Feet,
  neck="Loricate Torque +1",
  waist="Fucho-no-Obi",
  left_ear="Etiolation Earring",
  right_ear="Odnowa Earring +1",
  left_ring="Patricius Ring",
  right_ring="Defending Ring",
  back=gear.AmbJSE.BLMMP
}

  sets.precast.FastCast =         --60FC 9QM
{   
  main=gear.Grioavolr,            --4FC
  sub="Enki Strap",               --0
  ammo="Impatiens",               --2QC
  head=gear.Merlinichead.FC,      --14FC
  body="Shango Robe",             --8FC
  hands=gear.Merlinichands.FC,    --5FC
  legs=gear.Psycloth.legs,        --7FC
  feet=gear.Merlinicfeet.Refresh, --5FC
  neck="Orunmila's Torque",       --5FC
  waist="Witful Belt",            --3FC3QC
  right_ear="Loquac. Earring",     --2FC
  left_ear="Etiolation Earring", --1FC
  left_ring="Kishar Ring",        --4FC
  right_ring="Rahab Ring",        --2FC
  back="Perimede Cape"            --4QC
}
  
  sets.precast.EnhancingMagic = 
  set_combine(sets.precast.Fastcast,
  {waist="Siegel Sash"})
  
  sets.precast.Stoneskin = set_combine(sets.precast.EnhancingMagic,
  {head="Umuthi Hat"})
  
	sets.precast.Cure = sets.precast.FastCast

	sets.meva = {}

	-- WS Sets
	sets.precast.WS = {}
  
	-- Max MP set
  sets.precast.WS['Myrkr'] = 
{
  ammo="Elis Tome",
  head=gear.Vanya.head,
  body=gear.Amalric.body,
  hands=gear.Vanya.hands,
  legs=gear.Amalric.legs,
  feet=gear.Amalric.feet,
  neck="Sanctity Necklace",
  waist="Luminary Sash",
  right_ear="Loquac. Earring",
  left_ear="Etiolation Earring",
  left_ring="Lebeche Ring",
  right_ring="Etana Ring",
  back={ name="Bane Cape", augments={'Elem. magic skill +9','Dark magic skill +5','"Mag.Atk.Bns."+2','"Fast Cast"+4',}},
} 
	
  ---  MIDCAST SETS  ---
  
  sets.midcast = {}
  
  sets.midcast['Elemental Magic'] = {}
	
  sets.midcast['Elemental Magic'].Main = 
{    
  main=gear.Grioavolr,
  sub="Enki Strap",
  ammo="Pemphredo Tathlum",
  head=gear.Merlinichead.FC,
  body="Spae. Coat +1",
  hands=gear.Amalric.hands,
  legs=gear.Merliniclegs.OA,
  feet=gear.BLMAF.Feet,
  neck="Sanctity Necklace",
  waist="Channeler's Stone",
  left_ear="Friomisi Earring",
  right_ear="Regal Earring",
  left_ring="Resonance Ring",
  right_ring="Vertigo Ring",
  back=gear.AmbJSE.BLMINT
}
  
	
  sets.midcast['Elemental Magic'].MACC = 
{
  main=gear.Grioavolr,
  sub="Enki Strap",
  ammo="Pemphredo Tathlum",
  head=gear.Merlinichead.FC,
  body=gear.Merlinicbody.MB,
  hands=gear.Amalric.hands,
  legs=gear.Merliniclegs.OA,
  feet=gear.BLMAF.Feet,
  neck="Erra Pendant",
  waist="Channeler's Stone",
  left_ear="Digni. Earring",
  right_ear="Regal Earring",
  left_ring="Resonance Ring",
  right_ring="Vertigo Ring",
  back=gear.AmbJSE.BLMINT
}

  
	sets.midcast['Elemental Magic'].StoreTP = 
  set_combine(sets.midcast['Elemental Magic'].Main, 
  {})

	sets.midcast.Impact = 
  set_combine(sets.midcast['Elemental Magic'].Main, 
  {})

	sets.midcast['Elemental Magic'].MagicBurst = --51 MB Total
{    
  ammo="Pemphredo Tathlum",
  head=gear.Merlinichead.FC,    
  body=gear.Merlinicbody.MB,    --10
  hands=gear.Amalric.hands,     --5
  legs=gear.Merliniclegs.MB,    --9
  feet=gear.BLMAF.Feet,         --5
  neck="Mizu. Kubikazari",      --10
  waist="Refoccilation Stone",  
  left_ear="Digni. Earring",    
  right_ear="Regal Earring",    
  left_ring="Mujin Band",       --5
  right_ring="Vertigo Ring",
  back=gear.AmbJSE.BLMINT       --5
}

  sets.midcast['Dark Magic'] = 
{
  ammo="Pemphredo Tathlum",
  head="Pixie Hairpin +1",
  body="Shango Robe",
  hands=gear.Amalric.hands,
  legs="Spae. Tonban +1",
  feet=gear.BLMAF.Feet,
  neck="Erra Pendant",
  waist="Eschan Stone",
  right_ear="Regal Earring",
  left_ear="Digni. Earring",
  left_ring="Archon Ring",
  right_ring="Kishar Ring",
  back=gear.ReiveJSE.BLM
}
  
	sets.midcast.Stun = 
  set_combine(sets.midcast['Dark Magic'], 
  {})    
  
  sets.midcast['Dark Magic'].Death = 
{    
  ammo="Pemphredo Tathlum",
  head="Pixie Hairpin +1",
  body="Spae. Coat +1",
  hands=gear.Amalric.hands,
  legs=gear.Merliniclegs.OA,
  feet=gear.BLMAF.Feet,
  neck="Sanctity Necklace",
  waist="Refoccilation Stone",
  left_ear="Friomisi Earring",
  right_ear="Regal Earring",
  left_ring="Archon Ring",
  right_ring="Vertigo Ring",
  back=gear.AmbJSE.BLMMP
}

	sets.midcast['Dark Magic'].DeathMagicBurst = 
{
  head="Pixie Hairpin +1",
  back=gear.AmbJSE.BLMMP,
  ring1="Archon Ring"
}

  sets.midcast['Enfeebling Magic'] = {}
  
  sets.midcast['Healing Magic'] = {}
  
  sets.midcast['Enhancing Magic'] = 
{
  
}
  
  sets.midcast.RefreshRecieved = 
set_combine(sets.midcast['Enhancing Magic'],
{
  waist="Gishdubar Sash",
  feet="Inspirited Boots"
})

  sets.midcast.Regen = 
set_combine(sets.midcast['Enhancing Magic'],
{
  main="Bolelabunga"
})

sets.midcast.Cure = sets.midcast['Healing Magic']
  
sets.midcast.CurePotencyRecieved = 
set_combine(sets.midcast.Cure,{waist="Siegel Sash"})
  
sets.midcast.Stoneskin = 
set_combine(sets.midcast['Enhancing Magic'],{waist="Siegel Sash",neck="Nodens Gorget"})
  
  ---  AFTERCAST SETS  ---
  
  sets.Idle = {}
  
	sets.Idle.Main = 
{    
  ammo="Elis Tome",
  head="Befouled Crown",
  body="Jhakri Robe +1",
  hands=gear.Merlinichead.FC,
  legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
  feet="Crier's Gaiters",
  neck="Sanctity Necklace",
  waist="Fucho-no-Obi",
  right_ear="Regal Earring",
  left_ear="Etiolation Earring",
  left_ring="Defending Ring",
  right_ring="Paguroidea Ring",
  back="Moonbeam Cape"
}
  
	sets.Idle.PDT = 
{    
  ammo="Elis Tome",
  head="Befouled Crown",
  body="Mallquis Saio +1",
  hands={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
  legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
  feet="Mallquis Clogs +1",
  neck="Loricate Torque +1",
  waist="Fucho-no-Obi",
  right_ear="Infused Earring",
  left_ear="Etiolation Earring",
  left_ring="Defending Ring",
  right_ring="Paguroidea Ring",
  back="Moonbeam Cape"
}
  
	sets.Idle.Manawall = 
  set_combine(sets.Idle.PDT,
  {feet=gear.BLMEmpy.Feet})
	
	sets.Idle.Death = sets.precast.FastCast
	sets.Idle.Current = sets.Idle.Main

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
    if spell.type == 'WeaponSkill' and buffactive['Mana Wall'] then
	   equip(sets.Idle.Manawall)
	end
	
    if spell.name == 'Impact' then
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
    if spell.name == "Mana Wall" then 
	   equip(sets.Idle.Manawall)
	end
    if string.find(spell.english,'Cur') then 
        equip(sets.midcast.Cure)
		if spell.target.type == 'SELF' then
		 equip(sets.midcast.CurePotencyRecieved)
		end
        weathercheck(spell.element)
    elseif spell.skill=="Elemental Magic" then
		if state.CastingMode.value == "MACC" then
	     equip(sets.midcast['Elemental Magic'].MACC)
		elseif state.CastingMode.value == "StoreTP" then
	     equip(sets.midcast['Elemental Magic'].StoreTP)
		elseif state.CastingMode.value == "MagicBurst" then
		 if player.equipment.main == 'Khatvanga' then
		   equip(sets.midcast['Elemental Magic'].MagicBurst,{feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+7%','Mag. Acc.+13','"Mag.Atk.Bns."+3',}},})
		 else 
	       equip(sets.midcast['Elemental Magic'].MagicBurst)
		 end
		else 
         equip(sets.midcast['Elemental Magic'].Main)
		end
		if spell.english == 'Impact' then
		 equip(set_combine(sets.midcast['Elemental Magic'].StoreTP,{head=empty,body="Twilight Cloak"}))
         weathercheck(spell.element)
		end 
        if sets.ele[spell.element] then equip(sets.ele[spell.element]) end
          weathercheck(spell.element)
	elseif spell.english == 'Death' then
		if state.CastingMode.value == "MagicBurst" then
	      equip(sets.midcast['Dark Magic'].DeathMagicBurst)
		else
          equip(sets.midcast['Dark Magic'].Death)
		end
        weathercheck(spell.element)	
		if state.IdleMode.value ~= 'Death' then
		  add_to_chat(2,'----- You could have done more Damage if you changed your Idle Mode!!! ------')
		end
    elseif spell.english == 'Stoneskin' then
        equip(sets.midcast.Stoneskin)
	elseif spell.english == 'Refresh' then
		if spell.target.type == 'SELF' then
		 equip(sets.midcast.RefreshRecieved)
		end	
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingMagic)
        if string.find(spell.english,'Regen') then
                equip(sets.midcast.Regen)
        end
    elseif spell.skill == 'Enfeebling Magic' then
	    equip(sets.midcast['Enfeebling Magic'])
		weathercheck(spell.element)
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
	handle_equipping_gear(player.status)
	equip(sets.Idle.Current)    
	if spell.name == "Mana Wall" then 
	   equip(sets.Idle.Manawall)
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
    equip(sets.Idle.Current)
end


function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.Idle.Current)
end


function job_handle_equipping_gear(playerStatus, eventArgs)    

	if buffactive["Mana Wall"] then
		-- add_to_chat(8,'Mana wall is On')
	    sets.Idle.Current = sets.Idle.Manawall
		if state.SuperTank.value == "On" then
		 equip(sets.Idle.Current)
		 disable("main","sub","ranged","ammo","head","neck","ear1","ear2","body","hands","ring1","ring2","back","waist","legs","feet")
		else
		 enable("main","sub","ranged","ammo","head","neck","ear1","ear2","body","hands","ring1","ring2","back","waist","legs","feet")
		end
	else 
	  enable("ranged","ammo","head","neck","ear1","ear2","body","hands","waist","legs","feet")
	  disable_specialgear()
	  if state.TPMode.value == "WeaponLock" then
	   equip({main=weaponlock_main,sub=weaponlock_sub})
	   disable("main")
	   disable("sub")
	  else
	    enable("main")
	    enable("sub")
	  end	
	  if state.IdleMode.value == "PDT" then
   	   sets.Idle.Current = sets.Idle.PDT
	  elseif state.IdleMode.value == "Death" then
	   sets.Idle.Current = sets.Idle.Death
	  else
	   sets.Idle.Current = sets.Idle.Main
	  end
    end	
    
end



function job_self_command(command)

end


function select_default_macro_book()
    set_macro_page(3, 2)
end