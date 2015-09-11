package 
{

    public class StringTools extends Object
    {

        public function StringTools() : void
        {
            return;
        }// end function

        public static function hex(param1:int, param2:Object = undefined) : String
        {
            var _loc_3:* = param1;
            var _loc_4:* = _loc_3.toString(16);
            _loc_4 = _loc_4.toUpperCase();
            if (param2 != null)
            {
                while (_loc_4.length < param2)
                {
                    
                    _loc_4 = "0" + _loc_4;
                }
            }
            return _loc_4;
        }// end function

    }
}
