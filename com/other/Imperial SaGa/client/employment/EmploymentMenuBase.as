package employment
{
    import message.*;
    import network.*;
    import popup.*;
    import user.*;

    public class EmploymentMenuBase extends Object
    {
        private var _aWinnerId:Array;
        private var _aOutId:Array;
        private var _warehouseNum:int;
        private var _bReset:Boolean;
        private var _cbCloseExpiration:Function;
        private var _updateCostDraw:Function;

        public function EmploymentMenuBase()
        {
            this._aWinnerId = [];
            this._aOutId = [];
            this._warehouseNum = 0;
            this._bReset = false;
            return;
        }// end function

        protected function get aWinnerId() : Array
        {
            return this._aWinnerId;
        }// end function

        protected function get aOutId() : Array
        {
            return this._aOutId;
        }// end function

        protected function get bWarehouse() : Boolean
        {
            return this._warehouseNum == 0 ? (false) : (true);
        }// end function

        protected function get warehouseNum() : int
        {
            return this._warehouseNum;
        }// end function

        public function get bReset() : Boolean
        {
            return this._bReset;
        }// end function

        public function release() : void
        {
            this._aWinnerId = [];
            this._aOutId = [];
            this._cbCloseExpiration = null;
            this._updateCostDraw = null;
            return;
        }// end function

        protected function checkConnectCommon(param1:NetResult, param2:Function, param3:Function) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            this._cbCloseExpiration = param2;
            this._updateCostDraw = param3;
            if (param1.resultCode != NetId.RESULT_OK)
            {
                if (param1.resultCode == NetId.RESULT_ERROR_EMPLOYMENT_LIMITED_EXPIRATION || param1.resultCode == NetId.RESULT_ERROR_EMPLOYMENT_LIMITED_BOX_EXPIRATION)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NAVI, MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_LIMITED_EMPLOY_EXPIRATION), this._cbCloseExpiration);
                    this._bReset = true;
                    return;
                }
            }
            this._aWinnerId = [];
            this._aOutId = [];
            if (param1.data.employmentBoxLotteryData)
            {
                for each (_loc_4 in param1.data.employmentBoxLotteryData.aPlayerId)
                {
                    
                    this._aWinnerId.push(_loc_4);
                }
                for each (_loc_4 in param1.data.employmentBoxLotteryData.aOutPlayerId)
                {
                    
                    this._aOutId.push(_loc_4);
                }
            }
            else
            {
                this._aWinnerId.push(param1.data.employmentLotteryData.playerId);
                for each (_loc_4 in param1.data.employmentLotteryData.aOutPlayerId)
                {
                    
                    this._aOutId.push(_loc_4);
                }
            }
            this._warehouseNum = 0;
            _loc_5 = GetItemInfo.aWarehouseData(param1.data.getItemInfo);
            if (_loc_5)
            {
                this._warehouseNum = _loc_5.length;
            }
            this.updateCost(param1);
            if (this._updateCostDraw != null)
            {
                this._updateCostDraw();
            }
            return;
        }// end function

        private function updateCost(param1:NetResult) : void
        {
            var _loc_2:* = UserDataManager.getInstance().userData;
            if (param1.data.crownData)
            {
                _loc_2.setCrownTotal(param1.data.crownData);
                Main.GetProcess().topBar.update();
            }
            if (param1.data.aOwnPaymentItemData)
            {
                _loc_2.setOwnPaymentItem(param1.data.aOwnPaymentItemData);
            }
            return;
        }// end function

        protected function checkWarehouse(param1:Function) : void
        {
            if (this.bWarehouse)
            {
                this.popupWindowStrage(param1);
            }
            else if (param1 != null)
            {
                this.param1();
            }
            return;
        }// end function

        private function popupWindowStrage(param1:Function) : void
        {
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.CONFIRM_SEND_CHARACTER_STRAGE, this._warehouseNum), param1);
            return;
        }// end function

    }
}
