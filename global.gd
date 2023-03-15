extends Node

var som = Vector2.ZERO
signal hitted

func emit_hit():
	emit_signal("hitted")


