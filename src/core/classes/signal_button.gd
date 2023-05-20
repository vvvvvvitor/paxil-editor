extends Button
class_name SignalButton

@export var target:Node
@export var signal_name:String
@export var parameter:float

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_press)
	
	
func _on_press():
	target.emit_signal(signal_name, parameter)
