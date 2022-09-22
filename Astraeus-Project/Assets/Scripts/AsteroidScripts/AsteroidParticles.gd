extends Particles2D

func _ready():
	emitting = true;
	var timer = get_tree().create_timer(lifetime, false);
	timer.connect("timeout", self, "queue_free");
