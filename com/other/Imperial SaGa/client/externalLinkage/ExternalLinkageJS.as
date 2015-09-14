package externalLinkage
{
    import com.hurlant.crypto.*;
    import com.hurlant.crypto.hash.*;
    import com.hurlant.util.*;
    import flash.external.*;
    import flash.utils.*;
    import user.*;

    public class ExternalLinkageJS extends Object
    {

        public function ExternalLinkageJS()
        {
            return;
        }// end function

        public static function callJSRemarketingTag(param1:int) : void
        {
            var _loc_2:* = UserDataManager.getInstance().userData;
            var _loc_3:* = _loc_2.userId.toString();
            var _loc_4:* = Crypto.getHash("md5");
            var _loc_5:* = Crypto.getHash("md5").hash(Hex.toArray(_loc_3));
            var _loc_6:* = Hex.fromArray(_loc_5);
            var _loc_7:* = {id:param1, param:_loc_6, channel:_loc_2.channel};
            ExternalLinkageJS.callJS("setRemarketingTag", _loc_7);
            return;
        }// end function

        private static function callJS(param1:String, param2:Object) : void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call(param1, param2);
            }
            return;
        }// end function

    }
}
