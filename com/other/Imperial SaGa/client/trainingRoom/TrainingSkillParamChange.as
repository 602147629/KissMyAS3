package trainingRoom
{

    public class TrainingSkillParamChange extends Object
    {
        private var _skillId:int;
        private var _powerBase:int;
        private var _powerChange:int;
        private var _hitBase:int;
        private var _hitChange:int;
        private var _spBase:int;
        private var _spChange:int;
        private var _bTraining:Boolean;

        public function TrainingSkillParamChange(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Boolean = false)
        {
            this._skillId = param1;
            this._powerBase = param2;
            this._powerChange = param3;
            this._hitBase = param4;
            this._hitChange = param5;
            this._spBase = param6;
            this._spChange = param7;
            this._bTraining = param8;
            return;
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        public function get powerBase() : int
        {
            return this._powerBase;
        }// end function

        public function get powerChange() : int
        {
            return this._powerChange;
        }// end function

        public function get hitBase() : int
        {
            return this._hitBase;
        }// end function

        public function get hitChange() : int
        {
            return this._hitChange;
        }// end function

        public function get spBase() : int
        {
            return this._spBase;
        }// end function

        public function get spChange() : int
        {
            return this._spChange;
        }// end function

        public function get bTraining() : Boolean
        {
            return this._bTraining;
        }// end function

    }
}
