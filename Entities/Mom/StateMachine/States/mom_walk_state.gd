class_name MomWalkState

const speed: float = 150.0

func enter(mom: Mom):
    mom.animation_player.play("Walk")
    
func _process(mom: Mom, delta: float) -> void:
    mom.global_position = mom.global_position.move_toward(mom.target_node.global_position, delta * speed)
    if mom.global_position == mom.target_node.global_position:
        if mom.target_node.name == "Sink":
            MomStateMachine.change_state(mom, MomStateMachine.MomStateEnum.WASH)
            mom.target_node = null
        elif mom.target_node.name == "Food1":
            pass
        
            
