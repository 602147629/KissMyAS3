package user
{
    import button.*;
    import flash.net.*;
    import message.*;
    import network.*;
    import popup.*;
    import utility.*;

    public class CrownUpdate extends Object
    {
        private var _fade:Fade;
        private var _bConnectEnd:Boolean;
        private var _bUpdateing:Boolean;

        public function CrownUpdate()
        {
            this.openCrownUpdateWindow();
            this._bUpdateing = true;
            return;
        }// end function

        public function get bUpdateing() : Boolean
        {
            return this._bUpdateing;
        }// end function

        public function release() : void
        {
            if (this._fade != null)
            {
                this._fade.release();
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._fade != null)
            {
                this._fade.control(param1);
                if (this._fade.isFade() && this._bConnectEnd && this._fade.isFadeEnd())
                {
                    this._fade.setFadeIn(Constant.FADE_IN_TIME);
                    ButtonManager.getInstance().unseal();
                }
                if (this._fade.isFade() == false)
                {
                    this._fade.release();
                    this._fade = null;
                    this._bUpdateing = false;
                }
            }
            return;
        }// end function

        private function openCrownUpdateWindow() : void
        {
            var _loc_1:* = new URLRequest(Main.GetApplicationData().getChargeJumpUrl());
            navigateToURL(_loc_1, "_blank");
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CROWN_UPDATE_MESSAGE), this.cbClosePopup);
            return;
        }// end function

        private function cbClosePopup() : void
        {
            ButtonManager.getInstance().seal([], false);
            NetManager.getInstance().request(new NetTaskCrownUpdate(this.cbCrownUpdate));
            this._fade = new Fade(Main.GetProcess());
            this._fade.maxAlpha = 0.5;
            this._fade.setFadeOut(0.5);
            return;
        }// end function

        private function cbCrownUpdate(param1:NetResult) : void
        {
            this._bConnectEnd = true;
            return;
        }// end function

    }
}
