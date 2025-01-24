class_name Kid extends Node2D

const scale_base: float = 0.45

var target_position: Vector2
var sprite2d: Sprite2D
var floor_min_max: Vector2
var legs_offset: float
var current_enum: KidStateMachine.PlayerStateEnum
var item_label: Label
var animation_player: AnimationPlayer
var dialog_label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    sprite2d = get_node("Sprite2D")
    animation_player = get_node("AnimationPlayer")
    dialog_label = get_node("Label")
    item_label = get_node("/root/Game/CanvasLayer/Label")
    var floor_body = get_node("/root/Game/Floor")
    var collision_polygon_2d = floor_body.get_child(0) as CollisionPolygon2D
    var min_y = INF
    var max_y = -INF
    for point in collision_polygon_2d.polygon:
        min_y = min(min_y, point.y)
        max_y = max(max_y, point.y)
    floor_min_max = Vector2(min_y, max_y)
    legs_offset = sprite2d.texture.get_height() * sprite2d.scale.y / 2.0 - 50.0 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    KidStateMachine.get_current(self)._process(self, delta)
    var scaleSizeY = scale_base + inverse_lerp(floor_min_max.x, floor_min_max.y, global_position.y + legs_offset) * (0.5 - scale_base)
    var scaleSizeX = scaleSizeY
    if(sprite2d.scale.x < 0):
        scaleSizeX = -scaleSizeY
    sprite2d.scale = Vector2(scaleSizeX, scaleSizeY)
            
func _unhandled_input(event: InputEvent):
    if event is InputEventMouseMotion:
        var object = PointCast.get_node_at_point(event.global_position)
        if object != null && "label" in object.get_parent():
            item_label.text = object.get_parent().label
        else:
            item_label.text = ""
    if event is InputEventMouseButton:
        if event.is_pressed():
            if event.button_index == MOUSE_BUTTON_LEFT:
                var mouse_position = event.global_position
                var y: float =  mouse_position.y - legs_offset
                var potential_target_position = Vector2(mouse_position.x, y)
                var object = PointCast.get_node_at_point(mouse_position)
                var dialog = DataProvider.get_data().get(object.get_parent().name)
                if dialog != null:
                    dialog_label.text = dialog
                    animation_player.play("Show")
                #var item = PointCast.get_node_at_point(mouse_position, "items")
                #if item != null:
                    #move_to_object_at(potential_target_position)
                    #target_scenery = null
                    #target_item = item
                    #return
                #var scenery = PointCast.get_node_at_point(mouse_position, "scenery")
                #if scenery != null: 
                    #move_to_object_at(potential_target_position)
                    #target_item = null
                    #target_scenery = scenery
                    #return
                var can_move = object.is_in_group("floor")
                if can_move:
                    move_to(potential_target_position)
                else: 
                    target_position = Vector2.ZERO
             
func move_to_object_at(potential_target_position: Vector2):                    
    if(potential_target_position.y < floor_min_max.x):
        potential_target_position.y = floor_min_max.x 
        move_to(potential_target_position)
        
func move_to(potential_target_position: Vector2):
    target_position = potential_target_position
    var absScaleX = absf(sprite2d.scale.x)
    if target_position.x > global_position.x:
        sprite2d.scale.x = absScaleX
    else:
        sprite2d.scale.x = -absScaleX
    KidStateMachine.change_state(self, KidStateMachine.PlayerStateEnum.WALK)          
