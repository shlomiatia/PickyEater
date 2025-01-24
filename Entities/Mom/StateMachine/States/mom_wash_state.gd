class_name MomWashState

func enter(mom: Mom):
    mom.animation_player.play("Wash")
    
func _process(_mom: Mom, _delta: float) -> void:
    pass
