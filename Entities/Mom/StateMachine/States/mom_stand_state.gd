class_name MomStandState

func enter(mom: Mom):
    mom.animation_player.play("Idle")
    mom.audio_stream_player.stop()
    
func _process(_mom: Mom, _delta: float) -> void:
    pass
