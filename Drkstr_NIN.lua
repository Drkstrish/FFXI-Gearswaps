-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- gs c toggle hastemode -- Toggles whether or not you're getting Haste II

function get_sets()
	
	mote_include_version = 2
		
		include('Mote-Include.lua')
		include('organizer-lib')
		
end

-- Setup vars that are user-independent.

function job_setup()
	
	state.Buff.Migawari = buffactive.migawari or false
	state.Buff.Sange = buffactive.sange or false
	state.Buff.Innin = buffactive.innin or false
		
		include('Mote-TreasureHunter')
	
	state.TreasureMode:set('Tag')
	state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi' }
	state.Runes = M{['description']='Runes', "Ignis", "Gelus", "Flabra", "Tellus", "Sulpor", "Unda", "Lux", "Tenebrae"}
	state.UseRune = M(false, 'Use Rune')
		
		run_sj = player.sub_job == 'RUN' or false
		
		select_ammo()
	
	LugraWSList = S{'Blade: Shun', 'Blade: Ku', 'Blade: Jin'}
	
	state.CapacityMode = M(false, 'Capacity Point Mantle')
	
		gear.RegularAmmo = 'Happo Shuriken'
		gear.SangeAmmo = 'Happo Shuriken'
		
		wsList = S{'Blade: Hi'}
		
		update_combat_form()
	
	state.warned = M(false)
		
		options.ammo_warning_limit = 25

-- For th_action_check():

-- JA IDs for actions that always have TH: Provoke, Animated Flourish

		info.default_ja_ids = S{35, 204}

-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
		
		info.default_u_ja_ids = S{201, 202, 203, 205, 207}

end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.

function user_setup()

-- Options: Override default values

	state.OffenseMode:options('Normal', 'Low', 'Mid', 'Acc')
	state.HybridMode:options('Normal', 'PDT')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'Acc')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')

--select_default_macro_book()

	send_command('bind ^= gs c cycle treasuremode')
	send_command('bind ^[ input /lockstyle on')
	send_command('bind ![ input /lockstyle off')
	send_command('bind != gs c toggle CapacityMode')
	send_command('bind @f9 gs c cycle HasteMode')
	send_command('bind @[ gs c cycle Runes')
	send_command('bind ^] gs c toggle UseRune')

end

function file_unload()

	send_command('unbind ^[') 
	send_command('unbind ![')
	send_command('unbind ^=')
	send_command('unbind !=')
	send_command('unbind @f9')
	send_command('unbind @[')

	end

