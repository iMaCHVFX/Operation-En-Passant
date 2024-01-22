extends CanvasLayer
class_name JamClient

var client_ui_scn = preload("res://addons/jam_launch/ui/ClientUI.tscn")
var client_ui: ClientUI
var current_client_token: String
var jwt: Jwt = Jwt.new()

var test_client_number: int = 1:
	set(val):
		if val != test_client_number and OS.is_debug_build():
			test_client_number = val
			await _setup_test_gjwt()

var session_id: String = ""
var api: ClientApi
var keys: ClientKeys

var jc: JamConnect:
	get:
		return get_parent()

func _init():
	layer = 512
	
	keys = ClientKeys.new()
	add_child(keys)

func _ready():
	api = ClientApi.new()
	api.game_id = jc.game_id
	api.jwt = jwt
	add_child(api)
	
	var gjwt = keys.get_included_gjwt()
	if gjwt == null:
		if OS.is_debug_build():
			_setup_test_gjwt()
		else:
			push_error("Failed to load GJWT")
	else:
		_set_gjwt(gjwt as String)

func _setup_test_gjwt():
	var gjwt = await keys.get_test_gjwt(jc.game_id, test_client_number)
	if gjwt != null:
		_set_gjwt(gjwt as String)
	else:
		push_error("Failed to load GJWT")

func _set_gjwt(gjwt: String):
	var gjwtRes = jwt.set_token(gjwt)
	if gjwtRes.errored:
		push_error(gjwtRes.error)

func client_start():
	print("Starting as client...")
	multiplayer.connected_to_server.connect(_on_client_connect)
	multiplayer.connection_failed.connect(_on_client_connect_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnect)
	client_ui = client_ui_scn.instantiate()
	client_ui.client_api = api
	client_ui.connect_to_session.connect(client_session_request)
	add_child(client_ui)

func client_session_request(ip: String, port: int, token: String, domain: Variant):
	current_client_token = token
	client_ui.visible = false
	
	var dev_ws = jc.network_mode == "websocket" and OS.is_debug_build()
	
	if OS.has_feature("websocket") or dev_ws:
		if domain == null:
			domain = "jamserve.net"
		ip = "wss://%s" % domain
	
	jc.log_event.emit("Attempting to connect to %s:%d..." % [ip, port])
	print("Attempting to connect to %s:%d..." % [ip, port])
	
	var peer
	var err
	if OS.has_feature("websocket") or dev_ws:
		peer = WebSocketMultiplayerPeer.new()
		err = peer.create_client("%s:%d" % [ip, port], TLSOptions.client_unsafe())
	else:
		peer = ENetMultiplayerPeer.new()
		err = peer.create_client(ip, port)
	if err != OK:
		printerr("Server connection error: ", err)
		jc.log_event.emit("Error: %d" % err)
		client_ui.visible = true
		return
	multiplayer.multiplayer_peer = peer

func leave_game():
	client_ui.visible = true
	if client_ui.active_session != null: # i.e. not a dev mode local client
		await client_ui.exit_lobby()
	multiplayer.multiplayer_peer.close()

func _on_client_connect_fail():
	jc.log_event.emit("Connection to server failed")
	printerr("connection to server failed")
	client_ui.visible = true

func _on_client_connect():
	jc.log_event.emit("Connected, verifying...")
	jc.verify_player.rpc_id(1, current_client_token)

func _on_server_disconnect():
	jc.log_event.emit("Server disconnected")
	client_ui.visible = true