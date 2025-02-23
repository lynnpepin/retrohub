extends Object

var computers := [
	"amiga",
	"amiga600",
	"amiga1200",
	"amstradcpc",
	"atari800",
	"atarist",
	"bbcmicro",
	"c64",
	"coco",
	"dos",
	"dragon32",
	"macintosh",
	"moto",
	"msx",
	"msx2",
	"msxturbor",
	"oric",
	"palm",
	"pc",
	"pc88",
	"pc98",
	"samcoupe",
	"spectravideo",
	"tanodragon",
	"ti99",
	"to8",
	"trs-80",
	"vic20",
	"x1",
	"x68000",
	"zmachine",
	"zx81",
	"zxspectrum",
]

var game_engines := [
	"cavestory",
	"chailove",
	"doom",
	"godot",
	"lutro",
	"openbor",
	"pico8",
	"scummvm",
	"solarus",
	"stratagus",
	"tic80",
]

var consoles := [
	"3do",
	"64dd",
	"n64",
	"amigacd32",
	"arcade",
	"astrocade",
	"atari2600",
	"atari5200",
	"atari7800",
	"atarijaguar",
	"atarijaguarcd",
	"atarilynx",
	"atarixe",
	"atomiswave",
	"cdimono1",
	"cdtv",
	"channelf",
	"colecovision",
	"daphne",
	"dreamcast",
	"famicom",
	"fds",
	"nes",
	"fba",
	"fbneo",
	"gameandwatch",
	"gamegear",
	"gb",
	"gbc",
	"gba",
	"gc",
	"genesis",
	"megadrive",
	"sega32x",
	"segacd",
	"gx4000",
	"intellivision",
	"mame",
	"mastersystem",
	"mess",
	"multivision",
	"naomi",
	"naomigd",
	"nds",
	"neogeo",
	"neogeocd",
	"neogeocdjp",
	"ngp",
	"ngpc",
	"odyssey2",
	"videopac",
	"pcengine",
	"pcenginecd",
	"tg16",
	"tg-cd",
	"pcfx",
	"pokemini",
	"ps2",
	"psx",
	"saturn",
	"saturnjp",
	"sfc",
	"satellaview",
	"snes",
	"sufami",
	"sg-1000",
	"supergrafx",
	"uzebox",
	"vectrex",
	"virtualboy",
	"wonderswan",
	"wonderswancolor",
	"xbox",
]

var modern_consoles := [
	"n3ds",
	"ps3",
	"ps4",
	"psp",
	"psvita",
	"switch",
	"wii",
	"wiiu",
	"xbox360",
	"xboxone",
]

var platforms := [
	"amiga",
	"amstradcpc",
	"apple2",
	"atari800",
	"atarist",
	"bbcmicro",
	"c64",
	"coco",
	"dos",
	"dragon32",
	"macintosh",
	"moto",
	"msx",
	"oric",
	"palm",
	"pc",
	"pc88",
	"pc98",
	"samcoupe",
	"spectravideo",
	"tanodragon",
	"ti99",
	"to8",
	"trs-80",
	"vic20",
	"x1",
	"x68000",
	"zmachine",
	"zx81",
	"zxspectrum",
	"cavestory",
	"chailove",
	"doom",
	"godot",
	"lutro",
	"openbor",
	"pico8",
	"scummvm",
	"solarus",
	"stratagus",
	"tic80",
	"3do",
	"64dd",
	"n64",
	"amigacd32",
	"arcade",
	"astrocade",
	"atari2600",
	"atari5200",
	"atari7800",
	"atarijaguar",
	"atarijaguarcd",
	"atarilynx",
	"atarixe",
	"atomiswave",
	"cdimono1",
	"cdtv",
	"channelf",
	"colecovision",
	"daphne",
	"dreamcast",
	"nes",
	"fds",
	"fba",
	"fbneo",
	"gameandwatch",
	"gamegear",
	"gb",
	"gbc",
	"gba",
	"gc",
	"megadrive",
	"sega32x",
	"segacd",
	"gx4000",
	"intellivision",
	"mame",
	"mastersystem",
	"mess",
	"multivision",
	"naomi",
	"naomigd",
	"nds",
	"neogeo",
	"neogeocd",
	"ngp",
	"ngpc",
	"videopac",
	"tg16",
	"tg-cd",
	"pcfx",
	"pokemini",
	"ps2",
	"psx",
	"saturn",
	"snes",
	"sg-1000",
	"supergrafx",
	"uzebox",
	"vectrex",
	"virtualboy",
	"wonderswan",
	"wonderswancolor",
	"xbox",
	"n3ds",
	"ps3",
	"ps4",
	"psp",
	"psvita",
	"switch",
	"wii",
	"wiiu",
	"xbox360",
	"xboxone",
]

var system_to_platform := {
	"geneis": "megadrive",
	"famicom": "nes",
	"sfc": "snes",
	"pcengine": "tg16",
	"pcenginecd": "tg-cd",
	"odyssey2": "videopac",
	"saturnjp": "saturn",
	"neogeocdjp": "neogeocd",
}