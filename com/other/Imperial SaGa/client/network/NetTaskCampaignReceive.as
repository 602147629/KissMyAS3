package network
{
    import subdualPoint.*;
    import user.*;

    public class NetTaskCampaignReceive extends NetTask
    {

        public function NetTaskCampaignReceive(param1:int, param2:Function)
        {
            super(NetId.PROTOCOL_CAMPAIGN_RECEIVE, param2);
            _param.type = param1;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                if (_param.type == 0)
                {
                    SubdualPointManager.getInstance().individualRewardCount = 0;
                }
                else
                {
                    SubdualPointManager.getInstance().wholeRewardCount = 0;
                }
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
