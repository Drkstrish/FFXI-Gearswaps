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
	sets.obi.Wind = {}
	sets.obi.Ice = {waist='Hyorin Obi'}
	sets.obi.Lightning = {waist='Rairin obi'}
	sets.obi.Light = {}
	sets.obi.Dark = {waist='Anrin obi'}
	sets.obi.Water = {}
	sets.obi.Earth = {}
	sets.obi.Fire = {}
    
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
		--send_command('input /party Well.... What had happened wuz...')
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
		sets.moving.RDM = {legs="Carmine Cuisses +1"}
		sets.moving.PLD = {legs="Carmine Cuisses +1"}
		--sets.moving.DRK = {legs="Carmine Cuisses +1"}
		sets.moving.RNG = {legs="Carmine Cuisses +1"}
		sets.moving.DRG = {legs="Carmine Cuisses +1"}
		sets.moving.BLU = {legs="Carmine Cuisses +1"}
		--sets.moving.COR = {legs="Carmine Cuisses +1"}
		sets.moving.RUN = {legs="Carmine Cuisses +1"}
		sets.moving.THF = {feet="Jute Boots +1"} -- Get Skadi's Jambeaux +1 to remove Jute Boots +1 from inventory for more jobs
		sets.moving.MNK = {feet="Crier's Gaiters"}		
		sets.moving.BLM = {feet="Crier's Gaiters"}
		--sets.moving.SMN = {feet="Crier's Gaiters"}		
		sets.moving.SCH = {feet="Crier's Gaiters"}	
		sets.moving.WAR = {feet="Hermes' Sandals"}
		--sets.moving.PUP = {feet="Hermes' Sandals"}
		sets.moving.SAM = {feet="Danzo Sune-Ate"}
		--sets.moving.NIN = {feet="Danzo Sune-Ate"}  -- this doesn't werk - need some function to check for day/time><
		--sets.moving.DNC = {feet="Skadi's Jambeaux +1"}
	
	sets.notmoving = {}
		sets.notmoving.RDM = {legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Cure" spellcasting time -8%','Mag. Acc.+14'}}}
		sets.notmoving.PLD = {legs={ name="Valor. Hose", augments={'Accuracy+24 Attack+24','"Store TP"+5','VIT+8','Accuracy+3'}}}
		--sets.notmoving.DRK = {legs={ name="Valor. Hose", augments={'Accuracy+24 Attack+24','"Store TP"+5','VIT+8','Accuracy+3'}}}
		sets.notmoving.RNG = {legs={ name="Herculean Trousers", augments={'Pet: Phys. dmg. taken -1%','"Fast Cast"+3','"Treasure Hunter"+1','Accuracy+11 Attack+11','Mag. Acc.+1 "Mag.Atk.Bns."+1'}}}
		sets.notmoving.DRG = {legs={ name="Valor. Hose", augments={'Accuracy+24 Attack+24','"Store TP"+5','VIT+8','Accuracy+3'}}}
		sets.notmoving.BLU = {legs={ name="Herculean Trousers", augments={'Pet: Phys. dmg. taken -1%','"Fast Cast"+3','"Treasure Hunter"+1','Accuracy+11 Attack+11','Mag. Acc.+1 "Mag.Atk.Bns."+1'}}}
		--sets.notmoving.COR = {legs={ name="Herculean Trousers", augments={'Pet: Phys. dmg. taken -1%','"Fast Cast"+3','"Treasure Hunter"+1','Accuracy+11 Attack+11','Mag. Acc.+1 "Mag.Atk.Bns."+1'}}}
		sets.notmoving.RUN = {legs={ name="Herculean Trousers", augments={'Pet: Phys. dmg. taken -1%','"Fast Cast"+3','"Treasure Hunter"+1','Accuracy+11 Attack+11','Mag. Acc.+1 "Mag.Atk.Bns."+1'}}}
		
		sets.notmoving.THF = { name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5'}}
		sets.notmoving.MNK = { name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5'}}	
		sets.notmoving.BLM = {feet="Inspirited Boots"}
		--sets.notmoving.SMN = {feet="Inspirited Boots"}		
		sets.notmoving.SCH = {feet="Inspirited Boots"}	
		sets.notmoving.WAR = { name="Valorous Greaves", augments={'Accuracy+27','"Store TP"+5','DEX+9','Attack+10'}}
		--sets.notmoving.PUP = { name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5'}}
		sets.notmoving.SAM = { name="Valorous Greaves", augments={'Accuracy+27','"Store TP"+5','DEX+9','Attack+10'}}
		--sets.notmoving.DNC = { name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5'}}
		--sets.notmoving.NIN = {}

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
