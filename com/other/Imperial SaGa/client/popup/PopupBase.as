package popup
{
    import button.*;
    import flash.display.*;
    import input.*;
    import sound.*;
    import tutorial.*;
    import utility.*;

    public class PopupBase extends Object
    {
        private var _bUse:Boolean;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _fade:Fade;
        private var _cbPopupClose:Function;
        private var _bBtnReverse:Boolean;
        public var _popupSeId:int = 2134;

        public function PopupBase()
        {
            this._mcBase = null;
            this._fade = null;
            this._cbPopupClose = null;
            this._isoMain = null;
            this._bUse = false;
            return;
        }// end function

        public function get bUse() : Boolean
        {
            return this._bUse;
        }// end function

        public function release() : void
        {
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            this._bUse = false;
            ButtonManager.getInstance().unseal();
            InputManager.getInstance().setDisable(false);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._fade)
            {
                this._fade.control(param1);
            }
            return;
        }// end function

        protected function openPopup(param1:DisplayObjectContainer, param2:MovieClip, param3:Function, param4:Array, param5:Boolean = false, param6:Boolean = true) : void
        {
            var _loc_8:* = null;
            if (this._bUse)
            {
                this.release();
                this._cbPopupClose = null;
            }
            this._mcBase = param2;
            if (param1 == null)
            {
                param1 = Main.GetProcess();
            }
            this._bBtnReverse = param5;
            if (param6)
            {
                this._fade = new Fade(param1);
                this._fade.maxAlpha = 0.5;
                this._fade.setFadeOut(0.5);
            }
            param1.addChild(this._mcBase);
            var _loc_7:* = 0;
            while (_loc_7 < this._mcBase.numChildren)
            {
                
                _loc_8 = this._mcBase.getChildAt(_loc_7) as MovieClip;
                if (_loc_8)
                {
                    _loc_8.mouseEnabled = false;
                    _loc_8.mouseChildren = false;
                }
                _loc_7++;
            }
            this._cbPopupClose = param3;
            SoundManager.getInstance().playSe(this._popupSeId);
            this.btnEnable(false);
            this._isoMain = new InStayOut(this._mcBase);
            this._isoMain.setIn(this.cbIn);
            ButtonManager.getInstance().seal(param4);
            InputManager.getInstance().setDisable(true);
            this._bUse = true;
            return;
        }// end function

        protected function cbIn() : void
        {
            this.btnEnable(true);
            return;
        }// end function

        protected function cbOut() : void
        {
            var _loc_1:* = this._cbPopupClose;
            this._cbPopupClose = null;
            this.release();
            if (_loc_1 != null)
            {
                this._loc_1();
            }
            return;
        }// end function

        protected function btnEnable(param1:Boolean) : void
        {
            return;
        }// end function

        protected function cbBtn(param1:int) : void
        {
            TutorialManager.getInstance().hideTutorialArrow();
            this.btnEnable(false);
            if (this._fade)
            {
                this._fade.setFadeIn(0.5);
            }
            this._isoMain.setOut(this.cbOut);
            return;
        }// end function

        public static function getSoundResource() : Array
        {
            var _loc_1:* = [SoundId.SE_POPUP];
            return _loc_1;
        }// end function

    }
}
