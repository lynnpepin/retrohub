extends Node
class_name RetroHubGenericEmulator

var command : String

var _substitutes := {}

func _init(emulator_raw : Dictionary, game_data : RetroHubGameData):
	_substitutes["rompath"] = game_data.path
	var binpath = find_and_substitute_str(emulator_raw["binpath"])
	_substitutes["binpath"] = binpath
	command = substitute_str(emulator_raw["command"])

func find_and_substitute_str(paths : Array) -> String:
	return substitute_str(FileUtils.test_for_valid_path(paths))

func substitute_str(path) -> String:
	return JSONUtils.format_string_with_substitutes(path, _substitutes)


func launch_game():
	var regex = RegEx.new()
	var err = regex.compile("[^\\s\"']+|\"([^\"]*)\"|'([^']*)'")
	var regex_results = regex.search_all(command)
	var command_base : String = regex_results[0].strings[0]
	var command_args := []
	for idx in range(1, regex_results.size()):
		if not regex_results[idx].strings[1].empty():
			command_args.append(regex_results[idx].strings[1])
		else:
			command_args.append(regex_results[idx].strings[0])

	return OS.execute(command_base, command_args, false)
