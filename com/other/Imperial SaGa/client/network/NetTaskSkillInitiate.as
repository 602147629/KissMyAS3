package network
{
    import user.*;

    public class NetTaskSkillInitiate extends NetTask
    {

        public function NetTaskSkillInitiate(param1:int, param2:int, param3:int, param4:int, param5:Array, param6:Function)
        {
            super(NetId.PROTOCOL_SKILL_INITIATE, param6);
            _param.baseId = param1;
            _param.skillId = param2;
            _param.correctionId = param3;
            _param.initiateId = param4;
            _param.aAdditionalId = param5;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                _loc_2 = UserDataManager.getInstance().userData;
                _loc_2.removePlayerPersonal(_param.initiateId);
                for each (_loc_3 in _param.aAdditionalId)
                {
                    
                    _loc_2.removePlayerPersonal(_loc_3);
                }
                if (param1.data.crownData)
                {
                    _loc_2.setCrownTotal(param1.data.crownData);
                }
                if (param1.data.aOwnPaymentItemData)
                {
                    UserDataManager.getInstance().userData.setOwnPaymentItem(param1.data.aOwnPaymentItemData);
                }
                Main.GetProcess().topBar.update();
                return true;
            }
            return false;
        }// end function

    }
}
