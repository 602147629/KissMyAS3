package haxegame.text
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.layout.*;
    import com.dango_itimi.utils.*;
    import flash.*;
    import flash.display.*;

    public class ScoreLine extends Object
    {
        public var place:int;
        public var numericLine:NumericLine;
        public var number:int;
        public var layer:IDisplayObjectContainer;

        public function ScoreLine(param1:IDisplayObjectContainer = undefined, param2:Number = 0, param3:Number = 0, param4:int = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            place = param4;
            numericLine = new NumericLine(param1, null, param2, param3, 2, 8, NumericLineAligh.LEFT);
            numericLine.baseClassCreateFunction = function () : MovieClip
            {
                return new Numeric();
            }// end function
            ;
            initialize();
            return;
        }// end function

        public function update() : void
        {
            var _loc_5:* = null as MovieClip;
            var _loc_1:* = StringUtil.addZeroToHeadOfNumber(number, place);
            var _loc_2:* = numericLine;
            var _loc_3:* = 0;
            var _loc_4:* = _loc_2.graphicsSet;
            while (_loc_3 < _loc_4.length)
            {
                
                _loc_5 = _loc_4[_loc_3];
                _loc_3++;
                _loc_2.layer.removeChild(_loc_5);
            }
            numericLine.createFromString(_loc_1);
            _loc_2 = numericLine;
            _loc_3 = 0;
            _loc_4 = _loc_2.graphicsSet;
            while (_loc_3 < _loc_4.length)
            {
                
                _loc_5 = _loc_4[_loc_3];
                _loc_3++;
                _loc_2.layer.addChild(_loc_5);
            }
            return;
        }// end function

        public function show() : void
        {
            var _loc_5:* = null as MovieClip;
            var _loc_1:* = StringUtil.addZeroToHeadOfNumber(number, place);
            var _loc_2:* = numericLine;
            var _loc_3:* = 0;
            var _loc_4:* = _loc_2.graphicsSet;
            while (_loc_3 < _loc_4.length)
            {
                
                _loc_5 = _loc_4[_loc_3];
                _loc_3++;
                _loc_2.layer.removeChild(_loc_5);
            }
            numericLine.createFromString(_loc_1);
            _loc_2 = numericLine;
            _loc_3 = 0;
            _loc_4 = _loc_2.graphicsSet;
            while (_loc_3 < _loc_4.length)
            {
                
                _loc_5 = _loc_4[_loc_3];
                _loc_3++;
                _loc_2.layer.addChild(_loc_5);
            }
            return;
        }// end function

        public function setScore(param1:int) : void
        {
            var _loc_6:* = null as MovieClip;
            var _loc_2:* = StringUtil.addZeroToHeadOfNumber(param1, place);
            numericLine.createFromString(_loc_2);
            var _loc_3:* = numericLine;
            var _loc_4:* = 0;
            var _loc_5:* = _loc_3.graphicsSet;
            while (_loc_4 < _loc_5.length)
            {
                
                _loc_6 = _loc_5[_loc_4];
                _loc_4++;
                _loc_3.layer.addChild(_loc_6);
            }
            return;
        }// end function

        public function initialize() : void
        {
            number = 0;
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

        public function addScore(param1:int) : void
        {
            var _loc_6:* = null as MovieClip;
            number = number + param1;
            var _loc_2:* = StringUtil.addZeroToHeadOfNumber(number, place);
            var _loc_3:* = numericLine;
            var _loc_4:* = 0;
            var _loc_5:* = _loc_3.graphicsSet;
            while (_loc_4 < _loc_5.length)
            {
                
                _loc_6 = _loc_5[_loc_4];
                _loc_4++;
                _loc_3.layer.removeChild(_loc_6);
            }
            numericLine.createFromString(_loc_2);
            _loc_3 = numericLine;
            _loc_4 = 0;
            _loc_5 = _loc_3.graphicsSet;
            while (_loc_4 < _loc_5.length)
            {
                
                _loc_6 = _loc_5[_loc_4];
                _loc_4++;
                _loc_3.layer.addChild(_loc_6);
            }
            return;
        }// end function

    }
}
