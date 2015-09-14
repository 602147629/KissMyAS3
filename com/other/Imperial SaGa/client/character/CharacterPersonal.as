package character
{
    import develop.*;

    public class CharacterPersonal extends Object
    {
        protected var _questUniqueId:int;
        protected var _hp:int;
        protected var _hpMax:int;
        protected var _lp:int;
        protected var _attack:int;
        protected var _defense:int;
        protected var _speed:int;
        protected var _magicReasonable:int;
        protected var _aSetSkillId:Array;
        protected var _useSkillId:int;
        protected var _bDead:Boolean;

        public function CharacterPersonal()
        {
            this._aSetSkillId = [];
            return;
        }// end function

        public function get questUniqueId() : int
        {
            return this._questUniqueId;
        }// end function

        public function get hp() : int
        {
            return this._hp;
        }// end function

        public function get hpMax() : int
        {
            return this._hpMax;
        }// end function

        public function set lp(param1:int) : void
        {
            this._lp = param1;
            return;
        }// end function

        public function get lp() : int
        {
            return this._lp;
        }// end function

        public function get attack() : int
        {
            return this._attack;
        }// end function

        public function get defense() : int
        {
            return this._defense;
        }// end function

        public function get speed() : int
        {
            return this._speed;
        }// end function

        public function get attackTotal() : int
        {
            return this._attack;
        }// end function

        public function get defenseTotal() : int
        {
            return this._defense;
        }// end function

        public function get speedTotal() : int
        {
            return this._speed;
        }// end function

        public function get magicReasonable() : int
        {
            return this._magicReasonable;
        }// end function

        public function get magicReasonableTotal() : int
        {
            return this._magicReasonable;
        }// end function

        public function get aSetSkillId() : Array
        {
            return this._aSetSkillId.concat();
        }// end function

        public function get useSkillId() : int
        {
            return this._useSkillId;
        }// end function

        public function set useSkillId(param1:int) : void
        {
            this._useSkillId = param1;
            return;
        }// end function

        public function get bDead() : Boolean
        {
            return this._bDead;
        }// end function

        public function setParameter(param1:Object) : void
        {
            var _loc_2:* = 0;
            this._questUniqueId = Constant.EMPTY_ID;
            this._hp = param1.hp;
            this._lp = 0;
            this._attack = 0;
            this._defense = 0;
            this._speed = 0;
            this._magicReasonable = 0;
            this._aSetSkillId = [];
            for each (_loc_2 in param1.aSkill)
            {
                
                this._aSetSkillId.push(_loc_2);
            }
            this._useSkillId = 0;
            return;
        }// end function

        protected function copyParameter(param1:CharacterPersonal) : void
        {
            var _loc_2:* = 0;
            this._questUniqueId = param1.questUniqueId;
            this._bDead = param1.bDead;
            this._hp = param1.hp;
            this._hpMax = param1.hpMax;
            this._attack = param1.attack;
            this._defense = param1.defense;
            this._speed = param1.speed;
            this._magicReasonable = param1.magicReasonable;
            this._aSetSkillId = [];
            for each (_loc_2 in param1.aSetSkillId)
            {
                
                this._aSetSkillId.push(_loc_2);
            }
            this._useSkillId = param1.useSkillId;
            return;
        }// end function

        public function setEquippedSkillId(param1:int, param2:int) : void
        {
            if (param1 >= 0 && param1 < this._aSetSkillId.length)
            {
                this._aSetSkillId[param1] = param2;
            }
            return;
        }// end function

        public function addSetSkill(param1:int) : Boolean
        {
            DebugLog.print("設定技へ追加:" + param1);
            var _loc_2:* = 0;
            while (_loc_2 < this._aSetSkillId.length)
            {
                
                if (this._aSetSkillId[_loc_2] == 0)
                {
                    this._aSetSkillId[_loc_2] = param1;
                    DebugLog.print("->追加した");
                    return true;
                }
                _loc_2++;
            }
            DebugLog.print("->追加していない");
            return false;
        }// end function

        public function getNotSetSkillNum() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this._aSetSkillId.length)
            {
                
                if (this._aSetSkillId[_loc_2] == 0)
                {
                    _loc_1++;
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function damageHp(param1:int) : void
        {
            this._hp = this._hp - param1;
            if (this._hp <= 0)
            {
                this._hp = 0;
                this._bDead = true;
            }
            return;
        }// end function

        public function addSp(param1:int) : void
        {
            return;
        }// end function

        public function setDeath() : void
        {
            this._hp = 0;
            this.damageHp(0);
            return;
        }// end function

        public function setHp(param1:int) : void
        {
            this._hp = param1;
            return;
        }// end function

    }
}
