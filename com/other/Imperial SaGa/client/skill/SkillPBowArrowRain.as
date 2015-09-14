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
    import utility.*;

    public class SkillPBowArrowRain extends SkillPositionBase
    {
        private var _formationPos:Point;
        private var _layerArrow:Sprite;
        private var _aAnimationArrow:Array;
        private var _aWaitArrow:Array;
        private var _waitTime:Number;
        private var _bDamageMotion:Boolean;
        private const _FALL_INTERVAL:Number = 0.05;
        private const _FALL_RANGE:Number = 300;
        private const _SHOT_SPEED:int = 1300;
        private const _FALL_SPEED:int = 700;
        private const _PHASE_SHOT:int = 20;
        private const _PHASE_FALL:int = 30;
        private const _SHOT_NUM:int = 6;

        public function SkillPBowArrowRain(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            var _loc_7:* = null;
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
            this._layerArrow = _layer.getLayer(LayerBattle.FRONT_EFFECT);
            this._aAnimationArrow = [];
            this._aWaitArrow = [];
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            if (this._aAnimationArrow)
            {
                for each (_loc_1 in this._aAnimationArrow)
                {
                    
                    _loc_1.release();
                }
            }
            this._aAnimationArrow = null;
            this._aWaitArrow = null;
            this._layerArrow = null;
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
                case this._PHASE_SHOT:
                {
                    this.controlShot(param1);
                    break;
                }
                case this._PHASE_FALL:
                {
                    this.controlFall(param1);
                    break;
                }
                case _PHASE_END:
                {
                    this.controlEnd();
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
                case this._PHASE_SHOT:
                {
                    this.phaseShot();
                    break;
                }
                case this._PHASE_FALL:
                {
                    this.phaseFall();
                    break;
                }
                case _PHASE_END:
                {
                    this.phaseEnd();
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
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_BULLET_START:
                    {
                        setPhase(this._PHASE_SHOT);
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function phaseShot() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._SHOT_NUM)
            {
                
                _loc_2 = new Point(-1, 0);
                _loc_3 = new Matrix();
                _loc_3.rotate((Random.range(0, 20) + 45) * Math.PI / 180);
                _loc_3.scale(this._SHOT_SPEED, this._SHOT_SPEED);
                if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
                {
                    _loc_3.scale(-1, 1);
                }
                _loc_2 = _loc_3.transformPoint(_loc_2);
                this._aWaitArrow.push(_loc_2);
                _loc_1++;
            }
            return;
        }// end function

        private function controlShot(param1:Number) : void
        {
            var _loc_2:* = null;
            if (_bValidateMain && this._aWaitArrow.length > 0)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_BULLET:
                    {
                        this._aAnimationArrow.push(this.createArrow(getStartPosition(), this._aWaitArrow.pop()));
                        break;
                    }
                    case _ACT_LABEL_BULLET_LOOP:
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_RS3_BOW_BOW);
                        _baseMc.gotoAndPlay(_ACT_LABEL_BULLET_START);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            for each (_loc_2 in this._aAnimationArrow)
            {
                
                _loc_2.control(param1);
                if (_loc_2.bEnd)
                {
                    _loc_2.release();
                    this._aAnimationArrow.splice(this._aAnimationArrow.indexOf(_loc_2), 1);
                    if (this._aAnimationArrow.length == 0)
                    {
                        setPhase(this._PHASE_FALL);
                    }
                }
            }
            return;
        }// end function

        private function phaseFall() : void
        {
            var _loc_3:* = null;
            this._waitTime = this._FALL_INTERVAL;
            this._bDamageMotion = false;
            setTarget(_aTarget[0]);
            var _loc_1:* = new Point(this._formationPos.x, 0);
            var _loc_2:* = 0;
            while (_loc_2 < this._SHOT_NUM * 5)
            {
                
                _loc_3 = new Point(Random.range(0, this._FALL_RANGE) - this._FALL_RANGE * 0.5, Random.range(0, this._FALL_RANGE) - this._FALL_RANGE * 0.5);
                this._aWaitArrow.push(_loc_3.add(_loc_1));
                _loc_2++;
            }
            return;
        }// end function

        private function controlFall(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = null;
            var _loc_8:* = null;
            this._waitTime = this._waitTime - param1;
            if (this._waitTime <= 0)
            {
                if (this._aWaitArrow.length > 0)
                {
                    this._waitTime = this._FALL_INTERVAL;
                    _loc_3 = new Point(0, 1);
                    _loc_4 = new Matrix();
                    _loc_4.scale(this._FALL_SPEED, this._FALL_SPEED);
                    _loc_3 = _loc_4.transformPoint(_loc_3);
                    _loc_5 = this.createArrow(this._aWaitArrow.pop(), _loc_3);
                    _loc_6 = this._formationPos.y / _loc_3.y;
                    _loc_6 = _loc_6 + Random.range(0, 10) * 0.001;
                    _loc_5.setHitMake(_loc_6);
                    this._aAnimationArrow.push(_loc_5);
                }
            }
            for each (_loc_2 in this._aAnimationArrow)
            {
                
                _loc_2.control(param1);
                if (_loc_2.bHit)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_ARROW_HIT);
                    _loc_2.release();
                    this._aAnimationArrow.splice(this._aAnimationArrow.indexOf(_loc_2), 1);
                    _loc_7 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_2.pos, _bReverse);
                    if (this._bDamageMotion == false)
                    {
                        for each (_loc_8 in _aTarget)
                        {
                            
                            _loc_8.setActionDamageLoop();
                        }
                        this._bDamageMotion = true;
                    }
                    if (this._aAnimationArrow.length == 0)
                    {
                        for each (_loc_8 in _aTarget)
                        {
                            
                            playDamage(_loc_8);
                            _loc_8.setActionDamageLoopRelease();
                        }
                        addEffect(_loc_7, this.cbSetEffectPhase);
                        continue;
                    }
                    addEffect(_loc_7);
                }
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_END:
                {
                    setPhase(_PHASE_END);
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

        private function createArrow(param1:Point, param2:Point) : SkillPartsArrow
        {
            var _loc_3:* = ResourceManager.getInstance().createMovieClip(getResource(), _EFFECT_MC_BULLET);
            var _loc_4:* = new SkillPartsArrow(_layer.getLayer(LayerBattle.CHARACTER), _loc_3, param1, param2);
            return new SkillPartsArrow(_layer.getLayer(LayerBattle.CHARACTER), _loc_3, param1, param2);
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.SKILL_PATH + "Skill_Bow_ArrowRain.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_ARROW_HIT, SoundId.SE_RS3_BOW_BOW];
            return _loc_1;
        }// end function

    }
}
