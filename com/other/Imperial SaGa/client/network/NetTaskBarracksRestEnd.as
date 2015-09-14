package network
{
    import user.*;
    import utility.*;

    public class NetTaskBarracksRestEnd extends NetTask
    {

        public function NetTaskBarracksRestEnd(param1:Boolean, param2:Boolean, param3:int, param4:Function)
        {
            super(NetId.PROTOCOL_BARRACKS_REST_END, param4);
            _param.bInstant = param1;
            _param.bFreeHealing = param2;
            _param.index = param3;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                param1.data.index = _param.index;
                if (_param.bFreeHealing && param1.data.alreadyRest != 1)
                {
                    _loc_2 = UserDataManager.getInstance().userData;
                    if (_loc_2.freeHealingNum == CommonConstant.FREE_HEALING_MAX_NUM)
                    {
                        _loc_2.setLastFreeHealingTime(TimeClock.getNowTime());
                    }
                    _loc_2.setFreeHealingNum((_loc_2.freeHealingNum - 1));
                }
                return true;
            }
            return false;
        }// end function

    }
}
