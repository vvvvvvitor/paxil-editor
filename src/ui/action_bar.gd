extends PanelContainer

func _ready():
	CoreTools.tool_selected.connect(_on_selection)
	child_entered_tree.connect(_on_new_action)


func set_action(scene:PackedScene):
	var action = scene.instantiate()
	action.set_meta("tool", CoreTools.current_tool)
	add_child(action)


func _on_new_action(child):
	if get_child_count() > 1:
		get_children()[0].queue_free()


func _on_selection(tool:Tool):
	tool._actionbar_init(self)
