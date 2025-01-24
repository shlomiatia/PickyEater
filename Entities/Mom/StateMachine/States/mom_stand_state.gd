class_name MomStandState

func enter(mom: Mom):
    mom.animation_player.play("Stand")
    
func _process(_mom: Mom, _delta: float) -> void:
    pass
