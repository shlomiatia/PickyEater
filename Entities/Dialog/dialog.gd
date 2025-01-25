extends Label

var animation_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player = get_node("AnimationPlayer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func ShowDialog(dialog: String, color: Color):
	self.text = dialog
	animation_player.seek(0)
	animation_player.get_animation("Show").track_set_key_value(0, 0, color)
	animation_player.get_animation("Show").track_set_key_value(0, 1, color)
	animation_player.get_animation("Show").track_set_key_value(0, 2, Color(color, 0.0))
	animation_player.play("Show")
