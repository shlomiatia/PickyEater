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
            player.show_mom_dialog("Finished? How lovely, you must be craving for a second... coming right up!")
            player.mom.move_to(player.get_node("/root/Game/Food1"))
            KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.WALK)
            player.move_to(player.get_node("/root/Game/Side").global_position)
        elif player.item.name == "Food2" && player.scenery == null:
            player.item.empty()
            player.animation_player.play("throw")
            player.mom.show()
            player.show_mom_dialog("Done so soon? Here is the last serve! Bon Appetit!")
            player.mom.move_to(player.get_node("/root/Game/Food2"))
            KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.WALK)
            player.move_to(player.get_node("/root/Game/Side").global_position)
        elif player.item.name == "Fork" && player.scenery.name == "Dog":
            player.item.hide()
            KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.GO_TO_SCENERY)
            player.play_sound(player.pickup_sound)
        elif player.item.name == "Food1" && player.scenery.name == "Trash":
            player.item.hide()
            KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.GO_TO_SCENERY)
            player.play_sound(player.pickup_sound)
        elif player.item.name == "Food2" && player.scenery.name == "Dog":
            player.item.hide()
            KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.GO_TO_SCENERY)
            player.play_sound(player.pickup_sound)
        elif player.item.name == "Worm" && player.scenery.name == "Window":
            player.get_node("/root/Game/Worm").hide()
            KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.GO_TO_SCENERY)
            player.play_sound(player.pickup_sound)
        elif player.item.name == "Fork1" && player.scenery.name == "Food3":
            KidStateMachine.change_state(player, KidStateMachine.KidStateEnum.GO_TO_SCENERY)
        
            
func handle_object(_player: Kid, _object: Node2D, _mouse_position: Vector2):
    pass
