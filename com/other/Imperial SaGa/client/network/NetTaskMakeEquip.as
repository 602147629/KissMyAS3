package network
{
    import dailyMission.*;
    import user.*;

    public class NetTaskMakeEquip extends NetTask
    {

        public function NetTaskMakeEquip(param1:int, param2:Array, param3:Function)
        {
            super(NetId.PROTOCOL_MAKE_EQUIP, param3);
            _param.recipeId = param1;
            _param.aMaterial = param2.concat();
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                _loc_2 = UserDataManager.getInstance().userData;
                for each (_loc_3 in param1.data.aOwnMaterial)
                {
                    
                    _loc_2.updateOwnDestinyStone(_loc_3.materialId, _loc_3.num);
                }
                if (param1.data.getItemInfo)
                {
                    UserDataManager.getInstance().userData.setGetItemInfo(param1.data.getItemInfo);
                }
                DailyMissionManager.getInstance().checkReceiveComplete(param1.data.dailyMission);
                return true;
            }
            return false;
        }// end function

    }
}
