package loginBonus
{
    import button.*;
    import flash.display.*;
    import icon.*;
    import item.*;
    import message.*;
    import player.*;
    import utility.*;

    public class LoginBonusPopup extends Object
    {
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _btnClose:ButtonBase;
        private var _bEnd:Boolean;
        private static const _MC_ITEM_MAX:int = 3;

        public function LoginBonusPopup(param1:MovieClip, param2:LoginBonusSheetData)
        {
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            this._mc = param1;
            this._isoMain = new InStayOut(this._mc);
            var _loc_3:* = param2.aGetBonus;
            var _loc_4:* = _loc_3.length;
            if (_loc_3.length > _MC_ITEM_MAX)
            {
                _loc_4 = _MC_ITEM_MAX;
            }
            this._mc.logBoGetWindMc.itemDisplaySetMc.gotoAndStop("item" + _loc_4);
            this._btnClose = ButtonManager.getInstance().addButton(this._mc.closeBtnMc, this.cbClose);
            this._btnClose.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._btnClose.setDisable(true);
            TextControl.setIdText(this._mc.closeBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            var _loc_5:* = "";
            var _loc_6:* = "";
            if (param2.caption != "" || param2.message != "")
            {
                _loc_5 = param2.caption;
                _loc_6 = param2.message;
            }
            else if (param2.loginBonusId == 6)
            {
                _loc_5 = MessageManager.getInstance().getMessage(MessageId.LOGIN_BONUS_TITLE_CAMPAIGN_0040);
                _loc_6 = MessageManager.getInstance().getMessage(MessageId.LOGIN_BONUS_MESSAGE_CAMPAIGN_0040);
            }
            else if (param2.loginBonusId == 5)
            {
                _loc_5 = MessageManager.getInstance().getMessage(MessageId.LOGIN_BONUS_TITLE_CAMPAIGN_0030);
                _loc_6 = MessageManager.getInstance().getMessage(MessageId.LOGIN_BONUS_MESSAGE_CAMPAIGN_0030);
            }
            else if (param2.loginBonusId == 4)
            {
                _loc_5 = MessageManager.getInstance().getMessage(MessageId.LOGIN_BONUS_TITLE_CAMPAIGN_0020);
                _loc_6 = MessageManager.getInstance().getMessage(MessageId.LOGIN_BONUS_MESSAGE_CAMPAIGN_0020);
            }
            else if (param2.loginBonusId == 3)
            {
                _loc_5 = MessageManager.getInstance().getMessage(MessageId.LOGIN_BONUS_TITLE_CAMPAIGN_0010);
                _loc_6 = MessageManager.getInstance().getMessage(MessageId.LOGIN_BONUS_MESSAGE_CAMPAIGN_0010);
            }
            else if (param2.loginBonusId == 2)
            {
                _loc_5 = TextControl.formatIdText(MessageId.RELEASE_LOGIN_BONUS_TITLE, (param2.nowStampCount + 1));
                _loc_6 = MessageManager.getInstance().getMessage(MessageId.RELEASE_LOGIN_BONUS_MESSAGE);
            }
            else
            {
                _loc_5 = MessageManager.getInstance().getMessage(MessageId.LOGIN_BONUS_TITLE);
                _loc_9 = MessageId.LOGIN_BONUS_MESSAGE_1POINT;
                if (_loc_3.length == 2)
                {
                    _loc_9 = MessageId.LOGIN_BONUS_MESSAGE_2POINT;
                }
                if (_loc_3.length == 3)
                {
                    _loc_9 = MessageId.LOGIN_BONUS_MESSAGE_3POINT;
                }
                _loc_6 = MessageManager.getInstance().getMessage(_loc_9);
            }
            TextControl.setText(this._mc.logBoGetWindMc.logBoTitleTextMc.textDt, _loc_5);
            TextControl.setText(this._mc.logBoGetWindMc.textMc.textDt, _loc_6);
            var _loc_7:* = [this._mc.logBoGetWindMc.itemDisplaySetMc.itemDisplay1Mc, this._mc.logBoGetWindMc.itemDisplaySetMc.itemDisplay2Mc, this._mc.logBoGetWindMc.itemDisplaySetMc.itemDisplay3Mc];
            var _loc_8:* = 0;
            while (_loc_8 < _loc_4)
            {
                
                _loc_10 = _loc_7[_loc_8];
                _loc_11 = "";
                _loc_12 = "";
                _loc_13 = _loc_3[_loc_8];
                switch(_loc_13.type)
                {
                    case CommonConstant.ITEM_KIND_WARRIOR:
                    {
                        _loc_14 = PlayerManager.getInstance().getPlayerInformation(_loc_13.id);
                        TextControl.setText(_loc_10.charaTextMc.textDt, _loc_14.name);
                        _loc_15 = new PlayerRarityIcon(_loc_10.charaTextMc.setCharaRankMc, _loc_14.rarity);
                        break;
                    }
                    case CommonConstant.ITEM_KIND_CROWN:
                    {
                        _loc_11 = "" + _loc_13.count + ItemManager.getInstance().getItemName(_loc_13.type, _loc_13.id);
                        _loc_12 = "";
                        TextControl.setText(_loc_10.itemTextMc.textDt, _loc_11);
                        TextControl.setText(_loc_10.textMc.textDt, _loc_12);
                        break;
                    }
                    default:
                    {
                        _loc_11 = ItemManager.getInstance().getItemName(_loc_13.type, _loc_13.id);
                        _loc_12 = "" + _loc_13.count + ItemManager.getInstance().getItemUnit(_loc_13.type, _loc_13.id);
                        TextControl.setText(_loc_10.itemTextMc.textDt, _loc_11);
                        TextControl.setText(_loc_10.textMc.textDt, _loc_12);
                        break;
                        break;
                    }
                }
                if (_loc_13.type == CommonConstant.ITEM_KIND_WARRIOR)
                {
                    _loc_10.charaTextMc.visible = true;
                    _loc_10.itemTextMc.visible = false;
                    _loc_10.textMc.visible = false;
                }
                else
                {
                    _loc_10.charaTextMc.visible = false;
                    _loc_10.itemTextMc.visible = true;
                    _loc_10.textMc.visible = true;
                }
                _loc_8++;
            }
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            if (this._btnClose)
            {
                ButtonManager.getInstance().removeButton(this._btnClose);
            }
            this._btnClose = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            this._mc = null;
            return;
        }// end function

        public function open() : void
        {
            this._isoMain.setIn(this.cbIn);
            return;
        }// end function

        private function cbIn() : void
        {
            this._btnClose.setDisable(false);
            return;
        }// end function

        private function cbClose(param1:int) : void
        {
            this._btnClose.setDisable(true);
            this._bEnd = true;
            this._isoMain.setOut();
            return;
        }// end function

    }
}
