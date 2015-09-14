package formationSkill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import formation.*;
    import layer.*;
    import player.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class FormationSkillDoubleX extends FormationSkillBase
    {
        private static const _PHASE_APPROACH_NEXT:int = 5;
        private static const _ACT_LABEL_JUMP:String = "2ndJump";
        private static const _ACT_LABEL_LEAVE:String = "leave";
        private static const aNotDisplayWeapon:Array = [CommonConstant.CHARACTER_WEAPONTYPE_BOW, CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS];

        public function FormationSkillDoubleX(param1:LayerBattle, param2:Array, param3:Array, param4:EffectManager)
        {
            super(param1, param2, param3, param4);
            _mc = ResourceManager.getInstance().createMovieClip(getResource(), "advance_chara_act");
            setTarget(_aTarget[0]);
            _aNullMc = [_mc.charaNull, _mc.charaNull2, _mc.charaNull3, _mc.charaNull4];
            if (_aAttacer.length != _aNullMc.length)
            {
                Assert.print("攻撃をするキャラクターと必要人数があっていません");
            }
            else
            {
                this.setPhase(_PHASE_APPROACH);
            }
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override public function setWeapon() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < _aNullMc.length)
            {
                
                _loc_2 = _aAttacer[_loc_1] as BattleActionPlayer;
                _loc_3 = _aNullMc[_loc_1];
                _loc_4 = _loc_2.playerDisplay.info;
                if (_loc_3 == null)
                {
                    Assert.print("キャラクターのnull位置情報が存在しません");
                }
                if (aNotDisplayWeapon.indexOf(_loc_4.weaponType) == -1)
                {
                    _loc_5 = _loc_3.getChildByName("weaponNull") as MovieClip;
                    _loc_6 = FormationManager.getInstance().getWeaponClassName(_loc_4.weaponType);
                    _loc_7 = createWeapon(_loc_6);
                    _loc_7.gotoAndStop(1);
                    _loc_5.addChild(_loc_7);
                    _aWeaponMc.push(_loc_7);
                }
                _loc_1++;
            }
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            if (_phase == _PHASE_APPROACH_NEXT)
            {
                this.controlNextApproach();
            }
            if (bValidateMain)
            {
                switch(_mc.currentLabel)
                {
                    case _ACT_LABEL_JUMP:
                    {
                        this.setPhase(_PHASE_APPROACH_NEXT);
                        break;
                    }
                    case _ACT_LABEL_LEAVE:
                    {
                        this.leave();
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

        override protected function setPhase(param1:int) : void
        {
            super.setPhase(param1);
            if (_phase == _PHASE_APPROACH_NEXT)
            {
                this.phaseNextApproach();
            }
            return;
        }// end function

        override protected function phaseApproach() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.phaseApproach();
            var _loc_1:* = 0;
            while (_loc_1 < 2)
            {
                
                _loc_2 = _aNullMc[_loc_1];
                _loc_3 = _aAttacer[_loc_1];
                _loc_4 = _loc_3.playerDisplay;
                _loc_4.setTargetJump(new Point(_targetDisplayPos.x + _loc_2.x, _targetDisplayPos.y + _loc_2.y));
                _loc_1++;
            }
            return;
        }// end function

        private function phaseNextApproach() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = 2;
            while (_loc_1 < 4)
            {
                
                _loc_2 = _aNullMc[_loc_1];
                _loc_3 = _aAttacer[_loc_1];
                _loc_4 = _loc_3.playerDisplay;
                _loc_4.setTargetJump(new Point(_targetDisplayPos.x + _loc_2.x, _targetDisplayPos.y + _loc_2.y));
                _loc_1++;
            }
            return;
        }// end function

        private function controlNextApproach() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = true;
            var _loc_2:* = 2;
            while (_loc_2 < 4)
            {
                
                _loc_3 = _aAttacer[_loc_2];
                _loc_4 = _loc_3.playerDisplay;
                if (_loc_4.bMoveing == true)
                {
                    _loc_1 = false;
                    break;
                }
                _loc_2++;
            }
            if (_loc_1)
            {
                _loc_2 = 2;
                while (_loc_2 < 4)
                {
                    
                    _loc_5 = _aAttacer[_loc_2];
                    _loc_6 = _aNullMc[_loc_2];
                    if (_loc_5 != null && _loc_6 != null)
                    {
                        _loc_7 = _loc_5.characterDisplay as PlayerDisplay;
                        _loc_7.setAnimationPattern(_loc_6);
                        _loc_6.gotoAndPlay(_ACT_LABEL_START);
                    }
                    _loc_2++;
                }
                _phase = _PHASE_ACTION;
            }
            return;
        }// end function

        override protected function phaseAction() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.phaseAction();
            var _loc_1:* = 0;
            while (_loc_1 < 2)
            {
                
                _loc_2 = _aAttacer[_loc_1];
                _loc_3 = _aNullMc[_loc_1];
                if (_loc_2 != null && _loc_3 != null)
                {
                    _loc_4 = _loc_2.characterDisplay as PlayerDisplay;
                    _loc_4.setAnimationPattern(_loc_3);
                    _loc_3.gotoAndPlay(_ACT_LABEL_START);
                }
                _loc_1++;
            }
            _layer.getLayer(LayerBattle.CHARACTER).addChild(_mc);
            _mc.gotoAndPlay(_ACT_LABEL_START);
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.controlAction();
            if (bValidateMain)
            {
                switch(_mc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = _aTarget[0];
                        _loc_2 = _loc_1.characterDisplay;
                        _loc_3 = _loc_2.getEffectNullMatrix();
                        _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_2.pos.add(new Point(_loc_3.tx, _loc_3.ty)));
                        addEffect(_loc_4, this.cbEffectUpdate);
                        break;
                    }
                    case _ACT_LABEL_END:
                    {
                        _mc.gotoAndStop(_ACT_LABEL_END);
                        this.setPhase(_PHASE_LEAVE);
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

        override protected function phaseLeave() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.phaseLeave();
            var _loc_1:* = 2;
            while (_loc_1 < 4)
            {
                
                _loc_2 = _aNullMc[_loc_1];
                _loc_3 = _aAttacer[_loc_1];
                _loc_4 = _loc_3.playerDisplay;
                _loc_3.playerDisplay.setTargetJump(_loc_4.backupPosition);
                _loc_2.visible = false;
                _loc_1++;
            }
            return;
        }// end function

        protected function cbEffectUpdate(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_X);
                    _loc_3 = _aTarget[0];
                    _loc_3.setActionDamage();
                    break;
                }
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_XX);
                    _loc_4 = _aTarget[0];
                    playDamage(_loc_4);
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

        private function leave() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < 2)
            {
                
                _loc_2 = _aAttacer[_loc_1];
                _loc_3 = _loc_2.playerDisplay;
                _loc_3.setTargetJump(_loc_3.backupPosition);
                _loc_1++;
            }
            return;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.FORMATION_SKILL_PATH + "FormationSkill_DoubleX.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            return [SoundId.SE_X, SoundId.SE_XX];
        }// end function

    }
}
