package network
{

    public class NetTaskQuestPaymentEventEnd extends NetTask
    {

        public function NetTaskQuestPaymentEventEnd(param1:Function)
        {
            super(NetId.PROTOCOL_PAYMENT_EVENT_END, param1);
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
