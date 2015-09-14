package network
{

    public class NetTaskSkillInitiateIntesification extends NetTask
    {

        public function NetTaskSkillInitiateIntesification(param1:Array, param2:Function)
        {
            super(NetId.PROTOCOL_SKILL_INITIATE_INTENSIFICATION, param2);
            _param.aUniqueId = param1;
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
