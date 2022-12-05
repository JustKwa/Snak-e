extends TileMap

var cell_occupied

signal occupied_cells(cells)


func _physics_process(_delta):
	emit_signal("occupied_cells", cell_occupied)
