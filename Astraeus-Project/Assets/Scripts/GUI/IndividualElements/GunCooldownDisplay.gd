extends Line2D


var startingPositions: PoolVector2Array;
var percent: float = 0;


func _ready():
	if (!PlayerSettings.config.get_value("Settings", "cooldownToggle", PlayerSettings.cooldownToggleDefault)):
		visible = false;
		set_process(false);
		return;
	
	default_color = PlayerSettings.config.get_value("Settings", "bulletColour", PlayerSettings.bulletColourDefault);
	startingPositions = points;
	

func _process(_delta):
	var xCoord = (startingPositions[1].x - startingPositions[0].x) * (percent/100);
	points[1] = Vector2(xCoord-abs(startingPositions[0].x), 0);
