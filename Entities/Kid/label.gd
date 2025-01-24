extends Label

@onready var camera = get_node("/root/Game/Camera2D")  # Adjust path as needed
@onready var target = get_node("../")  # The character node

func _process(_delta):
    # Get screen size
    var screen_size = get_viewport_rect().size
    
    # Get target's position in screen coordinates
    var target_pos = target.global_position
    if camera:
        target_pos = get_viewport_rect().size / 2.0 + (target_pos - camera.global_position)
    
    # Position label above target
    var label_pos = target_pos + Vector2(0, -50)  # Offset upward by 50 pixels
    
    # Clamp position to stay within screen bounds
    # Add padding of half the label's size to keep text visible
    var half_size = size / 2
    label_pos.x = clamp(label_pos.x, half_size.x, screen_size.x - half_size.x)
    label_pos.y = clamp(label_pos.y, half_size.y, screen_size.y - half_size.y)
    
    # Set the label's position
    global_position = label_pos
