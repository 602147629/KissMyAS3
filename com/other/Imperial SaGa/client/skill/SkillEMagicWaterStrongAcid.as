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

    public class SkillEMagicWaterStrongAcid extends SkillMagicBase
    {
        private var _skillUserEffectNull:Point;
        private const _PHASE_BULLET:int = 20;
        private const _PHASE_HIT:int = 30;
        private var _aMoveBullet:Array;
        private var _aBullet:Array;
        private var _waitTime:Number;
        private const WAIT_INTERVAL:Number = 0.003;
        private const BULLET_SPEED:int = 500;
        private var count:int = 0;

        public function SkillEMagicWaterStrongAcid(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_WATER))
            {
                playCastingSE();
            }
            var _loc_6:* = new Matrix();
            _loc_6 = _skillUserDisplay.getEffectNullMatrix();
            this._skillUserEffectNull = _skillUserDisplay.pos.add(new Point(_loc_6.tx, _loc_6.ty));
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
                        setPhase(this._PHASE_BULLET);
                        break;
                    }
                    case _ACT_LABEL_HIT:
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
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                if (isBoss())
                {
                    _bossEffect.gotoAndPlay(_ACT_LABEL_BACK);
                }
            }
            this._aBullet = [];
            var _loc_1:* = getMagicBulletStartNull(_baseMc.bulletStartNullMc);
            var _loc_2:* = this.getSpeedVector(_loc_1, _targetHitFrontPos, this.BULLET_SPEED);
            var _loc_3:* = this.getHitTime(_loc_1, _targetHitFrontPos, this.BULLET_SPEED);
            var _loc_4:* = 0;
            while (_loc_4 < 5)
            {
                
                _loc_5 = ResourceManager.getInstance().createMovieClip(getResource(), "bullet");
                _loc_5.visible = false;
                _loc_5.gotoAndPlay((_loc_4 + 1));
                _layer.getLayer(LayerBattle.FRONT_EFFECT).addChild(_loc_5);
                _loc_6 = {mc:_loc_5, vec:_loc_2, time:_loc_3, pos:_loc_1, throwHAcc:-20, throwH:0, throwHTime:_loc_3 / 2};
                this._aBullet.push(_loc_6);
                _loc_4++;
            }
            this._aMoveBullet = [];
            this._waitTime = this.WAIT_INTERVAL;
            return;
        }// end function

        private function controlBullet(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._waitTime > 0)
            {
                this._waitTime = this._waitTime - param1;
                if (this._waitTime <= 0)
                {
                    if (this._aBullet.length > 0)
                    {
                        _loc_2 = this._aBullet.shift();
                        _loc_2.mc.visible = true;
                        this._aMoveBullet.push(_loc_2);
                        this._waitTime = this.WAIT_INTERVAL;
                    }
                }
            }
            if (this._aMoveBullet != null)
            {
                this.bulletMove(param1, this._aMoveBullet, 20);
            }
            if (this._aBullet.length == 0 && this._aMoveBullet.length == 0)
            {
                _loc_3 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                addEffect(_loc_3, this.cbSetEffectPhase);
                SoundManager.getInstance().playSe(SoundId.SE_BATTLE_WATER);
                setPhase(this._PHASE_HIT);
            }
            return;
        }// end function

        private function bulletMove(param1:Number, param2:Array, param3:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_4:* = 0;
            while (_loc_4 < param2.length)
            {
                
                if (param2[_loc_4].time > 0)
                {
                    param2[_loc_4].time = param2[_loc_4].time - param1;
                    _loc_5 = new Matrix();
                    _loc_5.scale(param1, param1);
                    _loc_6 = _loc_5.transformPoint(param2[_loc_4].vec);
                    param2[_loc_4].pos = param2[_loc_4].pos.add(_loc_6);
                    _loc_7 = new Matrix();
                    param2[_loc_4].throwH = param2[_loc_4].throwH + param2[_loc_4].throwHAcc;
                    param2[_loc_4].throwHAcc = param2[_loc_4].throwHAcc + param3 / param2[_loc_4].throwHTime * param1;
                    _loc_7.translate(0, param2[_loc_4].throwH);
                    _loc_7.translate(param2[_loc_4].pos.x, param2[_loc_4].pos.y);
                    param2[_loc_4].mc.transform.matrix = _loc_7;
                    if (param2[_loc_4].time <= 0)
                    {
                        param2[_loc_4].mc.visible = false;
                        if (param2[_loc_4].mc != null && param2[_loc_4].mc.parent != null)
                        {
                            param2[_loc_4].mc.parent.removeChild(param2[_loc_4].mc);
                        }
                        param2[_loc_4].mc = null;
                        param2.splice(_loc_4, 1);
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
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
            return ResourcePath.SKILL_ENEMY_PATH + "Magic_Water_StrongAcid.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_BATTLE_WATER];
            return _loc_1;
        }// end function

    }
}