-- Define sets and vars used by this job file.
-- visualized at http://www.ffxiah.com/node/194 (not currently up to date 10/29/2015)
-- Happo
-- Hachiya
--sets.engaged[state.CombatForm][state.CombatWeapon][state.OffenseMode][state.HybridMode][classes.CustomMeleeGroups (any number)
-- Ninjutsu tips
-- To stick Slow (Hojo) lower earth resist with Raiton: Ni
-- To stick poison (Dokumori) or Attack down (Aisha) lower resist with Katon: Ni
-- To stick paralyze (Jubaku) lower resistence with Huton: Ni

function init_gear_sets()

--------------------------------------
-- Augments
--------------------------------------

	Andartia = {} --JSE Cape
		--Andartia.DEX = {name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
		--Andartia.AGI = { name="Andartia's Mantle", augments={'AGI+20','Accuracy+9 Attack+9','Weapon skill damage +10%',}}

	Chironic = {} -- WHM/RDM/BRD/SCH
		--Chironic.Head = "Chironic Hat"
		--Chironic.Body = {}
		--Chironic.Hands = "Chironic Gloves"
		--Chironic.Legs = "Chironic Hose"
		--Chironic.Feet = "Chironic Slippers"
			
	Merlinic = {} -- BLM/RDM/SMN/SCH/GEO
		--Merlinic.Head - Have 2
		--Merlinic.Body - Have 1
		--Merlinic.Hands - Have 2
		--Merlinic.Legs - Have 2
		--Merlinic.Feet - Have 3
		
	Odyssean = {} -- WAR/PLD/DRK
		--Odyssean.Head - Have 1
		--Odyssean.Body 
		--Odyssean.Hands - Have 2
		--Odyssean.Legs - Have 1
		--Odyssean.Feet - Have 1
				
	Valorous = {} -- WAR/PLD/DRK/BST/SAM/DRG
		--Valorous.Head - Have 3
		--Valorous.Body - Have 1
		--Valorous.Hands - Have 1
		--Valorous.Legs	- Have 2
		--Valorous.Feet - Have 1
	
	Herculean = {} -- MNK/THF/RNG/NIN/BLU/COR/PUP/DNC/RUN
		Herculean.Head = {}
			Herculean.Head.RNG = { name="Herculean Helm", augments={'Rng.Acc.+28','"Subtle Blow"+1','DEX+1','Rng.Atk.+15'}}
			Herculean.Head.Magic = { name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12'}}
		Herculean.Body = {}
			Herculean.Body.Crit = { name="Herculean Vest", augments={'Accuracy+28','Crit.hit rate+5','DEX+5','Attack+12'}}
		Herculean.Hands = {}
			Herculean.Hands.Crit = { name="Herculean Gloves", augments={'Accuracy+16','Crit.hit rate+5','DEX+1'}}
			Herculean.Hands.Triple = { name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9'}}
		Herculean.Legs = {}
			Herculean.Legs.Acc = { name="Herculean Trousers", augments={'Accuracy+14 Attack+14','DEX+9','Accuracy+15','Attack+14'}}
			Herculean.Legs.RNG = { name="Herculean Trousers", augments={'Rng.Acc.+23 Rng.Atk.+23','Enmity-1','AGI+7','Rng.Atk.+15'}}
			Herculean.Legs.Triple = { name="Herculean Trousers", augments={'Attack+27','"Triple Atk."+4','AGI+4','Accuracy+15'}}
		Herculean.Feet = {}
		    Herculean.Feet.Magic = { name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20'}}
			Herculean.Feet.RNG = { name="Herculean Boots", augments={'Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+2','Rng.Acc.+12','Rng.Atk.+9'}}
			Herculean.Feet.Triple = { name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5'}}
	
	Rao = {} -- MNK/SAM/NIN/PUP
		Rao.Head = { name="Rao Kabuto", augments={'STR+10','DEX+10','Attack+15'}}
		Rao.Body = {}
		Rao.Hands = "Rao Kote"
		Rao.Legs = { name="Rao Haidate", augments={'STR+10','DEX+10','Attack+15'}}
		Rao.Feet = "Rao Sune-Ate"
			
	Ryuo = {} -- MNK/SAM/NIN/PUP
		Ryuo.Head = { name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15'}}
		Ryuo.Body = {}
		Ryuo.Hands = { name="Ryuo Tekko", augments={'DEX+10','Accuracy+20','"Dbl.Atk."+3'}}
		Ryuo.Legs = { name="Ryuo Hakama", augments={'STR+10','DEX+10','Accuracy+15'}}
		Ryuo.Feet = { name="Ryuo Sune-Ate", augments={'STR+10','DEX+10','Accuracy+15'}}
			
	Adhemar = {} -- MNK/THF/RNG/NIN/BLU/COR/DNC/RUN
		Adhemar.Head = { name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15'}}
		Adhemar.Body = { name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15'}}
		Adhemar.Hands = {}
		Adhemar.Legs = {}
		Adhemar.Feet  = {}
		
	Amalric = {} -- BLM/RDM/SMN/BLU/SCH/GEO
		--Amalric.Head = {}
		--Amalric.Body = "Amalric Doublet"
		--Amalric.Hands = "Amalric Gages"
		--Amalric.Legs = "Amalric Slops"
		--Amalric.Feet = {}
		
	Apogee = {} -- SMN
		--Apogee.Head = {}
		--Apogee.Body = {}
		--Apogee.Hands = {}
		--Apogee.Legs = {}
		--Apogee.Feet = {}
		
	Argosy = {} -- WAR/DRK/BST
		--Argosy.Head = "Argosy Celata"
		--Argosy.Body = {}
		--Argosy.Hands = "Argosy Mufflers"
		--Argosy.Legs = "Argosy Breeches"
		--Argosy.Feet = "Argosy Sollerets"
		
	Carmine = {} -- RDM/PLD/DRK/RNG/DRG/BLU/COR/RUN
		--Carmine.Head = {}
		--Carmine.Body = {}
		--Carmine.Hands = "Carmine Fin. Ga."
		--Carmine.Legs = "Carmine Cuisses +1"
		--Carmine.Feet = "Carmine Greaves"
		
	Emicho = {} -- WAR/PLD/DRK/BST/DRG
		--Emicho.Head = "Emicho Coronet"
		--Emicho.Body = {}
		--Emicho.Hands = "Emicho Gauntlets"
		--Emicho.Legs = "Emicho Hose"
		--Emicho.Feet = "Emicho Gamabieras"
				
	Kaykaus = {}
		--Kaykaus.Head
		--Kaykaus.Body
		--Kaykaus.Hands
		--Kaykaus.Legs
		--Kaykaus.Feet
		
	Lustratio = {} -- WAR/THF/PLD/DRK/BST/BRD/DRG/DNC/RUN
		--Lustratio.Head = "Lustratio Cap"
		--Lustratio.Body = "Lustratio Harness"
		--Lustratio.Hands = "Lustratio Mittens"
		--Lustratio.Legs = "Lustratio Subligar"
		--Lustratio.Feet = "Lustratio Leggings"
		
	Souveran = {} -- WAR/PLD
		--Souveran.Head
		--Souveran.Body
		--Souveran.Hands
		--Souveran.Legs
		--Souveran.Feet
		
	Eschite = {} -- WAR/PLD/DRK
		--Eschite.Head
		--Eschite.Body
		--Eschite.Hands
		--Eschite.Legs = "Eschite Cuisses"
		--Eschite.Feet = "Eschite Greaves"
		
	Despair = {} -- WAR/RDM/PLD/DRK/BST/RNG/SAM/DRG/BLU/RUN
		--Despair.Head = "Despair Helm"
		--Despair.Body = "Despair Mail"
		--Despair.Hands = "Despair Fin. Gaunt."
		--Despair.Legs = "Despair Cuisses"
		--Despair.Feet = "Despair Greaves"
		
	Naga = {} -- MNK/SAM/NIN/PUP
		Naga.Head = "Naga Somen"
		Naga.Body = "Naga Samue"
		Naga.Hands = "Naga Tekko"
		Naga.Legs = "Naga Hakama" -- Augmented
		Naga.Feet = "Naga Kyahan"
		
	Rawhide = {} -- MNK/THF/RNG/NIN/BLU/COR/DNC/RUN
		Rawhide.Head = "Rawhide Mask" -- Augmented
		Rawhide.Body = "Rawhide Vest" -- Augmented
		Rawhide.Hands = "Rawhide Gloves" -- Augmented
		Rawhide.Legs = "Rawhide Trousers" -- Augmented
		Rawhide.Feet = "Rawhide Boots" -- Augmented
		
	Pursuers = {} -- THF/RNG/NIN/COR
		Pursuers.Head = { name="Pursuer's Beret", augments={'AGI+10','"Rapid Shot"+10','"Subtle Blow"+7'}}
		Pursuers.Body = { name="Pursuer's Doublet", augments={'HP+50','Crit. hit rate+4%','"Snapshot"+6'}}
		Pursuers.Hands = { name="Pursuer's Cuffs", augments={'AGI+10','"Rapid Shot"+10','"Subtle Blow"+7'}}
		Pursuers.Legs = { name="Pursuer's Pants", augments={'AGI+10','"Rapid Shot"+10','"Subtle Blow"+7'}}
		Pursuers.Feet = { name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15'}}
		
	Psycloth = {} -- BLM/RDM/SMN/BLU/SCH/GEO
		--Psycloth.Head = "Psycloth Tiara"
		--Psycloth.Body = "Psycloth Vest"
		--Psycloth.Hands = "Psycloth Manillas"
		--Psycloth.Legs = "Psycloth Lappas"
		--Psycloth.Feet = "Psycloth Boots"
		
	Vanya = {} -- WHM/BLM/RDM/BRD/SMN/SCH/GEO
		--Vanya.Head = "Vanya Hood"
		--Vanya.Body = "Vanya Robe"
		--Vanya.Hands = "Vanya Cuffs"
		--Vanya.Legs = "Vanya Slops"
		--Vanya.Feet = "Vanya Clogs"
	
	Acro = {} -- WAR/PLD/DRK/BST/SAM/DRG
		--Acro.Head - Have 1
		--Acro.Body - Have 3
		--Acro.Hands - Have 2
		--Acro.Legs 
		--Acro.Feet - Have 2
	
	Taeon = {} -- MNK/RDM/THF/BST/NIN/DRG/BLU/COR/PUP/DNC/RUN
		--Taeon.Head - Have 1
		--Taeon.Body - Have 2
		--Taeon.Hands - Have 2
		--Taeon.Legs - Have 2
		--Taeon.Feet - Have 3
	
-------------------------------------
-- Job Abilties
--------------------------------------

	sets.precast.JA['Mijin Gakure'] = {}
	sets.precast.JA['Futae'] = {}
	sets.precast.JA['Provoke'] = {}
	sets.precast.JA.Sange = {}

-- Waltz (chr and vit)

	sets.precast.Waltz = {}

-- Don't need any special gear for Healing Waltz.

	sets.precast.Waltz['Healing Waltz'] = {}

-- Set for acc on steps, since Yonin drops acc a fair bit

	sets.precast.Step = {}
	sets.midcast.Trust = {}
	sets.midcast["Apururu (UC)"] = {}

--------------------------------------
-- Utility Sets for rules below
--------------------------------------
   	sets.TreasureHunter = {waist="Chaac Belt"}
	sets.CapacityMantle =  {back="Mecistopins Mantle"}
	sets.WSDayBonus = {head="Gavialis Helm"}
	--sets.WSBack = {back="Trepidity Mantle"}
	--sets.BrutalLugra = {ear1="Cessance Earring",ear2="Lugra Earring +1"}
	--sets.BrutalTrux = {ear1="Cessance Earring",ear2="Trux Earring"}
	sets.BrutalMoon = { ear1="Brutal Earring",ear2="Moonshade Earring"}
	--sets.Rajas = {ring1="Haverton Ring"}
	sets.RegularAmmo = {ammo=gear.RegularAmmo}
	sets.SangeAmmo = {ammo=gear.SangeAmmo}
	sets.NightAccAmmo = {ammo="Ginsen"}
	sets.DayAccAmmo = {ammo="Ginsen"}
--------------------------------------
-- Ranged
--------------------------------------
    sets.precast.RA = {Head=Pursuers.Head,Body=Pursuers.Body,Hands=Pursuers.Hands,Legs=Pursuers.Legs,Feet=Pursuers.Feet}
	sets.midcast.RA = {}
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {})
	sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)
-- Fast cast sets for spells
	sets.precast.FC = {}
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
-- Midcast Sets
	sets.midcast.FastRecast = {}
-- skill ++ 
	sets.midcast.Ninjutsu = {}
-- any ninjutsu cast on self
	sets.midcast.SelfNinjutsu = sets.midcast.Ninjutsu
	sets.midcast.Utsusemi = set_combine(sets.midcast.Ninjutsu, {})
   	sets.midcast.Migawari = set_combine(sets.midcast.Ninjutsu, {})
-- Nuking Ninjutsu (skill & magic attack)
	sets.midcast.ElementalNinjutsu = {}
-- Effusions
	sets.precast.Effusion = {}
	sets.precast.Effusion.Lunge = sets.midcast.ElementalNinjutsu
	sets.precast.Effusion.Swipe = sets.midcast.ElementalNinjutsu
	sets.idle = {}
	sets.idle.Regen = set_combine(sets.idle, {})
    	sets.idle.Town = set_combine(sets.idle, {})
--sets.idle.Town.Adoulin = set_combine(sets.idle.Town, {})
	sets.idle.Weak = sets.idle
-- Defense sets
	sets.defense.PDT = {}
    	sets.defense.MDT = set_combine(sets.defense.PDT, {})
    	--sets.DayMovement = {feet="Danzo sune-ate"}
	--sets.NightMovement = {feet="Hachiya Kyahan +1"}
	--sets.Organizer = {}
-- Normal melee group without buffs
	sets.engaged = {}
-- assumptions made about targe
	sets.engaged.Low = set_combine(sets.engaged, {})
	sets.engaged.Mid = set_combine(sets.engaged.Low, {})
	sets.engaged.Acc = set_combine(sets.engaged.Mid, {})
-- set for fooling around without dual wield
	sets.NoDW = set_combine(sets.engaged, {})
    	sets.engaged.Innin = set_combine(sets.engaged, {})
	sets.engaged.Innin.Low = set_combine(sets.engaged.Innin, {})
	sets.engaged.Innin.Mid = set_combine(sets.engaged.Innin.Low, {})
	sets.engaged.Innin.Acc = sets.engaged.Acc
-- Defenseive sets
	sets.NormalPDT = {}
	sets.AccPDT = {}
	sets.engaged.PDT = set_combine(sets.engaged, sets.NormalPDT)
	sets.engaged.Low.PDT = set_combine(sets.engaged.Low, sets.NormalPDT)
	sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.NormalPDT)
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.AccPDT)
	sets.engaged.Innin.PDT = set_combine(sets.engaged.Innin, sets.NormalPDT, {})
	sets.engaged.Innin.Low.PDT = set_combine(sets.engaged.Innin.Low, sets.NormalPDT, {})
	sets.engaged.Innin.Mid.PDT = set_combine(sets.engaged.Innin.Mid, sets.NormalPDT, {})
	sets.engaged.Innin.Acc.PDT = set_combine(sets.engaged.Innin.Acc, sets.AccPDT)
	sets.engaged.HastePDT = {}
-- Delay Cap from spell + songs alone
	sets.engaged.MaxHaste = set_combine(sets.engaged, {})
-- Base set for hard content
	sets.engaged.Low.MaxHaste = set_combine(sets.engaged.MaxHaste, {})
	sets.engaged.Mid.MaxHaste = set_combine(sets.engaged.Low.MaxHaste, {})
	sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, {})
-- do nothing here
	sets.engaged.Innin.MaxHaste = sets.engaged.MaxHaste
	sets.engaged.Innin.Low.MaxHaste = sets.engaged.Low.MaxHaste
	sets.engaged.Innin.Mid.MaxHaste = sets.engaged.Mid.MaxHaste
	sets.engaged.Innin.Acc.MaxHaste = sets.engaged.Acc.MaxHaste
-- Defensive sets
	sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.HastePDT)
	sets.engaged.Low.PDT.MaxHaste = set_combine(sets.engaged.Low.MaxHaste, sets.engaged.HastePDT)
	sets.engaged.Mid.PDT.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, sets.engaged.HastePDT)
	sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged.Acc.MaxHaste, sets.AccPDT)
	sets.engaged.Innin.PDT.MaxHaste = set_combine(sets.engaged.Innin.MaxHaste, sets.NormalPDT)
	sets.engaged.Innin.Low.PDT.MaxHaste = set_combine(sets.engaged.Innin.Low.MaxHaste, sets.NormalPDT)
	sets.engaged.Innin.Mid.PDT.MaxHaste = set_combine(sets.engaged.Innin.Mid.MaxHaste, sets.NormalPDT)
	sets.engaged.Innin.Acc.PDT.MaxHaste = sets.engaged.Acc.PDT.MaxHaste
-- 35% Haste 
	sets.engaged.Haste_35 = set_combine(sets.engaged.MaxHaste, {})
	sets.engaged.Low.Haste_35 = set_combine(sets.engaged.Low.MaxHaste, {})
	sets.engaged.Mid.Haste_35 = set_combine(sets.engaged.Mid.MaxHaste, {})
	sets.engaged.Acc.Haste_35 = set_combine(sets.engaged.Acc.MaxHaste, {})
	sets.engaged.Innin.Haste_35 = set_combine(sets.engaged.Haste_35, {})
	sets.engaged.Innin.Low.Haste_35 = set_combine(sets.engaged.Low.Haste_35, {})
	sets.engaged.Innin.Mid.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, {})
	sets.engaged.Innin.Acc.Haste_35 = sets.engaged.Acc.Haste_35
	sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.Haste_35, sets.engaged.HastePDT)
	sets.engaged.Low.PDT.Haste_35 = set_combine(sets.engaged.Low.Haste_35, sets.engaged.HastePDT)
	sets.engaged.Mid.PDT.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, sets.engaged.HastePDT)
	sets.engaged.Acc.PDT.Haste_35 = set_combine(sets.engaged.Acc.Haste_35, sets.engaged.AccPDT)
	sets.engaged.Innin.PDT.Haste_35 = set_combine(sets.engaged.Innin.Haste_35, sets.engaged.HastePDT)
	sets.engaged.Innin.Low.PDT.Haste_35 = set_combine(sets.engaged.Innin.Low.Haste_35, sets.engaged.HastePDT)
	sets.engaged.Innin.Mid.PDT.Haste_35 = set_combine(sets.engaged.Innin.Mid.Haste_35, sets.engaged.HastePDT)
	sets.engaged.Innin.Acc.PDT.Haste_35 = sets.engaged.Acc.PDT.Haste_35
