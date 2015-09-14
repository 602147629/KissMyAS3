package network
{
    import dailyMission.*;
    import player.*;
    import tutorial.*;
    import user.*;

    public class NetTaskMagicDevelopLearning extends NetTask
    {
        private var _resourceCost:int;

        public function NetTaskMagicDevelopLearning(param1:Boolean, param2:int, param3:int, param4:int, param5:int, param6:Function)
        {
            super(NetId.PROTOCOL_MAGIC_DEVELOP_LEARNING, param6);
            _param.bHighSpeedLearning = param1;
            _param.uniqueId = param2;
            _param.skillId = param3;
            this._resourceCost = param5;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                TutorialManager.getInstance().ClearNoCost_MagicLearn();
                _loc_2 = new PlayerPersonal();
                _loc_2.setParameter(param1.data.playerPersonal);
                _loc_3 = UserDataManager.getInstance().userData.aPlayerPersonal;
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    if (_loc_3[_loc_4].uniqueId == _loc_2.uniqueId)
                    {
                        _loc_3[_loc_4] = _loc_2;
                        break;
                    }
                    _loc_4++;
                }
                UserDataManager.getInstance().userData.setOwnPlayer(_loc_3);
                UserDataManager.getInstance().userData.setMagicResource(UserDataManager.getInstance().userData.magicResource - this._resourceCost);
                DailyMissionManager.getInstance().checkReceiveComplete(param1.data.dailyMission);
                return true;
            }
            if (param1.resultCode == NetId.RESULT_ERROR_MAGIC_DEVELOP_LEARNING_CANT_HAVE)
            {
                return true;
            }
            return false;
        }// end function

    }
}
