extends Button

export(PackedScene) var targetScene = null;


func _on_Button_pressed():
	get_tree().change_scene_to(targetScene);
