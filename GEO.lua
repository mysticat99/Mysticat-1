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
	state.Buff.Doomed = buffactive.doomed or false
    indi_timer = ''
    indi_duration = 180
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Crits')--'Resistant',
    state.IdleMode:options('Normal', 'PDT')

	state.MagicBurst = M(false, 'Magic Burst')
	
    gear.default.weaponskill_waist = "Fotia Belt"

    select_default_macro_book()
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
end

function user_unload()
	send_command("unbind !`")
	send_command("unbind !end")
	send_command("unbind Delete")
end

organizer_items = {
	--reraisehead="White Rarab Cap +1",
}


-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
	sets.precast.JA['Cardinal Chant'] = {
		head="Geomancy Galero +1",
	}
	sets.precast.JA['Collimated Fervor'] = {
		head="Bagua Galero +1",
	}
	sets.precast.JA['Radial Arcana'] = {
		feet="Bagua Sandals +1",
	}
	sets.precast.JA['Life Cycle'] = {
		body="Geomancy Tunic +3",
		back="Nantosuelta's Cape",
	}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +1"}
	sets.precast.JA['Full Cycle'] = {
		hands="Bagua Mitaines +1",
		head="Azimuth Hood +1",
	}
	sets.precast.Bolster = {
		body="Bagua Tunic +1",
	}
	
    -- Fast cast sets for spells
	
	sets.precast.Waltz = {
		head="Geo. Galero +1",
		body="Bagua Tunic +1",
		hands="Geo. Mitaines +3",
		legs="Bagua Pants +1",
		feet="Geo. Sandals +2",
		neck="Unmoving Collar +1",
		ring1="Titan Ring +1",
		ring2="Titan Ring",
		ear1="Odnowa Earring +1",
		ear2="Odnowa Earring",
		back="Iximulew Cape",
	}
	
    sets.precast.FC = {
		main="Solstice",
		sub="Ammurapi Shield",
		head="Nahtirah Hat",
		neck="Voltsurge Torque",
		ear2="Malignance Earring",
		ear1="Loquacious Earring",
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body="Eirene's Manteel",
		ring1="Weatherspoon Ring +1",
		ring2="Kishar Ring",
		back="Perimede Cape",
		waist="Witful Belt",
		legs="Geo. Pants +3",
		feet="Regal Pumps +1",
	}

	sets.precast.FC.Cure = {
		main="Daybreak",
		sub="Sors Shield",
		head="Nahtirah Hat",
		ear2="Mendi. Earring",
		ear1="Loquacious Earring",
		neck="Voltsurge Torque",
		body="Heka's Kalasiris",
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ring1="Weatherspoon Ring +1",
		ring2="Kishar Ring",
		back="Pahtli Cape",
		waist="Witful Belt",
		legs="Doyen Pants",
		feet="Regal Pumps +1",
	}--Geo. Pants +1

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		neck="Stoicheion Medal",
		body="Vedic Coat",
	})
    
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash",
		feet="Regal Pumps +1",
		sub="Ammurapi Shield",
	})

	----------------------------------------------------------------
	----------------------------------------------------------------
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {
		neck="Nodens Gorget",
		feet="Regal Pumps +1",
		legs="Doyen Pants",
		sub="Ammurapi Shield",
	})
	
	----------------------------------------------------------------
	----------------------------------------------------------------
	
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Jhakri Coronal +1",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +1",
		ring1="Shukuyu Ring",
		ring2="Rufescent Ring",
		back="Lifestream Cape",
		waist="Fotia Belt",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches +1",
	}--Bagua Pants +1/Bagua Tunic +1/Geomancy Galero +1/Bagua Tunic +1
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Flash Nova'] = {
		head="Merlinic Hood",
		neck="Baetyl Pendant",
		ear2="Malignance Earring",
		ear1="Barkarole Earring",
		body="Jhakri Robe +2",
		hands="Ea Cuffs",
		ring1="Fenrir Ring",
		ring2="Shiva Ring +1",
		back="Nantosuelta's Cape",
		waist="Fotia Belt",
		legs="Merlinic Shalwar",
		feet="Merlinic Crackows",
	}--"Witching Robe"
    
	sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}

	sets.precast.WS['Exudation'] = {
		head="Buremte Hat",
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Malignance Earring",
		body="Geomancy Tunic +3",
		hands="Geo. Mitaines +3",
		ring1="Stikini Ring +1",
		ring2="Rufescent Ring",
		back="Nantosuelta's Cape",
		waist="Fotia Belt",
		legs="Geo. Pants +3",
		feet="Geo. Sandals +2",
	}--Bagua Pants +1/Buremte Hat

	sets.precast.WS['Realmrazer'] = {
		head="Buremte Hat",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Jhakri Robe +2",
		hands="Ea Cuffs",
		ring1="Stikini Ring +1",
		ring2="Rufescent Ring",
		back="Nantosuelta's Cape",
		waist="Fotia Belt",
		legs="Merlinic Shalwar",
		feet="Merlinic Crackows",
	}--Bagua Pants +1/Buremte Hat 

    --------------------------------------
    -- Midcast sets
    --------------------------------------

		sets.midcast.Bolster = {
			body="Bagua Tunic +1",
		}
        sets.midcast['Life Cycle'] = {
			body="Geomancy Tunic +3",
		}
        sets.midcast['Mending Halation'] = {
			legs="Bagua Pants +1",
		}
        sets.midcast['Radial Arcana'] = {
			feet="Bagua Sandals +1",
		}
        sets.midcast.Bolster.Pet = {
			body="Bagua Tunic +1",
		}
        sets.midcast['Life Cycle'].Pet = {
			body="Geomancy Tunic +3",
		}
        sets.midcast['Mending Halation'].Pet = {
			legs="Bagua Pants +1",
		}        
		sets.midcast.Bolster.Pet.Indi = {
			body="Bagua Tunic +1",
		}
        sets.midcast['Life Cycle'].Pet.Indi = {
			body="Geomancy Tunic +3",
		}
        sets.midcast['Mending Halation'].Pet.Indi = {
			legs="Bagua Pants +1",
		}
	
    -- Base fast recast for spells
    sets.midcast.FastRecast = {
		main="Solstice",
		head="Nahtirah Hat",
		ear2="Malignance Earring",
		ear1="Loquacious Earring",
		body="Eirene's Manteel",
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ring1="Weatherspoon Ring +1",
		ring2="Kishar Ring",
		neck="Voltsurge Torque",
		back="Lifestream Cape",
		waist="Witful Belt",
		legs="Geo. Pants +3",
		feet="Regal Pumps +1",
	}

    sets.midcast.Geomancy = {
		main="Idris",
		range="Dunna",
		head="Azimuth Hood +1",
		body="Bagua Tunic +1",
		hands="Geo. Mitaines +3",
		legs="Bagua Pants +1",
		feet="Medium's Sabots",
		ear1="Gifted Earring",
		ear2="Magnetic Earring",
		neck="Incanter's Torque",
		back="Lifestream Cape",
		waist="Kobo Obi",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
	}--"Stikini Ring +1"
		
    sets.midcast.Geomancy.Indi = {
		main="Idris",
		range="Dunna",
		head="Azimuth Hood +1",
		body="Bagua Tunic +1",
		hands="Geo. Mitaines +3",
		legs="Bagua Pants +1",
		feet="Azimuth Gaiters +1",
		ear1="Gifted Earring",
		ear2="Magnetic Earring",
		neck="Incanter's Torque",
		back="Lifestream Cape",
		waist="Kobo Obi",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
	}--"Stikini Ring +1"

    sets.midcast.Cure = set_combine(sets.precast.FC, {
		main="Daybreak",
		sub="Sors Shield",
		head="Vanya Hood",
		body="Heka's Kalasiris",
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs="Nares Trews",
		feet="Medium's Sabots",
		ear1="Meili Earring",
		ear2="Mendi. Earring",
		neck="Nodens Gorget",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Pahtli Cape",
		waist="Luminary Sash",
	})
    
    sets.midcast.Curaga = sets.midcast.Cure

	 sets.midcast['Enhancing Magic'] = set_combine(sets.precast.FastRecast,    {
		main="Solstice",
		sub="Ammurapi Shield",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Mimir Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Perimede Cape",
		waist="Embla Sash",
	})

	--[[
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
	]]

	-- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast.EnhancingMagic = set_combine(sets.precast.FastRecast,    {
		main="Solstice",
		sub="Ammurapi Shield",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Mimir Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Perimede Cape",
		waist="Embla Sash",
	})
		
	sets.midcast.Haste = set_combine(sets.precast.FastRecast,    {
		main="Solstice",
		sub="Ammurapi Shield",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Mimir Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Perimede Cape",
		waist="Embla Sash",
	})
	
	sets.midcast.Phalanx = set_combine(sets.precast.FastRecast,    {
		main="Solstice",
		sub="Ammurapi Shield",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Mimir Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Perimede Cape",
		waist="Embla Sash",
	})
	
	sets.midcast.Blink = set_combine(sets.precast.FastRecast,    {
		main="Solstice",
		sub="Ammurapi Shield",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Mimir Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Perimede Cape",
		waist="Embla Sash",
	})
	
	sets.midcast.Aquaveil = set_combine(sets.precast.FastRecast,    {
		main="Solstice",
		sub="Ammurapi Shield",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Mimir Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Perimede Cape",
		waist="Embla Sash",
	})
	
	sets.midcast.Flurry = set_combine(sets.precast.FastRecast,    {
		main="Solstice",
		sub="Ammurapi Shield",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Mimir Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Perimede Cape",
		waist="Embla Sash",
	})
	
    sets.midcast.Protectra = set_combine(sets.precast.FC, {
		main="Solstice",
		sub="Ammurapi Shield",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Mimir Earring",
		ring1="Sheltered Ring",
		ring2="Stikini Ring +1",
		back="Perimede Cape",
		waist="Embla Sash",
	})
	sets.midcast.Protect = sets.midcast.Protectra
	
	sets.midcast.Shellra = set_combine(sets.precast.FC, {
		main="Solstice",
		sub="Ammurapi Shield",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Mimir Earring",
		ring1="Sheltered Ring",
		ring2="Stikini Ring +1",
		back="Perimede Cape",
		waist="Embla Sash",
	})
	sets.midcast.Shell = sets.midcast.Shellra

	sets.midcast.Stoneskin = set_combine(sets.precast.FC, {
		main="Solstice",
		sub="Ammurapi Shield",
		head="Umuthi Hat",
		waist="Siegel Sash",
		ear2="Andoaa Earring",
		ear2="Earthcry Earring",
		legs="Haven Hose",
		neck="Nodens Gorget",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
	})

	sets.midcast.Regen = set_combine(sets.precast.FC, {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Mimir Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Perimede Cape",
		waist="Embla Sash",
	})

	sets.midcast.Refresh = set_combine(sets.precast.FC, {
		sub="Ammurapi Shield",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet="Inspirited Boots",
		ear2="Andoaa Earring",
		ear1="Mimir Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Perimede Cape",
		waist="Gishdubar Sash",
	})

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'],    {
		sub="Ammurapi Shield",
		head="Befouled Crown",
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		ear2="Andoaa Earring",
		ear1="Mimir Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Perimede Cape",
		waist="Embla Sash",
	})
	-----------------------------------------------------------------------------------------
	--Cursna SET (Affected by Healing Skill+)
	--main="Gada"
	--head="Vanya Hood"
	--body="Vanya Robe"
	--hands=""
	--legs="Vanya Slops"
	--feet="Vanya Clogs"
	--waist="Gishdubar Sash"
	--back="Oretan. Cape +1"
	--ring1="Haoma's Ring"
	--ring2="Haoma's Ring"
	sets.midcast.Cursna = set_combine(sets.precast.FC, {
		main="Solstice",
		ring1="Haoma's Ring",
		ring2="Haoma's Ring",
		ear1="Meili Earring",
		ear2="Andoaa Earring",
		neck="Malison Medallion",
		head="Vanya Hood",
		waist="Gishdubar Sash",
	})
	
	-------------------------------------------------------------------------------------
	
	sets.midcast['Elemental Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		head="Merlinic Hood",
		neck="Baetyl Pendant",
		ear1="Barkarole Earring",
		ear2="Malignance Earring",
		body="Jhakri Robe +2",
		hands="Ea Cuffs",
		ring2="Shiva Ring +1",
		ring1="Shiva Ring",
		back="Nantosuelta's Cape",
		waist="Refoccilation Stone",
		legs="Merlinic Shalwar",
		feet="Merlinic Crackows",
	}--Buremte Hat/Azimuth Coat/Lengo Pants/Loagaeth Cuffs/Welkin Crown/Azimuth Coat/Jhakri Robe +1/Witching Robe/Wretched Coat/Count's Garb / "Malignance Earring" / "Regal Earring"
	
	sets.midcast['Elemental Magic'].Crits = {
		main="Daybreak",
		sub="Ammurapi Shield",
		head="Merlinic Hood",
		neck="Baetyl Pendant",
		ear1="Barkarole Earring",
		ear2="Malignance Earring",
		body="Count's Garb",
		hands="Ea Cuffs",
		ring1="Shiva Ring",
		ring2="Shiva Ring +1",
		back="Nantosuelta's Cape",
		waist="Refoccilation Stone",
		legs="Merlinic Shalwar",
		feet="Merlinic Crackows",
	}--Buremte Hat/Azimuth Coat/Lengo Pants/Loagaeth Cuffs/Welkin Crown/Azimuth Coat/Jhakri Robe +1/Witching Robe/Wretched Coat/Count's Garb
	
	sets.magic_burst = {
		neck="Mizukage-no-Kubikazari",
		ring1="Mujin Band",
		ring2="Locus Ring",
		hands="Ea Cuffs",
	}--Count's Garb
	
	sets.midcast['Enfeebling Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		head="Merlinic Hood",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Geomancy Tunic +3",
		hands="Geo. Mitaines +3",
		ring1="Weatherspoon Ring +1",
		ring2="Kishar Ring",
		back="Nantosuelta's Cape",
		waist="Luminary Sash",
		legs="Geo. Pants +3",
		feet="Geo. Sandals +2",
	}--Nahtirah Hat/Azimuth Gloves/Ischemia Chasu.
	
	sets.midcast.Drain = {
		main="Rubicundity",
		sub="Ammurapi Shield",
		head="Bagua Galero +1",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Geomancy Tunic +3",
		hands="Geo. Mitaines +3",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Nantosuelta's Cape",
		waist="Fucho-No-Obi",
		legs="Azimuth Tights",
		feet="Merlinic Crackows",
	}--Jhakri Robe +2 / Geo. Tunic +1

	sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast.Stun = {
		main="Daybreak",
		sub="Ammurapi Shield",
		head="Merlinic Hood",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Geomancy Tunic +3",
		hands="Geo. Mitaines +3",
		ring1="Weatherspoon Ring +1",
		ring2="Stikini Ring +1",
		back="Nantosuelta's Cape",
		waist="Luminary Sash",
		legs="Geo. Pants +3",
		feet="Geo. Sandals +2",
	}
	
	sets.midcast.Dispellga = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak"})
	
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {
		main="Bolelabunga",
		head="Befouled Crown",
		neck="Sanctity Necklace",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Jhakri Robe +2",
		hands="Bagua Mitaines +1",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Umbra Cape",
		waist="Fucho-No-Obi",
		legs="Assiduity Pants +1",
		feet="Serpentes Sabots",
	}--Refresh Head soon.

		
																	-- EMPERYAN ARMOR :

