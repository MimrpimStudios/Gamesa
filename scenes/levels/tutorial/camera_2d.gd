extends Camera2D # nebo Camera3D podle tvého projektu

@onready var druha_kamera: Camera2D = $"../../Camera2D"

func change_cam():
	# Vytvoříme nový tween
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	# 1. Plynulý přesun na pozici druhé kamery
	tween.tween_property(self, "global_position", druha_kamera.global_position, 1.5)
	
	# 2. Plynulý zoom out (např. na hodnotu druhé kamery, nebo zadáš vlastní Vector2)
	# Pokud je druhá kamera dál, hodnota zoomu bude menší (např. Vector2(0.5, 0.5))
	tween.tween_property(self, "zoom", druha_kamera.zoom, 1.5)
