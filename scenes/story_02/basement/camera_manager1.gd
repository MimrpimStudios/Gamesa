extends Node

@onready var thief: CharacterBody2D = $"../Thief"
@onready var thief_2: CharacterBody2D = $"../Thief2"
@onready var thief_3: CharacterBody2D = $"../Thief3"
@onready var thief_animated_sprite_2d: AnimatedSprite2D = $"../Thief/AnimatedSprite2D"
@onready var thief_2_animated_sprite_2d: AnimatedSprite2D = $"../Thief2/AnimatedSprite2D"
@onready var thief_3_animated_sprite_2d: AnimatedSprite2D = $"../Thief3/AnimatedSprite2D"

@onready var _1_area_2d: Area2D = $"../Thief/1Area2D"
@onready var _1_area_2d_2: Area2D = $"../Thief/1Area2D2"

@onready var _2_area_2d: Area2D = $"../Thief2/2Area2D"
@onready var _2_area_2d_2: Area2D = $"../Thief2/2Area2D2"
@onready var _2_area_2dall: Area2D = $"../Thief2/2Area2DALL"

@onready var _3_area_2d: Area2D = $"../Thief3/3Area2D"
@onready var _3_area_2d_2: Area2D = $"../Thief3/3Area2D2"

@onready var polygon_2d_1: Polygon2D = $"../Thief/1Area2D/Polygon2D1"
@onready var polygon_2d_2: Polygon2D = $"../Thief/1Area2D2/Polygon2D2"

@onready var _2_polygon_2d_1: Polygon2D = $"../Thief2/2Area2D/2Polygon2D1"
@onready var _2_polygon_2d_2: Polygon2D = $"../Thief2/2Area2D2/2Polygon2D2"

@onready var _3_polygon_2d_1: Polygon2D = $"../Thief3/3Area2D/3Polygon2D1"
@onready var _3_polygon_2d_2: Polygon2D = $"../Thief3/3Area2D2/3Polygon2D2"

var rotation: bool = true # false left and right and left true right and left and right
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if rotation:
		thief_animated_sprite_2d.animation = "left"
		thief_animated_sprite_2d.frame = 1
		_1_area_2d.monitoring = true
		polygon_2d_1.show()
		_1_area_2d_2.monitoring = false
		polygon_2d_2.hide()
		_2_area_2d.monitoring = false
		_2_polygon_2d_1.hide()
		_2_area_2d_2.monitoring = true
		_2_polygon_2d_2.show()
		_2_area_2dall.monitoring = true
		_3_area_2d.monitoring = true
		_3_polygon_2d_1.show()
		_3_area_2d_2.monitoring = false
		_3_polygon_2d_2.hide()

		thief_2_animated_sprite_2d.animation = "right"
		thief_2_animated_sprite_2d.frame = 1
		
		thief_3_animated_sprite_2d.animation = "left"
		thief_3_animated_sprite_2d.frame = 1

	else:
		thief_animated_sprite_2d.animation = "right"
		thief_animated_sprite_2d.frame = 1
		_1_area_2d.monitoring = false
		polygon_2d_1.hide()
		_1_area_2d_2.monitoring = true
		polygon_2d_2.show()

		_2_area_2d.monitoring = true
		_2_polygon_2d_1.show()
		_2_area_2d_2.monitoring = false
		_2_polygon_2d_2.hide()
		_2_area_2dall.monitoring = true
		
		_3_area_2d.monitoring = false
		_3_polygon_2d_1.hide()
		_3_area_2d_2.monitoring = true
		_3_polygon_2d_2.show()

		thief_2_animated_sprite_2d.animation = "left"
		thief_2_animated_sprite_2d.frame = 1
		
		thief_3_animated_sprite_2d.animation = "right"
		thief_3_animated_sprite_2d.frame = 1


func _on_timer_timeout() -> void:
	rotation = not rotation
