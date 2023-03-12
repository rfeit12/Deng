extends Node

var simulacao = true
var a = 1.0

func _ready():
	for i in get_child_count():
		$".".get_child(i).modulate = Color (1,1,1,0)

func backtoblack():
#	yield(get_tree().create_timer(2), "timeout")	
#	for i in get_child_count():
#		a = 1.0
#		while get_child(i).modulate != Color(1,1,1,0):
#			a -= 0.1
#			$".".get_child(i).modulate = Color(1,1,1,a)
#			yield(get_tree().create_timer(0.1),"timeout")
#	i += 1
	pass


#func _on_Button_pressed():
#	yield(get_tree().create_timer(2), "timeout")	
#	for i in get_child_count():
#		a = 1.0
#		while get_child(i).modulate != Color(1,1,1,0):
#			a -= 0.1
#			$".".get_child(i).modulate = Color(1,1,1,a)
#			yield(get_tree().create_timer(0.05),"timeout")
