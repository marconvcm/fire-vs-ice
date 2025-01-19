class_name ActiveValuePlugin extends Node

@export var label: String = "Active Value"
@export var max_value: float = 1.0
@export var min_value: float = 0.0
@export var rate: float = 0.0
@export var value: float = 1.0
@export var is_enabled: bool = true
@export var is_rechargeable: bool = false
@export var is_depletable: bool = false

signal value_changed(value)
signal value_empty()
signal value_full()

func _process(delta: float) -> void:
   if is_enabled:
      tick(delta)

func tick(delta: float) -> void:
   if is_rechargeable:
      recharge(rate * max_value * delta)
   if is_depletable:
      deplete(rate * max_value * delta)

func deplete(amount: float) -> void:
   set_value(value - amount)

func recharge(amount: float) -> void:
   set_value(value + amount)

func empty() -> void:
   set_value(min_value)

func full() -> void:
   set_value(max_value)

func set_value(new_value: float, emit_signals: bool = true) -> void:
   value = clamp(new_value, min_value, max_value)
   if emit_signals:
      value_changed.emit(value)
      emit_signal("value_changed", value)
      if is_empty():
         value_empty.emit()
      if is_full():
         value_full.emit()

func is_empty() -> bool:
   return value <= min_value

func is_full() -> bool:
   return value >= max_value

func is_recharging() -> bool:
   return is_rechargeable and value < max_value

func is_depleting() -> bool:
   return is_depletable and value > min_value