-- 30% Haste
	sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_35, {})
	sets.engaged.Low.Haste_30 = set_combine(sets.engaged.Haste_30, {})
	sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Low.Haste_30, {})
	--sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Acc.Haste_35, {})
	sets.engaged.Acc.Haste_30 = sets.engaged.Acc.MaxHaste 
	sets.engaged.Innin.Haste_30 = set_combine(sets.engaged.Haste_30, {})
	sets.engaged.Innin.Low.Haste_30 = set_combine(sets.engaged.Low.Haste_30, {})
	sets.engaged.Innin.Mid.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, {})
	sets.engaged.Innin.Acc.Haste_30 = sets.engaged.Acc.Haste_30
	sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.HastePDT)
	sets.engaged.Low.PDT.Haste_30 = set_combine(sets.engaged.Low.Haste_30, sets.engaged.HastePDT)
	sets.engaged.Mid.PDT.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, sets.engaged.HastePDT)
	sets.engaged.Acc.PDT.Haste_30 = set_combine(sets.engaged.Acc.Haste_30, sets.engaged.AccPDT)
	sets.engaged.Innin.PDT.Haste_30 = set_combine(sets.engaged.Innin.Haste_30, sets.engaged.HastePDT)
	sets.engaged.Innin.Low.PDT.Haste_30 = set_combine(sets.engaged.Innin.Low.Haste_30, sets.engaged.HastePDT)
	sets.engaged.Innin.Mid.PDT.Haste_30 = set_combine(sets.engaged.Innin.Mid.Haste_30, sets.engaged.HastePDT)
	sets.engaged.Innin.Acc.PDT.Haste_30 = sets.engaged.Acc.PDT.Haste_30
