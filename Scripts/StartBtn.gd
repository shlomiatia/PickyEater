extends Button

var new_scene = preload("res://Entities/Game/Game.tscn").instantiate()

func _on_pressed() -> void:
	var current_scene = self.get_tree().current_scene
	self.get_tree().root.add_child(new_scene)
	self.get_tree().current_scene = new_scene
	current_scene.queue_free()
	
	#var dialog_popup = self.get_node("/root/Main/DialogPopup") as DialogPopup
	#dialog_popup._start_dialog(dialog_popup.mom, ["hello", "hi? dont die"])
