extends TileMap

var cellPos : Vector2
var sourceStorage = 0
var atlasCoord : Vector2i
var prevSource
var corruptCells = []
var arrayValid = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#set_custom_data("isCorrupt", false)
	#set_custom_data("startCorrupting", false)
	#set_custom_data("SpreadToPerc", 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cellPos = local_to_map(to_local(get_global_mouse_position())) 
	
	sourceStorage = get_cell_source_id(0, cellPos)
	atlasCoord = get_cell_atlas_coords(0, cellPos)
	if arrayValid:
		for i in corruptCells:
			if get_cell_tile_data(0, i).get_custom_data("startCorrupting") == true and get_cell_tile_data(0, i).get_custom_data("SpreadToPerc") < 100:
				get_cell_tile_data(0, i).set_custom_data("SpreadToPerc", get_cell_tile_data(0, i).get_custom_data("SpreadToPerc") + 1)
			elif get_cell_tile_data(0, i).get_custom_data("startCorrupting") == true and get_cell_tile_data(0, i).get_custom_data("SpreadToPerc") >= 100:
					if get_cell_tile_data(0, get_neighbor_cell(i, TileSet.CELL_NEIGHBOR_RIGHT_SIDE)) != null:
						get_cell_tile_data(0, get_neighbor_cell(i, TileSet.CELL_NEIGHBOR_RIGHT_SIDE)).set_custom_data("startCorrupting", true)
						corruptCells.append(get_neighbor_cell(i, TileSet.CELL_NEIGHBOR_RIGHT_SIDE))
					if get_cell_tile_data(0, get_neighbor_cell(i, TileSet.CELL_NEIGHBOR_LEFT_SIDE)) != null:
						get_cell_tile_data(0, get_neighbor_cell(i, TileSet.CELL_NEIGHBOR_LEFT_SIDE)).set_custom_data("startCorrupting", true)
						corruptCells.append(get_neighbor_cell(i, TileSet.CELL_NEIGHBOR_LEFT_SIDE))
					if get_cell_tile_data(0, get_neighbor_cell(i, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)) != null:
						get_cell_tile_data(0, get_neighbor_cell(i, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)).set_custom_data("startCorrupting", true)
						corruptCells.append(get_neighbor_cell(i, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE))
					if get_cell_tile_data(0, get_neighbor_cell(i, TileSet.CELL_NEIGHBOR_TOP_SIDE )) != null:
						get_cell_tile_data(0, get_neighbor_cell(i, TileSet.CELL_NEIGHBOR_TOP_SIDE)).set_custom_data("startCorrupting", true)
						corruptCells.append(get_neighbor_cell(i, TileSet.CELL_NEIGHBOR_TOP_SIDE))
					get_cell_tile_data(0, i).set_custom_data("isCorrupt", true)
			if get_cell_tile_data(0, i).get_custom_data("isCorrupt") == true:
				set_cell(0, i, 1, atlasCoord)
				
		
	
func _input(event):
	if Input.is_action_just_pressed("shoot"):
		if sourceStorage == 0:
			set_cell(0, cellPos, sourceStorage + 1, atlasCoord)
			get_cell_tile_data(0,cellPos).set_custom_data("SpreadToPerc", 100)
			get_cell_tile_data(0,cellPos).set_custom_data("startCorrupting", true)
			get_cell_tile_data(0,cellPos).set_custom_data("isCorrupt", true)
			corruptCells.append(cellPos)
			arrayValid = true
		print("cell Position: ", cellPos, " sourceStorage: ", sourceStorage, " atlas: ", atlasCoord)
				
