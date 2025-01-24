class_name KidGoToSceneryState


func enter(_player: Kid):
    pass
    
func cancel(_player: Kid) -> void:
    pass

func _process(player: Kid, delta: float) -> void:
    if player.process_walk(delta):
        KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.STAND)
 
func handle_object(_player: Kid, _object: Node2D, _mouse_position: Vector2):
    pass
