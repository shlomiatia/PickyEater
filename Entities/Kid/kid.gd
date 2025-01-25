class_name Kid extends Node2D

const speed: float = 250.0
const scale_base: float = 0.5
const legs_offset: float = 120.0

var target_position: Vector2
var skeleton2d: Skeleton2D
var floor_min_max: Vector2
var current_enum: KidStateMachine.KidStateEnum
var object_label: Label
var animation_player: AnimationPlayer
var item: Node2D
var scenery: Node2D
var dialog_label: Label
var mom: Mom
var after_throw_state: KidStateMachine.KidStateEnum = KidStateMachine.KidStateEnum.STAND
var audio_stream_player: AudioStreamPlayer;
var kid_sounds: Array[AudioStream]
var mom_sounds: Array[AudioStream]
var pickup_sound: AudioStream
var random_number_generator = RandomNumberGenerator.new()

func _ready() -> void:
	skeleton2d = get_node("Skeleton2D")
	animation_player = get_node("AnimationPlayer")
	audio_stream_player = get_node("AudioStreamPlayer")
	object_label = get_node("/root/Game/CanvasLayer/Object")
	dialog_label = get_node("/root/Game/CanvasLayer/Dialog")
	mom = get_node("/root/Game/Mom")
	var floor_body = get_node("/root/Game/Floor")
	kid_sounds = [
		preload("res://Sounds/boy angry talk.mp3"),
		preload("res://Sounds/boy talk.mp3"),
   ]
	mom_sounds = [
		preload("res://Sounds/mom angry talk.mp3"),
		preload("res://Sounds/mom talk.mp3"),
   ]
	pickup_sound = load("res://Sounds/pick-up sound.mp3")
	var collision_polygon_2d = floor_body.get_child(0) as CollisionPolygon2D
	var min_y = INF
	var max_y = -INF
	for point in collision_polygon_2d.polygon:
		min_y = min(min_y, point.y)
		max_y = max(max_y, point.y)
	floor_min_max = Vector2(min_y, max_y) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	KidStateMachine.get_current(self)._process(self, delta)
	var scaleSizeY = scale_base + inverse_lerp(floor_min_max.x, floor_min_max.y, global_position.y + legs_offset) * (0.6 - scale_base)
	var scaleSizeX = scaleSizeY
	if(skeleton2d.scale.x < 0):
		scaleSizeX = -scaleSizeY
	skeleton2d.scale = Vector2(scaleSizeX, scaleSizeY)
			
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		var object = PointCast.get_node_at_point(event.global_position)
		var text = ""
		if current_enum == KidStateMachine.KidStateEnum.ITEM && item != null:
			text = "Use %s on " % item.label
		if object != null && "label" in object.get_parent():
			text = text + object.get_parent().label
		object_label.text = text
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_LEFT:
				var mouse_position = event.global_position
				var object = PointCast.get_node_at_point(mouse_position)
				if object != null:
					KidStateMachine.get_current(self).handle_object(self, object, mouse_position)
			if event.button_index == MOUSE_BUTTON_RIGHT:
				KidStateMachine.get_current(self).cancel(self)
					
func process_walk(delta: float) -> bool:
	if target_position != Vector2.ZERO:
		global_position = global_position.move_toward(target_position, delta * speed)
		var y: float = global_position.y + legs_offset
		var potential_target_position = Vector2(global_position.x, y)
		var object = PointCast.get_node_at_point(potential_target_position)
		if global_position == target_position || object == null:
			target_position = Vector2.ZERO
			return true
	return false
					
func handle_object_stand_walk(object: Node2D, mouse_position: Vector2):

    var dialog = DataProvider.get_data().get(object.get_parent().name)
    if dialog != null:
        show_dialog(dialog)
    if object.is_in_group("items"):
        item = object.get_parent()
        if item.name == "Food3":
            show_dialog("She’s intent on getting me killed.")
            return
        var image = item.get_node("Sprite2D").texture.get_image()
        image.resize(64, 64)
        var small_texture = ImageTexture.create_from_image(image)
        Input.set_custom_mouse_cursor(small_texture, Input.CURSOR_ARROW, Vector2(32, 32))
        KidStateMachine.change_state(self, KidStateMachine.KidStateEnum.ITEM)
        return
    var can_move = object.is_in_group("floor")
    if can_move:
        var y: float = mouse_position.y - legs_offset
        var potential_target_position = Vector2(mouse_position.x, y)
        move_to(potential_target_position)
        KidStateMachine.change_state(self, KidStateMachine.KidStateEnum.WALK)      
    else: 
        target_position = Vector2.ZERO
    
func show_dialog(dialog: String):
	dialog_label.ShowDialog(dialog, Color.DARK_BLUE)
	play_sound(kid_sounds[random_number_generator.randi_range(0, kid_sounds.size() - 1)])
	
func show_mom_dialog(dialog: String):
	dialog_label.ShowDialog(dialog, Color.DARK_RED)
	play_sound(mom_sounds[random_number_generator.randi_range(0, mom_sounds.size() - 1)])
	
func play_sound(sound: AudioStream):
	audio_stream_player.stop()
	audio_stream_player.stream = sound
	audio_stream_player.play()
		
func move_to(potential_target_position: Vector2):
	target_position = potential_target_position
	var absScaleX = absf(skeleton2d.scale.x)
	if target_position.x > global_position.x:
		skeleton2d.scale.x = absScaleX
	else:
		skeleton2d.scale.x = -absScaleX
		
func finish_throw():
	KidStateMachine.change_state(self, after_throw_state)
	after_throw_state = KidStateMachine.KidStateEnum.STAND
