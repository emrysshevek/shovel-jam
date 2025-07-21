extends TileMapLayer
class_name InteractiveTileMap

const id = 1;
var toggled = false

func toggle() -> void:
	if toggled:
		activate_red()
	else:
		activate_blue()
	toggled = not toggled

func activate_red():
	var all_tiles = get_used_cells_by_id(id);
	for i in all_tiles:
		var data = get_cell_atlas_coords(i);
		if data == Vector2i(0,0):
			set_cell(local_to_map(map_to_local(i)), id, Vector2i(1,0), 0);
		elif data == Vector2i(0,1):
			print("I am red.", local_to_map(i));
			set_cell(local_to_map(map_to_local(i)), id, Vector2i(1,1), 0);

func activate_blue():
	var all_tiles = get_used_cells_by_id(id);
	for i in all_tiles:
		var data = get_cell_atlas_coords(i);
		if data == Vector2i(1,0):
			set_cell(local_to_map(map_to_local(i)), id, Vector2i(0,0), 0);
		elif data == Vector2i(1,1):
			print("I am red.", local_to_map(i));
			set_cell(local_to_map(map_to_local(i)), id, Vector2i(0,1), 0);
