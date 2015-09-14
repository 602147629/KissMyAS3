package network
{
    import user.*;

    public class NetTaskCodeInput extends NetTask
    {

        public function NetTaskCodeInput(param1:String, param2:int, param3:Function)
        {
            super(NetId.PROTOCOL_CODE_INPUT, param3);
            _param.code = param1;
            _param.common = param2;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            if (param1.resultCode == NetId.RESULT_OK || param1.resultCode == NetId.RESULT_ERROR_CODE_INPUT_INVALID_CODE || param1.resultCode == NetId.RESULT_ERROR_CODE_INPUT_EXPIRED_CODE || param1.resultCode == NetId.RESULT_ERROR_CODE_INPUT_HAVE_GOTTEN_CODE)
            {
                if (param1.resultCode == NetId.RESULT_OK)
                {
                    _loc_2 = UserDataManager.getInstance().userData;
                    if (param1.data.hasOwnProperty("bNewItem"))
                    {
                        _loc_2.setbNewItem(param1.data.bNewItem);
                    }
                }
                return true;
            }
            return false;
        }// end function

    }
}
