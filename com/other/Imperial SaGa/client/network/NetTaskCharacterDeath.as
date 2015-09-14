package network
{
    import notice.*;
    import player.*;

    public class NetTaskCharacterDeath extends NetTask
    {

        public function NetTaskCharacterDeath(param1:Array, param2:Function)
        {
            super(NetId.PROTOCOL_CHARACTER_DEATH, param2);
            _param.aDeadCharacterData = param1;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                _loc_2 = param1.data.aDeadResultData;
                for each (_loc_3 in _loc_2)
                {
                    
                    if (_loc_3.bLost)
                    {
                        NoticeManager.getInstance().addCharacterLost(new PlayerLostData(_loc_3.uniqueId, _loc_3.playerId));
                    }
                }
                return true;
            }
            return false;
        }// end function

    }
}
