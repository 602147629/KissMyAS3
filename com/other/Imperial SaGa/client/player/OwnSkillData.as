package player
{
    import skill.*;

    public class OwnSkillData extends Object
    {
        private var _skillId:int;
        private var _powerChange:int;
        private var _hitChange:int;
        private var _spChange:int;
        private var _spReduce:int;
        private var _kumiteCount:int;
        private var _skillInfo:SkillInformation;

        public function OwnSkillData(param1:Object)
        {
            this._skillId = param1.skillId;
            this._powerChange = param1.power ? (param1.power) : (0);
            this._hitChange = param1.hit ? (param1.hit) : (0);
            this._spChange = param1.spChange ? (param1.spChange) : (0);
            this._spReduce = param1.spReduce ? (param1.spReduce) : (0);
            this._kumiteCount = param1.kumiteCount ? (param1.kumiteCount) : (0);
            this._skillInfo = SkillManager.getInstance().getSkillInformation(this._skillId);
            return;
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        public function get powerChange() : int
        {
            return this._powerChange;
        }// end function

        public function set powerChange(param1:int) : void
        {
            this._powerChange = param1;
            return;
        }// end function

        public function get hitChange() : int
        {
            return this._hitChange;
        }// end function

        public function set hitChange(param1:int) : void
        {
            this._hitChange = param1;
            return;
        }// end function

        public function get spChange() : int
        {
            return this._spChange;
        }// end function

        public function set spChange(param1:int) : void
        {
            this._spChange = param1;
            return;
        }// end function

        public function get spReduce() : int
        {
            return this._spReduce;
        }// end function

        public function set spReduce(param1:int) : void
        {
            this._spReduce = param1;
            return;
        }// end function

        public function get kumiteCount() : int
        {
            return this._kumiteCount;
        }// end function

        public function set kumiteCount(param1:int) : void
        {
            this._kumiteCount = param1;
            return;
        }// end function

        public function get skillInfo() : SkillInformation
        {
            return this._skillInfo;
        }// end function

        public function get powerTotal() : int
        {
            if (this._skillInfo == null)
            {
                return 0;
            }
            var _loc_1:* = this._skillInfo.power + this._powerChange;
            return _loc_1;
        }// end function

        public function get powerMaxLimit() : int
        {
            return this._skillInfo == null ? (0) : (this._skillInfo.power * CommonConstant.OWN_SKILL_GROWTH_POWER_MAX_FACTOR / 1000);
        }// end function

        public function get powerMinLimit() : int
        {
            return this._skillInfo == null ? (0) : (this._skillInfo.power * CommonConstant.OWN_SKILL_GROWTH_POWER_MIN_FACTOR / 1000);
        }// end function

        public function isPowerMaxLimit() : Boolean
        {
            return this.powerTotal >= this.powerMaxLimit;
        }// end function

        public function isPowerMinLimit() : Boolean
        {
            return this.powerTotal <= this.powerMinLimit;
        }// end function

        public function get hitTotal() : int
        {
            if (this._skillInfo == null)
            {
                return 0;
            }
            var _loc_1:* = this._skillInfo.hit + this._hitChange;
            return _loc_1;
        }// end function

        public function get hitTotalShowVal() : int
        {
            return this.hitTotal / 10;
        }// end function

        public function get hitMaxLimit() : int
        {
            return this._skillInfo == null ? (0) : (this._skillInfo.hit * CommonConstant.OWN_SKILL_GROWTH_HIT_MAX_FACTOR / 1000);
        }// end function

        public function get hitMinLimit() : int
        {
            return this._skillInfo == null ? (0) : (this._skillInfo.hit * CommonConstant.OWN_SKILL_GROWTH_HIT_MIN_FACTOR / 1000);
        }// end function

        public function isHitMaxLimit() : Boolean
        {
            return this.hitTotal >= this.hitMaxLimit;
        }// end function

        public function isHitMinLimit() : Boolean
        {
            return this.hitTotal <= this.hitMinLimit;
        }// end function

        public function get spTotal() : int
        {
            if (this._skillInfo == null)
            {
                return 0;
            }
            var _loc_1:* = this._skillInfo.sp + this._spChange - this._spReduce;
            return _loc_1;
        }// end function

        public function get spMaxLimit() : int
        {
            return CommonConstant.OWN_SKILL_GROWTH_SP_MAX;
        }// end function

        public function get spMinLimit() : int
        {
            return this._skillInfo == null ? (0) : (this._skillInfo.sp * CommonConstant.OWN_SKILL_GROWTH_SP_MIN_FACTOR / 1000);
        }// end function

        public function isSpMaxLimit() : Boolean
        {
            return this.spTotal >= this.spMaxLimit;
        }// end function

        public function isSpMinLimit() : Boolean
        {
            return this.spTotal <= this.spMinLimit;
        }// end function

        public function clone() : OwnSkillData
        {
            return new OwnSkillData({skillId:this._skillId, power:this._powerChange, hit:this._hitChange, spChange:this._spChange, spReduce:this._spReduce, kumiteCount:this._kumiteCount});
        }// end function

    }
}
