package tradingPost
{
    import button.*;
    import flash.display.*;

    public class TradingPostItemBtn extends ButtonBase
    {

        public function TradingPostItemBtn(param1:MovieClip, param2:Function, param3:Function = null, param4:Function = null)
        {
            super(param1, param2, param3, param4);
            enterSeId = ButtonBase.SE_DECIDE_ID;
            return;
        }// end function

        public function selectable() : void
        {
            labelChange(_LABEL_CLICK);
            return;
        }// end function

    }
}