-- 5 - 20% Haste 
	sets.engaged.Haste_15 = set_combine(sets.engaged.Haste_30, {})
	sets.engaged.Low.Haste_15 = set_combine(sets.engaged.Haste_15, {})
	sets.engaged.Mid.Haste_15 = set_combine(sets.engaged.Low.Haste_15, {})
	sets.engaged.Acc.Haste_15 = sets.engaged.Acc.MaxHaste
	sets.engaged.Innin.Haste_15 = set_combine(sets.engaged.Haste_15, {})
	sets.engaged.Innin.Low.Haste_15 = set_combine(sets.engaged.Low.Haste_15, {})
	sets.engaged.Innin.Mid.Haste_15 = set_combine(sets.engaged.Mid.Haste_15, {})
	sets.engaged.Innin.Acc.Haste_15 = sets.engaged.Acc.Haste_15
	sets.engaged.PDT.Haste_15 = set_combine(sets.engaged.Haste_15, sets.engaged.HastePDT)
	sets.engaged.Low.PDT.Haste_15 = set_combine(sets.engaged.Low.Haste_15, sets.engaged.HastePDT)
	sets.engaged.Mid.PDT.Haste_15 = set_combine(sets.engaged.Mid.Haste_15, sets.engaged.HastePDT)
	sets.engaged.Acc.PDT.Haste_15 = set_combine(sets.engaged.Acc.Haste_15, sets.engaged.AccPDT)
	sets.engaged.Innin.PDT.Haste_15 = set_combine(sets.engaged.Innin.Haste_15, sets.engaged.HastePDT)
	sets.engaged.Innin.Low.PDT.Haste_15 = set_combine(sets.engaged.Innin.Low.Haste_15, sets.engaged.HastePDT)
	sets.engaged.Innin.Mid.PDT.Haste_15 = set_combine(sets.engaged.Innin.Mid.Haste_15, sets.engaged.HastePDT)
	sets.engaged.Innin.Acc.PDT.Haste_15 = sets.engaged.Acc.PDT.Haste_15
	sets.buff.Migawari = {}
