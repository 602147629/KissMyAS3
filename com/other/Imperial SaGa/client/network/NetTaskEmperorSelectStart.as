package network
{
    import user.*;

    public class NetTaskEmperorSelectStart extends NetTask
    {

        public function NetTaskEmperorSelectStart(param1:Function)
        {
            super(NetId.PROTOCOL_EMPEROR_SELECT_START, param1);
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                UserDataManager.getInstance().userData.addChapter();
                UserDataManager.getInstance().userData.resetProgress();
                Main.GetProcess().topBar.resetProgress();
                Main.GetProcess().topBar.updateChapter();
                return true;
            }
            return false;
        }// end function

    }
}
