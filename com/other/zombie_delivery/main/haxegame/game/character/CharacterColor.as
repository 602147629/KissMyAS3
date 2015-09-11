package haxegame.game.character
{
    import haxegame.game.level.*;

    public class CharacterColor extends Object
    {
        public static var TOTAL:int;

        public function CharacterColor() : void
        {
            return;
        }// end function

        public static function getType(param1:Level) : CharacterColorType
        {
            if (param1.num >= 3)
            {
                return CharacterColor.getRandomType();
            }
            else
            {
                return CharacterColorType.TYPE1;
            }
        }// end function

        public static function getRandomType() : CharacterColorType
        {
            var _loc_1:* = Math.floor(Math.random() * 3) + 1;
            switch(_loc_1) branch count is:<3>[17, 17, 39, 28] default offset is:<17>;
            return CharacterColorType.TYPE1;
            ;
            return CharacterColorType.TYPE3;
            ;
            return CharacterColorType.TYPE2;
            return;
        }// end function

    }
}
