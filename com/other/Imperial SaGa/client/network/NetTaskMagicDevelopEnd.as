package network
{
    import notice.*;
    import user.*;

    public class NetTaskMagicDevelopEnd extends NetTask
    {
        private var _numLearning:int;

        public function NetTaskMagicDevelopEnd(param1:Boolean, param2:int, param3:Function)
        {
            super(NetId.PROTOCOL_MAGIC_DEVELOP_DEVELOP_END, param3);
            _param.bHighSpeedDeveloping = param1;
            this._numLearning = param2;
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
