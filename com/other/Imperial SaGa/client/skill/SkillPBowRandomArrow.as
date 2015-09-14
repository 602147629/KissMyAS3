package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPBowRandomArrow extends SkillPositionBase
    {
        private var _formationPos:Point;
        private const _PHASE_BULLET:int = 20;
        private const _PHASE_HIT:int = 30;
        private var _ARROW_COUNT:int = 13;
        private var _aArrowY:Array;
        private var _aBullet:Array;
        private var _loopCount:int;
        private var _arrow:SkillPartsArrow;
        private var _aAnimationArrow:Array;
        private var _aWaitArrow:Array;
        private var _bDamageMotion:Boolean = false;
        private const _ARROW_SPEED:int = 2000;
        private var count:int = 0;

        public function SkillPBowRandomArrow(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            var _loc_7:* = null;
            this._aArrowY = [-800, -100, 1200, -1000, 500, -450, -1200, 100, 800, -750, 0, -600, 400];
            this._aBullet = [];
            this._aAnimationArrow = [];
            this._aWaitArrow = [];
            super(param1, param2, param3, param4, param5, getResource());
            var _loc_6:* = ResourceManager.getInstance().createMovieClip(getResource(), "nullPosition");
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                _loc_7 = _loc_6.playerNullMc;
                this._formationPos = new Point(_loc_7.x, _loc_7.y);
            }
            else
            {
                _loc_7 = _loc_6.enemyNullMc;
                this._formationPos = new Point(_loc_7.x, _loc_7.y);
            }
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override public function release() : void
        {
            this._formationPos = null;
            super.release();
            return;
        }// end function

        override protected function selectControl(param1:Number) : void
        {
            switch(_phase)
            {
                case _PHASE_WAIT:
                {
                    controlWait();
                    break;
                }
                case _PHASE_ACTION:
                {
                    this.controlAction();
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
                    this.controlHit(param1);
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
                case _PHASE_WAIT:
                {
                    phaseWait();
                    break;
                }
                case _PHASE_ACTION:
                {
                    this.phaseAction();
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

        override protected function phaseAction() : void
        {
            super.phaseAction();
            return;
        }// end function

        override protected function controlAction() : void
        {
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_BULLET:
                    {
                        setPhase(this._PHASE_BULLET);
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

        private function phaseBullet() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._ARROW_COUNT)
            {
                
                _loc_2 = ResourceManager.getInstance().createMovieClip(getResource(), "bullet");
                _loc_3 = getStartPosition();
                _loc_4 = getSpeedVector(_loc_3, this._formationPos, this._ARROW_SPEED);
                _loc_5 = _loc_4.add(new Point(0, this._aArrowY[this._loopCount]));
                if (this._loopCount == 10)
                {
                    _loc_6 = new SkillPartsArrow(_layer.getLayer(LayerBattle.CHARACTER), _loc_2, _loc_3, _loc_5);
                    _loc_6.setHitMake(getHitTime(_loc_3, this._formationPos, this._ARROW_SPEED));
                }
                else
                {
                    _loc_6 = new SkillPartsArrow(_layer.getLayer(LayerBattle.CHARACTER), _loc_2, _loc_3, _loc_5);
                }
                _loc_6.mc.visible = false;
                this._aBullet.push(_loc_6);
                var _loc_7:* = this;
                var _loc_8:* = this._loopCount + 1;
                _loc_7._loopCount = _loc_8;
                _loc_1++;
            }
            return;
        }// end function

        private function controlBullet(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (this.count < this._aBullet.length)
            {
                if (_bValidateMain && this._aBullet.length > 0)
                {
                    switch(_baseMc.currentLabel)
                    {
                        case _ACT_LABEL_BULLET:
                        {
                            this._aBullet[this.count].mc.visible = true;
                            this._aAnimationArrow.push(this._aBullet[this.count]);
                            SoundManager.getInstance().playSe(SoundId.SE_RS3_BOW_BOW);
                            var _loc_8:* = this;
                            var _loc_9:* = this.count + 1;
                            _loc_8.count = _loc_9;
                            break;
                        }
                        case _ACT_LABEL_BULLET_LOOP:
                        {
                            _baseMc.gotoAndPlay(_ACT_LABEL_BULLET_START);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            for each (_loc_2 in this._aAnimationArrow)
            {
                
                if (_loc_2)
                {
                    _loc_2.control(param1);
                    if (_loc_2.bHit)
                    {
                        _loc_3 = 0;
                        while (_loc_3 < _aTarget.length)
                        {
                            
                            _loc_4 = _aTarget[_loc_3];
                            _loc_5 = _loc_4.characterDisplay.getEffectNullMatrix();
                            _loc_6 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_4.characterDisplay.pos.add(new Point(_loc_5.tx, _loc_5.ty)), _bReverse);
                            addEffect(_loc_6, this.cbSetEffectPhase);
                            _loc_3++;
                        }
                    }
                    if (this._bDamageMotion == false)
                    {
                        for each (_loc_7 in _aTarget)
                        {
                            
                            _loc_7.setActionDamageLoop();
                        }
                        this._bDamageMotion = true;
                    }
                    if (_loc_2.bEnd)
                    {
                        _loc_2.release();
                        this._aAnimationArrow.splice(this._aAnimationArrow.indexOf(_loc_2), 1);
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
                    SoundManager.getInstance().playSe(SoundId.SE_ARROW_HIT);
                    _loc_3 = 0;
                    while (_loc_3 < _aTarget.length)
                    {
                        
                        _loc_4 = _aTarget[_loc_3] as BattleActionBase;
                        playDamage(_loc_4);
                        _loc_4.setActionDamageLoopRelease();
                        _loc_3++;
                    }
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    setPhase(this._PHASE_HIT);
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

        private function controlHit(param1:Number) : void
        {
            switch(_baseMc.currentLabel)
            {
                case _ACT_LABEL_END:
                {
                    setPhase(_PHASE_END);
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
            return ResourcePath.SKILL_PATH + "Skill_Bow_RandomArrow.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_ARROW_HIT, SoundId.SE_RS3_BOW_BOW, SoundId.SE_RS3_BOW_RANDOM_ARROW];
            return _loc_1;
        }// end function

    }
}
