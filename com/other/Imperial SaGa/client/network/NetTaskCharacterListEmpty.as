package network
{
    import user.*;

    public class NetTaskCharacterListEmpty extends NetTask
    {

        public function NetTaskCharacterListEmpty(param1:Function)
        {
            super(NetId.PROTOCOL_CHARACTER_LIST_EMPTY, param1);
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                _loc_2 = UserDataManager.getInstance().userData;
                _loc_2.setPlayerPersonal(param1.data.aPlayerPersonal);
                for each (_loc_3 in param1.data.aPlayerPersonal)
                {
                    
                    _loc_2.updateCorrelation(_loc_3.playerId);
                }
                return true;
            }
            return false;
        }// end function

    }
}
