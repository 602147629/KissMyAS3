package battle
{
    import flash.display.*;
    import flash.geom.*;
    import player.*;
    import resource.*;
    import skill.*;
    import sound.*;

    public class BattleActionPlayer extends BattleActionBase
    {
        public var _bAttackWait:Boolean;
        private var _deadEffect:BattlePlayerDead;
        private var _mcSheld:MovieClip;
        private var _mcGuardBase:MovieClip;
        private var _bLostAnimation:Boolean;

        public function BattleActionPlayer(param1:DisplayObjectContainer, param2:int, param3:BattleCharacterBase, param4:BattleCharacterStatus)
        {
            super(param3, param4);
            _parent = param1;
            _characterDisplay = new PlayerDisplay(param1, param2, questUniqueId);
            this._bAttackWait = false;
            this._mcGuardBase = null;
            this._mcSheld = null;
            setPhase(_PHASE_STAY);
            return;
        }// end function

        public function get playerDisplay() : PlayerDisplay
        {
            return _characterDisplay as PlayerDisplay;
        }// end function

        override public function release() : void
        {
            super.release();
            this.clearShield();
            this.clearGuardBase();
            _parent = null;
            return;
        }// end function

        private function clearShield() : void
        {
            if (this._mcSheld != null && this._mcSheld.parent != null)
            {
                this._mcSheld.parent.removeChild(this._mcSheld);
            }
            this._mcSheld = null;
            return;
        }// end function

        private function clearGuardBase() : void
        {
            if (this._mcGuardBase != null && this._mcGuardBase.parent != null)
            {
                this._mcGuardBase.parent.removeChild(this._mcGuardBase);
            }
            this._mcGuardBase = null;
            return;
        }// end function

        override protected function phaseStay() : void
        {
            this.clearShield();
            if (characterPersonal.bDead)
            {
                setPhase(_PHASE_DEAD);
                return;
            }
            if (PlayerPersonal.isDying(characterPersonal.hp, characterPersonal.hpMax) == false)
            {
                _characterDisplay.setAnimStay();
            }
            else
            {
                _characterDisplay.setAnimCrouch();
            }
            return;
        }// end function

        override protected function controlStay(param1:Number) : void
        {
            return;
        }// end function

        override protected function phaseSkillInput() : void
        {
            if (PlayerPersonal.isDying(characterPersonal.hp, characterPersonal.hpMax) == false)
            {
                if (SkillManager.isMagicSkill(_useSkillId))
                {
                    _characterDisplay.setAnimSelectMagic();
                }
                else
                {
                    _characterDisplay.setAnimSelect();
                }
            }
            else
            {
                _characterDisplay.setAnimCrouch();
            }
            return;
        }// end function

        override protected function controlSkillInput(param1:Number) : void
        {
            return;
        }// end function

        override protected function phaseSkillSelected() : void
        {
            if (PlayerPersonal.isDying(characterPersonal.hp, characterPersonal.hpMax) == false)
            {
                if (_status.bGuard == false)
                {
                    if (SkillManager.isMagicSkill(_useSkillId))
                    {
                        _characterDisplay.setAnimSelectedMagic();
                    }
                    else
                    {
                        _characterDisplay.setAnimSelected();
                    }
                }
                else
                {
                    _characterDisplay.setAnimSelectedGuard();
                }
            }
            else
            {
                _characterDisplay.setAnimCrouch();
            }
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
            _bActionEndWait = true;
            return;
        }// end function

        override protected function controlAttack(param1:Number) : void
        {
            if (_bActionEndWait == false)
            {
                this._bAttackWait = false;
                setPhase(_PHASE_STAY);
            }
            return;
        }// end function

        override protected function phaseDamage() : void
        {
            if (characterPersonal.bDead == false)
            {
                if (_status.bGuard)
                {
                    _characterDisplay.setAnimDamageGuard();
                }
                else
                {
                    _characterDisplay.setAnimDamage();
                }
            }
            else
            {
                _characterDisplay.setAnimDamageDead();
            }
            return;
        }// end function

        override protected function controlDamage(param1:Number) : void
        {
            if (_characterDisplay.bAnimationEnd && _bDamageDisp == false)
            {
                if (characterPersonal.bDead == false)
                {
                    if (this._bAttackWait)
                    {
                        setPhase(_PHASE_SKILL_SELECTED);
                    }
                    else
                    {
                        setPhase(_PHASE_STAY);
                    }
                }
                else
                {
                    setPhase(_PHASE_DEAD);
                }
            }
            return;
        }// end function

        override protected function phaseDamageLoop() : void
        {
            if (_status.bGuard == false)
            {
                _characterDisplay.setAnimDamage();
            }
            else
            {
                _characterDisplay.setAnimDamageGuard();
            }
            return;
        }// end function

        override protected function controlDamageLoop(param1:Number) : void
        {
            if (_status.bGuard == false)
            {
                _characterDisplay.setAnimDamage();
            }
            else
            {
                _characterDisplay.setAnimDamageGuard();
            }
            return;
        }// end function

        override protected function phaseGuardShield() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this.clearGuardPhase();
            switch(_status.shield)
            {
                case BattleConstant.DEFENSE_SHIELD_NORMAL:
                case BattleConstant.DEFENSE_SHIELD_GIRDER:
                {
                    this._mcSheld = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Weapons.swf", "weapon_Shield");
                    break;
                }
                case BattleConstant.DEFENSE_SHIELD_BIG:
                {
                    this._mcSheld = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Weapons.swf", "weapon_Shield_S");
                    break;
                }
                default:
                {
                    break;
                }
            }
            SoundManager.getInstance().playSe(SoundId.SE_GUARD);
            if (this._mcSheld != null)
            {
                this.createBaseMc("defense_guard");
                this._mcGuardBase.weaponNull.addChild(this._mcSheld);
                _loc_1 = _characterDisplay as PlayerDisplay;
                _characterDisplay.backupParent();
                _loc_2 = _characterDisplay.pos;
                this._mcGuardBase.x = _loc_2.x;
                this._mcGuardBase.y = _loc_2.y;
                _loc_1.setAnimationPattern(this._mcGuardBase);
            }
            return;
        }// end function

        override protected function controlGuardShield(param1:Number) : void
        {
            if (this._mcGuardBase.currentLabel == "end")
            {
                this.clearGuard();
                if (this._bAttackWait)
                {
                    setPhase(_PHASE_SKILL_SELECTED);
                }
                else
                {
                    setPhase(_PHASE_STAY);
                }
            }
            return;
        }// end function

        override protected function phaseCounter() : void
        {
            var _loc_3:* = null;
            var _loc_7:* = null;
            this.clearGuardPhase();
            _bActionEnd = true;
            var _loc_1:* = SkillManager.getInstance().getSkillInformation(_status.counterSkillId);
            var _loc_2:* = _loc_1 ? (SkillManager.getInstance().getDefenceMcName(_loc_1.effectId)) : ("");
            if (_loc_1 == null || _loc_2 == "")
            {
                setPhase(_PHASE_STAY);
                return;
            }
            _bCounterHitAnimation = true;
            this.createBaseMc(_loc_2);
            var _loc_4:* = this._mcGuardBase.getChildByName("weaponNullMoveMc") as DisplayObjectContainer;
            if (this._mcGuardBase.getChildByName("weaponNullMoveMc") as DisplayObjectContainer != null)
            {
                _loc_3 = _loc_4.getChildByName("weaponNull") as DisplayObjectContainer;
            }
            else
            {
                _loc_3 = this._mcGuardBase.getChildByName("weaponNull") as DisplayObjectContainer;
            }
            if (_loc_3 != null)
            {
                _loc_7 = SkillManager.getInstance().getWeaponClassName(_loc_1.effectId);
                if (_loc_7 != "")
                {
                    this._mcSheld = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Weapons.swf", _loc_7);
                    this._mcSheld.gotoAndStop(1);
                    _loc_3.addChild(this._mcSheld);
                }
            }
            var _loc_5:* = _characterDisplay as PlayerDisplay;
            _characterDisplay.backupParent();
            var _loc_6:* = _characterDisplay.pos;
            this._mcGuardBase.x = _loc_6.x;
            this._mcGuardBase.y = _loc_6.y;
            _loc_5.setAnimationPattern(this._mcGuardBase);
            return;
        }// end function

        override protected function controlCounter(param1:Number) : void
        {
            switch(this._mcGuardBase.currentFrameLabel)
            {
                case "start":
                {
                    switch(_status.counterSkillId)
                    {
                        case SkillId.SKILL_SPEAR_WINDMILL:
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_ROUND2);
                            break;
                        }
                        case SkillId.SKILL_SMALLSWORD_MATADOR:
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_JUMP3);
                            break;
                        }
                        case SkillId.SKILL_MARTIALART_COUNTER:
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_MART_COUNTER_SWISH);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case "hit":
                {
                    if (_cbCounterHit != null)
                    {
                        _cbCounterHit();
                    }
                    switch(_status.counterSkillId)
                    {
                        case SkillId.SKILL_SWORD_PARRY:
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_RS3_SWORD_PARRY);
                            break;
                        }
                        case SkillId.SKILL_SPEAR_WINDMILL:
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_RS3_BLOW_PUNCH);
                            break;
                        }
                        case SkillId.SKILL_SMALLSWORD_MATADOR:
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_ATACK1);
                            break;
                        }
                        case SkillId.SKILL_MARTIALART_COUNTER:
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_RS3_BLOW_PUNCH);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case "end":
                {
                    this.clearGuard();
                    _bCounterHitAnimation = false;
                    if (this._bAttackWait)
                    {
                        setPhase(_PHASE_SKILL_SELECTED);
                    }
                    else
                    {
                        setPhase(_PHASE_STAY);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function phaseDead() : void
        {
            var _loc_1:* = false;
            SoundManager.getInstance().playSe(SoundId.SE_DEAD1);
            _characterDisplay.setAnimDead();
            if (_bUseDeadEffect)
            {
                _loc_1 = false;
                if (characterPersonal as PlayerPersonal)
                {
                    _loc_1 = (characterPersonal as PlayerPersonal).isEmperor();
                }
                _bPlayingDeadEffect = true;
                this._deadEffect = new BattlePlayerDead(_parent, _characterDisplay as PlayerDisplay, characterPersonal.lp, _bBrokenItem, _loc_1);
                _bBrokenItem = false;
            }
            return;
        }// end function

        override protected function controlDead(param1:Number) : void
        {
            var _loc_2:* = false;
            if (this._deadEffect)
            {
                this._deadEffect.control(param1);
                if (this._deadEffect.bEnd)
                {
                    _loc_2 = false;
                    if (characterPersonal as PlayerPersonal)
                    {
                        _loc_2 = (characterPersonal as PlayerPersonal).isEmperor();
                    }
                    _characterDisplay.setAnimDead();
                    this._deadEffect.release();
                    this._deadEffect = null;
                    _bPlayingDeadEffect = false;
                    _bUseDeadEffect = false;
                    _characterDisplay.bGrayScale = !_loc_2 && characterPersonal.lp == 0 ? (true) : (false);
                }
            }
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

        override public function setActionStay() : void
        {
            setPhase(_PHASE_STAY);
            return;
        }// end function

        private function actionClear() : void
        {
            this.clearShield();
            this.clearGuardPhase();
            return;
        }// end function

        override public function setActionReset() : void
        {
            this.actionClear();
            this._bAttackWait = false;
            setPhase(_PHASE_STAY);
            return;
        }// end function

        override public function setActionSkillInput(param1:int) : void
        {
            super.setActionSkillInput(param1);
            this.actionClear();
            this._bAttackWait = true;
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
            setPhase(_PHASE_ATTACK);
            return;
        }// end function

        override public function setActionDamage() : void
        {
            if (_status.shield != BattleConstant.DEFENSE_SHIELD_NON)
            {
                setPhase(_PHASE_GUARD_SHIELD);
            }
            else if (_status.bCounterHit)
            {
                setPhase(_PHASE_BATTLE_WAIT);
            }
            else
            {
                setPhase(_PHASE_DAMAGE);
            }
            return;
        }// end function

        override public function setActionDamageLoop() : void
        {
            setPhase(_PHASE_DAMAGE_LOOP);
            return;
        }// end function

        override public function setActionDamageLoopRelease() : void
        {
            if (_phase == _PHASE_DAMAGE_LOOP)
            {
                setPhase(_PHASE_STAY);
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

        private function createBaseMc(param1:String) : void
        {
            this._mcGuardBase = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Defense_Guard.swf", param1);
            _parent.addChild(this._mcGuardBase);
            this._mcGuardBase.gotoAndPlay("start");
            return;
        }// end function

        private function clearGuardPhase() : void
        {
            this.clearGuard();
            return;
        }// end function

        private function clearGuard() : void
        {
            if (_phase != _PHASE_GUARD_SHIELD && _phase != _PHASE_COUNTER)
            {
                return;
            }
            _characterDisplay.returnParent();
            this.clearShield();
            this.clearGuardBase();
            return;
        }// end function

        public static function getSoundId() : Array
        {
            return [SoundId.SE_GUARD, SoundId.SE_DEAD1, SoundId.SE_REV_LOST_BREAK];
        }// end function

    }
}
