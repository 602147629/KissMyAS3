package utility
{
    import flash.display.*;

    public class DisplayUtils extends Object
    {

        public function DisplayUtils()
        {
            return;
        }// end function

        public static function setTopPriority(param1:DisplayObjectContainer, param2:DisplayObjectContainer) : void
        {
            var _loc_3:* = 0;
            if (param1.numChildren > 1)
            {
                _loc_3 = param1.numChildren - 1;
                param1.setChildIndex(param2, _loc_3);
            }
            return;
        }// end function

        public static function setMouseEnable(param1:DisplayObjectContainer, param2:Boolean) : void
        {
            param1.mouseEnabled = param2;
            param1.mouseChildren = param2;
            return;
        }// end function

    }
}
