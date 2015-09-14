package com.hurlant.crypto.symmetric
{
    import com.hurlant.crypto.symmetric.*;
    import com.hurlant.util.*;
    import flash.utils.*;

    public class SimpleIVMode extends Object implements IMode, ICipher
    {
        protected var mode:IVMode;
        protected var cipher:ICipher;

        public function SimpleIVMode(param1:IVMode)
        {
            this.mode = param1;
            cipher = param1 as ICipher;
            return;
        }// end function

        public function encrypt(param1:ByteArray) : void
        {
            var _loc_2:* = null;
            cipher.encrypt(param1);
            _loc_2 = new ByteArray();
            _loc_2.writeBytes(mode.IV);
            _loc_2.writeBytes(param1);
            param1.position = 0;
            param1.writeBytes(_loc_2);
            return;
        }// end function

        public function decrypt(param1:ByteArray) : void
        {
            var _loc_2:* = null;
            _loc_2 = new ByteArray();
            _loc_2.writeBytes(param1, 0, getBlockSize());
            mode.IV = _loc_2;
            _loc_2 = new ByteArray();
            _loc_2.writeBytes(param1, getBlockSize());
            cipher.decrypt(_loc_2);
            param1.length = 0;
            param1.writeBytes(_loc_2);
            return;
        }// end function

        public function dispose() : void
        {
            mode.dispose();
            mode = null;
            cipher = null;
            Memory.gc();
            return;
        }// end function

        public function toString() : String
        {
            return "simple-" + cipher.toString();
        }// end function

        public function getBlockSize() : uint
        {
            return mode.getBlockSize();
        }// end function

    }
}
