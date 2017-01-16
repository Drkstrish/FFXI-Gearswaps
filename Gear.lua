-- Check to see if it is needed to have the format be gear.______ = {} or if I can follow the current format I started.

--==================================--
-- Reisenjima gear
--==================================--

-- Weapons
	gear.Skinflayer = {}
	gear.Skinflayer.MH = { name="Skinflayer", augments={'"Triple Atk."+2','CHR+1','Accuracy+19','Attack+19','DMG:+18'}}
	gear.Skinflayer.OH = { name="Skinflayer", augments={'"Triple Atk."+3','Accuracy+10','Attack+13','DMG:+17'}}
	
	gear.Colada = {}
	gear.Colada.STP = { name="Colada", augments={'"Store TP"+5','VIT+2','Accuracy+25'}}
	gear.Colada.Refresh = { name="Colada", augments={'"Refresh"+2','INT+1','Mag. Acc.+15','"Mag.Atk.Bns."+10'}}
	
	gear.Zulfiqar = {}
	gear.Zulfiqar.Only = { name="Zulfiqar", augments={'Weapon Skill Acc.+5','STR+6','Attack+14','DMG:+24'}}
	
	gear.Kanaria = {}
	gear.Kanaria.Only = { name="Kanaria", augments={'"Triple Atk."+3','DEX+6','Accuracy+20','Attack+8','DMG:+3'}}
	
	gear.Grioavolr = {}
	gear.Grioavolr.Only = { name="Grioavolr", augments={'"Fast Cast"+7','MP+54','Mag. Acc.+29','"Mag.Atk.Bns."+28','Magic Damage +3'}}
	
	gear.Teller = {}
	gear.Teller.Only = { name="Teller", augments={'Weapon skill damage +2%','Rng.Acc.+23','Rng.Atk.+19','DMG:+15'}}
	
