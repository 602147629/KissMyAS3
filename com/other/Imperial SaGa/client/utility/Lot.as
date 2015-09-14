package utility
{

    public class Lot extends Object
    {

        public function Lot()
        {
            return;
        }// end function

        public static function isHit(param1:int) : Boolean
        {
            return Random.range(1, 100) <= param1;
        }// end function

        public static function lotTarget(param1:LotList) : Object
        {
            var _loc_6:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = param1.getTotalProbability();
            var _loc_5:* = Random.range(1, _loc_4);
            for each (_loc_6 in param1.aLotObject)
            {
                
                _loc_3 = _loc_3 + _loc_6["probability"];
                if (_loc_5 <= _loc_3)
                {
                    _loc_2 = _loc_6["target"];
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
