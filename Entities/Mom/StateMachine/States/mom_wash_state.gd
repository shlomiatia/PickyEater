class_name MomWashState

func enter(mom: Mom):
    mom.animation_player.play("Wash")
    mom.audio_stream_player.stop()
    mom.audio_stream_player.stream = mom.wash_audio
    mom.audio_stream_player.play()
    
func _process(_mom: Mom, _delta: float) -> void:
    pass
