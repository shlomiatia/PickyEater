class_name KidGoToItemState

func enter(_player: Kid):
    pass
    
func cancel(_player: Kid) -> void:
    pass

func _process(player: Kid, delta: float) -> void:
    if player.process_walk(delta):
        if player.item.name == "Fork" && player.scenery.name == "Dog":
            player.animation_player.play("throw")
            player.show_mom_dialog("Oh dear look at what you’ve done now")
            player.mom.move_to(Vector2(1700, 670))
            player.get_node("/root/Game/Food").name = "Food1"
            player.item.queue_free()
            player.scenery = null
        elif player.item.name == "Food1" && player.scenery.name == "Trash":
            player.item.empty()
            KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.GO_TO_SCENERY)
        player.item = null
            
func handle_object(_player: Kid, _object: Node2D, _mouse_position: Vector2):
    pass
