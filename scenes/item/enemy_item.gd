class_name EnemyItem
extends Area2D

signal item_activated

@export var item_stats: ItemStats : set = _set_item_stats

@onready var icon: Sprite2D = %Icon
@onready var tooltip_position: Marker2D = %TooltipPosition
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var item_timer: Timer = $ItemTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func activate() -> void:
	item_timer.start()
	var tween := create_tween().set_pause_mode(Tween.TWEEN_PAUSE_STOP)
	progress_bar.value = 0
	progress_bar.show()
	tween.tween_property(progress_bar, "value", 100, item_timer.wait_time)
	animation_player.play("active")


func _set_item_stats(value: ItemStats) -> void:
	item_stats = value
	
	if not icon or not item_timer:
		return
	
	icon.region_rect.position = item_stats.icon_coordinates * 16
	item_timer.wait_time = item_stats.activation_time
	item_stats.initialize()


func _on_item_timer_timeout() -> void:
	item_stats.activate()
	animation_player.play("RESET")
	progress_bar.hide()
	item_activated.emit()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("right_mouse"):
		if ItemTooltip.current_item != item_stats:
			ItemTooltip.show_tooltip(tooltip_position.global_position, item_stats)
		else:
			ItemTooltip.hide_tooltip()
