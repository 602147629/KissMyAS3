package user
{
    import asset.*;
    import barracks.*;
    import correlation.*;
    import develop.*;
    import formation.*;
    import home.*;
    import item.*;
    import notice.*;
    import player.*;
    import status.*;
    import storage.*;
    import topbar.*;
    import utility.*;

    public class UserDataPersonal extends Object
    {
        private var _userId:int;
        private var _name:String;
        private var _channel:String;
        private var _route:int;
        private var _exp:int;
        private var _crownTotal:Crown;
        private var _cycle:int;
        private var _progress:int;
        private var _chapter:int;
        private var _aPlayerPersonal:Array;
        private var _formationId:int;
        private var _aFormationData:Array;
        private var _emperorData:PlayerEmperorSkillBonus;
        private var _aSuccessiveEmperorId:Array;
        private var _aInstitution:Array;
        private var _aFormationPlayerUniqueId:Array;
        private var _aGrowthCurve:Array;
        private var _aOwnItem:Array;
        private var _kumiteResource:int;
        private var _magicResource:int;
        private var _gachaResource:int;
        private var _goldInsignia:int;
        private var _silverInsignia:int;
        private var _freeHealingNum:int;
        private var _lastFreeHealingTime:uint;
        private var _freeHealingLvUpCount:int;
        private var _freeAssaultNum:int;
        private var _lastAssaultTime:uint;
        private var _aCleatQuestId:Array;
        private var _aBarracksData:Array;
        private var _statusType:int;
        private var _aCorrelation:Array;
        private var _bNewItem:Boolean;
        private var _warriorIncrease:int;
        private var _bedIncrease:int;
        public var _aLostCharmId:Array;
        private var _bSubQuestLostPopuped:Boolean;

        public function UserDataPersonal()
        {
            this._channel = null;
            this._aPlayerPersonal = [];
            this._aInstitution = [];
            this._aSuccessiveEmperorId = [];
            this._aFormationPlayerUniqueId = [];
            this._aFormationData = [];
            this._aBarracksData = [];
            this._aCorrelation = [];
            this._aLostCharmId = [];
            this._aOwnItem = [];
            this._crownTotal = new Crown();
            this._bSubQuestLostPopuped = false;
            return;
        }// end function

        public function get userId() : int
        {
            return this._userId;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get channel() : String
        {
            return this._channel;
        }// end function

        public function setChannel(param1:String) : void
        {
            this._channel = param1;
            return;
        }// end function

        public function get route() : int
        {
            return this._route;
        }// end function

        public function setRoute(param1:int) : void
        {
            this._route = param1;
            return;
        }// end function

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function get crown() : int
        {
            return this._crownTotal.free;
        }// end function

        public function set crown(param1:int) : void
        {
            this._crownTotal.setCrownData(this._crownTotal);
            return;
        }// end function

        public function get paidCrown() : int
        {
            return this._crownTotal.paid;
        }// end function

        public function setCrownTotal(param1:Object) : void
        {
            if (param1 == null)
            {
                return;
            }
            this._crownTotal.setCrownData(param1);
            return;
        }// end function

        public function getCrownTotal() : Crown
        {
            return this._crownTotal;
        }// end function

        public function get cycle() : int
        {
            return this._cycle;
        }// end function

        public function get progress() : int
        {
            return this._progress;
        }// end function

        public function get chapter() : int
        {
            return this._chapter;
        }// end function

        public function get aPlayerPersonal() : Array
        {
            return this._aPlayerPersonal.concat();
        }// end function

        public function set aPlayerPersonal(param1:Array) : void
        {
            this._aPlayerPersonal = param1.concat();
            return;
        }// end function

        public function get formationId() : int
        {
            return this._formationId;
        }// end function

        public function set formationId(param1:int) : void
        {
            this._formationId = param1;
            return;
        }// end function

        public function get aFormationData() : Array
        {
            return this._aFormationData.concat();
        }// end function

        public function get emperorData() : PlayerEmperorSkillBonus
        {
            return this._emperorData;
        }// end function

        public function get emperorId() : int
        {
            return this._emperorData.emperorId;
        }// end function

        public function get aSuccessiveEmperorId() : Array
        {
            return this._aSuccessiveEmperorId;
        }// end function

        public function get aInstitution() : Array
        {
            return this._aInstitution;
        }// end function

        public function get aFormationPlayerUniqueId() : Array
        {
            return this._aFormationPlayerUniqueId.concat();
        }// end function

        public function get aSortiePlayerUniqueId() : Array
        {
            var _loc_3:* = 0;
            var _loc_1:* = [];
            var _loc_2:* = 0;
            var _loc_4:* = FormationSetData.FORMATION_INDEX_POSITION_1;
            while (_loc_4 <= FormationSetData.FORMATION_INDEX_POSITION_5)
            {
                
                _loc_3 = this._aFormationPlayerUniqueId[_loc_4];
                _loc_1.push(_loc_3);
                if (_loc_3)
                {
                    _loc_2++;
                }
                _loc_4++;
            }
            _loc_3 = _loc_2 >= 5 ? (this._aFormationPlayerUniqueId[FormationSetData.FORMATION_INDEX_COMMANDER]) : (Constant.EMPTY_ID);
            _loc_1.push(_loc_3);
            return _loc_1;
        }// end function

        public function get aGrowthCurve() : Array
        {
            return this._aGrowthCurve.concat();
        }// end function

        public function get aOwnItem() : Array
        {
            return this._aOwnItem.concat();
        }// end function

        public function get kumiteResource() : int
        {
            return this._kumiteResource;
        }// end function

        public function setKumiteResource(param1:int) : void
        {
            this._kumiteResource = param1;
            return;
        }// end function

        public function get magicResource() : int
        {
            return this._magicResource;
        }// end function

        public function setMagicResource(param1:int) : void
        {
            this._magicResource = param1;
            return;
        }// end function

        public function get gachaResource() : int
        {
            return this._gachaResource;
        }// end function

        public function setGachaResource(param1:int) : void
        {
            this._gachaResource = param1;
            return;
        }// end function

        public function get goldInsignia() : int
        {
            return this._goldInsignia;
        }// end function

        public function setGoldInsignia(param1:int) : void
        {
            this._goldInsignia = param1;
            return;
        }// end function

        public function get silverInsignia() : int
        {
            return this._silverInsignia;
        }// end function

        public function setSilverInsignia(param1:int) : void
        {
            this._silverInsignia = param1;
            return;
        }// end function

        public function get freeHealingNum() : int
        {
            return this._freeHealingNum;
        }// end function

        public function setFreeHealingNum(param1:int) : void
        {
            this._freeHealingNum = param1;
            return;
        }// end function

        public function get lastFreeHealingTime() : uint
        {
            return this._lastFreeHealingTime;
        }// end function

        public function setLastFreeHealingTime(param1:uint) : void
        {
            this._lastFreeHealingTime = param1;
            return;
        }// end function

        public function setFreeHealingLvUpCount(param1:int) : void
        {
            this._freeHealingLvUpCount = param1;
            return;
        }// end function

        public function get freeAssaultNum() : int
        {
            return this._freeAssaultNum;
        }// end function

        public function setFreeAssaultNum(param1:int) : void
        {
            this._freeAssaultNum = param1;
            return;
        }// end function

        public function setLastAssaultTime(param1:uint) : void
        {
            this._lastAssaultTime = param1;
            return;
        }// end function

        public function get hasFreeWholeArmyAssault() : Boolean
        {
            return false;
        }// end function

        public function clearFreeWholeArmyAssault() : void
        {
            this._freeAssaultNum = 0;
            return;
        }// end function

        public function get aCleatQuestId() : Array
        {
            return this._aCleatQuestId;
        }// end function

        public function get aBarracksData() : Array
        {
            return this._aBarracksData.concat();
        }// end function

        public function set statusType(param1:int) : void
        {
            this._statusType = param1;
            return;
        }// end function

        public function get statusType() : int
        {
            return this._statusType;
        }// end function

        public function get aCorrelation() : Array
        {
            return this._aCorrelation;
        }// end function

        public function get bNewItem() : Boolean
        {
            return this._bNewItem;
        }// end function

        public function get warriorIncrease() : int
        {
            return this._warriorIncrease;
        }// end function

        public function set warriorIncrease(param1:int) : void
        {
            this._warriorIncrease = param1;
            return;
        }// end function

        public function get bedIncrease() : int
        {
            return this._bedIncrease;
        }// end function

        public function set bedIncrease(param1:int) : void
        {
            this._bedIncrease = param1;
            return;
        }// end function

        public function get aLostCharmId() : Array
        {
            return this._aLostCharmId;
        }// end function

        public function resetLostCharmId() : void
        {
            this._aLostCharmId = [];
            return;
        }// end function

        public function addLostCharmId(param1:int) : void
        {
            this._aLostCharmId.push(param1);
            return;
        }// end function

        public function get bSubQuestLostPopuped() : Boolean
        {
            return this._bSubQuestLostPopuped;
        }// end function

        public function setSubQuestLostPopuped() : void
        {
            this._bSubQuestLostPopuped = true;
            return;
        }// end function

        public function setUserData(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            this._userId = param1.userId;
            this._name = param1.name;
            this._route = param1.route;
            this._exp = param1.exp;
            this._crownTotal.setCrownData(param1.crownData);
            this._kumiteResource = param1.kumiteResource;
            this._magicResource = param1.magicResource;
            this._gachaResource = param1.gachaResource;
            this._cycle = param1.cycle;
            this._progress = param1.progress;
            this._chapter = param1.chapter;
            this._statusType = param1.statusType;
            this._warriorIncrease = param1.warriorIncrease;
            this._bedIncrease = param1.bedIncrease;
            if (this._progress > ProgressBar.PROGRESS_MAX)
            {
                this._progress = ProgressBar.PROGRESS_MAX;
            }
            this._emperorData = new PlayerEmperorSkillBonus(param1.emperorData.uniqueId, param1.emperorData.emperorId, param1.emperorData.bonus);
            for each (_loc_2 in param1.aInstitution)
            {
                
                this.addFacility(_loc_2);
            }
            this._aCorrelation = [];
            for each (_loc_3 in param1.aCorrelation)
            {
                
                _loc_4 = PlayerManager.getInstance().getPlayerInformation(_loc_3);
                _loc_5 = new CorrelationInformation();
                _loc_5.setInfomation(_loc_4);
                this._aCorrelation.push(_loc_5);
            }
            return;
        }// end function

        public function getEmperorPlayerPersonal() : PlayerPersonal
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aPlayerPersonal)
            {
                
                if (_loc_1.isEmperor())
                {
                    return _loc_1.clone();
                }
            }
            return null;
        }// end function

        public function getPlayerPersonal(param1:int) : PlayerPersonal
        {
            var _loc_2:* = null;
            if (param1 < 0)
            {
                return null;
            }
            for each (_loc_2 in this._aPlayerPersonal)
            {
                
                if (_loc_2.uniqueId == param1)
                {
                    return _loc_2.clone();
                }
            }
            return null;
        }// end function

        public function removePlayerPersonal(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aPlayerPersonal.length)
            {
                
                _loc_3 = this._aPlayerPersonal[_loc_2];
                if (_loc_3.uniqueId == param1)
                {
                    this._aPlayerPersonal.splice(_loc_2, 1);
                    break;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function removePlayerPersonalWithClearNotice(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aPlayerPersonal.length)
            {
                
                _loc_3 = this._aPlayerPersonal[_loc_2];
                if (_loc_3.uniqueId == param1)
                {
                    this.clearUnitNotice(_loc_3);
                    this._aPlayerPersonal.splice(_loc_2, 1);
                    break;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function clearUnitNotice(param1:PlayerPersonal) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = [];
            if (param1.lastUseFacilityId == CommonConstant.FACILITY_ID_BARRACKS)
            {
                _loc_4 = Constant.EMPTY_ID;
                for each (_loc_5 in this._aBarracksData)
                {
                    
                    if (_loc_5.uniqueId == param1.uniqueId)
                    {
                        _loc_4 = _loc_5.noticeId;
                        _loc_5.setData(Constant.EMPTY_ID, 0, Constant.EMPTY_ID);
                        break;
                    }
                }
                _loc_3 = NoticeManager.getInstance().removeSimpleNoticeById(_loc_4);
                if (_loc_3)
                {
                    _loc_2.push(_loc_3);
                }
            }
            if (param1.lastUseFacilityId == CommonConstant.FACILITY_ID_TRAINING_ROOM)
            {
                if (param1.lastUseFacilitySubId == CommonConstant.FACILITY_ID_SUB_TRAINING_KUMITE)
                {
                    _loc_3 = NoticeManager.getInstance().removeSimpleNoticeByTypeTime(CommonConstant.NOTICE_FACILITY_TRAINING_KUMITE, param1.useFacilityEndTime);
                    if (_loc_3)
                    {
                        _loc_2.push(_loc_3);
                    }
                }
                if (param1.lastUseFacilitySubId == CommonConstant.FACILITY_ID_SUB_TRAINING_TRAINING)
                {
                    _loc_3 = NoticeManager.getInstance().removeSimpleNoticeByTypeTime(CommonConstant.NOTICE_FACILITY_TRAINING_TRAINING, param1.useFacilityEndTime);
                    if (_loc_3)
                    {
                        _loc_2.push(_loc_3);
                    }
                }
            }
            if (param1.lastUseFacilityId == CommonConstant.FACILITY_ID_MAGIC_DEVELOP)
            {
                _loc_3 = NoticeManager.getInstance().removeSimpleNoticeByTypeTime(CommonConstant.NOTICE_FACILITY_MAGIC_DEVELOP, param1.useFacilityEndTime);
                if (_loc_3)
                {
                    _loc_2.push(_loc_3);
                }
            }
            if (_loc_2.length > 0)
            {
                NoticeManager.getInstance().addLocalNotice(LocalNoticeInfo.LOCAL_NOTICE_EMPEROR_FACILITY_CANCEL);
                for each (_loc_3 in _loc_2)
                {
                    
                    NoticeManager.getInstance().addThroughNotice(_loc_3);
                }
            }
            return;
        }// end function

        public function checkInvalidFacilityNotice() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            var _loc_3:* = NoticeManager.getInstance().aInstitutionNotice;
            for each (_loc_2 in _loc_3)
            {
                
                if (_loc_2.type == CommonConstant.NOTICE_FACILITY_BARRACKS)
                {
                    if (this.checkBarracksUseNoticeId(_loc_2.uniqueId) == false)
                    {
                        _loc_1.push(_loc_2);
                    }
                    continue;
                }
                if (_loc_2.type == CommonConstant.NOTICE_FACILITY_TRAINING_KUMITE)
                {
                    if (this.checkUseFacilityPlayer(CommonConstant.FACILITY_ID_TRAINING_ROOM, CommonConstant.FACILITY_ID_SUB_TRAINING_KUMITE, _loc_2.epochTime) == false)
                    {
                        _loc_1.push(_loc_2);
                    }
                    continue;
                }
                if (_loc_2.type == CommonConstant.NOTICE_FACILITY_TRAINING_TRAINING)
                {
                    if (this.checkUseFacilityPlayer(CommonConstant.FACILITY_ID_TRAINING_ROOM, CommonConstant.FACILITY_ID_SUB_TRAINING_TRAINING, _loc_2.epochTime) == false)
                    {
                        _loc_1.push(_loc_2);
                    }
                    continue;
                }
                if (_loc_2.type == CommonConstant.NOTICE_FACILITY_MAGIC_DEVELOP)
                {
                    if (this.checkUseFacilityPlayer(CommonConstant.FACILITY_ID_MAGIC_DEVELOP, Constant.EMPTY_ID, _loc_2.epochTime) == false)
                    {
                        _loc_1.push(_loc_2);
                    }
                }
            }
            for each (_loc_2 in _loc_1)
            {
                
                NoticeManager.getInstance().removeSimpleNoticeById(_loc_2.uniqueId);
                NoticeManager.getInstance().addThroughNotice(_loc_2);
            }
            return;
        }// end function

        private function checkUseFacilityPlayer(param1:int, param2:int, param3:uint) : Boolean
        {
            var _loc_4:* = null;
            for each (_loc_4 in this._aPlayerPersonal)
            {
                
                if (_loc_4.lastUseFacilityId == param1)
                {
                    if (param2 != Constant.EMPTY_ID && _loc_4.lastUseFacilitySubId != param2)
                    {
                        continue;
                    }
                    if (_loc_4.useFacilityEndTime == param3)
                    {
                        return true;
                    }
                }
            }
            return false;
        }// end function

        public function addPlayerPersonal(param1:PlayerPersonal) : void
        {
            var _loc_2:* = null;
            if (param1 != null)
            {
                for each (_loc_2 in this._aPlayerPersonal)
                {
                    
                    if (param1.uniqueId == _loc_2.uniqueId)
                    {
                        _loc_2.copyParam(param1);
                        return;
                    }
                }
                this._aPlayerPersonal.push(param1);
            }
            return;
        }// end function

        public function updatePlayerPersonal(param1:Array, param2:Boolean) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            for each (_loc_3 in param1)
            {
                
                for each (_loc_4 in this._aPlayerPersonal)
                {
                    
                    if (_loc_3.uniqueId == _loc_4.uniqueId)
                    {
                        _loc_5 = _loc_4.updateStatus(_loc_3, param2);
                        if (param2)
                        {
                            this.addGrowthCurve(_loc_4.uniqueId, _loc_5);
                        }
                        break;
                    }
                }
            }
            return;
        }// end function

        public function updateCorrelation(param1:int) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(param1);
            var _loc_3:* = true;
            if (_loc_2 == null)
            {
                return;
            }
            for each (_loc_4 in this._aCorrelation)
            {
                
                if (_loc_2.characterId == _loc_4.charaId && PlayerManager.getInstance().cmpRarityValue(_loc_2.rarity, _loc_4.rarity) > 0)
                {
                    _loc_4.setInfomation(_loc_2);
                    _loc_3 = false;
                    break;
                }
            }
            if (_loc_3)
            {
                _loc_4 = new CorrelationInformation();
                _loc_4.setInfomation(_loc_2);
                this._aCorrelation.push(_loc_4);
            }
            return;
        }// end function

        public function getInstitutionInfo(param1:int) : InstitutionInfo
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aInstitution)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getCorrelationInfo(param1:int) : CorrelationInformation
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aCorrelation)
            {
                
                if (param1 == _loc_2.charaId)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getCorrelationList(param1:int) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this._aPlayerPersonal)
            {
                
                _loc_4 = PlayerManager.getInstance().getPlayerInformation(_loc_3.playerId);
                if (_loc_4.characterId == param1)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public function setProgress(param1:int) : void
        {
            if ((this._progress + 1) == param1)
            {
                this._progress = param1;
            }
            return;
        }// end function

        public function addProgress() : void
        {
            if (this._progress < ProgressBar.PROGRESS_MAX)
            {
                var _loc_1:* = this;
                var _loc_2:* = this._progress + 1;
                _loc_1._progress = _loc_2;
            }
            return;
        }// end function

        public function resetProgress() : void
        {
            this._progress = 0;
            return;
        }// end function

        public function isProgressMax() : Boolean
        {
            return this._progress >= ProgressBar.PROGRESS_MAX;
        }// end function

        public function addChapter() : void
        {
            if (this._chapter < 4)
            {
                var _loc_1:* = this;
                var _loc_2:* = this._chapter + 1;
                _loc_1._chapter = _loc_2;
            }
            else
            {
                this._chapter = 1;
            }
            return;
        }// end function

        public function resetChapter() : void
        {
            this._chapter = 1;
            return;
        }// end function

        public function addCycle() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._cycle + 1;
            _loc_1._cycle = _loc_2;
            return;
        }// end function

        public function updateExp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

        public function addFacility(param1:Object) : void
        {
            var _loc_2:* = new InstitutionInfo();
            _loc_2.setFacilityInfo(param1);
            DebugLog.print("--> InstitutionInfoId:" + _loc_2.id);
            this._aInstitution.push(_loc_2);
            return;
        }// end function

        public function setPlayerPersonal(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in param1)
            {
                
                _loc_3 = new PlayerPersonal();
                _loc_3.setParameter(_loc_2);
                this._aPlayerPersonal.push(_loc_3);
            }
            this.updateFormationBonus();
            return;
        }// end function

        public function setOwnPlayer(param1:Array) : void
        {
            var _loc_2:* = null;
            this._aPlayerPersonal = [];
            for each (_loc_2 in param1)
            {
                
                this._aPlayerPersonal.push(_loc_2.clone());
            }
            this.updateFormationBonus();
            return;
        }// end function

        public function setOwnFormation(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._aFormationData = [];
            for each (_loc_2 in param1)
            {
                
                _loc_3 = new OwnFormationData(_loc_2);
                this._aFormationData.push(_loc_3);
            }
            return;
        }// end function

        public function addOwnFormation(param1:Array) : void
        {
            var obj:Object;
            var fData:OwnFormationData;
            var aData:* = param1;
            var _loc_3:* = 0;
            var _loc_4:* = aData;
            while (_loc_4 in _loc_3)
            {
                
                obj = _loc_4[_loc_3];
                if (!this._aFormationData.some(function (param1:OwnFormationData, param2:int, param3:Array) : Boolean
            {
                return param1.formationId == obj.formationId;
            }// end function
            ))
                {
                    fData = new OwnFormationData(obj);
                    this._aFormationData.push(fData);
                }
            }
            return;
        }// end function

        public function isNewFormation() : Boolean
        {
            return this._aFormationData.some(function (param1:OwnFormationData, param2:int, param3:Array) : Boolean
            {
                return param1.bNew;
            }// end function
            );
        }// end function

        public function checkedNewFormation() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aFormationData)
            {
                
                if (_loc_1.bNew)
                {
                    _loc_1.checked();
                }
            }
            return;
        }// end function

        public function setCurrentFormation(param1:int) : void
        {
            this._formationId = param1;
            return;
        }// end function

        public function setFormationPlayer(param1:Array) : void
        {
            var _loc_3:* = 0;
            this._aFormationPlayerUniqueId = [];
            var _loc_2:* = 0;
            for each (_loc_3 in param1)
            {
                
                this._aFormationPlayerUniqueId.push(_loc_3);
            }
            return;
        }// end function

        public function setTutorialFormationPlayer() : void
        {
            var _loc_1:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_2:* = 0;
            for each (_loc_1 in this._aPlayerPersonal)
            {
                
                if (_loc_1.playerId == CommonConstant.INIT_PLAYER_ID_5)
                {
                    _loc_2++;
                }
            }
            _loc_2 = _loc_2 - 1;
            _loc_3 = [];
            _loc_4 = 0;
            while (_loc_4 < this._aPlayerPersonal.length)
            {
                
                _loc_1 = this._aPlayerPersonal[_loc_4];
                if (_loc_1.playerId == CommonConstant.INIT_PLAYER_ID_5)
                {
                    if (_loc_2 <= 0)
                    {
                        ;
                    }
                    else
                    {
                        _loc_2 = _loc_2 - 1;
                    }
                }
                _loc_3.push(_loc_1.uniqueId);
                if (_loc_3.length >= 4)
                {
                    break;
                }
                _loc_4++;
            }
            while (_loc_3.length < 5)
            {
                
                _loc_3.push(Constant.EMPTY_ID);
            }
            this.setFormationPlayer(_loc_3);
            return;
        }// end function

        public function setGrowthCurve(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._aGrowthCurve = [];
            for each (_loc_2 in param1)
            {
                
                _loc_3 = new GrowthCurveData(_loc_2.uniqueId, _loc_2.aGrowth);
                this._aGrowthCurve.push(_loc_3);
            }
            return;
        }// end function

        private function addGrowthCurve(param1:int, param2:int) : void
        {
            var _loc_3:* = null;
            for each (_loc_3 in this._aGrowthCurve)
            {
                
                if (_loc_3.uniqueId == param1)
                {
                    _loc_3.addGrowth(param2);
                    return;
                }
            }
            this._aGrowthCurve.push(new GrowthCurveData(param1, [param2]));
            return;
        }// end function

        public function removeGrowthCurve(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aGrowthCurve.length)
            {
                
                _loc_3 = this._aGrowthCurve[_loc_2];
                if (_loc_3.uniqueId == param1)
                {
                    this._aGrowthCurve.splice(_loc_2, 1);
                    break;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function setOwnEquipItem(param1:Array) : void
        {
            var o:Object;
            var b:Boolean;
            var data:OwnItemData;
            var aEquipItem:* = param1;
            var _loc_3:* = 0;
            var _loc_4:* = aEquipItem;
            while (_loc_4 in _loc_3)
            {
                
                o = _loc_4[_loc_3];
                b = this._aOwnItem.some(function (param1:OwnItemData, param2:int, param3:Array) : Boolean
            {
                if (param1.itemCategory == CommonConstant.ITEM_KIND_ACCESSORIES && param1.itemId == o.itemId)
                {
                    param1.setNum(o.num);
                    return true;
                }
                return false;
            }// end function
            );
                if (!b)
                {
                    data = new OwnItemData(o.itemId, CommonConstant.ITEM_KIND_ACCESSORIES, o.num);
                    this._aOwnItem.push(data);
                }
            }
            return;
        }// end function

        public function addOwnEquipItem(param1:int, param2:int) : void
        {
            var data:OwnItemData;
            var itemId:* = param1;
            var num:* = param2;
            if (itemId == Constant.EMPTY_ID)
            {
                return;
            }
            var b:* = this._aOwnItem.some(function (param1:OwnItemData, param2:int, param3:Array) : Boolean
            {
                if (param1.itemCategory == CommonConstant.ITEM_KIND_ACCESSORIES && param1.itemId == itemId)
                {
                    param1.setNum(param1.num + num);
                    return true;
                }
                return false;
            }// end function
            );
            if (!b && num > 0)
            {
                data = new OwnItemData(itemId, CommonConstant.ITEM_KIND_ACCESSORIES, num);
                this._aOwnItem.push(data);
            }
            return;
        }// end function

        public function subOwnEquipItem(param1:uint, param2:int) : void
        {
            var _loc_3:* = null;
            for each (_loc_3 in this._aOwnItem)
            {
                
                if (_loc_3.itemCategory == CommonConstant.ITEM_KIND_ACCESSORIES && _loc_3.itemId == param1)
                {
                    _loc_3.setNum(_loc_3.num - param2);
                    break;
                }
            }
            return;
        }// end function

        public function getEquipItemNum(param1:uint) : int
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_2:* = 0;
            for each (_loc_3 in this._aPlayerPersonal)
            {
                
                for each (_loc_4 in _loc_3.aSetItemId)
                {
                    
                    if (_loc_4 == param1)
                    {
                        _loc_2++;
                    }
                }
            }
            return _loc_2;
        }// end function

        public function getEquipItemCount(param1:uint) : int
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aOwnItem)
            {
                
                if (_loc_2.itemId == param1)
                {
                    return _loc_2.num;
                }
            }
            return 0;
        }// end function

        public function getEquipItemTotalNum() : int
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            for each (_loc_2 in this._aOwnItem)
            {
                
                if (_loc_2.itemCategory == CommonConstant.ITEM_KIND_ACCESSORIES)
                {
                    _loc_1 = _loc_1 + _loc_2.num;
                }
            }
            return _loc_1;
        }// end function

        public function setOwnDestinyStone(param1:Array) : void
        {
            var o:Object;
            var b:Boolean;
            var data:OwnItemData;
            var aDestinyStone:* = param1;
            var _loc_3:* = 0;
            var _loc_4:* = aDestinyStone;
            while (_loc_4 in _loc_3)
            {
                
                o = _loc_4[_loc_3];
                b = this._aOwnItem.some(function (param1:OwnItemData, param2:int, param3:Array) : Boolean
            {
                if (param1.itemCategory == CommonConstant.ITEM_KIND_DESTINY_STONE && param1.itemId == o.materialId)
                {
                    param1.setNum(o.num);
                    return true;
                }
                return false;
            }// end function
            );
                if (!b)
                {
                    data = new OwnItemData(o.materialId, CommonConstant.ITEM_KIND_DESTINY_STONE, o.num);
                    this._aOwnItem.push(data);
                }
            }
            return;
        }// end function

        public function addOwnDestinyStoneNum(param1:int, param2:int) : void
        {
            var data:OwnItemData;
            var destinyStoneId:* = param1;
            var num:* = param2;
            if (destinyStoneId == Constant.EMPTY_ID)
            {
                return;
            }
            var b:* = this._aOwnItem.some(function (param1:OwnItemData, param2:int, param3:Array) : Boolean
            {
                if (param1.itemCategory == CommonConstant.ITEM_KIND_DESTINY_STONE && param1.itemId == destinyStoneId)
                {
                    param1.setNum(param1.num + num);
                    return true;
                }
                return false;
            }// end function
            );
            if (!b && num > 0)
            {
                data = new OwnItemData(destinyStoneId, CommonConstant.ITEM_KIND_DESTINY_STONE, num);
                this._aOwnItem.push(data);
            }
            return;
        }// end function

        public function updateOwnDestinyStone(param1:int, param2:int) : void
        {
            var data:OwnItemData;
            var destinyStoneId:* = param1;
            var num:* = param2;
            var b:* = this._aOwnItem.some(function (param1:OwnItemData, param2:int, param3:Array) : Boolean
            {
                if (param1.itemCategory == CommonConstant.ITEM_KIND_DESTINY_STONE && param1.itemId == destinyStoneId)
                {
                    param1.setNum(num);
                    return true;
                }
                return false;
            }// end function
            );
            if (!b && num > 0)
            {
                data = new OwnItemData(destinyStoneId, CommonConstant.ITEM_KIND_DESTINY_STONE, num);
                this._aOwnItem.push(data);
            }
            return;
        }// end function

        public function getOwnDestinyStoneNum(param1:int) : int
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aOwnItem)
            {
                
                if (_loc_2.itemCategory == CommonConstant.ITEM_KIND_DESTINY_STONE && _loc_2.itemId == param1)
                {
                    return _loc_2.num;
                }
            }
            return 0;
        }// end function

        public function setOwnPaymentItem(param1:Array) : void
        {
            var o:Object;
            var b:Boolean;
            var data:OwnItemData;
            var aPaymentItem:* = param1;
            var _loc_3:* = 0;
            var _loc_4:* = aPaymentItem;
            while (_loc_4 in _loc_3)
            {
                
                o = _loc_4[_loc_3];
                b = this._aOwnItem.some(function (param1:OwnItemData, param2:int, param3:Array) : Boolean
            {
                if (param1.itemCategory == CommonConstant.ITEM_KIND_PAYMENT_ITEM && param1.itemId == o.paymentItemId)
                {
                    param1.setNum(o.num);
                    return true;
                }
                return false;
            }// end function
            );
                if (!b)
                {
                    data = new OwnItemData(o.paymentItemId, CommonConstant.ITEM_KIND_PAYMENT_ITEM, o.num);
                    this._aOwnItem.push(data);
                }
            }
            return;
        }// end function

        public function addOwnPaymentItemNum(param1:int, param2:int) : void
        {
            var data:OwnItemData;
            var paymentItemId:* = param1;
            var num:* = param2;
            if (paymentItemId == Constant.EMPTY_ID)
            {
                return;
            }
            var b:* = this._aOwnItem.some(function (param1:OwnItemData, param2:int, param3:Array) : Boolean
            {
                if (param1.itemCategory == CommonConstant.ITEM_KIND_PAYMENT_ITEM && param1.itemId == paymentItemId)
                {
                    param1.setNum(param1.num + num);
                    return true;
                }
                return false;
            }// end function
            );
            if (!b && num > 0)
            {
                data = new OwnItemData(paymentItemId, CommonConstant.ITEM_KIND_PAYMENT_ITEM, num);
                this._aOwnItem.push(data);
            }
            return;
        }// end function

        public function getOwnPaymentItemNum(param1:int) : int
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aOwnItem)
            {
                
                if (_loc_2.itemCategory == CommonConstant.ITEM_KIND_PAYMENT_ITEM && _loc_2.itemId == param1)
                {
                    return _loc_2.num;
                }
            }
            return 0;
        }// end function

        public function subUseItem(param1:Array) : void
        {
            var _loc_2:* = 0;
            for each (_loc_2 in param1)
            {
                
                if (_loc_2 != Constant.EMPTY_ID)
                {
                    this.addLostCharmId(_loc_2);
                    this.addOwnPaymentItemNum(_loc_2, -1);
                }
            }
            return;
        }// end function

        public function addOwnAssetNum(param1:int, param2:int) : void
        {
            if (param1 == Constant.EMPTY_ID)
            {
                return;
            }
            switch(param1)
            {
                case AssetId.ASSET_MAGIC_DEVELOP:
                {
                    this.setMagicResource(this._magicResource + param2);
                    break;
                }
                case AssetId.ASSET_TRAINING:
                {
                    this.setKumiteResource(this._kumiteResource + param2);
                    break;
                }
                case AssetId.ASSET_GACHA_POINT:
                {
                    this.setGachaResource(this._gachaResource + param2);
                    break;
                }
                case AssetId.ASSET_GOLD_INSIGNIA:
                {
                    this.setGoldInsignia(this._goldInsignia + param2);
                    break;
                }
                case AssetId.ASSET_SILVER_INSIGNIA:
                {
                    this.setSilverInsignia(this._silverInsignia + param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getOwnAssetNum(param1:int) : int
        {
            switch(param1)
            {
                case AssetId.ASSET_MAGIC_DEVELOP:
                {
                    return this._magicResource;
                }
                case AssetId.ASSET_TRAINING:
                {
                    return this._kumiteResource;
                }
                case AssetId.ASSET_GACHA_POINT:
                {
                    return this._gachaResource;
                }
                case AssetId.ASSET_GOLD_INSIGNIA:
                {
                    return this._goldInsignia;
                }
                case AssetId.ASSET_SILVER_INSIGNIA:
                {
                    return this._silverInsignia;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        public function getOwnItemNum(param1:int, param2:int) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            switch(param1)
            {
                case CommonConstant.ITEM_KIND_CROWN:
                {
                    return this.getCrownTotal().total;
                }
                case CommonConstant.ITEM_KIND_ACCESSORIES:
                {
                    return this.getEquipItemCount(param2);
                }
                case CommonConstant.ITEM_KIND_PAYMENT_ITEM:
                {
                    return this.getOwnPaymentItemNum(param2);
                }
                case CommonConstant.ITEM_KIND_DESTINY_STONE:
                {
                    return this.getOwnDestinyStoneNum(param2);
                }
                case CommonConstant.ITEM_KIND_WARRIOR:
                {
                    _loc_3 = 0;
                    for each (_loc_4 in this._aPlayerPersonal)
                    {
                        
                        if (_loc_4.playerId == param2)
                        {
                            _loc_3++;
                        }
                    }
                    return _loc_3;
                }
                case CommonConstant.ITEM_KIND_ASSET:
                {
                    return this.getOwnAssetNum(param2);
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        public function setGetItemInfo(param1:Object) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_2:* = GetItemInfo.aItemData(param1);
            var _loc_3:* = GetItemInfo.aPlayer(param1);
            var _loc_4:* = GetItemInfo.aWarehouseData(param1);
            if (_loc_2)
            {
                for each (_loc_5 in _loc_2)
                {
                    
                    switch(_loc_5.category)
                    {
                        case CommonConstant.ITEM_KIND_CROWN:
                        {
                            _loc_6 = UserDataManager.getInstance().userData.getCrownTotal();
                            _loc_7 = new Object();
                            _loc_8 = {};
                            _loc_7.free = _loc_6.free + _loc_5.num;
                            _loc_7.paid = _loc_6.paid;
                            _loc_8.crownData = _loc_7;
                            this.setCrownTotal(_loc_8.crownData);
                            break;
                        }
                        case CommonConstant.ITEM_KIND_ACCESSORIES:
                        {
                            this.addOwnEquipItem(_loc_5.itemId, _loc_5.num);
                            break;
                        }
                        case CommonConstant.ITEM_KIND_PAYMENT_ITEM:
                        {
                            this.addOwnPaymentItemNum(_loc_5.itemId, _loc_5.num);
                            break;
                        }
                        case CommonConstant.ITEM_KIND_DESTINY_STONE:
                        {
                            this.addOwnDestinyStoneNum(_loc_5.itemId, _loc_5.num);
                            break;
                        }
                        case CommonConstant.ITEM_KIND_WARRIOR:
                        {
                            break;
                        }
                        case CommonConstant.ITEM_KIND_ASSET:
                        {
                            this.addOwnAssetNum(_loc_5.itemId, _loc_5.num);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            if (_loc_3)
            {
                this.setPlayerPersonal(_loc_3);
                for each (_loc_9 in _loc_3)
                {
                    
                    this.updateCorrelation(_loc_9.playerId);
                }
            }
            if (_loc_4)
            {
                _loc_10 = GetItemInfo.getWarehouseEntryNum(param1, GetItemInfo.WAREHOUSE_ITEM_FLAG_LIMIT);
                _loc_11 = GetItemInfo.getWarehouseEntryNum(param1, GetItemInfo.WAREHOUSE_ITEM_FLAG_TERMLESS);
                StorageManager.getInstance().setGiftCount(StorageManager.getInstance().warehouseGiftCount() + _loc_4.length);
            }
            Main.GetProcess().topBar.update();
            return;
        }// end function

        public function getOwnItem(param1:int) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this._aOwnItem)
            {
                
                if (_loc_3.itemCategory == param1)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public function setClearQuestId(param1:Array) : void
        {
            var _loc_2:* = 0;
            this._aCleatQuestId = [];
            for each (_loc_2 in param1)
            {
                
                this._aCleatQuestId.push(_loc_2);
            }
            return;
        }// end function

        public function addClearQuestId(param1:int) : void
        {
            ArrayUtil.uniquePushId(this._aCleatQuestId, param1);
            return;
        }// end function

        public function setBarracksData(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._aBarracksData = [];
            var _loc_2:* = 0;
            for each (_loc_3 in param1)
            {
                
                _loc_4 = new BarracksData(_loc_3.uniqueId, _loc_2, _loc_3.restoreTime, _loc_3.noticeId);
                this._aBarracksData.push(_loc_4);
                _loc_2++;
            }
            return;
        }// end function

        public function resetBarracksData(param1:int, param2:int, param3:uint, param4:int) : void
        {
            var _loc_5:* = null;
            for each (_loc_5 in this._aBarracksData)
            {
                
                if (_loc_5.index == param1)
                {
                    _loc_5.setData(param2, param3, param4);
                    break;
                }
            }
            return;
        }// end function

        public function resetPlayerRestoreTime(param1:int, param2:int, param3:uint, param4:uint) : void
        {
            var _loc_5:* = null;
            for each (_loc_5 in this._aPlayerPersonal)
            {
                
                if (_loc_5.uniqueId == param1)
                {
                    _loc_5.setRestoreTime(param2, param3, param4, _loc_5.spMax);
                }
            }
            return;
        }// end function

        public function checkBarracksUse() : Boolean
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aBarracksData)
            {
                
                if (_loc_1.uniqueId)
                {
                    return true;
                }
            }
            return false;
        }// end function

        private function checkBarracksUseNoticeId(param1:int) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBarracksData)
            {
                
                if (_loc_2.uniqueId && _loc_2.noticeId == param1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function getFormationSetData() : FormationSetData
        {
            return new FormationSetData(this._formationId, this._aFormationPlayerUniqueId);
        }// end function

        public function setbNewItem(param1:Boolean) : void
        {
            this._bNewItem = param1;
            return;
        }// end function

        public function updateFormationBonus() : void
        {
            FormationBonusUtility.updateFormationBonus(this._formationId, this._aFormationPlayerUniqueId, this._aPlayerPersonal);
            CommanderSkillUtility.updateCommanderSkillBonus(this._aFormationPlayerUniqueId, this._aPlayerPersonal);
            return;
        }// end function

        public function setEmperorData(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = null;
            this._emperorData.uniqueId = param1;
            this._emperorData.emperorId = param2;
            this._emperorData.bonus = param3;
            for each (_loc_4 in this._aPlayerPersonal)
            {
                
                _loc_4.updateEmperorBonus();
            }
            return;
        }// end function

        public function setSuccessiveEmperor(param1:Array) : void
        {
            var _loc_2:* = 0;
            this._aSuccessiveEmperorId = [];
            for each (_loc_2 in param1)
            {
                
                this._aSuccessiveEmperorId.push(_loc_2);
            }
            return;
        }// end function

        public function getOwnFormationNum() : int
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = new Object();
            for each (_loc_3 in this._aFormationData)
            {
                
                _loc_4 = FormationManager.getInstance().getFormationInformation(_loc_3.formationId);
                if (_loc_4 && _loc_2[_loc_4.name] == null)
                {
                    _loc_1++;
                    _loc_2[_loc_4.name] = true;
                }
            }
            return _loc_1;
        }// end function

        private function getFreeWholeArmyAssaultTime() : uint
        {
            return 0;
        }// end function

        public function getNextFreeWholeArmyAssaultTime() : uint
        {
            return 0;
        }// end function

        private function getFreeHealingTime() : uint
        {
            return TimeClock.getResetTime2(CommonConstant.FREE_HEALING_UPDATE_TIME_1, CommonConstant.FREE_HEALING_UPDATE_TIME_2);
        }// end function

        public function getNextFreeHealingTime() : uint
        {
            return TimeClock.getResetTimeNext2(CommonConstant.FREE_HEALING_UPDATE_TIME_1, CommonConstant.FREE_HEALING_UPDATE_TIME_2);
        }// end function

        public function advanceLastFreeHealingTime(param1:int) : void
        {
            var _loc_6:* = 0;
            var _loc_2:* = CommonConstant.FREE_HEALING_MAX_NUM / CommonConstant.FREE_HEALING_ADD_NUM;
            if (param1 > _loc_2)
            {
                param1 = _loc_2;
            }
            var _loc_3:* = TimeClock.getNearCycleTime2(CommonConstant.FREE_HEALING_UPDATE_TIME_1, CommonConstant.FREE_HEALING_UPDATE_TIME_2);
            var _loc_4:* = TimeClock.getNowTime();
            var _loc_5:* = _loc_3.length - 1;
            while (_loc_5 >= 0)
            {
                
                _loc_6 = _loc_3[_loc_5];
                if (this._lastFreeHealingTime < _loc_6)
                {
                    if (param1 > 0)
                    {
                        this._lastFreeHealingTime = _loc_6;
                        param1 = param1 - 1;
                    }
                    else
                    {
                        break;
                    }
                }
                _loc_5 = _loc_5 - 1;
            }
            return;
        }// end function

        private function calcTimeFreeHealingAddNum() : int
        {
            var _loc_4:* = 0;
            var _loc_1:* = TimeClock.getNearCycleTime2(CommonConstant.FREE_HEALING_UPDATE_TIME_1, CommonConstant.FREE_HEALING_UPDATE_TIME_2);
            var _loc_2:* = TimeClock.getNowTime();
            var _loc_3:* = 0;
            for each (_loc_4 in _loc_1)
            {
                
                if (this._lastFreeHealingTime < _loc_4 && _loc_4 <= _loc_2)
                {
                    _loc_3++;
                }
            }
            return this.clampFreeHealingNum(CommonConstant.FREE_HEALING_ADD_NUM * _loc_3);
        }// end function

        private function calcLvUpFreeHealingAddNum() : int
        {
            return this.clampFreeHealingNum(CommonConstant.FREE_HEALING_ADD_NUM * this._freeHealingLvUpCount);
        }// end function

        private function clampFreeHealingNum(param1:int) : int
        {
            if (param1 > CommonConstant.FREE_HEALING_MAX_NUM)
            {
                param1 = CommonConstant.FREE_HEALING_MAX_NUM;
            }
            return param1;
        }// end function

        public function checkFreeWholeArmyAssault() : Boolean
        {
            return false;
        }// end function

        public function checkTimeFreeHealing() : Boolean
        {
            return this.calcTimeFreeHealingAddNum() > 0;
        }// end function

        public function checkLvUpFreeHealing() : Boolean
        {
            return this.calcLvUpFreeHealingAddNum() > 0;
        }// end function

        public function updateFreeWholeArmyAssault() : int
        {
            return 0;
        }// end function

        public function updateTimeFreeHealing() : int
        {
            var _loc_1:* = 0;
            if (this.checkTimeFreeHealing())
            {
                _loc_1 = this.calcTimeFreeHealingAddNum();
                this._freeHealingNum = this.clampFreeHealingNum(this._freeHealingNum + _loc_1);
                this._lastFreeHealingTime = TimeClock.getNowTime();
                return _loc_1;
            }
            return 0;
        }// end function

        public function updateLvUpFreeHealing() : int
        {
            var _loc_1:* = 0;
            if (this.checkLvUpFreeHealing())
            {
                _loc_1 = this.calcLvUpFreeHealingAddNum();
                this._freeHealingNum = this.clampFreeHealingNum(this._freeHealingNum + _loc_1);
                this._freeHealingLvUpCount = 0;
                return _loc_1;
            }
            return 0;
        }// end function

    }
}
