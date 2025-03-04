extends RetroHubGenericEmulator
class_name RetroHubRetroArchEmulator

static func get_custom_core_path() -> String:
	var config_file := get_config_path()
	if config_file:
		var file := File.new()
		if not file.open(config_file + "/retroarch.cfg", File.READ):
			while file.get_position() < file.get_len():
				var line := file.get_line()
				if "libretro_directory" in line:
					var path = line.get_slice("=", 1).replace("\"", "").replace("'", "").strip_edges()
					return FileUtils.expand_path(path)
		return ""
	return ""

static func get_config_path() -> String:
	var dir := Directory.new()
	match FileUtils.get_os_id():
		FileUtils.OS_ID.WINDOWS:
			# RetroArch on Windows works as a "portable" installation. Config is located beside main files.
			# Try to find a valid binpath.
			var emulator = RetroHubConfig.emulators_map["retroarch"]
			var binpaths = emulator["binpath"]
			for binpath in binpaths:
				if dir.file_exists(binpath):
					return binpath
			return ""
		FileUtils.OS_ID.LINUX:
			# RetroArch uses either XDG_CONFIG_HOME or HOME.
			var xdg = OS.get_environment("XDG_CONFIG_HOME")
			if not xdg.empty():
				var path = xdg + "/retroarch"
				if dir.dir_exists(path):
					return path
			else:
				# Default to HOME
				var path = FileUtils.get_home_dir() + "/.config/retroarch"
				if dir.dir_exists(path):
					return path
			return ""
		_:
			return ""

func _init(emulator_raw : Dictionary, game_data : RetroHubGameData, system_cores : Array).(emulator_raw, game_data):
	var corepath := get_custom_core_path()
	if corepath.empty():
		corepath = find_and_substitute_str(emulator_raw["corepath"])
	var corefile : String
	_substitutes["corepath"] = corepath
	var dir = Directory.new()
	for core_name in system_cores:
		for core_info in emulator_raw["cores"]:
			if core_info["name"] == core_name:
				var core_file_path : String = corepath + "/" + core_info["file"]
				if dir.file_exists(core_file_path):
					corefile = core_info["file"]
					_substitutes["corefile"] = corefile
					break
		if not corefile.empty():
			break
	
	if not corefile.empty():
		command = substitute_str(command)
	else:
		print("Could not find valid core file for emulator \"%s\"" % game_data.system_name)
