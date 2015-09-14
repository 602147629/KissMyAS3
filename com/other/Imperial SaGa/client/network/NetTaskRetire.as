package network
{
    import user.*;

    public class NetTaskRetire extends NetTask
    {

        public function NetTaskRetire(param1:Array, param2:Function)
        {
            super(NetId.PROTOCOL_CHARACTER_RETIRE, param2);
            _param.aUniqueId = param1;
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
