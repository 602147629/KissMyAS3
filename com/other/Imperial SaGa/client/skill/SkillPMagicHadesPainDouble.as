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

    public class SkillPMagicHadesPainDouble extends SkillMagicBase
    {
        private const _PHASE_BULLET_CREATE:int = 20;
        private const _PHASE_BULLET:int = 30;
        private const _PHASE_HIT:int = 40;
        private var _createBullet:EffectMc;
        private var _effAfterImage:EffectAfterImage;
        private var _bulletMc:MovieClip;
        private var _bulletPos:Point;
        private var _hitTime:Number;
        private var _throwH:Number;
        private var _throwHAcc:Number;
        private var _throwHTime:Number;
        private var _speedVec:Point;
        private const _TOP_POS:int = 0;
        private const _BULLET_SPEED:int = 500;

        public function SkillPMagicHadesPainDouble(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_HADES))
            {
                playCastingSE();
            }
            setPhase(_PHASE_WAIT);
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
                case this._PHASE_BULLET_CREATE:
                {
                    this.controlBulletCreate();
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
                case this._PHASE_BULLET_CREATE:
                {
                    this.phaseBulletCreate();
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
            if (isBoss() == false)
            {
                playCastingSE();
            }
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
                        setPhase(this._PHASE_BULLET_CREATE);
                        break;
                    }
                    case _ACT_LABEL_END:
                    {
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

        private function phaseBulletCreate() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_1 = _baseMc.bulletStartNullMc;
            _loc_2 = _skillUserDisplay.pos;
            if (_bReverse)
            {
                _loc_3 = new Point(_loc_2.x - _loc_1.x, _loc_2.y + _loc_1.y);
            }
            else
            {
                _loc_3 = new Point(_loc_2.x + _loc_1.x, _loc_2.y + _loc_1.y);
            }
            this._createBullet = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _ACT_LABEL_START_FRONT, _loc_3, _bReverse);
            addEffect(this._createBullet);
            return;
        }// end function

        private function controlBulletCreate() : void
        {
            if (this._createBullet.mcEffect.currentLabel == _ACT_LABEL_BULLET)
            {
                setPhase(this._PHASE_BULLET);
            }
            return;
        }// end function

        private function phaseBullet() : void
        {
            var _loc_1:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                if (isBoss())
                {
                    _bossEffect.gotoAndPlay(_ACT_LABEL_BACK);
                }
            }
            var _loc_2:* = this._createBullet.mcEffect.bulletStartNullMc;
            var _loc_3:* = _baseMc.bulletStartNullMc;
            _loc_1 = _skillUserDisplay.pos;
            if (_bReverse)
            {
                this._bulletPos = new Point(_loc_1.x - _loc_2.x - _loc_3.x, _loc_1.y + _loc_2.y + _loc_3.y);
            }
            else
            {
                this._bulletPos = new Point(_loc_1.x + _loc_2.x + _loc_3.x, _loc_1.y + _loc_2.y + _loc_3.y);
            }
            this._bulletMc = ResourceManager.getInstance().createMovieClip(getResource(), _EFFECT_MC_BULLET);
            _layer.getLayer(LayerBattle.FRONT_EFFECT).addChild(this._bulletMc);
            var _loc_4:* = _targetHitFrontPos.clone();
            this._speedVec = getSpeedVector(this._bulletPos, _loc_4, this._BULLET_SPEED);
            this._hitTime = getHitTime(this._bulletPos, _loc_4, this._BULLET_SPEED);
            this._throwHAcc = -10;
            this._throwH = 0;
            this._throwHTime = this._hitTime / 2;
            var _loc_5:* = new Matrix();
            new Matrix().translate(this._bulletPos.x, this._bulletPos.y);
            this._bulletMc.transform.matrix = _loc_5;
            this._effAfterImage = new EffectAfterImage(_layer.getLayer(LayerBattle.BACK_EFFECT), _layer.getLayer(LayerBattle.FRONT_EFFECT), 0.7);
            _effectManager.addEffect(this._effAfterImage);
            this._effAfterImage.bDraw = true;
            return;
        }// end function

        private function controlBullet(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._hitTime > 0)
            {
                this._hitTime = this._hitTime - param1;
                _loc_2 = new Matrix();
                _loc_2.scale(param1, param1);
                _loc_3 = _loc_2.transformPoint(this._speedVec);
                this._bulletPos = this._bulletPos.add(_loc_3);
                _loc_4 = new Matrix();
                this._throwH = this._throwH + this._throwHAcc;
                this._throwHAcc = this._throwHAcc + 10 / this._throwHTime * param1;
                _loc_4.translate(0, this._throwH);
                _loc_4.translate(this._bulletPos.x, this._bulletPos.y);
                this._bulletMc.transform.matrix = _loc_4;
            }
            if (this._hitTime <= 0)
            {
                if (this._bulletMc != null && this._bulletMc.parent != null)
                {
                    this._bulletMc.parent.removeChild(this._bulletMc);
                }
                this._effAfterImage.bDraw = false;
                if (this._effAfterImage)
                {
                    _effectManager.releaseEffect(this._effAfterImage);
                    this._effAfterImage = null;
                }
                this._bulletMc = null;
                _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                addEffect(_loc_5, this.cbSetEffectPhase);
                setPhase(this._PHASE_HIT);
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_BATTLE_SPACE);
                    playDamageAll();
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    _baseMc.gotoAndPlay(_ACT_LABEL_BACK);
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
            if (_bValidateMain)
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
            return ResourcePath.SKILL_PATH + "Magic_Hades_PainDouble.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_BATTLE_SPACE];
            return _loc_1;
        }// end function

    }
}
