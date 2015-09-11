package haxegame.game.pointer
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.event.*;
    import flash.*;
    import haxe.ds.*;

    public class Pointer extends Object
    {
        public var removedLineId:int;
        public var oldLine:Line;
        public var mouseEventChecker:MouseEventChecker;
        public var mainFunction:Function;
        public var lineTotalNum:int;
        public var lineMap:IMap;
        public var lineId:int;
        public var line:Line;
        public var layer:IDisplayObjectContainer;
        public var drawnLine:Line;
        public var dragPoint:Object;
        public var dragFirstPoint:Object;
        public var drag:Drag;
        public static var LINE_TOTAL:int;
        public static var IGNORE_LINE_LENGTH:int;
        public static var NOT_EXISTS_REMOVED_LINE:int;

        public function Pointer(param1:MouseEventChecker = undefined, param2:IDisplayObjectContainer = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param2;
            drag = new Drag(param1);
            initialize();
            return;
        }// end function

        public function waitToDrag() : void
        {
            drag.mainFunction();
            if (drag.firstPoint == null)
            {
                return;
            }
            var _loc_1:* = drag.firstPoint;
            var _loc_2:* = drag.point;
            var _loc_3:* = _loc_1.x - _loc_2.x;
            var _loc_4:* = _loc_1.y - _loc_2.y;
            if (Math.sqrt(_loc_3 * _loc_3 + _loc_4 * _loc_4) < 20)
            {
                return;
            }
            if (lineTotalNum >= 5)
            {
                removedLineId = LineMap.removeOldestLine(lineMap);
                (lineTotalNum - 1);
            }
            (lineId + 1);
            (lineTotalNum + 1);
            line = LineMap.add(lineMap, layer, lineId);
            var _loc_5:* = line;
            _loc_1 = drag.firstPoint;
            _loc_2 = drag.point;
            _loc_5.firstPoint = _loc_1;
            _loc_5.endPoint = _loc_2;
            _loc_5.graphics.lineStyle(4, Line.LINE_COLOR, 1);
            _loc_5.graphics.moveTo(_loc_1.x, _loc_1.y);
            _loc_5.graphics.lineTo(_loc_2.x, _loc_2.y);
            mainFunction = dragging;
            return;
        }// end function

        public function run() : void
        {
            mainFunction();
            return;
        }// end function

        public function resetRemovedLineId() : void
        {
            removedLineId = -1;
            return;
        }// end function

        public function resetDrawnLine() : void
        {
            drawnLine = null;
            return;
        }// end function

        public function initialize() : void
        {
            lineMap = new IntMap();
            lineId = 0;
            lineTotalNum = 0;
            drawnLine = null;
            removedLineId = -1;
            mainFunction = waitToDrag;
            return;
        }// end function

        public function existsRemovedLine() : Boolean
        {
            return removedLineId != -1;
        }// end function

        public function existsDrawnLine() : Boolean
        {
            return drawnLine != null;
        }// end function

        public function dragging() : void
        {
            var _loc_1:* = null as Line;
            var _loc_2:* = null;
            var _loc_3:* = null;
            drag.mainFunction();
            if (drag.firstPoint != null)
            {
                line.graphics.clear();
                _loc_1 = line;
                _loc_2 = drag.firstPoint;
                _loc_3 = drag.point;
                _loc_1.firstPoint = _loc_2;
                _loc_1.endPoint = _loc_3;
                _loc_1.graphics.lineStyle(4, Line.LINE_COLOR, 1);
                _loc_1.graphics.moveTo(_loc_2.x, _loc_2.y);
                _loc_1.graphics.lineTo(_loc_3.x, _loc_3.y);
            }
            else
            {
                drawnLine = line;
                mainFunction = waitToDrag;
            }
            return;
        }// end function

        public function destroy() : void
        {
            LineMap.destroy(lineMap, layer);
            return;
        }// end function

        public function clearLine(param1:int) : void
        {
            LineMap.clear(lineMap, param1);
            (lineTotalNum - 1);
            return;
        }// end function

    }
}
