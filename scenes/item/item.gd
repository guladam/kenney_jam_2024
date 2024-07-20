class_name Item
extends Area2D

signal connected_to_item
signal disconnected_from_item

static var connections: Dictionary
static var dragging: Item = null

@export var item_stats: ItemStats : set = _set_item_stats

@onready var icon: Sprite2D = %Icon
@onready var connection_line: Line2D = %ConnectionLine
@onready var line_connector: Area2D = %LineConnector
@onready var start_icon: Node2D = %StartIcon
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var item_timer: Timer = $ItemTimer
@onready var spark_timer: Timer = $SparkTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var spark: Sprite2D = %Spark

var enabled := true
var connected_item: Item


func _process(_delta: float) -> void:
	if dragging and dragging != self:
		return
	
	if _is_dragging():
		line_connector.global_position = get_global_mouse_position()
		connection_line.points[1] = get_local_mouse_position()
	if enabled and Input.is_action_just_released("left_mouse") and _is_dragging():
		dragging = null
		line_connector.global_position = global_position
		connection_line.clear_points()


func activate() -> void:
	item_timer.start()
	var tween := create_tween()
	progress_bar.value = 0
	progress_bar.show()
	tween.tween_property(progress_bar, "value", 100, item_timer.wait_time)
	animation_player.play("active")


func hide_start_symbol() -> void:
	start_icon.hide()


func _is_dragging() -> bool:
	return dragging and dragging == self


func _set_item_stats(value: ItemStats) -> void:
	item_stats = value
	
	if not icon or not item_timer:
		return
	
	icon.region_rect.position = item_stats.icon_coordinates * 16
	item_timer.wait_time = item_stats.activation_time


func _connect(item: Item) -> void:
	connections[self] = item
	connected_item = item
	connection_line.points[1] = to_local(item.global_position)
	dragging = null
	_update_start_point()
	connected_to_item.emit()


func _disconnect() -> void:
	connections.erase(self)
	connection_line.clear_points()
	connection_line.add_point(Vector2.ZERO)
	connection_line.add_point(global_position)
	if connected_item:
		connected_item = null
		_update_start_point()
		disconnected_from_item.emit()


func _update_start_point() -> void:
	get_tree().call_group("items", "hide_start_symbol")
	
	if connections.is_empty():
		return
	
	var first: Item = connections.keys()[0] as Item
	first.start_icon.show()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not enabled:
		return

	if event.is_action_pressed("left_mouse") and not dragging:
		_disconnect()
		dragging = self


func _on_line_connector_area_entered(item: Item) -> void:
	if not _is_dragging() or not item or item == self or item.connected_item == self:
		return
		
	_connect(item)


func _on_item_timer_timeout() -> void:
	item_stats.activate()
	animation_player.play("RESET")
	progress_bar.hide()
	
	if connected_item:
		spark_timer.start()
		spark.global_position = global_position
		spark.show()
		var tween := create_tween().set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(spark, "position", to_local(connected_item.global_position), spark_timer.wait_time)


func _on_spark_timer_timeout() -> void:
	connected_item.activate()
	spark.hide()
