package network
{

    public class NetTaskTrading extends NetTask
    {

        public function NetTaskTrading(param1:Function)
        {
            super(NetId.PROTOCOL_TRADING, param1);
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
