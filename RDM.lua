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


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff.Enspell = buffactive.enspell or false
    state.Buff.Saboteur = buffactive.saboteur or false
	state.Buff.Doomed = buffactive.doomed or false
   
	--(Coment out) determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Defense')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    gear.default.obi_waist = "Refoccilation Stone"
    
	state.MagicBurst = M(false, 'Magic Burst')
	
	send_command('bind @` gs c activate MagicBurst')
	
    --select_default_macro_book()
	--[[
        Alt + (tilda) will turn on or off the Lock Weapon
    ]]
    state.LockWeapon = M(false, "Lock Weapon")
	-----------------------------------------------
	state.Moving = M(false, "moving")
	state.Refresh = M(false, "Refresh")
	
	send_command("bind !` gs c toggle LockWeapon")
	send_command("bind !end gs c toggle Refresh")
	send_command("bind Delete gs c toggle MagicBurst")
	
	Enspell = S{'Enthunder', 'Enthunder II', 'Enstone', 'Enstone II', 'Enaero', 'Enaero II', 'Enblizzard', 'Enblizzard II', 'Enfire', 'Enfire II', 'Enwater', 'Enwater II'}
	
end

function user_unload()
	send_command("unbind !`")
	send_command("unbind !end")
	send_command("unbind Delete")
end

