package network
{
    import player.*;
    import user.*;

    public class NetTaskGrowthReset extends NetTask
    {

        public function NetTaskGrowthReset(param1:int, param2:Function)
        {
            super(NetId.PROTOCOL_GROWTH_RESET, param2);
            param.uniqueId = param1;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                if (param1.data.aOwnPaymentItemData)
                {
                    UserDataManager.getInstance().userData.setOwnPaymentItem(param1.data.aOwnPaymentItemData);
                }
                _loc_2 = new PlayerPersonal();
                _loc_2.setParameter(param1.data.playerPersonal);
                _loc_3 = UserDataManager.getInstance().userData;
                _loc_4 = _loc_3.aPlayerPersonal;
                _loc_5 = 0;
                while (_loc_5 < _loc_4.length)
                {
                    
                    if (_loc_4[_loc_5].uniqueId == _loc_2.uniqueId)
                    {
                        (_loc_4[_loc_5] as PlayerPersonal).copyParam(_loc_2);
                        break;
                    }
                    _loc_5++;
                }
                _loc_3.setOwnPlayer(_loc_4);
                _loc_3.removeGrowthCurve(_loc_2.uniqueId);
                return true;
            }
            return false;
        }// end function

    }
}
