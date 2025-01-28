extends Node

var prefslocation="user://PlayerPrefs"
var savelocation="user://PlayerSaves"

var MasterVolume: float
var MusicVolume: float
var SFXVolume: float

func _ready():
    if FileAccess.file_exists(prefslocation):
        readPrefs()
    else:
        defaultPrefs()
        writePrefs()

func defaultPrefs():
    MasterVolume=1.0
    MusicVolume=1.0
    SFXVolume=1.0

func clearData():
    pass

func writePrefs():
    var file=FileAccess.open(prefslocation, FileAccess.WRITE)
    file.store_float(MasterVolume)
    file.store_float(MusicVolume)
    file.store_float(SFXVolume)
    file.close()

func writeSave():
    var file=FileAccess.open(savelocation, FileAccess.WRITE)
    
func readPrefs():
    var file=FileAccess.open(prefslocation, FileAccess.READ)
    MasterVolume=file.get_float()
    MusicVolume=file.get_float()
    SFXVolume=file.get_float()
    file.close()
    
func readSave():
    var file=FileAccess.open(savelocation, FileAccess.READ)
