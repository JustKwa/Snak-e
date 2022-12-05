extends TileMap

var used_cells = get_used_cells()
var cells_available: PoolVector2Array

signal cells_available(cells)


func _on_obstacle_spawned(grid_position: Vector2) -> void:
	var cell_occupied = grid_position
	cells_available = used_cells
	for cell in used_cells:
		if cell != cell_occupied:
			cells_available.append(cell)
		else:
			pass
	emit_signal("cells_available", cells_available)
