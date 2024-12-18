extends Control


func _on_french_pressed():
	TranslationServer.set_locale("fr")
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_english_pressed():
	TranslationServer.set_locale("en")
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
