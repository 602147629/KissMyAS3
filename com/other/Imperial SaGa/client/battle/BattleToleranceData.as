package battle
{

    public class BattleToleranceData extends Object
    {
        private var _toleranceId:int;
        private var _rate:int;

        public function BattleToleranceData(param1:int, param2:int)
        {
            this._toleranceId = param1;
            this._rate = param2;
            return;
        }// end function

        public function get toleranceId() : int
        {
            return this._toleranceId;
        }// end function

        public function get rate() : int
        {
            return this._rate;
        }// end function

        public function get dispRate() : int
        {
            return BattleToleranceData.dispRate(this._rate);
        }// end function

        public function clone() : BattleToleranceData
        {
            return new BattleToleranceData(this._toleranceId, this._rate);
        }// end function

        public function addRate(param1:int) : void
        {
            this._rate = this._rate + param1;
            return;
        }// end function

        public static function clampRate(param1:int) : int
        {
            if (param1 > 1000)
            {
                return 1000;
            }
            if (param1 < -1000)
            {
                return -1000;
            }
            return param1;
        }// end function

        public static function dispRate(param1:int) : int
        {
            return clampRate(param1) / 10;
        }// end function

        public static function getToleranceRate(param1:Array, param2:int) : int
        {
            var _loc_4:* = null;
            var _loc_3:* = 0;
            for each (_loc_4 in param1)
            {
                
                if (_loc_4.toleranceId == param2)
                {
                    _loc_3 = _loc_4.rate;
                    break;
                }
            }
            return _loc_3;
        }// end function

        public static function checkAnyTolerance(param1:Array) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in param1)
            {
                
                if (_loc_2.rate)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public static function addToleranceDataArray(param1:Array, param2:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param2.length > 0)
            {
                for each (_loc_3 in param1)
                {
                    
                    for each (_loc_4 in param2)
                    {
                        
                        if (_loc_3.toleranceId == _loc_4.toleranceId)
                        {
                            _loc_3.addRate(_loc_4.rate);
                        }
                    }
                }
            }
            return;
        }// end function

    }
}
