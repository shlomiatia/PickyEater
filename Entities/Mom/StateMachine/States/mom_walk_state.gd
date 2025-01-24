class_name MomWalkState

const speed: float = 150.0

func enter(mom: Mom):
    mom.animation_player.play("Walk")
    
func _process(mom: Mom, delta: float) -> void:
    if mom.target_position != Vector2.ZERO:
        mom.global_position = mom.global_position.move_toward(mom.target_position, delta * speed)
        if mom.global_position == mom.target_position:
            mom.target_position = Vector2.ZERO
            MomStateMachine.change_state(mom, MomStateMachine.MomStateEnum.WASH)
            
