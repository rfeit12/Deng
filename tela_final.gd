extends Node2D

func _on_TextureButton_pressed():
	MusicaControle.parar()
	get_tree().change_scene("res://menu/menu.tscn")
