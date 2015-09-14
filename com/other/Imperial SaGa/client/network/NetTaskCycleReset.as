package network
{
    import user.*;

    public class NetTaskCycleReset extends NetTask
    {

        public function NetTaskCycleReset(param1:int, param2:Function)
        {
            super(NetId.PROTOCOL_CYCLE_RESET, param2);
            _param.state = param1;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                if (param1.data.getItemInfo)
                {
                    UserDataManager.getInstance().userData.setGetItemInfo(param1.data.getItemInfo);
                }
                return true;
            }
            return false;
        }// end function

    }
}
