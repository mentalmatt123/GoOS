extends Node2D

@onready var app = $App
@onready var window = $Window
@onready var search_text = $Window/Text
@onready var result = $Window/Result
@onready var youtube = $Window/Youtube
@onready var reddit = $Window/Reddit

func _ready():
	app.pressed.connect(_pressed)
	search_text.text_submitted.connect(_search)
	window.close_requested.connect(_close)

	window.visible = false
	youtube.visible = false
	reddit.visible = false

func _process(_delta):
	if window.has_focus():
		if Input.is_action_pressed('exit_window'):
			_close()

func _pressed():
	window.visible = true

func _close():
	window.visible = false
	
func _search(new_text):
	
	var query = new_text.strip_edges()
	
	if query.to_lower() == 'youtube.com':
		youtube.visible = true
		reddit.visible = false
		result.visible = false
		
	elif query.to_lower() == 'reddit.com':
		reddit.visible = true
		youtube.visible = false
		result.visible = false
	
	elif query.to_lower() == 'google.com':
		youtube.visible = false
		reddit.visible = false
		result.visible = true
		result.text = 'Google\nWorking Websites:\n\nreddit.com\nyoutube.com\ngoogle.com'
		
	elif query != '':
		youtube.visible = false
		reddit.visible = false
		result.visible = true
		
		
		result.text = 'Search Result:\n\n%s' % query
