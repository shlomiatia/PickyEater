extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass

func get_node_at_point(point: Vector2) -> Node2D:
    var query = PhysicsPointQueryParameters2D.new()
    query.position = point
    var space_state = get_world_2d().direct_space_state
    var results = space_state.intersect_point(query)
    if results.size() > 0:
        results = results.map(func(result): return result["collider"] as Node2D)
        for result in results:
            if !result.is_in_group("floor"):
                return result
                
        return results[0]
    return null
