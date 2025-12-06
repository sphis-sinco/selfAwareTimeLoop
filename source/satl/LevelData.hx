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
    
    want_tags:Array<String>,
    dont_want_tags:Array<String>,
    grant_tags:Array<String>,
}