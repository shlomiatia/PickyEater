extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass

func eat() -> void:
    get_node("/root/Game/Food3").empty()

func show_outro() -> void:
    get_node("/root/Game/Kid").show_outro = true
    get_node("/root/Game/CanvasLayer2/DialogPopup")._outro_dialog()
    
