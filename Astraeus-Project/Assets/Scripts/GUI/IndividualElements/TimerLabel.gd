extends Label

var time: float;

func _ready():
	time = 0;
	if (!PlayerSettings.config.get_value("Settings", "timerToggle", PlayerSettings.timerToggleDefault)):
		visible = false;
	

func _process(delta):
	time += delta;
	var formattedTime = get_formatted_time();
	text = formattedTime;
	PlayerSettings.gameTime = formattedTime;


func get_formatted_time() -> String:
	var minutes = floor(time/60);
	var seconds = time - (minutes*60);
	return "%02d" % minutes + ":" + "%02d" % seconds;
