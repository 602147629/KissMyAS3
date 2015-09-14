package barracks
{
    import network.*;
    import notice.*;
    import player.*;
    import user.*;
    import utility.*;

    public class BarracksAutoRestManager extends Object
    {
        private var _aAutoTarget:Array;
        private var _aRestCb:Array;
        private var _autoRestPlayer:BarracksAutoRestPlayer;
        private var _timeCount:Number;
        public static const CHECK_TARGET_ALL:int = 0;
        public static const CHECK_TARGET_PARTY:int = 1;
        private static var _instance:BarracksAutoRestManager = null;

        public function BarracksAutoRestManager()
        {
            this._aAutoTarget = [];
            this._aRestCb = [];
            this._autoRestPlayer = null;
            this._timeCount = 0;
            return;
        }// end function

        public function addCbRest(param1:Function) : void
        {
            this._aRestCb.push(param1);
            return;
        }// end function

        public function delCbRest(param1:Function) : void
        {
            var _loc_2:* = this._aRestCb.indexOf(param1);
            if (_loc_2 >= 0)
            {
                this._aRestCb.splice(_loc_2, 1);
            }
            return;
        }// end function

        public function clearCheck() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aAutoTarget)
            {
                
                _loc_1.release();
            }
            this._aAutoTarget = [];
            this._timeCount = 0;
            return;
        }// end function

        private function delAutoRestPlayer(param1:int) : void
        {
            return;
        }// end function

        public function updateCheckPlayer(param1:int = 0) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            this.clearCheck();
            var _loc_2:* = UserDataManager.getInstance().userData;
            var _loc_3:* = _loc_2.aBarracksData;
            var _loc_4:* = _loc_2.aPlayerPersonal;
            var _loc_5:* = _loc_2.aFormationPlayerUniqueId;
            _loc_6 = 0;
            while (_loc_6 < _loc_3.length)
            {
                
                _loc_7 = _loc_3[_loc_6];
                if (this._autoRestPlayer && this._autoRestPlayer.uniqueId == _loc_7.uniqueId)
                {
                }
                else
                {
                    for each (_loc_8 in _loc_4)
                    {
                        
                        if (_loc_8.uniqueId == _loc_7.uniqueId)
                        {
                            if (param1 == CHECK_TARGET_PARTY)
                            {
                                if (_loc_5.indexOf(_loc_8.uniqueId) < 0)
                                {
                                    break;
                                }
                            }
                            this._aAutoTarget.push(new BarracksAutoRestPlayer(_loc_8, _loc_7));
                            break;
                        }
                    }
                }
                _loc_6++;
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            return;
        }// end function

        public function autoRest() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (this._autoRestPlayer == null)
            {
                _loc_1 = TimeClock.getNowTime();
                _loc_3 = 0;
                while (_loc_3 < this._aAutoTarget.length)
                {
                    
                    _loc_2 = this._aAutoTarget[_loc_3];
                    if (_loc_2.getRestoreSec(_loc_1) <= 0)
                    {
                        break;
                    }
                    _loc_3++;
                }
                if (_loc_3 < this._aAutoTarget.length)
                {
                    this._autoRestPlayer = this._aAutoTarget[_loc_3];
                    this._aAutoTarget.splice(_loc_3, 1);
                    NetManager.getInstance().request(new NetTaskBarracksRestEnd(false, false, this._autoRestPlayer.index, this.cbConnectRestEnd));
                }
            }
            return;
        }// end function

        private function cbConnectRestEnd(param1:NetResult) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_2:* = param1.data.index;
            var _loc_3:* = UserDataManager.getInstance().userData;
            var _loc_4:* = new PlayerPersonal();
            new PlayerPersonal().setParameter(param1.data.playerPersonal);
            var _loc_5:* = _loc_3.aPlayerPersonal;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5.length)
            {
                
                if (_loc_5[_loc_6].uniqueId == _loc_4.uniqueId)
                {
                    (_loc_5[_loc_6] as PlayerPersonal).copyParam(_loc_4);
                    break;
                }
                _loc_6++;
            }
            _loc_3.setOwnPlayer(_loc_5);
            var _loc_7:* = _loc_3.aBarracksData;
            for each (_loc_8 in _loc_7)
            {
                
                if (_loc_8.uniqueId == _loc_4.uniqueId)
                {
                    _loc_8.setData(Constant.EMPTY_ID, 0, Constant.EMPTY_ID);
                }
                _loc_3.resetBarracksData(_loc_8.index, _loc_8.uniqueId, _loc_8.restoreTime, _loc_8.noticeId);
            }
            NoticeManager.getInstance().crearSimpleNoticeById(param1.data.institutionNoticeId);
            for each (_loc_9 in this._aRestCb)
            {
                
                this._loc_9(_loc_4);
            }
            this._autoRestPlayer = null;
            return;
        }// end function

        public static function getInstance() : BarracksAutoRestManager
        {
            if (_instance == null)
            {
                _instance = new BarracksAutoRestManager;
            }
            return _instance;
        }// end function

    }
}
