state.SpellDebug = M{['description']='Debug Spells', 'Off', 'On'}
send_command('alias spelldebug gs c cycle spelldebug')

send_command('alias revit input /item "Super Revitalizer" <me>')
send_command('alias pot1 input /item "Lucid Potion I" <me>')
send_command('alias pot2 input /item "Lucid Potion II" <me>')
send_command('alias pot3 input /item "Lucid Potion III" <me>')
send_command('alias eth1 input /item "Lucid Ether I" <me>')
send_command('alias eth2 input /item "Lucid Ether II" <me>')
send_command('alias eth3 input /item "Lucid Ether III" <me>')
send_command('alias elixer1 input /item "Lucid Elixir I" <me>')
send_command('alias elixer2 input /item "Lucid Elixir II" <me>')
send_command('alias wings1 input /item "Lucid Wings I" <me>')
send_command('alias wings2 input /item "Lucid Wings II" <me>')
send_command('alias manamist input /item "Mana Mist" <me>')
send_command('alias hpmist input /item "Healing Mist" <me>')
send_command('alias cat input /item "Catholicon" <me>')
send_command('alias cat1 input /item "Catholicon +1" <me>')
send_command('alias echodrop input /item "Echo Drops" <me>')
send_command('alias remedy input /item "Remedy" <me>')
send_command('alias holywater input /item "Holy Water" <me>')
send_command('alias warpring input /equip ring1 "Warp Ring"')

function check_temp_items()
 local tempitems = windower.ffxi.get_items(3)
  for id,item in pairs(tempitems) do
     print(item)
  end
end


function check_height() 
 selfz = math.floor(windower.ffxi.get_mob_by_index(player.index).z * 10)/10
 targetz = math.floor(windower.ffxi.get_mob_by_index(player.target.index).z * 10)/10
 heightdiff = selfz - targetz
 targdistance = math.floor(windower.ffxi.get_mob_by_index(player.target.index).distance:sqrt() * 10+0.5)/10
 send_command('input /echo My Height:'..selfz..' Target Height:'..targetz..' Height Difference:'..heightdiff..'  Target Distance:'..targdistance..'')
end

