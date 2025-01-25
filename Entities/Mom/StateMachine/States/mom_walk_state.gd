class_name MomWalkState

const speed: float = 250.0

func enter(mom: Mom):
    mom.animation_player.play("Walk", -1, 2.0)
    mom.audio_stream_player.stop()
    
func _process(mom: Mom, delta: float) -> void:
    mom.global_position = mom.global_position.move_toward(mom.target_node.global_position, delta * speed)
    if mom.global_position == mom.target_node.global_position:
        if mom.target_node.name == "Sink":
            if mom.get_node("/root/Game/FakeFork").visible:
                MomStateMachine.change_state(mom, MomStateMachine.MomStateEnum.DUCK)
            else:
                MomStateMachine.change_state(mom, MomStateMachine.MomStateEnum.WASH)
            mom.target_node = null
        elif mom.target_node.name == "Food1":
            var food = mom.get_node("/root/Game/Food1")
            food.sprite2d.texture = load("res://Textures/Food/Worms.png")
            food.name = "Food2"
            var fork = mom.get_node("/root/Game/Fork")
            fork.show()
            fork.name = "Fork1"
            mom.move_to(mom.get_node("/root/Game/Sink"))
        elif mom.target_node.name == "Exit":
            mom.target_node = null
            mom.hide()
            MomStateMachine.change_state(mom, MomStateMachine.MomStateEnum.STAND)
        elif mom.target_node.name == "Food2":
            var food = mom.get_node("/root/Game/Food2")
            food.sprite2d.texture = load("res://Textures/Food/Meatballs.png")
            food.name = "Food3"
            mom.move_to(mom.get_node("/root/Game/Exit"))
        
            
