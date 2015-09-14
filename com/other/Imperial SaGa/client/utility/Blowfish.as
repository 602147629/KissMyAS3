package utility
{
    import com.hurlant.crypto.symmetric.*;
    import flash.utils.*;

    public class Blowfish extends Object
    {
        private static const _RESOURCE_BLOCK:int = 4;
        private static const _RESOURCE_SKIP_BLOCK:int = 999999;
        private static var _classCryptkey:Class = Blowfish__classCryptkey;
        private static var _fixationKey:String = "";
        private static var _fixationKeyResource:String = "";
        private static var _aKeyEncryption:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        private static const _VARIABLE_KEY:int = 4;

        public function Blowfish()
        {
            return;
        }// end function

        public static function createFixitionKey() : void
        {
            var _loc_4:* = 0;
            var _loc_1:* = new _classCryptkey();
            var _loc_2:* = new ByteArray();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1.length)
            {
                
                _loc_4 = _loc_1[_loc_3];
                _loc_2.writeByte(~_loc_4 & 255);
                _loc_3++;
            }
            _loc_2.position = 0;
            _fixationKey = _loc_2.readUTFBytes(_loc_2.length);
            _fixationKeyResource = _fixationKey;
            _loc_1.clear();
            _loc_2.clear();
            return;
        }// end function

        public static function get fixationKey() : String
        {
            return _fixationKey;
        }// end function

        public static function setFixationKey(param1:String) : void
        {
            if (param1.length > 0)
            {
                _fixationKey = param1;
            }
            return;
        }// end function

        public static function get fixationKeyResource() : String
        {
            return _fixationKeyResource;
        }// end function

        public static function createVariableKey() : String
        {
            var _loc_1:* = "";
            var _loc_2:* = 0;
            while (_loc_2 < _VARIABLE_KEY)
            {
                
                _loc_1 = _loc_1 + _aKeyEncryption.substr(Random.range(0, (_aKeyEncryption.length - 1)), 1);
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public static function getVariableKey(param1:ByteArray) : String
        {
            var _loc_2:* = param1.readUTFBytes(_VARIABLE_KEY);
            return _loc_2;
        }// end function

        public static function encode(param1:String, param2:ByteArray) : ByteArray
        {
            var _loc_3:* = new ByteArray();
            _loc_3.position = 0;
            _loc_3.writeUTFBytes(param1);
            var _loc_4:* = new BlowFishKey(_loc_3);
            var _loc_5:* = 0;
            var _loc_6:* = param2.length;
            while (_loc_5 < _loc_6)
            {
                
                _loc_4.encrypt(param2, _loc_5);
                _loc_5 = _loc_5 + _loc_4.getBlockSize();
            }
            param2.position = 0;
            return param2;
        }// end function

        public static function decode(param1:String, param2:ByteArray) : void
        {
            var _loc_3:* = new ByteArray();
            _loc_3.position = 0;
            _loc_3.writeUTFBytes(param1);
            var _loc_4:* = new BlowFishKey(_loc_3);
            var _loc_5:* = 0;
            var _loc_6:* = param2.length;
            while (_loc_5 < _loc_6)
            {
                
                _loc_4.decrypt(param2, _loc_5);
                _loc_5 = _loc_5 + _loc_4.getBlockSize();
            }
            param2.position = 0;
            return;
        }// end function

        public static function decodeResource(param1:String, param2:ByteArray) : void
        {
            var _loc_7:* = 0;
            var _loc_3:* = new ByteArray();
            _loc_3.position = 0;
            _loc_3.writeUTFBytes(param1);
            var _loc_4:* = new BlowFishKey(_loc_3);
            var _loc_5:* = 0;
            var _loc_6:* = param2.length;
            while (_loc_5 < _loc_6)
            {
                
                _loc_7 = 0;
                while (_loc_7 < _RESOURCE_BLOCK)
                {
                    
                    _loc_4.decrypt(param2, _loc_5);
                    _loc_5 = _loc_5 + _loc_4.getBlockSize();
                    _loc_7++;
                }
                _loc_5 = _loc_5 + _RESOURCE_SKIP_BLOCK;
            }
            param2.position = 0;
            return;
        }// end function

    }
}