-- Weaponskills 
	sets.precast.WS = {}
	sets.precast.WS.Mid = set_combine(sets.precast.WS, {})
	sets.precast.WS.Low = sets.precast.WS.Mid
	sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {})
-- BLADE:Kamu
	sets.Kamu = {}
	sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, sets.Kamu)
	sets.precast.WS['Blade: Kamu'].Low = set_combine(sets.precast.WS.Low, sets.Kamu)
	sets.precast.WS['Blade: Kamu'].Mid = set_combine(sets.precast.WS.Mid, sets.Kamu)
	sets.precast.WS['Blade: Kamu'].Acc = set_combine(sets.precast.WS.Acc, sets.Kamu, {})
-- BLADE: JIN
sets.Jin = {}
	sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, sets.Jin)
	sets.precast.WS['Blade: Jin'].Low = set_combine(sets.precast.WS['Blade: Jin'], {})
	sets.precast.WS['Blade: Jin'].Mid = set_combine(sets.precast.WS['Blade: Jin'].Low, {})
	sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS['Blade: Jin'].Mid, {})
-- BLADE: HI
	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Blade: Hi'].Low = set_combine(sets.precast.WS['Blade: Hi'], {})
	sets.precast.WS['Blade: Hi'].Mid = set_combine(sets.precast.WS['Blade: Hi'], {})
	sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'].Mid, {})
