extends Node2D

@onready var app = $App
@onready var window = $Window
@onready var asm = $Window/TextEdit
@onready var out = $Window/LineEdit

var last_text = ''

func _ready():
	app.pressed.connect(_show)
	window.close_requested.connect(_close)
	
	window.visible = false

func _process(_delta):
	if window.has_focus():
		if Input.is_action_pressed('exit_window'):
			_close()
		
	if last_text != asm.text:
		assemble(asm.text)
		last_text = asm.text
	

func assemble(code):
	
	out.text = ''
		
	for line in code.split('\n'):
		line = line.strip_edges()  # Remove leading/trailing spaces

		if line.to_lower().begins_with('mov ah'):
			# Extract the part after "mov ah" and remove the trailing 'H'
			var extracted = line.substr(7, 9).strip_edges().to_upper()  # Extract the relevant part
			
			if line.to_lower().ends_with('h'):
				extracted = extracted.substr(0, extracted.length() - 1)  # Remove the last character 'H'
				
			out.text += 'B4 %s ' % extracted



func _show():
	window.visible = true

func _close():
	window.visible = false
