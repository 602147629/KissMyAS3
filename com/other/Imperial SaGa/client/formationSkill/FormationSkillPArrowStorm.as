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
    import skill.*;
    import sound.*;

    public class FormationSkillPArrowStorm extends FormationSkillBase
    {
        private var _mc2:MovieClip;
        private var _mc3:MovieClip;
        private var _mc4:MovieClip;
        private var _mc5:MovieClip;
        private var _mcArray:Array;
        private const _PHASE_BULLET:int = 10;
        private const _PHASE_HIT:int = 20;
        private var _ARROW_COUNT:int = 7;
        private var _aArrowY:Array;
        private var _aBullet:Array;
        private var _loopCount:int;
        private var _arrow:SkillPartsArrow;
        private var _aAnimationArrow:Array;
        private var _aWaitArrow:Array;
        private var _bDamageMotion:Boolean = false;
        private const _ARROW_SPEED:int = 2000;
        private var _arrowArray:Array;
        private var _hitBullet:Boolean = false;
        private var _hitCount:int = 0;
        private var _countMc:Array;

        public function FormationSkillPArrowStorm(param1:LayerBattle, param2:Array, param3:Array, param4:EffectManager)
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._aArrowY = [-175, 175, 100, -90, 125, -110, 90];
            this._aAnimationArrow = [];
            this._aWaitArrow = [];
            this._arrowArray = [];
            this._countMc = [0, 0, 0, 0, 0];
            super(param1, param2, param3, param4);
            this._mcArray = [];
            _mc = ResourceManager.getInstance().createMovieClip(getResource(), "position_chara_act");
            this._mc2 = ResourceManager.getInstance().createMovieClip(getResource(), "position_chara_act");
            this._mc3 = ResourceManager.getInstance().createMovieClip(getResource(), "position_chara_act");
            this._mc4 = ResourceManager.getInstance().createMovieClip(getResource(), "position_chara_act");
            this._mc5 = ResourceManager.getInstance().createMovieClip(getResource(), "position_chara_act");
            this._mcArray.push(_mc, this._mc2, this._mc3, this._mc4, this._mc5);
            var _loc_5:* = 0;
            while (_loc_5 < _aAttacer.length)
            {
                
                _loc_6 = _aAttacer[_loc_5] as BattleActionPlayer;
                _loc_7 = _loc_6.playerDisplay.pos;
                this._mcArray[_loc_5].x = _loc_7.x;
                this._mcArray[_loc_5].y = _loc_7.y;
                _layer.getLayer(LayerBattle.CHARACTER).addChild(this._mcArray[_loc_5]);
                _loc_5++;
            }
            _aNullMc = [];
            setPhase(_PHASE_APPROACH);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            this._countMc = [];
            this._countMc = null;
            this._arrowArray = [];
            this._arrowArray = null;
            if (_mc)
            {
                if (_mc.parent)
                {
                    _mc.parent.removeChild(_mc);
                }
            }
            _mc = null;
            if (this._mc2)
            {
                if (this._mc2.parent)
                {
                    this._mc2.parent.removeChild(this._mc2);
                }
            }
            this._mc2 = null;
            if (this._mc3)
            {
                if (this._mc3.parent)
                {
                    this._mc3.parent.removeChild(this._mc3);
                }
            }
            this._mc3 = null;
            if (this._mc4)
            {
                if (this._mc4.parent)
                {
                    this._mc4.parent.removeChild(this._mc4);
                }
            }
            this._mc4 = null;
            if (this._mc5)
            {
                if (this._mc5.parent)
                {
                    this._mc5.parent.removeChild(this._mc5);
                }
            }
            this._mc5 = null;
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
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < _aAttacer.length)
            {
                
                _loc_2 = _aAttacer[_loc_1] as BattleActionPlayer;
                _loc_3 = this._mcArray[_loc_1];
                _loc_4 = _loc_2.playerDisplay.info;
                if (_loc_4.weaponType == CommonConstant.CHARACTER_WEAPONTYPE_BOW)
                {
                    _loc_5 = "weapon_Bow";
                    _loc_6 = _loc_3.getChildByName("weaponNull1") as MovieClip;
                    _loc_7 = _loc_3.getChildByName("weaponNull2") as MovieClip;
                    if (_loc_6 != null && _loc_7 != null)
                    {
                        _loc_8 = createWeapon(_loc_5);
                        _loc_9 = createWeapon(_loc_5);
                        _loc_8.gotoAndStop(1);
                        _loc_9.gotoAndStop(2);
                        _loc_6.addChild(_loc_8);
                        _loc_7.addChild(_loc_9);
                        _aWeaponMc.push(_loc_8);
                        _aWeaponMc.push(_loc_9);
                    }
                }
                _loc_1++;
            }
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
                case this._PHASE_BULLET:
                {
                    this.controlBullet(param1);
                    break;
                }
                case this._PHASE_HIT:
                {
                    this.controlHit();
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
                case this._PHASE_BULLET:
                {
                    this.phaseBullet();
                    break;
                }
                case this._PHASE_HIT:
                {
                    this.phaseHit();
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
            return;
        }// end function

        override protected function controlApproach() : void
        {
            super.controlApproach();
            return;
        }// end function

        override protected function phaseAction() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.phaseAction();
            var _loc_1:* = 0;
            while (_loc_1 < _aAttacer.length)
            {
                
                _loc_2 = _aAttacer[_loc_1];
                _loc_3 = this._mcArray[_loc_1];
                _loc_4 = _loc_2.characterDisplay as PlayerDisplay;
                _loc_4.setAnimationPattern(_loc_3);
                _loc_1++;
            }
            return;
        }// end function

        override protected function controlAction() : void
        {
            super.controlAction();
            if (_mc.currentFrameLabel == "bullet")
            {
                setPhase(this._PHASE_BULLET);
            }
            return;
        }// end function

        private function getTarget(param1:BattleActionBase) : void
        {
            var _loc_2:* = param1.characterDisplay;
            var _loc_3:* = _loc_2.getEffectNullMatrix();
            var _loc_4:* = _loc_2.pos.add(new Point(_loc_3.tx, _loc_3.ty));
            _targetDisplayPos = _loc_4;
            return;
        }// end function

        private function getIntRandom(param1:int) : int
        {
            return (param1 + _aTarget.length) * Math.random();
        }// end function

        private function phaseBullet() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < _aAttacer.length)
            {
                
                _loc_2 = _aAttacer[_loc_1];
                _loc_3 = _loc_2.characterDisplay as PlayerDisplay;
                this._aBullet = [];
                this._loopCount = 0;
                _loc_4 = 0;
                while (_loc_4 < this._ARROW_COUNT)
                {
                    
                    this.getTarget(_aTarget[this.getIntRandom(0)]);
                    _loc_5 = _mc.bulletStartNullMc;
                    _loc_6 = ResourceManager.getInstance().createMovieClip(getResource(), "bullet");
                    _loc_7 = new Point(_loc_3.pos.x + _loc_5.x, _loc_3.pos.y + _loc_5.y);
                    _loc_8 = getSpeedVector(_loc_7, _targetDisplayPos, this._ARROW_SPEED);
                    _loc_9 = _loc_8.add(new Point(0, this._aArrowY[this._loopCount]));
                    if (_loc_4 == 3 || _loc_4 == 6)
                    {
                        _loc_10 = new SkillPartsArrow(_layer.getLayer(LayerBattle.FRONT_EFFECT), _loc_6, _loc_7, _loc_8);
                        _loc_10.setHitMake(getHitTime(_loc_7, _targetDisplayPos, this._ARROW_SPEED));
                    }
                    else
                    {
                        _loc_10 = new SkillPartsArrow(_layer.getLayer(LayerBattle.CHARACTER), _loc_6, _loc_7, _loc_9);
                    }
                    var _loc_11:* = this;
                    var _loc_12:* = this._loopCount + 1;
                    _loc_11._loopCount = _loc_12;
                    this._aBullet.push(_loc_10);
                    _loc_4++;
                }
                this._arrowArray.push(this._aBullet);
                _loc_1++;
            }
            return;
        }// end function

        private function controlBullet(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < _aAttacer.length)
            {
                
                if (this._countMc[_loc_2] < this._arrowArray[_loc_2].length)
                {
                    if (bValidateMain && this._arrowArray[_loc_2].length > 0)
                    {
                        switch(this._mcArray[_loc_2].currentLabel)
                        {
                            case _ACT_LABEL_BULLET:
                            {
                                this._aAnimationArrow.push(this._arrowArray[_loc_2][this._countMc[_loc_2]]);
                                SoundManager.getInstance().playSe(SoundId.SE_RS3_BOW_BOW);
                                var _loc_7:* = this._countMc;
                                var _loc_8:* = _loc_2;
                                var _loc_9:* = this._countMc[_loc_2] + 1;
                                _loc_7[_loc_8] = _loc_9;
                                break;
                            }
                            case "bulletLoop":
                            {
                                this._mcArray[_loc_2].gotoAndPlay("bulletStart");
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                }
                _loc_2++;
            }
            for each (_loc_3 in this._aAnimationArrow)
            {
                
                if (_loc_3)
                {
                    _loc_3.control(param1);
                    if (_loc_3.bHit)
                    {
                        var _loc_9:* = this;
                        var _loc_10:* = this._hitCount + 1;
                        _loc_9._hitCount = _loc_10;
                        if (this._hitCount == 2 * _aAttacer.length)
                        {
                            _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetDisplayPos);
                            addEffect(_loc_4, this.cbSetEffectPhase);
                        }
                        else
                        {
                            _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_3.pos);
                            addEffect(_loc_5);
                        }
                    }
                    if (this._bDamageMotion == false)
                    {
                        for each (_loc_6 in _aTarget)
                        {
                            
                            _loc_6.setActionDamageLoop();
                        }
                        this._bDamageMotion = true;
                    }
                    if (_loc_3.bEnd)
                    {
                        _loc_3.release();
                        this._aAnimationArrow.splice(this._aAnimationArrow.indexOf(_loc_3), 1);
                    }
                }
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    _loc_3 = 0;
                    while (_loc_3 < _aTarget.length)
                    {
                        
                        _loc_4 = _aTarget[_loc_3];
                        playDamage(_loc_4);
                        _loc_3++;
                    }
                    setPhase(this._PHASE_HIT);
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

        private function phaseHit() : void
        {
            return;
        }// end function

        private function controlHit() : void
        {
            switch(_mc.currentLabel)
            {
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
            return;
        }// end function

        override protected function phaseLeave() : void
        {
            super.phaseLeave();
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

        public static function getResource() : String
        {
            return ResourcePath.FORMATION_SKILL_PATH + "FormationSkill_ArrowStorm.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_ARROW_RUSH, SoundId.SE_RS3_BOW_BOW, SoundId.SE_ARROW_HIT];
            return _loc_1;
        }// end function

    }
}
