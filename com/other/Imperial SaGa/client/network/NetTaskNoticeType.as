package network
{

    public class NetTaskNoticeType extends NetTask
    {
        public static const TYPE_FREE_HEALING:int = 1;
        public static const TYPE_FREE_ASSAULT:int = 2;

        public function NetTaskNoticeType(param1:int, param2:Function)
        {
            super(NetId.PROTOCOL_NOTICE_CHECK, param2);
            _param.type = param1;
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
