extends TileMap

signal cells_available(available_cells)

var available_cells : PoolVector2Array

onready var item_controller = get_parent().get_node("item_controller")


func _ready():
	emit_signal("cells_available", available_cells)
	item_controller.connect("cells_occupied", self, "_on_cells_occupied")	


func _on_cells_occupied(occupied_cells: PoolVector2Array):
	var used_cells = get_used_cells()

	for cell in occupied_cells:
		used_cells.erase(cell)
	
	available_cells = used_cells
	emit_signal("cells_available", available_cells)
