package script
{
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import network.*;
    import notice.*;
    import popup.*;
    import quest.*;
    import user.*;
    import utility.*;

    public class ScriptComPaymentEventSelect extends ScriptComBase
    {
        private var _aChoice:Array;
        private var _select:ScriptParamSelect;
        private var _pos:Point;
        private var _bPopup:Boolean;
        private var _bPaid:Boolean;
        private var _labelNotEnough:String;
        private var _labelError:String;

        public function ScriptComPaymentEventSelect()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            this._aChoice = new Array();
            this._select = null;
            this._pos = new Point();
            this._bPopup = false;
            this._bPaid = false;
            this._labelNotEnough = null;
            this._labelError = null;
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.setXml(param1);
            this._pos = new Point(param1.pos.@x, param1.pos.@y);
            var _loc_2:* = 0;
            for each (_loc_3 in param1.ChoiceList.children())
            {
                
                _loc_4 = new ScriptSelectChoice();
                if (_loc_2 == 0)
                {
                    _loc_4.setParam(ScriptManager.getInstance().replaceKeyword(_loc_3.message), _loc_3.label, _loc_2);
                }
                else
                {
                    _loc_4.setParam(_loc_3.message, _loc_3.label, _loc_2);
                }
                this._aChoice.push(_loc_4);
                _loc_2++;
            }
            this._labelNotEnough = param1.labelNotEnough;
            this._labelError = param1.labelError;
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            this.createSelect();
            return;
        }// end function

        private function createSelect() : void
        {
            var _loc_1:* = ScriptManager.getInstance().getBalloonLayer();
            if (_loc_1 == null)
            {
                Assert.print("表示スプライトが有りません");
            }
            var _loc_2:* = ScriptManager.getInstance().createSelect();
            _loc_2.setParam(this._aChoice.concat(), this._pos);
            _loc_1.addChild(_loc_2.mc);
            return;
        }// end function

        override public function commandSkip() : int
        {
            return ScriptComConstant.COMMAND_SKIP_RESULT_DONT;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return false;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._bPopup || this._bPaid)
            {
                return;
            }
            _loc_2 = ScriptManager.getInstance().getSelect();
            if (_loc_2.bClose)
            {
                for each (_loc_3 in this._aChoice)
                {
                    
                    if (_loc_3.no == _loc_2.selectNo)
                    {
                        if (_loc_2.selectNo == 0)
                        {
                            if (ScriptManager.getInstance().isPaymentEvent())
                            {
                                CommonPopup.getInstance().openPaymentPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.QUEST_CONFIRM_PAYMENT_EVENT, QuestManager.getInstance().paymentEventCrown), this.cbPopupClose);
                                this._bPopup = true;
                                return;
                            }
                        }
                        else if (ScriptManager.getInstance().isPaymentEvent())
                        {
                            NetManager.getInstance().request(new NetTaskQuestPaymentEventStart(this.cbConnectCancel, false));
                            this._bPaid = true;
                            return;
                        }
                        break;
                    }
                }
                ScriptManager.getInstance().gotoLabel(_loc_3.label);
                _bCommandEnd = true;
            }
            return;
        }// end function

        public function cbPopupClose(param1:Boolean) : void
        {
            var _loc_2:* = null;
            if (param1)
            {
                _loc_2 = UserDataManager.getInstance().userData.getCrownTotal();
                if (_loc_2.total >= QuestManager.getInstance().paymentEventCrown)
                {
                    NetManager.getInstance().request(new NetTaskQuestPaymentEventStart(this.cbConnect, true));
                    this._bPaid = true;
                }
                else
                {
                    ScriptManager.getInstance().gotoLabel(this._labelNotEnough);
                    this._bPaid = true;
                    _bCommandEnd = true;
                }
            }
            else
            {
                this.createSelect();
            }
            this._bPopup = false;
            return;
        }// end function

        public function cbConnect(param1:NetResult) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (param1.resultCode == NetId.RESULT_ERROR)
            {
                ScriptManager.getInstance().gotoLabel(this._labelError);
                _bCommandEnd = true;
                return;
            }
            var _loc_2:* = UserDataManager.getInstance().userData;
            var _loc_3:* = new Object();
            if (_loc_2.crown < QuestManager.getInstance().paymentEventCrown)
            {
                _loc_3.crown = _loc_2.crown;
                _loc_3.paidCrown = _loc_2.paidCrown - QuestManager.getInstance().paymentEventCrown;
            }
            else
            {
                _loc_3.crown = _loc_2.crown - QuestManager.getInstance().paymentEventCrown;
                _loc_3.paidCrown = _loc_2.paidCrown;
            }
            if (param1.data.crownData)
            {
                _loc_2.setCrownTotal(param1.data.crownData);
            }
            else
            {
                _loc_2.setCrownTotal(_loc_3);
            }
            Main.GetProcess().topBar.update();
            NoticeManager.getInstance().addMiniNoticeByObject(param1.data.institutionNotice);
            QuestManager.getInstance().paymentEventNoticeId = param1.data.institutionNotice.uniqueId;
            for each (_loc_4 in param1.data.aRemuneration)
            {
                
                _loc_7 = new QuestRemunerationData();
                _loc_7.setRemunerationData(_loc_4);
                QuestManager.getInstance().addPaymentEventItem(_loc_7);
            }
            QuestManager.getInstance().setWarehousePaymentEventItem(GetItemInfo.checkAnyWarehouse(param1.data.getItemInfo));
            _loc_5 = ScriptManager.getInstance().getSelect();
            for each (_loc_6 in this._aChoice)
            {
                
                if (_loc_6.no == _loc_5.selectNo)
                {
                    ScriptManager.getInstance().gotoLabel(_loc_6.label);
                    break;
                }
            }
            _bCommandEnd = true;
            return;
        }// end function

        public function cbConnectCancel(param1:NetResult) : void
        {
            var _loc_3:* = null;
            if (param1.resultCode == NetId.RESULT_ERROR)
            {
                ScriptManager.getInstance().gotoLabel(this._labelError);
                _bCommandEnd = true;
                return;
            }
            var _loc_2:* = ScriptManager.getInstance().getSelect();
            for each (_loc_3 in this._aChoice)
            {
                
                if (_loc_3.no == _loc_2.selectNo)
                {
                    ScriptManager.getInstance().gotoLabel(_loc_3.label);
                    break;
                }
            }
            _bCommandEnd = true;
            return;
        }// end function

    }
}
