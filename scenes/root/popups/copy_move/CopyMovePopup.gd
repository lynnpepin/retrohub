extends PopupDialog

signal import_begin(importer, copy_mode)

onready var n_move_section := $"%MoveSection"
onready var n_copy_section := $"%CopySection"
onready var n_section_labels := [
	$"%MoveFiles",
	$"%CopyFiles",
	$"%MoveDisadvantage",
	$"%CopyAdvantage"
] 
onready var n_size := $"%Size"
onready var n_space_left := $"%SpaceLeft"
onready var n_move_copy_button := $"%MoveCopyButton"
onready var n_cancel := $"%Cancel"
onready var n_import := $"%Import"

var base_texts := []
var size : int
var space_left : int

func _ready():
	for label in n_section_labels:
		base_texts.push_back((label as Label).text)

var importer : RetroHubImporter

var thread := Thread.new()

func set_importer(_importer):
	importer = _importer
	for idx in range(n_section_labels.size()):
		n_section_labels[idx].text = base_texts[idx] % importer.get_name()
	
	n_size.text = "Calculating..."
	n_space_left.text = "Calculating..."
	thread.start(self, "t_get_size")

func t_get_size():
	size = importer.get_estimated_size()
	space_left = FileUtils.get_space_left()
	call_deferred("thread_finished")

func thread_finished():
	thread.wait_to_finish()
	n_size.text = get_human_readable_size(size)
	n_space_left.text = get_human_readable_size(space_left) if space_left > 0 else "Could not measure"

func get_human_readable_size(size_raw: int):
	var value : float = size_raw
	var multiplier = 0
	while value > 1024:
		value /= 1024
		multiplier += 1
	value = stepify(value, 0.01)
	match multiplier:
		0:
			return str(value) + " bytes"
		1:
			return str(value) + " KB"
		2:
			return str(value) + " MB"
		3:
			return str(value) + " GB"
		4:
			return str(value) + " TB"
		_:
			# Eventually we will have smartwaches with petabytes of storage,
			# but we're still not there yet
			return "too big"


func _on_Cancel_pressed():
	hide()


func _on_MoveCopyButton_toggled(button_pressed):
	n_move_section.modulate.a = 0.25 if button_pressed else 1
	n_copy_section.modulate.a = 1 if button_pressed else 0.25 


func _on_Import_pressed():
	emit_signal("import_begin", importer, n_move_copy_button.pressed)
	hide()
