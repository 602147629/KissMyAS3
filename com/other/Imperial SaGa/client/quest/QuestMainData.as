package quest
{
    import battle.*;
    import develop.*;
    import formation.*;
    import player.*;
    import sound.*;
    import user.*;

    public class QuestMainData extends Object
    {
        private var _title:String;
        private var _fileName:String;
        private var _scriptFileName:String;
        private var _aReadEvent:Array;
        private var _paymentEventRead:int;
        private var _questBgmId:int;
        private var _normalBattleBgmId:int;
        private var _bossBattleBgmId:int;
        private var _feverBgmId:int;
        private var _battleBgIdNormal:int;
        private var _battleBgIdBoss:int;
        private var _aPlayer:Array;
        private var _aPlayerQuestUniqueId:Array;
        private var _aSquare:Array;
        private var _aPlayerBonus:Array;
        private var _startSquareId:int;
        private var _divideRoot:QuestDivideRoot;

        public function QuestMainData()
        {
            this._startSquareId = Constant.EMPTY_ID;
            return;
        }// end function

        public function get title() : String
        {
            return this._title;
        }// end function

        public function get fileName() : String
        {
            return this._fileName;
        }// end function

        public function get scriptFileName() : String
        {
            return this._scriptFileName;
        }// end function

        public function get aReadEvent() : Array
        {
            return this._aReadEvent;
        }// end function

        public function get paymentEventRead() : int
        {
            return this._paymentEventRead;
        }// end function

        public function get questBgmId() : int
        {
            return this._questBgmId;
        }// end function

        public function get normalBattleBgmId() : int
        {
            return this._normalBattleBgmId;
        }// end function

        public function get bossBattlebgmId() : int
        {
            return this._bossBattleBgmId;
        }// end function

        public function get feverBgmId() : int
        {
            return this._feverBgmId;
        }// end function

        public function get battleBgIdNormal() : int
        {
            return this._battleBgIdNormal;
        }// end function

        public function get battleBgIdBoss() : int
        {
            return this._battleBgIdBoss;
        }// end function

        public function get aPlayer() : Array
        {
            return this._aPlayer;
        }// end function

        public function get aPlayerQuestUniqueId() : Array
        {
            return this._aPlayerQuestUniqueId;
        }// end function

        public function get aSquare() : Array
        {
            return this._aSquare;
        }// end function

        public function get aPlayerBonus() : Array
        {
            return this._aPlayerBonus.concat();
        }// end function

        public function get startSquareId() : int
        {
            return this._startSquareId;
        }// end function

        public function getPlayerPersonal(param1:int) : PlayerPersonal
        {
            var _loc_2:* = null;
            if (param1 < 0)
            {
                return null;
            }
            for each (_loc_2 in this._aPlayer)
            {
                
                if (_loc_2.uniqueId == param1)
                {
                    return _loc_2.clone();
                }
            }
            return null;
        }// end function

        public function getPlayerPersonalByQuestUniqueId(param1:int) : PlayerPersonal
        {
            var _loc_2:* = null;
            if (param1 < 0)
            {
                return null;
            }
            for each (_loc_2 in this._aPlayer)
            {
                
                if (_loc_2.questUniqueId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function setReceiveData(param1:Object) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            this._aPlayer = new Array();
            this._aSquare = new Array();
            this._aPlayerBonus = new Array();
            this._aPlayerQuestUniqueId = new Array();
            this._title = param1.questTitle;
            this._fileName = param1.fileName;
            this._scriptFileName = param1.scriptFileName;
            this._aReadEvent = [];
            if (param1.aReadEvent)
            {
                for each (_loc_8 in param1.aReadEvent)
                {
                    
                    this._aReadEvent.push(_loc_8);
                }
            }
            this._paymentEventRead = param1.paymentEventRead;
            this._questBgmId = param1.questBgmId;
            this._normalBattleBgmId = param1.normalBattleBgmId;
            this._bossBattleBgmId = param1.bossBattleBgmId;
            this._feverBgmId = param1.ferverBgmId;
            if (this._questBgmId <= 0)
            {
                this._questBgmId = SoundId.BGM_QST_MAP_1;
            }
            if (this._normalBattleBgmId <= 0)
            {
                this._normalBattleBgmId = SoundId.BGM_BATTLE_STANDARD_1;
            }
            if (this._bossBattleBgmId <= 0)
            {
                this._bossBattleBgmId = SoundId.BGM_BATTLE_BOSS_1ST;
            }
            if (this._feverBgmId <= 0)
            {
                this._feverBgmId = SoundId.BGM_BATTLE_ARMYATTACK_RS1;
            }
            this._battleBgIdNormal = int(param1.battleBgIdNormal);
            this._battleBgIdBoss = int(param1.battleBgIdBoss);
            for each (_loc_2 in param1.aPlayerQuestUniqueId)
            {
                
                this._aPlayerQuestUniqueId.push(_loc_2);
            }
            _loc_3 = 0;
            for each (_loc_4 in param1.aPlayer)
            {
                
                _loc_9 = new PlayerPersonal();
                _loc_10 = this._aPlayerQuestUniqueId[_loc_3];
                _loc_9.setParameter(_loc_4);
                _loc_9.questUniqueId = _loc_10;
                _loc_9.updateSp();
                this._aPlayer.push(_loc_9);
                _loc_3++;
            }
            _loc_5 = UserDataManager.getInstance().userData.aFormationPlayerUniqueId[FormationSetData.FORMATION_INDEX_COMMANDER];
            if (_loc_5 != Constant.EMPTY_ID && UserDataManager.getInstance().getFormationEntryNum() < FormationSetData.FORMATION_INDEX_NUM)
            {
                _loc_3 = 0;
                while (_loc_3 < this._aPlayer.length)
                {
                    
                    _loc_11 = this._aPlayer[_loc_3];
                    if (_loc_11.uniqueId == _loc_5)
                    {
                        this._aPlayer.splice(_loc_3, 1);
                        this._aPlayerQuestUniqueId.splice(_loc_3, 1);
                        break;
                    }
                    _loc_3++;
                }
            }
            for each (_loc_6 in param1.aSquare)
            {
                
                _loc_12 = new QuestSquare();
                _loc_12.setReceiveData(_loc_6);
                this._aSquare.push(_loc_12);
                if (_loc_12.attribute1 == QuestConstant.SQUARE_ATTR1_START)
                {
                    this._startSquareId = _loc_12.id;
                }
            }
            for each (_loc_7 in param1.aPlayerBonus)
            {
                
                _loc_13 = new QuestPlayerBattleBonus();
                _loc_13.setParam(_loc_7);
                this._aPlayerBonus.push(_loc_13);
            }
            this._divideRoot = new QuestDivideRoot();
            this._divideRoot.searchDivideSquare(this._aSquare, this._startSquareId);
            return;
        }// end function

        public function isDivideRootSquare(param1:int) : Boolean
        {
            return this._divideRoot.isDivideRootSquare(param1);
        }// end function

        public function resetPlayerPersonalOwnSkill(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aPlayer.length)
            {
                
                _loc_3 = this._aPlayer[_loc_2];
                if (_loc_3 == null)
                {
                    DebugLog.print("データの取得に失敗");
                }
                for each (_loc_4 in param1)
                {
                    
                    if (_loc_4.uniqueId == _loc_3.uniqueId)
                    {
                        _loc_3.setOwnSkill(_loc_4);
                        break;
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        public function resetEmperorLp(param1:PlayerPersonal) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (param1)
            {
                _loc_2 = 0;
                while (_loc_2 < this._aPlayer.length)
                {
                    
                    _loc_3 = this._aPlayer[_loc_2];
                    if (_loc_3 == null || _loc_3.isEmperor() == false)
                    {
                    }
                    else
                    {
                        _loc_3.lp = param1.lp;
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

        public function updatePlayerPersonal(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aPlayer.length)
            {
                
                _loc_3 = this._aPlayer[_loc_2];
                if (_loc_3 == null)
                {
                    DebugLog.print("データの取得に失敗");
                }
                for each (_loc_4 in param1)
                {
                    
                    if (_loc_4.uniqueId == _loc_3.uniqueId)
                    {
                        _loc_3.updateStatus(_loc_4);
                        break;
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        public function updatePlayerPersonalAddBonus(param1:Array, param2:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this._aPlayer.length)
            {
                
                _loc_4 = this._aPlayer[_loc_3];
                _loc_5 = BattleBonus.searchBonus(param2, _loc_4.questUniqueId);
                if (_loc_4 == null || _loc_5 == null)
                {
                    DebugLog.print("データの取得に失敗");
                }
                for each (_loc_6 in param1)
                {
                    
                    if (_loc_6.uniqueId == _loc_4.uniqueId)
                    {
                        _loc_4.battleUpdate(_loc_6, _loc_5.bonus);
                        break;
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        public function setTutorialQuestBonus(param1:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            this._aPlayerBonus = [];
            var _loc_2:* = [[{attack:1, defense:0, speed:0, hp:0}, {attack:0, defense:1, speed:0, hp:0}, {attack:0, defense:0, speed:0, hp:0}, {attack:0, defense:0, speed:1, hp:0}, {attack:0, defense:0, speed:0, hp:0}], [{attack:0, defense:1, speed:0, hp:0}, {attack:0, defense:0, speed:0, hp:1}, {attack:1, defense:0, speed:0, hp:0}, {attack:1, defense:0, speed:0, hp:1}, {attack:0, defense:0, speed:0, hp:1}], [{attack:0, defense:0, speed:1, hp:1}, {attack:0, defense:0, speed:0, hp:0}, {attack:0, defense:1, speed:0, hp:0}, {attack:0, defense:0, speed:0, hp:0}, {attack:0, defense:0, speed:1, hp:0}], [{attack:0, defense:0, speed:0, hp:0}, {attack:0, defense:0, speed:0, hp:0}, {attack:0, defense:0, speed:0, hp:0}, {attack:0, defense:0, speed:0, hp:0}, {attack:0, defense:0, speed:0, hp:0}]];
            var _loc_3:* = 0;
            for each (_loc_4 in this._aPlayer)
            {
                
                _loc_5 = [];
                _loc_6 = 0;
                while (_loc_6 < param1)
                {
                    
                    _loc_9 = _loc_2[_loc_6 % _loc_2.length];
                    _loc_5.push(_loc_9[_loc_3]);
                    _loc_6++;
                }
                _loc_7 = new QuestPlayerBattleBonus();
                _loc_8 = {uniqueId:_loc_4.uniqueId, aBonus:_loc_5};
                _loc_7.setParam(_loc_8);
                this._aPlayerBonus.push(_loc_7);
                _loc_3++;
            }
            return;
        }// end function

    }
}
