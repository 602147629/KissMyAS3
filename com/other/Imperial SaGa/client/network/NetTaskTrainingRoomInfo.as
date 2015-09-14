package network
{

    public class NetTaskTrainingRoomInfo extends NetTask
    {

        public function NetTaskTrainingRoomInfo(param1:Function)
        {
            super(NetId.PROTOCOL_TRAINING_ROOM_INFO, param1);
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