organizer_items = {
	--reraisehead="White Rarab Cap +1
	sword_1="Naegling",
	dagger_1="Tauret",
}


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {
		body="Vitiation Tabard +1",
	}
    
	sets.precast.JA['Provoke'] = sets.enmity

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		ammo="Brigantia Pebble",
		head="Vitiation Chapeau +1",
		neck="Unmoving Collar +1",
		ear1="Odnowa Earring +1",
		ear2="Roundel Earring",
		body="Jhakri Robe +2",
		hands="Vitiation Gloves +1",
		ring1="Titan Ring +1",
		ring2="Titan Ring",
		back="Iximulew Cape",
		waist="Chuq'aba Belt",
		legs="Vitiation Tights +1",
		feet="Vitiation Boots +1",
	}
        
	sets.precast.Step = {
		ammo="Amar Cluster",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		ear2="Telos Earring",                              
		ear1="Digni. Earring",
		waist="Sarissapho Belt",
	}--Sucellos's Cape
	
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.enmity = {
		ear1="Friomisi Earring",
		neck="Unmoving Collar +1",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		waist="Warwolf Belt",
		ring1="Petrov Ring",
		ring2="Begrudging Ring",
	}
    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {
		ammo="Impatiens",
		head="Atrophy Chapeau +1",
		neck="Voltsurge Torque",
		ear1="Loquacious Earring",
		ear2="Malignance Earring",
		body="Vitiation Tabard +1",
		hands="Leyline Gloves",
		ring1="Weatherspoon Ring +1",
		ring2="Kishar Ring",
		back="Perimede Cape",
		waist="Witful Belt",
		legs="Psycloth Lappas",
		feet="Regal Pumps +1",
	}--Psycloth Lappas

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head=empty,
		body="Twilight Cloak",
	})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Ginsen",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Aya. Gambieras +1",
		neck="Subtlety Spectacles",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		ring1="Petrov Ring",
		ring2="Hetairoi Ring",
		waist="Sarissapho Belt",
		back="Letalis Mantle",
	}--Sucellos's Cape

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		ammo="Ginsen",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		head="Atrophy Chapeau +1",
		body="Lethargy Sayon +1",
		hands="Lethargy Gantherots +1",
		neck="Erra Pendant",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		legs="Psycloth Lappas",
	})

    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS,  {
		ammo="Pemphredo Tathlum",
		head="Merlinic Hood",
		body="Jhakri Robe +2",
		hands="Amalric Gages",
		legs="Merlinic Shalwar",
		feet="Merlinic Crackows",
		ear1="Friomisi Earring",
		ear2="Malignance Earring",
		neck="Baetyl Pendant",
		back="Ghostfyre Cape",
		ring1="Fenrir Ring",
		ring2="Fenrir Ring",
	})--Sucellos's Cape

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS,  {
		hands="Malignance Gloves",
		neck="Fotia Gorget",
		ring1="Begrudging Ring",
		ring2="Epona's Ring",
		waist="Fotia Belt",
	})
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,  {
		ammo="Brigantia Pebble",
		neck="Subtlety Spectacles",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
	})--Sucellos's Cape
    
	sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS,  {
		ammo="Brigantia Pebble",
		neck="Subtlety Spectacles",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
	})
	
	sets.precast.WS['Knights of Round'] = set_combine(sets.precast.WS,  {
		ammo="Brigantia Pebble",
		neck="Subtlety Spectacles",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
	})

	--Aya. Zucchetto +1
	--Ayanmo Corazza +1
	--Aya. Manopolas +1
	--Aya. Cosciales +1
	--Aya. Gambieras +1
	
    -- Midcast Sets
    
    sets.midcast.FastRecast = {
		ammo="Impatiens",
		sub="Ammurapi Shield",
		head="Atrophy Chapeau +1",
		neck="Voltsurge Torque",
		ear1="Loquacious Earring",
		ear2="Malignance Earring",
		body="Vitiation Tabard +1",
		hands="Leyline Gloves",
		ring1="Weatherspoon Ring +1",
		ring2="Kishar Ring",
		back="Swith Cape",
		waist="Witful Belt",
		legs="Psycloth Lappas",
		feet="Regal Pumps +1",
	}

    sets.midcast.Cure = set_combine(sets.precast.FC ,   {
		ammo="Impatiens",
		main="Daybreak",
		sub="Sors Shield",
		head="Vanya Hood",
		body="Heka's Kalasiris",
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs="Atrophy Tights +1",
		feet="Medium's Sabots",
		neck="Nodens Gorget",
		ear1="Meili Earring",
		ear2="Mendi. Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Pahtli Cape",
		waist="Luminary Sash",
	})--Pahtli/Roundel Earring/Mendi. Earring/Sors Shield
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {
		waist="Chuq'aba Belt",
	})--ring1="Kunaji Ring",ring2="Asklepian Ring"

	sets.midcast.Cursna = set_combine(sets.precast.FC, {
		sub="Ammurapi Shield",
		head="Hyksos Khat",
		feet="Gendewitha Galoshes",
		ring1="Haoma's Ring",
		ring2="Haoma's Ring",
		ear1="Andoaa Earring",
		neck="Malison Medallion",
		waist="Gishdubar Sash",
	})

    sets.midcast['Enhancing Magic'] = set_combine(sets.precast.FC , {
		ammo="Impatiens",
		sub="Ammurapi Shield",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands="Atrophy Gloves +1",
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet="Lethargy Houseaux +1",
		back="Ghostfyre Cape",
		waist="Embla Sash",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		ear1="Mimir Earring",
		ear2="Andoaa Earring",
		neck="Incanter's Torque",
	})-- 114% / (BIS = Enhancing Dur+151%)

	sets.midcast['Enhancing Magic'].Enspell = set_combine(sets.midcast['Enhancing Magic'], {
		head="Umuthi Hat",
		hands="Aya. Manopolas +2",
		back="Ghostfyre Cape",
	})

	sets.midcast.Enspell = set_combine(sets.midcast['Enhancing Magic'], {
		head="Umuthi Hat",
		hands="Aya. Manopolas +2",
		back="Ghostfyre Cape",
	})

	--[[
		Umuthi Hat					(DMG+8%)
		Aya. Manopolas +1 			(DMG+15%) / +2 (17%)
		Ghostfyre Cape				(DMG+5%)
	]]

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
		body="Vitiation Tabard +1",
		legs="Lethargy Fuseau +1",
		back="Ghostfyre Cape",
	})

	sets.midcast['Phalanx II'] = set_combine(sets.midcast['Enhancing Magic'], {
		hands="Vitiation Gloves +1",
	})
	
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		sub="Ammurapi Shield",
		head="Umuthi Hat",
		waist="Siegel Sash",
		ear2="Andoaa Earring",
		ear2="Earthcry Earring",
		legs="Haven Hose",
		neck="Nodens Gorget",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
	})--waist="Siegel Sash",ear1="Earthcry Earring",legs="Haven Hose",head="Umuthi Hat"
    
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'],  {
		ring1="Sheltered Ring",
	})
    sets.midcast.Protectra = sets.midcast.Protect
 
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'],  {
		ring1="Sheltered Ring",
	})
    sets.midcast.Shellra = sets.midcast.Shell
	
    sets.midcast['Enfeebling Magic'] = {
		main="Daybreak",
		ammo="Pemphredo Tathlum",
		sub="Ammurapi Shield",
		head="Lethargy Chappel +1",
		neck="Erra Pendant",
		--ear1="Regal Earring",
		ear1="Snotra Earring",
		ear2="Malignance Earring",
		body="Atrophy Tabard +1",
		hands="Lethargy Gantherots +1",
		ring1="Weatherspoon Ring +1",
		ring2="Leviathan Ring +1",
		back="Ghostfyre Cape",
		waist="Refoccilation Stone",
		legs="Psycloth Lappas",
		feet="Merlinic Crackows",
	}--Malignance / Digni. --Sucellos's Cape

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {
		main="Daybreak",
		head="Vitiation Chapeau +1",
	})

	sets.midcast['Bio III'] =  set_combine(sets.midcast['Enfeebling Magic'], {
		legs="Vitiation Tights +1",
	})
	
	sets.midcast['Paralyze II'] =  set_combine(sets.midcast['Enfeebling Magic'], {
		feet="Vitiation Boots +1",
	})
	
	sets.midcast['Blind II'] = set_combine(sets.midcast['Enfeebling Magic'], {
		legs="Vitiation Tights +1",
	})
	
    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {
		head="Vitiation Chapeau +1",
	})
    
    sets.midcast['Elemental Magic'] = {
		main="Daybreak",
		ammo="Pemphredo Tathlum",
		sub="Ammurapi Shield",
		head="Merlinic Hood",
		neck="Baetyl Pendant",
		ear1="Friomisi Earring",
		ear2="Malignance Earring",
		body="Jhakri Robe +2",
		hands="Amalric Gages",
		ring1="Shiva Ring",
		ring2="Shiva Ring +1",
		back="Ghostfyre Cape",
		waist="Refoccilation Stone",
		legs="Merlinic Shalwar",
		feet="Merlinic Crackows",
	}--Sucellos's Cape
        
	sets.magic_burst = {
		neck="Mizukage-no-Kubikazari",
		ring1="Locus Ring",
		ring2="Mujin Band",
	}	
		
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
		main="Daybreak",
		sub="Ammurapi Shield",
		head=empty,
		body="Twilight Cloak",
	})

	sets.midcast.Dispellga = set_combine(sets.midcast['Enfeebling Magic'], {
		main="Daybreak",
		sub="Ammurapi Shield",
	})

    sets.midcast['Dark Magic'] = {
		main="Rubicundity",
		ammo="Pemphredo Tathlum",
		sub="Ammurapi Shield",
		head="Lethargy Chappel +1",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Atrophy Tabard +1",
		hands="Amalric Gages",
		ring1="Weatherspoon Ring +1",
		ring2="Kishar Ring",
		back="Ghostfyre Cape",
		waist="Refoccilation Stone",
		legs="Merlinic Shalwar",
		feet="Merlinic Crackows",
	}--Shango Robe --Sucellos's Cape

	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Impatiens",
		hands="Leyline Gloves",
		ring1="Weatherspoon Ring +1",
		ring2="Kishar Ring",
		back="Perimede Cape",
		waist="Witful Belt",
	})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main="Rubicundity",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		neck="Erra Pendant",
		ring1="Weatherspoon Ring +1",
		ring2="Kishar Ring",
		waist="Fucho-No-Obi",
	})--head="Merlinic Hood",waist="Fucho-No-Obi",ring1="Excelsis Ring"

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {
		sub="Ammurapi Shield",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands="Atrophy Gloves +1",
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet="Lethargy Houseaux +1",
		back="Ghostfyre Cape",
		waist="Embla Sash",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		ear1="Mimir Earring",
		ear2="Andoaa Earring",
		neck="Incanter's Torque",
	}
        
    sets.buff.ComposureOther = set_combine(sets.midcast.EnhancingDuration, {
		sub="Ammurapi Shield",
		head="Lethargy Chappel +1",
		body="Lethargy Sayon +1",
		hands="Lethargy Gantherots +1",
		legs="Lethargy Fuseau +1",
		feet="Lethargy Houseaux +1",
		back="Ghostfyre Cape",
	})

	--[[
		head="Lethargy Chappel +1",
		body="Lethargy Sayon +1",
		hands="Lethargy Gantherots +1",
		legs="Lethargy Fuseau +1",
		feet="Lethargy Houseaux +1",
	]]
    sets.buff.Saboteur = {
		hands="Lethargy Gantherots +1",
	}--Sucellos's Cape
    
	sets.buff.Enspell = {
		head="Umuthi Hat",
		hands="Aya. Manopolas +2",
		back="Ghostfyre Cape",
	}
	
	--[[
						Enspell Damage :
		
		Umuthi Hat					(DMG+8%)
		Aya. Manopolas +1 			(DMG+15%) / +2 (17%)
		Ghostfyre Cape				(DMG+5%)
	]]

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
		ammo="Ginsen",
		head="Befouled Crown",
		neck="Sanctity Necklace",
		ear2="Malignance Earring",
		ear1="Loquacious Earring",
		body="Jhakri Robe +2",
		hands="Serpentes Cuffs",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Umbra Cape",
		waist="Fucho-No-Obi",
		legs="Aya. Cosciales +1",
		feet="Serpentes Sabots",
	}

    -- Idle sets
    sets.idle = {
		ammo="Homiliary",
		head="Befouled Crown",
		neck="Loricate Torque +1",
		ear2="Malignance Earring",
		ear1="Loquacious Earring",
		body="Jhakri Robe +2",
		hands="Serpentes Cuffs",
		ring2="Stikini Ring +1",
		ring1="Stikini Ring +1",
		back="Umbra Cape",
		waist="Fucho-No-Obi",
		legs="Malignance Tights",
		feet="Serpentes Sabots",
	}--Homiliary/Fucho-No-Obi

    sets.idle.Town = {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Befouled Crown",
		neck="Loricate Torque +1",
		ear2="Malignance Earring",
		ear1="Loquacious Earring",
		body="Jhakri Robe +2",
		hands="Serpentes Cuffs",
		ring2="Stikini Ring +1",
		ring1="Stikini Ring +1",
		back="Umbra Cape",
		waist="Fucho-No-Obi",
		legs="Malignance Tights",
		feet="Serpentes Sabots",
	}
    
    sets.idle.Weak = {
		ammo="Homiliary",
		head="Befouled Crown",
		neck="Loricate Torque +1",
		ear2="Malignance Earring",
		ear1="Loquacious Earring",
		body="Jhakri Robe +2",
		hands="Serpentes Cuffs",
		ring2="Stikini Ring +1",
		ring1="Stikini Ring +1",
		back="Umbra Cape",
		waist="Fucho-No-Obi",
		legs="Malignance Tights",
		feet="Serpentes Sabots",
	}

    sets.idle.PDT = {
		ammo="Staunch Tathlum",
        head="Aya. Zucchetto +2",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Odnowa Earring",
        body="Ayanmo Corazza +2",
		hands="Malignance Gloves",
		ring1="Defending Ring",
		ring2="Dark Ring",
        back="Umbra Cape",
		waist="Flume Belt",
		legs="Malignance Tights",
		feet="Aya. Gambieras +1",
	}

    sets.idle.MDT = {
		ammo="Staunch Tathlum",
        head="Aya. Zucchetto +2",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Odnowa Earring",
        body="Ayanmo Corazza +2",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
        back="Umbra Cape",
		waist="Flume Belt",
		legs="Malignance Tights",
		feet="Volte Spats",
	}
    
    
    -- Defense sets
    sets.defense.PDT = {
		ammo="Staunch Tathlum",
		head="Aya. Zucchetto +2",
		neck="Loricate Torque +1",
		ear2="Malignance Earring",
		ear1="Loquacious Earring",
		body="Ayanmo Corazza +2",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Umbra Cape",
		waist="Flume Belt",
		legs="Malignance Tights",
		feet="Aya. Gambieras +1",
	}--Sucellos's Cape

    sets.defense.MDT = {
		ammo="Staunch Tathlum",
        head="Aya. Zucchetto +2",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Odnowa Earring",
        body="Ayanmo Corazza +2",
		hands="Malignance Gloves",
		ring2="Defending Ring",
		ring1="Shadow Ring",
        back="Umbra Cape",
		waist="Flume Belt",
		legs="Malignance Tights",
		feet="Volte Spats",
	}--Sucellos's Cape

    sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.Adoulin = {legs="Carmine Cuisses +1"}
	sets.MoveSpeed = {legs="Carmine Cuisses +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
	--Aya. Zucchetto +2
	--Ayanmo Corazza +2
	--Aya. Manopolas +1
	--Aya. Cosciales +1
	--Aya. Gambieras +1
	
    -- Normal melee group
    sets.engaged = {
		ammo="Ginsen",
		head="Aya. Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
		body="Ayanmo Corazza +2",
		hands="Malignance Gloves",
		ring1="Petrov Ring",
		ring2="Hetairoi Ring",
		back="Letalis Mantle",
		waist="Sarissapho Belt",
		legs="Malignance Tights",
		feet="Aya. Gambieras +1",
	}--Pya'ekue Belt --Sucellos's Cape

	sets.engaged.Haste = set_combine(sets.engaged,	{})

	sets.engaged.Enspell = set_combine(sets.engaged,	{
		head="Umuthi Hat",
		hands="Aya. Manopolas +2",
		back="Ghostfyre Cape",
	})
	
	sets.engaged.Acc = {
		ammo="Ginsen",
		head="Alhazen Hat +1",
		neck="Subtlety Spectacles",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
		body="Ayanmo Corazza +2",
		hands="Malignance Gloves",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		back="Letalis Mantle",
		waist="Kentarch Belt",
		legs="Malignance Tights",
		feet="Aya. Gambieras +1",
	}--Sucellos's Cape
	
	sets.engaged.Acc.Haste = set_combine(sets.engaged.Acc,	{})
	
	sets.engaged.Acc.Enspell = set_combine(sets.engaged.Acc,	{
		head="Umuthi Hat",
		hands="Aya. Manopolas +2",
		back="Ghostfyre Cape",
	})
	
    sets.engaged.Defense = {
		ammo="Staunch Tathlum",
		head="Aya. Zucchetto +2",
		neck="Loricate Torque +1",
		ear2="Malignance Earring",
		ear1="Loquacious Earring",
		body="Ayanmo Corazza +2",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Umbra Cape",
		waist="Flume Belt",
		legs="Malignance Tights",
		feet="Aya. Gambieras +1",
	}--Sucellos's Cape
	
	sets.engaged.Defense.Haste = set_combine(sets.engaged.Defense,	{})
	
	sets.engaged.Defense.Enspell = set_combine(sets.engaged.Defense,	{
		head="Umuthi Hat",
		hands="Aya. Manopolas +2",
		back="Ghostfyre Cape",
	})
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
	sets.buff.Doomed = {
		ring2="Saida Ring",
		waist="Gishdubar Sash",
	}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    
    --if spell.action_type == 'Magic' then
        
        if spell.skill == 'Enhancing Magic' then
            if Enspell:contains(spell.english) then
                ---return 'Enspell'
				equip(sets.midcast.Enspell)
            end
        end
    end

function customize_melee_set(meleeSet)
    if state.Buff.Enspell then
        meleeSet = set_combine(meleeSet, sets.buff.Enspell)
    end
	if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

--[[ (Coment out)


function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'Enthunder', 'Enthunder II', 'Enstone', 'Enstone II', 'Enaero', 'Enaero II', 'Enblizzard', 'Enblizzard II', 'Enfire', 'Enfire II', 'Enwater', 'Enwater II', 'Haste'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end
]]

--[[ 2nd part

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    --select_movement_feet()
    determine_haste_group()
end
]]


--[[ 3rd part

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    
    if Enspell then
        classes.CustomMeleeGroups:append('Enspell')
	elseif Enspell and  buffactive.haste then
        classes.CustomMeleeGroups:append('Enspell')
	elseif buffactive.haste then
        classes.CustomMeleeGroups:append('Haste')
	end
	
end
]]
-------------------- NEW Code

function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
	------------------
	if buff:startswith('En') then
            classes.CustomMeleeGroups:clear()

            if (buff == "Enthunder II" and gain) or buffactive['Enthunder II'] then
				classes.CustomMeleeGroups:append('Enspell')--Determines which Set it equips
				equip(sets.engaged.Enspell)
                add_to_chat(8, '-------Enspell set is now on-------')
            end
			
			if (buff == "Enthunder" and gain) or buffactive['Enthunder'] then
				classes.CustomMeleeGroups:append('Enspell')--Determines which Set it equips
				equip(sets.engaged.Enspell)
                add_to_chat(8, '-------Enspell set is now on-------')
            end

			if (buff == "Enfire II" and gain) or buffactive['Enfire II'] then
				classes.CustomMeleeGroups:append('Enspell')--Determines which Set it equips
				equip(sets.engaged.Enspell)
                add_to_chat(8, '-------Enspell set is now on-------')
            end

			if (buff == "Enfire" and gain) or buffactive['Enfire'] then
				classes.CustomMeleeGroups:append('Enspell')--Determines which Set it equips
				equip(sets.engaged.Enspell)
                add_to_chat(8, '-------Enspell set is now on-------')
            end
			
			if (buff == "Enstone II" and gain) or buffactive['Enstone II'] then
				classes.CustomMeleeGroups:append('Enspell')--Determines which Set it equips
				equip(sets.engaged.Enspell)
                add_to_chat(8, '-------Enspell set is now on-------')
            end
			
			if (buff == "Enstone" and gain) or buffactive['Enstone'] then
				classes.CustomMeleeGroups:append('Enspell')--Determines which Set it equips
				equip(sets.engaged.Enspell)
                add_to_chat(8, '-------Enspell set is now on-------')
            end
			
			if (buff == "Enwater II" and gain) or buffactive['Enwater II'] then
				classes.CustomMeleeGroups:append('Enspell')--Determines which Set it equips
				equip(sets.engaged.Enspell)
                add_to_chat(8, '-------Enspell set is now on-------')
            end
			
			if (buff == "Enwater" and gain) or buffactive['Enwater'] then
				classes.CustomMeleeGroups:append('Enspell')--Determines which Set it equips
				equip(sets.engaged.Enspell)
                add_to_chat(8, '-------Enspell set is now on-------')
            end
			
			if (buff == "Enaero II" and gain) or buffactive['Enaero II'] then
				classes.CustomMeleeGroups:append('Enspell')--Determines which Set it equips
				equip(sets.engaged.Enspell)
                add_to_chat(8, '-------Enspell set is now on-------')
            end
			
			if (buff == "Enaero" and gain) or buffactive['Enaero'] then
				classes.CustomMeleeGroups:append('Enspell')--Determines which Set it equips
				equip(sets.engaged.Enspell)
                add_to_chat(8, '-------Enspell set is now on-------')
            end
			
			if (buff == "Enblizzard II" and gain) or buffactive['Enblizzard II'] then
				classes.CustomMeleeGroups:append('Enspell')--Determines which Set it equips
				equip(sets.engaged.Enspell)
                add_to_chat(8, '-------Enspell set is now on-------')
            end
			
			if (buff == "Enblizzard" and gain) or buffactive['Enblizzard'] then
				classes.CustomMeleeGroups:append('Enspell')--Determines which Set it equips
				equip(sets.engaged.Enspell)
                add_to_chat(8, '-------Enspell set is now on-------')
            end
			
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    
	
	----------------------Mythic-------------------
--[[    if buff:startswith('Aftermath') then
        if player.equipment.main == 'Tizona' then
            classes.CustomMeleeGroups:clear()

            if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
				classes.CustomMeleeGroups:append('Aftermath3')--Determines which Set it equips
				equip(sets.engaged.TizonaAftermath3)
                add_to_chat(8, '-------AM3 UP(Occ. Attacks x2(40%) to x3(20%)-------')
            end

			if (buff == "Aftermath: Lv.2" and gain) or buffactive['Aftermath: Lv.2'] then
                classes.CustomMeleeGroups:append('AM2')--Determines which Set it equips
				equip(sets.engaged)
                add_to_chat(8, '-------------AM2 UP(M.ACC+)-------------')
            end
			
			if (buff == "Aftermath: Lv.1" and gain) or buffactive['Aftermath: Lv.1'] then
                classes.CustomMeleeGroups:append('AM1')--Determines which Set it equips
                equip(sets.engaged)
				add_to_chat(8, '-------------AM1 UP(ACC+30~49)-------------')
            end
			
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
				-------------Empy----------------
	if buff:startswith('Aftermath') then
        if player.equipment.main == 'Almace' then
            classes.CustomMeleeGroups:clear()

            if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
				classes.CustomMeleeGroups:append('Aftermath3')--Determines which Set it equips
				equip(sets.engaged.AlmaceAftermath3)
                add_to_chat(8, '-------AM3 UP(Occ. Deals Double DMG +50%)-------')
            end

			if (buff == "Aftermath: Lv.2" and gain) or buffactive['Aftermath: Lv.2'] then
                classes.CustomMeleeGroups:append('AM2')--Determines which Set it equips
				equip(sets.engaged.AlmaceAftermath3)
                add_to_chat(8, '-------------AM2 UP(Occ. Deals Double DMG+40%)-------------')
            end
			
			if (buff == "Aftermath: Lv.1" and gain) or buffactive['Aftermath: Lv.1'] then
                classes.CustomMeleeGroups:append('AM1')--Determines which Set it equips
                equip(sets.engaged.AlmaceAftermath3)
				add_to_chat(8, '-------------AM1 UP(Occ. Deals Double DMG+30%)-------------')
            end
	]]		
            if not midaction() then
                handle_equipping_gear(player.status)
            end
end
   


function determine_haste_group()

    classes.CustomMeleeGroups:clear()
    -- mythic AM	
  		if buffactive['Enthunder II'] then
			classes.CustomMeleeGroups:append('Enspell')
			equip(sets.engaged.Enspell)
		end
		
		if buffactive['Enthunder'] then
			classes.CustomMeleeGroups:append('Enspell')
			equip(sets.engaged.Enspell)
		end
		
		if buffactive['Enfire II'] then
			classes.CustomMeleeGroups:append('Enspell')
			equip(sets.engaged.Enspell)
		end
		
		if buffactive['Enfire'] then
			classes.CustomMeleeGroups:append('Enspell')
			equip(sets.engaged.Enspell)
		end

		if buffactive['Enstone II'] then
			classes.CustomMeleeGroups:append('Enspell')
			equip(sets.engaged.Enspell)
		end
		
		if buffactive['Enstone'] then
			classes.CustomMeleeGroups:append('Enspell')
			equip(sets.engaged.Enspell)
		end
   
		if buffactive['Enwater II'] then
			classes.CustomMeleeGroups:append('Enspell')
			equip(sets.engaged.Enspell)
		end
   
		if buffactive['Enwater'] then
			classes.CustomMeleeGroups:append('Enspell')
			equip(sets.engaged.Enspell)
		end
		
		if buffactive['Enaero II'] then
			classes.CustomMeleeGroups:append('Enspell')
			equip(sets.engaged.Enspell)
		end
		
		if buffactive['Enaero'] then
			classes.CustomMeleeGroups:append('Enspell')
			equip(sets.engaged.Enspell)
		end
		
		if buffactive['Enblizzard II'] then
			classes.CustomMeleeGroups:append('Enspell')
			equip(sets.engaged.Enspell)
		end
		
		if buffactive['Enblizzard'] then
			classes.CustomMeleeGroups:append('Enspell')
			equip(sets.engaged.Enspell)
		end
end

---------------END OF NEW CODE

--[[
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            --enable('main','sub','range')
        else
            --disable('main','sub','range')
        end
    end
end
]]

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Hachirin-no-Obi"
    elseif spell.skill == 'Elemental Magic' then
        --gear.default.obi_waist = "Refoccilation Stone"
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)

    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.self_healing)
    end
    --if spell.action_type == 'Magic' then
       -- apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    --end
	if spell.skill == 'Elemental Magic'  then
        if spell.element == world.day_element or spell.element == world.weather_element then
            equip({waist="Hachirin-No-Obi"})
            --add_to_chat(8,'----- Hachirin-no-Obi Equipped. -----')
        end
    end
	if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
        equip(sets.magic_burst)
        end
	end
	if spell.type == "WeaponSkill" then
      if spell.element == world.weather_element or spell.element == world.day_element then
        --equip({waist="Hachirin-no-Obi"})
        --add_to_chat(8,'----- Hachirin-no-Obi Equipped. -----')
      end
    end
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        --equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
end


