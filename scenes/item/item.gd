class_name Item
extends Area2D

static var current_connection_index: int = 0
static var dragging: Item = null

@onready var connection_line: Line2D = %ConnectionLine
@onready var line_connector: Area2D = %LineConnector
@onready var connection_label: Label = %ConnectionLabel

var connected_item: Item
var connection_index: int


func _process(_delta: float) -> void:
	if dragging and dragging != self:
		return
	
	if _is_dragging():
		line_connector.global_position = get_global_mouse_position()
		connection_line.points[1] = get_local_mouse_position()
	if Input.is_action_just_released("left_mouse") and _is_dragging():
		print("cancel")
		dragging = null
		line_connector.global_position = global_position
		connection_line.clear_points()


func _is_dragging() -> bool:
	return dragging and dragging == self


func _connect(item: Item) -> void:
	connection_index = current_connection_index
	connection_label.text = str(connection_index)
	connection_label.show()
	connected_item = item
	connection_line.points[1] = to_local(item.global_position)
	dragging = null
	current_connection_index += 1


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("left_mouse") and not dragging:
		connection_line.clear_points()
		connection_line.add_point(Vector2.ZERO)
		connection_line.add_point(global_position)
		dragging = self


func _on_line_connector_area_entered(item: Item) -> void:
	if not _is_dragging() or not item or item == self or item.connected_item == self:
		return
		
	_connect(item)
