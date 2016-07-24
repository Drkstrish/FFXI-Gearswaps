-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
	Custom commands:

	gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
	
	Treasure hunter modes:
		None - Will never equip TH gear
		Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
		SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
		Fulltime - Will keep TH gear equipped fulltime

--]]

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff['Sleep'] = buffactive['Sleep'] or false
	state.Buff['Bio'] = buffactive['Bio'] or false
	state.Buff['Sneak Attack'] = buffactive['Sneak Attack'] or false
	state.Buff['Trick Attack'] = buffactive['Trick Attack'] or false
	state.Buff['Feint'] = buffactive['Feint'] or false
	state.Buff["Assassin's Charge"] = buffactive["Assassin's Charge"] or false
	state.Buff['Perfect Dodge'] = buffactive['Perfect Dodge'] or false
	state.Buff['Flee'] = buffactive['Perfect Dodge'] or false
--	state.Buff['Madrigal'] = buffactive['Madrigal'] or false
	state.Buff['Commitment'] = buffactive['Commitment'] or false
	state.Buff['Ionis'] = buffactive['Ionis'] or false
	state.Buff['Reive Mark'] = buffactive['Reive Mark'] or false
	
	include('Mote-TreasureHunter')

	-- For th_action_check():
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'DWmid', 'DWlow', 'DWnone', 'HTBC', 'Acc', 'PDT', 'Salvage', 'MAbsorb')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc')

	--update_combat_form()
	
	jp_zones = S{"Woh Gates"}

	-- Gear Definitions
	gear.JPcape = {name="Mecisto. Mantle", augments={'Cap. Point+50%','VIT+1','Rng.Acc.+3','DEF+6'}}
	gear.Runninshoes = "Jute Boots +1"

	-- gear.Sleep = {}
	-- gear.HasteBelt = {}

	-- Iuitl Set. I have none.
	-- This entire set should be acquired, +1, and aug for DT
	-- Iuitl head is for DT, ta
	-- gear.IHead = {}
	-- Iuitl body is for DT, acc, r.acc, subtle blow
	-- gear.IBody = {}
	-- Iuitl hands is for DT, acc, r.acc, snapshot
	-- Best aug is snapshot 1-3, for Precast ra
	-- gear.IHands = {}
	-- Iuitl legs is for DT, m.acc, mab, stp
	-- gear.ILegs = {}
	-- Iuitl feet is for DT, atk, r.atk, m.acc
	-- gear.IFeet = {}
	
	-- Artifact set. I have none.
	-- Artifact Head has acc, r.acc, crit dmg
	-- gear.AFHead = {}
	-- Artifact Body has acc, crit dmg, aug: Hide
	-- gear.AFBody = {}
	-- Artifact Hands have steal, crit dmg, increased trick dmg
	-- gear.AFHands = {}
	-- Artifact Legs have acc, atk, steal, crit dmg
	-- gear.AFLegs = {}
	-- Artifact Feet have acc, r.acc, steal, movement+12%, aug: Flee
	-- gear.AFFeet = {}
	
	-- Relic set
	-- Relic Head has acc, mug, aug: Aura Steal
	-- gear.RHead = {}
	-- Relic Body has crit rate, crit dmg, aug: Ambush
	-- gear.RBody = {}
	-- Relic Hands have acc, th, aug: Perfect Dodge
	gear.RHands = {name="Plunderer's Armlets +1"}
	-- Relic Legs have acc, gilfinder, aug: Feint
	-- gear.RLegs = {}
	-- Relic Feet have ta, ta dmg, aug: Assassin's Charge
	-- gear.RFeet = {}

	-- Empyrean set
	-- Empyrean set has a unique set bonus which applies with as little as 2 pieces.
	-- Empyrean Head is for ta, aug: Accomplice, aug: Collaborator
	gear.EmpHead = {name="Skulker's Bonnet"}
	-- Empyrean Body is for aug: Conspirator
	-- gear.EmpBody = {}
	-- Empyrean Hands are for sa dmg 
	gear.EmpHands = {name="Skulker's Armlets"}
	-- Empyrean Legs are for crit rate, despoil
	-- gear.EmpLegs = {}
	-- Empyrean Feet are for th, despoil
	-- gear.EmpFeet = {}

	-- Taeon set, all pieces aug: atk or atk/acc, dw, crit - Dont Carry any now that I have lots of Herculean.
	-- Taeon head is for acc, r.acc, crit rate
	-- gear.THead = {}
	-- Taeon body is for atk, r.atk, fast cast
	-- gear.TBody = {}
	-- Taeon hands is for m.acc, mab
	-- gear.THands = {}
	-- Taeon legs is for acc, r.acc, ta
	-- gear.TLegs = {}
	-- Taeon feet is for acc, r.acc, m.acc, dw
	-- gear.TFeet = {}

	-- Pursuer's set. Do not have augmented gear at this time
	-- Pursuer's head is for ratk, marks, stp
	gear.PHead = {name="Pursuer's Beret"}
	-- Pursuer's body is for racc, ratk, stp
	gear.PBody = {name="Pursuer's Doublet"}
	-- Pursuer's hands is for ratk, enm-
	-- gear.PHands = {}
	-- Pursuer's legs is for racc, ratk, rapid shot
	-- gear.PLegs = {}
	-- Pursuer's feet is for racc, enm-
	gear.PFeet = {name="Pursuer's Gaiters"}

	-- Rawhide set
	-- Rawhide head is for atk, refresh
	gear.RawHead = {name="Rawhide Mask", augments={'HP+50','Accuracy+15','Evasion+20'}}
	-- Rawhide body is for acc, atk, matk, ta
	gear.RawBody = "Rawhide Vest"
	-- Rawhide hands is for acc, m.acc, blue magic skill, spell int-
	gear.RawHands = {name="Rawhide Gloves", augments={'HP+50','Accuracy+15','Evasion+20'}}
	-- Rawhide legs is for m.acc, enh magic skill, tactical parry
	gear.RawLegs = {name="Rawhide Trousers", augments={'HP+50','Accuracy+15','Evasion+20'}}
	-- Rawhide feet is for acc, dw, waltz pot
	gear.RawFeet = {name="Rawhide Boots", augments={'HP+50','Accuracy+15','Evasion+20'}}

	-- Herculean set, Triple Attack pile.
	-- Herculean head is for atk, ratk, mab, fc
	gear.HHead3x = {name="Herculean Helm", augments={'Accuracy+14','"Triple Atk."+3','MND+1','Attack+7'}}
	-- Herculean body is for acc, racc, enm-, stp, crit hit rate
	-- gear.HBody3x = {}
	-- Herculean hands is for acc, racc, ta, sb, pdt
	gear.HHands3x = {name="Herculean Gloves", augments={'Accuracy+12','"Triple Atk."+4','STR+6'}}
	-- Herculean legs is for ratk, enm-, stp, pdt
	gear.HLegs3x = {name="Herculean Trousers", augments={'Accuracy+20','"Triple Atk."+3','Attack+9'}}
	-- Herculean feet is for acc, atk, racc, ratk, macc, mab, ta, sb, pdt
	gear.HFeet3x = {name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5'}}

	-- Herculean set, WS Dmg build
	-- Herculean head is for atk, ratk, mab, fc
	-- gear.HHeadWS = {}
	-- Herculean body is for acc, racc, enm-, stp, crit hit rate
	-- gear.HBodyWS = {}
	-- Herculean hands is for acc, racc, ta, sb, pdt
	-- gear.HHandsWS = {}
	-- Herculean legs is for ratk, enm-, stp, pdt
	gear.HLegsWS = {name="Herculean Trousers", augments={'Weapon skill damage +4%','AGI+6','Accuracy+10','Attack+8'}}
	-- Herculean feet is for acc, atk, racc, ratk, macc, mab, ta, sb, pdt
	gear.HFeetWS = {name="Herculean Boots", augments={'Accuracy+25','Weapon skill damage +3%','Attack +7'}}

	-- Herculean set, DW Path stuff
	-- Herculean head is for atk, ratk, mab, fc
	-- gear.HHeadM = {}
	-- Herculean body is for acc, racc, enm-, stp, crit hit rate
	-- gear.HBodyM = {}
	-- Herculean hands is for acc, racc, ta, sb, pdt
	gear.HHandsM = {name="Herculean Gloves", augments={'Accuracy+17','"Dual Wield"+4','MND+8'}}
	-- Herculean legs is for ratk, enm-, stp, pdt
	gear.HLegsM = {name="Herculean Trousers", augments={'Attack+25','"Dual Wield"+4','Accuracy+5',}}
	-- Herculean feet is for acc, atk, racc, ratk, macc, mab, ta, sb, pdt
	-- gear.HFeetM = {}



	gear.AugCanny = {name="Canny Cape", augments={'DEX+4','AGI+1','"Dual Wield"+4','Crit. hit damage +1%'}}

	gear.default.weaponskill_neck = "Clotharius Torque"
	gear.default.weaponskill_waist = "Caudata Belt"

	-- Additional local binds
	send_command('bind ^` input /ja "Flee" <me>')
	send_command('bind ^= gs c cycle treasuremode')
	send_command('bind !- gs c cycle targetmode')
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind ^f9 gs c cycle WeaponSkillMode')

end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^`')
	send_command('unbind !-')
	send_command('unbind f9')
	send_command('unbind ^f9')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Special sets (required by rules)
	--------------------------------------

--	sets.Kiting = back="Solemnity Cape"
--	sets.Kiting = {main="Odium",ring1="Warden's Ring",Head="Rawhide Mask",neck="Sanctity Necklace",Body="Samnuha Coat",feet=gear.Runninshoes}

	sets.TreasureHunter = {hands=gear.RHands}

	sets.ExtraRegen = {}
	sets.Refresh = {body="Mekosuchinae Harness"}
	sets.Roll = {}
	sets.Moonshade = {ear2="Moonshade Earring"}
	sets.Aries = {}
	sets.ProSh = {}

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Sneak Attack'] = {head="Lustratio Cap",body=gear.RawBody,hands=gear.EmpHands,ring1="Apate Ring",ring2="Rajas Ring",
		feet=gear.RawFeet}
	sets.buff['Trick Attack'] = set_combine(sets.buff['Sneak Attack'], {head=gear.Rawhead,
		hands=sets.Refresh,ring1="Apate Ring",ring2="Rajas Ring",back=gear.AugCanny,legs=gear.HlegsWS,feet=gear.Hlegs3x})
	sets.buff["Assassin's Charge"] = {}
	sets.buff['Flee'] = {feet="Jute Boots +1"}
--	sets.buff['Madrigal'] = {ear1="Kuwunga Earring"}
	sets.buff['Sleep'] = {}
	sets.buff['Reive Mark'] = {}
	sets.buff['Commitment'] = {back=gear.JPcape}

	-- Actions we want to use to tag TH.
	sets.precast.Step = {head="Dampening Tam",neck="Maskirova Torque",ear1="Heartseeker Earring",ear2="Steelflash Earring",
		body="Samnuha Coat",hands=gear.Rhands,ring1="Apate Ring",ring2="Beeline Ring",
		back=gear.AugCanny,waist="Olseni Belt",legs=gear.Hlegs3x,feet=gear.HfeetWS}
	sets.precast.Flourish1 = {ammo="Seething Bomblet",
		head="Dampening Tam",neck="Sanctity Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Rahab Ring",ring2="Beeline Ring",
		back=gear.AugCanny,waist="Olseni Belt",legs=gear.Rawlegs,feet=gear.Hfeet3x}
	sets.precast.JA.Provoke = sets.TreasureHunter


	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Collaborator'] = {head=gear.EmpHead}
	sets.precast.JA['Accomplice'] = {head=gear.EmpHead}
	sets.precast.JA['Flee'] = {feet=gear.AFFeet}
	sets.precast.JA['Hide'] = {body=gear.AFBody}
	sets.precast.JA['Conspirator'] = {body=gear.EmpBody}
	sets.precast.JA['Steal'] = {head=gear.RHead,legs=gear.AFLegs,feet=gear.AFFeet}
	sets.precast.JA['Despoil'] = {legs=gear.EmpLegs,feet=gear.EmpFeet}
	sets.precast.JA['Mug'] = sets.buff['Sneak Attack']
	sets.precast.JA['Perfect Dodge'] = {hands=gear.RHands}
	sets.precast.JA['Feint'] = {legs=gear.RLegs}

	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head=gear.Emphead,
		body=gear.RawBody,hands=gear.Rhands,ring2="Petrov Ring",
		waist="Caudata Belt",legs=gear.RawLegs,feet=gear.Rawfeet}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}


	-- Fast cast sets for spells
	sets.precast.FC = {head=gear.HHead3x,neck="Voltsurge Torque",hands="Leyline Gloves",Ear1="Loquacious Earring",Ring1="Rahab Ring",
		legs="Limbo Trousers"}

--	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	-- Ranged snapshot gear
	sets.precast.RA = {}


	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Lustratio Cap",neck="Maskirova Torque",ear1="Brutal Earring",ear2=sets.moonshade,
		body=gear.RawBody,hands=gear.HHands3x,ring1="Apate Ring",ring2="Petrov Ring",
		back=gear.AugCanny,waist="Caudata Belt",legs=gear.HlegsWS,feet=gear.HFeetWS}
	sets.precast.WS.Acc = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = {}
	sets.precast.WS['Exenterator'].Acc = {}
	sets.precast.WS['Exenterator'].Mod = {}
	--sets.precast.WS['Exenterator'].SA = {}
	--sets.precast.WS['Exenterator'].TA = {}
	--sets.precast.WS['Exenterator'].SATA = {}

	sets.precast.WS['Dancing Edge'] = sets.precast.WS
	sets.precast.WS['Dancing Edge'].Acc = sets.precast.WS.Acc
	sets.precast.WS['Dancing Edge'].Mod = sets.precast.WS
	--sets.precast.WS['Dancing Edge'].SA = sets.precast.WS
	--sets.precast.WS['Dancing Edge'].TA = sets.precast.WS.Acc
	--sets.precast.WS['Dancing Edge'].SATA = sets.precast.WS.Acc

	sets.precast.WS['Evisceration'] = sets.precast.WS
	sets.precast.WS['Evisceration'].Acc = sets.precast.WS.Acc
	sets.precast.WS['Evisceration'].Mod = sets.precast.WS
	--sets.precast.WS['Evisceration'].SA = sets.precast.WS.Acc
	--sets.precast.WS['Evisceration'].TA = sets.precast.WS.Acc
	--sets.precast.WS['Evisceration'].SATA = sets.precast.WS.Acc

	-- for checkparam bc ws set will not load
	sets.Rudra = sets.precast.WS.Acc

	sets.Rudra.SA = sets.precast.WS.Acc

	sets.precast.WS["Rudra's Storm"] = sets.Rudra
	sets.precast.WS["Rudra's Storm"].Acc = sets.Rudra
	sets.precast.WS["Rudra's Storm"].Mod = sets.Rudra
	sets.precast.WS["Rudra's Storm"].SA = sets.Rudra.SA
	sets.precast.WS["Rudra's Storm"].TA = sets.Rudra.SA
	sets.precast.WS["Rudra's Storm"].SATA = sets.precast.WS["Rudra's Storm"].SA
	
--	sets.precast.WS['Mercy Stroke'] = {}
--	sets.precast.WS['Mercy Stroke'].Acc = {}
--	sets.precast.WS['Mercy Stroke'].Mod = {}
--	sets.precast.WS["Mercy Stroke"].SA = {}
--	sets.precast.WS["Mercy Stroke"].TA = {}
--	sets.precast.WS["Mercy Stroke"].SATA = {}

	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head=gear.AFHead,ear1="Brutal Earring"})
	sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {ammo="Seething Bomblet", back="Grounded Mantle +1"})
	sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {back="Grounded Mantle +1",waist="Fotia Belt"})
	--sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Yetshila",body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
	--sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Yetshila",body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
	--sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Yetshila",body="Pillager's Vest +1",legs="Pillager's Culottes +1"})

	sets.precast.WS['Mandalic Stab'] = {}
	sets.precast.WS['Mandalic Stab'].Acc = {}
	sets.precast.WS['Mandalic Stab'].Mod = {}
	--sets.precast.WS['Mandalic Stab'].SA = {}
	--sets.precast.WS['Mandalic Stab'].TA = {}
	--sets.precast.WS['Mandalic Stab'].SATA = {}

	-- Aeolian Edge: wind, DEX:40% INT:40%, (pINT-mINT)/2 + 8
	sets.precast.WS['Aeolian Edge'] = {neck="Sanctity Necklace",
		body="Samnuha Coat",hands="Leyline Gloves",back="Argochampsa Mantle",
		legs="Limbo Trousers",feet=gear.HFeetWS}

	--sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Cyclone: who cares, it's TH
	sets.precast.WS['Cyclone'] = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = {}

	-- Specific spells
	sets.midcast.Utsusemi = {}

	-- Ranged gear
	-- Standard TH Set
	sets.midcast.RA = {}
	
	-- Max Racc set for gashing bolts
	sets.midcast.RA.Acc = sets.midcast.RA


	--------------------------------------
	-- Idle/resting/defense sets
	--------------------------------------

	-- Idle sets
	-- body="Mekosuchinae Harness"
	-- body="Mextli Harness"
	-- body="Emet Harness +1"
	sets.idle = {}

	sets.idle.Town = {}
		
	sets.idle.Field = sets.idle

	sets.idle.Weak = {}


	-- Defense sets

	sets.defense.PDT = {}

	sets.defense.MDT = {}

	-- Resting sets

	sets.resting = {}


	--------------------------------------
	-- Melee sets
	--------------------------------------
	--	rather than F9 cycling, i recommend making macros
	--	FORMAT BELOW (Acc example):
	--		/echo Acc set (full accuracy), is that correct?
	--		/ta <stpt>
	--		/console gs c set OffenseMode Acc
	--		/console gs equip sets.engaged.Acc
	--------------------------------------

	-- Normal melee group
	-- No buffs
	-- Assumes Canny, Taeon head/hands/legs/feet have Dual Wield +4-5 aug.
	-- Crit rate (e.g. relic body) will outparse multi-hit (e.g. qaaxo body) options in no-buff situations (e.g. salvage).
	sets.engaged = {head="Dampening Tam",
		neck="Clotharius Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body=gear.RawBody,hands="Hhands3x",ring1="Beeline Ring",ring2="Petrov Ring",
		back=gear.AugCanny,waist="Sarissaphoroi Belt",legs=gear.Hlegs3x,feet=gear.Hfeet3x}

	-- This set provides ~35% DW
	-- Assumes Canny, Taeon head/hands/legs/feet have Dual Wield +4-5 aug.
	sets.engaged.DWmid = {head="Dampening Tam",
		neck="Clotharius Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body=gear.RawBody,hands="Hhands3x",ring1="Beeline Ring",ring2="Petrov Ring",
		back=gear.AugCanny,waist="Sarissaphoroi Belt",legs=gear.Hlegs3x,feet=gear.Hfeet3x}
	-- This set provides ~20% DW
	sets.engaged.DWlow = {head="Dampening Tam",
		neck="Clotharius Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body=gear.RawBody,hands="Hhands3x",ring1="Beeline Ring",ring2="Petrov Ring",
		back=gear.AugCanny,waist="Sarissaphoroi Belt",legs=gear.Hlegs3x,feet=gear.Hfeet3x}
	-- This set provides NO DW
	-- Mandau/Jugo +1 needs no DW with capped haste
	sets.engaged.DWnone = {head="Dampening Tam",
		neck="Clotharius Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body=gear.RawBody,hands="Hhands3x",ring1="Beeline Ring",ring2="Petrov Ring",
		back=gear.AugCanny,waist="Sarissaphoroi Belt",legs=gear.Hlegs3x,feet=gear.Hfeet3x}

	-- Utility set for high-tier fights
	-- Assumes buffs, haste, and behind mob
	sets.engaged.HTBC = {head="Dampening Tam",
		neck="Clotharius Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body=gear.RawBody,hands="Hhands3x",ring1="Beeline Ring",ring2="Petrov Ring",
		back=gear.AugCanny,waist="Sarissaphoroi Belt",legs=gear.Hlegs3x,feet=gear.Hfeet3x}
	-- Acc with DW15
	sets.engaged.Acc = {head="Dampening Tam",
		neck="Clotharius Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body=gear.RawBody,hands="Hhands3x",ring1="Beeline Ring",ring2="Petrov Ring",
		back=gear.AugCanny,waist="Sarissaphoroi Belt",legs=gear.Hlegs3x,feet=gear.Hfeet3x}
	-- PDT with a little Acc
	sets.engaged.PDT = {head="Dampening Tam",
		neck="Clotharius Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body=gear.RawBody,hands="Hhands3x",ring1="Beeline Ring",ring2="Petrov Ring",
		back=gear.AugCanny,waist="Sarissaphoroi Belt",legs=gear.Hlegs3x,feet=gear.Hfeet3x}

	-- Any non-mandau main with sub Atoyac (oat/crit rate aug) for delve and skirmish
	-- No magical or debuff add'l effects

	-- Salvage set, for use with drain samba
	-- Jugo Kukri's add'l effect is not overwritten by drain samba

	sets.engaged.Salvage = {head="Dampening Tam",
		neck="Clotharius Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body=gear.RawBody,hands="Hhands3x",ring1="Beeline Ring",ring2="Petrov Ring",
		back=gear.AugCanny,waist="Sarissaphoroi Belt",legs=gear.Hlegs3x,feet=gear.Hfeet3x}

	-- Fire Absorb, for Cerberus
	sets.engaged.MAbsorb = {}

	-- STP
	-- Theoretical, for CP
	-- options: [iuitl head, THandsTA], [THeadDW, Aeto gloves]

--	sets.engaged.STP = {}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	--if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
		--equip(sets.TreasureHunter)
	--elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
		--if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
			--equip(sets.TreasureHunter)
		--end
	--end
	if spell.type:lower() == 'weaponskill' then
--		if buffactive['Madrigal'] then
--			equip(sets.buff['Madrigal'])
--		end
		if spell.english == "Rudra's Storm" then
			if buffactive['Sneak Attack'] then
				equip(sets.precast.WS["Rudra's Storm"].SA)
			end
			if buffactive['Trick Attack'] then
				equip(sets.precast.WS["Rudra's Storm"].TA)
			end
		end
		if buffactive["Assassin's Charge"] then
			equip(sets.buff["Assassin's Charge"])
		end
		if (player.tp > 1749 and player.tp < 2000) or (player.tp > 2749 and player.tp < 3000) then
			equip(sets.Moonshade)
		end
	end
	if buffactive['Reive Mark'] then
		equip(sets.buff['Reive Mark'])
	end
	if buffactive['Ionis'] and jp_zones:contains(world.area) then
		equip(sets.buff['Commitment'])
	end
	if buffactive['Commitment'] or buffactive["Corsair's Roll"] then
		equip(sets.buff['Commitment'])
	end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
		equip(sets.TreasureHunter)
	end
	if buffactive['Reive Mark'] then
		equip(sets.buff['Reive Mark'])
	end
	if buffactive['Ionis'] and jp_zones:contains(world.area) then
		equip(sets.buff['Commitment'])
	end
	if buffactive['Commitment'] or buffactive["Corsair's Roll"] then
		equip(sets.buff['Commitment'])
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	-- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
	if spell.type == 'WeaponSkill' and not spell.interrupted then
		state.Buff['Sneak Attack'] = false
		state.Buff['Trick Attack'] = false
		state.Buff['Feint'] = false
		state.Buff["Assassin's Charge"] = false
	end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
	-- If Feint is active, put that gear set on on top of regular gear.
	-- This includes overlaying SATA gear.
	check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

--function get_custom_wsmode(spell, spellMap, defaut_wsmode)
--	local wsmode

--	if buffactive['Sneak Attack'] then
--		wsmode = 'SA'
--	end
--	if buffactive['Trick Attack'] then
--		wsmode = (wsmode or '') .. 'TA'
--	end
--	return wsmode
--end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
	-- Check that ranged slot is locked, if necessary
	check_range_lock()

	-- Check for SATA when equipping gear.
	-- If either is active, equip that gear specifically, and block equipping default gear.
	check_buff('Sneak Attack', eventArgs)
	check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
	if player.hpp < 80 then
		idleSet = set_combine(idleSet, sets.ExtraRegen)
	end
	
	if player.mpp < 30 then
		idleSet = set_combine(idleSet, sets.Refresh)
	end
	
	if buffactive["Dancer's Roll"] or buffactive["Evoker's Roll"] or buffactive["Corsair's Roll"] or buffactive["Bolter's Roll"] then
		idleSet = set_combine(idleSet, sets.Roll)
	end
	
	if buffactive["Fighter's Roll"] or buffactive["Rogue's Roll"] or buffactive["Hunter's Roll"] or buffactive["Chaos Roll"] then
		idleSet = set_combine(idleSet, sets.Roll)
	end
	
	if buffactive["Wizard's Roll"] or buffactive["Warlock's Roll"] or buffactive["Caster's Roll"] or buffactive["Courser's Roll"] then
		idleSet = set_combine(idleSet, sets.Roll)
	end
	
	if buffactive["Samurai Roll"] or buffactive["Blitzer's Roll"] or buffactive["Tactician's Roll"] or buffactive["Miser's Roll"] then
		idleSet = set_combine(idleSet, sets.Roll)
	end
	if buffactive['Flee'] then
		idleSet = set_combine(idleSet, sets.buff['Flee'])
	end
	if buffactive['Sleep'] then
		idleSet = set_combine(idleSet, sets.Aries)
	end
	if buffactive['Reive Mark'] then
		idleSet = set_combine(idleSet, sets.buff['Reive Mark'])
	end
	if buffactive['Ionis'] and jp_zones:contains(world.area) then
		idleSet = set_combine(idleSet, sets.buff['Commitment'])
	end
	if buffactive['Commitment'] or buffactive["Corsair's Roll"] then
		idleSet = set_combine(idleSet, sets.buff['Commitment'])
	end
	if not state.Buff['Protect'] and not state.Buff['Shell'] then
		idleSet = set_combine(idleSet, sets.ProSh)
	end
	return idleSet
end


function customize_melee_set(melee_set)
	if state.TreasureMode.value == 'Fulltime' then
		melee_set = set_combine(melee_set, sets.TreasureHunter)
	end
	if state.OffenseMode ~= Acc then
		if player.mp < 100 then
			melee_set = set_combine(melee_set, {ring1="Petrov Ring"})
		end
	end
	if buffactive['Reive Mark'] then
		melee_set = set_combine(melee_set, sets.buff['Reive Mark'])
	end
	if buffactive['Ionis'] and jp_zones:contains(world.area) then
		melee_set = set_combine(melee_set, sets.buff['Commitment'])
	end
	if buffactive['Commitment'] or buffactive["Corsair's Roll"] then
		melee_set = set_combine(melee_set, sets.buff['Commitment'])
	end
	if buffactive['Sleep'] then
		if buffactive['Bio'] then
			melee_set = set_combine(melee_set, sets.Aries)
		else
			melee_set = set_combine(melee_set, sets.buff['Sleep'])
		end
	end
	return melee_set
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	th_update(cmdParams, eventArgs)
	--update_combat_form()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local msg = 'Melee'
	
	if state.CombatForm.has_value then
		msg = msg .. ' (' .. state.CombatForm.value .. ')'
	end
	
	msg = msg .. ': '
	
	msg = msg .. state.OffenseMode.value
	if state.HybridMode.value ~= 'Normal' then
		msg = msg .. '/' .. state.HybridMode.value
	end
	msg = msg .. ', WS: ' .. state.WeaponskillMode.value
	
	if state.DefenseMode.value ~= 'None' then
		msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
	end
	
	if state.Kiting.value == true then
		msg = msg .. ', Kiting'
	end

	if state.PCTargetMode.value ~= 'default' then
		msg = msg .. ', Target PC: '..state.PCTargetMode.value
	end

	if state.SelectNPCTargets.value == true then
		msg = msg .. ', Target NPCs'
	end
	
	msg = msg .. ', TH: ' .. state.TreasureMode.value

	add_to_chat(122, msg)

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
	if state.Buff[buff_name] then
		equip(sets.buff[buff_name] or {})
		if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
		eventArgs.handled = true
	end
end

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
	if category == 2 or -- any ranged attack
		category == 4 or -- any magic action
		--(category == 3 and param == 30) or -- Aeolian Edge
		(category == 6 and info.default_ja_ids:contains(param)) --or -- Provoke, Animated Flourish
		--(category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
		then return true
	end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
	if player.equipment.range ~= 'empty' then
		disable('range', 'ammo')
	else
		enable('range', 'ammo')
	end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 6)
	elseif player.sub_job == 'WAR' then
		set_macro_page(1, 6)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 6)
	else
		set_macro_page(1, 6)
	end
end
