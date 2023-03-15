extends KinematicBody2D

var simulacao = false
var motion = Vector2.ZERO;
var speed = 200
var atacando = false
onready var animacao_deng = get_node("Sprite")
onready var iswall = get_node("wall_detect") as RayCast2D
var som = preload("res://Som.tscn")

func _process(delta):
	if simulacao:
		if is_on_floor():
			if Input.is_action_pressed("ui_up"):
				motion.y = -250;
		elif iswall.is_colliding() and !is_on_floor():
			motion.y = 0
			if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right") and iswall.scale.x < 0:
				motion.x = speed * 3;
				motion.y = -250;
			elif Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left") and iswall.scale.x > 0:
				motion.x = speed * 3;
				motion.y = -250;
			else:
				motion.y = 30
		else:
				motion.y += 10


		if Input.is_action_pressed("ui_right"):
			motion.x = speed
			$Sprite.flip_h = true;
			iswall.scale.x = 4.5
		elif Input.is_action_pressed("ui_left"):
			motion.x = -speed
			$Sprite.flip_h = false;
			iswall.scale.x = -4.5
			
		else:
			motion.x = 0
		
		if !is_on_floor() and !iswall.is_colliding():
			$Sprite.play("jump");
			$Sprite.rotation_degrees = 0
		elif iswall.is_colliding() and !is_on_floor():
			$Sprite.play("idle")
			if iswall.scale.x < 0:
				$Sprite.rotation_degrees = 90
			elif iswall.scale.x > 0:
				$Sprite.rotation_degrees = -90
		elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
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
				$Sprite.rotation_degrees = 0
			
	move_and_slide(motion, Vector2.UP)

func ataque():
	yield(get_tree().create_timer(0.4), "timeout")
	for i in range(72):
			atirar(i*5)

func podeatacar():
	yield(get_tree().create_timer(0.2),"timeout")
	atacando = false

func atirar(g):
	var som_instancia = som.instance()
	get_parent().add_child(som_instancia)
	som_instancia.global_position = self.global_position
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
