package network
{
    import storage.*;
    import user.*;

    public class NetTaskTutorialEnd extends NetTask
    {

        public function NetTaskTutorialEnd(param1:Function)
        {
            super(NetId.PROTOCOL_TUTORIAL_END, param1);
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                StorageManager.getInstance().setGiftCount(param1.data.warehouseGiftCount);
                StorageManager.getInstance().setUnlimitedGiftCount(param1.data.warehouseUnlimitedCount);
                UserDataManager.getInstance().userData.setLastFreeHealingTime(param1.data.lastFreeHealingTime);
                return true;
            }
            return false;
        }// end function

        override public function tutorialProtocol(param1:NetResult) : void
        {
            param1.resultCode = NetId.RESULT_OK;
            return;
        }// end function

    }
}
