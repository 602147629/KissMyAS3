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
    import skill.*;
    import sound.*;

    public class FormationSkillPDragonTusk extends FormationSkillBase
    {
        private const _PHASE_ACTION_START:int = 20;
        private const _PHASE_MOVE_BULLET:int = 30;
        private const _PHASE_SWITCHING:int = 10;
        private var _mcArray:Array;
        private var count:int = 0;
        private var _aBullet:Array;
        private const _SHOT_SPEED:int = 4000;

        public function FormationSkillPDragonTusk(param1:LayerBattle, param2:Array, param3:Array, param4:EffectManager)
        {
            super(param1, param2, param3, param4);
            _mc = ResourceManager.getInstance().createMovieClip(getResource(), "position_chara_act");
            this.setTarget(_aTarget[0]);
            _aNullMc = [_mc.charaLay1, _mc.charaLay2, _mc.charaLay3, _mc.charaLay4, _mc.charaLay5];
            this.seGetCheck();
            setPhase(_PHASE_APPROACH);
            return;
        }// end function

        override public function release() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.release();
            var _loc_1:* = 0;
            while (_loc_1 < 5)
            {
                
                _loc_2 = _aNullMc.pop();
                _loc_3 = this._mcArray.pop();
                _loc_4 = this._mcArray.pop();
                _loc_2 = null;
                _loc_3 = null;
                _loc_4 = null;
                _loc_1++;
            }
            this._mcArray = [];
            return;
        }// end function

        override protected function selectControl(param1:Number) : void
        {
            switch(_phase)
            {
                case _PHASE_APPROACH:
                {
                    this.controlApproach();
                    break;
                }
                case _PHASE_ACTION:
                {
                    this.controlAction();
                    break;
                }
                case _PHASE_LEAVE:
                {
                    this.controlLeave();
                    break;
                }
                case _PHASE_END:
                {
                    this.controlEnd();
                    break;
                }
                case this._PHASE_SWITCHING:
                {
                    this.controlSwitching();
                    break;
                }
                case this._PHASE_ACTION_START:
                {
                    this.controlActionStart();
                    break;
                }
                case this._PHASE_MOVE_BULLET:
                {
                    this.controlMoveBullet(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function selectPhase() : void
        {
            switch(_phase)
            {
                case _PHASE_APPROACH:
                {
                    this.phaseApproach();
                    break;
                }
                case _PHASE_ACTION:
                {
                    this.phaseAction();
                    break;
                }
                case _PHASE_LEAVE:
                {
                    this.phaseLeave();
                    break;
                }
                case _PHASE_END:
                {
                    this.phaseEnd();
                    break;
                }
                case this._PHASE_SWITCHING:
                {
                    this.phaseSwitching();
                    break;
                }
                case this._PHASE_ACTION_START:
                {
                    this.phaseActionStart();
                    break;
                }
                case this._PHASE_MOVE_BULLET:
                {
                    this.phaseMoveBullet();
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
                _loc_4.setAnimation(PlayerDisplay.LABEL_JUMP);
                _loc_4.setTargetPoint(_loc_2.localToGlobal(new Point()), 0);
                _loc_1++;
            }
            SoundManager.getInstance().playSe(SoundId.SE_JUMP1);
            return;
        }// end function

        override protected function controlApproach() : void
        {
            if (SoundManager.getInstance().isListLoaded())
            {
                super.controlApproach();
            }
            return;
        }// end function

        override protected function phaseAction() : void
        {
            var _loc_1:* = null;
            super.phaseAction();
            this._mcArray = [];
            for each (_loc_1 in _aNullMc)
            {
                
                this.motionSettings(this.count);
            }
            return;
        }// end function

        override protected function controlAction() : void
        {
            this.count = 0;
            setPhase(this._PHASE_SWITCHING);
            return;
        }// end function

        private function phaseSwitching() : void
        {
            this._mcArray[this.count].gotoAndPlay(_ACT_LABEL_START);
            setPhase(this._PHASE_ACTION_START);
            return;
        }// end function

        private function controlSwitching() : void
        {
            return;
        }// end function

        private function phaseActionStart() : void
        {
            return;
        }// end function

        private function controlActionStart() : void
        {
            var _loc_1:* = _aTarget[0];
            if (this._mcArray.length == (this.count + 1) && this._mcArray[this.count].currentFrameLabel == _ACT_LABEL_HIT)
            {
                this.dragonTuskEffect(this.count);
                this.weponEffect(this.count);
            }
            else if (this._mcArray[this.count].currentFrameLabel == _ACT_LABEL_HIT)
            {
                this.dragonTuskEffect(this.count);
                this.weponEffect(this.count);
                _loc_1.setActionDamage();
                var _loc_2:* = this;
                var _loc_3:* = this.count + 1;
                _loc_2.count = _loc_3;
                setPhase(this._PHASE_SWITCHING);
            }
            if (this._mcArray[this.count].currentFrameLabel == "bullet")
            {
                setPhase(this._PHASE_MOVE_BULLET);
            }
            return;
        }// end function

        private function phaseMoveBullet() : void
        {
            var _loc_1:* = _aNullMc[this.count];
            var _loc_2:* = this._mcArray[this.count].bulletStartNullMc;
            this._aBullet = [];
            var _loc_3:* = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_Bow.swf", "bullet");
            var _loc_4:* = new Point(_loc_1.x + _loc_2.x, _loc_1.y + _loc_2.y);
            var _loc_5:* = getSpeedVector(_loc_4, _targetDisplayPos, this._SHOT_SPEED);
            var _loc_6:* = getHitTime(_loc_4, _targetDisplayPos, this._SHOT_SPEED);
            var _loc_7:* = new SkillPartsArrow(_layer.getLayer(LayerBattle.FRONT_EFFECT), _loc_3, _loc_4, _loc_5);
            new SkillPartsArrow(_layer.getLayer(LayerBattle.FRONT_EFFECT), _loc_3, _loc_4, _loc_5).setHitMake(_loc_6);
            this._aBullet.push(_loc_7);
            SoundManager.getInstance().playSe(SoundId.SE_RS3_BOW_BOW_ATTACK_NORMAL);
            return;
        }// end function

        private function controlMoveBullet(param1:Number) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = _aTarget[0];
            var _loc_3:* = this._aBullet.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4 = this._aBullet[_loc_3];
                _loc_4.control(param1);
                if (_loc_4.bHit)
                {
                    if (this._mcArray.length == (this.count + 1))
                    {
                        this.dragonTuskEffect(this.count);
                        this.weponEffect(this.count);
                        SoundManager.getInstance().playSe(SoundId.SE_ARROW_HIT);
                    }
                    else
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_ARROW_HIT);
                        this.dragonTuskEffect(this.count);
                        this.weponEffect(this.count);
                        _loc_2.setActionDamage();
                        var _loc_5:* = this;
                        var _loc_6:* = this.count + 1;
                        _loc_5.count = _loc_6;
                        setPhase(this._PHASE_SWITCHING);
                    }
                    _loc_4.release();
                    this._aBullet.splice(_loc_3, 1);
                }
                _loc_3 = _loc_3 - 1;
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_START:
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    setPhase(_PHASE_LEAVE);
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function motionSettings(param1:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_2:* = _aAttacer[param1];
            var _loc_3:* = _loc_2.playerDisplay;
            var _loc_4:* = _loc_2.playerDisplay.info;
            switch(_loc_3.info.weaponType)
            {
                case CommonConstant.CHARACTER_WEAPONTYPE_SWORD:
                case CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD:
                {
                    this._mcArray[param1] = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_Sword.swf", "position_chara_act");
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_AX:
                {
                    this._mcArray[param1] = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_Axe.swf", "position_chara_act");
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_CLUB:
                {
                    this._mcArray[param1] = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_Club.swf", "position_chara_act");
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_SPEAR:
                case CommonConstant.CHARACTER_WEAPONTYPE_HALBERD:
                {
                    this._mcArray[param1] = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_Spear.swf", "position_chara_act");
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD:
                {
                    this._mcArray[param1] = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_SmallSword.swf", "position_chara_act");
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS:
                case CommonConstant.CHARACTER_WEAPONTYPE_NAIL:
                {
                    this._mcArray[param1] = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_MartialArt1.swf", "position_chara_act");
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_BOW:
                {
                    this._mcArray[param1] = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Attack_Bow.swf", "position_chara_act");
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_3.info.weaponType == CommonConstant.CHARACTER_WEAPONTYPE_BOW)
            {
                _loc_5 = "weapon_Bow";
                _loc_6 = this._mcArray[param1].getChildByName("weaponNull1") as MovieClip;
                _loc_7 = this._mcArray[param1].getChildByName("weaponNull2") as MovieClip;
                if (_loc_6 != null && _loc_7 != null)
                {
                    _loc_8 = createWeapon(_loc_5);
                    _loc_9 = createWeapon(_loc_5);
                    _loc_8.gotoAndStop(1);
                    _loc_9.gotoAndStop(1);
                    _loc_6.addChild(_loc_8);
                    _loc_7.addChild(_loc_9);
                    _aWeaponMc.push(_loc_8);
                    _aWeaponMc.push(_loc_9);
                }
            }
            else if (_loc_3.info.weaponType == CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS)
            {
            }
            else
            {
                _loc_10 = this._mcArray[param1].getChildByName("weaponNull") as MovieClip;
                _loc_5 = FormationManager.getInstance().getWeaponClassName(_loc_4.weaponType);
                _loc_11 = createWeapon(_loc_5);
                _loc_11.gotoAndStop(1);
                _loc_10.addChild(_loc_11);
                _aWeaponMc.push(_loc_11);
            }
            this._mcArray[param1].gotoAndStop(1);
            _loc_3.setAnimationPattern(this._mcArray[param1]);
            _loc_3.layer.getLayer(LayerBattle.CHARACTER).addChild(this._mcArray[param1]);
            var _loc_12:* = this;
            var _loc_13:* = this.count + 1;
            _loc_12.count = _loc_13;
            return;
        }// end function

        private function weponEffect(param1:int) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = _aAttacer[param1];
            var _loc_3:* = _loc_2.playerDisplay;
            switch(_loc_3.info.weaponType)
            {
                case CommonConstant.CHARACTER_WEAPONTYPE_SWORD:
                case CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD:
                {
                    _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), ResourcePath.SKILL_PATH + "Attack_Sword.swf", _EFFECT_MC_HIT, _targetDisplayPos);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK);
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD:
                {
                    _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), ResourcePath.SKILL_PATH + "Attack_SmallSword.swf", _EFFECT_MC_HIT, _targetDisplayPos);
                    SoundManager.getInstance().playSe(SoundId.SE_ATACK1);
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_AX:
                {
                    _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), ResourcePath.SKILL_PATH + "Attack_Axe.swf", _EFFECT_MC_HIT, _targetDisplayPos);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_AXE_NORMAL_ATTACK);
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_CLUB:
                {
                    _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), ResourcePath.SKILL_PATH + "Attack_Club.swf", _EFFECT_MC_HIT, _targetDisplayPos);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_CLUB_NORMAL_ATTACK);
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_SPEAR:
                case CommonConstant.CHARACTER_WEAPONTYPE_HALBERD:
                {
                    _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), ResourcePath.SKILL_PATH + "Attack_Spear.swf", _EFFECT_MC_HIT, _targetDisplayPos);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_SPEAR_NORMAL_ATTACK);
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS:
                case CommonConstant.CHARACTER_WEAPONTYPE_NAIL:
                {
                    _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), ResourcePath.SKILL_PATH + "Attack_MartialArt1.swf", _EFFECT_MC_HIT, _targetDisplayPos);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_BLOW_PUNCH);
                    break;
                }
                case CommonConstant.CHARACTER_WEAPONTYPE_BOW:
                {
                    _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), ResourcePath.SKILL_PATH + "Attack_Bow.swf", _EFFECT_MC_HIT, _targetDisplayPos);
                    break;
                }
                default:
                {
                    break;
                }
            }
            addEffect(_loc_4);
            return;
        }// end function

        private function dragonTuskEffect(param1:int) : void
        {
            var _loc_2:* = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetDisplayPos);
            if (this._mcArray.length == (this.count + 1))
            {
                addEffect(_loc_2, this.cbSetEffectPhase);
            }
            else
            {
                addEffect(_loc_2);
            }
            return;
        }// end function

        override protected function phaseLeave() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < _aTarget.length)
            {
                
                _loc_3 = _aTarget[_loc_1];
                playDamage(_loc_3);
                _loc_1++;
            }
            super.phaseLeave();
            for each (_loc_2 in this._mcArray)
            {
                
                _loc_2.parent.removeChild(_loc_2);
            }
            setLeave();
            SoundManager.getInstance().playSe(SoundId.SE_JUMP1);
            return;
        }// end function

        override protected function controlLeave() : void
        {
            super.controlLeave();
            return;
        }// end function

        override protected function phaseEnd() : void
        {
            super.phaseEnd();
            return;
        }// end function

        override protected function controlEnd() : void
        {
            super.controlEnd();
            return;
        }// end function

        override protected function setTarget(param1:BattleActionBase) : void
        {
            var _loc_2:* = param1.characterDisplay;
            var _loc_3:* = _loc_2.getEffectNullMatrix();
            var _loc_4:* = _loc_2.pos.add(new Point(_loc_3.tx, _loc_3.ty));
            _targetDisplayPos = _loc_4;
            return;
        }// end function

        private function seGetCheck() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in _aAttacer)
            {
                
                _loc_2 = _loc_1.playerDisplay;
                switch(_loc_2.info.weaponType)
                {
                    case CommonConstant.CHARACTER_WEAPONTYPE_SWORD:
                    case CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD:
                    {
                        SoundManager.getInstance().loadSound(SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK);
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD:
                    {
                        SoundManager.getInstance().loadSound(SoundId.SE_ATACK1);
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_AX:
                    {
                        SoundManager.getInstance().loadSound(SoundId.SE_RS3_AXE_NORMAL_ATTACK);
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_CLUB:
                    {
                        SoundManager.getInstance().loadSound(SoundId.SE_RS3_CLUB_NORMAL_ATTACK);
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_SPEAR:
                    case CommonConstant.CHARACTER_WEAPONTYPE_HALBERD:
                    {
                        SoundManager.getInstance().loadSound(SoundId.SE_RS3_SPEAR_NORMAL_ATTACK);
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS:
                    case CommonConstant.CHARACTER_WEAPONTYPE_NAIL:
                    {
                        SoundManager.getInstance().loadSound(SoundId.SE_RS3_BLOW_PUNCH);
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_BOW:
                    {
                        SoundManager.getInstance().loadSound(SoundId.SE_ARROW_HIT);
                        SoundManager.getInstance().loadSound(SoundId.SE_RS3_BOW_BOW_ATTACK_NORMAL);
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

        public static function getResource() : String
        {
            return ResourcePath.FORMATION_SKILL_PATH + "FormationSkill_DragonTusk.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP1];
            return _loc_1;
        }// end function

    }
}
