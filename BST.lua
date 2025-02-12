-- NOTE: I do not play bst, so this will not be maintained for 'active' use.
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.
 
-- Credit to Quetzalcoatl.Falkirk for most of the original work.
 
--[[
    Custom commands:
   
    Ctrl-F8 : Cycle through available pet food options.
    Alt-F8 : Cycle through correlation modes for pet attacks.
    Alt-F7 : Cycle through PET MODES
    Ctrl-F7 : Cycle through JUG PETS
]]
 
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
   
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
end
 
function job_setup()
	state.Buff.Doomed = buffactive.doomed or false
    -- Set up Jug Pet Modes and keybind Ctrl-F7
    state.JugMode = M{['description']='Jug Mode', 'Meaty Broth', 'Airy Broth', 'Livid Broth', 'Saline Broth', 'Bubbly Broth', 'Windy Greens', 'Furious Broth', 'Seedbed Soil', 'Feculent Broth', 'Putrescent Broth', 'Gassy Sap', 'Aged Humus'}-- 'Feculent Broth', 'Putrescent Broth', 'Gassy Sap', 'Aged Humus'
    JugPet = {name="Meaty Broth"}
    send_command('bind ^f7 gs c cycle JugMode')
 
    -- Set up Reward Modes and keybind Ctrl-F8
    state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Pet Roborant'}-- 'Eta', 'Zeta', 'Pet Poultice', 'Epsilon'
    RewardFood = {name="Pet Food Theta"}--Pet Fd. Epsilon
    send_command('bind ^f8 gs c cycle RewardMode')
 
        --Pet Roborant    =    Erase Pet
        --Pet Poultice    =    Regen 6 HP/tick for 5 Minutes
        --Theta           =    20 HP/tick Regen and BEST FOOD for heals
        --Eta             =    17 HP/tick Regen and 2nd BEST FOOD for heals
        --Zeta            =    14 HP/tick Regen and 3rd BEST FOOD for heals
       
    -- Set up Monster Correlation Modes and keybind Alt-F8
    state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral','Favorable','HighAcc', 'MaxAcc'}
    send_command('bind !f8 gs c cycle CorrelationMode')
 
	--Ready Moves TP
	ready_moves_to_check = S{'Sic','Whirl Claws','Dust Cloud','Foot Kick','Sheep Song','Sheep Charge','Lamb Chop',
    'Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang',
    'Roar','Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Venom','Geist Wall','Toxic Spit',
    'Numbing Noise','Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Power Attack',
    'Hi-Freq Field','Sandpit','Sandblast','Venom Spray','Mandibular Bite','Metallic Body','Bubble Shower',
    'Bubble Curtain','Scissor Guard','Big Scissors','Grapple','Spinning Top','Double Claw','Filamented Hold',
    'Frog Kick','Queasyshroom','Silence Gas','Numbshroom','Spore','Dark Spore','Shakeshroom','Blockhead',
    'Secretion','Fireball','Tail Blow','Plague Breath','Brain Crush','Infrasonics','??? Needles',
    'Needleshot','Chaotic Eye','Blaster','Scythe Tail','Ripper Fang','Chomp Rush','Intimidate','Recoil Dive',
    'Water Wall','Snow Cloud','Wild Carrot','Sudden Lunge','Spiral Spin','Noisome Powder','Wing Slap',
    'Beak Lunge','Suction','Drainkiss','Acid Mist','TP Drainkiss','Back Heel','Jettatura','Choke Breath',
    'Fantod','Charged Whisker','Purulent Ooze','Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath',
    'Sensilla Blades','Tegmina Buffet','Molting Plumage','Swooping Frenzy','Pentapeck','Sweeping Gouge',
    'Zealous Snort','Somersault ','Tickling Tendrils','Stink Bomb','Nectarous Deluge','Nepenthic Plunge',
        'Pecking Flurry','Pestilent Plume','Foul Waters','Spider Web','Sickle Slash','Frogkick','Ripper Fang','Scythe Tail','Chomp Rush'}
		-----------------------------------------------------------------
	mab_ready_moves = S{
     'Cursed Sphere','Venom','Toxic Spit',
     'Venom Spray','Bubble Shower',
     'Fireball','Plague Breath',
     'Snow Cloud','Acid Spray','Silence Gas','Dark Spore',
     'Charged Whisker','Purulent Ooze','Aqua Breath','Stink Bomb',
     'Nectarous Deluge','Nepenthic Plunge','Foul Waters','Dust Cloud','Sheep Song','Scream','Dream Flower','Roar','Gloeosuccus','Palsy Pollen',
     'Soporific','Geist Wall','Numbing Noise','Spoil','Hi-Freq Field',
     'Sandpit','Sandblast','Filamented Hold',
     'Spore','Infrasonics','Chaotic Eye',
     'Blaster','Intimidate','Noisome Powder','TP Drainkiss','Jettatura','Spider Web',
     'Corrosive Ooze','Molting Plumage','Swooping Frenzy',
     'Pestilent Plume',}
 
    -- Custom pet modes for engaged gear
    state.PetMode = M{['description']='Pet Mode', 'Normal', 'PetStance', 'PetTank'}
    send_command('bind !f7 gs c cycle PetMode')
 
    get_combat_form()
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'Refresh', 'Reraise')
    state.PhysicalDefenseMode:options('PetPDT', 'PDT', 'Hybrid', 'Killer')
