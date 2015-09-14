package network
{

    public class NetTaskMagicLaboratory extends NetTask
    {

        public function NetTaskMagicLaboratory(param1:Function)
        {
            super(NetId.PROTOCOL_MAGIC_DEVELOP_INFO, param1);
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