-- Chironic
	gear.Chironichead = {}
	gear.Chironichead.MAcc = { name="Chironic Hat", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Conserve MP"+1','VIT+1','Mag. Acc.+8'}}
	gear.Chironichead.blank = "Chironic Hat"
	
	gear.Chironicbody = {}
	gear.Chironicbody.MAcc = { name="Chironic Doublet", augments={'Mag. Acc.+29','Enmity-4','MND+2','"Mag.Atk.Bns."+6'}}
	gear.Chironicbody.Cures = { name="Chironic Doublet", augments={'Mag. Acc.+12','"Cure" potency +11%'}}
	gear.Chironicbody.blank - "Chironic Doublet"
	
	gear.Chironichands = {}
	gear.Chironichands.MAatk = { name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+6','Mag. Acc.+10','"Mag.Atk.Bns."+14'}}
	gear.Chironichands.blank = "Chironic Gloves"
	
	gear.Chironiclegs = {}
	gear.Chironiclegs.MAcc = { name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Cure" spellcasting time -8%','Mag. Acc.+14'}}
	gear.Chironiclegs.blank = "Chironic Hose"
	
	gear.Chironicfeet = {}
	gear.Chironicfeet.MAcc = { name="Chironic Slippers", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Haste+4','Mag. Acc.+13'}}
	gear.Chironicfeet.blank = "Chironic Slippers"
	
-- Herculean
	gear.Herculeanhead = {}
	gear.Herculeanhead.Magic = { name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Crit. hit damage +2%','STR+9','"Mag.Atk.Bns."+12'}}
	gear.Herculeanhead.Ranged = { name="Herculean Helm", augments={'Rng.Acc.+28','"Subtle Blow"+1','DEX+1','Rng.Atk.+15'}}

	gear.Herculeanbody = {}
	gear.Herculeanbody.Crit = { name="Herculean Vest", augments={'Accuracy+28','Crit.hit rate+5','DEX+5','Attack+12'}}

	gear.Herculeanhands = {}
	gear.Herculeanhands.Crit = { name="Herculean Gloves", augments={'Accuracy+16','Crit.hit rate+5','DEX+1'}}
	gear.Herculeanhands.Triple = { name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+3','STR+9'}}
	gear.Herculeanhands.Ranged = { name="Herculean Gloves", augments={'Rng.Acc.+18 Rng.Atk.+18','Enmity-3','AGI+6','Rng.Acc.+9','Rng.Atk.+1'}}

	gear.Herculeanlegs = {}
	gear.Herculeanlegs.MaxAcc = { name="Herculean Trousers", augments={'Accuracy+14 Attack+14','DEX+9','Accuracy+15','Attack+14'}}
	gear.Herculeanlegs.Triple = { name="Herculean Trousers", augments={'Attack+27','"Triple Atk."+4','AGI+4','Accuracy+15'}}
	gear.Herculeanlegs.Ranged = { name="Herculean Trousers", augments={'Rng.Acc.+23 Rng.Atk.+23','Enmity-1','AGI+7','Rng.Atk.+15'}}
	gear.Herculeanfeet.TH = { name="Herculean Trousers", augments={'Pet: Phys. dmg. taken -1%','"Fast Cast"+3','"Treasure Hunter"+1','Accuracy+11 Attack+11','Mag. Acc.+1 "Mag.Atk.Bns."+1'}}

	gear.Herculeanfeet = {}
	gear.Herculeanfeet.Triple = { name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','VIT+6','Accuracy+5'}}
	gear.Herculeanfeet.Magic = { name="Herculean Boots", augments={'AGI+10','"Store TP"+2','Magic Damage +17','Mag. Acc.+20 "Mag.Atk.Bns."+20'}}
	gear.Herculeanfeet.Ranged = { name="Herculean Boots", augments={'Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+2','Rng.Acc.+12','Rng.Atk.+9'}}

-- Merlinic
	gear.Merlinichead = {}
	gear.Merlinichead.FC = { name="Merlinic Hood", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Fast Cast"+6','INT+6','Mag. Acc.+10','"Mag.Atk.Bns."+14'}}
	gear.Merlinichead.MB = { name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+4%','Mag. Acc.+13','"Mag.Atk.Bns."+9'}}

	gear.Merlinicbody = {}
	gear.Merlinicbody.MB = { name="Merlinic Jubbah", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst mdg.+10%','CHR+7'}}

	gear.Merlinichands = {}
	gear.Merlinichands.Nukes = { name="Merlinic Dastanas", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','INT+8','Mag. Acc.+3','"Mag.Atk.Bns."+15'}}
	gear.Merlinichands.blank = "Merlinic Dastanas"

	gear.Merliniclegs = {}
	gear.Merliniclegs.MB = { name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+21','Magic burst mdg.+9%','INT+1','Mag. Acc.+13'}}
	gear.Merliniclegs.OA = { name="Merlinic Shalwar", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Occult Acumen"+9','CHR+5','"Mag.Atk.Bns."+13'}}
	
	gear.Merlinicfeet = {}
	gear.Merlinicfeet.MB = { name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst mdg.+7%','CHR+2','Mag. Acc.+6','"Mag.Atk.Bns."+14'}}
	gear.Merlinicfeet.Refresh = { name="Merlinic Crackows", augments={'INT+1','Phys. dmg. taken -4%','"Refresh"+1','Accuracy+8 Attack+8'}}

-- Odyssean

	gear.Odysseanhead = {}
	gear.Odysseanhead.TP = { name="Odyssean Helm", augments={'Accuracy+28','"Dbl.Atk."+3','CHR+4','"Mag.Atk.Bns."+3'}}
	gear.Odysseanhead.WS = { name="Odyssean Helm", augments={'Attack+9','Weapon skill damage +4%','STR+3','Accuracy+13'}}
	
	gear.Odysseanbody = {}
	
	gear.Odysseanhands = {}
	gear.Odysseanhands.TP = { name="Odyssean Gauntlets", augments={'Accuracy+22','DEX+9','Attack+3'}}
	gear.Odysseanhands.WS = { name="Odyssean Gauntlets", augments={'Mag. Acc.+24','Weapon skill damage +3%','MND+9'}}
	
	gear.Odysseanlegs = {}
	gear.Odysseanlegs.WS = { name="Odyssean Cuisses", augments={'Accuracy+21','STR+14'}}
	
	gear.Odysseanfeet = {}
	gear.Odysseanfeet.TP = { name="Odyssean Greaves", augments={'Accuracy+23','"Dbl.Atk."+2','STR+3'}}
	gear.Odysseanfeet.FC = { name="Odyssean Greaves", augments={'"Fast Cast"+3','VIT+5','Accuracy+9','Attack+15'}}
	gear.Odysseanfeet.Matk = { name="Odyssean Greaves", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','"Store TP"+5','MND+1','"Mag.Atk.Bns."+15'}}
	
-- Valorous
	gear.Valoroushead = {}
	gear.Valoroushead.WS  = { name="Valorous Mask", augments={'Accuracy+28','Weapon skill damage +3%','STR+15','Attack+12'}}
	gear.Valoroushead.TP  = { name="Valorous Mask", augments={'Accuracy+30','"Dbl.Atk."+2','STR+2','Attack+12'}}
	gear.Valoroushead.PetAcc  = { name="Valorous Mask", augments={'Pet: Accuracy+30 Pet: Rng. Acc.+30','"Store TP"+1','Pet: DEX+10','Pet: Attack+14 Pet: Rng.Atk.+14'}}
	
	gear.Valorousbody = {}
	gear.Valorousbody.PetAcc = { name="Valorous Mail", augments={'Pet: Accuracy+30 Pet: Rng. Acc.+30','Pet: "Store TP"+3','Pet: DEX+14'}}
	gear.Valorousbody.WS = { name="Valorous Mail", augments={'Accuracy+28','Sklchn.dmg.+4%','STR+9','Attack+15'}}

	gear.Valoroushands = {}
	gear.Valoroushands.TP  = { name="Valorous Mitts", augments={'Accuracy+16 Attack+16','"Store TP"+4','VIT+8','Accuracy+14'}}
	gear.Valoroushands.WS  = { name="Valorous Mitts", augments={'Accuracy+27','"Dbl.Atk."+2','STR+15'}}
	gear.Valoroushands.MaxAcc = { name="Valorous Mitts", augments={'Accuracy+19 Attack+19','Magic dmg. taken -2%','VIT+10','Accuracy+15','Attack+15'}}	
	gear.Valoroushands.PetAcc  = { name="Valorous Mitts", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Pet: "Regen"+1','Pet: DEX+4','Pet: Attack+11 Pet: Rng.Atk.+11'}}

	gear.Valorouslegs = {}
	gear.Valorouslegs.TP  = { name="Valor. Hose", augments={'Accuracy+24 Attack+24','"Store TP"+5','VIT+8','Accuracy+3'}}
	gear.Valorouslegs.PetAcc  = { name="Valor. Hose", augments={'Pet: Accuracy+30 Pet: Rng. Acc.+30','Pet: Haste+2','Pet: INT+10','Pet: Attack+14 Pet: Rng.Atk.+14'}}

	gear.Valorousfeet = {}
	gear.Valorousfeet.MaxAcc  = { name="Valorous Greaves", augments={'Accuracy+24 Attack+24','Damage taken-1%','Accuracy+14'}}
	gear.Valorousfeet.STP  = { name="Valorous Greaves", augments={'Accuracy+27','"Store TP"+5','DEX+9','Attack+10'}}
	gear.Valorousfeet.PetAcc  = { name="Valorous Greaves", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Pet: "Dbl. Atk."+1','Pet: DEX+9','Pet: Attack+5 Pet: Rng.Atk.+5'}}

--==================================--
-- Escha abjuration gear
--==================================--
    
-- Adhemar
	gear.Adhemarhead = {}
	gear.Adhemarhead.A = { name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15'}}

	gear.Adhemarbody = {}
	gear.Adhemarbody.A = { name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15'}}

	gear.Adhemarhands = {}
	gear.Adhemarhands.A = { name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15'}}

	gear.Adhemarfeet = {}
	gear.Adhemarfeet.D = { name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8'}}

-- Amalric
	gear.Amalricbody = {}
	gear.Amalricbody.A = { name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15'}}
	
	gear.Amalrichands = {}
	gear.Amalrichands.D = { name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15'}}
	
	gear.Amalriclegs = {}
	gear.Amalriclegs.A = { name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15'}}
	
-- Apogee
-- Argosy
	gear.Argosyhead = {}
	gear.Argosyhead.D =  { name="Argosy Celata", augments={'DEX+10','Accuracy+15','"Dbl.Atk."+2'}}
	
	gear.Argosyhands = {}
	gear.Argosyhands.D =  { name="Argosy Mufflers", augments={'STR+15','"Dbl.Atk."+2','Haste+2%'}}
	
	gear.Argosylegs = {}
	gear.Argosylegs.D = { name="Argosy Breeches", augments={'STR+10','Attack+20','"Store TP"+5'}}
	
	gear.Argosyfeet = {}
	gear.Argosyfeet.D = { name="Argosy Sollerets", augments={'HP+50','"Dbl.Atk."+2','"Store TP"+3'}}
	
-- Carmine
	gear.Carminehead = {}
	gear.Carminehead.D = {}

	gear.Carminehands = {}
	gear.Carminehands.D = { name="Carmine Fin. Ga.", augments={'Rng.Atk.+15','"Mag.Atk.Bns."+10','"Store TP"+5'}}
	
	gear.Carminelegs = {}
	gear.Carminelegs.D = { name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6'}}
	
	gear.Carminefeet = {}
	gear.Carminefeet.D = { name="Carmine Greaves", augments={'HP+60','MP+60','Phys. dmg. taken -3'}}
	
-- Emicho
	gear.Emichohead = {}
	gear.Emichohead.C = { name="Emicho Coronet", augments={'Pet: Accuracy+15','Pet: Attack+15','Pet: "Dbl. Atk."+3'}}
	
	gear.Emichohands = {}
	gear.Emichohands.C =  { name="Emicho Gambieras", augments={'Pet: Accuracy+15','Pet: Attack+15','Pet: "Dbl. Atk."+3'}}
	
	gear.Emicholegs = {}
	gear.Emicholegs.C = { name="Emicho Gauntlets", augments={'Pet: Accuracy+15','Pet: Attack+15','Pet: "Dbl. Atk."+3'}}
	
	gear.Emichofeet = {}
	gear.Emichofeet.C = { name="Emicho Hose", augments={'Pet: Accuracy+15','Pet: Attack+15','Pet: "Dbl. Atk."+3'}}
	
-- Kaykaus
-- Lustratio
	gear.Lustratiohead = {}
	gear.Lustratiohead.B = { name="Lustratio Cap", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%'}}
	
	gear.Lustratiobody = {}
	gear.Lustratiobody.D = { name="Lustratio Harness", augments={'Accuracy+8','Attack+10','"Dbl.Atk."+3'}}
	
	gear.Lustratiohands = {}
	gear.Lustratiohands.B = { name="Lustratio Mittens", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%'}}
	
	gear.Lustratiolegs = {}
	gear.Lustratiolegs.B = { name="Lustratio Subligar", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%'}}
	
	gear.Lustratiofeet = {}
	gear.Lustratiofeet.B = { name="Lustratio Leggings", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%'}}
	
-- Rao
	gear.Raohead = {}
	gear.Raohead.B = { name="Rao Kabuto", augments={'STR+10','DEX+10','Attack+15'}}

	gear.Raohands = {}
	gear.Raohands.A = { name="Rao Kote", augments={'Accuracy+10','Attack+10','Evasion+15'}}
	
	gear.Raolegs = {}
	gear.Raolegs.B = { name="Rao Haidate", augments={'STR+10','DEX+10','Attack+15'}}
	
	gear.Raofeet = {}
	gear.Raofeet.A = { name="Rao Sune-Ate", augments={'Accuracy+10','Attack+10','Evasion+15'}}
	
-- Ryuo    
	gear.Ryuohead = {}
	gear.Ryuohead.A = { name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15'}}
	
	gear.Ryuohands = {}
	gear.Ryuohands.D = { name="Ryuo Tekko", augments={'DEX+10','Accuracy+20','"Dbl.Atk."+3'}}
	
	gear.Ryuolegs = {}
	gear.Ryuolegs.A = { name="Ryuo Hakama", augments={'STR+10','DEX+10','Accuracy+15'}}
	
	gear.Ryuofeet = {}
	gear.Ryuofeet.A = { name="Ryuo Sune-Ate", augments={'STR+10','DEX+10','Accuracy+15'}}
	
-- Souveran
	gear.Souveranbody = {}
	gear.Souveranbody.A = {}
	
	gear.Souveranhands = {}
	gear.Souveranhands.A = {}
	
	gear.Souveranlegs = {}
	gear.Souveranlegs.A {}
	
	gear.Souveranfeet = {}
	gear.Souveranfeet.A = {}

--==================================--
-- Escha gear
--==================================--

-- Escha Zi'Tah weapons
	gear.NibiruAxe = {}
	gear.NibiruAxe.C = { name="Nibiru Tabar", augments={'Pet: Attack+25','Pet: "Mag.Atk.Bns."+15','Pet: Enmity+7'}}
	gear.NibiruAxe.C = { name="Nibiru Tabar", augments={'Pet: Attack+25','Pet: "Mag.Atk.Bns."+15','Pet: Enmity+7'}}

	gear.NibiruClub = {}
	gear.NibiruClub.B = { name="Nibiru Cudgel", augments={'MP+50','INT+10','"Mag.Atk.Bns."+15'}}

-- Escha Ru'Aun weapons

	gear.Emissary = {}
	gear.Emissary.D = { name="Emissary", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+20','"Refresh"+1'}}

	gear.Bidenhander = {}
	gear.Bidenhander.B = { name="Bidenhander", augments={'DMG:+30','Accuracy+20','Attack+20'}}
	
	gear.Skullrender = {}
	gear.Skullrender.C = { name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20'}}
	gear.Skullrender.C = { name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20'}}

	gear.Akademos = {}
	gear.Akademos.C = { name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15'}}

-- Despair
	gear.Despairhead = {}
	gear.Despairhead.C = { name="Despair Helm", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%'}}
	
	gear.Despairbody = {}
	gear.Despairbody.C = { name="Despair Mail", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%'}}
	
	gear.Despairhands = {}
	gear.Despairhands.C = { name="Despair Fin. Gaunt.", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%'}}
	
	gear.Despairlegs = {}
	gear.Despairlegs.C = { name="Despair Cuisses", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%'}}
	
	gear.Despairfeet = {}
	gear.Despairfeet.C = { name="Despair Greaves", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%'}}
	
-- Eschite
-- Naga
	gear.Nagahead = {}
	gear.Nagahead.A  = { name="Naga Somen", augments={'STR+7','Accuracy+9','"Subtle Blow"+5'}}
	
	gear.Nagabody = {}
    	gear.Nagabody.A = { name="Naga Samue", augments={'STR+9','Accuracy+13','"Subtle Blow"+6'}}
    	
    	gear.Nagahands = {}
    	gear.Nagahands.A = { name="Naga Tekko", augments={'STR+10','Accuracy+15','"Subtle Blow"+7'}}
    	
    	gear.Nagalegs = {}
    	gear.Nagalegs.A = { name="Naga Hakama", augments={'STR+10','Accuracy+15','"Subtle Blow"+7'}}
    	
	gear.Nagafeet = {}
	gear.Nagafeet.A = { name="Naga Kyahan", augments={'STR+10','Accuracy+15','"Subtle Blow"+7'}}

-- Psycloth
	gear.Psyclothbody = {}
	gear.Psyclothbody.D  = { name="Psycloth Vest", augments={'Elem. magic skill +20','INT+7','Enmity-6'}}
	
	gear.Psyclothhands = {}
	gear.Psyclothhands.A  = { name="Psycloth Manillas", augments={'MP+50','INT+7','"Conserve MP"+6'}}
	
	gear.Psyclothlegs = {}
	gear.Psyclothlegs.D  = { name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7'}}
	
	gear.Psyclothfeet = {}
	gear.Psyclothfeet.A  = { name="Psycloth Boots", augments={'MP+50','INT+7','"Conserve MP"+6'}}
	
-- Pursuer's
	gear.Pursuershead = {}
	gear.Pursuershead.A = { name="Pursuer's Beret", augments={'AGI+10','"Rapid Shot"+10','"Subtle Blow"+7'}}
	
	gear.Pursuersbody = {}
	gear.Pursuersbody.D = { name="Pursuer's Doublet", augments={'HP+50','Crit. hit rate+4%','"Snapshot"+6'}}
	
	gear.Pursuershands = {}
	gear.Pursuershands.A = { name="Pursuer's Cuffs", augments={'AGI+10','"Rapid Shot"+10','"Subtle Blow"+7'}}
	
	gear.Pursuerslegs = {}
	gear.Pursuerslegs.A = { name="Pursuer's Pants", augments={'AGI+10','"Rapid Shot"+10','"Subtle Blow"+7'}}
	
	gear.Pursuersfeet = {}
	gear.Pursuersfeet.D = { name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15'}}	

-- Rawhide
	gear.Rawhidehead = {}
	gear.Rawhidehead.B  = { name="Rawhide Mask", augments={'HP+50','Accuracy+15','Evasion+20'}}	
	
	gear.Rawhidebody = {}
	gear.Rawhidebody.D  = { name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2'}}	
	
	gear.Rawhidehands = {}
	gear.Rawhidehand.B  = s{ name="Rawhide Gloves", augments={'HP+50','Accuracy+15','Evasion+20'}}	
	
	gear.Rawhidelegs = {}
	gear.Rawhidelegs.D  = { name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1'}}	
	
	gear.Rawhidefeet = {}
	gear.Rawhidefeet.B  = { name="Rawhide Boots", augments={'HP+50','Accuracy+15','Evasion+20'}}

-- Vanya
	gear.Vanyahead = {}
	gear.Vanyahead.D = { name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%'}}
	
	gear.Vanyabody = {}
	gear.Vanyabody.B = { name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3'}}	
	
	gear.Vanyahands = {}
	gear.Vanyahands.B = { name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3'}}
	
	gear.Vanyalegs = {}
	gear.Vanyalegs.B = { name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3'}}

--==================================--
-- Skirmish gear
--==================================--
	
-- Weapons
	gear.Kumbhakarna = {}
	gear.Kumbhakarna.TP180 = { name="Kumbhakarna", augments={'Pet: Accuracy+19 Pet: Rng. Acc.+19','Pet: Phys. dmg. taken -2%','Pet: TP Bonus+180'}}
	gear.Kumbhakarna.Stats = { name="Kumbhakarna", augments={'Pet: Attack+14 Pet: Rng.Atk.+14','Pet: Phys. dmg. taken -4%','Pet: STR+13 Pet: DEX+13 Pet: VIT+13'}}

-- Helios
-- Taeon
	gear.Taeonhead = {}
	gear.Taeonhead.Triple = { name="Taeon Chapeau", augments={'Accuracy+14 Attack+14','"Triple Atk."+2'}}
	
	gear.Taeonbody = {}
	gear.Taeonbody.PetAcc = { name="Taeon Tabard", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+3','Pet: Haste+5'}}
	
	gear.Taeonhands = {}
	gear.Taeonhands.PetAcc = { name="Taeon Gloves", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Dbl. Atk."+2'}}
	
	gear.Taeonlegs = {}
	gear.Taeonlegs.Triple = { name="Taeon Tights", augments={'Accuracy+19 Attack+19','"Triple Atk."+1'}}
	gear.Taeonlegs.Pettank = { name="Taeon Tights", augments={'Pet: Accuracy+5 Pet: Rng. Acc.+5','Pet: "Regen"+3','Pet: Damage taken -4%'}}
	
	gear.Taeonfeet = {}
	gear.Taeonfeet.PetAcc = { name="Taeon Boots", augments={'Pet: Accuracy+18 Pet: Rng. Acc.+18','Pet: "Dbl. Atk."+3','CHR+9'}}
	
-- Telchine
-- Acro
	gear.Acrohead = {}
	gear.Acrohead.Haste = { name="Acro Helm", augments={'Accuracy+10','Haste+3','STR+1 VIT+1'}}

	gear.Acrobody = {}
	gear.Acrobody.Pet = { name="Acro Surcoat", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+3','Pet: Damage taken -4%'}}

	gear.Acrohands = {}
	gear.Acrohands.Pet = { name="Acro Gauntlets", augments={'Pet: Accuracy+17 Pet: Rng. Acc.+17','Pet: "Regen"+3','Pet: Damage taken -4%'}}

	gear.Acrofeet = {}
	gear.Acrofeet.Pet = { name="Acro Leggings", augments={'Pet: Attack+19 Pet: Rng.Atk.+19','Pet: "Regen"+3','Pet: Damage taken -4%'}}
	
--==================================--
-- Sinister Reign gear
--==================================--

	gear.Malevolence = {}
	gear.Malevolence.High = { name="Malevolence", augments={'INT+9','Mag. Acc.+10','"Mag.Atk.Bns."+9','"Fast Cast"+4'}}
	gear.Malevolence.Low = { name="Malevolence", augments={'INT+3','Mag. Acc.+5','"Mag.Atk.Bns."+7'}}
	
	gear.TamingSari = {}
	gear.TamingSari.NotMax = { name="Taming Sari", augments={'STR+9','DEX+8','DMG:+14'}}
	
	gear.Vampirism = {}
	gear.Vampirism.High = { name="Vampirism", augments={'STR+6','INT+5','"Occult Acumen"+5','DMG:+7'}}
	gear.Vampirism.Low = { name="Vampirism", augments={'STR+3','INT+5','"Occult Acumen"+3','DMG:+3'}}    
	
	gear.Rubicundity = { name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7'}}
	
	gear.Nobility = {}
	gear.Nobility.Cap = { name="Nobility", augments={'AGI+10','Crit.hit rate+4','"Store TP"+8','DMG:+15'}}

--==================================--
-- JSE Capes
--==================================--

	gear.ReiveJSE = {}
	gear.ReiveJSE.MNK = { name="Anchoret's Mantle", augments={'STR+4','DEX+3','"Subtle Blow"+3','"Counter"+2'}}
	gear.ReiveJSE.BLM = { name="Bane Cape", augments={'Elem. magic skill +9','Dark magic skill +5','"Mag.Atk.Bns."+2','"Fast Cast"+4'}}
	gear.ReiveJSE.SCH = { name="Bookworm's Cape", augments={'INT+1','MND+4','Helix eff. dur. +11','"Regen" potency+7'}}
	gear.ReiveJSE.THF = { name="Canny Cape", augments={'DEX+4','AGI+1','"Dual Wield"+4','Crit. hit damage +1%'}}
	gear.ReiveJSE.BLU = { name="Cornflower Cape", augments={'MP+30','DEX+2','Accuracy+2','Blue Magic skill +9'}}
	gear.ReiveJSE.RUN = { name="Evasionist's Cape", augments={'Enmity+1','"Embolden"+7','"Dbl.Atk."+1'}}
	gear.ReiveJSE.RDM = { name="Ghostfyre Cape", augments={'Enfb.mag. skill +7','Enha.mag. skill +1','Mag. Acc.+8'}}
	gear.ReiveJSE.RNG = { name="Lutian Cape", augments={'STR+3','AGI+5','"Store TP"+1','"Snapshot"+3'}}
	gear.ReiveJSE.BST = { name="Pastoralist's Mantle", augments={'STR+1 DEX+1','Pet: Accuracy+14 Pet: Rng. Acc.+14','Pet: Damage taken -5%'}}
	gear.ReiveJSE.SAM = { name="Takaha Mantle", augments={'STR+4','"Zanshin"+3','"Store TP"+2','Meditate eff. dur. +5'}}
	gear.ReiveJSE.NIN = { name="Yokaze Mantle", augments={'STR+2','DEX+3','Sklchn.dmg.+4%'}}
	
	gear.JSEcape = {}
	gear.JSEcape.NINWS = { name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','Weapon skill damage +10%'}}
	gear.JSEcape.NINTP = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10'}}
	gear.JSEcape.BST = { name="Artio's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: "Regen"+10'}}
	gear.JSEcape.BLUcrit =  { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10'}}
	gear.JSEcape.BLUWS = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%'}}
	gear.JSEcape.SAMTP = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10'}}
	gear.JSEcape.SAMWS = { name="Smertrios's Mantle", augments={'STR+23','Accuracy+20 Attack+20','Weapon skill damage +10%'}}
	gear.JSEcape.BLM = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10'}}
	gear.JSEcape.RNG = {}
	gear.JSEcape.SCH = {}

--==================================--
-- Misc. Gear
--==================================--
