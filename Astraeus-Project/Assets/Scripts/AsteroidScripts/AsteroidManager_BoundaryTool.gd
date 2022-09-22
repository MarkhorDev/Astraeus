tool
extends Node2D


export var run: bool = true setget set_editor_process;


func _physics_process(_delta):
	update();


func _draw():
	if (Engine.editor_hint):
		var spawnBoundaries = get_parent().spawnBoundaries;
		var drawPoints = [
			Vector2(-spawnBoundaries.x, -spawnBoundaries.y),
			Vector2(spawnBoundaries.x, -spawnBoundaries.y),
			Vector2(spawnBoundaries.x, spawnBoundaries.y),
		];
		drawPoints = PoolVector2Array(drawPoints);
		draw_polyline(drawPoints, Color.greenyellow, 2.0, true);


func set_editor_process(value: bool):
	run = value;
	set_physics_process(value);