-- BLADE: SHUN
	sets.Shun = {}
	sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, sets.Shun)
	sets.precast.WS['Blade: Shun'].Low = set_combine(sets.precast.WS.Low, sets.Shun)
	sets.precast.WS['Blade: Shun'].Mid = set_combine(sets.precast.WS.Mid, sets.Shun)
	sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS.Acc, sets.Shun)
-- BLADE: Rin
	sets.Rin = {}
	sets.precast.WS['Blade: Rin'] = set_combine(sets.precast.WS, sets.Rin)
	sets.precast.WS['Blade: Rin'].Low = set_combine(sets.precast.WS.Low, sets.Rin)
	sets.precast.WS['Blade: Rin'].Mid = set_combine(sets.precast.WS.Mid, sets.Rin)
	sets.precast.WS['Blade: Rin'].Acc = set_combine(sets.precast.WS.Acc, sets.Rin, {})
-- BLADE: KU 
	sets.Ku = {}
	sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, sets.Ku)
	sets.precast.WS['Blade: Ku'].Low = set_combine(sets.precast.WS['Blade: Ku'], {})
	sets.precast.WS['Blade: Ku'].Mid = sets.precast.WS['Blade: Ku'].Low
	sets.precast.WS['Blade: Ku'].Acc = set_combine(sets.precast.WS['Blade: Ku'].Mid, {})
