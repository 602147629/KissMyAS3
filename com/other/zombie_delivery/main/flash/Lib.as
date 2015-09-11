package flash
{
    import flash.display.*;
    import flash.net.*;

    public class Lib extends Object
    {
        public static var current:MovieClip;

        public function Lib() : void
        {
            return;
        }// end function

        public static function getURL(param1:URLRequest, param2:String = undefined) : void
        {
            var _loc_3:* = navigateToURL;
            if (param2 == null)
            {
                null._loc_3(param1);
            }
            else
            {
                null._loc_3(param1, param2);
            }
            return;
        }// end function

    }
}
