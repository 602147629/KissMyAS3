package haxegame.game.level
{
    import flash.*;

    public class Level extends Object
    {
        public var num:int;
        public static var MIN:int;

        public function Level() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            initialize();
            return;
        }// end function

        public function initialize() : void
        {
            num = 1;
            return;
        }// end function

        public function increment() : void
        {
            (num + 1);
            return;
        }// end function

    }
}
