extends ProgressBar


var complete: bool;


func _ready():
	if (!PlayerSettings.config.get_value("Settings", "difficultyToggle", PlayerSettings.difficultyToggleDefault)):
		get_parent().visible = false;
		set_process(false);
		return;
	
	complete = false;


func _process(_delta):
	value = PlayerSettings.difficultyValue;
	
	if (value >= max_value and complete == false):
		complete = true;
		get_node("AnimationPlayer").play("Blink");
