package trainingRoom
{
    import player.*;

    public class TrainingRoomKumitePlayerData extends Object
    {
        private var _guestNo:int;
        private var _userId:int;
        private var _userName:String;
        private var _exp:int;
        private var _count:int;
        private var _playerId:int;
        private var _hp:int;
        private var _lp:int;
        private var _sp:int;
        private var _addHp:int;
        private var _addAttack:int;
        private var _addDefense:int;
        private var _addSpeed:int;
        private var _battleCount:int;
        private var _isDone:Boolean;

        public function TrainingRoomKumitePlayerData(param1:int, param2:Object)
        {
            this._guestNo = param1;
            this._userId = param2.userId;
            this._userName = param2.userName;
            this._exp = param2.exp;
            this._count = param2.count;
            this._playerId = param2.playerId;
            this._hp = param2.hp;
            this._lp = param2.lp;
            this._sp = param2.sp;
            this._addHp = param2.addHp;
            this._addAttack = param2.addAtk;
            this._addDefense = param2.addDef;
            this._addSpeed = param2.addSpd;
            this._battleCount = param2.battleCount;
            this._isDone = param2.done;
            var _loc_3:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            if (_loc_3)
            {
                this._sp = PlayerPersonal.calcDefaultSp(_loc_3);
            }
            return;
        }// end function

        public function get guestNo() : int
        {
            return this._guestNo;
        }// end function

        public function get userId() : int
        {
            return this._userId;
        }// end function

        public function get userName() : String
        {
            return this._userName;
        }// end function

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function get playerId() : int
        {
            return this._playerId;
        }// end function

        public function get hp() : int
        {
            return this._hp;
        }// end function

        public function get lp() : int
        {
            return this._lp;
        }// end function

        public function get sp() : int
        {
            return this._sp;
        }// end function

        public function get addHp() : int
        {
            return this._addHp;
        }// end function

        public function get addAttack() : int
        {
            return this._addAttack;
        }// end function

        public function get addDefense() : int
        {
            return this._addDefense;
        }// end function

        public function get addSpeed() : int
        {
            return this._addSpeed;
        }// end function

        public function get battleCount() : int
        {
            return this._battleCount;
        }// end function

        public function get isDone() : Boolean
        {
            return this._isDone;
        }// end function

        public function getGrowthTotal() : int
        {
            return this._addHp + this._addAttack + this._addDefense + this._addSpeed;
        }// end function

    }
}
