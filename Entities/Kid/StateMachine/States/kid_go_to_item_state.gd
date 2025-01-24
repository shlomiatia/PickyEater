class_name KidGoToItemState

func enter(player: Kid):
    player.move_to(player.item.global_position)
    player.animation_player.seek(0)
    player.animation_player.play("Walk", -1, 2.0)

func cancel(_player: Kid) -> void:
    pass

func _process(player: Kid, delta: float) -> void:
    if player.process_walk(delta):
        if player.item.name == "Food1" && player.scenery == null:
            player.item.empty()
            player.animation_player.play("throw")
            player.show_mom_dialog("How lovely, you must be craving for a second!")
            player.mom.move_to(player.get_node("/root/Game/Food1"))
        elif player.item.name == "Fork" && player.scenery.name == "Dog":
            player.item.queue_free()
            KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.GO_TO_SCENERY)
        elif player.item.name == "Food1" && player.scenery.name == "Trash":
            player.item.hide()
            KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.GO_TO_SCENERY)
        player.item = null
            
func handle_object(_player: Kid, _object: Node2D, _mouse_position: Vector2):
    pass
