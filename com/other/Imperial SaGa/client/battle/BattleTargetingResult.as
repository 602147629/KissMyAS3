package battle
{
    import skill.*;

    public class BattleTargetingResult extends Object
    {
        private var _skillInfo:SkillInformation;
        private var _aTarget:Array;

        public function BattleTargetingResult(param1:SkillInformation, param2:Array)
        {
            this._skillInfo = param1;
            this._aTarget = param2;
            return;
        }// end function

        public function get skillInfo() : SkillInformation
        {
            return this._skillInfo;
        }// end function

        public function get aTarget() : Array
        {
            return this._aTarget.concat();
        }// end function

    }
}
