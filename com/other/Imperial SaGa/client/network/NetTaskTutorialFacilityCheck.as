package network
{

    public class NetTaskTutorialFacilityCheck extends NetTask
    {

        public function NetTaskTutorialFacilityCheck(param1:uint, param2:Function)
        {
            super(NetId.PROTOCOL_TUTORIAL_FACILITY_CHECK, param2);
            _param.flag = param1;
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
