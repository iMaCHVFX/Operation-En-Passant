extends TileMap
@onready var player = get_parent().get_parent().get_node("Player")
var X_OFFSET = FastNoiseLite.new()
var Y_OFFSET = FastNoiseLite.new()
@onready var tile_map = $"."

var w = 64
var h = 64

var loaded_chunks = []

func _ready():
	X_OFFSET.seed = 8934893498
	#Y_OFFSET.seed = 
	
	{
		"noise_type": 3,
		"seed": 0,
		"frequency": 0.010000,
		"domain_warp_enabled": false,
		"domain_warp_amplitude": 30.000000,
		"domain_warp_fractal_gain": 0.500000,
		"domain_warp_fractal_type": 0,
		"domain_warp_frequency": 0.050000,
		"domain_warp_fractal_octaves": 5,
		"domain_warp_type": 0,
		"fractal_type": 1,
		"fractal_gain": 0.500000,
		"fractal_lacunarity": 2.000000,
		"fractal_octaves": 5,
		"fractal_ping_pong_strength": 2.000000,
		"fractal_weighted_strength": 0.000000,
		"cellular_distance_function": 0,
		"cellular_jitter": 0.450000,
		"cellular_return_type": 1,
	}
	
	
	
	
func _process(delta):
	#var player_tile_pos : Vector2 = local_to_map(player.position)
	generate_chunk()
	
	#unload_dist_chunk(player_tile_pos)
	
func generate_chunk():
	for x in range(256):
		var ground = abs(X_OFFSET.get_noise_2d(x, 0) * 25)
		for y in range(ground, 256):
			#allows for above ground terraibn
			if X_OFFSET.get_noise_2d(x,y) > -0.25:
				if get_cell_source_id(0,Vector2i(x,y-1)) == -1:
					#checks for an empty block to the left and places a slope left
					if get_cell_source_id(0, Vector2i(x-1, y)) == -1:
						set_cell(0, Vector2i(x-1,y),0, Vector2i(7,0))
						#checks for empty to the right places right slope
					if get_cell_source_id(0, Vector2i(x+1, y)) == -1:
						set_cell(0, Vector2i(x+1,y),0, Vector2i(6,0))
												
						if get_cell_source_id(0, Vector2i(x + 1, y + 1)) == 1:						
							set_cell(0, Vector2i(x+1, y+1),0, Vector2i(6,1))

						
					set_cell(0, Vector2i(x, y), 0, Vector2i(1 ,0))
					
				else:
					set_cell(0, Vector2i(x, y), 0, Vector2i(1 ,1))
				













# this goes in generate_chunk after first forloop
#var xoff = X_OFFSET.get_noise_2d(pos.x - (w / 2) + x, pos.y - (w / 2) + y ) * 10
#var yoff = Y_OFFSET.get_noise_2d(pos.x - (w / 2) + x, pos.y - (w / 2) + y ) * 10
#----------------------------------------
	
			#if Vector2(pos.x, pos.y) not in loaded_chunks:
				#loaded_chunks.append(Vector2(pos.x, pos.y))
			
#func unload_dist_chunk(player_pos):
	#var unload_dist = (w * 2) + 1
	#
	#for chunk in loaded_chunks:
		#var dist_to_player = dist(chunk, player_pos)
		#
		#if dist_to_player > unload_dist:
			#clear_chunk(chunk)
			#loaded_chunks.erase(chunk)
			#
#func clear_chunk(pos):
	#for x in range(w):
		#for y in range(h):
			#set_cell(0, Vector2i(pos.x - (w/2) + x, pos.y - (w / 2) + y), -1, Vector2i(-1 ,-1))
#
#func dist(p1, p2):
	#var r = p1-p2 
	#return sqrt(r.x ** 2 + r.y ** 2)
	
	
func _input(event):
	if Input.is_action_just_pressed("generate new map"):
		generate_chunk()
