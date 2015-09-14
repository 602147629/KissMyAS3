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

    public class SkillPMagicHeavenLightBall extends SkillMagicBase
    {
        private var _aTargetsPos:Array;
        private const _PHASE_BULLET:int = 20;
        private const _PHASE_HIT:int = 30;
        private var _aBullet:Array;
        private var _aMoveBullet:Array;
        private var _waitTime:Number;
        private const WAIT_INTERVAL:Number = 0.01;
        private const BULLET_SPEED:int = 1000;

        public function SkillPMagicHeavenLightBall(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_HEAVEN))
            {
                playCastingSE();
            }
            this._aTargetsPos = [];
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

        private function phaseBullet() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                if (isBoss())
                {
                    _bossEffect.gotoAndPlay(_ACT_LABEL_BACK);
                }
            }
            this._aBullet = [];
            for each (_loc_1 in _aTarget)
            {
                
                setTarget(_loc_1);
                _loc_2 = getMagicBulletStartNull(_baseMc.bulletStartNullMc);
                _loc_3 = this.getSpeedVector(_loc_2, _targetHitFrontPos, this.BULLET_SPEED);
                _loc_4 = this.getHitTime(_loc_2, _targetHitFrontPos, this.BULLET_SPEED);
                _loc_5 = {vec:_loc_3, time:_loc_4, pos:_loc_2, targetPos:_targetHitFrontPos};
                this._aBullet.push(_loc_5);
            }
            this._aMoveBullet = [];
            this._waitTime = this.WAIT_INTERVAL;
            return;
        }// end function

        private function controlBullet(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (this._waitTime > 0)
            {
                this._waitTime = this._waitTime - param1;
                if (this._waitTime <= 0)
                {
                    if (this._aBullet.length > 0)
                    {
                        _loc_3 = this._aBullet.pop();
                        _loc_4 = ResourceManager.getInstance().createMovieClip(getResource(), "bullet");
                        _loc_5 = new Bullet(_layer.getLayer(LayerBattle.CHARACTER), _loc_4, _loc_3.pos, _loc_3.vec);
                        _loc_5.effectPos = _loc_3.targetPos;
                        _loc_5.setHitMake(_loc_3.time);
                        this._aMoveBullet.push(_loc_5);
                        this._waitTime = this.WAIT_INTERVAL;
                    }
                }
            }
            var _loc_2:* = this._aMoveBullet.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_6 = this._aMoveBullet[_loc_2];
                _loc_6.control(param1);
                if (_loc_6.bHit)
                {
                    setTarget(_aTarget[_loc_2]);
                    _loc_7 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_6.effectPos, _bReverse);
                    addEffect(_loc_7, this.cbSetEffectPhase);
                    _loc_6.release();
                    this._aMoveBullet.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            if (this._aBullet.length == 0 && this._aMoveBullet.length == 0)
            {
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
                    SoundManager.getInstance().playSe(SoundId.SE_BATTLE_SUN);
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
            return ResourcePath.SKILL_PATH + "Magic_Heaven_LightBall.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_BATTLE_SUN];
            return _loc_1;
        }// end function

    }
}

import battle.*;

import character.*;

import effect.*;

import flash.display.*;

import flash.geom.*;

import layer.*;

import resource.*;

import sound.*;

class Bullet extends SkillPartsArrow
{
    public var effectPos:Point;

    function Bullet(param1:DisplayObjectContainer, param2:MovieClip, param3:Point, param4:Point)
    {
        super(param1, param2, param3, param4);
        return;
    }// end function

}

