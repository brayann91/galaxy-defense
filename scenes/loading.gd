extends Node2D

@onready var anim = $AnimationPlayer
@onready var music = $AudioStreamPlayer

const MAIN_SCENE_PATH := "res://scenes/Main3D.tscn"

var loading_started := false

func _ready():
	anim.play("loading_text")

	music.play()

	ResourceLoader.load_threaded_request(MAIN_SCENE_PATH)
	loading_started = true


func _process(_delta):
	if not loading_started:
		return

	var status := ResourceLoader.load_threaded_get_status(MAIN_SCENE_PATH)
	
	# await get_tree().create_timer(5).timeout

	if status == ResourceLoader.THREAD_LOAD_LOADED:
		music.stop()

		var packed_scene := ResourceLoader.load_threaded_get(MAIN_SCENE_PATH)
		get_tree().change_scene_to_packed(packed_scene)
