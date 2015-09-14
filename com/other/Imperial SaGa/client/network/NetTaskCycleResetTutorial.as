package network
{

    public class NetTaskCycleResetTutorial extends NetTask
    {

        public function NetTaskCycleResetTutorial(param1:Function)
        {
            super(NetId.PROTOCOL_CYCLE_RESET_TUTORIAL, param1);
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
