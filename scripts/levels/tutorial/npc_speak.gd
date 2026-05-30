extends Area2D


@onready var npc: CharacterBody2D = $"../PharmacyMale"
@onready var animation: AnimationPlayer = $"../AnimationPlayer"
var speak = false
var played = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if speak and Input.is_action_just_pressed("integrate") and not animation.is_playing() and not played:
		global_var.player_movement = false
		played = true
		global_var.player_show_speakNPC = false
		animation.play("Dialog01")


func _on_body_entered(_body: Node2D) -> void:
	if not played:
		speak = true
		global_var.player_show_speakNPC = true


func _on_body_exited(_body: Node2D) -> void:
	if not played:
		speak = false
		global_var.player_show_speakNPC = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Dialog01":
		global_var.player_movement = true
