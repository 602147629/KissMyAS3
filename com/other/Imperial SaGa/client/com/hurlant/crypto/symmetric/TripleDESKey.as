package com.hurlant.crypto.symmetric
{
    import com.hurlant.util.*;
    import flash.utils.*;

    public class TripleDESKey extends DESKey
    {
        protected var decKey2:Array;
        protected var decKey3:Array;
        protected var encKey2:Array;
        protected var encKey3:Array;

        public function TripleDESKey(param1:ByteArray)
        {
            super(param1);
            encKey2 = generateWorkingKey(false, param1, 8);
            decKey2 = generateWorkingKey(true, param1, 8);
            if (param1.length > 16)
            {
                encKey3 = generateWorkingKey(true, param1, 16);
                decKey3 = generateWorkingKey(false, param1, 16);
            }
            else
            {
                encKey3 = encKey;
                decKey3 = decKey;
            }
            return;
        }// end function

        override public function decrypt(param1:ByteArray, param2:uint = 0) : void
        {
            desFunc(decKey3, param1, param2, param1, param2);
            desFunc(decKey2, param1, param2, param1, param2);
            desFunc(decKey, param1, param2, param1, param2);
            return;
        }// end function

        override public function encrypt(param1:ByteArray, param2:uint = 0) : void
        {
            desFunc(encKey, param1, param2, param1, param2);
            desFunc(encKey2, param1, param2, param1, param2);
            desFunc(encKey3, param1, param2, param1, param2);
            return;
        }// end function

        override public function dispose() : void
        {
            var _loc_1:* = 0;
            super.dispose();
            _loc_1 = 0;
            if (encKey2 != null)
            {
                _loc_1 = 0;
                while (_loc_1 < encKey2.length)
                {
                    
                    encKey2[_loc_1] = 0;
                    _loc_1 = _loc_1 + 1;
                }
                encKey2 = null;
            }
            if (encKey3 != null)
            {
                _loc_1 = 0;
                while (_loc_1 < encKey3.length)
                {
                    
                    encKey3[_loc_1] = 0;
                    _loc_1 = _loc_1 + 1;
                }
                encKey3 = null;
            }
            if (decKey2 != null)
            {
                _loc_1 = 0;
                while (_loc_1 < decKey2.length)
                {
                    
                    decKey2[_loc_1] = 0;
                    _loc_1 = _loc_1 + 1;
                }
                decKey2 = null;
            }
            if (decKey3 != null)
            {
                _loc_1 = 0;
                while (_loc_1 < decKey3.length)
                {
                    
                    decKey3[_loc_1] = 0;
                    _loc_1 = _loc_1 + 1;
                }
                decKey3 = null;
            }
            Memory.gc();
            return;
        }// end function

        override public function toString() : String
        {
            return "3des";
        }// end function

    }
}
