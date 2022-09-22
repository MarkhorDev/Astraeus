extends Node2D


var bulletScene: PackedScene = preload("res://Assets/Scenes/Objects/Bullet.tscn");
export var rotationOffset: float;
export var bulletColours: PoolColorArray;


func _on_Timer_timeout():
	spawn_laser();


func spawn_laser():
	var random = RandomNumberGenerator.new();
	random.randomize();
	
	var viewportRect = get_viewport_rect().size;
	
	var spawnPos: Vector2;
	var rotation: float;
	var spawnCode = random.randi_range(0, 3);
	match (spawnCode):
		0:
			spawnPos = Vector2(viewportRect.x, random.randf_range(-viewportRect.y, viewportRect.y));
			rotation = random.randf_range(180-rotationOffset, 180 + rotationOffset);
		1:
			spawnPos = Vector2(-viewportRect.x, random.randf_range(-viewportRect.y, viewportRect.y));
			rotation = random.randf_range(0-rotationOffset, 0+rotationOffset);
		2:
			spawnPos = Vector2(random.randf_range(-viewportRect.x, viewportRect.x), viewportRect.y);
			rotation = random.randf_range(270-rotationOffset, 270+rotationOffset);
		3:
			spawnPos = Vector2(random.randf_range(-viewportRect.x, viewportRect.x), -viewportRect.y);
			rotation = random.randf_range(90-rotationOffset, 90+rotationOffset);
		
	var bullet = bulletScene.instance();
	bullet.global_position = spawnPos;
	bullet.rotation_degrees = rotation;
	bullet.modulate = bulletColours[random.randi_range(0, len(bulletColours)-1)];
	
	call_deferred("add_child", bullet, true);
