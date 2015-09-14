package network
{
    import user.*;

    public class NetTaskTrainingRoomKumiteEnd extends NetTask
    {
        private var _numLearning:int;

        public function NetTaskTrainingRoomKumiteEnd(param1:Boolean, param2:Boolean, param3:int, param4:Function)
        {
            super(NetId.PROTOCOL_TRAINING_ROOM_KUMITE_END, param4);
            _param.bInstant = param1;
            _param.bKumitePlayerData = param2;
            this._numLearning = param3;
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
