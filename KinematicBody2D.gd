extends KinematicBody2D

var motion = Vector2.ZERO;
var speed = 300
var atacando = false
onready var animacao_deng = get_node("Sprite")
var som = preload("res://Som.tscn")

func _process(delta):
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = -250;

	else:
		motion.y += 10
#		$Sprite.play("Jump");
		
	if Input.is_action_pressed("ui_right"):
		motion.x = speed
		$Sprite.flip_h = true;
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed
		$Sprite.flip_h = false;
		
	else:
		motion.x = 0
	
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		$Sprite.play("run");
	elif Input.is_action_pressed("ui_down"):
		atacando = true
		ataque()
		$Sprite.play("attack")
		yield(animacao_deng,"animation_finished")
		$Sprite.play("idle")
		atacando = false
	elif atacando == false:
		$Sprite.play("idle");
		
	move_and_slide(motion, Vector2.UP)

func ataque():
	yield(get_tree().create_timer(0.4), "timeout")
	for i in range(30):
		if $Sprite.flip_h == true:
			atirar((i-17)*4)
		else:
			atirar(((i+30)*4))


func atirar(g):
	var som_instancia = som.instance()
	get_parent().add_child(som_instancia)
	som_instancia.global_position = $".".global_position
	
	som_instancia.rotation_degrees = g
