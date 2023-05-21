extends Control

const WELCOME_WINDOW:PackedScene = preload("res://res/components/popups/welcome.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	Core.create_window_popup(WELCOME_WINDOW)