-- BLADE: TEN
	sets.Ten = {}
	sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, sets.Ten)
	sets.precast.WS['Blade: Ten'].Low = set_combine(sets.precast.WS['Blade: Ten'], {})
	sets.precast.WS['Blade: Ten'].Mid = set_combine(sets.precast.WS['Blade: Ten'].Low, {})
	sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS['Blade: Ten'].Mid, {})
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Blade: Chi'] = set_combine(sets.precast.WS['Aeolian Edge'], {})
-- BLADE: TO
	sets.precast.WS['Blade: To'] = sets.precast.WS['Blade: Chi']
end
------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
    if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") and buffactive.silence then
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    
    if spell.skill == "Ninjutsu" and spell.target.type:lower() == 'self' and spellMap ~= "Utsusemi" then
        if spell.english == "Migawari" then
            classes.CustomClass = "Migawari"
        else
            classes.CustomClass = "SelfNinjutsu"
        end
    end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
        -- If sneak is active when using, cancel before completion
        send_command('cancel 71')
    end
    if string.find(spell.english, 'Utsusemi') then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
            cancel_spell()
            eventArgs.cancel = true
            return
        end
    end

end

function job_post_precast(spell, action, spellMap, eventArgs)
    -- Ranged Attacks 
    if spell.action_type == 'Ranged Attack' and state.OffenseMode ~= 'Acc' then
        equip( sets.SangeAmmo )
    end
    -- protection for lag
    if spell.name == 'Sange' and player.equipment.ammo == gear.RegularAmmo then
        state.Buff.Sange = false
        eventArgs.cancel = true
    end
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
            equip(sets.TreasureHunter)
        end
        -- Mecistopins Mantle rule
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        -- Gavialis Helm rule
        if is_sc_element_today(spell) then
            if state.OffenseMode.current == 'Normal' and wsList:contains(spell.english) then
                -- do nothing
            else
              equip(sets.WSDayBonus)
            end
        end
        -- Swap in special ammo for WS in high Acc mode
        if state.OffenseMode.value == 'Acc' then
            equip(select_ws_ammo())
        end
        -- Lugra Earring for some WS
        if LugraWSList:contains(spell.english) then
            if world.time >= (17*60) or world.time <= (7*60) then
                equip(sets.BrutalLugra)
            else
                equip(sets.BrutalTrux)
            end
        elseif spell.english == 'Blade: Hi' or spell.english == 'Blade: Ten' then
            if world.time >= (17*60) or world.time <= (7*60) then
                equip(sets.BrutalLugra)
            else
                equip(sets.BrutalMoon)
            end
        end

    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        equip(sets.midcast.FastRecast)
    end
    if spell.english == "Monomi: Ichi" then
        if buffactive['Sneak'] then
            send_command('@wait 1.7;cancel sneak')
        end
    end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    --if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
    --    equip(sets.TreasureHunter)
    --end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Aftermath timer creation
    aw_custom_aftermath_timers_aftercast(spell)
    --if spell.type == 'WeaponSkill' then
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    if state.HybridMode.value == 'PDT' then
        if state.Buff.Migawari then
            idleSet = set_combine(idleSet, sets.buff.Migawari)
        else 
            idleSet = set_combine(idleSet, sets.defense.PDT)
        end
    else
        idleSet = set_combine(idleSet, select_movement())
    end
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if state.Buff.Migawari and state.HybridMode.value == 'PDT' then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if player.equipment.sub == 'empty' then
        meleeSet = set_combine(meleeSet, sets.NoDW)
    end
    if player.mp < 100 and state.OffenseMode.value ~= 'Acc' then
        -- use Rajas instead of Oneiros for normal + mid
        meleeSet = set_combine(meleeSet, sets.Rajas)
    end
    meleeSet = set_combine(meleeSet, select_ammo())
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
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
    
    if buff == 'Innin' and gain  or buffactive['Innin'] then
        state.CombatForm:set('Innin')
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    else
        state.CombatForm:reset()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    
end

