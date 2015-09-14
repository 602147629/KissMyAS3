package network
{

    public class NetTaskUserRename extends NetTask
    {

        public function NetTaskUserRename(param1:String, param2:Function)
        {
            super(NetId.PROTOCOL_USER_RENAME, param2);
            _param.name = param1;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                return true;
            }
            if (param1.resultCode == NetId.RESULT_ERROR_USER_RENAME_TOO_LONG)
            {
                return true;
            }
            if (param1.resultCode == NetId.RESULT_ERROR_USER_RENAME_NG_WORD)
            {
                return true;
            }
            if (param1.resultCode == NetId.RESULT_ERROR_USER_RENAME_INVALID_CHARA)
            {
                return true;
            }
            return false;
        }// end function

    }
}
