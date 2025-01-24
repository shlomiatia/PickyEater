class_name KidItemState

func enter(player: Kid):
    player.animation_player.seek(0)
    player.animation_player.play("RESET")

func _process(_player: Kid, _delta: float) -> void:
    pass

func cancel(player: Kid) -> void:
    Input.set_custom_mouse_cursor(null)
    KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.STAND)      

func handle_object(player: Kid, object: Node2D, _mouse_position: Vector2):
    var key = "%s.%s" % [player.item.name, object.get_parent().name]
    var dialog = DataProvider.get_data().get(key)
    if dialog == "<Solution>":
        player.scenery = object.get_parent()
        player.move_to(player.item.global_position)
        Input.set_custom_mouse_cursor(null)
        KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.GO_TO_ITEM)      
    elif dialog != null:
        player.show_dialog(dialog)
        
