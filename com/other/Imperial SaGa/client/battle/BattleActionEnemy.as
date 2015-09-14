package battle
{
    import enemy.*;
    import flash.display.*;
    import skill.*;
    import sound.*;

    public class BattleActionEnemy extends BattleActionBase
    {
        protected var _aDeadImmortalEnemyId:Array;

        public function BattleActionEnemy(param1:DisplayObjectContainer, param2:int, param3:BattleCharacterBase, param4:BattleCharacterStatus)
        {
            this._aDeadImmortalEnemyId = [];
            super(param3, param4);
            this.setDisplay(param1, param2, characterPersonal.questUniqueId);
            setPhase(_PHASE_STAY);
            return;
        }// end function

        public function set aDeadImmortalEnemyId(param1:Array) : void
        {
            this._aDeadImmortalEnemyId = param1;
            return;
        }// end function

        public function get enemyDisplay() : EnemyDisplay
        {
            return _characterDisplay as EnemyDisplay;
        }// end function

        public function setDisplay(param1:DisplayObjectContainer, param2:int, param3:int) : void
        {
            _characterDisplay = EnemyManager.getInstance().createEnemyDisplay(param1, param2, param3);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override protected function phaseStay() : void
        {
            _bAttackAnimation = false;
            _characterDisplay.setAnimStay();
            return;
        }// end function

        override protected function controlStay(param1:Number) : void
        {
            return;
        }// end function

        override protected function phaseSkillInput() : void
        {
            return;
        }// end function

        override protected function controlSkillInput(param1:Number) : void
        {
            return;
        }// end function

        override protected function phaseSkillSelected() : void
        {
            return;
        }// end function

        override protected function controlSkillSelected(param1:Number) : void
        {
            return;
        }// end function

        override protected function phaseBattleWait() : void
        {
            _characterDisplay.setAnimBattleWait();
            return;
        }// end function

        override protected function controlBattleWait(param1:Number) : void
        {
            return;
        }// end function

        override protected function phaseAttack() : void
        {
            if (SkillManager.isMagicSkill(_useSkillId))
            {
                _characterDisplay.setAnimMagic();
            }
            else
            {
                _characterDisplay.setAnimAttack();
            }
            _bAttackAnimation = true;
            return;
        }// end function

        override protected function controlAttack(param1:Number) : void
        {
            if (_characterDisplay.bAnimationEnd)
            {
                _bAttackAnimation = false;
                setPhase(_PHASE_STAY);
            }
            return;
        }// end function

        override protected function phaseDamage() : void
        {
            _characterDisplay.setAnimDamage();
            return;
        }// end function

        override protected function controlDamage(param1:Number) : void
        {
            if (_characterDisplay.bAnimationEnd)
            {
                if (this._aDeadImmortalEnemyId.length > 0 && this._aDeadImmortalEnemyId.indexOf(this.enemyDisplay.info.id) != -1)
                {
                    setPhase(_PHASE_STAY);
                }
                else if (characterPersonal.bDead == false || _bDeadDisable)
                {
                    setPhase(_PHASE_STAY);
                }
                else
                {
                    setPhase(_PHASE_DEAD);
                }
                _bDeadDisable = false;
            }
            return;
        }// end function

        override protected function phaseDamageLoop() : void
        {
            _characterDisplay.setAnimDamageLoop();
            return;
        }// end function

        override protected function controlDamageLoop(param1:Number) : void
        {
            return;
        }// end function

        override protected function phaseCounter() : void
        {
            _bCounterHitAnimation = true;
            _characterDisplay.setAnimAttack();
            return;
        }// end function

        override protected function controlCounter(param1:Number) : void
        {
            if (_characterDisplay.bAnimationEnd)
            {
                _bCounterHitAnimation = false;
                setPhase(_PHASE_STAY);
            }
            return;
        }// end function

        override protected function phaseDead() : void
        {
            SoundManager.getInstance().playSe(SoundId.SE_RS3_OTHER_ENEMY_DEATH);
            _bAttackAnimation = false;
            _characterDisplay.setAnimDead();
            return;
        }// end function

        override protected function controlDead(param1:Number) : void
        {
            return;
        }// end function

        override protected function phaseWin() : void
        {
            _characterDisplay.setAnimWin();
            return;
        }// end function

        override protected function controlWin(param1:Number) : void
        {
            return;
        }// end function

        override protected function phaseStatusUp() : void
        {
            _characterDisplay.setAnimStatusUp();
            return;
        }// end function

        override protected function controlStatusUp(param1:Number) : void
        {
            return;
        }// end function

        override protected function phaseMetamorphoseStart() : void
        {
            this.enemyDisplay.setAnimMetamorphoseOut();
            return;
        }// end function

        override protected function controlMetamorphoseStart(param1:Number) : void
        {
            if (_characterDisplay.bAnimationEnd)
            {
                _bActionEnd = true;
            }
            return;
        }// end function

        override protected function phaseMetamorphoseEnd() : void
        {
            this.enemyDisplay.setAnimMetamorphoseIn();
            return;
        }// end function

        override protected function controlMetamorphoseEnd(param1:Number) : void
        {
            if (_characterDisplay.bAnimationEnd)
            {
                setPhase(_PHASE_STAY);
            }
            return;
        }// end function

        override public function setActionStay() : void
        {
            setPhase(_PHASE_STAY);
            return;
        }// end function

        override public function setActionSkillInput(param1:int) : void
        {
            super.setActionSkillInput(param1);
            setPhase(_PHASE_SKILL_INPUT);
            return;
        }// end function

        override public function setActionSkillSelected() : void
        {
            super.setActionSkillSelected();
            setPhase(_PHASE_SKILL_SELECTED);
            return;
        }// end function

        override public function setActionBattleWait() : void
        {
            setPhase(_PHASE_BATTLE_WAIT);
            return;
        }// end function

        override public function setActionAttack() : void
        {
            super.setActionAttack();
            setPhase(_PHASE_ATTACK);
            return;
        }// end function

        override public function setActionDamage() : void
        {
            if (_phase != _PHASE_DEAD)
            {
                if (_status.bCounterHit)
                {
                    setPhase(_PHASE_BATTLE_WAIT);
                }
                else
                {
                    setPhase(_PHASE_DAMAGE);
                }
            }
            return;
        }// end function

        override public function setActionDamageLoop() : void
        {
            if (_phase != _PHASE_DEAD)
            {
                setPhase(_PHASE_DAMAGE_LOOP);
            }
            return;
        }// end function

        override public function setActionDamageLoopRelease() : void
        {
            super.setActionDamageLoopRelease();
            if (_phase != _PHASE_DEAD)
            {
                _characterDisplay.setAnimDamageLoopRelease();
            }
            return;
        }// end function

        override public function setActionDead() : void
        {
            if (characterPersonal.bDead && _phase != _PHASE_DAMAGE && _phase != _PHASE_DEAD)
            {
                setPhase(_PHASE_DEAD);
            }
            return;
        }// end function

        override public function setActionWin() : void
        {
            setPhase(_PHASE_WIN);
            return;
        }// end function

        override public function setActionStatusUp() : void
        {
            setPhase(_PHASE_STATUS_UP);
            return;
        }// end function

        override public function setActionMetamorphoseStart() : void
        {
            setPhase(_PHASE_METAMORPHOSE_START);
            return;
        }// end function

        override public function setActionMetamorphoseEnd() : void
        {
            setPhase(_PHASE_METAMORPHOSE_END);
            return;
        }// end function

        public static function getSoundResource() : Array
        {
            var _loc_1:* = [SoundId.SE_RS3_OTHER_ENEMY_DEATH];
            return _loc_1;
        }// end function

    }
}
