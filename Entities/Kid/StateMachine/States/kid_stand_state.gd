class_name KidStandState

func enter(_player: Kid):
    pass

func _process(_player: Kid, _delta: float) -> void:
    pass
    
func cancel(_player: Kid) -> void:
    pass

func handle_object(player: Kid, object: Node2D, mouse_position: Vector2):
    player.handle_object_stand_walk(object, mouse_position)
