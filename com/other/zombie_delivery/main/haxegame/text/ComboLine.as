package haxegame.text
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.layout.*;
    import flash.*;
    import flash.display.*;

    public class ComboLine extends Object
    {
        public var numericLine:NumericLine;
        public var layer:IDisplayObjectContainer;

        public function ComboLine(param1:IDisplayObjectContainer = undefined, param2:Number = 0, param3:Number = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            numericLine = new NumericLine(param1, null, param2, param3, 1, 12, NumericLineAligh.CENTER);
            numericLine.baseClassCreateFunction = function () : MovieClip
            {
                return new ComboNumeric();
            }// end function
            ;
            return;
        }// end function

        public function show(param1:int) : void
        {
            var _loc_5:* = null as MovieClip;
            numericLine.create(param1);
            var _loc_2:* = numericLine;
            var _loc_3:* = 0;
            var _loc_4:* = _loc_2.graphicsSet;
            while (_loc_3 < _loc_4.length)
            {
                
                _loc_5 = _loc_4[_loc_3];
                _loc_3++;
                _loc_2.layer.addChild(_loc_5);
            }
            return;
        }// end function

        public function hide() : void
        {
            var _loc_4:* = null as MovieClip;
            var _loc_1:* = numericLine;
            var _loc_2:* = 0;
            var _loc_3:* = _loc_1.graphicsSet;
            while (_loc_2 < _loc_3.length)
            {
                
                _loc_4 = _loc_3[_loc_2];
                _loc_2++;
                _loc_1.layer.removeChild(_loc_4);
            }
            return;
        }// end function

    }
}
