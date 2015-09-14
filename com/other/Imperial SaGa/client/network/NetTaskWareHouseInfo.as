package network
{
    import storage.*;
    import user.*;

    public class NetTaskWareHouseInfo extends NetTask
    {

        public function NetTaskWareHouseInfo(param1:Function)
        {
            super(NetId.PROTOCOL_WAREHOUSE_INFO, param1);
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                UserDataManager.getInstance().userData.setbNewItem(false);
                StorageManager.getInstance().setStorageItem(param1.data.aWarehouseGiftData);
                StorageManager.getInstance().setStorageUnlimitedItem(param1.data.aWarehouseUnlimitedData);
                StorageManager.getInstance().setReceiveItem(param1.data.aWarehouseAcceptData);
                StorageManager.getInstance().setWarehouseGiftDleted(param1.data.bWarehouseGiftDleted);
                return true;
            }
            return false;
        }// end function

    }
}
