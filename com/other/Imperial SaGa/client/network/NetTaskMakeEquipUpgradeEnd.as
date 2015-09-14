package network
{
    import user.*;

    public class NetTaskMakeEquipUpgradeEnd extends NetTask
    {
        private var _numLearning:int;

        public function NetTaskMakeEquipUpgradeEnd(param1:int, param2:int, param3:Function)
        {
            super(NetId.PROTOCOL_MAKE_EQUIP_UPGRADE_END, param3);
            _param.type = param1;
            this._numLearning = param2;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                if (_param.type > 0)
                {
                    if (param1.data.aOwnPaymentItemData)
                    {
                        UserDataManager.getInstance().userData.setOwnPaymentItem(param1.data.aOwnPaymentItemData);
                    }
                }
                return true;
            }
            return false;
        }// end function

    }
}
