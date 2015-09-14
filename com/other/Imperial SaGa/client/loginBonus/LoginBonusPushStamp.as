package loginBonus
{
    import flash.display.*;
    import sound.*;
    import utility.*;

    public class LoginBonusPushStamp extends Object
    {
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _mcGetItem:DisplayObject;
        private var _timer:Number;
        private var _bEnd:Boolean;

        public function LoginBonusPushStamp(param1:MovieClip, param2:DisplayObject)
        {
            this._mc = param1;
            this._isoMain = new InStayOut(this._mc, true);
            this._mcGetItem = param2;
            this._mcGetItem.x = this._mcGetItem.width * -0.5;
            this._mcGetItem.y = this._mcGetItem.height * -0.5;
            this._mc.itemNull.addChild(this._mcGetItem);
            this._timer = 0.5;
            this._isoMain.setIn(this.cbIn);
            SoundManager.getInstance().playSe(SoundId.SE_RS3_EVENT_BATTLE_ITEM_GET);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        private function cbIn() : void
        {
            return;
        }// end function

        public function release() : void
        {
            this._mc = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcGetItem)
            {
                if (this._mcGetItem.parent)
                {
                    this._mcGetItem.parent.removeChild(this._mcGetItem);
                }
            }
            this._mcGetItem = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._isoMain.bOpened)
            {
                this._timer = this._timer - param1;
                if (this._timer <= 0)
                {
                    this._timer = 0;
                    this._bEnd = true;
                }
            }
            return;
        }// end function

    }
}
