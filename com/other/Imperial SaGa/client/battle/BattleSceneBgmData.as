package battle
{

    public class BattleSceneBgmData extends Object
    {
        private var _bgmId:int;
        private var _feverBgmId:int;

        public function BattleSceneBgmData(param1:int, param2:int)
        {
            this._bgmId = param1;
            this._feverBgmId = param2;
            return;
        }// end function

        public function get bgmId() : int
        {
            return this._bgmId;
        }// end function

        public function get feverBgmId() : int
        {
            return this._feverBgmId;
        }// end function

    }
}
