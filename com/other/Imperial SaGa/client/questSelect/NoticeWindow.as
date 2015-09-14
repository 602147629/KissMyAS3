package questSelect
{
    import area.*;
    import button.*;
    import flash.display.*;
    import message.*;
    import quest.*;
    import resource.*;
    import utility.*;

    public class NoticeWindow extends Object
    {
        private var _baseMc:MovieClip;
        private var _isoMc:InStayOut;
        private var _btnClose:ButtonBase;
        private var _fade:Fade;
        private var _bOpen:Boolean;
        private var _bClose:Boolean;
        public static const TYPE_AREA_QUEST:int = 1;
        public static const TYPE_BATTLE_QUEST:int = 2;
        public static const TYPE_SUB_QUEST_LOST:int = 3;
        public static const TYPE_CAMPAIGN_QUEST:int = 4;

        public function NoticeWindow(param1:Sprite)
        {
            this._fade = new Fade(param1, 0.5);
            this._fade.setFadeIn(0);
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + "UI_QuestSelect.swf", "QuestInformationPopup");
            param1.addChild(this._baseMc);
            this._isoMc = new InStayOut(this._baseMc);
            TextControl.setIdText(this._baseMc.infoPopupBGMc.infoTitleMc.textDt, MessageId.QUEST_SELECT_NOTICE_TITLE);
            var _loc_2:* = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
            _loc_2.smoothing = true;
            _loc_2.x = _loc_2.x - _loc_2.width / 2;
            _loc_2.y = _loc_2.y - _loc_2.height;
            this._baseMc.infoPopupNaviCharaMc.naviCharaNull.addChild(_loc_2);
            this._btnClose = ButtonManager.getInstance().addButton(this._baseMc.cancelBtnMc, this.cbBtnClick);
            this._btnClose.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._btnClose.getMoveClip().textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this._btnClose.setDisableFlag(true);
            this._bOpen = false;
            this._bClose = false;
            return;
        }// end function

        public function release() : void
        {
            if (this._btnClose)
            {
                ButtonManager.getInstance().removeButton(this._btnClose);
            }
            this._btnClose = null;
            if (this._isoMc)
            {
                this._isoMc.release();
            }
            this._isoMc = null;
            if (this._baseMc && this._baseMc.parent != null)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
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

        public function setIn(param1:int, param2:Array, param3:Array) : void
        {
            var _loc_4:* = "";
            if (param1 == TYPE_CAMPAIGN_QUEST)
            {
                _loc_4 = MessageManager.getInstance().getMessage(MessageId.NEW_EVENT_QUEST_UNLOCKED_NOTICE);
            }
            else if (param1 == TYPE_SUB_QUEST_LOST)
            {
                _loc_4 = MessageManager.getInstance().getMessage(MessageId.LOST_QUEST_NOTICE);
            }
            else if (param3.length > 0 && param3[0] == QuestConstant.BATTLE_QUEST_AREA_ID)
            {
                _loc_4 = MessageManager.getInstance().getMessage(MessageId.NEW_BATTLE_QUEST_NOTICE);
            }
            else
            {
                _loc_4 = _loc_4 + this.newQuestNoticeMessage(param3);
                _loc_4 = _loc_4 + this.newAreaNoticeMessage(param2);
            }
            TextControl.setText(this._baseMc.infoPopupNaviCharaMc.infoBalloonTextMc.textDt, _loc_4);
            this._bClose = false;
            if (_loc_4 == "")
            {
                this._bClose = true;
            }
            this._bOpen = true;
            if (this._bClose == false)
            {
                this._isoMc.setIn();
                this._fade.setFadeOut(Constant.FADE_OUT_TIME);
                this._btnClose.setDisable(false);
            }
            return;
        }// end function

        private function cbOut() : void
        {
            this._bClose = true;
            return;
        }// end function

        private function cbBtnClick(param1:int) : void
        {
            this._btnClose.setDisable(true);
            this._isoMc.setOut(this.cbOut);
            this._fade.setFadeIn(Constant.FADE_IN_TIME);
            return;
        }// end function

        public function get bOpen() : Boolean
        {
            return this._bOpen;
        }// end function

        public function get bClose() : Boolean
        {
            return this._bClose;
        }// end function

        private function newAreaNoticeMessage(param1:Array) : String
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = "";
            if (param1.length > 0)
            {
                if (param1.length > 1)
                {
                    _loc_2 = MessageManager.getInstance().getMessage(MessageId.NEW_AREA_NOTICES);
                }
                else
                {
                    _loc_3 = param1[0];
                    _loc_4 = AreaManager.getInstance().getArea(_loc_3);
                    _loc_2 = MessageManager.getInstance().getMessage(MessageId.NEW_AREA_NOTICE);
                    _loc_2 = _loc_2.replace("%d", _loc_4.name);
                }
                _loc_2 = _loc_2 + "\n";
            }
            return _loc_2;
        }// end function

        private function newQuestNoticeMessage(param1:Array) : String
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = "";
            if (param1.length > 0)
            {
                if (param1.length > 1)
                {
                    _loc_2 = MessageManager.getInstance().getMessage(MessageId.NEW_QUEST_NOTICES);
                }
                else
                {
                    _loc_3 = param1[0];
                    _loc_4 = AreaManager.getInstance().getArea(_loc_3);
                    _loc_2 = MessageManager.getInstance().getMessage(MessageId.NEW_QUEST_NOTICE);
                    _loc_2 = _loc_2.replace("%d", _loc_4.name);
                }
                _loc_2 = _loc_2 + "\n";
            }
            return _loc_2;
        }// end function

    }
}
