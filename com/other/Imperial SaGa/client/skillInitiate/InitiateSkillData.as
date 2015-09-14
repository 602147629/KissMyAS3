package skillInitiate
{

    public class InitiateSkillData extends Object
    {
        private var _skillId:int;
        private var _teacherNum:int;
        private var _isHave:Boolean;

        public function InitiateSkillData(param1:int, param2:int, param3:Boolean)
        {
            this._skillId = param1;
            this._teacherNum = param2;
            this._isHave = param3;
            return;
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        public function get teacherNum() : int
        {
            return this._teacherNum;
        }// end function

        public function get isHave() : Boolean
        {
            return this._isHave;
        }// end function

    }
}
