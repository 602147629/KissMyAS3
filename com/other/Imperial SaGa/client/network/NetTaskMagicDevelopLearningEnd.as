package network
{
    import notice.*;
    import user.*;

    public class NetTaskMagicDevelopLearningEnd extends NetTask
    {
        private var _numLearning:int;

        public function NetTaskMagicDevelopLearningEnd(param1:int, param2:Boolean, param3:int, param4:Function)
        {
            super(NetId.PROTOCOL_MAGIC_DEVELOP_LEARNING_END, param4);
            _param.index = param1;
            _param.bHighSpeedLearning = param2;
            this._numLearning = param3;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                UserDataManager.getInstance().userData.setOwnPaymentItem(param1.data.aOwnPaymentItemData);
                NoticeManager.getInstance().crearSimpleNoticeById(param1.data.institutionNoticeId);
                return true;
            }
            return false;
        }// end function

    }
}
