package network
{
    import storage.*;
    import user.*;

    public class NetTaskWareHouseReceive extends NetTask
    {

        public function NetTaskWareHouseReceive(param1:Array, param2:Function)
        {
            super(NetId.PROTOCOL_WAREHOUSE_RECEIVE, param2);
            _param.aUniqueId = param1;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                _loc_2 = UserDataManager.getInstance().userData;
                _loc_3 = param1.data.aWarehouseAcceptData;
                StorageManager.getInstance().deleteStorageItem(_loc_3);
                StorageManager.getInstance().deleteStorageUnlimitedItem(_loc_3);
                StorageManager.getInstance().addReceiveItem(_loc_3);
                for each (_loc_4 in _loc_3)
                {
                    
                    switch(_loc_4.category)
                    {
                        case CommonConstant.ITEM_KIND_CROWN:
                        {
                            _loc_6 = UserDataManager.getInstance().userData.getCrownTotal();
                            _loc_7 = new Object();
                            _loc_8 = {};
                            _loc_7.free = _loc_6.free + _loc_4.num;
                            _loc_7.paid = _loc_6.paid;
                            _loc_8.crownData = _loc_7;
                            _loc_2.setCrownTotal(_loc_8.crownData);
                            break;
                        }
                        case CommonConstant.ITEM_KIND_ACCESSORIES:
                        {
                            _loc_2.addOwnEquipItem(_loc_4.itemId, _loc_4.num);
                            break;
                        }
                        case CommonConstant.ITEM_KIND_PAYMENT_ITEM:
                        {
                            _loc_2.addOwnPaymentItemNum(_loc_4.itemId, _loc_4.num);
                            break;
                        }
                        case CommonConstant.ITEM_KIND_DESTINY_STONE:
                        {
                            _loc_2.addOwnDestinyStoneNum(_loc_4.itemId, _loc_4.num);
                            break;
                        }
                        case CommonConstant.ITEM_KIND_WARRIOR:
                        {
                            break;
                        }
                        case CommonConstant.ITEM_KIND_ASSET:
                        {
                            _loc_2.addOwnAssetNum(_loc_4.itemId, _loc_4.num);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                _loc_2.setPlayerPersonal(param1.data.aPlayer);
                for each (_loc_5 in param1.data.aPlayer)
                {
                    
                    _loc_2.updateCorrelation(_loc_5.playerId);
                }
                Main.GetProcess().topBar.update();
                return true;
            }
            if (param1.resultCode == NetId.RESULT_ERROR_WAREHOUSE_RECEIVE_INVALID_ITEM_DARA)
            {
                return true;
            }
            return false;
        }// end function

    }
}
