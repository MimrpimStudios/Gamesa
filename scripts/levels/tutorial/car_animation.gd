extends Node

@onready var anims = {
	$"../AnimationPlayer": ["car", 5.0],
	$"../AnimationPlayer2": ["car2", 8.0],
	$"../AnimationPlayer3": ["car3", 11.0],
	$"../AnimationPlayer4": ["car4", 8.0],
	$"../AnimationPlayer5": ["car5", 0.0],
	$"../AnimationPlayer6": ["car6", 2.0],
	$"../AnimationPlayer7": ["car7", 14.0]
}

func _ready() -> void:
	for player in anims:
		var data = anims[player]
		var anim_name = data[0]
		var start_time = data[1]

		# Kontrola, jestli uzel existuje, aby ti to nespadlo
		if player and player.has_animation(anim_name):
			var anim = player.get_animation(anim_name)
			
			# Vynutíme looping přímo v kódu (jistota je jistota)
			anim.loop_mode = Animation.LOOP_LINEAR
			
			# Spustíme animaci
			player.play(anim_name, -1, 1.3)
			
			# Vypočítáme správný startovní čas (modulo)
			# Pokud je animace kratší než start_time, začne v odpovídajícím bodě smyčky
			var real_start = fmod(start_time, anim.length)
			
			# Posuneme na čas a zaktualizujeme vizuál (true)
			player.seek(real_start, true)
		else:
			print("Chyba: AnimationPlayer nebo animace ", anim_name, " nenalezena!")

func _process(_delta: float) -> void:
	pass
