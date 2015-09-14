package network
{
    import topbar.*;
    import user.*;

    public class NetTaskCrownUpdate extends NetTask
    {

        public function NetTaskCrownUpdate(param1:Function)
        {
            super(NetId.PROTOCOL_CROWN_UPDATE, param1);
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                _loc_2 = UserDataManager.getInstance().userData;
                _loc_2.setCrownTotal(param1.data.crownData);
                _loc_3 = Main.GetProcess().topBar;
                _loc_3.updateCrownData();
                return true;
            }
            return false;
        }// end function

    }
}
