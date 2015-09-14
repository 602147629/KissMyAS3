package network
{
    import notice.*;
    import user.*;

    public class NetTaskLostNoticeCheck extends NetTask
    {
        private var _aUniqueId:Array;

        public function NetTaskLostNoticeCheck(param1:Array, param2:Function)
        {
            super(NetId.PROTOCOL_LOST_NOTICE_CHECK, param2);
            _param.aUniqueId = param1;
            this._aUniqueId = param1.concat();
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                for each (_loc_2 in this._aUniqueId)
                {
                    
                    _loc_3 = UserDataManager.getInstance().userData;
                    _loc_3.removePlayerPersonal(_loc_2);
                    _loc_4 = _loc_3.aFormationPlayerUniqueId;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4.length)
                    {
                        
                        if (_loc_4[_loc_5] == _loc_2)
                        {
                            _loc_4[_loc_5] = Constant.EMPTY_ID;
                        }
                        _loc_5++;
                    }
                    _loc_3.setFormationPlayer(_loc_4);
                }
                this._aUniqueId = [];
                NoticeManager.getInstance().clearCharacterLostNotice();
                return true;
            }
            return false;
        }// end function

    }
}
