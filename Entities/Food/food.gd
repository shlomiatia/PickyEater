class_name Food extends Node2D

var label = "Food"
var sprite2d: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    sprite2d = get_node("Sprite2D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass
    
func empty():
    sprite2d.texture = load("res://Textures/Food/Plate.png")
    show()

    
