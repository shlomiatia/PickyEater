class_name DialogPopup
extends Node2D

const mom: String = "mom"
const kid: String = "kid"
@onready var mom_dialog: TextureRect = $CanvasLayer/MomDialog
@onready var mom_label: Label = $CanvasLayer/MomDialog/MomLabel

@onready var kid_dialog: TextureRect = $CanvasLayer/KidDialog
@onready var kid_label: Label = $CanvasLayer/KidDialog/KidLabel

@onready var button: Button = $CanvasLayer/Button
#@onready var color_rect: ColorRect = $CanvasLayer/ColorRect
var dialog: Array[String] = []
var current_speaker: String = kid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass



func _start_dialog(speaker: String, dialog_content: Array[String]) -> void:
    _hide_dialogs()
    dialog = dialog_content
    current_speaker = speaker
    #color_rect.visible = true
    button.visible = true
    if(speaker==mom):
        mom_dialog.visible = true
        mom_label.text = dialog[0]
    if(speaker==kid):
        kid_dialog.visible = true
        kid_label.text = dialog[0]
    #show text 

func _on_button_pressed() -> void:
    dialog = dialog.slice(1)
    if(dialog.size() >= 1):
        _start_dialog(mom if (current_speaker==kid) else kid, dialog)
    else:
        _hide_dialogs()
        button.visible = false

func _hide_dialogs() -> void:
    mom_dialog.visible = false
    kid_dialog.visible = false
