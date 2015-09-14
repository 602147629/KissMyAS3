package network
{

    public class NetTaskGetTutorialUnit extends NetTask
    {

        public function NetTaskGetTutorialUnit(param1:Function)
        {
            super(NetId.PROTOCOL_GET_TUTORIAL_UNIT, param1);
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