function spelldebug(spell)
  skillchainproperties = "None"
  add_to_chat(2,'Spell Type:'..spell.type..'  Ability Type:'..spell.action_type..'')
  if spell.action_type == 'Magic' then
    add_to_chat(2,'-----------Spell Info-----------')
    add_to_chat(2,'Name:'..spell.name..'     Element:'..spell.element..'     Skill:'..spell.skill..'')
	add_to_chat(2,'Base Cast Time:'..spell.cast_time..'     Base Recast:'..spell.recast..'')
	if spell.type ~= 'Ninjutsu' then
	  add_to_chat(2,'MP Cost:'..spell.mp_cost..'')
	end
    if string.find(spell.english,'ga') or buffactive.Accession or buffactive.Manifestation then
	 add_to_chat(2,'Range:'..spell.range..'')
	end
	add_to_chat(2,'-----------Spell End-----------')
  end
  if spell.type == "JobAbility" then
  end
  if spell.type == "WeaponSkill" then
	add_to_chat(2,'-----------WS Info-----------')
	add_to_chat(2,'Name:'..spell.name..'     Spell Skill:'..spell.skill..'')
	add_to_chat(2,'Base TP:'..tpspent..'') -- Does not include bonuses such as Moonshade Earring
	if (#spell.skillchain_a > 1) then
	  skillchainproperties = spell.skillchain_a
	end
	if (#spell.skillchain_b > 1) then
	  skillchainproperties = skillchainproperties ..' '.. spell.skillchain_b
	end
	if (#spell.skillchain_c) then
	  skillchainproperties = skillchainproperties ..' '.. spell.skillchain_c
	end
      add_to_chat(2,'Skillchain Properties:'..skillchainproperties..'') 
  end
  if spell.type == "Scholar" then
    stratrecast = windower.ffxi.get_ability_recasts()[spell.recast_id]
	stratsremaining = math.floor(((165 - stratrecast) / 33) - 1)
	add_to_chat(2,'Remaining Stratagems: '..stratsremaining..'')
  end
  if spell.type == "Monster" then
	add_to_chat(2,'Name:'..spell.name..'')
	send_command('@wait 1;input //gs c showcharges')
  end
  -- add_to_chat(2,'-----------Target Info-----------')
  -- add_to_chat(2,'Target Name:'..spell.target.name..'')
  -- add_to_chat(2,'Target Type:'..spell.target.type..'')
  -- add_to_chat(2,'Model Size:'..spell.target.model_size..'')
  -- add_to_chat(2,'-----------Target End-----------')
end

-- For BST to see how many Charges Remain
function chargesremaining()
    charges = 3
    ready = windower.ffxi.get_ability_recasts()[102]
	if ready ~= 0 then
	  charges = math.floor(((30 - ready) / 10))
	end
	add_to_chat(2,'Ready Recast:'..ready..'   Charges Remaining:'..charges..'')
end

-- Equip Obi based on Weather

function weathercheck(spell_element)
    -- Relevant Obis. Add the ones you have uniquely - or add the Hachirin-no-obi on each
    sets.obi = {}
    sets.obi.Wind = {waist='Hachirin-no-obi'}
    sets.obi.Ice = {waist='Hachirin-no-obi'}
    sets.obi.Lightning = {waist='Hachirin-no-obi'}
    sets.obi.Light = {waist='Hachirin-no-obi'}
    sets.obi.Dark = {waist='Hachirin-no-obi'}
    sets.obi.Water = {waist='Hachirin-no-obi'}
    sets.obi.Earth = {waist='Hachirin-no-obi'}
    sets.obi.Fire = {waist='Hachirin-no-obi'}
    
    -- Generic gear for day/weather
    sets.weather = {back='Twilight Cape'}
    sets.day = {ring1='Zodiac Ring'}
	
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

-- Called whenever you gain or lose a buff.
function job_buff_change(status,gain_or_loss)
   if (gain_or_loss) then  
   add_to_chat(4,'------- Gained Buff: '..status..'-------')
   if status == "KO" then
	   --send_command('input /party These tears... they sting-wing....')
	   send_command('input /party Well.... What had happened wuz...')
   end
   if status == "Sublimation: Complete" then
   equip(sets.Idle.Current)
   end
   else 
   add_to_chat(3,'------- Lost Buff: '..status..'-------')
   if status == "stun" then 
     equip(sets.Idle.Current)
   end
   end
    handle_equipping_gear(player.status)
end

function checkblocking(spell)
	if buffactive.sleep or buffactive.petrification or buffactive.terror then 
	   add_to_chat(3,'Canceling Action - Asleep/Petrified/Terror!')
	   cancel_spell()
	   return
	end 
	if spell.name ~= 'Ranged' and spell.type ~= 'WeaponSkill' and spell.type ~= 'Scholar' then
      if spell.action_type == 'Ability' then
	    if buffactive.Amnesia then
		  cancel_spell()
		  add_to_chat(3,'Canceling Ability - Currently have Amnesia')
		  return
		else
	      recasttime = windower.ffxi.get_ability_recasts()[spell.recast_id] 
          if spell and (recasttime >= 1) then
		    add_to_chat(3,'Ability Canceled:'..spell.name..' - Waiting on Recast:(seconds) '..recasttime..'')
            cancel_spell()
            return
          end
		end
	  end
      if spell.action_type == 'Magic' then
	    if buffactive.Silence then
	      cancel_spell()
		  echodrops = "Echo Drops"
		  numberofecho = player.inventory[echodrops].count
		  if numberofecho < 2 then 
		    add_to_chat(2,'Silenced - Consider using Echo Drops. QTY:'..player.inventory[echodrops].count..'')
		  else 
		    add_to_chat(3,'Silenced - Using Echo Drops.  QTY:'..numberofecho..'')
		    send_command('input /item "Echo Drops" <me>')
		  end
		  return
	    else 
		  if (spell.name == 'Refresh' and (buffactive["Sublimation: Complete"] or buffactive["Sublimation: Activated"]) and spell.target.type == 'SELF') then
		   add_to_chat(3,'Cancel Refresh - Have Sublimation Already')
		   cancel_spell()
		   return
		  end
	      recasttime = windower.ffxi.get_spell_recasts()[spell.recast_id] / 100
          if spell and (recasttime >= 1) then
		   add_to_chat(2,'Spell Canceled:'..spell.name..' - Waiting on Recast:(seconds) '..recasttime..'')
           cancel_spell()
           return
          end
		end
      end
    end
	if spell.type == 'WeaponSkill' and buffactive.Amnesia then
		  cancel_spell()
		  add_to_chat(3,'Canceling Ability - Currently have Amnesia')
		  return	  
	end
	if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive ['Copy Image (4+)']) then
	  cancel_spell()
	  add_to_chat(3,'Canceling Utsusemi - Already have Max and can not override')
	  return
	end
end



--- The following detects movement and automatically equips gear whether you're moving or not.

-- Current Concerns:
-- ** What happens for draw_in & knock-back  (I've somewhat mitigated by adding an engaged check on player.status see player.status ~= engaged below.
-- ** When casting a spell and past the interruption window and start running - you equip the gear pre-midcast finalizing. I think I can 
-- determine if mid-cast maybe with a variable on job_midcast{ CustomStatus = casting} and job_aftercast { CustomStatus = Idle } 
sets.moving = {}
sets.moving.BLM = {feet="Herald's Gaiters"}
sets.moving.SCH = {feet="Herald's Gaiters"}
sets.moving.RNG = {feet="Jute Boots +1"}
sets.moving.SAM = {feet="Danzo Sune-ate"}
--sets.moving.NIN = {feet=gear.MovementFeet.name}  -- this doesn't werk - need some function to check for day/time><
sets.notmoving = {}
sets.notmoving.BLM = {feet="Skaoi Boots"}
sets.notmoving.SCH = {feet="Skaoi Boots"}
sets.notmoving.RNG = {feet={ name="Herculean Boots", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +2%','Rng.Acc.+1','Rng.Atk.+9',}}}
sets.notmoving.SAM = {feet={ name="Valorous Greaves", augments={'Accuracy+23 Attack+23','Enmity+2','STR+8','Accuracy+9','Attack+9',}}}
--sets.notmoving.NIN = {feet={ name="Herculean Boots", augments={'Mag. Acc.+1 "Mag.Atk.Bns."+1','STR+11','Quadruple Attack +2','Accuracy+18 Attack+18',}}}

mov = {counter=0}
if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
    mov.x = windower.ffxi.get_mob_by_index(player.index).x
    mov.y = windower.ffxi.get_mob_by_index(player.index).y
    mov.z = windower.ffxi.get_mob_by_index(player.index).z
end
moving = false
windower.raw_register_event('prerender',function()
    mov.counter = mov.counter + 1;
    if mov.counter>5 then
        local pl = windower.ffxi.get_mob_by_index(player.index)
        if pl and pl.x and mov.x then
            local movement = math.sqrt( (pl.x-mov.x)^2 + (pl.y-mov.y)^2 + (pl.z-mov.z)^2 ) > 0.1
            if movement and not moving then
			    if sets.moving[player.main_job] and player.status ~= "Engaged" then  
                  send_command('gs equip sets.moving.'..player.main_job..'')
				end
				if state.SpellDebug.value == "On" then 
				  send_command('input /echo Moving! Status: '..player.status..'') 
				end
                moving = true
            elseif not movement and moving then
			    if sets.notmoving[player.main_job] and player.status ~= "Engaged" then 
                  send_command('gs equip sets.notmoving.'..player.main_job..'')
				end
				if state.SpellDebug.value == "On" then 
				  send_command('input /echo Stopped Moving! Status: '..player.status..'')
				end
                moving = false
            end
        end
        if pl and pl.x then
            mov.x = pl.x
            mov.y = pl.y
            mov.z = pl.z
        end
        mov.counter = 0
    end
end)
