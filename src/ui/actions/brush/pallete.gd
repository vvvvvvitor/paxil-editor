extends ColorPallete


var workspace = Core.current_workspace

# Called when the node enters the scene tree for the first time.
func _ready():
	color_added.connect(_on_new_color)
	color_changed.connect(_on_color_change)
	primary_changed.connect(_on_primary_change)
	secondary_changed.connect(_on_secondary_change)
	
	set_pallete(workspace.color_pallete)
	make_pallete()
	
	primary_color = workspace.primary_color
	secondary_color = workspace.secondary_color


func _on_new_color(color:Color):
	workspace.color_pallete == get_pallete()
	

func _on_color_change(index, color):
	workspace.color_pallete[index] = color


func _on_primary_change(id):
	workspace.primary_color = id


func _on_secondary_change(id):
	workspace.secondary_color = id

