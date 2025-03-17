extends Node2D

@onready var app = $App
@onready var window = $Window

func _ready():
	window.close_requested.connect(_close)
	app.pressed.connect(_show)
	
	window.visible = false

func _process(_delta):
	if window.has_focus():
		if Input.is_action_pressed('exit_window'):
			_close()

func _show():
	window.visible = true

func _close():
	window.visible = false
