extends Node2D

@onready var app = $App
@onready var window = $Window
@onready var python = $Window/TextEdit
@onready var out = $Window/TextEdit2
var last_text = ''
var vars = {}

func _ready():
	window.close_requested.connect(_close)
	app.pressed.connect(_show)
	
	window.visible = false

func _process(_delta):
	if window.has_focus():
		if Input.is_action_pressed('exit_window'):
			_close()
			
	if last_text != python.text:
		run(python.text)
		last_text = python.text

func _show():
	window.visible = true

func _close():
	window.visible = false

func run(code):
	out.text = ''
	
	for line in code.split('\n'):
		line = line.strip_edges()
		
		if line.begins_with('print') and '('in line and ')':
			var extracted = line.split('(')[1].split(')')[0]
			
			if extracted.begins_with('"') and extracted.ends_with('"'):
				out.text += extracted.substr(1, 2)
			
			elif extracted.begins_with("'") and extracted.ends_with("'"):
				out.text += extracted.substr(1, extracted.length() - 2)
			
			else:
				if extracted in vars:
					out.text += vars[extracted]
					
				else:
					out.text += '\'%s\' Is Not Defined' % extracted
		
		elif '=' in line:
			var key = line.split('=')[0].strip_edges()
			var value = line.split('=')[1].strip_edges()
			
			if value.begins_with('"') and value.ends_with('"'):
				value = value.substr(1, value.length() - 2)
			
			elif value.begins_with("'") and value.ends_with("'"):
				value = value.substr(1, value.length() - 2)
			
			else:
				if value in vars:
					value = vars[value]
				
				else:
					out.text += '\'%s\' Is Not Defined' % value
				
			vars[key] = value
			
