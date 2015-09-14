package subdualPoint
{
    import asset.*;
    import item.*;
    import message.*;
    import network.*;
    import popup.*;
    import resource.*;
    import user.*;

    public class SubdualPointRewardReceivePopup extends Object
    {
        private var _bReceiveIndividual:Boolean;
        private var _bReceiveWhole:Boolean;
        private var _phase:int;
        private var _type:int;
        private var _aRewardData:Array;
        private var _bWarehouse:Boolean;
        private var _popupIdx:int;
        private static const _PHASE_OPEN_WAIT:int = 0;
        private static const _PHASE_RECEIVE:int = 1;
        private static const _PHASE_LOAD_RESOURCE:int = 2;
        private static const _PHASE_NEXT:int = 3;
        private static const _PHASE_POPUP:int = 4;
        private static const _PHASE_END:int = 5;

        public function SubdualPointRewardReceivePopup(param1:Boolean, param2:Boolean)
        {
            this._bReceiveIndividual = param1;
            this._bReceiveWhole = param2;
            this._phase = _PHASE_OPEN_WAIT;
            this._type = Constant.UNDECIDED;
            this._aRewardData = null;
            this._popupIdx = 0;
            this.setPhase(_PHASE_NEXT);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._phase == _PHASE_END;
        }// end function

        public function release() : void
        {
            this._aRewardData = null;
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
                    case _PHASE_NEXT:
                    {
                        this.phaseNext();
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

        private function phaseNext() : void
        {
            if (this._type == Constant.UNDECIDED)
            {
                if (this._bReceiveIndividual)
                {
                    this._type = 0;
                }
                else if (this._bReceiveWhole)
                {
                    this._type = 1;
                }
            }
            else if (this._type == 0)
            {
                if (this._bReceiveWhole)
                {
                    this._type = 1;
                }
                else
                {
                    this._type = Constant.UNDECIDED;
                }
            }
            else if (this._type == 1)
            {
                this._type = Constant.UNDECIDED;
            }
            if (this._type == Constant.UNDECIDED)
            {
                this.setPhase(_PHASE_END);
            }
            else
            {
                this.setPhase(_PHASE_RECEIVE);
            }
            return;
        }// end function

        private function phaseReceive() : void
        {
            NetManager.getInstance().request(new NetTaskCampaignReceive(this._type, this.cbRecive));
            return;
        }// end function

        private function cbRecive(param1:NetResult) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            this._aRewardData = [];
            var _loc_2:* = param1.data.getPrize;
            if (_loc_2)
            {
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_4 = new SubdualPointRewardData();
                    _loc_4.setRecieve(_loc_2[_loc_3]);
                    _loc_4.changeStatusReceipt();
                    this._aRewardData.push(_loc_4);
                    SubdualPointManager.getInstance().addReceivedReward(this._type, _loc_4);
                    _loc_3++;
                }
            }
            if (this._type == 0)
            {
                this._bWarehouse = GetItemInfo.checkAnyWarehouse(param1.data.getItemInfo);
            }
            else
            {
                this._bWarehouse = false;
            }
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
            if (this._type == 0)
            {
                this._popupIdx = 0;
            }
            else
            {
                this._popupIdx = this._aRewardData.length - 1;
            }
            if (this._popupIdx < 0)
            {
                this._popupIdx = 0;
            }
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
                this.setPhase(_PHASE_NEXT);
            }
            return;
        }// end function

        private function openPopup(param1:SubdualPointRewardData) : void
        {
            var _loc_2:* = null;
            if (this._type == 0)
            {
                _loc_2 = TextControl.formatIdText(MessageId.EVENT_QUEST_DESTRUCTION_GET_REWARD_SINGLE, AssetListManager.getInstance().getAssetName(AssetId.ASSET_EVENT_POINT_0001), param1.point, ItemManager.getInstance().getItemName(param1.category, param1.itemId), param1.num);
            }
            else
            {
                _loc_2 = TextControl.formatIdText(MessageId.EVENT_QUEST_DESTRUCTION_GET_REWARD_ALL, AssetListManager.getInstance().getAssetName(AssetId.ASSET_EVENT_POINT_0001), param1.point);
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
