package player
{

    public class PlayerEmperorBgm extends Object
    {
        private var _charaId:int;
        private var _wayBgmId:int;
        private var _normalBattleBgmId:int;
        private var _bossBattleBgmId:int;
        private var _feverBgmId:int;

        public function PlayerEmperorBgm()
        {
            this._charaId = 0;
            this._wayBgmId = 0;
            this._normalBattleBgmId = 0;
            this._bossBattleBgmId = 0;
            this._feverBgmId = 0;
            return;
        }// end function

        public function setParam(param1:Object) : void
        {
            this._charaId = param1.charId;
            this._wayBgmId = param1.wayBgm;
            this._normalBattleBgmId = param1.normalBattleBgm;
            this._bossBattleBgmId = param1.bossBattleBgm;
            this._feverBgmId = param1.feverBgm;
            return;
        }// end function

        public function get charaId() : int
        {
            return this._charaId;
        }// end function

        public function get wayBgmId() : int
        {
            return this._wayBgmId;
        }// end function

        public function get normalBattleBgmId() : int
        {
            return this._normalBattleBgmId;
        }// end function

        public function get bossBattleBgmId() : int
        {
            return this._bossBattleBgmId;
        }// end function

        public function get feverBgmId() : int
        {
            return this._feverBgmId;
        }// end function

    }
}
