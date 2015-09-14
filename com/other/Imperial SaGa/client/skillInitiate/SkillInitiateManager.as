package skillInitiate
{
    import player.*;
    import playerList.*;
    import user.*;

    public class SkillInitiateManager extends Object
    {
        private const _SUPPORT_LIMIT_NUM:int = 9;
        private var _studentId:int;
        private var _studentName:String;
        private var _isHaveSkill:Boolean;
        public var _studentData:ListPlayerData;
        private var _teacherId:int;
        private var _teacherName:String;
        public var _teacherData:ListPlayerData;
        private var _aSupportId:Array;
        private var _skillId:int;
        private var _bonusId:int;

        public function SkillInitiateManager()
        {
            this._aSupportId = [];
            return;
        }// end function

        public function get studentId() : int
        {
            return this._studentId;
        }// end function

        public function set studentId(param1:int) : void
        {
            this._studentId = param1;
            var _loc_2:* = UserDataManager.getInstance().userData.getPlayerPersonal(param1);
            this._studentName = _loc_2 == null ? ("") : (PlayerManager.getInstance().getPlayerInformation(_loc_2.playerId).name);
            return;
        }// end function

        public function get studentName() : String
        {
            return this._studentName;
        }// end function

        public function get isHaveSkill() : Boolean
        {
            return this._isHaveSkill;
        }// end function

        public function get studentData() : ListPlayerData
        {
            return this._studentData;
        }// end function

        public function set studentData(param1:ListPlayerData) : void
        {
            this._studentData = param1;
            return;
        }// end function

        public function get teacherId() : int
        {
            return this._teacherId;
        }// end function

        public function set teacherId(param1:int) : void
        {
            this._teacherId = param1;
            var _loc_2:* = UserDataManager.getInstance().userData.getPlayerPersonal(param1);
            this._teacherName = _loc_2 == null ? ("") : (PlayerManager.getInstance().getPlayerInformation(_loc_2.playerId).name);
            return;
        }// end function

        public function get teacherName() : String
        {
            return this._teacherName;
        }// end function

        public function get teacherData() : ListPlayerData
        {
            return this._teacherData;
        }// end function

        public function set teacherData(param1:ListPlayerData) : void
        {
            this._teacherData = param1;
            return;
        }// end function

        public function get aSupportId() : Array
        {
            return this._aSupportId;
        }// end function

        public function addSupportId(param1:int) : void
        {
            if (this._aSupportId.length < this._SUPPORT_LIMIT_NUM && this._aSupportId.indexOf(param1) == -1)
            {
                this._aSupportId.push(param1);
            }
            return;
        }// end function

        public function removeSupportId(param1:int) : void
        {
            if (this._aSupportId.indexOf(param1) != -1)
            {
                this._aSupportId.splice(this._aSupportId.indexOf(param1), 1);
            }
            return;
        }// end function

        public function resetSupportId() : void
        {
            this._aSupportId = [];
            return;
        }// end function

        public function canAddSupport() : Boolean
        {
            return this._aSupportId.length < this._SUPPORT_LIMIT_NUM && this.calcCurProbability() < 100;
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        public function set skillId(param1:int) : void
        {
            this._skillId = param1;
            var _loc_2:* = UserDataManager.getInstance().userData.getPlayerPersonal(this._studentId);
            this._isHaveSkill = _loc_2 == null ? (false) : (_loc_2.isHaveSkill(this._skillId));
            return;
        }// end function

        public function get bonusId() : int
        {
            return this._bonusId;
        }// end function

        public function set bonusId(param1:int) : void
        {
            this._bonusId = param1;
            return;
        }// end function

        public function get aSelectedId() : Array
        {
            var _loc_1:* = [];
            if (this._studentId != Constant.EMPTY_ID)
            {
                _loc_1.push(this._studentId);
            }
            if (this._teacherId != Constant.EMPTY_ID)
            {
                _loc_1.push(this._teacherId);
            }
            _loc_1 = _loc_1.concat(this._aSupportId);
            return _loc_1;
        }// end function

        public function calcBaseProbability() : Number
        {
            var _loc_1:* = null;
            if (this._studentId != Constant.EMPTY_ID)
            {
                _loc_1 = UserDataManager.getInstance().userData.getPlayerPersonal(this._studentId);
                return Math.min(SkillInitiateUtility.getBaseProbability(this._teacherId, this._aSupportId), 100);
            }
            return 0;
        }// end function

        public function calcCurProbability() : Number
        {
            var _loc_1:* = null;
            if (this._studentId != Constant.EMPTY_ID)
            {
                _loc_1 = UserDataManager.getInstance().userData.getPlayerPersonal(this._studentId);
                return Math.min(SkillInitiateUtility.getBaseProbability(this._teacherId, this._aSupportId) + SkillInitiateUtility.getBonusProbability(this._bonusId), 100);
            }
            return 0;
        }// end function

    }
}
