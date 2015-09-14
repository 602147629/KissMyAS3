package network
{

    public class NetTaskNameEntry extends NetTask
    {

        public function NetTaskNameEntry(param1:String, param2:Function)
        {
            super(NetId.PROTOCOL_NAME_ENYTY, param2);
            _param.name = param1;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                return true;
            }
            if (param1.resultCode == NetId.RESULT_ERROR_NAME_ENTRY_TOO_LONG)
            {
                return true;
            }
            if (param1.resultCode == NetId.RESULT_ERROR_NAME_ENTRY_NG_WORD)
            {
                return true;
            }
            if (param1.resultCode == NetId.RESULT_ERROR_NAME_ENTRY_INVALID_CHARA)
            {
                return true;
            }
            return false;
        }// end function

    }
}
