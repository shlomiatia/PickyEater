class_name KidGoToSceneryState


func enter(player: Kid):
    player.move_to(player.scenery.global_position)
    
func cancel(_player: Kid) -> void:
    pass

func _process(player: Kid, delta: float) -> void:
    if player.process_walk(delta):
        KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.STAND)
        if player.scenery.name == "Trash":
            player.animation_player.play("throw")
            player.scenery.get_node("Sprite2D").texture = load("res://Textures/Trash full.png")
            player.scenery = null
 
func handle_object(_player: Kid, _object: Node2D, _mouse_position: Vector2):
    pass