end
 
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()
    -- Unbinds the Reward and Correlation hotkeys.
    send_command('unbind !f7')
    send_command('unbind ^f7')
    send_command('unbind !f8')
    send_command('unbind ^f8')
end
 
organizer_items = {
	reraisehead="White Rarab Cap +1",
	sword_1="Naegling",
	dagger_1="Tauret",
}

 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
 
    sets.precast.JA['Killer Instinct'] = {
		head="Ankusa Helm",
		body="Nukumi Gausape",
		legs="Totemic Trousers",
	}--Nukumi Gausape
    sets.precast.JA['Feral Howl'] = {
		body="Ankusa Jackcoat",
	}
    sets.precast.JA['Call Beast'] = {
		ammo=JugPet,
		hands="Ankusa Gloves +1",
	}--Ankusa Gloves +1
    sets.precast.JA['Bestial Loyalty'] = sets.precast.JA['Call Beast']
    sets.precast.JA['Familiar'] = {
		legs="Ankusa Trousers +1",
	}--Ankusa Trousers +1
    sets.precast.JA['Tame'] = {
		head="Totemic Helm",
		ear1="Tamer's Earring",
		legs="Stout Kecks",
	}
    sets.precast.JA['Spur'] = {
		main="Skullrender",
		sub="Arktoi",
		feet="Nukumi Ocreae",
		back="Artio's Mantle",
	}--Nukumi Ocreae
 
    sets.precast.JA['Reward'] = {
		ammo=RewardFood,
        head="Khimaira Bonnet",
		neck="Aife's Medal",
		ear1="Pratik Earring",
		ear2="Ferine Earring",
        body="Totemic Jackcoat +1",
		hands="Ogre Gloves",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
        back="Artio's Mantle",
		waist="Crudelis Belt",
		legs="Ankusa Trousers +1",
		feet="Ankusa Gaiters +1",
	}--Loyalist Sabatons/Stout Bonnet/Zoraal Ja's Axe/Pallas's Shield/Pratik Earring/Mdomo Axe/Ankusa Trousers +1/Ankusa Gaiters +1
 
    sets.precast.JA['Charm'] = {
		ammo="Tsar's Egg",
        head="Totemic Helm",
		neck="Ferine Necklace",
		ear1="Enchanter's Earring",
		ear2="Reverie Earring +1",
        body="Ankusa Jackcoat",
		hands="Ankusa Gloves +1",
		ring1="Dawnsoul Ring",
		ring2="Dawnsoul Ring",
        back="Aisance Mantle +1",
		waist="Aristo Belt",
		legs="Ankusa Trousers +1",
		feet="Ankusa Gaiters +1",
	}--Ankusa Gaiters +1/Ankusa Trousers +1/Ankusa Gloves +1
 
	sets.precast.JA['Provoke'] = {
		ear1="Friomisi Earring",
		ear2="Cryptic Earring",
		neck="Unmoving Collar +1",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		waist="Warwolf Belt",
		ring1="Petrov Ring",
		ring2="Begrudging Ring",
		feet="Rager Ledel. +1",
		head="Halitus Helm",
	}
 
	sets.TP_Bonus        = {ear2="Thrud Earring"}
 
    -- CURING WALTZ
    sets.precast.Waltz = {
		ammo="Sonia's Plectrum",
        head="Skormoth Mask",
		neck="Unmoving Collar +1",
		ear1="Odnowa Earring +1",
		ear2="Thrud Earring",
        body="Reiki Osode",
		hands="Taeon Gloves",
		ring1="Titan Ring +1",
		ring2="Titan Ring",
        back="Iximulew Cape",
		waist="Warwolf Belt",
		legs="Malignance Tights",
		feet="Amm Greaves",
	}--Taeon Boots/Genmei Kabuto
 
    -- HEALING WALTZ
    sets.precast.Waltz['Healing Waltz'] = {}
 
    -- STEPS
    sets.precast.Step = {
		ammo="Ginsen",
        head="Alhazen Hat +1",
		neck="Subtlety Spec.",
		ear1="Digni. Earring",
		ear2="Telos Earring",
        body="Reiki Osode",
		hands="Leyline Gloves",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
        back="Artio's Mantle",
		waist="Incarnation Sash",
		legs="Malignance Tights",
		feet="Meg. Jam. +1",
	}--Leyline Gloves/Dampening Tam
 
    -- VIOLENT FLOURISH
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {
		head="Dampening Tam",
		body="Vatic Byrnie",
		feet="Meg. Jam. +1",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
	}
 
    sets.precast.FC = {
		ammo="Impatiens",
		neck="Voltsurge Torque",
		ear2="Loquacious Earring",
		ring1="Weatherspoon Ring +1",
		ring2="Prolix Ring",
		hands="Leyline Gloves",
	}
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		neck="Magoraga Beads",
	})
 
    -- WEAPONSKILLS
    -- Default weaponskill set.
    sets.precast.WS = {
		ammo="Floestone",
        head="Meghanada Visor +2",
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
        body="Phorcys Korazin",
		hands="Meg. Gloves +2",
		ring1="Shukuyu Ring",
		ring2="Epona's Ring",
        back="Vespid Mantle",
		waist="Fotia Belt",
		legs="Malignance Tights",
		feet="Meg. Jam. +1",
	}--Vespid Mantle/Lilitu Headgear/Letalis Mantle/Vatic Byrnie
 
    sets.precast.WS.WSAcc = {
		ammo="Ginsen",
        head="Meghanada Visor +2",
		neck="Subtlety Spec.",
		ear1="Digni. Earring",
		ear2="Telos Earring",
        body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Shukuyu Ring",
		ring2="Rufescent Ring",
        back="Letalis Mantle",
		waist="Hurch'lan Sash",
		legs="Malignance Tights",
		feet="Meg. Jam. +1",
	}
 
    -- Specific weaponskill sets.
    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		body="Phorcys Korazin",
		hands="Meg. Gloves +2",
		head="Meghanada Visor +2",
		waist="Fotia Belt",
		ear2="Thrud Earring",
	})--back="Buquwik Cape"/Vatic Byrnie/Mes. Haubergeon
 
	sets.precast.WS['Decimation'] = set_combine(sets.precast.WS, {ear2="Thrud Earring"})
 
	sets.precast.WS['Mistral Axe'] = set_combine(sets.precast.WS, {ear2="Thrud Earring"})
 
	sets.precast.WS['Calamity'] = set_combine(sets.precast.WS, {ear2="Thrud Earring"})
 
	sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {ear2="Thrud Earring"})
 
	sets.precast.WS['Spinning Axe'] = set_combine(sets.precast.WS, {ear2="Thrud Earring"})
 
	sets.precast.WS['Smash Axe'] = set_combine(sets.precast.WS, {ear2="Thrud Earring"})
 
	sets.precast.WS['Raging Axe'] = set_combine(sets.precast.WS, {ear2="Thrud Earring"})
 
	sets.precast.WS['Avalanche Axe'] = set_combine(sets.precast.WS, {ear2="Thrud Earring"})
 
    sets.precast.WS['Ruinator'].WSAcc = set_combine(sets.precast.WS.WSAcc, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
	})
 
    sets.precast.WS['Ruinator'].Mekira = set_combine(sets.precast.WS['Ruinator'], {head="Meghanada Visor +2"})
 
    sets.precast.WS['Onslaught'] = set_combine(sets.precast.WS, {
		ear1="Digni. Earring",
		ear2="Telos Earring",
        ring1="Shukuyu Ring",
	})
 
    sets.precast.WS['Onslaught'].WSAcc = set_combine(sets.precast.WSAcc, {
		hands="Buremte Gloves",
		ring1="Petrov Ring",
	})
 
    sets.precast.WS['Primal Rend'] = {
		ammo="Pemphredo Tathlum",
        head="Jumalik Helm",
		neck="Baetyl Pendant",
		ear1="Friomisi Earring",
		ear2="Thrud Earring",
        body="Phorcys Korazin",
		hands="Leyline Gloves",
		ring1="Fenrir Ring",
		ring2="Fenrir Ring",
        back="Toro Cape",
		waist="Fotia Belt",
		legs="Malignance Tights",
		feet="Meg. Jam. +1",
	}--Jumalik Helm/Stoicheion Medal/Vatic Byrnie/Phorcys Korazin
 
	sets.precast.WS['Gale Axe'] = set_combine(sets.precast.WS['Primal Rend'], {ear2="Hecate's Earring"})
 
    sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'], {
		waist="Fotia Belt",
		neck="Baetyl Pendant",
		body="Phorcys Korazin",
		ear2="Thrud Earring",
	})--Vatic Byrnie
 
    sets.precast.WS['Bora Axe'] = set_combine(sets.precast.WS['Primal Rend'], {
		waist="Fotia Belt",
		neck="Fotia Gorget",
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		ear2="Thrud Earring",
	})
 
    --------------------------------------
    -- Midcast sets
    --------------------------------------
   
    sets.midcast.FastRecast = {
		ammo="Impatiens",
        head="Anwig Salade",
		neck="Voltsurge Torque",
		ear2="Loquacious Earring",
        body="Taeon Tabard",
		hands="Leyline Gloves",
		ring1="Weatherspoon Ring +1",
		ring2="Prolix Ring",
        back="Iximulew Cape",
		waist="Incarnation Sash",
		legs="Malignance Tights",
		feet="Amm Greaves",
	}
 
    sets.midcast.Utsusemi = sets.midcast.FastRecast
 
    sets.midcast.Cure = {
		ammo="Impatiens",
        ear1="Mendi. Earring",
		ear2="Loquacious Earring",
		head="Anwig Salade",
		body="Jumalik Mail",
		hands="Buremte Gloves",
		ring1="Weatherspoon Ring +1",
		ring2="Prolix Ring",
	}
 
    sets.midcast.Curaga = sets.midcast.Cure
 
    -- PET SIC & READY MOVES
    sets.midcast.Pet.WS = {
		ammo="Demonry Core",
        head={ name="Valorous Mask", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+2','Pet: AGI+1',}},
		neck="Shulmanu Collar",
		ear1="Domes. Earring",
		ear2="Enmerkar Earring",
        body={ name="Valorous Mail", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Store TP"+10','Pet: INT+4','Pet: Attack+4 Pet: Rng.Atk.+4',}},
		hands="Nukumi Manoplas",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back="Artio's Mantle",
		waist="Incarnation Sash",
		legs={ name="Valorous Hose", augments={'Pet: "Dbl. Atk."+3','Pet: DEX+8','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Attack+14 Pet: Rng.Atk.+14',}},
		feet={ name="Valorous Greaves", augments={'Pet: Accuracy+26 Pet: Rng. Acc.+26','Pet: "Dbl. Atk."+2','Pet: STR+7',}},
	}--Argocham. Mantle/Artio's Mantle/Pastoralist's Mantle/Hija Earring/Domes. Earring/Regimen Mittens/Despair Greaves/Despair Cuisses/Despair Mail/Totemic Gaiters/Nukumi Manoplas
 
    sets.ReadyPrecast = {
		sub="Charmer's Merlin",
		legs="Desultor Tassets",
		ring1="Varar Ring",
		ring2="Varar Ring",
	}
 
	
    sets.midcast.Pet.Neutral = set_combine(sets.midcast.Pet.WS, {head="Despair Helm"})
	sets.midcast.Pet.HighAcc = set_combine(sets.midcast.Pet.WS, {hands="Emicho Gauntlets"})
	sets.midcast.Pet.MaxAcc = set_combine(sets.midcast.Pet.WS, {
		hands={ name="Valorous Mitts", augments={'Pet: Accuracy+29 Pet: Rng. Acc.+29','Pet: "Dbl. Atk."+1','Pet: STR+8','Pet: Attack+13 Pet: Rng.Atk.+13',}},
	})
	sets.midcast.Pet.MabReady = set_combine(sets.midcast.Pet.WS, {
		neck="Adad Amulet",
		back="Argochampsa Mantle",
	})
	 
	sets.midcast.Pet.TPBonus = {hands="Nukumi Manoplas"} 
    sets.midcast.Pet.Favorable = {
		head="Nukumi Cabasset",
		legs="Totemic Trousers",
	}--Nukumi Cabasset
 
    sets.midcast.Pet.WS.Unleash = set_combine(sets.midcast.Pet.WS, {hands="Emicho Gauntlets"})--Nukumi Manoplas
 
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
	--Hunahpu   Pet: ACC+30 Haste+3 (Occ. Atk Twice Store TP+5)
	--Izizoeksi Pet: Haste+2% Enmity+7 Damage taken -5%
	--Kerehcatl Pet: Accuracy+28 Attack+28
	--Skullrender (x2) Pet: Haste+8% Double Attack+5% ACC+20 ATK+20
	
	--Acro Surcoat    Pet: DT-4% ACC+12 R.ACC+12 DA+1%
	--Acro Gauntlets  Pet: Haste+3% Acc+17 R.ACC+17 DA+3%
	--Acro Breeches   Pet: Haste+1% ACC+12 R.ACC+12 DA+2%
	--Acro Leggings   Pet: DT-3% ACC+10 R.ACC+10 DA+1%
 
	--Despair Helm    Pet: ACC+20 R.ACC+20 ATK+20 R.ATK+20 DT-3%  VIT+7
 
	--Valorous Mask   	Pet: AGI+1 ACC+25 R.ACC+25 DA+2%
	--Valorous Mail   	Pet: INT+4 ACC+10 Rng.ACC+10 ATK+4 Rng.ATK+4 Store TP+10
	--Valorous Mitts  	Pet: STR+8 ACC+29 R.ACC+29 ATK+13 R.ATK+13 DA+1% 
	--Valorous Hose   	Pet: DEX+8 ACC+15 R.ACC+15 ATK+14 R.ATK+14 DA+3% 
	--Valorous Greaves 	Pet: STR+7 ACC+26 Rng.ACC+26 DA+2%
 
	--Emicho Gauntlets  Pet: ATK+40 ACC+15 Store TP +6 DA+3%
 
	--Pastoralist's Mantle     Pet: ACC+20  Rng.ACC+20   PDT-2%
	
	--Artio's Mantle     ACC+20 ATK+20 Reward+30 Spur+10   Pet: ACC+20 R.ACC+20 ATK+20 R.ATK+20 Haste+10%
	
	--Empath Necklace : ACC+10 PET: ACC+10 R.ACC+10 ATK+5 R.ATK+10 Regen+1%
	
	--Ferine Necklace : CHR+6 ACC+7 ATK+7 PET: Double Attack +2%
	
	--Hija Earring Pet: Attack +10 Magic Atk Bonus +5 Double Attack +2%
 
	--Domes. Earring (EVA+3 Enmity-5 PET: Enmity+5 Double Attack+3%)
 
	-- Enmerkar Earring (Pet: ACC+15 M.ACC+15 Store TP+8 DT-3%)
 
    -- RESTING
    sets.resting = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head={ name="Valorous Mask", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+2','Pet: AGI+1',}},
		neck="Sanctity Necklace",
		ear1="Domes. Earring",
		ear2="Enmerkar Earring",
        body={ name="Valorous Mail", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Store TP"+10','Pet: INT+4','Pet: Attack+4 Pet: Rng.Atk.+4',}},
		hands="Ankusa Gloves +1",
		ring1="Dark Ring",
		ring2="Defending Ring",
        back="Artio's Mantle",
		waist="Isa Belt",
		legs="Nukumi Quijotes",
		feet="Skadi's Jambeaux +1",
	}--Isa Belt/Primal Belt/Muscle Belt +1/Nukumi Quijotes/Lissome Necklace
 
    -- IDLE SETS
    sets.idle = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head={ name="Valorous Mask", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+2','Pet: AGI+1',}},
		neck="Empath Necklace",
		ear2="Enmerkar Earring",
		ear1="Domes. Earring",
        body={ name="Valorous Mail", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Store TP"+10','Pet: INT+4','Pet: Attack+4 Pet: Rng.Atk.+4',}},
		hands="Emicho Gauntlets",
		ring1="Dark Ring",
		ring2="Defending Ring",
        back="Pastoralist's Mantle",
		waist="Isa Belt",
		legs={ name="Valorous Hose", augments={'Pet: "Dbl. Atk."+3','Pet: DEX+8','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Attack+14 Pet: Rng.Atk.+14',}},
		feet="Skadi's Jambeaux +1",
	}--Hunahpu/Izizoeksi/Kerehcatl/Nukumi Quijotes/Twilight Helm/Totemic Gloves
       
    sets.idle.Town = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head={ name="Valorous Mask", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+2','Pet: AGI+1',}},
		neck="Empath Necklace",
		ear1="Domes. Earring",
		ear2="Enmerkar Earring",
        body={ name="Valorous Mail", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Store TP"+10','Pet: INT+4','Pet: Attack+4 Pet: Rng.Atk.+4',}},
		hands="Emicho Gauntlets",
		ring1="Dark Ring",
		ring2="Defending Ring",
        back="Artio's Mantle",
		waist="Isa Belt",
		legs={ name="Valorous Hose", augments={'Pet: "Dbl. Atk."+3','Pet: DEX+8','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Attack+14 Pet: Rng.Atk.+14',}},
		feet="Skadi's Jambeaux +1",
	}--Hunahpu/Izizoeksi/Kerehcatl/Nukumi Quijotes/Twilight Helm/Totemic Gloves
       
    sets.idle.Weak = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head={ name="Valorous Mask", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+2','Pet: AGI+1',}},
		neck="Empath Necklace",
		ear1="Domes. Earring",
		ear2="Enmerkar Earring",
        body={ name="Valorous Mail", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Store TP"+10','Pet: INT+4','Pet: Attack+4 Pet: Rng.Atk.+4',}},
		hands="Emicho Gauntlets",
		ring1="Dark Ring",
		ring2="Defending Ring",
        back="Pastoralist's Mantle",
		waist="Isa Belt",
		legs={ name="Valorous Hose", augments={'Pet: "Dbl. Atk."+3','Pet: DEX+8','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Attack+14 Pet: Rng.Atk.+14',}},
		feet="Skadi's Jambeaux +1",
	}--Hunahpu/Izizoeksi/Kerehcatl/Nukumi Quijotes/Twilight Helm/Totemic Gloves
       
    sets.idle.Refresh = {body="Acro Surcoat"}
 
    sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
 
    sets.idle.Pet = sets.idle
 
    sets.idle.Pet.Engaged = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head={ name="Valorous Mask", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+2','Pet: AGI+1',}},
		neck="Shulmanu Collar",
		ear1="Domes. Earring",
		ear2="Enmerkar Earring",
        body={ name="Valorous Mail", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Store TP"+10','Pet: INT+4','Pet: Attack+4 Pet: Rng.Atk.+4',}},
		hands="Emicho Gauntlets",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back="Artio's Mantle",
		waist="Incarnation Sash",
		legs={ name="Valorous Hose", augments={'Pet: "Dbl. Atk."+3','Pet: DEX+8','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Attack+14 Pet: Rng.Atk.+14',}},
		feet={ name="Valorous Greaves", augments={'Pet: Accuracy+26 Pet: Rng. Acc.+26','Pet: "Dbl. Atk."+2','Pet: STR+7',}},
	}--Regimen Mittens/Rimeice Earring/Spurrer Beret/Ankusa Trousers +1/Totemic Gloves/Ankusa Jackcoat/Taeon Boots
       
    -- DEFENSE SETS
    sets.defense.PDT = {
		ammo="Staunch Tathlum",
        head="Jumalik Helm",
		neck="Loricate Torque +1",
        body="Jumalik Mail",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
        back="Solemnity Cape",
		waist="Flume Belt",
		legs="Malignance Tights",
		feet="Meg. Jam. +1",
	}--Jumalik Mail/Jumalik Helm
 
    sets.defense.PetPDT = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head="Despair Helm",
		neck="Empath Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
        body="Acro Surcoat",
		hands="Ankusa Gloves +1",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back="Pastoralist's Mantle",
		waist="Isa Belt",
		legs="Tali'ah Seraweels +1",
		feet="Acro Leggings",
	}--Shepherd's Chain/Despair Greaves/Despair Cuisses/Despair Mail/Selemnus Belt/Rimeice Earring/Nukumi Quijotes/Ankusa Trousers +1/Totemic Gloves/Ankusa Jackcoat/Nukumi Quijotes/Acro Gauntlets/Nukumi Quijotes
 
    sets.defense.Hybrid = set_combine(sets.defense.PDT, {
		head="Skormoth Mask",
        back="Mollusca Mantle",
		waist="Incarnation Sash",
		legs="Malignance Tights",
		feet="Amm Greaves",
	})
 
    sets.defense.Killer = set_combine(sets.defense.Hybrid, {
		ammo="Bibiki Seashell",
		head="Ankusa Helm",
		body="Nukumi Gausape",
		legs="Totemic Trousers",
	})--Nukumi Gausape
 
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum",
        head="Skormoth Mask",
		ear1="Odnowa Earring +1",
		ear2="Odnowa Earring",
        body="Jumalik Mail",
		feet="Volte Spats",
		ring1="Dark Ring",
        back="Solemnity Cape",
		waist="Nierenschutz",
	})
 
    sets.Kiting = {
		ammo="Staunch Tathlum",
        head="Jumalik Helm",
        body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Skadi's Jambeaux +1",
		neck="Loricate Torque +1",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
		ring1="Dark Ring",
		ring2="Defending Ring",
        back="Solemnity Cape",
		waist="Flume Belt",
	}
 
	--Kiting mode Stats
		--Head 		(PDT-5)
		--Body   	(PDT-7)
		--Hands 	(PDT-3)
		--Legs 		(PDT-5)
		--Feet		(N/A)
	
		--Ring1		(PDT-5)
		--Ring2		(DT-10)
		--Neck		(DT-5)
		--Waist		(PDT-4)
		--Back		(PDT-4)
		--Ammo		(DT-2)
 
	--Total:		50% PDT 
 
    --------------------------------------
    -- Engaged sets
    --------------------------------------
 
    sets.engaged = {
		ammo="Ginsen",
        head="Skormoth Mask",
		neck="Asperity Necklace",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
        body="Mes. Haubergeon",
		hands="Taeon Gloves",
		ring1="Hetairoi Ring",
		ring2="Epona's Ring",
        back="Letalis Mantle",
		waist="Sarissapho Belt",
		legs="Meg. Chausses +2",
		feet="Loyalist Sabatons",
	}--Loyalist Sabatons/Mes'yohi Haubergeon/Patentia Sash/Felistris Mask
 
    sets.engaged.Acc = {
		ammo="Amar Cluster",
        head="Meghanada Visor +2",
		neck="Subtlety Spec.",
		ear1="Digni. Earring",
		ear2="Telos Earring",
        body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Chirich Ring",
		ring2="Chirich Ring",
        back="Letalis Mantle",
		waist="Hurch'lan Sash",
		legs="Malignance Tights",
		feet="Meg. Jam. +1",
	}
 
    sets.engaged.Killer = set_combine(sets.engaged, {
		head="Ankusa Helm",
		body="Nukumi Gausape",
		legs="Totemic Trousers",
	})--Nukumi Gausape
    sets.engaged.Killer.Acc = set_combine(sets.engaged.Acc, {
		head="Ankusa Helm",
		body="Nukumi Gausape",
		legs="Totemic Trousers",
		waist="Hurch'lan Sash",
	})--Nukumi Gausape
   
   
    -- EXAMPLE SETS WITH PET MODES
   
    sets.engaged.PetStance = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head={ name="Valorous Mask", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+2','Pet: AGI+1',}},
		neck="Shulmanu Collar",
		ear1="Domes. Earring",
		ear2="Enmerkar Earring",
        body={ name="Valorous Mail", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Store TP"+10','Pet: INT+4','Pet: Attack+4 Pet: Rng.Atk.+4',}},
		hands="Emicho Gauntlets",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back="Artio's Mantle",
		waist="Incarnation Sash",
		legs={ name="Valorous Hose", augments={'Pet: "Dbl. Atk."+3','Pet: DEX+8','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Attack+14 Pet: Rng.Atk.+14',}},
		feet={ name="Valorous Greaves", augments={'Pet: Accuracy+26 Pet: Rng. Acc.+26','Pet: "Dbl. Atk."+2','Pet: STR+7',}},
	}
		
    sets.engaged.PetStance.Acc = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head={ name="Valorous Mask", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+2','Pet: AGI+1',}},
		neck="Shulmanu Collar",
		ear2="Enmerkar Earring",
		ear1="Ferine Earring",
        body={ name="Valorous Mail", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Store TP"+10','Pet: INT+4','Pet: Attack+4 Pet: Rng.Atk.+4',}},
		hands="Emicho Gauntlets",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back="Artio's Mantle",
		waist="Incarnation Sash",
		legs={ name="Valorous Hose", augments={'Pet: "Dbl. Atk."+3','Pet: DEX+8','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Attack+14 Pet: Rng.Atk.+14',}},
		feet={ name="Valorous Greaves", augments={'Pet: Accuracy+26 Pet: Rng. Acc.+26','Pet: "Dbl. Atk."+2','Pet: STR+7',}},
	}--Ankusa Jackcoat/Totemic Gloves/Ankusa Trousers +1
    sets.engaged.PetTank = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head="Despair Helm",
		neck="Empath Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
        body="Acro Surcoat",
		hands="Ankusa Gloves +1",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back="Pastoralist's Mantle",
		waist="Isa Belt",
		legs="Tali'ah Seraweels +1",
		feet="Acro Leggings",
	}--Nukumi Quijotes/Ankusa Jackcoat/Totemic Gloves
    sets.engaged.PetTank.Acc = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head="Despair Helm",
		neck="Empath Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
        body="Acro Surcoat",
		hands="Emicho Gauntlets",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back="Pastoralist's Mantle",
		waist="Isa Belt",
		legs="Tali'ah Seraweels +1",
		feet="Acro Leggings",
	}--Ankusa Jackcoat/Totemic Gloves/Nukumi Quijotes/Ankusa Trousers +1
    sets.engaged.PetMDT = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head="Despair Helm",
		neck="Empath Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
        body="Acro Surcoat",
		hands="Emicho Gauntlets",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back="Pastoralist's Mantle",
		waist="Isa Belt",
		legs="Tali'ah Seraweels +1",
		feet="Acro Leggings",
	}--Ankusa Jackcoat/Totemic Gloves/Nukumi Quijotes/Ankusa Trousers +1
 
    -- MORE EXAMPLE SETS WITH EXPANDED COMBAT FORMS
    sets.engaged.DW = {
		ammo="Ginsen",
        head="Skormoth Mask",
		neck="Asperity Necklace",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
        body="Mes. Haubergeon",
		hands="Taeon Gloves",
		ring1="Petrov Ring",
		ring2="Epona's Ring",
        back="Artio's Mantle",
		waist="Sarissapho Belt",
		legs="Meg. Chausses +2",
		feet="Loyalist Sabatons",
	}--Loyalist Sabatons
    sets.engaged.DW.Acc = {
		ammo="Ginsen",
        head="Meghanada Visor +2",
		neck="Subtlety Spec.",
		ear1="Digni. Earring",
		ear2="Telos Earring",
        body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
        back="Letalis Mantle",
		waist="Hurch'lan Sash",
		legs="Malignance Tights",
		feet="Meg. Jam. +1",
	}
	sets.engaged.DW.PetStance = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head={ name="Valorous Mask", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+2','Pet: AGI+1',}},
		neck="Shulmanu Collar",
		ear1="Domes. Earring",
		ear2="Enmerkar Earring",
        body={ name="Valorous Mail", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Store TP"+10','Pet: INT+4','Pet: Attack+4 Pet: Rng.Atk.+4',}},
		hands="Emicho Gauntlets",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back="Artio's Mantle",
		waist="Incarnation Sash",
		legs={ name="Valorous Hose", augments={'Pet: "Dbl. Atk."+3','Pet: DEX+8','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Attack+14 Pet: Rng.Atk.+14',}},
		feet={ name="Valorous Greaves", augments={'Pet: Accuracy+26 Pet: Rng. Acc.+26','Pet: "Dbl. Atk."+2','Pet: STR+7',}},
	}--Totemic Gloves/Ankusa Jackcoat/Ankusa Trousers +1/Taeon Boots
    sets.engaged.DW.PetStance.Acc = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head={ name="Valorous Mask", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+2','Pet: AGI+1',}},
		neck="Shulmanu Collar",
		ear1="Ferine Earring",
		ear2="Enmerkar Earring",
        body={ name="Valorous Mail", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Store TP"+10','Pet: INT+4','Pet: Attack+4 Pet: Rng.Atk.+4',}},
		hands="Emicho Gauntlets",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back="Artio's Mantle",
		waist="Incarnation Sash",
		legs={ name="Valorous Hose", augments={'Pet: "Dbl. Atk."+3','Pet: DEX+8','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Attack+14 Pet: Rng.Atk.+14',}},
		feet={ name="Valorous Greaves", augments={'Pet: Accuracy+26 Pet: Rng. Acc.+26','Pet: "Dbl. Atk."+2','Pet: STR+7',}},
	}--Ankusa Jackcoat/Totemic Gloves/Nukumi Quijotes/Ankusa Trousers +1
    sets.engaged.DW.PetTank = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head="Despair Helm",
		neck="Empath Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
        body="Acro Surcoat",
		hands="Ankusa Gloves +1",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back="Pastoralist's Mantle",
		waist="Isa Belt",
		legs="Tali'ah Seraweels +1",
		feet="Acro Leggings",
	}--Ankusa Jackcoat/Totemic Gloves/Nukumi Quijotes
    sets.engaged.DW.PetTank.Acc = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head="Despair Helm",
		neck="Empath Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
        body="Acro Surcoat",
		hands="Emicho Gauntlets",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back="Pastoralist's Mantle",
		waist="Isa Belt",
		legs="Tali'ah Seraweels +1",
		feet="Acro Leggings",
	}--Ankusa Jackcoat/Totemic Gloves/Nukumi Quijotes/Ankusa Trousers +1
    sets.engaged.DW.PetMDT = {
		main="Skullrender",
		sub="Arktoi",
		ammo="Demonry Core",
        head="Despair Helm",
		neck="Empath Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
        body="Acro Surcoat",
		hands="Emicho Gauntlets",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back="Pastoralist's Mantle",
		waist="Isa Belt",
		legs="Tali'ah Seraweels +1",
		feet="Acro Leggings",
	}--Ankusa Jackcoat/Totemic Gloves/Nukumi Quijotes/Ankusa Trousers +1
   
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
 
    sets.buff['Killer Instinct'] = {
		head="Ankusa Helm",
		body="Nukumi Gausape",
		legs="Totemic Trousers",
	}--Nukumi Gausape
	sets.buff.Doomed = {
		ring2="Saida Ring",
		waist="Gishdubar Sash",
	}
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
function job_precast(spell, action, spellMap, eventArgs)
    -- Define class for Sic and Ready moves.
    -- Define class for Sic and Ready moves.
        if ready_moves_to_check:contains(spell.name) and pet.status == 'Engaged' then
                classes.CustomClass = "WS"
        equip(sets.midcast.Pet.ReadyRecast)
        end

	--if spell.type == "Monster" and pet.status == 'Engaged' then
      --  equip(sets.ReadyPrecast)
        --classes.CustomClass = "WS"
    --end
end

function job_aftercast(spell, action, spellMap, eventArgs)
 
if spell.type == "Monster" and not spell.interrupted then
 
 equip(set_combine(sets.midcast.Pet.WS, sets.midcast.Pet[state.CorrelationMode.value]))
 
    if mab_ready_moves:contains(spell.english) and pet.status == 'Engaged' then
 equip(sets.midcast.Pet.MabReady)
 end
 
    if buffactive['Unleash'] then
                hands={ name="Valorous Mitts", augments={'Pet: Accuracy+29 Pet: Rng. Acc.+29','Pet: "Dbl. Atk."+1','Pet: STR+8','Pet: Attack+13 Pet: Rng.Atk.+13',}}
        end
 
 
 eventArgs.handled = true
 end
 
 
end 
 
function job_post_precast(spell, action, spellMap, eventArgs)
    -- If Killer Instinct is active during WS, equip Nukumi Gausape.
    if spell.type:lower() == 'weaponskill' and buffactive['Killer Instinct'] then
        equip(sets.buff['Killer Instinct'])
    end
	if player.tp > 2750 then
            equip(sets.TP_Bonus)	
		end
end
 
 
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
    -- Equip monster correlation gear, as appropriate
	if stateField == 'Correlation Mode' then
        state.CorrelationMode:set(newValue)
    end
    equip(sets.midcast.Pet[state.CorrelationMode.value])
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
function job_buff_change(buff, gain)
    if buff == 'Killer Instinct' then
        get_combat_form()
        handle_equipping_gear(player.status)
    end
end
 
-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Idle' or newStatus == 'Engaged' then
        handle_equipping_gear(player.status)
    end
end
 
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Reward Mode' then
        -- Theta, Zeta or Eta
        RewardFood.name = "Pet Food " .. newValue
    elseif stateField == 'Jug Mode' then
        JugPet.name = newValue
    elseif stateField == 'Pet Mode' then
        state.CombatWeapon:set(newValue)
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    if defaut_wsmode == 'Normal' then
        if spell.english == "Ruinator" and (world.day_element == 'Water' or world.day_element == 'Wind' or world.day_element == 'Ice') then
            return 'Mekira'
        end
    end
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
end
 
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
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
   
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
 
    msg = msg .. ', Jug: '..state.JugMode.value..', Reward: '..state.RewardMode.value..', Corr.: '..state.CorrelationMode.value
 
    add_to_chat(122, msg)
 
    eventArgs.handled = true
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function get_combat_form()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        state.CombatForm:set('DW')
    else
        state.CombatForm:reset()
    end
end
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
        -- Default macro set/book
        set_macro_page(1, 12)
 
 
        -- Default macro set/book
        if player.sub_job == 'DNC' then
                set_macro_page(1, 12)
        elseif player.sub_job == 'NIN' then
                set_macro_page(1, 12)
        elseif player.sub_job == 'WHM' then
                set_macro_page(1, 12)
        elseif player.sub_job == 'SCH' then
                set_macro_page(1, 12)
        else
                set_macro_page(1, 12)
        end
end