--Azimuth Hood = DEF:72 HP+15 MP+46 STR+10 DEX+10 VIT+10 AGI+2 INT+21 MND+13 CHR+13 Evasion+15 Magic Evasion+58 "Magic Def. Bonus"+3 Haste+5% Geomancy skill +10 "Full Circle"+1 Luopan: "Regen"+2 Set: MP occasionally not depleted when using geomancy spells


--Azimuth Coat = DEF:92 HP+23 MP+56 STR+12 DEX+12 VIT+12 AGI+12 INT+22 MND+17 CHR+17 Evasion+17 Magic Evasion+62 Magic Accuracy+13 "Magic Atk. Bonus"+13 "Magic Def. Bonus"+3 Haste+2% Elemental magic skill +13 Enmity-7 "Refresh"+2 Set: MP occasionally not depleted when using geomancy spells
--Azimuth Coat = DEF:92 HP+23 MP+56 STR+12 DEX+12 VIT+12 AGI+12 INT+22 MND+17 CHR+17 Evasion+17 Magic Evasion+62 Magic Accuracy+13 "Magic Atk. Bonus"+13 "Magic Def. Bonus"+3 Haste+2% Elemental magic skill +13 Enmity-7 "Refresh"+2 Set: MP occasionally not depleted when using geomancy spells


