package battle
{
    import character.*;
    import flash.display.*;
    import flash.geom.*;
    import skill.*;

    public class BattleCharacterBase extends Object
    {
        protected var _characterAction:BattleActionBase;
        protected var _parent:DisplayObjectContainer;
        protected var _parentDamage:DisplayObjectContainer;
        protected var _personal:CharacterPersonal;
        protected var _formationIndex:int;
        protected var _division:int;
        protected var _standingPos:Point;
        protected var _damageOffset:Point;
        protected var _status:BattleCharacterStatus;
        protected var _badStatusColor:BattleBadStatusColor;
        protected var _aDamageHp:Array;
        protected var _aDamageHpDisp:Array;
        protected var _aDamageLp:Array;
        protected var _aDamageLpDisp:Array;
        protected var _aRecoveryHp:Array;
        protected var _aRecoveryHpDisp:Array;
        protected var _aDamageBadStatus:Array;
        protected var _aDamageBadStatusDisp:Array;

        public function BattleCharacterBase(param1:DisplayObjectContainer, param2:CharacterPersonal, param3:int)
        {
            this._parent = param1;
            this._parentDamage = this._parent;
            this.setPersonal(param2);
            this._formationIndex = param3;
            this._aDamageHp = [];
            this._aDamageHpDisp = [];
            this._aDamageLp = [];
            this._aDamageLpDisp = [];
            this._aRecoveryHp = [];
            this._aRecoveryHpDisp = [];
            this._aDamageBadStatus = [];
            this._aDamageBadStatusDisp = [];
            this._standingPos = new Point();
            this._status = new BattleCharacterStatus(this);
            this._damageOffset = new Point();
            return;
        }// end function

        public function get characterAction() : BattleActionBase
        {
            return this._characterAction;
        }// end function

        public function get parentDamage() : DisplayObjectContainer
        {
            return this._parentDamage;
        }// end function

        public function set parentDamage(param1:DisplayObjectContainer) : void
        {
            this._parentDamage = param1;
            return;
        }// end function

        public function get personal() : CharacterPersonal
        {
            return this._personal;
        }// end function

        public function get sex() : int
        {
            return CharacterConstant.SEX_NON;
        }// end function

        public function get armyType() : int
        {
            return Constant.UNDECIDED;
        }// end function

        public function get formationIndex() : int
        {
            return this._formationIndex;
        }// end function

        public function set formationIndex(param1:int) : void
        {
            this._formationIndex = param1;
            return;
        }// end function

        public function get division() : int
        {
            return this._division;
        }// end function

        public function get status() : BattleCharacterStatus
        {
            return this._status;
        }// end function

        public function get bBattleDead() : Boolean
        {
            return this._personal.bDead;
        }// end function

        public function isDefense() : Boolean
        {
            return this._status.bGuard;
        }// end function

        public function setDefense(param1:Boolean) : void
        {
            this._status.bGuard = param1;
            return;
        }// end function

        public function isCounter() : Boolean
        {
            return this._status.bCounter;
        }// end function

        public function setCounterSkillId(param1:int) : void
        {
            this._status.setCounterSkillId(param1);
            return;
        }// end function

        public function getGrowthTotal() : int
        {
            return 0;
        }// end function

        public function getSkillPower(param1:SkillInformation) : int
        {
            return param1.power;
        }// end function

        public function getSkillHit(param1:SkillInformation) : int
        {
            return param1.hit;
        }// end function

        public function addDaamgeHp(param1:DamageData) : void
        {
            this._aDamageHp.push(param1);
            return;
        }// end function

        public function addDamageLp(param1:DamageData) : void
        {
            this._aDamageLp.push(param1);
            return;
        }// end function

        public function addDamageBadStatus(param1:DamageData) : void
        {
            this._aDamageBadStatus.push(param1);
            return;
        }// end function

        public function addRecoveryHp(param1:DamageData) : void
        {
            this._aRecoveryHp.push(param1);
            return;
        }// end function

        public function setDeadDisable() : void
        {
            this._characterAction.bDeadDisable = true;
            return;
        }// end function

        public function setUseDeadEffect() : void
        {
            this._characterAction.setUseDeadEffect();
            return;
        }// end function

        public function setBrokenItem() : void
        {
            this._characterAction.setBrokenItem();
            return;
        }// end function

        protected function initAfterCharacterAction() : void
        {
            if (this._badStatusColor != null)
            {
                this._badStatusColor.release();
                this._badStatusColor = null;
            }
            this._badStatusColor = new BattleBadStatusColor(this._characterAction.characterDisplay.layer);
            return;
        }// end function

        protected function setPersonal(param1:CharacterPersonal) : void
        {
            this._personal = param1;
            return;
        }// end function

        public function release() : void
        {
            if (this._badStatusColor != null)
            {
                this._badStatusColor.release();
            }
            this._badStatusColor = null;
            if (this._characterAction)
            {
                this._characterAction.release();
            }
            this._characterAction = null;
            this._parentDamage = null;
            this._personal = null;
            this._parent = null;
            this._status = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_2:* = this._characterAction.isDead();
            if (this._aDamageHp.length > 0)
            {
                if (_loc_2)
                {
                    this._aDamageHp = [];
                }
                else
                {
                    _loc_4 = this._aDamageHp[0];
                    if (_loc_4.bCounter == false && _loc_4.bSkip == false)
                    {
                        _loc_5 = new DamageUtility(this._parentDamage, _loc_4, this.getDamagePos());
                        this._aDamageHpDisp.push(_loc_5);
                    }
                    this._aDamageHp.shift();
                }
            }
            _loc_3 = this._aDamageHpDisp.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_6 = this._aDamageHpDisp[_loc_3];
                _loc_6.control(param1);
                if (_loc_6.bEnd)
                {
                    _loc_6.release();
                    this._aDamageHpDisp.splice(_loc_3, 1);
                }
                _loc_3 = _loc_3 - 1;
            }
            if (this._aDamageLp.length > 0)
            {
                if (this._aDamageHpDisp.length == 0)
                {
                    if (this._characterAction.bUseDeadEffect == false && this._characterAction.bPlayingDeadEffect == false)
                    {
                        _loc_7 = this._aDamageLp[0];
                        if (_loc_7.bBrokenItem)
                        {
                            _loc_8 = new DamageUtilityBrokenItem(this._parentDamage, _loc_7, this.getDamagePos());
                        }
                        else
                        {
                            _loc_8 = new DamageUtility(this._parentDamage, _loc_7, this.getDamagePos());
                        }
                        this._aDamageLpDisp.push(_loc_8);
                    }
                    this._aDamageLp.shift();
                }
            }
            _loc_3 = this._aDamageLpDisp.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_9 = this._aDamageLpDisp[_loc_3];
                _loc_9.control(param1);
                if (_loc_9.bEnd)
                {
                    _loc_9.release();
                    this._aDamageLpDisp.splice(_loc_3, 1);
                }
                _loc_3 = _loc_3 - 1;
            }
            if (this._aDamageBadStatus.length > 0)
            {
                if (this._aDamageHpDisp.length == 0 && this._aDamageLpDisp.length == 0 && this._aDamageBadStatusDisp.length == 0)
                {
                    _loc_10 = this._aDamageBadStatus[0];
                    if (_loc_2)
                    {
                        this._aDamageBadStatus = [];
                        if (_loc_10.dispStatusId != BattleConstant.BAD_STATUS_ID_INSTANT_DEATH)
                        {
                            _loc_10 = null;
                        }
                    }
                    if (_loc_10 != null)
                    {
                        _loc_11 = new DamageUtility(this._parentDamage, _loc_10, this.getBadStatusPos());
                        this._aDamageBadStatusDisp.push(_loc_11);
                        this._aDamageBadStatus.shift();
                    }
                }
            }
            _loc_3 = this._aDamageBadStatusDisp.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_12 = this._aDamageBadStatusDisp[_loc_3];
                if (_loc_2)
                {
                    _loc_12.clearWaitTime();
                }
                _loc_12.control(param1);
                if (_loc_12.bEnd)
                {
                    _loc_12.release();
                    this._aDamageBadStatusDisp.splice(_loc_3, 1);
                }
                _loc_3 = _loc_3 - 1;
            }
            if (this._aRecoveryHp.length > 0)
            {
                if (_loc_2)
                {
                    this._aRecoveryHp = [];
                }
                else
                {
                    _loc_13 = this._aRecoveryHp[0];
                    _loc_14 = new DamageUtility(this._parentDamage, _loc_13, this.getDamagePos(), DamageUtility.COLOR_GREEN);
                    this._aRecoveryHpDisp.push(_loc_14);
                    this._aRecoveryHp.shift();
                }
            }
            _loc_3 = this._aRecoveryHpDisp.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_15 = this._aRecoveryHpDisp[_loc_3];
                if (_loc_2)
                {
                    _loc_15.clearWaitTime();
                }
                _loc_15.control(param1);
                if (_loc_15.bEnd)
                {
                    _loc_15.release();
                    this._aRecoveryHpDisp.splice(_loc_3, 1);
                }
                _loc_3 = _loc_3 - 1;
            }
            if (this._badStatusColor != null)
            {
                this._badStatusColor.control(this._status.badStatus, this._personal.bDead);
            }
            this._characterAction.bDamageDisp = this._aDamageHpDisp.length > 0 || this._aDamageLpDisp.length > 0 || this._aDamageBadStatus.length > 0 || this._aDamageBadStatusDisp.length > 0;
            this._characterAction.control(param1);
            return;
        }// end function

        private function getDamagePos() : Point
        {
            var _loc_1:* = this._standingPos.add(this._damageOffset);
            if (_loc_1.y >= 540)
            {
                _loc_1.y = 540;
            }
            return _loc_1;
        }// end function

        private function getBadStatusPos() : Point
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = this._characterAction.characterDisplay;
            var _loc_2:* = this._standingPos.add(this._damageOffset);
            if (_loc_1.mc.character)
            {
                _loc_3 = _loc_1.mc.character.moveNull;
                if (_loc_3)
                {
                    _loc_4 = _loc_3.transform.matrix;
                    _loc_2 = _loc_2.add(new Point(_loc_4.tx, _loc_4.ty));
                }
            }
            if (_loc_2.y >= 540)
            {
                _loc_2.y = 540;
            }
            return _loc_2;
        }// end function

        public function dealDamage(param1:int) : void
        {
            return;
        }// end function

        public function setPosition(param1:Point) : void
        {
            this._standingPos = param1.clone();
            this._characterAction.characterDisplay.pos = param1.clone();
            return;
        }// end function

        public function setCbCounterHit(param1:Function) : void
        {
            this._characterAction.setCbCounterHit(param1);
            return;
        }// end function

    }
}
