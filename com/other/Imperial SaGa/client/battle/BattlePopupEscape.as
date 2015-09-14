package battle
{
    import flash.display.*;
    import message.*;
    import popup.*;
    import utility.*;

    public class BattlePopupEscape extends Object
    {
        private var _popup:BattlePopup;
        private var _parent:DisplayObjectContainer;
        private var _bEnd:Boolean;
        private var _bEscape:Boolean;
        private var _fade:Fade;

        public function BattlePopupEscape(param1:DisplayObjectContainer)
        {
            this._parent = param1;
            this._bEscape = false;
            this._bEnd = false;
            this._fade = new Fade(param1, 0.5);
            this._fade.setFadeOut(Constant.FADE_OUT_TIME);
            this.setEscapeCheck();
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd && this._fade.isFadeEnd();
        }// end function

        public function get bEscape() : Boolean
        {
            return this._bEscape;
        }// end function

        public function release() : void
        {
            if (this._fade != null)
            {
                this._fade.release();
            }
            this._fade = null;
            this.popupRelease();
            this._parent = null;
            return;
        }// end function

        private function popupRelease() : void
        {
            if (this._popup != null)
            {
                this._popup.release();
            }
            this._popup = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._fade != null)
            {
                this._fade.control(param1);
            }
            return;
        }// end function

        private function setEscapeCheck() : void
        {
            this._popup = new BattlePopup(this._parent, MessageManager.getInstance().getMessage(MessageId.BATTLE_POPUP_ESCAPE_TITLE1), MessageManager.getInstance().getMessage(MessageId.BATTLE_POPUP_ESCAPE_TITLE2), MessageManager.getInstance().getMessage(MessageId.BATTLE_POPUP_ESCAPE_TITLE2_LIST), MessageManager.getInstance().getMessage(MessageId.BATTLE_POPUP_ESCAPE_BUTTON_YES), MessageManager.getInstance().getMessage(MessageId.BATTLE_POPUP_ESCAPE_BUTTON_NO), this.cbEscapeCheckClose);
            return;
        }// end function

        private function setEscapeEntry() : void
        {
            CommonPopup.getInstance().openRetreatPopup(CommonPopup.POPUP_TYPE_NAVI, MessageManager.getInstance().getMessage(MessageId.BATTLE_POPUP_ESCAPE_REALITY_TITLE1), MessageManager.getInstance().getMessage(MessageId.BATTLE_POPUP_ESCAPE_REALITY_TITLE2), MessageManager.getInstance().getMessage(MessageId.BATTLE_POPUP_ESCAPE_REALITY_BUTTON_YES), MessageManager.getInstance().getMessage(MessageId.BATTLE_POPUP_ESCAPE_REALITY_BUTTON_NO), this.cbEscapeEntryClose);
            return;
        }// end function

        private function cbEscapeCheckClose() : void
        {
            var _loc_1:* = this._popup.select;
            this.popupRelease();
            if (_loc_1 == BattlePopup.SELECT_YES)
            {
                this.setEscapeEntry();
                return;
            }
            this._bEnd = true;
            this._fade.setFadeIn(Constant.FADE_IN_TIME);
            return;
        }// end function

        private function cbEscapeEntryClose(param1:Boolean) : void
        {
            if (param1 == false)
            {
                this.setEscapeCheck();
                return;
            }
            this._bEscape = true;
            this._bEnd = true;
            this._fade.setFadeIn(Constant.FADE_IN_TIME);
            return;
        }// end function

    }
}
