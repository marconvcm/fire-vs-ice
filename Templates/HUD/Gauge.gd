class_name Gauge extends Control

@onready var label: Label = $Label
@onready var progress_bar: ProgressBar = $ProgressBar
@export var active_value: ActiveValuePlugin

func connect_active_value(target_active_value: ActiveValuePlugin) -> void:
   self.active_value = target_active_value
   if target_active_value != null:
      progress_bar.min_value = target_active_value.min_value
      progress_bar.max_value = target_active_value.max_value
      progress_bar.value = target_active_value.value
      target_active_value.value_changed.connect(_on_value_changed)
      target_active_value.max_value_changed.connect(_on_max_value_changed)    

func _on_value_changed(value: float) -> void:
   progress_bar.value = value

func _on_max_value_changed(maxv: float) -> void:
    progress_bar.max_value=maxv
