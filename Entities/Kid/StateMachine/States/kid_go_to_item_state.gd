class_name KidGoToItemState

func enter(_player: Kid):
    pass

func _process(player: Kid, delta: float) -> void:
    if player.process_walk(delta):
        player.item.queue_free()
        player.item = null
        player.move_to(player.scenery.global_position)
        player.scenery = null
        KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.GO_TO_SCENERY)     

func handle_object(_player: Kid, _object: Node2D, _mouse_position: Vector2):
    pass
