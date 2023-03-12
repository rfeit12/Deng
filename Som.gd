extends Area2D

func _process(delta):
	move_local_x(450 * delta)
	move_local_y(80 * delta)

func _on_Som_body_entered(body):
	if body.is_in_group("branco"):
		Global.som = global_position
		Global.emit_hit()
		queue_free()


