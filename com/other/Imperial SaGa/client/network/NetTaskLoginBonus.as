package network
{
    import user.*;
    import utility.*;

    public class NetTaskLoginBonus extends NetTask
    {

        public function NetTaskLoginBonus(param1:Function)
        {
            super(NetId.PROTOCOL_LOGINBONUS, param1);
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                _loc_2 = uint(param1.data.loginBonusGetTime);
                _loc_2 = _loc_2 + Random.range(0, 60);
                Main.GetApplicationData().loginBonusGetTime = _loc_2;
                for each (_loc_3 in param1.data.aLoginBonus)
                {
                    
                    if (_loc_3.getItemInfo)
                    {
                        UserDataManager.getInstance().userData.setGetItemInfo(_loc_3.getItemInfo);
                    }
                }
                return true;
            }
            return false;
        }// end function

    }
}
