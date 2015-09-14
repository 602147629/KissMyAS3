package network
{
    import user.*;

    public class NetTaskQuestPaymentEventStart extends NetTask
    {

        public function NetTaskQuestPaymentEventStart(param1:Function, param2:Boolean)
        {
            super(NetId.PROTOCOL_PAYMENT_EVENT_START, param1);
            _param.bPayment = param2;
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
