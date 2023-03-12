extends Node2D

onready var battle_music = load("res://assets/musica_caindo.mp3")

func tocar(musica):
	$musica.stream = musica
	$musica.play()
