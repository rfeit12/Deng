extends TileMap

var cell
var cell_id

func _ready():
	var tile = Global.connect("hitted",self,"change")
	
func change():
	cell = world_to_map(Global.som)
	cell_id = get_cellv(cell)
	gradient()

func gradient():
	while cell_id != 11:
		match cell_id:
			cell_id: set_cellv(cell, cell_id+1)
		cell_id+=1
	yield(get_tree().create_timer(3),"timeout")
	back()
	
var cell_brancas
var cell_id_brancas

func back():
	var brancas = get_used_cells_by_id(11)
	if brancas != []:
		var i = 11
		while i != 0:
			i-=1
			set_cellv(brancas[0], i)
