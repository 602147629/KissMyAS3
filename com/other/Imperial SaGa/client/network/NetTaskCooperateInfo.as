﻿package network
{

    public class NetTaskCooperateInfo extends NetTask
    {

        public function NetTaskCooperateInfo(param1:Function)
        {
            super(NetId.PROTOCOL_COOPERATE_INFO, param1);
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                return true;
            }
            return false;
        }// end function

    }
}
