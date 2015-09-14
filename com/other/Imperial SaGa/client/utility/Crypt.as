package utility
{
    import flash.utils.*;

    public class Crypt extends Object
    {

        public function Crypt()
        {
            return;
        }// end function

        public static function encryption(param1:String, param2:ByteArray) : ByteArray
        {
            var _loc_4:* = null;
            var _loc_3:* = new ByteArray();
            var _loc_5:* = Blowfish.createVariableKey();
            _loc_3.writeUTFBytes(_loc_5);
            _loc_4 = Blowfish.encode(Blowfish.fixationKey + _loc_5, param2);
            _loc_3.writeBytes(_loc_4);
            _loc_3.position = 0;
            return _loc_3;
        }// end function

        public static function decryption(param1:String, param2:ByteArray) : ByteArray
        {
            var _loc_3:* = new ByteArray();
            var _loc_4:* = Blowfish.getVariableKey(param2);
            param2.readBytes(_loc_3, 0, param2.bytesAvailable);
            Blowfish.decode(param1 + _loc_4, _loc_3);
            return _loc_3;
        }// end function

        public static function decryptionResource(param1:String, param2:ByteArray, param3:Boolean = false) : ByteArray
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_4:* = new ByteArray();
            var _loc_5:* = Main.GetApplicationData().isNotResourceEncryption();
            if (Main.GetApplicationData().isNotResourceEncryption() == false && param3 == false)
            {
                _loc_6 = getTimer();
                _loc_7 = Blowfish.getVariableKey(param2);
                param2.readBytes(_loc_4, 0, param2.length - _loc_7.length);
                Blowfish.decodeResource(param1 + _loc_7, _loc_4);
                _loc_4.uncompress();
            }
            else
            {
                _loc_4 = param2;
            }
            return _loc_4;
        }// end function

    }
}
