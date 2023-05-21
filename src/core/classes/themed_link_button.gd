extends Button
class_name ThemedLinkButton

@export var URI:String


func _init():
	pressed.connect(__on_press)
	
	
func __on_press():
	OS.shell_open(URI)
