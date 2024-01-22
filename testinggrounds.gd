class_name fuckyoufuckyoufuckyoufuckyou
extends TileMap

var cellPos : Vector2
var sourceStorage = 0
var atlasCoord : Vector2i
var prevSource
var corruptCells = []
var storageArr = []
var firstHalf : bool = true



# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cellPos = local_to_map(to_local(get_global_mouse_position())) 
	
	sourceStorage = get_cell_source_id(0, cellPos)
	atlasCoord = get_cell_atlas_coords(0, cellPos)
	
	

	
	if firstHalf:
		for i in range(corruptCells.size()/2):
			var index = i if firstHalf else i + corruptCells.size()/2
			if get_cell_tile_data(0, corruptCells[index]).get_custom_data("startCorrupting") == true and get_cell_tile_data(0, corruptCells[index]).get_custom_data("SpreadToPerc") < 1:
				get_cell_tile_data(0, corruptCells[index]).set_custom_data("SpreadToPerc", get_cell_tile_data(0, corruptCells[index]).get_custom_data("SpreadToPerc") + 0.001)
			elif get_cell_tile_data(0, corruptCells[index]).get_custom_data("startCorrupting") == true and get_cell_tile_data(0, corruptCells[index]).get_custom_data("SpreadToPerc") >= 1:
					if get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_RIGHT_SIDE)) != null:
						get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_RIGHT_SIDE)).set_custom_data("startCorrupting", true)
						if corruptCells.find(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_RIGHT_SIDE)) == -1:
							corruptCells.append(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_RIGHT_SIDE))
						
					if get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_LEFT_SIDE)) != null:
						get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_LEFT_SIDE)).set_custom_data("startCorrupting", true)
						if corruptCells.find(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_LEFT_SIDE)) == -1:
							corruptCells.append(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_LEFT_SIDE))
						
					if get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)) != null:
						get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)).set_custom_data("startCorrupting", true)
						if corruptCells.find(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)) == -1:
							corruptCells.append(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_BOTTOM_SIDE))
						
					if get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_TOP_SIDE )) != null:
						get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_TOP_SIDE)).set_custom_data("startCorrupting", true)
						if corruptCells.find(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_TOP_SIDE)) == -1:
							corruptCells.append(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_TOP_SIDE))
						
					get_cell_tile_data(0, corruptCells[index]).set_custom_data("isCorrupt", true)
			if get_cell_tile_data(0, corruptCells[index]).get_custom_data("isCorrupt") == true and get_cell_source_id(0, corruptCells[index]) == 0:
				set_cell(0, corruptCells[index], 1, get_cell_atlas_coords(0, corruptCells[index]))
		firstHalf = false
	else:
		for i in range(corruptCells.size()/2):
			var index = i if firstHalf else i + corruptCells.size()/2
			if get_cell_tile_data(0, corruptCells[index]).get_custom_data("startCorrupting") == true and get_cell_tile_data(0, corruptCells[index]).get_custom_data("SpreadToPerc") < 1:
				get_cell_tile_data(0, corruptCells[index]).set_custom_data("SpreadToPerc", get_cell_tile_data(0, corruptCells[index]).get_custom_data("SpreadToPerc") + 0.001)
			elif get_cell_tile_data(0, corruptCells[index]).get_custom_data("startCorrupting") == true and get_cell_tile_data(0, corruptCells[index]).get_custom_data("SpreadToPerc") >= 1:
					if get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_RIGHT_SIDE)) != null:
						get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_RIGHT_SIDE)).set_custom_data("startCorrupting", true)
						if corruptCells.find(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_RIGHT_SIDE)) == -1:
							corruptCells.append(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_RIGHT_SIDE))
						
					if get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_LEFT_SIDE)) != null:
						get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_LEFT_SIDE)).set_custom_data("startCorrupting", true)
						if corruptCells.find(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_LEFT_SIDE)) == -1:
							corruptCells.append(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_LEFT_SIDE))
						
					if get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)) != null:
						get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)).set_custom_data("startCorrupting", true)
						if corruptCells.find(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)) == -1:
							corruptCells.append(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_BOTTOM_SIDE))
						
					if get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_TOP_SIDE )) != null:
						get_cell_tile_data(0, get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_TOP_SIDE)).set_custom_data("startCorrupting", true)
						if corruptCells.find(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_TOP_SIDE)) == -1:
							corruptCells.append(get_neighbor_cell(corruptCells[index], TileSet.CELL_NEIGHBOR_TOP_SIDE))
						
					get_cell_tile_data(0, corruptCells[index]).set_custom_data("isCorrupt", true)
			if get_cell_tile_data(0, corruptCells[index]).get_custom_data("isCorrupt") == true and get_cell_source_id(0, corruptCells[index]) == 0:
				set_cell(0, corruptCells[index], 1, get_cell_atlas_coords(0, corruptCells[index]))	
		firstHalf = true		
		
	
func _input(event):
	if Input.is_action_just_pressed("shoot"):
		if sourceStorage == 0:
			set_cell(0, cellPos, sourceStorage + 1, atlasCoord)
			get_cell_tile_data(0,cellPos).set_custom_data("SpreadToPerc", 100)
			get_cell_tile_data(0,cellPos).set_custom_data("startCorrupting", true)
			get_cell_tile_data(0,cellPos).set_custom_data("isCorrupt", true)
			if corruptCells.find(cellPos) == -1:
				corruptCells.append(cellPos)
			
		#print("cell Position: ", cellPos, " sourceStorage: ", sourceStorage, " atlas: ", atlasCoord)
				
