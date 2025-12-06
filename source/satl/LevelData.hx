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