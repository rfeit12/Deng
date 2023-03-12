extends Node2D

onready var musica = preload("res://assets/musica_caindo.mp3")
onready var player = get_node("KinematicBody2D")

const PLAYER_COLORS = [
	Color(1, 1, 1, 0.9),
	Color(1, 1, 1, 0.8),
	Color(1, 1, 1, 0.7),
	Color(1, 1, 1, 0.6),
	Color(1, 1, 1, 0.5),
	Color(1, 1, 1, 0.4),
	Color(1, 1, 1, 0.3),
	Color(1, 1, 1, 0.2),
	Color(1, 1, 1, 0.1),
	Color(1, 1, 1, 0.0),
]

func _ready():
	yield(get_tree().create_timer(2.5),"timeout")
	MusicaControle.tocar(musica)
	textos()
	player.deng_cai()

func textos():
	yield(get_tree().create_timer(2.4),"timeout")
	$Label.text = "Feito por:\nRenan Feitosa"
	yield(get_tree().create_timer(5),"timeout")
	for i in range(10):
		$Label.modulate = Color(PLAYER_COLORS[i])
		yield(get_tree().create_timer(0.1), "timeout")
	yield(get_tree().create_timer(4),"timeout")
	$Label.text = "Deng"
	$Label.rect_position = Vector2(256, 100)
	$Label.modulate = Color(1,1,1,1)
	$Label.get("custom_fonts/font").set_size(150)
	$deng_ideograma.show()
