package utility
{
    import flash.utils.*;

    public class TimeClock extends Object
    {

        public function TimeClock()
        {
            return;
        }// end function

        public static function getRemainingTime(param1:uint) : Date
        {
            var _loc_2:* = new Date();
            if (param1 < 0)
            {
                return _loc_2;
            }
            _loc_2.setTime(param1 * 1000);
            return _loc_2;
        }// end function

        public static function bProgressTime(param1:uint) : Boolean
        {
            var _loc_2:* = Main.GetApplicationData().serverTime;
            var _loc_3:* = Main.GetApplicationData().measureTime;
            var _loc_4:* = (getTimer() - _loc_3) / 1000;
            var _loc_5:* = _loc_2 + _loc_4;
            return param1 < _loc_5;
        }// end function

        public static function getResetTime(param1:uint) : uint
        {
            var _loc_2:* = getNowTimeDate();
            var _loc_3:* = new Date(_loc_2.fullYear, _loc_2.month, _loc_2.date, 0, 0, 0, 0);
            var _loc_4:* = _loc_2.time / 1000;
            var _loc_5:* = _loc_3.time / 1000;
            var _loc_6:* = _loc_4 - _loc_5;
            if (_loc_4 - _loc_5 > param1)
            {
                return _loc_5 + param1;
            }
            return _loc_5 + param1 - 86400;
        }// end function

        public static function calcNextResetTime(param1:uint, param2:uint) : uint
        {
            var _loc_3:* = new Date();
            _loc_3.setTime(param2 * 1000);
            var _loc_4:* = new Date(_loc_3.fullYear, _loc_3.month, _loc_3.date, 0, 0, 0, 0);
            var _loc_5:* = _loc_3.time / 1000;
            var _loc_6:* = _loc_4.time / 1000;
            var _loc_7:* = _loc_5 - _loc_6;
            if (_loc_5 - _loc_6 > param1)
            {
                return _loc_6 + param1 + 86400;
            }
            return _loc_6 + param1;
        }// end function

        public static function getNearCycleTime2(param1:uint, param2:uint) : Array
        {
            var _loc_3:* = [];
            var _loc_4:* = getNowTimeDate();
            var _loc_5:* = new Date(_loc_4.fullYear, _loc_4.month, _loc_4.date, 0, 0, 0, 0);
            var _loc_6:* = _loc_4.time / 1000;
            var _loc_7:* = _loc_5.time / 1000;
            var _loc_8:* = _loc_6 - _loc_7;
            _loc_3.push(_loc_7 + param2);
            _loc_3.push(_loc_7 + param1);
            _loc_3.push(_loc_7 + param2 - 86400);
            _loc_3.push(_loc_7 + param1 - 86400);
            _loc_3.push(_loc_7 + param2 - 86400 * 2);
            _loc_3.push(_loc_7 + param1 - 86400 * 2);
            return _loc_3;
        }// end function

        public static function getResetTime2(param1:uint, param2:uint) : uint
        {
            var _loc_3:* = getNowTimeDate();
            var _loc_4:* = new Date(_loc_3.fullYear, _loc_3.month, _loc_3.date, 0, 0, 0, 0);
            var _loc_5:* = _loc_3.time / 1000;
            var _loc_6:* = _loc_4.time / 1000;
            var _loc_7:* = _loc_5 - _loc_6;
            if (_loc_5 - _loc_6 > param2)
            {
                return _loc_6 + param2;
            }
            if (_loc_7 > param1)
            {
                return _loc_6 + param1;
            }
            return _loc_6 + param2 - 86400;
        }// end function

        public static function getResetTimeNext2(param1:uint, param2:uint) : uint
        {
            var _loc_3:* = getNowTimeDate();
            var _loc_4:* = new Date(_loc_3.fullYear, _loc_3.month, _loc_3.date, 0, 0, 0, 0);
            var _loc_5:* = _loc_3.time / 1000;
            var _loc_6:* = _loc_4.time / 1000;
            var _loc_7:* = _loc_5 - _loc_6;
            if (_loc_5 - _loc_6 > param2)
            {
                return _loc_6 + param1;
            }
            if (_loc_7 > param1)
            {
                return _loc_6 + param2;
            }
            return _loc_6 + param1;
        }// end function

        public static function getNowTime() : uint
        {
            return Main.GetApplicationData().serverTime + (getTimer() - Main.GetApplicationData().measureTime) / 1000;
        }// end function

        public static function getNowTimeDate() : Date
        {
            var _loc_1:* = getNowTime();
            var _loc_2:* = new Date();
            _loc_2.setTime(_loc_1 * 1000);
            return _loc_2;
        }// end function

    }
}
