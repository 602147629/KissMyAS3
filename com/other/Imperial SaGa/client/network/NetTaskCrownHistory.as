package network
{

    public class NetTaskCrownHistory extends NetTask
    {

        public function NetTaskCrownHistory(param1:int, param2:int, param3:Function)
        {
            super(NetId.PROTOCOL_MYPAGE_CROWNHISTORY, param3);
            _param.start = param1;
            _param.limit = param2;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                return true;
            }
            return false;
        }// end function

    }
}
