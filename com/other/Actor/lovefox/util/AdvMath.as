package lovefox.util
{
    import flash.display.*;

    public class AdvMath extends Object
    {
        static var _pi:Number = Math.PI;
        static var _golden:Number = 0.618;
        static var _randomStack:Array = [];
        static var _randomNextSeed:int = 0;

        public function AdvMath()
        {
            return;
        }// end function

        public static function getAngle(param1:Number, param2:Number) : Number
        {
            var _loc_3:* = Math.atan2(param2, param1);
            return _loc_3;
        }// end function

        public static function binarySplit(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_2:* = param1.toString(2).length;
            var _loc_5:* = [];
            _loc_3 = _loc_2 - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4 = param1 >> _loc_3 << _loc_3;
                if (_loc_4 != 0)
                {
                    _loc_5.push(_loc_4);
                }
                param1 = param1 - _loc_4;
                _loc_3 = _loc_3 - 1;
            }
            return _loc_5;
        }// end function

        public static function randomOrder(param1:Array, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (param2 == null)
            {
                param2 = Math.random;
            }
            param1 = param1.concat();
            if (param1.length > 1)
            {
                _loc_3 = new Array();
                while (param1.length > 0)
                {
                    
                    _loc_4 = Math.floor(AdvMath.param2() * param1.length);
                    _loc_3.push(param1[_loc_4]);
                    param1.splice(_loc_4, 1);
                }
                param1 = _loc_3;
            }
            return param1;
        }// end function

        public static function findInArray(param1:Array, param2) : Boolean
        {
            var _loc_3:* = undefined;
            for (_loc_3 in param1)
            {
                
                if (param1[_loc_3] == param2)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public static function getMax(param1:Array) : Number
        {
            var _loc_2:* = param1[0];
            var _loc_3:* = 1;
            while (_loc_3 < param1.length)
            {
                
                _loc_2 = Math.max(param1[_loc_3], _loc_2);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public static function getMin(param1:Array) : Number
        {
            var _loc_2:* = param1[0];
            var _loc_3:* = 1;
            while (_loc_3 < param1.length)
            {
                
                _loc_2 = Math.min(param1[_loc_3], _loc_2);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public static function signSymbol(param1:Number) : Number
        {
            var _loc_2:* = undefined;
            if (param1 > 0)
            {
                _loc_2 = 1;
            }
            else if (param1 == 0)
            {
                _loc_2 = 0;
            }
            else if (param1 < 0)
            {
                _loc_2 = -1;
            }
            return _loc_2;
        }// end function

        public static function fullMod(param1:Number, param2:Number) : Number
        {
            var _loc_3:* = param1 % param2;
            if (_loc_3 > param2 / 2)
            {
                _loc_3 = _loc_3 - param2;
            }
            else if (_loc_3 < (-param2) / 2)
            {
                _loc_3 = _loc_3 + param2;
            }
            return _loc_3;
        }// end function

        public static function random() : Number
        {
            if (_randomStack.length <= 0)
            {
                randomize(_randomNextSeed);
            }
            var _loc_1:* = _randomStack.shift() + _randomStack.shift() / 100;
            if (_randomStack.length % 1000 == 0)
            {
                _randomNextSeed = _randomNextSeed + _loc_1;
            }
            return _loc_1 / 100;
        }// end function

        public static function randomize(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_2:* = new BitmapData(100, 100, true, 0);
            _loc_2.noise(param1, 0, 99, 4, false);
            _randomStack = [];
            _randomNextSeed = 0;
            _loc_3 = 0;
            while (_loc_3 < _loc_2.width)
            {
                
                _loc_4 = 0;
                while (_loc_4 < _loc_2.width)
                {
                    
                    _randomStack.push(_loc_2.getPixel(_loc_3, _loc_4));
                    _loc_4 = _loc_4 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            _loc_2.dispose();
            return;
        }// end function

    }
}
