extends Node2D


var turn := 0
var mouse_pos
var game_over := false

func _ready() -> void:
	$Control.hide()
	
func _input(event: InputEvent) -> void:
	mouse_pos = $Grid.world_to_map(get_global_mouse_position())
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			if $Grid.get_cell(mouse_pos.x , mouse_pos.y) == -1 and !game_over:
				$Grid.set_cell(mouse_pos.x, mouse_pos.y, turn)
				check_board()
				if turn == 1:
					turn = 0
				else:
					turn = 1

	if event is InputEventMouse:
		$Highlight.clear()
		if $Highlight.get_cell(mouse_pos.x , mouse_pos.y) == -1 and !game_over:
				$Highlight.set_cell(mouse_pos.x, mouse_pos.y, turn)

	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()
		


func check_board() -> void:

	for __i in 3 :
		#Horizontal
		if ($Grid.get_cell(0, __i) != -1 and
		$Grid.get_cell(0, __i) == $Grid.get_cell(1, __i) and
		$Grid.get_cell(0, __i) == $Grid.get_cell(2, __i)
		):
			winer(turn)
			game_over = true
			return
		#verctical
		elif ($Grid.get_cell(__i, 0) != -1 and
		$Grid.get_cell(__i, 0) == $Grid.get_cell(__i, 1) and
		$Grid.get_cell(__i, 0) == $Grid.get_cell(__i, 2)
		):
			winer(turn)
			game_over = true
			return
		#Diaginaly L_R
		elif ($Grid.get_cell(0, 0) != -1 and
		$Grid.get_cell(0, 0) == $Grid.get_cell(1, 1) and
		$Grid.get_cell(0, 0) == $Grid.get_cell(2, 2)
		):
			winer(turn)
			game_over = true
			return
		#Diaginaly R_L
		elif ($Grid.get_cell(2, 0) != -1 and
		$Grid.get_cell(2, 0) == $Grid.get_cell(1, 1) and
		$Grid.get_cell(2, 0) == $Grid.get_cell(0, 2)
		):
			winer(turn)
			game_over = true
			return
		# tie
		if $Grid.get_used_cells().size() == 9 and !game_over:
			winer(-1)
			$Control/win.text = "Tie"
			$Control.show()
			return

func winer(__winer) -> void:
	if __winer == 0:
		$Control/win.text = "X Win"
		$Control.show()
	elif __winer == 1:
		$Control/win.text = "O Win"
		$Control.show()

