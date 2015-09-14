package dailyMission
{
    import item.*;
    import message.*;
    import network.*;
    import popup.*;
    import resource.*;
    import user.*;

    public class DailyMissionReceivePopup extends Object
    {
        private var _data:DailyMissionData;
        private var _phase:int;
        private var _aRewardData:Array;
        private var _bWarehouse:Boolean;
        private var _popupIdx:int;
        private var _bReloadRequest:Boolean;
        private static const _PHASE_OPEN_WAIT:int = 0;
        private static const _PHASE_CHECK:int = 1;
        private static const _PHASE_RECEIVE:int = 2;
        private static const _PHASE_LOAD_RESOURCE:int = 3;
        private static const _PHASE_POPUP:int = 4;
        private static const _PHASE_END:int = 5;

        public function DailyMissionReceivePopup(param1:DailyMissionData)
        {
            this._data = param1;
            this._phase = _PHASE_OPEN_WAIT;
            this._aRewardData = [this._data];
            this._popupIdx = 0;
            this._bReloadRequest = false;
            this.setPhase(_PHASE_CHECK);
            return;
        }// end function

        public function get bReloadRequest() : Boolean
        {
            return this._bReloadRequest;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._phase == _PHASE_END;
        }// end function

        public function release() : void
        {
            this._aRewardData = null;
            this._data = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case _PHASE_LOAD_RESOURCE:
                {
                    this.controlLoadResource();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case _PHASE_CHECK:
                    {
                        this.phaseCheck();
                        break;
                    }
                    case _PHASE_RECEIVE:
                    {
                        this.phaseReceive();
                        break;
                    }
                    case _PHASE_LOAD_RESOURCE:
                    {
                        this.phaseLoadResource();
                        break;
                    }
                    case _PHASE_POPUP:
                    {
                        this.phasePopup();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function phaseCheck() : void
        {
            this.setPhase(_PHASE_RECEIVE);
            return;
        }// end function

        private function phaseReceive() : void
        {
            NetManager.getInstance().request(new NetTaskDailyMissionReceive(this._data.id, this.cbRecive));
            return;
        }// end function

        private function cbRecive(param1:NetResult) : void
        {
            var res:* = param1;
            if (res.resultCode == NetId.RESULT_ERROR_DAILY_MISSION_RECEIVE_CHANGE_DATE)
            {
                this._bReloadRequest = true;
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.DAILY_MISSION_POPUP_MESSAGE_TIME_UP), function () : void
            {
                setPhase(_PHASE_END);
                return;
            }// end function
            );
                return;
            }
            this._data.changeStatusReceipt();
            DailyMissionManager.getInstance().updateClearCount();
            this._bWarehouse = GetItemInfo.checkAnyWarehouse(res.data.getItemInfo);
            this.setPhase(_PHASE_LOAD_RESOURCE);
            return;
        }// end function

        private function phaseLoadResource() : void
        {
            return;
        }// end function

        private function controlLoadResource() : void
        {
            if (ResourceManager.getInstance().isLoaded() == false)
            {
                return;
            }
            this._popupIdx = 0;
            this.setPhase(_PHASE_POPUP);
            return;
        }// end function

        private function phasePopup() : void
        {
            this.openCheck();
            return;
        }// end function

        private function openCheck() : void
        {
            if (this._popupIdx < this._aRewardData.length)
            {
                this.openPopup(this._aRewardData[this._popupIdx]);
            }
            else if (this._bWarehouse)
            {
                this._bWarehouse = false;
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CONFIRM_SEND_STRAGE), this.openCheck);
            }
            else
            {
                this.setPhase(_PHASE_END);
            }
            return;
        }// end function

        private function openPopup(param1:DailyMissionData) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = MessageManager.getInstance().getMessage(MessageId.DAILY_MISSION_GET_REWARD_POPUP_01);
            for each (_loc_3 in param1.aPrize)
            {
                
                _loc_2 = _loc_2 + ("\n" + TextControl.formatIdText(MessageId.DAILY_MISSION_GET_REWARD_POPUP_02, ItemManager.getInstance().getItemName(_loc_3.category, _loc_3.itemId), _loc_3.num));
            }
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, _loc_2, this.cbPopup, MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_NEXT));
            return;
        }// end function

        private function cbPopup() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._popupIdx + 1;
            _loc_1._popupIdx = _loc_2;
            this.openCheck();
            return;
        }// end function

    }
}
