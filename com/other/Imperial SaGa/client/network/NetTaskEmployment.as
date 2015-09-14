package network
{

    public class NetTaskEmployment extends NetTask
    {

        public function NetTaskEmployment(param1:Function)
        {
            super(NetId.PROTOCOL_EMPLOYMENT, param1);
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
