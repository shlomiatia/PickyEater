class_name KidWalkState
const speed: float = 500.0

func enter(_player: Kid):
    pass

func _process(player: Kid, delta: float) -> void:
    if player.target_position != Vector2.ZERO:
        player.global_position = player.global_position.move_toward(player.target_position, delta * speed)
        if player.global_position == player.target_position:
            player.target_position = Vector2.ZERO
            KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.STAND)

func handle_object(player: Kid, object: Node2D, mouse_position: Vector2):
    player.handle_object_stand_walk(object, mouse_position)
