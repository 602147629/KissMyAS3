package battle
{
    import character.*;
    import flash.display.*;

    public class BattleActionBase extends Object
    {
        protected var _parent:DisplayObjectContainer;
        protected var _phase:int;
        protected var _battleCharacter:BattleCharacterBase;
        protected var _characterDisplay:CharacterDisplayBase;
        protected var _useSkillId:int;
        protected var _status:BattleCharacterStatus;
        protected var _bDeadDisable:Boolean;
        protected var _bActionEnd:Boolean;
        protected var _bActionEndWait:Boolean;
        protected var _bDamageDisp:Boolean;
        protected var _bUseDeadEffect:Boolean;
        protected var _bBrokenItem:Boolean;
        protected var _bPlayingDeadEffect:Boolean;
        protected var _bAttackAnimation:Boolean;
        protected var _bCounterHitAnimation:Boolean;
        protected var _cbCounterHit:Function;
        static const _PHASE_STAY:int = 1;
        static const _PHASE_SKILL_INPUT:int = 10;
        static const _PHASE_SKILL_SELECTED:int = 11;
        static const _PHASE_BATTLE_WAIT:int = 20;
        static const _PHASE_ATTACK:int = 30;
        static const _PHASE_DAMAGE:int = 40;
        static const _PHASE_DAMAGE_LOOP:int = 41;
        static const _PHASE_GUARD_SHIELD:int = 45;
        static const _PHASE_COUNTER:int = 47;
        static const _PHASE_DEAD:int = 50;
        static const _PHASE_WIN:int = 60;
        static const _PHASE_STATUS_UP:int = 70;
        static const _PHASE_METAMORPHOSE_START:int = 80;
        static const _PHASE_METAMORPHOSE_END:int = 81;

        public function BattleActionBase(param1:BattleCharacterBase, param2:BattleCharacterStatus)
        {
            this._parent = null;
            this._characterDisplay = null;
            this._battleCharacter = param1;
            this._status = param2;
            this._bDamageDisp = false;
            this._bAttackAnimation = false;
            this._bCounterHitAnimation = false;
            this._bDeadDisable = false;
            return;
        }// end function

        public function get characterDisplay() : CharacterDisplayBase
        {
            return this._characterDisplay;
        }// end function

        public function get characterPersonal() : CharacterPersonal
        {
            return this._battleCharacter.personal;
        }// end function

        public function get questUniqueId() : int
        {
            return this._battleCharacter.personal.questUniqueId;
        }// end function

        public function set bDeadDisable(param1:Boolean) : void
        {
            this._bDeadDisable = param1;
            return;
        }// end function

        public function get bAnimationEnd() : Boolean
        {
            return this._characterDisplay.bAnimationEnd;
        }// end function

        public function get bActionEnd() : Boolean
        {
            return this._bActionEnd;
        }// end function

        public function disableActionEndWait() : void
        {
            this._bActionEndWait = false;
            return;
        }// end function

        public function get bDamageDisp() : Boolean
        {
            return this._bDamageDisp;
        }// end function

        public function set bDamageDisp(param1:Boolean) : void
        {
            this._bDamageDisp = param1;
            return;
        }// end function

        public function get bUseDeadEffect() : Boolean
        {
            return this._bUseDeadEffect;
        }// end function

        public function setUseDeadEffect() : void
        {
            this._bUseDeadEffect = true;
            return;
        }// end function

        public function get bBrokenItem() : Boolean
        {
            return this._bBrokenItem;
        }// end function

        public function setBrokenItem() : void
        {
            this._bBrokenItem = true;
            return;
        }// end function

        public function get bPlayingDeadEffect() : Boolean
        {
            return this._bPlayingDeadEffect;
        }// end function

        public function get bAttackAnimation() : Boolean
        {
            return this._bAttackAnimation;
        }// end function

        public function get bCounterHitAnimation() : Boolean
        {
            return this._bCounterHitAnimation;
        }// end function

        public function get type() : int
        {
            return this._characterDisplay.type;
        }// end function

        public function setUseSkillId(param1:int) : void
        {
            this._battleCharacter.personal.useSkillId = param1;
            this._useSkillId = param1;
            return;
        }// end function

        public function isStay() : Boolean
        {
            return this._phase == _PHASE_STAY;
        }// end function

        public function isDead() : Boolean
        {
            return this._phase == _PHASE_DEAD;
        }// end function

        public function release() : void
        {
            if (this._characterDisplay)
            {
                this._characterDisplay.release();
            }
            this._characterDisplay = null;
            this._cbCounterHit = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case _PHASE_STAY:
                {
                    this.controlStay(param1);
                    break;
                }
                case _PHASE_SKILL_INPUT:
                {
                    this.controlSkillInput(param1);
                    break;
                }
                case _PHASE_SKILL_SELECTED:
                {
                    this.controlSkillSelected(param1);
                    break;
                }
                case _PHASE_BATTLE_WAIT:
                {
                    this.controlBattleWait(param1);
                    break;
                }
                case _PHASE_ATTACK:
                {
                    this.controlAttack(param1);
                    break;
                }
                case _PHASE_DAMAGE:
                {
                    this.controlDamage(param1);
                    break;
                }
                case _PHASE_DAMAGE_LOOP:
                {
                    this.controlDamageLoop(param1);
                    break;
                }
                case _PHASE_GUARD_SHIELD:
                {
                    this.controlGuardShield(param1);
                    break;
                }
                case _PHASE_COUNTER:
                {
                    this.controlCounter(param1);
                    break;
                }
                case _PHASE_DEAD:
                {
                    this.controlDead(param1);
                    break;
                }
                case _PHASE_WIN:
                {
                    this.controlWin(param1);
                    break;
                }
                case _PHASE_STATUS_UP:
                {
                    this.controlStatusUp(param1);
                    break;
                }
                case _PHASE_METAMORPHOSE_START:
                {
                    this.controlMetamorphoseStart(param1);
                    break;
                }
                case _PHASE_METAMORPHOSE_END:
                {
                    this.controlMetamorphoseEnd(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._characterDisplay != null)
            {
                this._characterDisplay.control(param1);
            }
            return;
        }// end function

        protected function setPhase(param1:int) : void
        {
            this._phase = param1;
            this._bActionEnd = false;
            switch(this._phase)
            {
                case _PHASE_STAY:
                {
                    this.phaseStay();
                    break;
                }
                case _PHASE_SKILL_INPUT:
                {
                    this.phaseSkillInput();
                    break;
                }
                case _PHASE_SKILL_SELECTED:
                {
                    this.phaseSkillSelected();
                    break;
                }
                case _PHASE_BATTLE_WAIT:
                {
                    this.phaseBattleWait();
                    break;
                }
                case _PHASE_ATTACK:
                {
                    this.phaseAttack();
                    break;
                }
                case _PHASE_DAMAGE:
                {
                    this.phaseDamage();
                    break;
                }
                case _PHASE_DAMAGE_LOOP:
                {
                    this.phaseDamageLoop();
                    break;
                }
                case _PHASE_GUARD_SHIELD:
                {
                    this.phaseGuardShield();
                    break;
                }
                case _PHASE_COUNTER:
                {
                    this.phaseCounter();
                    break;
                }
                case _PHASE_DEAD:
                {
                    this.phaseDead();
                    break;
                }
                case _PHASE_WIN:
                {
                    this.phaseWin();
                    break;
                }
                case _PHASE_STATUS_UP:
                {
                    this.phaseStatusUp();
                    break;
                }
                case _PHASE_METAMORPHOSE_START:
                {
                    this.phaseMetamorphoseStart();
                    break;
                }
                case _PHASE_METAMORPHOSE_END:
                {
                    this.phaseMetamorphoseEnd();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function phaseStay() : void
        {
            return;
        }// end function

        protected function controlStay(param1:Number) : void
        {
            return;
        }// end function

        protected function phaseSkillInput() : void
        {
            return;
        }// end function

        protected function controlSkillInput(param1:Number) : void
        {
            return;
        }// end function

        protected function phaseSkillSelected() : void
        {
            return;
        }// end function

        protected function controlSkillSelected(param1:Number) : void
        {
            return;
        }// end function

        protected function phaseBattleWait() : void
        {
            return;
        }// end function

        protected function controlBattleWait(param1:Number) : void
        {
            return;
        }// end function

        protected function phaseAttack() : void
        {
            return;
        }// end function

        protected function controlAttack(param1:Number) : void
        {
            return;
        }// end function

        protected function phaseDamage() : void
        {
            return;
        }// end function

        protected function controlDamage(param1:Number) : void
        {
            return;
        }// end function

        protected function phaseDamageLoop() : void
        {
            return;
        }// end function

        protected function controlDamageLoop(param1:Number) : void
        {
            return;
        }// end function

        protected function phaseGuardShield() : void
        {
            return;
        }// end function

        protected function controlGuardShield(param1:Number) : void
        {
            return;
        }// end function

        protected function phaseCounter() : void
        {
            return;
        }// end function

        protected function controlCounter(param1:Number) : void
        {
            return;
        }// end function

        protected function phaseDead() : void
        {
            return;
        }// end function

        protected function controlDead(param1:Number) : void
        {
            return;
        }// end function

        protected function phaseWin() : void
        {
            return;
        }// end function

        protected function controlWin(param1:Number) : void
        {
            return;
        }// end function

        protected function phaseStatusUp() : void
        {
            return;
        }// end function

        protected function controlStatusUp(param1:Number) : void
        {
            return;
        }// end function

        protected function phaseMetamorphoseStart() : void
        {
            this._bActionEnd = false;
            return;
        }// end function

        protected function controlMetamorphoseStart(param1:Number) : void
        {
            return;
        }// end function

        protected function phaseMetamorphoseEnd() : void
        {
            this._bActionEnd = false;
            return;
        }// end function

        protected function controlMetamorphoseEnd(param1:Number) : void
        {
            return;
        }// end function

        public function setActionStay() : void
        {
            return;
        }// end function

        public function setActionReset() : void
        {
            return;
        }// end function

        public function setActionSkillInput(param1:int) : void
        {
            this.setUseSkillId(param1);
            return;
        }// end function

        public function setActionSkillSelected() : void
        {
            return;
        }// end function

        public function setActionBattleWait() : void
        {
            return;
        }// end function

        public function setActionAttack() : void
        {
            return;
        }// end function

        public function setActionDamage() : void
        {
            return;
        }// end function

        public function setActionDamageLoop() : void
        {
            return;
        }// end function

        public function setActionDamageLoopRelease() : void
        {
            return;
        }// end function

        public function setActionDead() : void
        {
            return;
        }// end function

        public function setActionWin() : void
        {
            return;
        }// end function

        public function setActionStatusUp() : void
        {
            return;
        }// end function

        public function setActionMetamorphoseStart() : void
        {
            return;
        }// end function

        public function setActionMetamorphoseEnd() : void
        {
            return;
        }// end function

        public function setCbCounterHit(param1:Function) : void
        {
            this._cbCounterHit = param1;
            return;
        }// end function

    }
}
