extends Node2D

onready var musica_completa = load("res://assets/musica_completa.mp3")

var no_nivel = false

func tocar(musica = musica_completa):
	$musica.stream = musica
	$musica.play()
	$musica.volume_db = -15

func reiniciar(musica = musica_completa):
	$musica.pause_mode = true
	tocar()
