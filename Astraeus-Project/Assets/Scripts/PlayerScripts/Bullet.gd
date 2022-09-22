extends Area2D


export var moveSpeed: float = 50.0;


func _physics_process(delta):
	position += (Vector2.RIGHT * moveSpeed).rotated(deg2rad(rotation_degrees)) * delta;
	

func _on_VisibilityBox_viewport_exited(_viewport):
	queue_free();
