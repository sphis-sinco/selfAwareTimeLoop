package satl;

typedef LevelData = {
    layers:Array<LayerData>,
    dialogues:Dynamic
}

typedef LayerData = {
    name:String,
    has_entities:Bool,
    collision:Bool,
    layer:Int
}

typedef DialogueLine = {
    line:String,
    sound:String,
    tags:Array<String>,
}