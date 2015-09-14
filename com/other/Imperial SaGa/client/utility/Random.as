package utility
{

    public class Random extends Object
    {

        public function Random()
        {
            return;
        }// end function

        public static function range(param1:int, param2:int) : int
        {
            return int(Math.floor(Math.random() * (param2 - param1 + 1)) + param1);
        }// end function

        public static function shuffleArray(param1:Array) : Array
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = param1.concat();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = range(0, (_loc_2.length - 1));
                _loc_5 = _loc_2[_loc_4];
                _loc_2[_loc_4] = _loc_2[_loc_3];
                _loc_2[_loc_3] = _loc_5;
                _loc_3++;
            }
            return _loc_2;
        }// end function

    }
}
