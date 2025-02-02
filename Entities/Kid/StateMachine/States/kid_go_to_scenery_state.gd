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
        if player.item.name == "Fork" && player.scenery.name == "Dog":
            player.animation_player.play("throw")
            player.show_mom_dialog("Oh dear look at what you’ve done now. Now I have to wash it")
            var fake_fort = player.get_node("/root/Game/FakeFork")
            player.mom.move_to(fake_fort)
            player.get_node("/root/Game/Food").name = "Food1"
            fake_fort.show()
            player.scenery = null
        elif player.scenery.name == "Trash":
            player.animation_player.play("throw")
            player.scenery.get_node("Sprite2D").texture = load("res://Textures/Trash full.png")
            player.scenery = null
            player.item = player.get_node("/root/Game/Food1")
            player.after_throw_state =  KidStateMachine.KidStateEnum.GO_TO_ITEM
            player.play_sound(load("res://Sounds/trash sound.mp3"))
        elif player.item.name == "Food2" && player.scenery.name == "Dog":
            player.animation_player.play("throw")
            player.scenery.get_node("Sprite2D").texture = load("res://Textures/Dog sick.png")
            player.scenery = null
            player.item = player.get_node("/root/Game/Food2")
            player.after_throw_state =  KidStateMachine.KidStateEnum.GO_TO_ITEM
            player.play_sound(load("res://Sounds/dog whining.mp3"))
        elif player.item.name == "Worm" && player.scenery.name == "Window":
            player.get_node("/root/Game/Window").get_node("Sprite2D").texture = load("res://Textures/WindowOpened.png")
            player.get_node("/root/Game/Bird").get_node("AnimationPlayer").play("Fly")
        elif player.item.name == "Fork1" && player.scenery.name == "Food3":
            player.get_node("/root/Game/Worm").show()
            player.show_dialog("Yach! Some worms fell off. They are still alive")
            
func handle_object(_player: Kid, _object: Node2D, _mouse_position: Vector2):
    pass
