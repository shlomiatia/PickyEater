extends Button

var new_scene = preload("res://Entities/Game/Game.tscn").instantiate()
@onready var pow_food: PowFood = $"../../CanvasLayer2/PowFood"

func _on_pressed() -> void:
	pow_food._pow_food(2)
	#var current_scene = self.get_tree().current_scene
	#self.get_tree().root.add_child(new_scene)
	#self.get_tree().current_scene = new_scene
	#current_scene.queue_free()
	
	#var dialog_popup = self.get_node("/root/Main/DialogPopup") as DialogPopup
	#dialog_popup._start_dialog(dialog_popup.mom, ["hello", "hi? dont die"])
