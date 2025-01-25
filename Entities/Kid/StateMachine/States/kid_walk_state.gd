class_name KidWalkState

func enter(player: Kid):
    player.animation_player.seek(0)
    player.animation_player.play("Walk", -1, 2.0)

func _process(player: Kid, delta: float) -> void:
    if player.process_walk(delta):
        print("what")
        KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.STAND)

func handle_object(player: Kid, object: Node2D, mouse_position: Vector2):
    player.handle_object_stand_walk(object, mouse_position)
