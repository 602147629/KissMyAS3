package com.hurlant.crypto.symmetric
{
    import com.hurlant.crypto.symmetric.*;
    import com.hurlant.util.*;
    import flash.utils.*;

    public class ECBMode extends Object implements IMode, ICipher
    {
        private var key:ISymmetricKey;
        private var padding:IPad;

        public function ECBMode(param1:ISymmetricKey, param2:IPad = null)
        {
            this.key = param1;
            if (param2 == null)
            {
                param2 = new PKCS5(param1.getBlockSize());
            }
            else
            {
                param2.setBlockSize(param1.getBlockSize());
            }
            this.padding = param2;
            return;
        }// end function

        public function encrypt(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            padding.pad(param1);
            param1.position = 0;
            _loc_2 = key.getBlockSize();
            _loc_3 = new ByteArray();
            _loc_4 = new ByteArray();
            _loc_5 = 0;
            while (_loc_5 < param1.length)
            {
                
                _loc_3.length = 0;
                param1.readBytes(_loc_3, 0, _loc_2);
                key.encrypt(_loc_3);
                _loc_4.writeBytes(_loc_3);
                _loc_5 = _loc_5 + _loc_2;
            }
            param1.length = 0;
            param1.writeBytes(_loc_4);
            return;
        }// end function

        public function decrypt(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            param1.position = 0;
            _loc_2 = key.getBlockSize();
            if (param1.length % _loc_2 != 0)
            {
                throw new Error("ECB mode cipher length must be a multiple of blocksize " + _loc_2);
            }
            _loc_3 = new ByteArray();
            _loc_4 = new ByteArray();
            _loc_5 = 0;
            while (_loc_5 < param1.length)
            {
                
                _loc_3.length = 0;
                param1.readBytes(_loc_3, 0, _loc_2);
                key.decrypt(_loc_3);
                _loc_4.writeBytes(_loc_3);
                _loc_5 = _loc_5 + _loc_2;
            }
            padding.unpad(_loc_4);
            param1.length = 0;
            param1.writeBytes(_loc_4);
            return;
        }// end function

        public function dispose() : void
        {
            key.dispose();
            key = null;
            padding = null;
            Memory.gc();
            return;
        }// end function

        public function getBlockSize() : uint
        {
            return key.getBlockSize();
        }// end function

        public function toString() : String
        {
            return key.toString() + "-ecb";
        }// end function

    }
}
