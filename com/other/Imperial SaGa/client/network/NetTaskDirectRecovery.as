package network
{
    import user.*;
    import utility.*;

    public class NetTaskDirectRecovery extends NetTask
    {

        public function NetTaskDirectRecovery(param1:int, param2:Boolean, param3:Function)
        {
            super(NetId.PROTOCOL_DIRECT_RECOVERY, param3);
            _param.uniqueId = param1;
            _param.bFreeHealing = param2;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                _loc_2 = UserDataManager.getInstance().userData;
                if (_param.bFreeHealing && param1.data.alreadyRest != 1)
                {
                    if (_loc_2.freeHealingNum == CommonConstant.FREE_HEALING_MAX_NUM)
                    {
                        _loc_2.setLastFreeHealingTime(TimeClock.getNowTime());
                    }
                    _loc_2.setFreeHealingNum((_loc_2.freeHealingNum - 1));
                }
                if (param1.data.hasOwnProperty("aOwnPaymentItemData"))
                {
                    _loc_2.setOwnPaymentItem(param1.data.aOwnPaymentItemData);
                }
                return true;
            }
            return false;
        }// end function

    }
}
