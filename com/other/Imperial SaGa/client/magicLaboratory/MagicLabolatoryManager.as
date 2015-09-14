package magicLaboratory
{
    import skill.*;
    import tutorial.*;
    import utility.*;

    public class MagicLabolatoryManager extends Object
    {
        private var _aDevelopSkillId:Array;
        private var _aImpossibleSkillId:Array;
        private var _aLearningSkillId:Array;
        private var _aUpgradeData:Array;
        private var _developCompleteTime:uint;
        private var _aLearningData:Array;
        private var _developCount:int;
        private static var instance:MagicLabolatoryManager;

        public function MagicLabolatoryManager(param1:Blocker)
        {
            this._aDevelopSkillId = [];
            this._aImpossibleSkillId = [];
            this._aLearningSkillId = [];
            this._aUpgradeData = [];
            this._developCompleteTime = 0;
            this._aLearningData = [];
            this._developCount = 0;
            return;
        }// end function

        public function get aDevelopSkillId() : Array
        {
            return this._aDevelopSkillId;
        }// end function

        public function get aImpossibleSkillId() : Array
        {
            return this._aImpossibleSkillId;
        }// end function

        public function get aLearningSkillId() : Array
        {
            return this._aLearningSkillId;
        }// end function

        public function get bDevelopable() : Boolean
        {
            return this._aDevelopSkillId.length > 0;
        }// end function

        public function get developCompleteTime() : uint
        {
            return this._developCompleteTime;
        }// end function

        public function set developCompleteTime(param1:uint) : void
        {
            this._developCompleteTime = param1;
            return;
        }// end function

        public function get aLearningData() : Array
        {
            return this._aLearningData;
        }// end function

        public function get developCount() : int
        {
            return this._developCount;
        }// end function

        public function setDevelopCount(param1:int) : void
        {
            this._developCount = param1;
            return;
        }// end function

        public function setData(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param1.hasOwnProperty("aDevelopSkillId"))
            {
                this._aDevelopSkillId = param1.aDevelopSkillId as Array;
            }
            if (param1.hasOwnProperty("aImpossibleSkillId"))
            {
                this._aImpossibleSkillId = param1.aImpossibleSkillId as Array;
            }
            if (param1.hasOwnProperty("aLearningSkillId"))
            {
                this._aLearningSkillId = [];
                _loc_2 = param1.aLearningSkillId as Array;
                for each (_loc_3 in _loc_2)
                {
                    
                    this._aLearningSkillId.push(_loc_3);
                }
            }
            if (param1.hasOwnProperty("aLearningData"))
            {
                this._aLearningData = [];
                _loc_2 = param1.aLearningData as Array;
                for each (_loc_4 in _loc_2)
                {
                    
                    _loc_5 = new MagicLearningData();
                    _loc_5.setObject(_loc_4);
                    this._aLearningData.push(_loc_5);
                }
            }
            if (param1.hasOwnProperty("developCount"))
            {
                this._developCount = param1.developCount;
            }
            return;
        }// end function

        public function isDeveloping() : Boolean
        {
            return this._developCompleteTime != 0;
        }// end function

        public function getDevelopWaitTime() : uint
        {
            var _loc_4:* = 0;
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_3))
            {
                _loc_4 = MagicLabolatoryManager.getInstance().developCount;
                if (_loc_4 > 0)
                {
                    _loc_4 = _loc_4 - 1;
                }
                return MagicLearnUtility.getDevelopSecond(_loc_4);
            }
            var _loc_1:* = this._developCompleteTime;
            var _loc_2:* = TimeClock.getNowTime();
            var _loc_3:* = _loc_1 > _loc_2 ? (_loc_1 - _loc_2) : (0);
            return _loc_3;
        }// end function

        public function isDevelopTimeOut() : Boolean
        {
            return this.getDevelopWaitTime() <= 0;
        }// end function

        public function skillDeveloped(param1:int) : Boolean
        {
            if (this._aDevelopSkillId.indexOf(param1) != -1)
            {
                this._aDevelopSkillId.splice(this._aDevelopSkillId.indexOf(param1), 1);
                this._aLearningSkillId.push(param1);
                return true;
            }
            return false;
        }// end function

        public function isLearning(param1:MagicLearningData) : Boolean
        {
            return param1.endTime != 0;
        }// end function

        public function getLearningWaitTime(param1:MagicLearningData) : uint
        {
            var _loc_5:* = null;
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_4))
            {
                _loc_5 = SkillManager.getInstance().getSkillInformation(param1.skillId);
                return MagicLearnUtility.getLearnSecond(_loc_5);
            }
            var _loc_2:* = param1.endTime;
            var _loc_3:* = TimeClock.getNowTime();
            var _loc_4:* = _loc_2 > _loc_3 ? (_loc_2 - _loc_3) : (0);
            return _loc_2 > _loc_3 ? (_loc_2 - _loc_3) : (0);
        }// end function

        public function isLearningTimeOut(param1:MagicLearningData) : Boolean
        {
            return this.getLearningWaitTime(param1) <= 0;
        }// end function

        public function getSelectedLearningData() : MagicLearningData
        {
            var _loc_1:* = Constant.UNDECIDED;
            var _loc_2:* = MagicLearnUtility.getLearnCount();
            var _loc_3:* = 0;
            while (_loc_3 < this._aLearningData.length)
            {
                
                if (_loc_3 >= _loc_2)
                {
                    break;
                }
                if (_loc_1 == Constant.UNDECIDED && this._aLearningData[_loc_3].noticeId == Constant.EMPTY_ID)
                {
                    _loc_1 = _loc_3;
                }
                _loc_3++;
            }
            if (_loc_1 == Constant.UNDECIDED && this._aLearningData.length < _loc_2)
            {
                _loc_1 = this._aLearningData.length;
            }
            return this.getLearningData(_loc_1);
        }// end function

        public function getLearningData(param1:int) : MagicLearningData
        {
            if (param1 < 0 || param1 >= this._aLearningData.length)
            {
                if (param1 >= 0 && param1 < MagicLearnUtility.getLearnCount())
                {
                    this._aLearningData[param1] = new MagicLearningData();
                    return this._aLearningData[param1];
                }
                return null;
            }
            return this._aLearningData[param1];
        }// end function

        public function getIndex(param1:MagicLearningData) : int
        {
            return this._aLearningData.indexOf(param1);
        }// end function

        public function checkFastFinishAlert() : int
        {
            var _loc_2:* = null;
            var _loc_1:* = Constant.UNDECIDED;
            for each (_loc_2 in this._aLearningData)
            {
                
                if (_loc_2.bFastFinish)
                {
                    _loc_2.checkFastFinish();
                    if (_loc_1 == Constant.UNDECIDED)
                    {
                        _loc_1 = this._aLearningData.indexOf(_loc_2);
                    }
                }
            }
            return _loc_1;
        }// end function

        public function checkFinishAlert() : int
        {
            var _loc_2:* = null;
            var _loc_1:* = Constant.UNDECIDED;
            for each (_loc_2 in this._aLearningData)
            {
                
                if (_loc_2.bFinish)
                {
                    if (_loc_1 == Constant.UNDECIDED)
                    {
                        _loc_1 = this._aLearningData.indexOf(_loc_2);
                    }
                }
            }
            return _loc_1;
        }// end function

        public static function getInstance() : MagicLabolatoryManager
        {
            if (instance == null)
            {
                instance = new MagicLabolatoryManager(new Blocker());
            }
            return instance;
        }// end function

    }
}

import skill.*;

import tutorial.*;

import utility.*;

class Blocker extends Object
{

    function Blocker()
    {
        return;
    }// end function

}

