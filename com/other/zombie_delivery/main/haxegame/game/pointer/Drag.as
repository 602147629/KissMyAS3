package haxegame.game.pointer
{
    import com.dango_itimi.as3_and_createjs.event.*;
    import flash.*;

    public class Drag extends Object
    {
        public var point:Object;
        public var mouseEventChecker:MouseEventChecker;
        public var mainFunction:Function;
        public var firstPoint:Object;

        public function Drag(param1:MouseEventChecker = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            mouseEventChecker = param1;
            initialize();
            return;
        }// end function

        public function waitToMouseDown() : void
        {
            if (mouseEventChecker.isDowned())
            {
                initializeToDrag();
            }
            return;
        }// end function

        public function run() : void
        {
            mainFunction();
            return;
        }// end function

        public function isNeutral() : Boolean
        {
            if (firstPoint == null)
            {
            }
            return point == null;
        }// end function

        public function initializeToDrag() : void
        {
            firstPoint = mouseEventChecker.getDownedLocalPoint();
            var _loc_1:* = firstPoint;
            point = {x:_loc_1.x, y:_loc_1.y};
            mainFunction = drag;
            return;
        }// end function

        public function initialize() : void
        {
            firstPoint = null;
            point = null;
            mainFunction = waitToMouseDown;
            return;
        }// end function

        public function drag() : void
        {
            if (mouseEventChecker.isMoved())
            {
                point = mouseEventChecker.getMovedLocalPoint();
            }
            if (mouseEventChecker.isUpped())
            {
                mainFunction = initialize;
            }
            else if (mouseEventChecker.isRollOuted())
            {
                mainFunction = initialize;
            }
            return;
        }// end function

    }
}
