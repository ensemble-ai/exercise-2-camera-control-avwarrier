class_name AutoScrollCamera
extends CameraControllerBase


@export var top_left: Vector2
@export var bottom_right: Vector2
@export var auto_scroll_speed: Vector3


func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	if cpos.z - tpos.z >= top_left.y:
		target.global_position.z = cpos.z + bottom_right.y
	elif cpos.z - tpos.z <= bottom_right.y:
		target.global_position.z = cpos.z + top_left.y
	
	if cpos.x - tpos.x >= bottom_right.x:
		target.global_position.x = cpos.x - bottom_right.x
	elif cpos.x - tpos.x < top_left.x:
		target.global_position.x = cpos.x - top_left.x
	
	target.global_position += auto_scroll_speed
	global_position += auto_scroll_speed
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(-bottom_right.x - 0.5, 0, top_left.y + 0.5))
	immediate_mesh.surface_add_vertex(Vector3(-bottom_right.x - 0.5, 0, bottom_right.y - 0.5))
	
	immediate_mesh.surface_add_vertex(Vector3(-top_left.x + 0.5, 0, top_left.y + 0.5))
	immediate_mesh.surface_add_vertex(Vector3(-top_left.x + 0.5, 0, bottom_right.y - 0.5))
	
	immediate_mesh.surface_add_vertex(Vector3(-top_left.x + 0.5, 0, top_left.y + 0.5))
	immediate_mesh.surface_add_vertex(Vector3(-bottom_right.x - 0.5, 0, top_left.y + 0.5))
	
	immediate_mesh.surface_add_vertex(Vector3(-top_left.x + 0.5, 0, bottom_right.y - 0.5))
	immediate_mesh.surface_add_vertex(Vector3(-bottom_right.x - 0.5, 0, bottom_right.y - 0.5))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
