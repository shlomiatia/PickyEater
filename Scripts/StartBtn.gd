class_name MainScreen
extends Button

@onready var pow_food: PowFood = $"../../CanvasLayer2/PowFood"
const INTRO: Array[String] = ["Danny! Time for Dinner!",
"Coming mom!",
"...",
"Oh there you are Danny, if I'd waited any longer my hair would turn gray!",
"...",
"Your dinner is ready!",
"...",
"Oh no!",
"Eat up, before it gets cold!",
"Have you seen this thing bobby? It’s disgusting! I think mom is trying to poison me again.",
"Wang Wang",
"That’s right. I have to find a way to get rid of it without mom noticing, or I am doomed!",
"..."
]
@onready var dialog_popup: DialogPopup = $"../../CanvasLayer2/DialogPopup"
const INTRO_SPEAKERS: Array[String] = [dialog_popup.mom,
dialog_popup.kid,
dialog_popup.mom,
dialog_popup.mom,
dialog_popup.laugh,
dialog_popup.mom,
dialog_popup.food,
dialog_popup.kid,
dialog_popup.mom,
dialog_popup.kid,
dialog_popup.dog,
dialog_popup.kid,
dialog_popup.dog
]

const REMOTE_CONTROL_1 = preload("res://Textures/ui/Remote Control 1.png")

func _ready() -> void:
    Input.set_custom_mouse_cursor(REMOTE_CONTROL_1, Input.CURSOR_POINTING_HAND)


func _on_pressed() -> void:
    #var current_scene = self.get_tree().current_scene
    #self.get_tree().root.add_child(new_scene)
    #self.get_tree().current_scene = new_scene
    #current_scene.queue_free()
    
    dialog_popup._start_dialog(INTRO_SPEAKERS, INTRO)

func _broccoli() -> void:
    pow_food._pow_food(0)
    
    
