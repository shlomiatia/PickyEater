class_name KidGoToSceneryState


func enter(player: Kid):
    player.move_to(player.scenery.global_position)
    player.animation_player.seek(0)
    player.animation_player.play("Walk", -1, 2.0)
    
func cancel(_player: Kid) -> void:
    pass

func _process(player: Kid, delta: float) -> void:
    if player.process_walk(delta):
        KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.STAND)
        if player.scenery.name == "Dog":
            player.animation_player.play("throw")
            player.show_mom_dialog("Oh dear look at what you’ve done now")
            player.mom.move_to(player.get_node("/root/Game/Sink"))
            player.get_node("/root/Game/Food").name = "Food1"
            player.scenery = null
        elif player.scenery.name == "Trash":
            player.animation_player.play("throw")
            player.scenery.get_node("Sprite2D").texture = load("res://Textures/Trash full.png")
            player.scenery = null
            player.item = player.get_node("/root/Game/Food1")
            player.after_throw_state =  KidStateMachine.KidStateEnum.GO_TO_ITEM
            
 
func handle_object(_player: Kid, _object: Node2D, _mouse_position: Vector2):
    pass
