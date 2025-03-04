extends Control

signal request_search(search, game_data)
signal search_completed(orig_game_data, new_game_data)

onready var n_search_field = $"%SearchField"
onready var n_search = $"%Search"
onready var n_screenshot = $"%Screenshot"
onready var n_developer = $"%Developer"
onready var n_publisher = $"%Publisher"
onready var n_num_players = $"%NumPlayers"
onready var n_name = $"%Name"
onready var n_description = $"%Description"
onready var n_game_search_entries = $"%GameSearchEntries"
onready var n_confirm = $"%Confirm"

onready var button_group := ButtonGroup.new()

var orig_game_data : RetroHubGameData
var new_game_data : RetroHubGameData

var cached_images := {}

func _ready():
	RetroHubMedia.connect("game_media_scraped", self, "_on_game_media_scraped")

func set_entry(game_entry: Control):
	clear_entries()
	if orig_game_data != game_entry.game_data:
		orig_game_data = game_entry.game_data
		n_search_field.text = orig_game_data.name.get_basename()
	var game_datas = game_entry.data
	print("Game datas: ", game_datas)
	n_search.disabled = false
	if game_datas.empty():
		var button := create_entry(null)
		button.text = "No games found"
		button.disabled = true
	else:
		for game_data in game_datas:
			var button := create_entry(game_data)
			button.text = game_data.name
		n_game_search_entries.get_child(0).set_pressed(true)

func clear_entries():
	for child in n_game_search_entries.get_children():
		child.queue_free()
		n_game_search_entries.remove_child(child)
	n_screenshot.texture = null
	n_developer.text = ""
	n_publisher.text = ""
	n_num_players.text = ""
	n_name.text = ""
	n_description.text = ""
	n_confirm.disabled = true

func populate_info(game_data: RetroHubGameData):
	if cached_images.has(game_data):
		n_screenshot.texture = cached_images[game_data]
	else:
		request_screenshot(game_data)
		n_screenshot.texture = preload("res://assets/icons/image_downloading.svg")
	n_developer.text = game_data.developer
	n_publisher.text = game_data.publisher
	n_num_players.text = game_data.num_players
	n_name.text = game_data.name
	n_description.text = game_data.description
	n_confirm.disabled = false
	new_game_data = game_data

func request_screenshot(game_data: RetroHubGameData):
	cached_images[game_data] = null
	RetroHubMedia.scrape_game_media_data_type(game_data, "screenshot")

func _on_game_media_scraped(game_data: RetroHubGameData, req_body: PoolByteArray):
	# FIXME: Hardcoded to PNG
	var image := Image.new()
	image.load_png_from_buffer(req_body)
	var texture := ImageTexture.new()
	texture.create_from_image(image)
	cached_images[game_data] = texture
	if new_game_data == game_data:
		n_screenshot.texture = cached_images[game_data]

func _on_entry_toggled(button_pressed: bool, game_data: RetroHubGameData):
	if button_pressed:
		populate_info(game_data)

func create_entry(game_data: RetroHubGameData) -> Button:
	var button = Button.new()
	button.align = Button.ALIGN_LEFT
	button.clip_text = true
	button.size_flags_horizontal = SIZE_EXPAND_FILL
	button.rect_min_size.y = 28
	button.group = button_group
	button.toggle_mode = true
	button.connect("toggled", self, "_on_entry_toggled", [game_data])
	n_game_search_entries.add_child(button)
	return button


func _on_SearchField_text_changed(new_text):
	n_search.disabled = new_text.empty()


func _on_Search_pressed():
	emit_signal("request_search", n_search_field.text, orig_game_data)


func _on_Confirm_pressed():
	cached_images.clear()
	RetroHubMedia.remap_cache(new_game_data, orig_game_data)
	emit_signal("search_completed", orig_game_data, new_game_data)
