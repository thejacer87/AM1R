extends Node

signal transition_in_started(room)
signal transition_in_finished
signal transition_out_started
signal transition_out_finished

var _time_max := 100
var _next_scene
var _next_room
var _main_scene
var _loader


func _ready():
	var root = get_tree().get_root()
	_main_scene = root.get_child(root.get_child_count() - 1)


func _process(time):
	if _loader == null:
		# no need to process anymore
		set_process(false)
		return

	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + _time_max:

		# poll your loader
		var err = _loader.poll()

		if err == ERR_FILE_EOF: # Finished loading.
			_next_scene = _loader.get_resource()
			_loader = null
			break
		elif err == OK:
			#update_progress()
			pass
			break
		else: # error during loading
			#show_error()
			_loader = null
			break


func load_level(level: String) -> void:
	_loader = ResourceLoader.load_interactive(level)
	if _loader == null:
		#show_error()
		return
	set_process(true)


func set_new_scene(next_scene):
	set_process(false)
	var child = _main_scene.get_children()
	var old_scene = _main_scene.get_child(0)
	var next_level = false
	if is_instance_valid(next_scene):
		next_level = next_scene.instance()
		if Globals.Samus != null:
			old_scene.remove_child(Globals.Samus)
			old_scene.queue_free()
			next_level.add_child(Globals.Samus)
		_main_scene.add_child(next_level)
	return next_level


func transition_out(player: AnimationPlayer, animation: String, scene: String) -> void:
	connect("transition_out_started", Globals.Samus, "_on_transition_out_started")
	emit_signal("transition_out_started")
	player.play(animation)
	load_level(scene)
	yield(player, "animation_finished")
	var next_level = set_new_scene(_next_scene)
	connect("transition_out_finished", next_level, "_on_transition_out_finished")
	emit_signal("transition_out_finished")


func transition_in(player: AnimationPlayer, animation: String, room: String) -> void:
	connect("transition_in_started", Globals.Samus, "_on_transition_in_started")
	emit_signal("transition_in_started", room)
	player.play(animation)
	yield(player, "animation_finished")
	connect("transition_in_finished", Globals.Samus, "_on_transition_in_finished")
	emit_signal("transition_in_finished")

