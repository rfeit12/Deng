extends Node2D

var simulacao = false
onready var camera2d = get_node("Camera2D")
onready var tween = get_node("Camera2D/Tween")
onready var fogueira = get_node("AnimatedSprite")
onready var musica_inicio = preload("res://assets/musica_inicio.mp3")
onready var dramatic_sound = preload("res://assets/dramatic_sound.mp3")

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
		$AudioStreamPlayer2D.stream = musica_inicio
		$AudioStreamPlayer2D.play()
	
func _on_TextureButton_pressed():
	transition_camera2D($Camera2D, $KinematicBody2D/Camera2D)
	apagar_fogueira()
	yield(fogueira,"animation_finished")
	get_node("KinematicBody2D").simulacao = true
	apagar_HUD()

func apagar_fogueira():
	$AnimatedSprite.play("apagando")
	yield(get_tree().create_timer(0.8), "timeout")
	$KinematicBody2D/reacoes.play("exclamacao")
	yield(fogueira,"animation_finished")
	$KinematicBody2D/reacoes.play("vazio")
	$AnimatedSprite.play("apagada")
	

func apagar_HUD():
	$HUD.modulate = Color(1,1,1,0)
	for i in range(10):
		$HUD.modulate = Color(PLAYER_COLORS[i])
		yield(get_tree().create_timer(0.06), "timeout")
		

func switch_camera(from, to) -> void:
	from.current = false
	to.current = true

func transition_camera2D(from: Camera2D, to: Camera2D, duration: float = 2.5) -> void:
	yield(get_tree().create_timer(0.3), "timeout")
	var transitioning = false
	if transitioning: return
	camera2d.zoom = from.zoom
	camera2d.offset = from.offset
	
	camera2d.global_transform = from.global_transform
	
	camera2d.current = true
	transitioning = true

	tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(camera2d, "global_transform", to.global_transform, duration).from(camera2d.global_transform)
	tween.tween_property(camera2d, "zoom", to.zoom, duration).from(camera2d.zoom)
#	tween.tween_property(camera2d, "fov", to.fov, duration).from(camera2d.fov)
	
	yield(get_tree().create_timer(duration), "timeout")
	
	to.current = false
	transitioning = false
	
	to.current = true

func _on_Area2D_body_entered(body):
	if $KinematicBody2D/Camera2D.current:
		$StaticBody2D/CollisionShape2D.disabled = false
		transition_camera2D($KinematicBody2D/Camera2D, $CameraPenhasco, 8)
		simulacao = false
		$KinematicBody2D/AudioStreamPlayer2D.stream = dramatic_sound
		$KinematicBody2D/AudioStreamPlayer2D.play()
		yield(get_tree().create_timer(15),"timeout")
		get_tree().change_scene("res://titulo.tscn")
