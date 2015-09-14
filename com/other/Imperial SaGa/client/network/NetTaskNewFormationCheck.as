package network
{

    public class NetTaskNewFormationCheck extends NetTask
    {

        public function NetTaskNewFormationCheck(param1:Function)
        {
            super(NetId.PROTOCOL_NEW_FORMATION_CHECK, param1);
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
