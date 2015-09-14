package network
{
    import storage.*;

    public class NetTaskWareHouseNoticeCheck extends NetTask
    {
        private var _aUniqueId:Array;

        public function NetTaskWareHouseNoticeCheck(param1:Function)
        {
            super(NetId.PROTOCOL_WAREHOUSE_NOTICE_CHECK, param1);
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                StorageManager.getInstance().setWarehouseGiftDleted(0);
                return true;
            }
            return false;
        }// end function

    }
}
