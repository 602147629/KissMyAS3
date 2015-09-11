package haxegame.game.pointer
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import flash.*;
    import flash.display.*;

    public class Line extends Object
    {
        public var mainFunction:Function;
        public var layer:IDisplayObjectContainer;
        public var id:int;
        public var graphics:Graphics;
        public var firstPoint:Object;
        public var endPoint:Object;
        public static var init__:Boolean;
        public static var LINE_THICKNESS:Number;
        public static var LINE_ALPHA:Number;
        public static var LINE_RED:uint;
        public static var LINE_GREEN:uint;
        public static var LINE_BLUE:uint;
        public static var LINE_COLOR:uint;

        public function Line(param1:IDisplayObjectContainer = undefined, param2:int = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            id = param2;
            layer = CommonClassSet.createLayer();
            param1.addChild(layer);
            graphics = layer.graphics;
            return;
        }// end function

        public function draw(param1:Object, param2:Object) : void
        {
            firstPoint = param1;
            endPoint = param2;
            graphics.lineStyle(4, Line.LINE_COLOR, 1);
            graphics.moveTo(param1.x, param1.y);
            graphics.lineTo(param2.x, param2.y);
            return;
        }// end function

        public function destroy(param1:IDisplayObjectContainer) : void
        {
            param1.removeChild(layer);
            return;
        }// end function

        public function clear() : void
        {
            graphics.clear();
            return;
        }// end function

    }
}
