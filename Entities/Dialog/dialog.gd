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
    self.add_theme_color_override("font_color", color)
    animation_player.seek(0)
    animation_player.play("Show")
