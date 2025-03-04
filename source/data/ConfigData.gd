extends Resource
class_name ConfigData

signal config_updated(key, old_value, new_value)

var _config_changed := false
var _old_config : Dictionary

# Games directory
var is_first_time : bool = true setget _set_is_first_time
var games_dir : String = FileUtils.get_home_dir() + "/ROMS" setget _set_games_dir
var current_theme : String = "default" setget _set_current_theme
var lang : String = "en" setget _set_lang
var region : String = "usa" setget _set_region
var rating_system : String = "esrb" setget _set_rating_system
var date_format : String = "mm/dd/yyyy" setget _set_date_format
var scraper_ss_use_custom_account : bool = false setget _set_scraper_ss_use_custom_account
var scraper_ss_username : String = "" setget _set_scraper_ss_username
var scraper_ss_password : String = "" setget _set_scraper_ss_password

const KEY_IS_FIRST_TIME = "is_first_time"
const KEY_GAMES_DIR = "games_dir"
const KEY_CURRENT_THEME = "current_theme"
const KEY_LANG = "lang"
const KEY_REGION = "region"
const KEY_RATING_SYSTEM = "rating_system"
const KEY_DATE_FORMAT = "date_format"
const KEY_SCRAPER_SS_USE_CUSTOM_ACCOUNT = "scraper_ss_use_custom_account"
const KEY_SCRAPER_SS_USERNAME = "scraper_ss_username"
const KEY_SCRAPER_SS_PASSWORD = "scraper_ss_password"

const _keys = [
	KEY_IS_FIRST_TIME,
	KEY_GAMES_DIR,
	KEY_CURRENT_THEME,
	KEY_LANG,
	KEY_REGION,
	KEY_RATING_SYSTEM,
	KEY_DATE_FORMAT,
	KEY_SCRAPER_SS_USE_CUSTOM_ACCOUNT,
	KEY_SCRAPER_SS_USERNAME,
	KEY_SCRAPER_SS_PASSWORD
]

var _should_save : bool = true

func _set_is_first_time(_is_first_time):
	mark_for_saving()
	is_first_time = _is_first_time

func _set_games_dir(_games_dir):
	mark_for_saving()
	games_dir = _games_dir

func _set_current_theme(_current_theme):
	mark_for_saving()
	if "res://default_themes" in _current_theme:
		current_theme = _current_theme.get_file().get_basename()
	else:
		current_theme = _current_theme

func _set_lang(_lang):
	mark_for_saving()
	lang = _lang

func _set_region(_region):
	mark_for_saving()
	region = _region

func _set_rating_system(_rating_system):
	mark_for_saving()
	rating_system = _rating_system

func _set_date_format(_date_format):
	mark_for_saving()
	date_format = _date_format

func _set_scraper_ss_use_custom_account(_scraper_ss_use_custom_account):
	mark_for_saving()
	scraper_ss_use_custom_account = _scraper_ss_use_custom_account

func _set_scraper_ss_username(_scraper_ss_username):
	mark_for_saving()
	scraper_ss_username = _scraper_ss_username

func _set_scraper_ss_password(_scraper_ss_password):
	mark_for_saving()
	scraper_ss_password = _scraper_ss_password

func mark_for_saving():
	if _should_save:
		_config_changed = true

func load_config_from_path(path: String) -> int:
	# Open file
	var file = File.new()
	var err = file.open(path, File.READ)
	if err:
		print("Error opening config file " + path + " for reading!")
		return err

	# Parse file
	var json_result = JSON.parse(file.get_as_text())
	if(json_result.error):
		print("Error parsing config file!")
		return ERR_FILE_CORRUPT
	
	# Dictionary ready for retrieval
	_old_config = json_result.result

	_should_save = false
	for key in _keys:
		if _old_config.has(key):
			set(key, _old_config[key])
		else:
			_config_changed = true
	_should_save = true

	return OK

func save_config_to_path(path: String, force_save: bool = false) -> int:
	if not _config_changed and not force_save:
		return OK

	# Open file
	var file := File.new()
	if(file.open(path, File.WRITE)):
		print("Error opening config file " + path + "for saving!")
		return ERR_CANT_OPEN
	
	# Construct dict and save config
	var dict = {}
	for key in _keys:
		dict[key] = get(key)

	# Save JSON to file
	var json_output = JSON.print(dict, "\t")
	file.store_string(json_output)
	
	_config_changed = false

	# Now signal any changes that ocurred to the config file
	for key in _keys:
		if _old_config.has(key):
			if _old_config[key] != get(key):
				emit_signal("config_updated", key, _old_config[key], get(key))

	_old_config = dict
	return OK