--Azimuth Gloves = DEF:62 HP+8 MP+57 STR+4 DEX+16 VIT+14 AGI+3 INT+13 MND+20 CHR+11 Magic Accuracy+17 Evasion+8 Magic Evasion+32 "Magic Def. Bonus"+1 Enfeebling magic skill +13 Haste+3% Enmity-10 Set: MP occasionally not depleted when using geomancy spells


--Azimuth Tights = DEF:80 HP+18 MP+36 STR+13 VIT+5 AGI+10 INT+31 MND+14 CHR+11 Magic Accuracy+10 "Magic Atk. Bonus"+10 Evasion+11 Magic Evasion+80 "Magic Def. Bonus"+3 Dark magic skill +15 Haste+4% Set: MP occasionally not depleted when using geomancy spells


--Azimuth Gaiters = DEF:49 HP+34 MP+47 STR+5 DEX+5 VIT+5 AGI+18 INT+12 MND+11 CHR+20 Evasion+28 Magic Evasion+80"Magic Def. Bonus"+3 Haste+3% "Indicolure" spell duration +15 Physical damage taken -3% Set: MP occasionally not depleted when using geomancy spells

--Solstice = Handbell Skill+5 Conserve MP+6 Indi Spell +15

--Lifestream Cape (DEF:13 HP+50 MP+50 Enfeebling Magic Skill +10 Fast Cast+10% GEOMANCY SKILL +15 Indi. Duration+15 DT-2% PET: DT-4%)

