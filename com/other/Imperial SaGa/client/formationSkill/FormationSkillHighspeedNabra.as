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

    public class FormationSkillHighspeedNabra extends FormationSkillBase
    {
        private static const aNotDisplayWeapon:Array = [CommonConstant.CHARACTER_WEAPONTYPE_BOW, CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS];

        public function FormationSkillHighspeedNabra(param1:LayerBattle, param2:Array, param3:Array, param4:EffectManager)
        {
            super(param1, param2, param3, param4);
            _mc = ResourceManager.getInstance().createMovieClip(getResource(), "advance_chara_act");
            setTarget(_aTarget[0]);
            _aNullMc = [_mc.chara1Null, _mc.chara2Null, _mc.chara3Null];
            if (_aAttacer.length != _aNullMc.length)
            {
                Assert.print("攻撃をするキャラクターと必要人数があっていません");
            }
            else
            {
                setPhase(_PHASE_APPROACH);
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

        override protected function phaseApproach() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.phaseApproach();
            var _loc_1:* = 0;
            while (_loc_1 < _aNullMc.length && _loc_1 < _aAttacer.length)
            {
                
                _loc_2 = _aNullMc[_loc_1];
                _loc_3 = _aAttacer[_loc_1];
                _loc_4 = _loc_3.playerDisplay;
                _loc_4.setTargetJump(new Point(_targetDisplayPos.x + _loc_2.x, _targetDisplayPos.y + _loc_2.y));
                _loc_1++;
            }
            SoundManager.getInstance().playSe(SoundId.SE_AXE_SWISH);
            return;
        }// end function

        override protected function phaseAction() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.phaseAction();
            _layer.getLayer(LayerBattle.CHARACTER).addChild(_mc);
            var _loc_1:* = 0;
            while (_loc_1 < _aNullMc.length)
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

        override protected function phaseLeave() : void
        {
            super.phaseLeave();
            setLeave();
            return;
        }// end function

        protected function cbEffectUpdate(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK);
                    SoundManager.getInstance().playSe(SoundId.SE_ATACK5);
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

        public static function getResource() : String
        {
            return ResourcePath.FORMATION_SKILL_PATH + "FormationSkill_HighspeedNabra.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            return [SoundId.SE_AXE_SWISH, SoundId.SE_AXE_HIT, SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK, SoundId.SE_ATACK5];
        }// end function

    }
}
