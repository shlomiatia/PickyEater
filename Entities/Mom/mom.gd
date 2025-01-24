class_name Mom extends Node2D

const scale_base: float = 0.5
const legs_offset: float = 150.0

var label: String = "Mom"

var current_enum: MomStateMachine.MomStateEnum
var target_node: Node2D
var animation_player: AnimationPlayer
var floor_min_max: Vector2
var skeleton2d: Skeleton2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    skeleton2d = get_node("Skeleton2D")
    animation_player = get_node("AnimationPlayer")
    var floor_body = get_node("/root/Game/Floor")
    var collision_polygon_2d = floor_body.get_child(0) as CollisionPolygon2D
    var min_y = INF
    var max_y = -INF
    for point in collision_polygon_2d.polygon:
        min_y = min(min_y, point.y)
        max_y = max(max_y, point.y)
    floor_min_max = Vector2(min_y, max_y) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    MomStateMachine.get_current(self)._process(self, delta)
    var scaleSizeY = scale_base + inverse_lerp(floor_min_max.x, floor_min_max.y, global_position.y + legs_offset) * (0.6 - scale_base)
    var scaleSizeX = scaleSizeY
    if(skeleton2d.scale.x < 0):
        scaleSizeX = -scaleSizeY
    skeleton2d.scale = Vector2(scaleSizeX, scaleSizeY)

func move_to(node: Node2D):
    target_node = node
    var absScaleX = absf(skeleton2d.scale.x)
    if target_node.global_position.x > global_position.x:
        skeleton2d.scale.x = absScaleX
    else:
        skeleton2d.scale.x = -absScaleX
    MomStateMachine.change_state(self, MomStateMachine.MomStateEnum.WALK)
