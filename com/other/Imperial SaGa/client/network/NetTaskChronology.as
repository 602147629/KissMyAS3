package network
{

    public class NetTaskChronology extends NetTask
    {

        public function NetTaskChronology(param1:Function)
        {
            super(NetId.PROTOCOL_MYPAGE_CHRONOLOGY, param1);
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
