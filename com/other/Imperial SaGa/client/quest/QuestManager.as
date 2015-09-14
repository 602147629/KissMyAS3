package quest
{
    import battle.*;
    import character.*;
    import develop.*;
    import flash.display.*;
    import flash.geom.*;
    import formation.*;
    import item.*;
    import player.*;
    import resource.*;
    import sound.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class QuestManager extends Object
    {
        private var _questData:QuestMainData;
        private var _questResultData:QuestResultData;
        private var _aUnit:Array;
        private var _aTeamOrder:Array;
        private var _aUnitFormationBackup:Array;
        private var _commanderUniqueId:int;
        private var _questId:String;
        private var _eventId:uint;
        private var _questNo:int;
        private var _difficulty:int;
        private var _aUseItemId:Array;
        private var _aUseFreeItemId:Array;
        private var _bLpCovering:Boolean;
        private var _aPieceEnemy:Array;
        private var _aPieceTreasure:Array;
        private var _aPieceHippopotamus:Array;
        private var _junctionMax:int;
        private var _totalBattleExp:int;
        private var _aPopupMessage:Array;
        private var _aQuestFlag:Array;
        private var _aBattleResult:Array;
        private var _junctionCount:int;
        private var _feverCount:int;
        private var _bossPosition:int;
        private var _startPosition:int;
        private var _unitPosition:int;
        private var _feverGaugeMode:int;
        private var _bMainQuest:Boolean;
        private var _paymentEventStartSqId:int;
        private var _paymentEventNextSqId:int;
        private var _paymentEventActiveSqId:int;
        private var _paymentEventNoticeId:int;
        private var _paymentEventCrown:int;
        private var _aPaymentEventItem:Array;
        private var _bWarehousePaymentEventItem:Boolean;
        private var _loader:XmlLoader;
        private var _aQuestResultData:Array;
        private var _aAmuletLabel:Array;
        private static var _instance:QuestManager = null;
        private static const aPaymentEquipItem:Array = [PaymentItemId.ITEM_GROWTH_RATE_UP];
        public static const FEVER_GAUGE_MODE_JUNCTION:int = 1;
        public static const FEVER_GAUGE_MODE_POSITION:int = 2;
        public static const DISPLAY_OBJECT_TYPE_CLOUD:int = 1;
        public static const DISPLAY_OBJECT_TYPE_SNOW:int = 2;
        public static const DISPLAY_OBJECT_TYPE_DARKNESS:int = 3;

        public function QuestManager()
        {
            this._aUseItemId = [];
            this._aUseFreeItemId = [];
            this._aQuestFlag = [];
            this._aAmuletLabel = [];
            return;
        }// end function

        public function get questData() : QuestMainData
        {
            return this._questData;
        }// end function

        public function get questResultData() : QuestResultData
        {
            return this._questResultData;
        }// end function

        public function get aUnit() : Array
        {
            return this._aUnit;
        }// end function

        public function get aUnitFormationBackup() : Array
        {
            return this._aUnitFormationBackup;
        }// end function

        public function get commanderUniqueId() : int
        {
            return this._commanderUniqueId;
        }// end function

        public function get questId() : String
        {
            return this._questId;
        }// end function

        public function get eventId() : uint
        {
            return this._eventId;
        }// end function

        public function get questNo() : int
        {
            return this._questNo;
        }// end function

        public function get difficulty() : int
        {
            return this._difficulty;
        }// end function

        public function get aUseItemId() : Array
        {
            return this._aUseItemId;
        }// end function

        public function get aUseFreeItemId() : Array
        {
            return this._aUseFreeItemId;
        }// end function

        public function get junctionMax() : int
        {
            return this._junctionMax;
        }// end function

        public function get totalBattleExp() : int
        {
            return this._totalBattleExp;
        }// end function

        public function addTotalBatleExp(param1:int) : void
        {
            DebugLog.print("バトル経験値：" + this._totalBattleExp + "　Newバトル経験値：" + (this._totalBattleExp + param1));
            this._totalBattleExp = this._totalBattleExp + param1;
            return;
        }// end function

        public function get aPopupMessage() : Array
        {
            return this._aPopupMessage;
        }// end function

        public function get aQuestFlag() : Array
        {
            return this._aQuestFlag;
        }// end function

        public function get aBattleResult() : Array
        {
            return this._aBattleResult;
        }// end function

        public function get junctionCount() : int
        {
            return this._junctionCount;
        }// end function

        public function get totalMassCount() : int
        {
            return (this._junctionCount + 1);
        }// end function

        public function getJunctionGaugePersent() : Number
        {
            return this._junctionCount / this._junctionMax * 100;
        }// end function

        public function get feverPoint() : int
        {
            return this._feverGaugeMode == FEVER_GAUGE_MODE_POSITION ? (this._unitPosition) : (0);
        }// end function

        public function getFeverGaugePersent() : Number
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_1:* = 0;
            if (this._feverGaugeMode == FEVER_GAUGE_MODE_POSITION)
            {
                _loc_2 = this._bossPosition - this._startPosition;
                _loc_3 = this._unitPosition - this._startPosition;
                if (_loc_2 != 0)
                {
                    _loc_1 = _loc_3 / _loc_2 * 100;
                }
            }
            return _loc_1;
        }// end function

        public function get bMainQuest() : Boolean
        {
            return this._bMainQuest;
        }// end function

        public function get paymentEventStartSqId() : int
        {
            return this._paymentEventStartSqId;
        }// end function

        public function get paymentEventNextSqId() : int
        {
            return this._paymentEventNextSqId;
        }// end function

        public function setPaymentEventSqId(param1:int, param2:int) : void
        {
            this._paymentEventStartSqId = param1;
            this._paymentEventNextSqId = param2;
            this._paymentEventActiveSqId = this._paymentEventStartSqId;
            return;
        }// end function

        public function get paymentEventActiveSqId() : int
        {
            return this._paymentEventActiveSqId;
        }// end function

        public function setPaymentEventActiveSqId(param1:int) : void
        {
            this._paymentEventActiveSqId = param1;
            return;
        }// end function

        public function get paymentEventNoticeId() : int
        {
            return this._paymentEventNoticeId;
        }// end function

        public function set paymentEventNoticeId(param1:int) : void
        {
            this._paymentEventNoticeId = param1;
            return;
        }// end function

        public function get paymentEventCrown() : int
        {
            return this._paymentEventCrown;
        }// end function

        public function set paymentEventCrown(param1:int) : void
        {
            this._paymentEventCrown = param1;
            return;
        }// end function

        public function get aPaymentEventItem() : Array
        {
            return this._aPaymentEventItem ? (this._aPaymentEventItem.concat()) : ([]);
        }// end function

        public function addPaymentEventItem(param1:QuestRemunerationData) : void
        {
            this._aPaymentEventItem.push(param1);
            return;
        }// end function

        public function get bWarehousePaymentEventItem() : Boolean
        {
            return this._bWarehousePaymentEventItem;
        }// end function

        public function setWarehousePaymentEventItem(param1:Boolean) : void
        {
            this._bWarehousePaymentEventItem = param1;
            return;
        }// end function

        public function get aAmuletLabel() : Array
        {
            return this._aAmuletLabel;
        }// end function

        public function loadListData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "QuestResultMessage.xml", this.cbLoadComplete, false);
            return;
        }// end function

        public function isListLoaded() : Boolean
        {
            if (this._loader != null)
            {
                return this._loader.bLoaded;
            }
            return false;
        }// end function

        private function cbLoadComplete(param1:XML) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._aQuestResultData = [];
            for each (_loc_2 in param1.Data.Message)
            {
                
                _loc_3 = new QuestResultMessageData();
                _loc_3.setParameter(_loc_2);
                this._aQuestResultData.push(_loc_3);
            }
            this._loader.release();
            this._loader = null;
            return;
        }// end function

        public function reset() : void
        {
            this._totalBattleExp = 0;
            this._junctionCount = 0;
            this._feverCount = 0;
            this._aAmuletLabel = [];
            return;
        }// end function

        public function setQuestNo(param1:int, param2:uint, param3:Boolean = false) : void
        {
            this._questNo = param1;
            this._eventId = param2;
            return;
        }// end function

        public function setDifficulty(param1:int) : void
        {
            this._difficulty = param1;
            return;
        }// end function

        public function setUseItem(param1:Array, param2:Array) : void
        {
            var _loc_3:* = 0;
            if (param1)
            {
                this._aUseItemId = param1.concat();
            }
            else
            {
                this._aUseItemId = [];
            }
            if (param2)
            {
                this._aUseFreeItemId = param2.concat();
            }
            else
            {
                this._aUseFreeItemId = [];
            }
            this._bLpCovering = this._aUseItemId.indexOf(PaymentItemId.ITEM_DEFENCE_LP_DAMEAGE) >= 0 || this._aUseFreeItemId.indexOf(PaymentItemId.ITEM_DEFENCE_LP_DAMEAGE) >= 0;
            if (this._aUseItemId.indexOf(PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT) >= 0 || this._aUseFreeItemId.indexOf(PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT) >= 0)
            {
                this._feverGaugeMode = FEVER_GAUGE_MODE_POSITION;
            }
            else
            {
                this._feverGaugeMode = FEVER_GAUGE_MODE_JUNCTION;
            }
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END) || TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_SELECT_END) || TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_MAIN_QUEST_END))
            {
                _loc_3 = this._aUseItemId.indexOf(PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT);
                if (_loc_3 >= 0)
                {
                    this._aUseItemId.splice(_loc_3, 1);
                }
                _loc_3 = this._aUseFreeItemId.indexOf(PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT);
                if (_loc_3 >= 0)
                {
                    this._aUseFreeItemId.splice(_loc_3, 1);
                }
            }
            return;
        }// end function

        public function isLpCovering() : Boolean
        {
            return this._bLpCovering;
        }// end function

        public function isFreeAssault() : Boolean
        {
            return this._aUseFreeItemId.indexOf(PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT) >= 0;
        }// end function

        public function setReceiveQuestStart(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._questData = new QuestMainData();
            this._questData.setReceiveData(param1);
            this._aBattleResult = [];
            for each (_loc_2 in this._questData.aPlayer)
            {
                
                this._aBattleResult.push(new QuestBattleResult(_loc_2.uniqueId));
            }
            this._aPopupMessage = [];
            _loc_3 = param1.aQuestFlag;
            this._aQuestFlag = new Array();
            if (_loc_3.length > 0)
            {
                if (_loc_3[0] is int || _loc_3[0] is String)
                {
                    for each (_loc_4 in _loc_3)
                    {
                        
                        _loc_5 = new QuestFlag(_loc_4);
                        this._aQuestFlag.push(_loc_5);
                    }
                }
                else if (_loc_3[0] is Object)
                {
                    for each (_loc_6 in _loc_3)
                    {
                        
                        _loc_7 = new QuestFlag(_loc_6.id);
                        _loc_7.setReceive(_loc_6);
                        this._aQuestFlag.push(_loc_7);
                    }
                }
            }
            this._bMainQuest = false;
            if (param1.bMainQuest is Boolean)
            {
                this._bMainQuest = param1.bMainQuest;
            }
            this.questInit();
            return;
        }// end function

        public function setReceiveQuestResult(param1:Object) : void
        {
            this._questResultData = new QuestResultData();
            this._questResultData.setQuestResultData(param1);
            return;
        }// end function

        private function feverGaugePositionInit() : void
        {
            var _loc_1:* = null;
            this._bossPosition = 0;
            for each (_loc_1 in this._questData.aSquare)
            {
                
                if (_loc_1.attribute1 == QuestConstant.SQUARE_ATTR1_BOSSBATTLE)
                {
                    this._bossPosition = _loc_1.y;
                    break;
                }
            }
            this._startPosition = 0;
            _loc_1 = this.getSquare(this._questData.startSquareId);
            if (_loc_1)
            {
                this._startPosition = _loc_1.y;
            }
            this._unitPosition = this._startPosition;
            return;
        }// end function

        public function updateUnitPosition() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_1:* = false;
            var _loc_2:* = 0;
            var _loc_3:* = this._unitPosition - this._startPosition;
            if (_loc_3 < 0)
            {
                _loc_3 = -_loc_3;
            }
            for each (_loc_4 in this._aUnit)
            {
                
                _loc_5 = this.getSquare(_loc_4.squareId);
                if (_loc_5 == null)
                {
                    continue;
                }
                _loc_6 = _loc_5.y - this._startPosition;
                if (_loc_6 < 0)
                {
                    _loc_6 = -_loc_6;
                }
                if (_loc_3 < _loc_6)
                {
                    _loc_1 = true;
                    _loc_2 = _loc_5.y;
                    _loc_3 = _loc_6;
                }
            }
            if (_loc_1)
            {
                this._unitPosition = _loc_2;
            }
            return;
        }// end function

        public function addJunctionCount() : void
        {
            if (this.questData.aSquare.length > this._junctionCount)
            {
                var _loc_1:* = this;
                var _loc_2:* = this._junctionCount + 1;
                _loc_1._junctionCount = _loc_2;
            }
            return;
        }// end function

        public function addFeverCount() : void
        {
            if (this.questData.aSquare.length > this._feverCount)
            {
                var _loc_1:* = this;
                var _loc_2:* = this._feverCount + 1;
                _loc_1._feverCount = _loc_2;
            }
            return;
        }// end function

        public function addBattleResult(param1:Array, param2:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            for each (_loc_3 in param1)
            {
                
                if (_loc_3.bDead == false)
                {
                    DebugLog.print("UniqueId:" + _loc_3.uniqueId + "の戦闘回数を増やしました。");
                    for each (_loc_4 in this._aBattleResult)
                    {
                        
                        if (_loc_4.uniqueId == _loc_3.uniqueId)
                        {
                            _loc_5 = BattleBonus.searchBonus(param2, _loc_3.questUniqueId);
                            _loc_4.addBattleCount(_loc_5);
                            break;
                        }
                    }
                }
            }
            return;
        }// end function

        public function getBattleResult(param1:uint) : QuestBattleResult
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBattleResult)
            {
                
                if (_loc_2.uniqueId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getPlayerBonus(param1:uint, param2:int) : PlayerBattleBonus
        {
            var _loc_3:* = null;
            for each (_loc_3 in this.questData.aPlayerBonus)
            {
                
                if (_loc_3.uniqueId == param1)
                {
                    return _loc_3.getParam(param2);
                }
            }
            return null;
        }// end function

        public function checkSpecialPlayerBonus(param1:int, param2:Boolean, param3:Boolean) : Boolean
        {
            if (CommonConstant.GROWTH_DIVIDE_MODE)
            {
                if (param3 == false)
                {
                    return false;
                }
            }
            var _loc_4:* = param2 ? (CommonConstant.GROWTH_SPECIAL_COND_PLAYER_NUM_DIVIDED) : (CommonConstant.GROWTH_SPECIAL_COND_PLAYER_NUM_NORMAL);
            return param1 <= _loc_4;
        }// end function

        public function createPlayerAddBonus(param1:PlayerBattleBonus, param2:PlayerPersonal, param3:Boolean) : PlayerBattleBonus
        {
            var _loc_4:* = new PlayerBattleBonus();
            var _loc_5:* = param1.attack ? (param3 ? (CommonConstant.GROWTH_ADD_ATK_SPECIAL) : (CommonConstant.GROWTH_ADD_ATK_NORMAL)) : (0);
            var _loc_6:* = param1.defense ? (param3 ? (CommonConstant.GROWTH_ADD_DEF_SPECIAL) : (CommonConstant.GROWTH_ADD_DEF_NORMAL)) : (0);
            var _loc_7:* = param1.speed ? (param3 ? (CommonConstant.GROWTH_ADD_SPD_SPECIAL) : (CommonConstant.GROWTH_ADD_SPD_NORMAL)) : (0);
            var _loc_8:* = param1.hp ? (param3 ? (CommonConstant.GROWTH_ADD_HP_SPECIAL) : (CommonConstant.GROWTH_ADD_HP_NORMAL)) : (0);
            var _loc_9:* = PlayerManager.getInstance().getPlayerInformation(param2.playerId);
            if (param2.attack + _loc_5 > _loc_9.maxAttack)
            {
                _loc_5 = _loc_9.maxAttack - param2.attack;
                if (_loc_5 < 0)
                {
                    _loc_5 = 0;
                }
            }
            if (param2.defense + _loc_6 > _loc_9.maxDefense)
            {
                _loc_6 = _loc_9.maxDefense - param2.defense;
                if (_loc_6 < 0)
                {
                    _loc_6 = 0;
                }
            }
            if (param2.speed + _loc_7 > _loc_9.maxSpeed)
            {
                _loc_7 = _loc_9.maxSpeed - param2.speed;
                if (_loc_7 < 0)
                {
                    _loc_7 = 0;
                }
            }
            if (param2.hpMax + _loc_8 > _loc_9.maxHp)
            {
                _loc_8 = _loc_9.maxHp - param2.hpMax;
                if (_loc_8 < 0)
                {
                    _loc_8 = 0;
                }
            }
            _loc_4.setAddBonus(_loc_5, _loc_6, _loc_7, _loc_8);
            return _loc_4;
        }// end function

        public function getPopMessage() : String
        {
            var _loc_2:* = 0;
            var _loc_1:* = "";
            if (this._aPopupMessage.length > 0)
            {
                _loc_2 = Random.range(0, (this._aPopupMessage.length - 1));
                _loc_1 = this._aPopupMessage[_loc_2].message;
                this._aPopupMessage.splice(_loc_2, 1);
            }
            return _loc_1;
        }// end function

        public function setQuestFlag(param1:int, param2:Boolean) : void
        {
            var _loc_3:* = null;
            for each (_loc_3 in this._aQuestFlag)
            {
                
                if (_loc_3.id == param1)
                {
                    _loc_3.setState(param2);
                }
            }
            return;
        }// end function

        public function getQuestFlag(param1:int) : QuestFlag
        {
            var _loc_3:* = null;
            var _loc_2:* = null;
            for each (_loc_3 in this._aQuestFlag)
            {
                
                if (_loc_3.id == param1)
                {
                    _loc_2 = _loc_3;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function getUpdateQuestFlag(param1:int) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = new Array();
            for each (_loc_3 in this._aQuestFlag)
            {
                
                if (QuestConstant.QUEST_FLAG < _loc_3.id && _loc_3.id < QuestConstant.PAYMENT_FLAG)
                {
                    if (_loc_3.bClear == false || _loc_3.bClear && param1 == CommonConstant.QUEST_RESULT_TYPE_GOOD_SUCCESS)
                    {
                        _loc_2.push(_loc_3);
                    }
                }
            }
            return _loc_2;
        }// end function

        public function addPaymentEventQuestFlag(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = true;
            for each (_loc_3 in this._aQuestFlag)
            {
                
                if (_loc_3.id == param1)
                {
                    _loc_2 = false;
                    break;
                }
            }
            if (_loc_2)
            {
                _loc_4 = new QuestFlag(param1);
                this._aQuestFlag.push(_loc_4);
            }
            return;
        }// end function

        private function questInit() : void
        {
            this._aUnit = [];
            this._aTeamOrder = [];
            this._aUnitFormationBackup = [];
            this._aPieceEnemy = [];
            this._aPieceTreasure = [];
            this._aPieceHippopotamus = [];
            this._commanderUniqueId = Constant.UNDECIDED;
            this._junctionMax = this._questData.aSquare.length - 1;
            this._junctionCount = 0;
            this._feverCount = 0;
            this.feverGaugePositionInit();
            this._totalBattleExp = 0;
            this._paymentEventStartSqId = Constant.UNDECIDED;
            this._paymentEventNextSqId = Constant.UNDECIDED;
            this._paymentEventNoticeId = 0;
            this._aPaymentEventItem = [];
            this._bWarehousePaymentEventItem = false;
            this._aAmuletLabel = [];
            return;
        }// end function

        public function questRelease() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_1 in this._aUnit)
            {
                
                if (_loc_1 != null)
                {
                    _loc_1.release(true);
                }
            }
            this._aUnit = [];
            this._aTeamOrder = [];
            this._aUnitFormationBackup = [];
            for each (_loc_2 in this._aPieceEnemy)
            {
                
                _loc_2.release();
            }
            this._aPieceEnemy = [];
            for each (_loc_3 in this._aPieceTreasure)
            {
                
                _loc_3.release();
            }
            this._aPieceTreasure = [];
            for each (_loc_4 in this._aPieceHippopotamus)
            {
                
                _loc_4.release();
            }
            this._aPieceHippopotamus = [];
            this._questData = null;
            return;
        }// end function

        public function getSquare(param1:int) : QuestSquare
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._questData.aSquare)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getQuestEnemyList(param1:Array) : QuestEnemyList
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = null;
            param1 = param1.sortOn("groupId", Array.NUMERIC);
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1[_loc_3];
                if (_loc_4.groupId == 1)
                {
                    _loc_2 = _loc_4;
                }
                else
                {
                    _loc_5 = this.getQuestFlag(_loc_4.flagId);
                    if (_loc_5 != null && _loc_5.bState == true)
                    {
                        _loc_2 = _loc_4;
                    }
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public function getTeamNum() : int
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = 0;
            for each (_loc_2 in this._aUnit)
            {
                
                for each (_loc_3 in _loc_2.aPlayer)
                {
                    
                    _loc_4 = this._questData.getPlayerPersonal(_loc_3.uniqueId);
                    if (_loc_4 != null && _loc_4.bDead == false && _loc_4.hp > 0)
                    {
                        _loc_1++;
                        break;
                    }
                }
            }
            return _loc_1;
        }// end function

        public function getNextUnit(param1:int) : int
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (param1 == Constant.UNDECIDED)
            {
                return this._aUnit[0].teamNo;
            }
            var _loc_3:* = 0;
            while (_loc_3 < this._aUnit.length)
            {
                
                _loc_4 = this._aUnit[_loc_3];
                if (_loc_4 != null && _loc_4.teamNo == param1)
                {
                    _loc_2 = this._aUnit[(_loc_3 + 1)];
                    if (_loc_2 == null)
                    {
                        _loc_2 = this._aUnit[0];
                    }
                    if (_loc_4 != null && _loc_4.aPlayer.length == 0)
                    {
                        this.removeUnit(_loc_4.teamNo);
                    }
                    break;
                }
                _loc_3++;
            }
            if (_loc_2 != null)
            {
                return _loc_2.teamNo;
            }
            _loc_5 = this.searchNextTeamNo(param1);
            if (_loc_5)
            {
                return _loc_5;
            }
            if (param1 != 1 && this._aUnit.length > 1)
            {
                return this._aUnit[1].teamNo;
            }
            return this._aUnit[0].teamNo;
        }// end function

        public function isJoinWaitUnit(param1:int) : Boolean
        {
            var _loc_5:* = null;
            var _loc_2:* = this.getUnit(param1);
            if (_loc_2 == null)
            {
                return false;
            }
            var _loc_3:* = this.getSquare(_loc_2.squareId);
            if (_loc_3 == null || _loc_3.attribute1 != QuestConstant.SQUARE_ATTR1_JOIN)
            {
                return false;
            }
            var _loc_4:* = _loc_3.id;
            for each (_loc_5 in this._aUnit)
            {
                
                if (_loc_5 == null || _loc_5.aPlayer.length <= 0 || _loc_5.teamNo == param1)
                {
                    continue;
                }
                _loc_3 = this.getSquare(_loc_5.squareId);
                if (_loc_3 && this.checkOnRoute(_loc_3, _loc_4))
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function getBossBattleJoinParty() : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_1:* = [];
            var _loc_2:* = 0;
            while (_loc_2 < this._aUnit.length)
            {
                
                _loc_3 = this._aUnit[_loc_2];
                _loc_4 = _loc_3.aPlayer.length - 1;
                while (_loc_4 >= 0)
                {
                    
                    _loc_5 = _loc_3.aPlayer[_loc_4];
                    if (_loc_5 != null)
                    {
                        _loc_6 = this._questData.getPlayerPersonal(_loc_5.uniqueId);
                        if (_loc_6 != null && (_loc_6.bDead || _loc_6.hp <= 0))
                        {
                            _loc_3.removePlayer(_loc_5 as PlayerDisplay);
                        }
                    }
                    _loc_4 = _loc_4 - 1;
                }
                if (_loc_3.aPlayer.length > 0)
                {
                    _loc_1.push(_loc_3);
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function getBossBattleRouteCount(param1:int) : int
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = this.getUnit(param1);
            if (_loc_2 != null)
            {
                _loc_3 = this.getSquare(_loc_2.squareId);
                _loc_4 = this._questData.aSquare.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    if (_loc_3 == null)
                    {
                        break;
                    }
                    if (_loc_3.attribute1 == QuestConstant.SQUARE_ATTR1_BOSSBATTLE)
                    {
                        return _loc_5;
                    }
                    _loc_3 = QuestManager.getInstance().getSquare(_loc_3.aConnectionId[0]);
                    _loc_5++;
                }
            }
            return -1;
        }// end function

        public function checkOnRoute(param1:QuestSquare, param2:int, param3:int = 0) : Boolean
        {
            var _loc_5:* = null;
            if (param3 >= this._questData.aSquare.length)
            {
                return false;
            }
            var _loc_4:* = 0;
            while (_loc_4 < param1.aConnectionId.length)
            {
                
                _loc_5 = this.getSquare(param1.aConnectionId[_loc_4]);
                if (_loc_5)
                {
                    if (_loc_5.id == param2)
                    {
                        return true;
                    }
                    if (this.checkOnRoute(_loc_5, param2, (param3 + 1)))
                    {
                        return true;
                    }
                }
                _loc_4++;
            }
            return false;
        }// end function

        public function getQuestSquareRouteCount(param1:QuestSquare, param2:Array = null, param3:int = 0, param4:int = 99999, param5:int = 0, param6:int = 0) : int
        {
            var _loc_9:* = null;
            var _loc_10:* = 0;
            if (param1.aConnectionId.length == 0)
            {
                return param6;
            }
            var _loc_7:* = 99999;
            var _loc_8:* = 0;
            while (_loc_8 < param1.aConnectionId.length)
            {
                
                _loc_9 = QuestManager.getInstance().getSquare(param1.aConnectionId[_loc_8]);
                if (_loc_9)
                {
                    if (param2 != null && param6 > 0 && param6 >= param3 && param6 <= param4)
                    {
                        param2.push(_loc_9.id);
                    }
                    _loc_10 = this.getQuestSquareRouteCount(_loc_9, param2, param3, param4, param5, (param6 + 1));
                    if (_loc_10 < _loc_7)
                    {
                        _loc_7 = _loc_10;
                    }
                }
                _loc_8++;
            }
            return _loc_7;
        }// end function

        public function getPaymentEventStartCandidateSquareId() : Array
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            for each (_loc_1 in this._questData.aSquare)
            {
                
                if (_loc_1.attribute1 == QuestConstant.SQUARE_ATTR1_START)
                {
                    _loc_2 = this.getQuestSquareRouteCount(_loc_1);
                    _loc_3 = [];
                    this.getQuestSquareRouteCount(_loc_1, _loc_3, 0, _loc_2 / 2);
                    return _loc_3;
                }
            }
            return [];
        }// end function

        public function getPaymentEventEndCandidateSquareId(param1:int) : Array
        {
            var _loc_2:* = this.getSquare(param1);
            var _loc_3:* = [];
            if (_loc_2)
            {
                this.getQuestSquareRouteCount(_loc_2, _loc_3, 3, 5);
            }
            return _loc_3;
        }// end function

        public function setUnit(param1:int, param2:int) : QuestUnit
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param1 == 1)
            {
                param2 = 0;
            }
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            for each (_loc_5 in this._aUnit)
            {
                
                if (_loc_5 != null && _loc_5.teamNo == param1)
                {
                    return _loc_5;
                }
                if (_loc_5 != null && _loc_5.teamNo == param2)
                {
                    if (_loc_5.teamNo < param1)
                    {
                        _loc_3 = _loc_4 + 1;
                    }
                    else
                    {
                        _loc_3 = _loc_4;
                    }
                }
                _loc_4++;
            }
            _loc_6 = new QuestUnit(param1);
            this._aUnit.splice(_loc_3, 0, _loc_6);
            return _loc_6;
        }// end function

        public function getUnit(param1:int) : QuestUnit
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aUnit)
            {
                
                if (_loc_2 != null && _loc_2.teamNo == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function removeUnit(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this._aUnit.length)
            {
                
                _loc_2 = this._aUnit[_loc_3];
                if (_loc_2 != null && _loc_2.teamNo == param1)
                {
                    _loc_2.release();
                    this._aUnit.splice(_loc_3, 1);
                    if (this._aUnit.length > 0)
                    {
                        this.setNextTeamInfo(param1, this._aUnit[_loc_3 % this._aUnit.length]);
                    }
                    else
                    {
                        this.setNextTeamInfo(param1, null);
                    }
                    break;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function resetUnitTeamNo(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aUnit)
            {
                
                if (_loc_2.teamNo > param1)
                {
                    (_loc_2.teamNo - 1);
                }
            }
            return;
        }// end function

        private function setNextTeamInfo(param1:int, param2:QuestUnit) : void
        {
            this._aTeamOrder[param1] = param2 ? (param2.teamNo) : (0);
            return;
        }// end function

        private function searchNextTeamNo(param1:int) : int
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aTeamOrder[param1];
            if (_loc_2 != 0 && _loc_2 != param1)
            {
                _loc_3 = this.getUnit(_loc_2);
                if (_loc_3)
                {
                    return _loc_3.teamNo;
                }
            }
            return 0;
        }// end function

        public function getPieceEnemy(param1:int) : QuestSymbolEnemyList
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aPieceEnemy)
            {
                
                if (_loc_2.squareId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function addPieceEnemy(param1:int, param2:DisplayObjectContainer, param3:int = -1) : QuestSymbolEnemyList
        {
            var _loc_4:* = this.getSquare(param1);
            if (this.getSquare(param1).aEnemy.length == 0)
            {
                Assert.print("マスID:" + param1 + " バトルのマスが設定されているのに敵情報が取得できませんでした。");
            }
            var _loc_5:* = new QuestSymbolEnemyList(param2, _loc_4);
            this._aPieceEnemy.push(_loc_5);
            if (param3 != -1)
            {
                param2.setChildIndex(_loc_5.parentMc, param3);
            }
            return _loc_5;
        }// end function

        public function removePieceEnemy(param1:QuestSymbolEnemyList) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aPieceEnemy.length)
            {
                
                _loc_3 = this._aPieceEnemy[_loc_2];
                if (_loc_3.squareId == param1.squareId)
                {
                    this._aPieceEnemy.splice(_loc_2, 1);
                    break;
                }
                _loc_2++;
            }
            param1.release();
            return;
        }// end function

        public function addPieceTreasure(param1:int, param2:DisplayObjectContainer, param3:int = -1) : QuestPieceTreasure
        {
            var _loc_4:* = this.getSquare(param1);
            if (this.getSquare(param1) == null)
            {
                return null;
            }
            var _loc_5:* = new QuestPieceTreasure(param2, _loc_4, _loc_4.itemDisp);
            this._aPieceTreasure.push(_loc_5);
            return _loc_5;
        }// end function

        public function openPieceTreasure(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aPieceTreasure)
            {
                
                if (_loc_2.squareId == param1)
                {
                    _loc_2.openBox();
                }
            }
            return;
        }// end function

        public function removePieceTreasure(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aPieceTreasure.length)
            {
                
                _loc_3 = this._aPieceTreasure[_loc_2];
                if (_loc_3.squareId == param1)
                {
                    this._aPieceTreasure.splice(_loc_2, 1);
                    _loc_3.release();
                    _loc_2 = _loc_2 - 1;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function addPieceHippopotamus(param1:int, param2:DisplayObjectContainer, param3:int) : QuestPieceHippopotamus
        {
            var _loc_4:* = this.getSquare(param1);
            if (this.getSquare(param1) == null)
            {
                return null;
            }
            var _loc_5:* = new QuestPieceHippopotamus(param2, _loc_4, param3);
            this._aPieceHippopotamus.push(_loc_5);
            return _loc_5;
        }// end function

        public function showPieceHippopotamus(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aPieceHippopotamus)
            {
                
                if (_loc_2.squareId == param1)
                {
                    _loc_2.setShow();
                }
            }
            return;
        }// end function

        public function vanishPieceHippopotamus(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aPieceHippopotamus)
            {
                
                if (_loc_2.squareId == param1)
                {
                    _loc_2.setVanish();
                }
            }
            return;
        }// end function

        public function removePieceHippopotamus(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aPieceHippopotamus.length)
            {
                
                _loc_3 = this._aPieceHippopotamus[_loc_2];
                if (_loc_3.squareId == param1)
                {
                    this._aPieceHippopotamus.splice(_loc_2, 1);
                    _loc_3.release();
                    _loc_2 = _loc_2 - 1;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function setAmuletLabel() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            for each (_loc_1 in aPaymentEquipItem)
            {
                
                if (this._aUseItemId.indexOf(_loc_1) >= 0 || this._aUseFreeItemId.indexOf(_loc_1) >= 0)
                {
                    _loc_2 = this.getAmuletLabel(_loc_1);
                    if (_loc_2 != "" && this._aAmuletLabel.indexOf(_loc_2) == -1)
                    {
                        this._aAmuletLabel.push(_loc_2);
                    }
                }
            }
            return;
        }// end function

        public function getAmuletLabel(param1:int) : String
        {
            var _loc_2:* = "";
            switch(param1)
            {
                case PaymentItemId.ITEM_GROWTH_RATE_UP:
                {
                    _loc_2 = "amulet1";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function displayObjecResource(param1:int) : Array
        {
            var _loc_2:* = [];
            switch(param1)
            {
                case DISPLAY_OBJECT_TYPE_CLOUD:
                {
                    _loc_2 = _loc_2.concat(QuestMapCloud.getResource());
                    break;
                }
                case DISPLAY_OBJECT_TYPE_DARKNESS:
                {
                    _loc_2 = _loc_2.concat(QuestMapDarkness2.getResource());
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function createQuestMapObject(param1:DisplayObjectContainer, param2:int, param3:Number) : Array
        {
            switch(param2)
            {
                case DISPLAY_OBJECT_TYPE_CLOUD:
                {
                    return this.createCloud(param1);
                }
                case DISPLAY_OBJECT_TYPE_SNOW:
                {
                    return this.createSnow(param1, param3);
                }
                case DISPLAY_OBJECT_TYPE_DARKNESS:
                {
                    return this.createDarkness(param1, param3);
                }
                default:
                {
                    break;
                }
            }
            return [];
        }// end function

        private function createCloud(param1:DisplayObjectContainer) : Array
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = [new Point(0, 200), new Point(350, 400), new Point(50, 700), new Point(100, 900), new Point(300, 1100), new Point(600, 1300), new Point(-100, 1600), new Point(100, 1900), new Point(-200, 2000), new Point(800, 2100)];
            var _loc_3:* = [];
            for each (_loc_4 in _loc_2)
            {
                
                _loc_5 = new QuestMapCloud(param1, _loc_4, 60 * 10);
                _loc_3.push(_loc_5);
            }
            return _loc_3;
        }// end function

        private function createSnow(param1:DisplayObjectContainer, param2:Number) : Array
        {
            var _loc_5:* = null;
            var _loc_3:* = [];
            var _loc_4:* = 0;
            while (_loc_4 < 100)
            {
                
                _loc_5 = new QuestMapSnow(param1, _loc_4, param2);
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            return _loc_3;
        }// end function

        private function createDarkness(param1:DisplayObjectContainer, param2:Number) : Array
        {
            var _loc_7:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_3:* = new Sprite();
            _loc_3.graphics.beginFill(0);
            _loc_3.graphics.drawRect(0, 0, Constant.SCREEN_WIDTH, Constant.SCREEN_HEIGHT);
            _loc_3.graphics.endFill();
            var _loc_4:* = new BitmapData(Constant.SCREEN_WIDTH, Constant.SCREEN_HEIGHT, true, 0);
            new BitmapData(Constant.SCREEN_WIDTH, Constant.SCREEN_HEIGHT, true, 0).draw(_loc_3);
            var _loc_5:* = new Bitmap(_loc_4);
            new Bitmap(_loc_4).transform.colorTransform = new ColorTransform(1, 1, 1, 0.4);
            param1.parent.parent.parent.addChild(_loc_5);
            var _loc_6:* = [];
            _loc_7 = 0;
            while (_loc_7 < 50)
            {
                
                _loc_12 = new QuestMapDarkness(param1, _loc_7, param2);
                _loc_6.push(_loc_12);
                _loc_7++;
            }
            var _loc_8:* = 2 * param2 / 50;
            var _loc_9:* = [];
            var _loc_10:* = Constant.SCREEN_WIDTH / 50;
            var _loc_11:* = (param2 + 99) / 100;
            _loc_7 = 0;
            while (_loc_7 < _loc_8)
            {
                
                _loc_9.push(new Point(Random.range(0, _loc_10) * 50, Random.range(0, _loc_11) * 100 + 50 * (_loc_7 & 1)));
                _loc_7++;
            }
            _loc_9.sortOn("y", Array.NUMERIC);
            _loc_7 = 0;
            while (_loc_7 < _loc_8)
            {
                
                _loc_13 = new QuestMapDarkness2(param1, _loc_7, new Point(0, 0), _loc_5, param2);
                _loc_6.push(_loc_13);
                _loc_7++;
            }
            return _loc_6;
        }// end function

        public function resultBgm() : int
        {
            var _loc_2:* = 0;
            var _loc_1:* = this._questResultData.resultType;
            switch(_loc_1)
            {
                case CommonConstant.QUEST_RESULT_TYPE_GOOD_SUCCESS:
                {
                    _loc_2 = SoundId.BGM_RESULT_RANK1;
                    break;
                }
                case CommonConstant.QUEST_RESULT_TYPE_SUCCESS:
                {
                    _loc_2 = SoundId.BGM_RESULT_RANK2;
                    break;
                }
                case CommonConstant.QUEST_RESULT_TYPE_FAILURE:
                {
                    _loc_2 = SoundId.BGM_BATTLE_LOSE;
                    break;
                }
                default:
                {
                    _loc_2 = SoundId.BGM_BATTLE_LOSE;
                    DebugLog.print("想定外のリザルトタイプが送られています。\nリザルトタイプ：" + _loc_1);
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function resultMessage(param1:int, param2:int) : String
        {
            var _loc_4:* = null;
            var _loc_3:* = "";
            for each (_loc_4 in this._aQuestResultData)
            {
                
                if (_loc_4.type == param1)
                {
                    _loc_3 = _loc_4.getResultMessage(param2);
                }
            }
            return _loc_3;
        }// end function

        public function questStrategyRank(param1:int) : int
        {
            var _loc_2:* = 0;
            if (QuestConstant.QUEST_RESULT_GAUGE_S <= param1)
            {
                _loc_2 = QuestConstant.QUEST_RESULT_RANK_S;
            }
            else if (QuestConstant.QUEST_RESULT_GAUGE_A <= param1)
            {
                _loc_2 = QuestConstant.QUEST_RESULT_RANK_A;
            }
            else if (QuestConstant.QUEST_RESULT_GAUGE_B <= param1)
            {
                _loc_2 = QuestConstant.QUEST_RESULT_RANK_B;
            }
            else if (QuestConstant.QUEST_RESULT_GAUGE_C <= param1)
            {
                _loc_2 = QuestConstant.QUEST_RESULT_RANK_C;
            }
            else
            {
                _loc_2 = QuestConstant.QUEST_RESULT_RANK_D;
            }
            return _loc_2;
        }// end function

        public function getQuestEndTime(param1:uint) : String
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = "";
            if (param1 > 0)
            {
                _loc_3 = TimeClock.getNowTime();
                _loc_4 = param1 - _loc_3;
                _loc_5 = _loc_4 / 86400;
                _loc_6 = _loc_4 / 3600;
                _loc_7 = _loc_4 / 60;
                if (_loc_4 >= 86400)
                {
                    _loc_2 = String(_loc_5 + "日");
                }
                else if (_loc_4 >= 3600)
                {
                    _loc_2 = String(_loc_6 + "時間");
                }
                else
                {
                    _loc_2 = String(_loc_7 + "分");
                }
            }
            return _loc_2;
        }// end function

        public function setTutorialQuest(param1:Boolean) : void
        {
            var uniqueId:uint;
            var startSq:QuestSquare;
            var sq:QuestSquare;
            var getBattleCountFunc:Function;
            var personal:PlayerPersonal;
            var bItemCountCap:* = param1;
            this._aBattleResult = [];
            this._questData.aPlayer.length = 0;
            var userData:* = UserDataManager.getInstance().userData;
            var aQuestUniqueId:* = this._questData.aPlayerQuestUniqueId;
            var i:int;
            var _loc_3:* = 0;
            var _loc_4:* = userData.aFormationPlayerUniqueId;
            while (_loc_4 in _loc_3)
            {
                
                uniqueId = _loc_4[_loc_3];
                personal = userData.getPlayerPersonal(uniqueId);
                personal.updateSp();
                personal.questUniqueId = aQuestUniqueId[i];
                this._questData.aPlayer.push(personal);
                this._aBattleResult.push(new QuestBattleResult(personal.uniqueId));
                i = (i + 1);
            }
            var _loc_3:* = 0;
            var _loc_4:* = this._questData.aSquare;
            while (_loc_4 in _loc_3)
            {
                
                sq = _loc_4[_loc_3];
                if (sq.attribute1 == QuestConstant.SQUARE_ATTR1_START)
                {
                    startSq = sq;
                }
            }
            getBattleCountFunc = function (param1:QuestSquare, param2:int = 0, param3:int = 0) : int
            {
                var _loc_6:* = null;
                var _loc_7:* = 0;
                if (param1.attribute1 == QuestConstant.SQUARE_ATTR1_BATTLE || param1.attribute1 == QuestConstant.SQUARE_ATTR1_BOSSBATTLE)
                {
                    param3++;
                }
                if (param1.aConnectionId.length == 0)
                {
                    return param3;
                }
                var _loc_4:* = 0;
                var _loc_5:* = 0;
                while (_loc_5 < param1.aConnectionId.length)
                {
                    
                    _loc_6 = QuestManager.getInstance().getSquare(param1.aConnectionId[_loc_5]);
                    if (_loc_6)
                    {
                        _loc_7 = getBattleCountFunc(_loc_6, (param2 + 1), param3);
                        if (_loc_7 > _loc_4)
                        {
                            _loc_4 = _loc_7;
                        }
                    }
                    _loc_5++;
                }
                return _loc_4;
            }// end function
            ;
            this._questData.setTutorialQuestBonus(this.getBattleCountFunc(startSq));
            return;
        }// end function

        public function setCommanderUniqueId(param1:int) : void
        {
            this._commanderUniqueId = param1;
            return;
        }// end function

        public function addFormationBackup(param1:FormationSetData) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in param1.aPlayerUniqueId)
            {
                
                if (_loc_3 == Constant.EMPTY_ID)
                {
                    continue;
                }
                _loc_5 = this._questData.getPlayerPersonal(_loc_3);
                if (_loc_5 && _loc_5.bDead == false)
                {
                    _loc_2.push(_loc_3);
                }
            }
            _loc_2.sort(Array.NUMERIC);
            _loc_4 = new QuestFormationSetBackupData(_loc_2, param1);
            this._aUnitFormationBackup.push(_loc_4);
            return;
        }// end function

        public function getFormationBackup(param1:Array) : QuestFormationSetBackupData
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aUnitFormationBackup.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aUnitFormationBackup[_loc_2];
                if (_loc_3.checkKeyMember(param1))
                {
                    return _loc_3;
                }
                _loc_2 = _loc_2 - 1;
            }
            return null;
        }// end function

        public static function getInstance() : QuestManager
        {
            if (_instance == null)
            {
                _instance = new QuestManager;
            }
            return _instance;
        }// end function

        public static function getYear(param1:int, param2:int) : int
        {
            param2 = param2 + 1;
            switch(param1)
            {
                case QuestConstant.CHAPTER_NO2:
                {
                    param2 = param2 + QuestConstant.CHAPTER_PROGRESS_1;
                    break;
                }
                case QuestConstant.CHAPTER_NO3:
                {
                    param2 = param2 + QuestConstant.CHAPTER_PROGRESS_2;
                    break;
                }
                case QuestConstant.CHAPTER_NO4:
                {
                    param2 = param2 + QuestConstant.CHAPTER_PROGRESS_3;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return param2;
        }// end function

        public static function questRankLabel(param1:int) : String
        {
            var _loc_2:* = QuestManager.getInstance().questStrategyRank(param1);
            var _loc_3:* = "rankD";
            switch(_loc_2)
            {
                case QuestConstant.QUEST_RESULT_RANK_S:
                {
                    _loc_3 = "rankS";
                    break;
                }
                case QuestConstant.QUEST_RESULT_RANK_A:
                {
                    _loc_3 = "rankA";
                    break;
                }
                case QuestConstant.QUEST_RESULT_RANK_B:
                {
                    _loc_3 = "rankB";
                    break;
                }
                case QuestConstant.QUEST_RESULT_RANK_C:
                {
                    _loc_3 = "rankC";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        public static function questClearRankLabel(param1:int, param2:Boolean) : String
        {
            var _loc_3:* = QuestManager.questRankLabel(param1);
            if (param2)
            {
                _loc_3 = _loc_3 + "_clear";
            }
            return _loc_3;
        }// end function

    }
}