function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        update_combat_form()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_ammo()
    determine_haste_group()
    update_combat_form()
    run_sj = player.sub_job == 'RUN' or false
    --select_movement()
    th_update(cmdParams, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
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
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end

function select_movement()
    -- world.time is given in minutes into each day
    -- 7:00 AM would be 420 minutes
    -- 17:00 PM would be 1020 minutes
    if world.time >= (17*60) or world.time <= (7*60) then
        return sets.NightMovement
    else
        return sets.DayMovement
    end
end

function determine_haste_group()
    
    classes.CustomMeleeGroups:clear()
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
    -- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
    -- Embrava 25%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- state.HasteMode = toggle for when you know Haste II is being cast on you
    -- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
    -- but wtf can  you do..   I macro it, and use it often. 
    if state.HasteMode.value == 'Hi' then
        if ( ((buffactive[33] or buffactive[580]) and buffactive.march) or (buffactive.embrava and buffactive[33]) or (buffactive.embrava and buffactive.march == 1) ) then
            add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( (buffactive[33] or buffactive.march == 2) and buffactive['haste samba'] ) or buffactive.embrava then
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
        elseif buffactive[580] or buffactive[33] or buffactive.march == 2 then
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif buffactive.march == 1 then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    else
        if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava) ) or 
           ( buffactive.embrava and buffactive.march == 2 ) or (buffactive[33] and buffactive.march == 2) or 
           ( buffactive.embrava and ( buffactive.march == 1 or buffactive[33] ) ) then
            add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif (buffactive[33] and buffactive['haste samba'] and buffactive.march == 1) or buffactive.embrava or (buffactive.march == 2 and buffactive['haste samba']) then
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
        elseif buffactive.march == 2 or (buffactive[33] and buffactive.march == 1) or buffactive[580] then
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif buffactive[33] or buffactive.march == 1 then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Capacity Point Mantle' then
        gear.Back = newValue
    elseif stateField == 'Runes' then
        local msg = ''
        if newValue == 'Ignis' then
            msg = msg .. 'Increasing resistence against ICE and deals FIRE damage.'
        elseif newValue == 'Gelus' then
            msg = msg .. 'Increasing resistence against WIND and deals ICE damage.'
        elseif newValue == 'Flabra' then
            msg = msg .. 'Increasing resistence against EARTH and deals WIND damage.'
        elseif newValue == 'Tellus' then
            msg = msg .. 'Increasing resistence against LIGHTNING and deals EARTH damage.'
        elseif newValue == 'Sulpor' then
            msg = msg .. 'Increasing resistence against WATER and deals LIGHTNING damage.'
        elseif newValue == 'Unda' then
            msg = msg .. 'Increasing resistence against FIRE and deals WATER damage.'
        elseif newValue == 'Lux' then
            msg = msg .. 'Increasing resistence against DARK and deals LIGHT damage.'
        elseif newValue == 'Tenebrae' then
            msg = msg .. 'Increasing resistence against LIGHT and deals DARK damage.'
        end
        add_to_chat(123, msg)
    elseif stateField == 'Use Rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
end

--- Custom spell mapping.
--function job_get_spell_map(spell, default_spell_map)
--    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
--        return 'HighTierNuke'
--    end
--end
-- Creating a custom spellMap, since Mote capitalized absorbs incorrectly
function job_get_spell_map(spell, default_spell_map)
    if spell.type == 'Trust' then
        return 'Trust'
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'Offense: '..state.OffenseMode.current
    msg = msg .. ', Hybrid: '..state.HybridMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    if state.HasteMode.value ~= 'Normal' then
        msg = msg .. ', Haste: '..state.HasteMode.current
    end
    if state.RangedMode.value ~= 'Normal' then
        msg = msg .. ', Rng: '..state.RangedMode.current
    end
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(123, msg)
    eventArgs.handled = true
end

-- Call from job_precast() to setup aftermath information for custom timers.
function aw_custom_aftermath_timers_precast(spell)
    if spell.type == 'WeaponSkill' then
        info.aftermath = {}
        
        local empy_ws = "Blade: Hi"
        
        info.aftermath.weaponskill = empy_ws
        info.aftermath.duration = 0
        
        info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end
        
        if spell.english == empy_ws and player.equipment.main == 'Kannagi' then
            -- nothing can overwrite lvl 3
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            -- only lvl 3 can overwrite lvl 2
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end
            
            -- duration is based on aftermath level
            info.aftermath.duration = 30 * info.aftermath.level
        end
    end
end

-- Call from job_aftercast() to create the custom aftermath timer.
function aw_custom_aftermath_timers_aftercast(spell)
    if not spell.interrupted and spell.type == 'WeaponSkill' and
       info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

        local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
        send_command('timers d "Aftermath: Lv.1"')
        send_command('timers d "Aftermath: Lv.2"')
        send_command('timers d "Aftermath: Lv.3"')
        send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

        info.aftermath = {}
    end
end

function select_ammo()
    if state.Buff.Sange then
        return sets.SangeAmmo
    else
        return sets.RegularAmmo
    end
end

function select_ws_ammo()
    if world.time >= (18*60) or world.time <= (6*60) then
        return sets.NightAccAmmo
    else
        return sets.DayAccAmmo
    end
end
function update_combat_form()
    if state.Buff.Innin then
        state.CombatForm:set('Innin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 2)
    elseif player.sub_job == 'WAR' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'RUN' then
        set_macro_page(2, 9)
    else
        set_macro_page(2, 2)
    end
end