package formationSkill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import player.*;
    import resource.*;
    import sound.*;

    public class FormationSkillStrongerTackle extends FormationSkillBase
    {
        private var _aActionMc:Array;
        private var _bLoopEnd:Boolean;
        private var _bNextAttacker:Boolean;
        private var _mc2:MovieClip;
        private var _attackCnt:int;
        private static const _PHASE_ATTACKER_APPROACH:int = 5;
        private static const _PHASE_ATTACKER_ACTION:int = 6;
        private static const _ACT_LABEL_LOOP_START:String = "loopIn";
        private static const _ACT_LABEL_LOOP_END:String = "loopOut";

        public function FormationSkillStrongerTackle(param1:LayerBattle, param2:Array, param3:Array, param4:EffectManager)
        {
            super(param1, param2, param3, param4);
            _mc = ResourceManager.getInstance().createMovieClip(getResource(), "advance_chara_act");
            this._attackCnt = 0;
            this._bLoopEnd = false;
            this._aActionMc = [];
            setTarget(_aTarget[0]);
            this._bNextAttacker = false;
            if (_aAttacer.length == 3)
            {
                this._bNextAttacker = true;
            }
            setPhase(_PHASE_APPROACH);
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            super.release();
            for each (_loc_1 in this._aActionMc)
            {
                
                if (_loc_1 && _loc_1.parent)
                {
                    _loc_1.parent.removeChild(_loc_1);
                }
            }
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            super.control(param1);
            switch(_phase)
            {
                case _PHASE_ATTACKER_APPROACH:
                {
                    this.controlAttackerApproach();
                    break;
                }
                case _PHASE_ATTACKER_ACTION:
                {
                    this.controlAttackerAction();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (bValidateMain)
            {
                switch(_mc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
                        _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetDisplayPos);
                        addEffect(_loc_2, this.cbEffectUpdate);
                        break;
                    }
                    case _ACT_LABEL_LOOP_END:
                    {
                        if (this._bLoopEnd == false)
                        {
                            _mc.gotoAndPlay(_ACT_LABEL_LOOP_START);
                            _mc.charaNull.gotoAndPlay(_ACT_LABEL_LOOP_START);
                        }
                        break;
                    }
                    case _ACT_LABEL_END:
                    {
                        setPhase(_PHASE_LEAVE);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        override protected function selectPhase() : void
        {
            super.selectPhase();
            switch(_phase)
            {
                case _PHASE_ATTACKER_APPROACH:
                {
                    this.phaseAttackerApproach();
                    break;
                }
                case _PHASE_ATTACKER_ACTION:
                {
                    this.phaseAttackerAction();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function phaseApproach() : void
        {
            super.phaseApproach();
            var _loc_1:* = _aAttacer[(_aAttacer.length - 1)];
            var _loc_2:* = _loc_1.playerDisplay;
            _loc_2.setTargetJump(new Point(_targetDisplayPos.x + _mc.charaNull.x, _targetDisplayPos.y + _mc.charaNull.y));
            setPhase(_PHASE_ATTACKER_APPROACH);
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            _layer.getLayer(LayerBattle.CHARACTER).addChild(_mc);
            var _loc_1:* = _aAttacer[(_aAttacer.length - 1)];
            var _loc_2:* = _mc.charaNull;
            var _loc_3:* = _loc_1.characterDisplay as PlayerDisplay;
            _loc_3.setAnimationPattern(_loc_2);
            _mc.gotoAndPlay(_ACT_LABEL_START);
            _loc_2.gotoAndPlay(_ACT_LABEL_START);
            setPhase(_PHASE_ATTACKER_ACTION);
            return;
        }// end function

        override protected function controlAction() : void
        {
            super.controlAction();
            return;
        }// end function

        override protected function phaseLeave() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.phaseLeave();
            var _loc_1:* = _aAttacer[(_aAttacer.length - 1)];
            var _loc_2:* = _mc.charaNull;
            if (_loc_1 != null && _loc_1.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_3 = _loc_1.characterDisplay as PlayerDisplay;
                _loc_4 = new Point(_mc.x, _mc.y);
                _loc_3.pos = _loc_4.add(new Point(_loc_2.x, _loc_2.y));
                _loc_3.setTargetJump(_loc_3.backupPosition);
            }
            _mc.visible = false;
            return;
        }// end function

        private function phaseAttackerApproach() : void
        {
            if (this._mc2 && this._mc2.parent)
            {
                this._mc2.parent.removeChild(this._mc2);
            }
            this._mc2 = ResourceManager.getInstance().createMovieClip(getResource(), "advance_chara_act2");
            this._mc2.x = _targetDisplayPos.x;
            this._mc2.y = _targetDisplayPos.y;
            var _loc_1:* = _aAttacer[this._attackCnt];
            var _loc_2:* = _loc_1.playerDisplay;
            _loc_2.setTargetJump(new Point(_targetDisplayPos.x + this._mc2.charaNull.x, _targetDisplayPos.y + this._mc2.charaNull.y));
            this._aActionMc.push(this._mc2);
            return;
        }// end function

        private function controlAttackerApproach() : void
        {
            if (bMoveing() == false)
            {
                setPhase(_PHASE_ACTION);
            }
            return;
        }// end function

        private function phaseAttackerAction() : void
        {
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._mc2);
            var _loc_1:* = _aAttacer[this._attackCnt];
            var _loc_2:* = this._mc2.charaNull;
            var _loc_3:* = _loc_1.characterDisplay as PlayerDisplay;
            _loc_3.setAnimationPattern(_loc_2);
            this._mc2.gotoAndPlay(_ACT_LABEL_START);
            _loc_2.gotoAndPlay(_ACT_LABEL_START);
            SoundManager.getInstance().playSe(SoundId.SE_RS3_SPEAR_CHARGE);
            return;
        }// end function

        private function controlAttackerAction() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            switch(this._mc2.currentFrameLabel)
            {
                case _ACT_LABEL_HIT:
                {
                    _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), "hit_front2", _targetDisplayPos);
                    addEffect(_loc_1, this.cbEffectUpdate2);
                    break;
                }
                case _ACT_LABEL_END:
                {
                    _loc_2 = _aAttacer[this._attackCnt];
                    _loc_3 = this._mc2.charaNull;
                    if (_loc_2 != null && _loc_2.type == CharacterDisplayBase.TYPE_PLAYER)
                    {
                        _loc_4 = _loc_2.characterDisplay as PlayerDisplay;
                        _loc_5 = new Point(this._mc2.x, this._mc2.y);
                        _loc_4.pos = _loc_5.add(new Point(_loc_3.x, _loc_3.y));
                        _loc_4.setTargetJump(_loc_4.backupPosition);
                    }
                    this._mc2.visible = false;
                    if (this._bNextAttacker == false || this._attackCnt > 0)
                    {
                        this._bLoopEnd = true;
                        _phase = _PHASE_ACTION;
                    }
                    if (this._bNextAttacker && this._attackCnt == 0)
                    {
                        var _loc_6:* = this;
                        var _loc_7:* = this._attackCnt + 1;
                        _loc_6._attackCnt = _loc_7;
                        setPhase(_PHASE_ATTACKER_APPROACH);
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

        override protected function phaseEnd() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < _aAttacer.length)
            {
                
                _loc_2 = _aAttacer[_loc_1];
                if (_loc_2 != null)
                {
                    _loc_2.characterDisplay.returnParent();
                    _loc_2.disableActionEndWait();
                }
                _loc_1++;
            }
            _bSkillEnd = true;
            return;
        }// end function

        protected function cbEffectUpdate(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_ATACK3);
                    _loc_3 = _aTarget[0];
                    playDamage(_loc_3);
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        protected function cbEffectUpdate2(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = _aTarget[0];
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_BLOW_PUNCH);
                    _loc_3.setActionDamage();
                    break;
                }
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_STEP);
                    _loc_3.setActionDamage();
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.FORMATION_SKILL_PATH + "FormationSkill_StrongerTackle.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            return [SoundId.SE_RS3_SPEAR_CHARGE, SoundId.SE_RS3_SPEAR_CHARGE_STAB_WITH_A_SPEAR, SoundId.SE_RS3_BLOW_PUNCH, SoundId.SE_ATACK3, SoundId.SE_STEP];
        }// end function

    }
}
