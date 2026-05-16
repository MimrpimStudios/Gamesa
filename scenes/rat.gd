extends CharacterBody2D

@onready var animated_sprite_2d_body: AnimatedSprite2D = $AnimatedSprite2DBody
@onready var animated_sprite_2d_head: AnimatedSprite2D = $AnimatedSprite2DHead
@onready var animated_sprite_2_dtail: AnimatedSprite2D = $AnimatedSprite2Dtail
@onready var ray_cast_2d: RayCast2D = $RayCast2D

const SPEED = 100 # 300 je na krysu docela dost, ale záleží na tobě
var direction = 1 # Začneme doprava (1)

func _ready() -> void:
	update_direction_visuals()

func _physics_process(delta: float) -> void:
	# Gravitace
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Detekce zdi a otočení
	if ray_cast_2d.is_colliding():
		direction *= -1 # Otočí směr (z 1 na -1 a naopak)
		update_direction_visuals()

	velocity.x = direction * SPEED
	
	move_and_slide()

func update_direction_visuals():
	var is_left = direction == 1
	
	# Otočení spritů
	animated_sprite_2d_body.flip_h = is_left
	animated_sprite_2d_head.flip_h = is_left
	animated_sprite_2_dtail.flip_h = is_left
	
	# OTOČENÍ RAYCASTU: Aby se díval tam, kam jdeme
	# Pokud míří doprava (např. target position x = 50), 
	# vynásobíme to směrem.
	ray_cast_2d.target_position.x = abs(ray_cast_2d.target_position.x) * direction
