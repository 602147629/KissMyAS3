package network
{

    public class NetTaskNoticeCheck extends NetTask
    {

        public function NetTaskNoticeCheck(param1:Array, param2:Function)
        {
            super(NetId.PROTOCOL_NOTICE_CHECK, param2);
            _param.aUniqueId = param1;
            _param.type = 0;
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
