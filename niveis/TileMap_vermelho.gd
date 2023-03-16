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
