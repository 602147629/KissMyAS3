package network
{
    import user.*;

    public class NetTaskMakeEquipDecomposition extends NetTask
    {
        private var _aItemId:Array;

        public function NetTaskMakeEquipDecomposition(param1:Array, param2:Function)
        {
            this._aItemId = param1;
            super(NetId.PROTOCOL_MAKE_EQUIP_DISMANTLING, param2);
            _param.itemId = param1;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                if (param1.data.getItemInfo)
                {
                    UserDataManager.getInstance().userData.setGetItemInfo(param1.data.getItemInfo);
                }
                return true;
            }
            return false;
        }// end function

    }
}
