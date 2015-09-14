package utility
{

    public class UniqueIdUtil extends Object
    {
        private static var _uniqueId:uint = 1;

        public function UniqueIdUtil()
        {
            return;
        }// end function

        public static function createUniqueId() : uint
        {
            var _loc_1:* = _uniqueId;
            var _loc_3:* = _uniqueId + 1;
            _uniqueId = _loc_3;
            return _loc_1;
        }// end function

    }
}
