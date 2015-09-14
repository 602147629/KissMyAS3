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

    public class SkillEMagicWaterThunderBall extends SkillMagicBase
    {
        private const _PHASE_BULLET_CREATE:int = 20;
        private const _PHASE_BULLET:int = 30;
        private const _PHASE_HIT:int = 40;
        private var _aBullet:Array;
        private const BULLET_SPEED:int = 1500;

        public function SkillEMagicWaterThunderBall(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
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
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = getMagicBulletStartNull(_baseMc.bulletStartNullMc);
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY && isBoss() == false)
            {
                _loc_3 = _skillUserDisplay.getEffectNullMatrix();
                _loc_4 = _skillUserDisplay.pos.add(new Point(_loc_3.tx, _loc_3.ty));
                _loc_1.y = _loc_4.y;
            }
            var _loc_2:* = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _ACT_LABEL_START_FRONT, _loc_1, _bReverse);
            addEffect(_loc_2, this.cbSetEffect);
            return;
        }// end function

        private function controlBulletCreate() : void
        {
            return;
        }// end function

        private function cbSetEffect(param1:EffectMc, param2:String) : void
        {
            switch(param2)
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
            return;
        }// end function

        private function phaseBullet() : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                if (isBoss())
                {
                    _bossEffect.gotoAndPlay(_ACT_LABEL_BACK);
                }
            }
            this._aBullet = [];
            var _loc_1:* = getMagicBulletStartNull(_baseMc.bulletStartNullMc);
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY && isBoss() == false)
            {
                _loc_6 = _skillUserDisplay.getEffectNullMatrix();
                _loc_7 = _skillUserDisplay.pos.add(new Point(_loc_6.tx, _loc_6.ty));
                _loc_1.y = _loc_7.y;
            }
            var _loc_2:* = this.getSpeedVector(_loc_1, _targetHitFrontPos, this.BULLET_SPEED);
            var _loc_3:* = this.getHitTime(_loc_1, _targetHitFrontPos, this.BULLET_SPEED);
            var _loc_4:* = ResourceManager.getInstance().createMovieClip(getResource(), "bullet");
            var _loc_5:* = new SkillPartsArrow(_layer.getLayer(LayerBattle.CHARACTER), _loc_4, _loc_1, _loc_2);
            new SkillPartsArrow(_layer.getLayer(LayerBattle.CHARACTER), _loc_4, _loc_1, _loc_2).setHitMake(_loc_3);
            this._aBullet.push(_loc_5);
            SoundManager.getInstance().playSe(SoundId.SE_ELECTRIC_SHOCK);
            return;
        }// end function

        private function controlBullet(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = this._aBullet.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aBullet[_loc_2];
                _loc_3.control(param1);
                if (_loc_3.bHit)
                {
                    _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                    addEffect(_loc_4, this.cbSetEffectPhase, cbEffectControl);
                    _loc_3.release();
                    this._aBullet.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            if (this._aBullet.length == 0 && this._aBullet.length == 0)
            {
                setPhase(this._PHASE_HIT);
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_START:
                {
                    break;
                }
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
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
            return ResourcePath.SKILL_ENEMY_PATH + "Magic_Water_ThunderBall.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_ELECTRIC_SHOCK];
            return _loc_1;
        }// end function

    }
}
