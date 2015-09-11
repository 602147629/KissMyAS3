package haxegame.game
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import flash.*;
    import flash.display.*;

    public class GameMouseCheckLayerArea extends Object
    {
        public var graphics:Graphics;
        public static var RED:uint;
        public static var GREEN:uint;
        public static var BLUE:uint;
        public static var COLOR:uint;
        public static var ALPHA:Number;

        public function GameMouseCheckLayerArea(param1:IDisplayObjectContainer = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            graphics = param1.graphics;
            graphics.beginFill(0, 0);
            graphics.drawRect(0, 0, 320, 480);
            return;
        }// end function

    }
}
