---------------------------------------------------------------------------
--
--   cocktail.lua
--
--   MAME target COCKTAIL subtarget makefile
--
---------------------------------------------------------------------------

--------------------------------------------------
-- specify required CPU cores
--------------------------------------------------

CPUS["I8085"] = true
CPUS["I86"] = true
CPUS["M6502"] = true
CPUS["M6800"] = true
CPUS["M6805"] = true
CPUS["M6809"] = true
CPUS["M680X0"] = true
CPUS["MB88XX"] = true
CPUS["MCS48"] = true
CPUS["MCS51"] = true
CPUS["S2650"] = true
CPUS["TMS32010"] = true
CPUS["TMS57002"] = true
CPUS["Z80"] = true

--------------------------------------------------
-- specify required sound cores
--------------------------------------------------

SOUNDS["ASTROCADE"] = true
SOUNDS["AY8910"] = true
SOUNDS["DAC"] = true
SOUNDS["DIGITALKER"] = true
SOUNDS["DISCRETE"] = true
SOUNDS["HC55516"] = true
SOUNDS["M58817"] = true
SOUNDS["MSM5205"] = true
SOUNDS["NAMCO"] = true
SOUNDS["NES_APU"] = true
SOUNDS["OKIM6295"] = true
SOUNDS["POKEY"] = true
SOUNDS["SN76477"] = true
SOUNDS["SN76496"] = true
SOUNDS["SP0250"] = true
SOUNDS["TC8830F"] = true
SOUNDS["TMS36XX"] = true
SOUNDS["TMS5110"] = true
SOUNDS["TMS5220"] = true
SOUNDS["VOTRAX_SC01"] = true
SOUNDS["YM2151"] = true
SOUNDS["YM2203"] = true
SOUNDS["YM3812"] = true

--------------------------------------------------
-- specify required video cores
--------------------------------------------------

VIDEOS["AVGDVG"] = true
VIDEOS["BUFSPRITE"] = true
VIDEOS["MC6845"] = true
VIDEOS["TMS34061"] = true
VIDEOS["X1_001"] = true

--------------------------------------------------
-- specify required machine cores
--------------------------------------------------

MACHINES["6522VIA"] = true
MACHINES["6821PIA"] = true
MACHINES["ADC0808"] = true
MACHINES["BANKDEV"] = true
MACHINES["EEPROMDEV"] = true
MACHINES["ER2055"] = true
MACHINES["GEN_LATCH"] = true
MACHINES["I8243"] = true
MACHINES["I8255"] = true
MACHINES["I8257"] = true
MACHINES["INPUT_MERGER"] = true
MACHINES["LATCH8"] = true
MACHINES["LDPR8210"] = true
MACHINES["MB14241"] = true
MACHINES["MIOT6530"] = true
MACHINES["MOS6530"] = true
MACHINES["NETLIST"] = true
MACHINES["OUTPUT_LATCH"] = true
MACHINES["PIT8253"] = true
MACHINES["RIOT6532"] = true
MACHINES["SEGACRPT"] = true
MACHINES["SEGACRP2"] = true
MACHINES["TICKET"] = true
MACHINES["TMS1024"] = true
MACHINES["TMS6100"] = true
MACHINES["TTL74157"] = true
MACHINES["TTL74259"] = true
MACHINES["UPD4701"] = true
MACHINES["WATCHDOG"] = true
MACHINES["X2212"] = true
MACHINES["Z80CTC"] = true
MACHINES["Z80DAISY"] = true
MACHINES["Z80DMA"] = true
MACHINES["Z80PIO"] = true
MACHINES["Z80SIO"] = true

--------------------------------------------------
-- specify required bus cores
--------------------------------------------------

BUSES["GENERIC"] = true


--------------------------------------------------
-- this is the list of driver libraries that
-- comprise MAME
--------------------------------------------------

PROJECTS = {
	"atari",
	"capcom",
	"dataeast",
	"galaxian",
	"gottlieb",
	"irem",
	"itech",
	"jaleco",
	"konami",
	"midw8080",
	"midway",
	"namco",
	"nichibutsu",
	"nintendo",
	"pacman",
	"phoenix",
	"sega",
	"seta",
	"sunelectronics",
	"taito",
	"tecmo",
	"toaplan",
	"universal",
	"valadon",
	"shared"
}

function linkProjects_mame_cocktail(_target, _subtarget)
	links(PROJECTS)
end


function createMAMEProjects(_target, _subtarget, _name)
	project (_name)
	targetsubdir(_target .."_" .. _subtarget)
	kind (LIBTYPE)
	uuid (os.uuid("drv-" .. _target .."_" .. _subtarget .. "_" .._name))
	addprojectflags()
	precompiledheaders_novs()

	includedirs {
		MAME_DIR .. "src/osd",
		MAME_DIR .. "src/emu",
		MAME_DIR .. "src/devices",
		MAME_DIR .. "src/mame/shared",
		MAME_DIR .. "src/lib",
		MAME_DIR .. "src/lib/util",
		MAME_DIR .. "3rdparty",
		GEN_DIR  .. "mame/layout",
	}

	includedirs {
		ext_includedir("asio"),
		ext_includedir("flac"),
		ext_includedir("glm"),
		ext_includedir("jpeg"),
		ext_includedir("rapidjson"),
		ext_includedir("zlib")
	}

end

function createProjects_mame_cocktail(_target, _subtarget)
	for x, name in ipairs(PROJECTS) do
		local dir = path.join(MAME_DIR, "src", _target, name)

		local sources = {}
		if 0 < #os.matchfiles(path.join(dir, "**.cpp")) then
			table.insert(sources, MAME_DIR .. "src/" .. _target .. "/" .. name .. "/**.cpp")
		end
		if 0 < #os.matchfiles(path.join(dir, "**.h")) then
			table.insert(sources, MAME_DIR .. "src/" .. _target .. "/" .. name .. "/**.h")
		end
		if 0 < #os.matchfiles(path.join(dir, "**.ipp")) then
			table.insert(sources, MAME_DIR .. "src/" .. _target .. "/" .. name .. "/**.ipp")
		end

		if 0 < #sources then
			createMAMEProjects(_target, _subtarget, name)
			files(sources)
		end
	end
end
