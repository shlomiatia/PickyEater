class_name KidItemState


func enter(_player: Kid):
    pass

func _process(_player: Kid, _delta: float) -> void:
    pass

func handle_object(player: Kid, object: Node2D, _mouse_position: Vector2):
    var key = "%s.%s" % [player.item.name, object.get_parent().name]
    var dialog = DataProvider.get_data().get(key)
    if dialog == "<Solution>":
        print("!!!")
    else:
        player.show_dialog(dialog)
        
