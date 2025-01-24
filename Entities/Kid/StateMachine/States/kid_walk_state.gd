class_name KidWalkState

func enter(_player: Kid):
    pass

func _process(player: Kid, delta: float) -> void:
    if player.process_walk(delta):
        KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.STAND)

func handle_object(player: Kid, object: Node2D, mouse_position: Vector2):
    player.handle_object_stand_walk(object, mouse_position)
