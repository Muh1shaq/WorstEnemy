extends Area2D

func _ready() -> void:
	# Menghubungkan sinyal deteksi objek masuk
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# Jika objek yang masuk memiliki fungsi die(), panggil fungsinya
	if body.has_method("die"):
		body.die()
