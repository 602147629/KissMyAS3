package tradingPost
{
    import flash.display.*;
    import popup.*;

    public class TradingPostPopupUtility extends Object
    {

        public function TradingPostPopupUtility()
        {
            return;
        }// end function

        public static function openAlertPopup(param1:DisplayObjectContainer, param2:String, param3:Function) : void
        {
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, param2, param3, null, false, param1);
            return;
        }// end function

        public static function openYesNoPopup(param1:DisplayObjectContainer, param2:String, param3:Function) : void
        {
            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, param2, param3, null, null, false, param1);
            return;
        }// end function

        public static function openPaymentPopup(param1:DisplayObjectContainer, param2:String, param3:Function) : void
        {
            CommonPopup.getInstance().openPaymentPopup(CommonPopup.POPUP_TYPE_NORMAL, param2, param3, null, null, param1);
            return;
        }// end function

        public static function openReelPopup(param1:DisplayObjectContainer, param2:String, param3:Function, param4:int, param5:int) : void
        {
            CommonPopup.getInstance().openReelPopup(param2, param3, param4, param5, param1);
            return;
        }// end function

    }
}
