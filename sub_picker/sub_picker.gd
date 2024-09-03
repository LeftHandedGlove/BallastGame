extends Control


func _on_previous_screen_button_pressed() -> void:
	SceneManager.switch_to_scene("MainMenu")


func _on_new_sub_button_pressed() -> void:
	SceneManager.switch_to_scene("SubBuilder")
