package com.dango_itimi.as3_and_createjs.layout
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.*;
    import flash.display.*;

    public class NumericLine extends Object
    {
        public var testDisplayObject:DisplayObject;
        public var positionY:Number;
        public var positionX:Number;
        public var numericGraphicsWidth:int;
        public var layer:IDisplayObjectContainer;
        public var intervalPixel:int;
        public var graphicsSet:Array;
        public var baseClassCreateFunction:Function;
        public var baseClass:Class;
        public var align:NumericLineAligh;

        public function NumericLine(param1:IDisplayObjectContainer = undefined, param2:Class = undefined, param3:Number = 0, param4:Number = 0, param5:int = 0, param6:int = 0, param7:NumericLineAligh = undefined) : void
        {
            var baseClass1:* = param2;
            if (Boot.skip_constructor)
            {
                return;
            }
            positionY = param4;
            positionX = param3;
            baseClass = baseClass1;
            intervalPixel = param5;
            layer = param1;
            numericGraphicsWidth = param6;
            align = param7;
            graphicsSet = [];
            baseClassCreateFunction = function () : MovieClip
            {
                return Type.createInstance(baseClass1, []);
            }// end function
            ;
            return;
        }// end function

        public function show() : void
        {
            var _loc_3:* = null as MovieClip;
            var _loc_1:* = 0;
            var _loc_2:* = graphicsSet;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_1];
                _loc_1++;
                layer.addChild(_loc_3);
            }
            return;
        }// end function

        public function hide() : void
        {
            var _loc_3:* = null as MovieClip;
            var _loc_1:* = 0;
            var _loc_2:* = graphicsSet;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_1];
                _loc_1++;
                layer.removeChild(_loc_3);
            }
            return;
        }// end function

        public function createGraphics(param1:String, param2:int, param3:Number) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null as MovieClip;
            var _loc_7:* = null as IMovieClipUtil;
            var _loc_8:* = null as String;
            var _loc_9:* = 0;
            graphicsSet = [];
            var _loc_4:* = 0;
            while (_loc_4 < param2)
            {
                
                _loc_4++;
                _loc_5 = _loc_4;
                _loc_6 = baseClassCreateFunction();
                _loc_7 = Type.createInstance(CommonClassSet.movieClipUtilClass, [_loc_6]);
                _loc_8 = param1.charAt(_loc_5);
                if (_loc_8 == ".")
                {
                    _loc_7.gotoAndStop(_loc_7.getTotalFrames());
                }
                else
                {
                    _loc_9 = Std.parseInt(param1.charAt(_loc_5));
                    _loc_7.gotoAndStop((_loc_9 + 1));
                }
                _loc_6.x = param3;
                _loc_6.y = positionY;
                graphicsSet.push(_loc_6);
                param3 = param3 + (numericGraphicsWidth + intervalPixel);
            }
            return;
        }// end function

        public function createFromString(param1:String) : void
        {
            var _loc_3:* = NaN;
            var _loc_2:* = param1.length;
            var _loc_4:* = align;
            switch(_loc_4.index) branch count is:<2>[18, 30, 51] default offset is:<14>;
            ;
            _loc_3 = positionX;
            ;
            _loc_3 = positionX - _loc_2 * numericGraphicsWidth;
            ;
            _loc_3 = positionX - Math.floor(_loc_2 * numericGraphicsWidth / 2);
            createGraphics(param1, _loc_2, _loc_3);
            return;
        }// end function

        public function create(param1:Number) : void
        {
            createFromString("" + param1);
            return;
        }// end function

    }
}
