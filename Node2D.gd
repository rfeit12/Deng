extends Node2D

func _on_StaticBody2D_body_entered(body):
	$Piso.modulate = Color(1,1,1,1)
	yield(get_tree().create_timer(2), "timeout")
	$Piso.modulate = Color(1,1,1,0)
