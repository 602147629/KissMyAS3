package user
{
    import player.*;
    import resource.*;

    public class UserDataManager extends Object
    {
        private var _userData:UserDataPersonal;
        private var _loader:XmlLoader;
        private var _aEmperorLv:Array;
        private var _bCreated:Boolean;
        private static var _inscance:UserDataManager = null;

        public function UserDataManager(param1:Blocker)
        {
            this._userData = new UserDataPersonal();
            this._aEmperorLv = [];
            return;
        }// end function

        public function get userData() : UserDataPersonal
        {
            return this._userData;
        }// end function

        public function get bCreated() : Boolean
        {
            return this._bCreated;
        }// end function

        public function loadData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "EmperorParameter.xml", this.cbLoadComplete, false);
            return;
        }// end function

        public function isLoaded() : Boolean
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
            for each (_loc_2 in param1.EmperorLv.Data)
            {
                
                _loc_3 = new EmperorLv();
                _loc_3.setXml(_loc_2);
                this._aEmperorLv.push(_loc_3);
            }
            this._loader.release();
            this._loader = null;
            this._bCreated = true;
            return;
        }// end function

        public function getEmperorLv(param1:int = -1) : int
        {
            var _loc_3:* = null;
            var _loc_2:* = 1;
            if (param1 == Constant.UNDECIDED)
            {
                param1 = this._userData.exp;
            }
            for each (_loc_3 in this._aEmperorLv)
            {
                
                if (_loc_3.totalExp > param1)
                {
                    break;
                }
                _loc_2 = _loc_3.lv;
            }
            return _loc_2;
        }// end function

        public function getNextExp() : uint
        {
            var _loc_3:* = null;
            var _loc_1:* = this.getEmperorLv();
            var _loc_2:* = 0;
            if (_loc_1 < this._aEmperorLv.length)
            {
                _loc_3 = this._aEmperorLv[_loc_1];
            }
            else
            {
                _loc_3 = this._aEmperorLv[(this._aEmperorLv.length - 1)];
            }
            _loc_2 = _loc_3.totalExp;
            return _loc_2;
        }// end function

        public function getReserveMax() : int
        {
            var _loc_3:* = null;
            var _loc_1:* = 1;
            var _loc_2:* = 0;
            for each (_loc_3 in this._aEmperorLv)
            {
                
                if (_loc_3.totalExp > this._userData.exp)
                {
                    break;
                }
                _loc_1 = _loc_3.lv;
                _loc_2 = _loc_3.reserveMax;
            }
            return _loc_2;
        }// end function

        public function getCurrentPlayerCap() : int
        {
            var _loc_1:* = this.getReserveMax() + this._userData.warriorIncrease;
            var _loc_2:* = _loc_1 - this.getCurrentPlayerNum();
            return _loc_2 < 0 ? (0) : (_loc_2);
        }// end function

        public function getCurrentPlayerNum() : int
        {
            return (this._userData.aPlayerPersonal.length - 1);
        }// end function

        public function checkWarriorExtendable() : Boolean
        {
            return this._userData.warriorIncrease + CommonConstant.TRADING_POST_ADD_WARRIOR_COUNT <= CommonConstant.TRADING_POST_ADD_WARRIOR_MAX;
        }// end function

        public function getCurrentBedNum() : int
        {
            return this._userData.bedIncrease + CommonConstant.BARRACKS_BED_INIT_NUM;
        }// end function

        public function checkBedExtendable() : Boolean
        {
            return this._userData.bedIncrease + CommonConstant.BARRACKS_BED_INIT_NUM + CommonConstant.BARRACKS_ADD_BED_COUNT <= CommonConstant.BARRACKS_BED_MAX_NUM;
        }// end function

        public function updateSp() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._userData.aPlayerPersonal)
            {
                
                _loc_1.updateSp();
            }
            return;
        }// end function

        public function tutorialEndPlayerSpReset() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._userData.aPlayerPersonal)
            {
                
                _loc_1.recoverySp();
            }
            return;
        }// end function

        public function isPlayerFullHp() : Boolean
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._userData.aPlayerPersonal)
            {
                
                if (_loc_1.isFullHp() == false)
                {
                    return false;
                }
            }
            return true;
        }// end function

        public function isUnlockFacility(param1:int) : Boolean
        {
            var eLv:EmperorLv;
            var facilityId:* = param1;
            var _loc_3:* = 0;
            var _loc_4:* = this._aEmperorLv;
            while (_loc_4 in _loc_3)
            {
                
                eLv = _loc_4[_loc_3];
                if (eLv.totalExp > this._userData.exp)
                {
                    break;
                }
                if (eLv.aUnlockData && eLv.aUnlockData.some(function (param1:EmperorLvUnlockData, param2:int, param3:Array) : Boolean
            {
                return param1.type == EmperorLvUnlockData.UNLOCK_TYPE_FACILITY && param1.id == facilityId;
            }// end function
            ))
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function getUnlockFacilityEmperorLv(param1:int) : int
        {
            var eLv:EmperorLv;
            var facilityId:* = param1;
            var _loc_3:* = 0;
            var _loc_4:* = this._aEmperorLv;
            while (_loc_4 in _loc_3)
            {
                
                eLv = _loc_4[_loc_3];
                if (eLv.aUnlockData && eLv.aUnlockData.some(function (param1:EmperorLvUnlockData, param2:int, param3:Array) : Boolean
            {
                return param1.type == EmperorLvUnlockData.UNLOCK_TYPE_FACILITY && param1.id == facilityId;
            }// end function
            ))
                {
                    return eLv.lv;
                }
            }
            return 0;
        }// end function

        public function isUnlockCommanderSkill() : Boolean
        {
            return this.isUnlockFacility(EmperorLvUnlockData.UNLOCK_ID_COMMANDER_SKILL);
        }// end function

        public function getUnlockFacilityIdArray(param1:int, param2:int = 0) : Array
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = [];
            if (param2 == 0)
            {
                param2 = this.getEmperorLv();
            }
            for each (_loc_4 in this._aEmperorLv)
            {
                
                if (param2 < _loc_4.lv)
                {
                    break;
                }
                if (param1 >= _loc_4.lv)
                {
                    continue;
                }
                for each (_loc_5 in _loc_4.aUnlockData)
                {
                    
                    if (_loc_5.type == EmperorLvUnlockData.UNLOCK_TYPE_FACILITY)
                    {
                        _loc_3.push(_loc_5.id);
                    }
                }
            }
            return _loc_3;
        }// end function

        public function getUnlockFormationIdArray(param1:int, param2:int = 0) : Array
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = [];
            if (param2 == 0)
            {
                param2 = this.getEmperorLv();
            }
            for each (_loc_4 in this._aEmperorLv)
            {
                
                if (param2 < _loc_4.lv)
                {
                    break;
                }
                if (param1 >= _loc_4.lv)
                {
                    continue;
                }
                for each (_loc_5 in _loc_4.aUnlockData)
                {
                    
                    if (_loc_5.type == EmperorLvUnlockData.UNLOCK_TYPE_FORMATION)
                    {
                        _loc_3.push(_loc_5.id);
                    }
                }
            }
            return _loc_3;
        }// end function

        public function getUnlockItemIdArray(param1:int, param2:int = 0) : Array
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = [];
            if (param2 == 0)
            {
                param2 = this.getEmperorLv();
            }
            for each (_loc_4 in this._aEmperorLv)
            {
                
                if (param2 < _loc_4.lv)
                {
                    break;
                }
                if (param1 >= _loc_4.lv)
                {
                    continue;
                }
                for each (_loc_5 in _loc_4.aUnlockData)
                {
                    
                    if (_loc_5.type == EmperorLvUnlockData.UNLOCK_TYPE_ITEM)
                    {
                        _loc_3.push(_loc_5.id);
                    }
                }
            }
            return _loc_3;
        }// end function

        public function getMinPlayerNum() : int
        {
            return 5;
        }// end function

        public function checkRemainPlayerNum(param1:int) : Boolean
        {
            return this._userData.aPlayerPersonal.length - param1 >= this.getMinPlayerNum();
        }// end function

        public function isPlayerLack() : Boolean
        {
            return this._userData.aPlayerPersonal.length < this.getMinPlayerNum();
        }// end function

        public function isFormationEmpty() : Boolean
        {
            var _loc_1:* = 0;
            for each (_loc_1 in this._userData.aFormationPlayerUniqueId)
            {
                
                if (_loc_1 != Constant.EMPTY_ID)
                {
                    return false;
                }
            }
            return true;
        }// end function

        public function getFormationEntryNum() : int
        {
            var _loc_2:* = 0;
            var _loc_1:* = 0;
            for each (_loc_2 in this._userData.aFormationPlayerUniqueId)
            {
                
                if (_loc_2 != Constant.EMPTY_ID)
                {
                    _loc_1++;
                }
            }
            return _loc_1;
        }// end function

        private function getFormationEntryPlayerPersonal() : Array
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._userData.aFormationPlayerUniqueId)
            {
                
                if (_loc_2 != Constant.EMPTY_ID)
                {
                    _loc_3 = this._userData.getPlayerPersonal(_loc_2);
                    if (_loc_3)
                    {
                        _loc_1.push(_loc_3);
                    }
                }
            }
            return _loc_1;
        }// end function

        public function updateFormationPlayer() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_1:* = this._userData.aFormationPlayerUniqueId;
            var _loc_2:* = [];
            for each (_loc_3 in _loc_1)
            {
                
                _loc_4 = this._userData.getPlayerPersonal(_loc_3);
                if (_loc_4 != null)
                {
                    _loc_2.push(_loc_4.uniqueId);
                    continue;
                }
                _loc_2.push(0);
            }
            this._userData.setFormationPlayer(_loc_2);
            this._userData.updateFormationBonus();
            return;
        }// end function

        public function getSortiePlayerNum() : int
        {
            var _loc_2:* = 0;
            var _loc_1:* = 0;
            for each (_loc_2 in this._userData.aSortiePlayerUniqueId)
            {
                
                if (_loc_2 != Constant.EMPTY_ID)
                {
                    _loc_1++;
                }
            }
            return _loc_1;
        }// end function

        private function getSortiePlayerPersonal() : Array
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._userData.aSortiePlayerUniqueId)
            {
                
                if (_loc_2 != Constant.EMPTY_ID)
                {
                    _loc_3 = this._userData.getPlayerPersonal(_loc_2);
                    if (_loc_3)
                    {
                        _loc_1.push(_loc_3);
                    }
                }
            }
            return _loc_1;
        }// end function

        public function isSortiePlayerGrowtEnd() : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_1:* = this.getSortiePlayerPersonal();
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = _loc_2.isLifeRunningOut() || _loc_2.isParamMax();
                if (_loc_3 == false)
                {
                    return false;
                }
            }
            return true;
        }// end function

        public function getSortiePlayerLpTargetNum() : int
        {
            var _loc_3:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = this.getSortiePlayerPersonal();
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.isEmperor() == false)
                {
                    _loc_1++;
                }
            }
            return _loc_1;
        }// end function

        public function checkSpecialEvent() : Boolean
        {
            if (this._userData.chapter == CommonConstant.ROUTE_SELECT_CHAPTER && this._userData.progress == CommonConstant.ROUTE_SELECT_PROGRESS && this._userData.route == CommonConstant.ROUTE_TYPE_NORMAL)
            {
                return true;
            }
            return false;
        }// end function

        public static function getInstance() : UserDataManager
        {
            if (!_inscance)
            {
                _inscance = new UserDataManager(new Blocker());
            }
            return _inscance;
        }// end function

    }
}

import player.*;

import resource.*;

class Blocker extends Object
{

    function Blocker()
    {
        return;
    }// end function

}

