extends ItemList


# Called when the node enters the scene tree for the first time.
func _ready():
	item_selected.connect(_on_selection)
	
	for tool in CoreTools.tools:
		add_icon_item(tool.tool_icon)


func _on_selection(index):
	CoreTools.tools[index]._on_selection()
	CoreTools.emit_signal("tool_selected", CoreTools.tools[index])
