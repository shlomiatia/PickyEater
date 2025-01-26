class_name DialogPopup
extends Node2D


const DEAD_DOG = preload("res://Textures/Frame 8.png")
const OUTRO_TEXTS: Array[String] =["I did it! I survived dinner!",
"...",
"Well said Bobby",
"Alrighty! Time for dessert!",
"Noooooooooo…"]
const OUTRO_SPEAKERS: Array[String]=[kid, dog, kid, mom, kid]

const mom: String = "mom"
const kid: String = "kid"
const laugh: String = "laugh"
const food: String = "food"
const dog: String = "dog"
const LAUGH: AudioStreamMP3 = preload("res://Sounds/laugh.mp3")
const DOG_SOUND: AudioStreamMP3 = preload("res://Sounds/dog whining.mp3")
@onready var pow_food: PowFood = $"../PowFood"

@onready var mom_dialog: TextureRect = $CanvasLayer/MomDialog
@onready var mom_label: Label = $CanvasLayer/MomDialog/MomLabel

@onready var kid_dialog: TextureRect = $CanvasLayer/KidDialog
@onready var kid_label: Label = $CanvasLayer/KidDialog/KidLabel

@onready var dog_dialog: TextureRect = $CanvasLayer/DogDialog
@onready var dog_label: Label = $CanvasLayer/DogDialog/DogLabel

@onready var color_rect: ColorRect = $CanvasLayer/ColorRect
var dialog: Array[String] = []
var speakers: Array[String] = []
var can_click: bool = false

func _ready() -> void:
    pass # Replace with function body.


func _process(_delta: float) -> void:
    pass

func _outro_dialog() -> void:
    dog_dialog.texture = DEAD_DOG
    _start_dialog(OUTRO_SPEAKERS, OUTRO_TEXTS)
    
func _unhandled_input(event: InputEvent):
    if event is InputEventMouseButton:
        if event.is_pressed():
            if event.button_index == MOUSE_BUTTON_LEFT:
                _on_button_pressed()

func _start_dialog(dialog_speakers: Array[String], dialog_content: Array[String]) -> void:
    can_click = true
    _hide_dialogs()
    dialog = dialog_content
    speakers = dialog_speakers
    color_rect.visible = true
    if(speakers[0]==mom):
        mom_dialog.visible = true
        mom_label.text = dialog[0]
    elif(speakers[0]==kid):
        kid_dialog.visible = true
        kid_label.text = dialog[0]
    elif(speakers[0]==laugh):
        can_click = false
        _play_sound_wait(LAUGH)
    elif(speakers[0]==food):
        can_click = false
        _hide_dialogs()
        await _broccoli()
        _next_dialog()
    elif(speakers[0]==dog):
        dog_dialog.visible = true
        dog_label.text = dialog[0]
        _play_sound(DOG_SOUND)

func _on_button_pressed() -> void:
    prints("_on_button_pressed", can_click)
    if can_click:
        _next_dialog()

func _hide_dialogs() -> void:
    mom_dialog.visible = false
    kid_dialog.visible = false
    dog_dialog.visible = false

func _next_dialog() -> void:
    dialog = dialog.slice(1)
    speakers = speakers.slice(1)
    if(dialog.size() >= 1):
        _start_dialog(speakers, dialog)
    else:
        _hide_dialogs()
        color_rect.visible = false
        _start_game()
    
func _play_sound_wait(CorrectSound: AudioStreamMP3) -> void:
    get_node("/root/AudioPlayer/AudioStreamPlayer").set_stream_paused(true)
    if !$AudioStreamPlayer2D.is_playing():
        $AudioStreamPlayer2D.stream = CorrectSound
        $AudioStreamPlayer2D.play()
        await get_tree().create_timer(2.5).timeout
        get_node("/root/AudioPlayer/AudioStreamPlayer").set_stream_paused(false)
        _next_dialog()

func _play_sound(CorrectSound: AudioStreamMP3) -> void:
    if !$AudioStreamPlayer2D.is_playing():
        $AudioStreamPlayer2D.stream = CorrectSound
        $AudioStreamPlayer2D.play()
    
func _broccoli() -> void:
    await pow_food._pow_food(0)
    
func _start_game() -> void:
    var current_scene = self.get_tree().current_scene
    var new_scene
    if current_scene.name == "Main":
         new_scene = load("res://Entities/Game/Game.tscn").instantiate()
    else:
        new_scene = load("res://Entities/MainScreen/Main.tscn").instantiate()
    self.get_tree().root.add_child(new_scene)
    self.get_tree().current_scene = new_scene
    current_scene.queue_free()
