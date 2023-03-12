extends KinematicBody2D

var simulacao = false
var motion = Vector2.ZERO;
var speed = 200
var atacando = false
onready var animacao_deng = get_node("Sprite")
var som = preload("res://Som.tscn")

func _process(delta):
	if simulacao:
		if is_on_floor():
			if Input.is_action_pressed("ui_up"):
				motion.y = -250;
				$Sprite.play("jump");
				

		else:
			motion.y += 10
			
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
		elif !atacando:
			if Input.is_action_just_pressed("attack"):
				atacando = true
				ataque()
				$Sprite.play("attack")
				yield(animacao_deng,"animation_finished")
				$Sprite.play("idle")
				podeatacar()
			else:
				$Sprite.play("idle");
			
	move_and_slide(motion, Vector2.UP)

func ataque():
	yield(get_tree().create_timer(0.4), "timeout")
	for i in range(25):
		if $Sprite.flip_h == true:
			atirar((i-17)*4)
		else:
			atirar(((i+30)*4))

func podeatacar():
	yield(get_tree().create_timer(2),"timeout")
	atacando = false

func atirar(g):
	var som_instancia = som.instance()
	get_parent().add_child(som_instancia)
	som_instancia.global_position = $".".global_position
	
	som_instancia.rotation_degrees = g

func deng_cai():
	var caindo = true
	motion.y += 50
	while caindo:
		self.rotation_degrees += 20
		yield(get_tree().create_timer(0.07),"timeout")
		if position.y > get_viewport().size.y + 250 :
			get_tree().change_scene("res://nivel.tscn")
		
	


func _on_Area2D_body_entered(body):
	simulacao = false
	motion.x = 0
	$Sprite.play("idle")
	$Sprite.flip_h = true
	yield(get_tree().create_timer(2),"timeout")
	$Sprite.play("run")
	motion.y = 50
	speed = 80
	motion.x = speed
