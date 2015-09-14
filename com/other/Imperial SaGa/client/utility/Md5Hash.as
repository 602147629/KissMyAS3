package utility
{
    import com.hurlant.crypto.hash.*;
    import com.hurlant.util.*;
    import flash.utils.*;

    public class Md5Hash extends Object
    {

        public function Md5Hash()
        {
            return;
        }// end function

        public static function getHashValue(param1:String) : String
        {
            var _loc_2:* = Hex.toArray(Hex.fromString(param1));
            var _loc_3:* = new MD5();
            _loc_2 = _loc_3.hash(_loc_2);
            _loc_2.position = 0;
            var _loc_4:* = Hex.fromArray(_loc_2);
            return Hex.fromArray(_loc_2);
        }// end function

    }
}
