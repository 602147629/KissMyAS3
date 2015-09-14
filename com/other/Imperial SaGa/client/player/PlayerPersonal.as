package player
{
    import battle.*;
    import character.*;
    import develop.*;
    import formation.*;
    import item.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class PlayerPersonal extends CharacterPersonal
    {
        protected var _uniqueId:int;
        protected var _playerId:int;
        protected var _battleCount:int;
        private var _trainingCount:int;
        protected var _sp:int;
        protected var _spMax:int;
        protected var _spRecoveryTime:uint;
        protected var _aOwnSkillData:Array;
        protected var _aSetItemId:Array;
        private var _itemAtk:int;
        private var _itemDef:int;
        private var _itemSpd:int;
        private var _itemMagic:int;
        private var _aDefenseToleranceItem:Array;
        private var _aBadStatusToleranceItem:Array;
        private var _emperorBonus:int;
        private var _emperorBonusTarget:int;
        private var _bonusAtk:int;
        private var _bonusDef:int;
        private var _bonusSpd:int;
        private var _bonusMag:int;
        private var _bRestoreBonus:Boolean;
        private var _restoreStartHp:int;
        private var _restoreStartTime:uint;
        private var _restoreEndTime:uint;
        private var _lastUseFacilityId:int;
        private var _lastUseFacilitySubId:int;
        private var _useFacilityEndTime:uint;
        private var _gotTime:uint;
        private var _formationBonusAtk:int;
        private var _formationBonusDef:int;
        private var _formationBonusSpd:int;
        private var _formationBonusMag:int;
        private var _commanderSkillBonus:PlayerCommanderSkill;
        public static const PLAYER_DYING_HP_PER:int = 30;

        public function PlayerPersonal()
        {
            this.initialize();
            return;
        }// end function

        public function get uniqueId() : int
        {
            return this._uniqueId;
        }// end function

        public function set questUniqueId(param1:int) : void
        {
            _questUniqueId = param1;
            return;
        }// end function

        public function get playerId() : int
        {
            return this._playerId;
        }// end function

        public function set battleCount(param1:int) : void
        {
            this._battleCount = param1;
            return;
        }// end function

        public function get battleCount() : int
        {
            return this._battleCount;
        }// end function

        public function set trainingCount(param1:int) : void
        {
            this._trainingCount = param1;
            return;
        }// end function

        public function get trainingCount() : int
        {
            return this._trainingCount;
        }// end function

        public function get sp() : int
        {
            return this._sp;
        }// end function

        public function get spMax() : int
        {
            return this._spMax;
        }// end function

        public function get spRecoveryTime() : uint
        {
            return this._spRecoveryTime;
        }// end function

        public function get aOwnSkillData() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aOwnSkillData)
            {
                
                _loc_1.push(_loc_2.clone());
            }
            return _loc_1;
        }// end function

        public function getOwnSkillData(param1:int) : OwnSkillData
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aOwnSkillData)
            {
                
                if (_loc_2.skillId == param1)
                {
                    return _loc_2.clone();
                }
            }
            return null;
        }// end function

        public function get aSetItemId() : Array
        {
            return this._aSetItemId.concat();
        }// end function

        public function get itemAtk() : int
        {
            return this._itemAtk;
        }// end function

        public function get itemDef() : int
        {
            return this._itemDef;
        }// end function

        public function get itemSpd() : int
        {
            return this._itemSpd;
        }// end function

        public function get itemMagic() : int
        {
            return this._itemMagic;
        }// end function

        public function get aDefenseToleranceItem() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aDefenseToleranceItem)
            {
                
                _loc_1.push(_loc_2.clone());
            }
            return _loc_1;
        }// end function

        public function get aBadStatusToleranceItem() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aBadStatusToleranceItem)
            {
                
                _loc_1.push(_loc_2.clone());
            }
            return _loc_1;
        }// end function

        public function get emperorBonus() : int
        {
            return this._emperorBonus;
        }// end function

        public function get emperorBonusTarget() : int
        {
            return this._emperorBonusTarget;
        }// end function

        public function get bonusAtk() : int
        {
            return this._bonusAtk;
        }// end function

        public function get bonusDef() : int
        {
            return this._bonusDef;
        }// end function

        public function get bonusSpd() : int
        {
            return this._bonusSpd;
        }// end function

        public function get bonusMag() : int
        {
            return this._bonusMag;
        }// end function

        public function get bRestoreBonus() : Boolean
        {
            return this._bRestoreBonus;
        }// end function

        public function get restoreStartHp() : int
        {
            return this._restoreStartHp;
        }// end function

        public function get restoreStartTime() : uint
        {
            return this._restoreStartTime;
        }// end function

        public function get restoreEndTime() : uint
        {
            return this._restoreEndTime;
        }// end function

        public function get lastUseFacilityId() : int
        {
            return this._lastUseFacilityId;
        }// end function

        public function get lastUseFacilitySubId() : int
        {
            return this._lastUseFacilitySubId;
        }// end function

        public function get useFacilityEndTime() : uint
        {
            return this._useFacilityEndTime;
        }// end function

        public function get gotTime() : uint
        {
            return this._gotTime;
        }// end function

        public function get formationBonusAtk() : int
        {
            return this._formationBonusAtk;
        }// end function

        public function get formationBonusDef() : int
        {
            return this._formationBonusDef;
        }// end function

        public function get formationBonusSpd() : int
        {
            return this._formationBonusSpd;
        }// end function

        public function get formationBonusMag() : int
        {
            return this._formationBonusMag;
        }// end function

        public function get commanderSkillBonus() : PlayerCommanderSkill
        {
            return this._commanderSkillBonus;
        }// end function

        public function setFormationBonus(param1:FormationInformation, param2:int) : void
        {
            var _loc_3:* = 0;
            if (param1)
            {
                _loc_3 = PlayerManager.getInstance().getPlayerInformation(this._playerId).weaponType;
                this._formationBonusAtk = param1.getAttackCorrectionValue(param2, _loc_3);
                this._formationBonusDef = param1.getDefenseCorrectionValue(param2, _loc_3);
                this._formationBonusSpd = param1.getSpeedCorrectionValue(param2, _loc_3);
                this._formationBonusMag = param1.getMagicCorrectionValue(param2, _loc_3);
            }
            else
            {
                this.resetFormationBonus();
            }
            return;
        }// end function

        public function resetFormationBonus() : void
        {
            this._formationBonusAtk = 0;
            this._formationBonusDef = 0;
            this._formationBonusSpd = 0;
            this._formationBonusMag = 0;
            return;
        }// end function

        public function setCommanderSkillBonus(param1:PlayerCommanderSkill) : void
        {
            this._commanderSkillBonus = param1;
            return;
        }// end function

        public function resetCommanderSkillBonus() : void
        {
            this._commanderSkillBonus = null;
            return;
        }// end function

        override public function get attackTotal() : int
        {
            return Math.max(1, super.attack + this.bonusAttackTotal);
        }// end function

        override public function get defenseTotal() : int
        {
            return Math.max(1, super.defense + this.bonusDefenseTotal);
        }// end function

        override public function get speedTotal() : int
        {
            return Math.max(1, super.speed + this.bonusSpeedTotal);
        }// end function

        override public function get magicReasonableTotal() : int
        {
            return Math.max(0, super.magicReasonable + this.bonusMagicTotal);
        }// end function

        public function get damageRecoverRateTotal() : int
        {
            var _loc_1:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            return _loc_1.recoverRate;
        }// end function

        public function get bonusAttackTotal() : int
        {
            var _loc_1:* = this._itemAtk + this._formationBonusAtk;
            if (this._emperorBonusTarget == PlayerConstant.EMPEROR_SKILL_TARGET_ATTACK)
            {
                _loc_1 = _loc_1 + this._emperorBonus;
            }
            if (this.isRestoreBonus() && this._bonusAtk != 0)
            {
                _loc_1 = _loc_1 + this._bonusAtk;
            }
            if (this._commanderSkillBonus)
            {
                _loc_1 = _loc_1 + this._commanderSkillBonus.addAttack;
            }
            return _loc_1;
        }// end function

        public function isBonusAttack() : Boolean
        {
            return this._itemAtk != 0 || this._formationBonusAtk != 0 || this._emperorBonus != 0 && this._emperorBonusTarget == PlayerConstant.EMPEROR_SKILL_TARGET_ATTACK || this.isRestoreBonus() && this._bonusAtk != 0 || this._commanderSkillBonus && this._commanderSkillBonus.addAttack != 0;
        }// end function

        public function get bonusDefenseTotal() : int
        {
            var _loc_1:* = this._itemDef + this._formationBonusDef;
            if (this._emperorBonusTarget == PlayerConstant.EMPEROR_SKILL_TARGET_DEFENSE)
            {
                _loc_1 = _loc_1 + this._emperorBonus;
            }
            if (this.isRestoreBonus() && this._bonusDef != 0)
            {
                _loc_1 = _loc_1 + this._bonusDef;
            }
            if (this._commanderSkillBonus)
            {
                _loc_1 = _loc_1 + this._commanderSkillBonus.addDefense;
            }
            return _loc_1;
        }// end function

        public function isBonusDefense() : Boolean
        {
            return this._itemDef != 0 || this._formationBonusDef != 0 || this._emperorBonus != 0 && this._emperorBonusTarget == PlayerConstant.EMPEROR_SKILL_TARGET_DEFENSE || this.isRestoreBonus() && this._bonusDef != 0 || this._commanderSkillBonus && this._commanderSkillBonus.addDefense != 0;
        }// end function

        public function get bonusSpeedTotal() : int
        {
            var _loc_1:* = this._itemSpd + this._formationBonusSpd;
            if (this._emperorBonusTarget == PlayerConstant.EMPEROR_SKILL_TARGET_SPEED)
            {
                _loc_1 = _loc_1 + this._emperorBonus;
            }
            if (this.isRestoreBonus() && this._bonusSpd != 0)
            {
                _loc_1 = _loc_1 + this._bonusSpd;
            }
            if (this._commanderSkillBonus)
            {
                _loc_1 = _loc_1 + this._commanderSkillBonus.addSpeed;
            }
            return _loc_1;
        }// end function

        public function isBonusSpeed() : Boolean
        {
            return this._itemSpd != 0 || this._formationBonusSpd != 0 || this._emperorBonus != 0 && this._emperorBonusTarget == PlayerConstant.EMPEROR_SKILL_TARGET_SPEED || this.isRestoreBonus() && this._bonusSpd != 0 || this._commanderSkillBonus && this._commanderSkillBonus.addSpeed != 0;
        }// end function

        public function get bonusMagicTotal() : int
        {
            var _loc_1:* = this._itemMagic + this._formationBonusMag;
            if (this.isRestoreBonus() && this._bonusMag != 0)
            {
                _loc_1 = _loc_1 + this._bonusMag;
            }
            if (this._commanderSkillBonus)
            {
                _loc_1 = _loc_1 + this._commanderSkillBonus.addMagic;
            }
            return _loc_1;
        }// end function

        public function isBonusMagic() : Boolean
        {
            return this._itemMagic != 0 || this._formationBonusMag != 0 || this.isRestoreBonus() && this._bonusMag != 0 || this._commanderSkillBonus && this._commanderSkillBonus.addMagic != 0;
        }// end function

        public function battleUpdate(param1:PlayerPersonal, param2:PlayerBattleBonus) : void
        {
            DebugLog.print("ユニークID" + this.uniqueId.toString());
            var _loc_3:* = _bDead;
            var _loc_4:* = _hp;
            var _loc_5:* = _lp;
            _bDead = param1.bDead;
            _hp = param1.hp;
            _lp = param1.lp;
            this._sp = param1.sp;
            _aSetSkillId = param1._aSetSkillId;
            this._aOwnSkillData = param1._aOwnSkillData;
            this._aSetItemId = param1._aSetItemId;
            DebugLog.print("死亡のフラグが" + _loc_3 + "から" + _bDead.toString() + "へ");
            DebugLog.print("HPが" + _loc_4 + "から" + _hp.toString() + "へ");
            DebugLog.print("LPが" + _loc_5 + "から" + _lp.toString() + "へ");
            if (_bDead)
            {
                return;
            }
            var _loc_6:* = _hpMax;
            var _loc_7:* = _attack;
            var _loc_8:* = _defense;
            var _loc_9:* = _speed;
            _hpMax = param1.hpMax;
            this.addAttack(param2.attack);
            this.addDefense(param2.defense);
            this.addSpeed(param2.speed);
            DebugLog.print("最大HPが" + _loc_6 + "から" + _hpMax.toString() + "へ");
            DebugLog.print("攻撃力が" + _loc_7 + "から" + _attack.toString() + "へ");
            DebugLog.print("防御力が" + _loc_8 + "から" + _defense.toString() + "へ");
            DebugLog.print("すばやさが" + _loc_9 + "から" + _speed.toString() + "へ");
            DebugLog.print("HPボーナス" + param2.hp.toString());
            DebugLog.print("攻撃ボーナス" + param2.attack.toString());
            DebugLog.print("防御ボーナス" + param2.defense.toString());
            DebugLog.print("すばやさボーナス" + param2.speed.toString());
            return;
        }// end function

        public function setOwnSkill(param1:PlayerPersonal) : void
        {
            _aSetSkillId = param1._aSetSkillId.concat();
            this._aOwnSkillData = param1._aOwnSkillData.concat();
            return;
        }// end function

        public function updateStatus(param1:PlayerPersonal, param2:Boolean = false) : int
        {
            var _loc_3:* = _bDead;
            var _loc_4:* = _hp;
            var _loc_5:* = _lp;
            var _loc_6:* = _hpMax;
            var _loc_7:* = _attack;
            var _loc_8:* = _defense;
            var _loc_9:* = _speed;
            this._battleCount = param1.battleCount;
            if (param2)
            {
                var _loc_11:* = this;
                var _loc_12:* = this._battleCount + 1;
                _loc_11._battleCount = _loc_12;
            }
            _bDead = param1._bDead;
            _hpMax = param1.hpMax;
            _hp = param1.hp;
            _lp = param1.lp;
            this._sp = param1.sp;
            this._spRecoveryTime = param1.spRecoveryTime;
            _attack = param1.attack;
            _defense = param1.defense;
            _speed = param1.speed;
            this._bRestoreBonus = false;
            this._bonusAtk = 0;
            this._bonusDef = 0;
            this._bonusSpd = 0;
            this._bonusMag = 0;
            _aSetSkillId = param1._aSetSkillId;
            this._aOwnSkillData = param1._aOwnSkillData;
            var _loc_10:* = param1.aSetItemId;
            this._aSetItemId = _loc_10;
            this._formationBonusAtk = param1.formationBonusAtk;
            this._formationBonusDef = param1.formationBonusDef;
            this._formationBonusSpd = param1.formationBonusSpd;
            this._formationBonusMag = param1.formationBonusMag;
            this._commanderSkillBonus = param1.commanderSkillBonus;
            if (param2 && _bDead && _hp == 0 && _lp > 0)
            {
                this.revive();
            }
            DebugLog.print("死亡のフラグが" + _loc_3 + "から" + _bDead.toString() + "へ");
            DebugLog.print("HPが" + _loc_4 + "から" + _hp.toString() + "へ");
            DebugLog.print("LPが" + _loc_5 + "から" + _lp.toString() + "へ");
            DebugLog.print("最大HPが" + _loc_6 + "から" + _hpMax.toString() + "へ");
            DebugLog.print("攻撃力が" + _loc_7 + "から" + _attack.toString() + "へ");
            DebugLog.print("防御力が" + _loc_8 + "から" + _defense.toString() + "へ");
            DebugLog.print("すばやさが" + _loc_9 + "から" + _speed.toString() + "へ");
            return _attack - _loc_7 + (_defense - _loc_8) + (_speed - _loc_9) + (_hpMax - _loc_6);
        }// end function

        override public function setParameter(param1:Object) : void
        {
            var _loc_3:* = null;
            super.setParameter(param1);
            this._uniqueId = param1.uniqueId;
            this._playerId = parseInt(param1.playerId);
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            this.updateEmperorBonus();
            this._battleCount = param1.battleCount;
            this._trainingCount = param1.trainingCount;
            _hpMax = _loc_2.hp + param1.addHp;
            _lp = param1.lp;
            if (param1.sp != null)
            {
                this._sp = param1.sp;
                if (this._sp > _loc_2.sp)
                {
                    this._sp = _loc_2.sp;
                }
            }
            else
            {
                this._sp = calcDefaultSp(_loc_2);
            }
            this._spMax = _loc_2.sp;
            if (param1.spRecoveryTime != null)
            {
                this._spRecoveryTime = param1.spRecoveryTime;
            }
            else
            {
                this._spRecoveryTime = TimeClock.getNowTime();
            }
            _attack = _loc_2.attack + param1.addAtk;
            _defense = _loc_2.defense + param1.addDef;
            _speed = _loc_2.speed + param1.addSpd;
            _magicReasonable = _loc_2.magicReasonable;
            this._aOwnSkillData = [];
            for each (_loc_3 in param1.aOwnSkillData)
            {
                
                this._aOwnSkillData.push(new OwnSkillData(_loc_3));
            }
            this._aSetItemId = param1.aItem.concat();
            this.updateStatusItem();
            _useSkillId = BattleManager.getDefaultSkillId(_loc_2);
            this._bonusAtk = param1.bonusAtk == undefined ? (0) : (param1.bonusAtk);
            this._bonusDef = param1.bonusDef == undefined ? (0) : (param1.bonusDef);
            this._bonusSpd = param1.bonusSpd == undefined ? (0) : (param1.bonusSpd);
            this._bonusMag = param1.bonusMag == undefined ? (0) : (param1.bonusMag);
            this._bRestoreBonus = param1.bonusLimit == 1;
            this._restoreStartHp = param1.restoreStartHp;
            this._restoreStartTime = param1.restoreStartTime;
            this._restoreEndTime = param1.restoreEndTime;
            this._lastUseFacilityId = param1.lastUseFacility;
            this._lastUseFacilitySubId = param1.lastUseFacilitySub;
            this._useFacilityEndTime = param1.useFacilityEndTime;
            this._gotTime = param1.gotTime;
            this._formationBonusAtk = 0;
            this._formationBonusDef = 0;
            this._formationBonusSpd = 0;
            this._formationBonusMag = 0;
            this._commanderSkillBonus = null;
            if (_hp <= 0)
            {
                _bDead = true;
            }
            return;
        }// end function

        private function initialize() : void
        {
            this._battleCount = 0;
            this._trainingCount = 0;
            _lp = 0;
            this._sp = 0;
            this._spMax = 0;
            _attack = 0;
            _defense = 0;
            _speed = 0;
            this._aOwnSkillData = [];
            this._aSetItemId = [];
            this._emperorBonus = 0;
            this._emperorBonusTarget = 0;
            this._bonusAtk = 0;
            this._bonusDef = 0;
            this._bonusSpd = 0;
            this._bonusMag = 0;
            this._bRestoreBonus = false;
            this._restoreStartHp = 0;
            this._restoreStartTime = 0;
            this._restoreEndTime = 0;
            this._lastUseFacilityId = 0;
            this._lastUseFacilitySubId = 0;
            this._useFacilityEndTime = 0;
            this._gotTime = 0;
            this._formationBonusAtk = 0;
            this._formationBonusDef = 0;
            this._formationBonusSpd = 0;
            this._formationBonusMag = 0;
            this._commanderSkillBonus = null;
            this._aBadStatusToleranceItem = [];
            this._aDefenseToleranceItem = [];
            return;
        }// end function

        public function clone() : PlayerPersonal
        {
            var _loc_1:* = new PlayerPersonal();
            _loc_1.copyParam(this);
            return _loc_1;
        }// end function

        public function copyParam(param1:PlayerPersonal) : void
        {
            super.copyParameter(param1);
            this._uniqueId = param1.uniqueId;
            this._battleCount = param1.battleCount;
            this._trainingCount = param1.trainingCount;
            this._playerId = param1.playerId;
            _lp = param1.lp;
            this._sp = param1.sp;
            this._spMax = param1.spMax;
            this._spRecoveryTime = param1.spRecoveryTime;
            _attack = param1.attack;
            _defense = param1.defense;
            _speed = param1.speed;
            this._emperorBonus = param1.emperorBonus;
            this._emperorBonusTarget = param1.emperorBonusTarget;
            this._itemAtk = param1.itemAtk;
            this._itemDef = param1.itemDef;
            this._itemSpd = param1.itemSpd;
            this._itemMagic = param1.itemMagic;
            this._aDefenseToleranceItem = param1.aDefenseToleranceItem;
            this._aBadStatusToleranceItem = param1.aBadStatusToleranceItem;
            this._aOwnSkillData = param1.aOwnSkillData;
            this._aSetItemId = param1.aSetItemId;
            this._bonusAtk = param1.bonusAtk;
            this._bonusDef = param1.bonusDef;
            this._bonusSpd = param1.bonusSpd;
            this._bonusMag = param1.bonusMag;
            this._bRestoreBonus = param1.bRestoreBonus;
            this._restoreStartHp = param1.restoreStartHp;
            this._restoreStartTime = param1.restoreStartTime;
            this._restoreEndTime = param1.restoreEndTime;
            this._lastUseFacilityId = param1.lastUseFacilityId;
            this._lastUseFacilitySubId = param1.lastUseFacilitySubId;
            this._useFacilityEndTime = param1.useFacilityEndTime;
            this._gotTime = param1.gotTime;
            this._formationBonusAtk = param1.formationBonusAtk;
            this._formationBonusDef = param1.formationBonusDef;
            this._formationBonusSpd = param1.formationBonusSpd;
            this._formationBonusMag = param1.formationBonusMag;
            this._commanderSkillBonus = param1.commanderSkillBonus;
            return;
        }// end function

        public function copyParamOnEdit(param1:PlayerPersonal) : void
        {
            var _loc_2:* = _aSetSkillId;
            var _loc_3:* = this._aSetItemId;
            this.copyParam(param1);
            _aSetSkillId = _loc_2;
            this._aSetItemId = _loc_3;
            this.updateStatusItem();
            return;
        }// end function

        public function setEquippedItemId(param1:int, param2:int) : void
        {
            if (param1 >= 0 && param1 < this._aSetItemId.length)
            {
                this._aSetItemId[param1] = param2;
                this.updateStatusItem();
            }
            return;
        }// end function

        protected function updateStatusItem() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = false;
            this._itemAtk = 0;
            this._itemDef = 0;
            this._itemSpd = 0;
            this._itemMagic = 0;
            this._aDefenseToleranceItem = [];
            this._aBadStatusToleranceItem = [];
            for each (_loc_1 in this._aSetItemId)
            {
                
                if (_loc_1 <= Constant.EMPTY_ID)
                {
                    continue;
                }
                _loc_2 = ItemManager.getInstance().getItemStatus(_loc_1);
                this._itemAtk = this._itemAtk + _loc_2.addAttack;
                this._itemDef = this._itemDef + _loc_2.addDefense;
                this._itemSpd = this._itemSpd + _loc_2.addSpeed;
                this._itemMagic = this._itemMagic + _loc_2.addMagic;
                for each (_loc_3 in _loc_2.aDefenseTolerance)
                {
                    
                    _loc_5 = false;
                    for each (_loc_4 in this._aDefenseToleranceItem)
                    {
                        
                        if (_loc_4.toleranceId == _loc_3.toleranceId)
                        {
                            _loc_4.addRate(_loc_3.rate);
                            _loc_5 = true;
                            break;
                        }
                    }
                    if (!_loc_5)
                    {
                        this._aDefenseToleranceItem.push(_loc_3.clone());
                    }
                }
                for each (_loc_3 in _loc_2.aBadStatusTolerance)
                {
                    
                    _loc_5 = false;
                    for each (_loc_4 in this._aBadStatusToleranceItem)
                    {
                        
                        if (_loc_4.toleranceId == _loc_3.toleranceId)
                        {
                            _loc_4.addRate(_loc_3.rate);
                            _loc_5 = true;
                            break;
                        }
                    }
                    if (!_loc_5)
                    {
                        this._aBadStatusToleranceItem.push(_loc_3.clone());
                    }
                }
            }
            return;
        }// end function

        override public function damageHp(param1:int) : void
        {
            super.damageHp(param1);
            if (_bDead)
            {
                this._sp = 0;
            }
            return;
        }// end function

        public function damageLp(param1:int) : void
        {
            _lp = _lp - param1;
            if (_lp <= 0)
            {
                _lp = 0;
                _bDead = true;
            }
            return;
        }// end function

        public function decreaseSp(param1:int) : void
        {
            this._sp = this._sp - param1;
            if (this._sp <= 0)
            {
                this._sp = 0;
            }
            return;
        }// end function

        override public function addSp(param1:int) : void
        {
            this._sp = this._sp + param1;
            if (this._sp > this._spMax)
            {
                this._sp = this._spMax;
            }
            return;
        }// end function

        public function addMaxHp(param1:int) : void
        {
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            _hpMax = _hpMax + param1;
            _hp = _hp + param1;
            if (_hpMax > _loc_2.maxHp)
            {
                _hpMax = _loc_2.maxHp;
            }
            if (_hp > _hpMax)
            {
                _hp = _hpMax;
            }
            if (param1 < 0)
            {
                DebugLog.print("HPが減りました！？");
            }
            return;
        }// end function

        public function addAttack(param1:int) : void
        {
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            _attack = _attack + param1;
            if (_attack > _loc_2.maxAttack)
            {
                _attack = _loc_2.maxAttack;
            }
            if (param1 < 0)
            {
                DebugLog.print("攻撃力が減りました！？");
            }
            return;
        }// end function

        public function addDefense(param1:int) : void
        {
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            _defense = _defense + param1;
            if (_defense > _loc_2.maxDefense)
            {
                _defense = _loc_2.maxDefense;
            }
            if (param1 < 0)
            {
                DebugLog.print("防御力が減りました！？");
            }
            return;
        }// end function

        public function addSpeed(param1:int) : void
        {
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            _speed = _speed + param1;
            if (_speed > _loc_2.maxSpeed)
            {
                _speed = _loc_2.maxSpeed;
            }
            if (param1 < 0)
            {
                DebugLog.print("すばやさが減りました！？");
            }
            return;
        }// end function

        public function addOwnSkill(param1:int) : void
        {
            this._aOwnSkillData.push(new OwnSkillData({skillId:param1}));
            DebugLog.print("所持技へ追加:" + param1);
            return;
        }// end function

        public function isHaveSkill(param1:int) : Boolean
        {
            var skillId:* = param1;
            return this._aOwnSkillData.some(function (param1, param2:int, param3:Array) : Boolean
            {
                return (param1 as OwnSkillData).skillId == skillId;
            }// end function
            );
        }// end function

        public function updateOwnSkill(param1:OwnSkillData) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aOwnSkillData)
            {
                
                if (_loc_2.skillId == param1.skillId)
                {
                    _loc_2.powerChange = param1.powerChange;
                    _loc_2.hitChange = param1.hitChange;
                    _loc_2.spChange = param1.spChange;
                    _loc_2.spReduce = param1.spReduce;
                    return;
                }
            }
            return;
        }// end function

        public function isDying() : Boolean
        {
            return PlayerPersonal.isDying(_hp, _hpMax);
        }// end function

        public function isDyingAtResting() : Boolean
        {
            return this.isResting() ? (PlayerPersonal.isDying(this.getHpAtResting(), _hpMax)) : (PlayerPersonal.isDying(_hp, _hpMax));
        }// end function

        public function isLifeRunningOut() : Boolean
        {
            var _loc_1:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            return PlayerManager.getInstance().getLifeRunningLevel(_loc_1, this._battleCount) >= 5;
        }// end function

        public function isParamMax() : Boolean
        {
            var _loc_1:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            if (_loc_1)
            {
                return _hpMax >= _loc_1.maxHp && _attack >= _loc_1.maxAttack && _defense >= _loc_1.maxDefense && _speed >= _loc_1.maxSpeed;
            }
            return false;
        }// end function

        public function getGrowthTotal() : int
        {
            var _loc_1:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            var _loc_2:* = _hpMax - _loc_1.hp;
            var _loc_3:* = _attack - _loc_1.attack;
            var _loc_4:* = _defense - _loc_1.defense;
            var _loc_5:* = _speed - _loc_1.speed;
            return _loc_2 + _loc_3 + _loc_4 + _loc_5;
        }// end function

        public function getGrowthLabel() : String
        {
            var _loc_1:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            return PlayerPersonal.getGrowthLabel(_loc_1, this._battleCount);
        }// end function

        public function isUseFacility() : Boolean
        {
            return this._lastUseFacilityId != Constant.EMPTY_ID;
        }// end function

        public function isAwaitingCheckFacility() : Boolean
        {
            if (this._lastUseFacilityId == Constant.EMPTY_ID)
            {
                return false;
            }
            if (this._lastUseFacilityId == CommonConstant.FACILITY_ID_BARRACKS)
            {
                if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_3))
                {
                    return false;
                }
            }
            if (this._lastUseFacilityId == CommonConstant.FACILITY_ID_MAGIC_DEVELOP)
            {
                if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_4))
                {
                    return false;
                }
            }
            if (this._lastUseFacilityId == CommonConstant.FACILITY_ID_TRAINING_ROOM && this._lastUseFacilitySubId == CommonConstant.FACILITY_ID_SUB_TRAINING_KUMITE)
            {
                if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_6))
                {
                    return false;
                }
            }
            if (this._lastUseFacilityId == CommonConstant.FACILITY_ID_TRAINING_ROOM && this._lastUseFacilitySubId == CommonConstant.FACILITY_ID_SUB_TRAINING_TRAINING)
            {
                if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_4))
                {
                    return false;
                }
            }
            var _loc_1:* = TimeClock.getNowTime();
            return this.useFacilityEndTime < _loc_1;
        }// end function

        public function setUseFacility(param1:int, param2:int, param3:uint) : void
        {
            this._lastUseFacilityId = param1;
            this._lastUseFacilitySubId = param2;
            this._useFacilityEndTime = param3;
            return;
        }// end function

        public function resetUseFacility() : void
        {
            this._lastUseFacilityId = Constant.EMPTY_ID;
            this._lastUseFacilitySubId = Constant.EMPTY_ID;
            this._useFacilityEndTime = TimeClock.getNowTime();
            return;
        }// end function

        private function isResting() : Boolean
        {
            return this._lastUseFacilityId == CommonConstant.FACILITY_ID_BARRACKS;
        }// end function

        public function getHpAtResting() : int
        {
            var _loc_1:* = NaN;
            var _loc_2:* = 0;
            if (this.isResting())
            {
                _loc_1 = 0;
                if (this._restoreEndTime - this._restoreStartTime > 0)
                {
                    _loc_1 = this.getRestorePassTime(TimeClock.getNowTime()) / (this._restoreEndTime - this._restoreStartTime);
                }
                if (_loc_1 >= 1)
                {
                    return _hpMax;
                }
                _loc_2 = this._restoreStartHp + (_hpMax - this._restoreStartHp) * Math.max(_loc_1, 0);
                if (_loc_2 > _hpMax)
                {
                    _loc_2 = _hpMax;
                }
                if (_loc_2 < 0)
                {
                    _loc_2 = 0;
                }
                return _loc_2;
            }
            return _hp;
        }// end function

        public function setRestoreTime(param1:int, param2:uint, param3:uint, param4:int) : void
        {
            this._restoreStartHp = param1;
            this._restoreStartTime = param2;
            this._restoreEndTime = param3;
            this._useFacilityEndTime = param3;
            this._sp = Math.min(this._spMax, param4);
            return;
        }// end function

        public function getRestoreTimeSec() : int
        {
            var _loc_1:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            return PlayerPersonal.getRestoreTimeSec(_hp, this, _loc_1);
        }// end function

        public function getRestoreWaitTime(param1:uint) : int
        {
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_3))
            {
                return this._restoreEndTime - this._restoreStartTime;
            }
            return this._restoreEndTime > param1 ? (this._restoreEndTime - param1) : (0);
        }// end function

        private function getRestorePassTime(param1:uint) : int
        {
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_3))
            {
                return 0;
            }
            return param1 - this._restoreStartTime;
        }// end function

        public function isRestoreBonus() : Boolean
        {
            return this._bRestoreBonus;
        }// end function

        public function canEquippedAccessories(param1:ItemInformation) : Boolean
        {
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            if (param1.category == CommonConstant.EQUIPMENTTYPE_ACCESSORIES)
            {
                return true;
            }
            return false;
        }// end function

        public function resetSp() : void
        {
            var _loc_1:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            this._sp = calcDefaultSp(_loc_1);
            this._spRecoveryTime = TimeClock.getNowTime();
            return;
        }// end function

        public function recoverySp() : void
        {
            this._sp = this._spMax;
            this._spRecoveryTime = TimeClock.getNowTime();
            return;
        }// end function

        public function updateSp() : void
        {
            if (PlayerManager.getInstance().isSpStopPlayer(this._uniqueId))
            {
                return;
            }
            if (_bDead == false)
            {
                this.recoverySp();
            }
            return;
        }// end function

        public function updateSpRecoveryTime() : void
        {
            this._spRecoveryTime = TimeClock.getNowTime();
            return;
        }// end function

        public function getDefenseToleranceTotal() : Array
        {
            var _loc_1:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            var _loc_2:* = _loc_1.getDefenseTolerance();
            BattleToleranceData.addToleranceDataArray(_loc_2, this._aDefenseToleranceItem);
            if (this._commanderSkillBonus)
            {
                BattleToleranceData.addToleranceDataArray(_loc_2, this._commanderSkillBonus.aAddDefenseTolerance);
            }
            return _loc_2;
        }// end function

        public function isBonusDefenseTolerance(param1:int) : Boolean
        {
            var _loc_2:* = BattleToleranceData.getToleranceRate(this._aDefenseToleranceItem, param1);
            if (_loc_2 != 0)
            {
                return true;
            }
            if (this._commanderSkillBonus)
            {
                _loc_2 = BattleToleranceData.getToleranceRate(this._commanderSkillBonus.aAddDefenseTolerance, param1);
                if (_loc_2 != 0)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function getBadStatusToleranceTotal() : Array
        {
            var _loc_1:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            var _loc_2:* = _loc_1.getBadStatusTolerance();
            BattleToleranceData.addToleranceDataArray(_loc_2, this._aBadStatusToleranceItem);
            if (this._commanderSkillBonus)
            {
                BattleToleranceData.addToleranceDataArray(_loc_2, this._commanderSkillBonus.aAddBadStatusTolerance);
            }
            return _loc_2;
        }// end function

        public function isBonusBadStatusTolerance(param1:int) : Boolean
        {
            var _loc_2:* = BattleToleranceData.getToleranceRate(this._aBadStatusToleranceItem, param1);
            if (_loc_2 != 0)
            {
                return true;
            }
            if (this._commanderSkillBonus)
            {
                _loc_2 = BattleToleranceData.getToleranceRate(this._commanderSkillBonus.aAddBadStatusTolerance, param1);
                if (_loc_2 != 0)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function recoveryHp() : void
        {
            _hp = _hpMax;
            return;
        }// end function

        public function isFullHp() : Boolean
        {
            return _hp >= _hpMax;
        }// end function

        public function revive() : void
        {
            _bDead = false;
            _hp = Math.floor(_hpMax / 2) as int;
            return;
        }// end function

        public function isEmperor() : Boolean
        {
            return this._uniqueId == UserDataManager.getInstance().userData.emperorData.uniqueId;
        }// end function

        public function emperorUniqueIdOverride(param1:int) : void
        {
            if (this._uniqueId < 0)
            {
                this._uniqueId = param1;
            }
            return;
        }// end function

        public function updateEmperorBonus() : void
        {
            var _loc_3:* = null;
            this._emperorBonus = 0;
            this._emperorBonusTarget = PlayerConstant.EMPEROR_SKILL_TARGET_LESS;
            if (!BuildSwitch.SW_EMPEROR_SKILL)
            {
                return;
            }
            var _loc_1:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(UserDataManager.getInstance().userData.emperorData.emperorId);
            if (_loc_2)
            {
                _loc_3 = PlayerManager.getInstance().getEmperorSkill(_loc_2.characterId);
                if (_loc_3)
                {
                    if (PlayerManager.getInstance().isEmperorSkillTarget(_loc_1, _loc_2, _loc_3))
                    {
                        this._emperorBonus = UserDataManager.getInstance().userData.emperorData.bonus;
                    }
                    this._emperorBonusTarget = _loc_3.target;
                }
            }
            return;
        }// end function

        public function hasCommanderSkill() : Boolean
        {
            var _loc_1:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            return _loc_1.hasCommanderSkill();
        }// end function

        public static function isDying(param1:int, param2:int) : Boolean
        {
            return param2 > 0 && param1 * 100 / param2 < PLAYER_DYING_HP_PER;
        }// end function

        public static function getGrowthLabel(param1:PlayerInformation, param2:int) : String
        {
            return (1 + PlayerManager.getInstance().getLifeRunningLevel(param1, param2)).toString();
        }// end function

        public static function getRestoreTimeSec(param1:int, param2:PlayerPersonal, param3:PlayerInformation = null) : int
        {
            var _loc_4:* = CommonConstant.HP_RECOVERY_SECONDS * (param2.hpMax - param1);
            if (CommonConstant.HP_RECOVERY_SECONDS * (param2.hpMax - param1) < 0)
            {
                _loc_4 = 0;
            }
            return _loc_4;
        }// end function

        public static function calcDefaultSp(param1:PlayerInformation) : int
        {
            return param1.sp;
        }// end function

    }
}
