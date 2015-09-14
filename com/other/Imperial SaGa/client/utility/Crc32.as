package utility
{
    import flash.utils.*;

    public class Crc32 extends Object
    {
        static var _aCrcTbl:Array = null;

        public function Crc32()
        {
            return;
        }// end function

        public static function calc(param1:ByteArray) : uint
        {
            var _loc_2:* = 4294967295;
            return _updateCrc(_loc_2, param1) ^ _loc_2;
        }// end function

        private static function _makeCrcTable() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (_aCrcTbl)
            {
                return;
            }
            _aCrcTbl = [];
            var _loc_1:* = 0;
            while (_loc_1 < 256)
            {
                
                _loc_2 = _loc_1;
                _loc_3 = 0;
                while (_loc_3 < 8)
                {
                    
                    if (_loc_2 & 1)
                    {
                        _loc_2 = 3988292384 ^ _loc_2 >>> 1;
                    }
                    else
                    {
                        _loc_2 = _loc_2 >>> 1;
                    }
                    _loc_3++;
                }
                _aCrcTbl.push(_loc_2);
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private static function _updateCrc(param1:uint, param2:ByteArray) : uint
        {
            _makeCrcTable();
            var _loc_3:* = 0;
            while (_loc_3 < param2.length)
            {
                
                param1 = _aCrcTbl[(param1 ^ param2[_loc_3]) & uint(255)] ^ param1 >>> 8;
                _loc_3++;
            }
            return param1;
        }// end function

    }
}
