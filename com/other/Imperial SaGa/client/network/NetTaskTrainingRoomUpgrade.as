package network
{

    public class NetTaskTrainingRoomUpgrade extends NetTask
    {

        public function NetTaskTrainingRoomUpgrade(param1:Function)
        {
            super(NetId.PROTOCOL_TRAINING_ROOM_UPGRADE, param1);
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
