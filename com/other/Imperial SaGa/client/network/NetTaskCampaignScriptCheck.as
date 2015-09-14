package network
{

    public class NetTaskCampaignScriptCheck extends NetTask
    {

        public function NetTaskCampaignScriptCheck(param1:Function, param2:int)
        {
            super(NetId.PROTOCOL_CAMPAIGN_SCRIPT_CHECK, param1);
            _param.campaignSubId = param2;
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
