package network
{

    public class NetTaskSkillInitiateUpgrade extends NetTask
    {

        public function NetTaskSkillInitiateUpgrade(param1:Function)
        {
            super(NetId.PROTOCOL_SKILL_INITIATE_UPGRADE, param1);
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
