package com.hurlant.crypto.hash
{
    import flash.utils.*;

    public class HMAC extends Object
    {
        private var bits:uint;
        private var hash:IHash;

        public function HMAC(param1:IHash, param2:uint = 0)
        {
            this.hash = param1;
            this.bits = param2;
            return;
        }// end function

        public function getHashSize() : uint
        {
            if (bits != 0)
            {
                return bits / 8;
            }
            return hash.getHashSize();
        }// end function

        public function dispose() : void
        {
            hash = null;
            bits = 0;
            return;
        }// end function

        public function compute(param1:ByteArray, param2:ByteArray) : ByteArray
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (param1.length > hash.getInputSize())
            {
                _loc_3 = hash.hash(param1);
            }
            else
            {
                _loc_3 = new ByteArray();
                _loc_3.writeBytes(param1);
            }
            while (_loc_3.length < hash.getInputSize())
            {
                
                _loc_3[_loc_3.length] = 0;
            }
            _loc_4 = new ByteArray();
            _loc_5 = new ByteArray();
            _loc_6 = 0;
            while (_loc_6 < _loc_3.length)
            {
                
                _loc_4[_loc_6] = _loc_3[_loc_6] ^ 54;
                _loc_5[_loc_6] = _loc_3[_loc_6] ^ 92;
                _loc_6 = _loc_6 + 1;
            }
            _loc_4.position = _loc_3.length;
            _loc_4.writeBytes(param2);
            _loc_7 = hash.hash(_loc_4);
            _loc_5.position = _loc_3.length;
            _loc_5.writeBytes(_loc_7);
            _loc_8 = hash.hash(_loc_5);
            if (bits > 0 && bits < 8 * _loc_8.length)
            {
                _loc_8.length = bits / 8;
            }
            return _loc_8;
        }// end function

        public function toString() : String
        {
            return "hmac-" + (bits > 0 ? (bits + "-") : ("")) + hash.toString();
        }// end function

    }
}
