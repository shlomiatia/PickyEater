class_name MomDuckState

func enter(mom: Mom):
    mom.animation_player.play("Pickup")
    mom.audio_stream_player.stop()
    
func _process(_mom: Mom, _delta: float) -> void:
    pass
