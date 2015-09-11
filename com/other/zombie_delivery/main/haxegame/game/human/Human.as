package haxegame.game.human
{
    import flash.*;
    import flash.display.*;
    import haxegame.game.character.*;

    public class Human extends Character
    {

        public function Human() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            return;
        }// end function

        override public function createView(param1:Number, param2:CharacterColorType) : MovieClip
        {
            var _loc_3:* = param1;
            if (_loc_3 == 1)
            {
                switch(param2.index) branch count is:<2>[18, 33, 48] default offset is:<14>;
                ;
                return new DropSmallView1();
                ;
                return new DropSmallView2();
                ;
                return new DropSmallView3();
            }
            else if (_loc_3 == 1.25)
            {
                switch(param2.index) branch count is:<2>[18, 33, 48] default offset is:<14>;
                ;
                return new DropMiddleView1();
                ;
                return new DropMiddleView2();
                ;
                return new DropMiddleView3();
            }
            else if (_loc_3 == 1.5)
            {
                switch(param2.index) branch count is:<2>[18, 33, 48] default offset is:<14>;
                ;
                return new DropBigView1();
                ;
                return new DropBigView2();
                ;
                return new DropBigView3();
                ;
            }
            return;
        }// end function

    }
}
