package haxegame.game.collision
{
    import flash.*;

    public class CollisionPair extends Object
    {
        public var id2:int;
        public var id1:int;

        public function CollisionPair(param1:int = 0, param2:int = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            id1 = param1;
            id2 = param2;
            return;
        }// end function

    }
}