--Nantosuelta's Cape (DEF:15 Indicolure effect duration +20 "Life Cycle"+10)

    -- Idle sets

	-- .Indi sets are for when an Indi-spell is active.
	
    sets.idle = {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		range="Dunna",
		head="Befouled Crown",
		neck="Sanctity Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
		body="Jhakri Robe +2",
		hands="Bagua Mitaines +1",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Umbra Cape",
		waist="Fucho-No-Obi",
		legs="Assiduity Pants +1",
		feet="Bagua Sandals +1",
	}--Arciela's Grace +1,Lifestream Cape

    sets.idle.PDT = {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		range="Dunna",
		head="Befouled Crown",
		neck="Loricate Torque +1",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
		body="Jhakri Robe +2",
		hands="Geo. Mitaines +3",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Umbra Cape",
		waist="Refoccilation Stone",
		legs="Assiduity Pants +1",
		feet="Geo. Sandals +2",
	}

	sets.idle.MDT = {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		range="Dunna",
		head="Befouled Crown",
		neck="Loricate Torque +1",
		ear1="Handler's Earring +1",
		ear1="Enmerkar Earring",
		body="Jhakri Robe +2",
		hands="Geo. Mitaines +3",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Solemnity Cape",
		waist="Isa Belt",
		legs="Assiduity Pants +1",
		feet="Merlinic Crackows",
	}	
		
    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {
		main="Idris",
		sub="Ammurapi Shield",
		range="Dunna",
		head="Azimuth Hood +1",
		neck="Incanter's Torque",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
		body="Jhakri Robe +2",
		hands="Geo. Mitaines +3",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Lifestream Cape",
		waist="Isa Belt",
		legs="Bagua Pants +1",
		feet="Bagua Sandals +1",
	}
		-------------------------------------------------------------------------------------
		-------------------------------------------------------------------------------------
		
		--body={ name="Telchine Chas.", augments={'Pet: Evasion+10','Pet: "Regen"+3','Pet: Damage taken -3%',}},
		
		--hands={ name="Telchine Gloves", augments={'Pet: Evasion+18','Pet: "Regen"+3','Pet: Damage taken -2%',}},
		
		--legs={ name="Telchine Braconi", augments={'Pet: Evasion+9','Pet: "Regen"+3','Pet: Damage taken -4%',}},
		
		-------------------------------------------------------------------------------------
		-------------------------------------------------------------------------------------
	-- Pet Regen:
    sets.idle.PDT.Pet = {
		main="Idris",
		sub="Ammurapi Shield",
		range="Dunna",
		head="Azimuth Hood +1",
		neck="Sanctity Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
		body={ name="Telchine Chas.", augments={'Pet: Evasion+10','Pet: "Regen"+3','Pet: Damage taken -3%',}},
		hands={ name="Telchine Gloves", augments={'Pet: Evasion+18','Pet: "Regen"+3','Pet: Damage taken -2%',}},
		legs={ name="Telchine Braconi", augments={'Pet: Evasion+9','Pet: "Regen"+3','Pet: Damage taken -4%',}},
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Nantosuelta's Cape",
		waist="Isa Belt",
		feet="Bagua Sandals +1",
	}
	
	sets.idle.Indi = set_combine(sets.midcast.Geomancy.Indi, {})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    sets.idle.PDT.Indi = set_combine(sets.midcast.Geomancy.Indi, {})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})
	
    -- .Indi sets are for when an Indi-spell is active.
    --sets.idle.Indi = set_combine(sets.idle, {main="Idris",legs="Bagua Pants +1",feet="Azimuth Gaiters +1",back="Nantosuelta's Cape",ring1="Stikini Ring +1",ring2="Stikini Ring +1"})
    --sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {main="Idris",legs="Bagua Pants +1",feet="Azimuth Gaiters +1",back="Nantosuelta's Cape",ring1="Stikini Ring +1",ring2="Stikini Ring +1"})
	
	-- Pet Regen:
    --sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {main="Idris",legs="Bagua Pants +1",feet="Bagua Sandals +1",back="Nantosuelta's Cape",ring1="Stikini Ring +1",ring2="Stikini Ring +1"})
    --sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {main="Idris",legs="Bagua Pants +1",feet="Bagua Sandals +1",back="Nantosuelta's Cape"})

	-- Town and Others
	
    sets.idle.Town = {
		main="Idris",
		sub="Ammurapi Shield",
		range="Dunna",
		head="Befouled Crown",
		neck="Sanctity Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
		body="Jhakri Robe +2",
		hands="Bagua Mitaines +1",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Lifestream Cape",
		waist="Fucho-No-Obi",
		legs="Azimuth Tights",
		feet="Bagua Sandals +1",
	} --Bolelabunga/Paguroidea Ring

    sets.idle.Weak = {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		range="Dunna",
		head="Befouled Crown",
		neck="Sanctity Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
		body="Jhakri Robe +2",
		hands="Bagua Mitaines +1",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Umbra Cape",
		waist="Fucho-No-Obi",
		legs="Assiduity Pants +1",
		feet="Bagua Sandals +1",
	}

    -- Defense sets

    sets.defense.PDT = {
		main="Idris",
		sub="Ammurapi Shield",
		range="Dunna",
		head="Jhakri Coronal +1",
		neck="Loricate Torque +1",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
		body="Geomancy Tunic +3",
		hands="Geo. Mitaines +3",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Umbra Cape",
		waist="Isa Belt",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches +1",
	}

    sets.defense.MDT = {
		main="Idris",
		sub="Ammurapi Shield",
		range="Dunna",
		head="Nahtirah Hat",
		neck="Loricate Torque +1",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
		body="Geomancy Tunic +3",
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Solemnity Cape",
		waist="Isa Belt",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches +1",
	}

    sets.Kiting = {feet="Geo. Sandals +2"}
	sets.Adoulin = {feet="Geo. Sandals +2"}
	sets.MoveSpeed = {feet="Geo. Sandals +2"}
	
    sets.latent_refresh = {waist="Fucho-No-Obi"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
		main="Idris",
		range="Dunna",
		head="Jhakri Coronal +1",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +1",
		ring1="Petrov Ring",
		ring2="Hetairoi Ring",
		back="Solemnity Cape",
		waist="Windbuffet Belt +1",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches +1",
	}--Count's Garb

	sets.engaged.Acc = {
		main="Idris",
		range="Dunna",
		head="Alhazen Hat +1",
		neck="Subtley Spec.",
		ear1="Telos Earring",
		ear2="Digni. Earring",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +1",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		back="Solemnity Cape",
		waist="Witful Belt",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches +1",
	}
		
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

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
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
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'White Magic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	
	if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
	
end


---------------------------------------------------------------------------------------------------------------------Auto Sublimation-----------------------------------
------------------------------------------------------------------------------------
--If MP is below 45% will auto-activate uppon using any spell 
--and 
--when it becomes "Complete" if MP is still Below 75% it will auto-activate uppon using any spell.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function job_post_aftercast(spell, action, spellMap, eventArgs)
    if spell.type ~= 'JobAbility' then
        auto_sublimation()
    end
end
 
function auto_sublimation()
    local abil_recasts = windower.ffxi.get_ability_recasts()
    if not (buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete']) then
        if not (buffactive['Invisible'] or buffactive['Weakness']) then
            if abil_recasts[234] == 0 then
                send_command('@wait 2;input /ja "Sublimation" <me>')
            end
        end
    elseif buffactive['Sublimation: Complete'] then
        if player.mpp < 45 and abil_recasts[234] == 0 then
            send_command('@wait 2;input /ja "Sublimation" <me>')
        end
    end         
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------




-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 11)
end
