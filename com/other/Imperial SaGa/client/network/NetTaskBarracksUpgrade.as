package network
{

    public class NetTaskBarracksUpgrade extends NetTask
    {

        public function NetTaskBarracksUpgrade(param1:Function)
        {
            super(NetId.PROTOCOL_BARRACKS_UPGRADE, param1);
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
