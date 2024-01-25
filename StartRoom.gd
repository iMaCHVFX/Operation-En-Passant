extends TileMap
@onready var _1 = $"1"
@onready var _1_1 = $"1/1-1"
@onready var _1_1_1 = $"1/1-1/1-1-1"
@onready var _1_1_2 = $"1/1-1/1-1-2"
@onready var _1_2 = $"1/1-2"
@onready var _1_2_1 = $"1/1-2/1-2-1"
@onready var _1_2_2 = $"1/1-2/1-2-2"
@onready var _2 = $"2"
@onready var _2_1 = $"2/2-1"
@onready var _2_1_1 = $"2/2-1/2-1-1"
@onready var _2_1_2 = $"2/2-1/2-1-2"
@onready var _2_2 = $"2/2-2"
@onready var _2_2_1 = $"2/2-2/2-2-1"
@onready var _2_2_2 = $"2/2-2/2-2-2"


var cellPos : Vector2 = Vector2(0.0,0.0)
var sourceStorage = 0
var atlasCoord : Vector2i = Vector2i(0,0)
var corruptCells = []
var updateRate : float = 0.5
var cellPlaced: bool
var maxtime = 2.0
var collide : bool = false
var cleaserPos : Vector2
var sourceIn = 1
var hasClicked : bool = false




# Called when the node enters the scene tree for the first time.
func _ready():
	match Global.initStart:
		0:
			_1.visible = true
			remove_child(_2)

		1:
			_2.visible = true
			remove_child(_1)
			
	if Global.initStart == 0:
		match Global.secondRoom:
			0:
				_1_1.visible = true
				_1.remove_child(_1_2)
			1:
				_1_2.visible = true
				_1.remove_child(_1_1)
	else:
		match Global.secondRoom:
			0:
				_2_1.visible = true
				_2.remove_child(_2_2)
			1:
				_2_2.visible = true
				_2.remove_child(_2_1)

	if Global.secondRoom == 0 and Global.initStart == 0:
		match Global.finalRoom:
			0:
				_1_1_1.visible = true
				_1_1.remove_child(_1_1_2)
			1:
				_1_1_2.visible = true
				_1_1.remove_child(_1_1_1)
	elif Global.secondRoom == 0 and Global.initStart == 1:
		match Global.finalRoom:
			0:
				_2_1_1.visible = true
				_2_1.remove_child(_2_1_2)
			1:
				_2_1_2.visible = true
				_2_1.remove_child(_2_1_1)
	elif Global.secondRoom == 1 and Global.initStart == 0:
		match Global.finalRoom:
			0:
				_1_2_1.visible = true
				_1_2.remove_child(_1_2_2)
			1:
				_1_2_2.visible = true
				_1_2.remove_child(_1_2_1)
	elif Global.secondRoom == 1 and Global.initStart == 1:
		match Global.finalRoom:
			0:
				_2_2_1.visible = true
				_2_2.remove_child(_2_2_2)
			1:
				_2_2_2.visible = true
				_2_2.remove_child(_2_2_1)
				
	var timer = Timer.new()
	timer.wait_time = maxtime
	timer.autostart = true
	add_child(timer)
		
	timer.timeout.connect(on_timeout)


	print("1: ",_1.visible, " 1-1: ",_1_1.visible, " 1-2: ",_1_2.visible," 1-1-1: ",_1_1_1.visible, " 1-1-2: ",_1_1_2.visible, " 1-2-1: ",_1_2_1.visible," 1-2-2 ",_1_2_2.visible, "2: ",_2.visible, " 2-1: ",_2_1.visible, " 2-2: ",_2_2.visible," 2-1-1: ",_2_1_1.visible, " 2-1-2: ",_2_1_2.visible, " 2-2-1: ",_2_2_1.visible," 2-2-2 ", _2_2_2.visible)
 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if collide:
		startFill(cellPos, 0, atlasCoord)
	
func _input(event):
	if Input.is_action_just_pressed("rightclick"):
		hasClicked = true
		if hasClicked:
			startFill(cellPos, sourceStorage, atlasCoord)
			
			set_cell(0, cellPos, 1, atlasCoord)
			
func startFill(worldPos, setToCell, replacementTile):
	if collide:
		cellPos = local_to_map(to_local(cleaserPos))
	elif hasClicked:
		cellPos = local_to_map(to_local(get_global_mouse_position()))
	hasClicked = false
	
	sourceStorage = get_cell_source_id(0, cellPos)
	atlasCoord = get_cell_atlas_coords(0, cellPos)
	
	set_cell(0, cellPos, setToCell, get_cell_atlas_coords(0, cellPos))


	var q = [ cellPos, cellPos, cellPos]
	while q: 
		var currCell  : Vector2 = q.pop_front()
		var currCellU = Vector2(currCell.x, currCell.y-1)
		var currCellL = Vector2(currCell.x-1, currCell.y)
		var currCellR = Vector2(currCell.x+1, currCell.y)
		var currCellD = Vector2(currCell.x, currCell.y+1)
		
		if collide:
			sourceIn = 0
		else:
			sourceIn = 1

		if replacementTile != get_cell_atlas_coords(0, currCellL):
			replacementTile = get_cell_atlas_coords(0, currCellL)		
		
		if get_cell_source_id(0, currCellL) == setToCell:
			
			
			q.append(currCellL)
			set_cell(0, currCellL, sourceIn, replacementTile)

		if replacementTile != get_cell_atlas_coords(0, currCellR):
			replacementTile = get_cell_atlas_coords(0, currCellR)			

		if get_cell_source_id(0, currCellR) == setToCell:
			
			q.append(currCellR)
			set_cell(0, currCellR, sourceIn, replacementTile)

		if replacementTile !=  get_cell_atlas_coords(0, currCellD):
			replacementTile = get_cell_atlas_coords(0, currCellD)			

		if get_cell_source_id(0, currCellD) == setToCell:
			
			q.append(currCellD)
			set_cell(0, currCellD, sourceIn, replacementTile)

		if replacementTile != get_cell_atlas_coords(0, currCellU):
			replacementTile = get_cell_atlas_coords(0, currCellU)			

		if get_cell_source_id(0, currCellU) == setToCell:
			
			q.append(currCellU)
			set_cell(0, currCellU, sourceIn, replacementTile)
		if collide:
			collide = false
			break
		
		await(get_tree().create_timer(1)).timeout
		
func on_timeout():
	if collide:
		startFill(cellPos, 0, atlasCoord)
	
	#collide = false		
