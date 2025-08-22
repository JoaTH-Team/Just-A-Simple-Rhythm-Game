package backend;

class Paths {
    inline public static function getPath(name:String):String {
        return "assets/" + name;
    }

    inline public static function getMusic(name:String):String {
        return getPath("music/" + name + ".ogg");
    }
    
    inline public static function getSound(name:String):String {
        return getPath("sound/" + name + ".ogg");
    }

    inline public static function getData(name:String):String {
        return getPath("data/" + name);
    }

    inline public static function getImages(name:String):String {
        return getPath("images/" + name + ".png");
    }
}