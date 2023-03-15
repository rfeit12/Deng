extends TileMap

var cell
var cell_id

func _ready():
	var tile = Global.connect("hitted",self,"change")
	
func change():
	cell = Global.som
#	world_to_map(Global.som)
	cell_id = get_cellv(cell)
	if cell_id == 0:
		match cell_id:
			cell_id: set_cellv(cell, 1)
	
var cell_brancas
var cell_id_brancas

func back():
	var brancas = get_used_cells_by_id(11)
	if brancas != []:
		var i = 11
		while i != 0:
			i-=1
			set_cellv(brancas[0], i)