function validateTextInformation()
if state.LockWeapon.value then
        --main_text_hub.toggle_lock_weapon = const_on
    else
        --main_text_hub.toggle_lock_weapon = const_off
    end
end

function job_state_change(stateField, newValue, oldValue)
   if stateField == "Lock Weapon" then --Updates HUB and disables/enables window for Lock Weapon
        if newValue == true then
			disable("main")
			disable("sub")
            --main_text_hub.toggle_lock_weapon = "ON"
        else
            enable("main")
			enable("sub")
            --main_text_hub.toggle_lock_weapon = "OFF"
        end 
end
end
------------------------------------Mov---------------------------------------------
mov= {counter=0}
if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
	mov.x = windower.ffxi.get_mob_by_index(player.index).x
	mov.y = windower.ffxi.get_mob_by_index(player.index).y
	mov.z = windower.ffxi.get_mob_by_index(player.index).z
end	

moving = false
windower.raw_register_event('prerender', function()
	mov.counter = mov.counter +1;
	if buffactive['Mana Wall'] then
		moving = false
	elseif mov.counter > 15 then
		local p1 = windower.ffxi.get_mob_by_index(player.index)
		if p1 and p1.x and mov.x then
			dist = math.sqrt( (p1.x-mov.x)^2 + (p1.y-mov.y)^2 + (p1.z-mov.z)^2 )
			if dist > 1 and not moving then
				state.Moving.value = true
				send_command('gs c update')
				if world.area:contains("Adoulin") then
					send_command('gs equip sets.Adoulin')
					else
					send_command('gs equip sets.MoveSpeed')
				end
		moving = true
			elseif dist < 1 and moving then
				state.Moving.value = false
				send_command('gs c update')
				moving = false
			end
		end
	if p1 and p1.x then
		mov.x = p1.x
		mov.y = p1.y
		mov.z = p1.z
	end
	
	mov.counter = 0

	end
end)
------------------------Auto-Refresh-------------------------------------------------
function job_post_aftercast(spell, action, spellMap, eventArgs)
    if spell.type ~= 'JobAbility' then
        auto_refresh()
    end
end


function auto_refresh()
    local spell_recasts = windower.ffxi.get_spell_recasts()
    if state.Refresh.value == true then 
	if not (buffactive['Refresh']) then
        if not (buffactive['Invisible'] or buffactive['Weakness'] or buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete']) then
            if spell_recasts[10] == 0 then
                send_command('@wait 2;input /ma "Refresh" <me>')
            end
        end
    
    end         
end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    
	if not spell.interrupted and spell.english == S{'Enthunder', 'Enthunder II', 'Enstone', 'Enstone II', 'Enaero', 'Enaero II', 'Enblizzard', 'Enblizzard II', 'Enfire', 'Enfire II', 'Enwater', 'Enwater II'} then
        State.Buff.Enspell = true
    end

    -- Lock feet after using Mana Wall.
    --if not spell.interrupted then
        --spell.skill == 'Elemental Magic' then
          --  state.MagicBurst:reset()
        --end
--end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 5)
	elseif player.sub_job == 'WHM' then
        set_macro_page(1, 5)
	elseif player.sub_job == 'BLM' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'SCH' then
        set_macro_page(1, 5)
	elseif player.sub_job == 'THF' then
        set_macro_page(1, 5)
    else
        set_macro_page(1, 5)
    end
end
end