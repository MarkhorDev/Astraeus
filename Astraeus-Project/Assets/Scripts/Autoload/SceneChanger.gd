extends Node


var sceneTransition: AnimationPlayer;


func _ready():
	sceneTransition = SceneTransition.get_node("AnimationPlayer");
	assert(sceneTransition != null);


func change_scene(scenePath: String):
	if (sceneTransition == null):
		return;
	
	var tree = get_tree();
	sceneTransition.play("FadeIn");
	var audioGroup = tree.get_nodes_in_group("AudioTheme");
	if (len(audioGroup) > 0):
		audioGroup[0].get_node("AnimationPlayer").play("FadeOut");
	
	yield (sceneTransition, "animation_finished");
	assert(tree.change_scene(scenePath) == OK);
	sceneTransition.play("FadeOut");
	
	tree.paused = false;
