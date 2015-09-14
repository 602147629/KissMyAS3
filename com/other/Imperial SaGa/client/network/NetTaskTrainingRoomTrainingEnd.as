package network
{
    import user.*;

    public class NetTaskTrainingRoomTrainingEnd extends NetTask
    {
        private var _numLearning:int;

        public function NetTaskTrainingRoomTrainingEnd(param1:Boolean, param2:int, param3:Function)
        {
            super(NetId.PROTOCOL_TRAINING_ROOM_TRAINING_END, param3);
            _param.bInstant = param1;
            this._numLearning = param2;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                if (_param.bInstant)
                {
                    if (param1.data.aOwnPaymentItemData)
                    {
                        UserDataManager.getInstance().userData.setOwnPaymentItem(param1.data.aOwnPaymentItemData);
                    }
                }
                return true;
            }
            return false;
        }// end function

    }
}
