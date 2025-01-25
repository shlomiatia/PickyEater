class_name PowFood
extends Node2D

const RES: String = "res://Textures/Food/"
const FOODS: Array[String] = ["Broccoli", "Worms", "Meatballs", "Pasta", "Pie"]
const TEXTS: Array[String] = ["Infected Broccoli",
"Devious Schnizel", "Worm infested Meatballs", "Suspicious Sauce Spaghetti", 
"Polluted Pie", "Eye Scream"]
@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    self.visible = false
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass

func _pow_food(foodNo: int) -> void:
    self.visible = true
    texture_rect.texture = load(RES + FOODS[foodNo] + ".png")
    label.text = TEXTS[foodNo]
    var sound = load("res://Sounds/LEVEL " + str(foodNo+1) + ".mp3")
    _play_sound(sound)
    await get_tree().create_timer(7).timeout
    self.visible = false
    get_node("/root/AudioPlayer/AudioStreamPlayer").set_stream_paused(false)
    

func _play_sound(CorrectSound: AudioStreamMP3) -> void:
    get_node("/root/AudioPlayer/AudioStreamPlayer").set_stream_paused(true)
    if !$AudioStreamPlayer2D.is_playing():
        $AudioStreamPlayer2D.stream = CorrectSound
        $AudioStreamPlayer2D.play()
    
