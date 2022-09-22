extends HBoxContainer


signal colour_changed(colour);


export var defaultPropertyName: String;


func _ready():
	update_slider_numbers();
# warning-ignore:return_value_discarded
	update_sprite_colour();


func _on_Slider_value_changed(_value):
	update_slider_numbers();
	var colour = update_sprite_colour();
	emit_signal("colour_changed", colour);


func _on_ResetButton_pressed(): # Reset colour to default
	var defaultColour: Color = PlayerSettings.get(defaultPropertyName);
	set_colour(defaultColour);


func set_colour(colour: Color):
	var colourVector: Vector3 = Vector3(colour.r, colour.g, colour.b);
	var sliderContainer = get_node("SliderContainer");
	for index in sliderContainer.get_children().size():
		var child = sliderContainer.get_child(index);
		child.get_node("Slider").value = colourVector[index]*255;
	
	update_slider_numbers();
# warning-ignore:return_value_discarded
	update_sprite_colour();


func update_sprite_colour() -> Color:
	var rgb: Vector3 = Vector3.ZERO;
	var sliderContainer = get_node("SliderContainer");
	for index in sliderContainer.get_children().size():
		var child = sliderContainer.get_child(index);
		rgb[index] = child.get_node("Slider").value;
	
	var rgba: Color = Color8(int(rgb.x), int(rgb.y), int(rgb.z), 255); # Explicit conversion to avoid narrowing conversion warnings
	get_node("ColourDisplay").color = rgba;
	return rgba;
	

func update_slider_numbers():
	var sliderContainer = get_node("SliderContainer");
	for child in sliderContainer.get_children():
		child.get_node("Number").text = str(child.get_node("Slider").value);
