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

    public class SkillEMagicHadesBloodSucking extends SkillMagicBase
    {
        private var _skillUserEffectNull:Point;
        private const _PHASE_BULLET_CREATE:int = 20;
        private const _PHASE_BULLET:int = 30;
        private const _PHASE_HIT:int = 40;
        private var _createBullet:EffectMc;
        private var _aMoveBullet:Array;
        private var _aMoveBulletUp:Array;
        private var _aMoveBulletDown:Array;
        private var _aBullet:Array;
        private var _aBulletUp:Array;
        private var _aBulletDown:Array;
        private var _waitTime:Number;
        private const WAIT_INTERVAL:Number = 0.035;
        private const BULLET_SPEED:int = 500;
        private var count:int = 0;

        public function SkillEMagicHadesBloodSucking(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_HADES))
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
                    case _ACT_LABEL_HIT:
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
            SoundManager.getInstance().playSe(SoundId.SE_BATTLE_SPACE);
            this._createBullet = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _ACT_LABEL_START_FRONT, _targetHitFrontPos, _bReverse);
            addEffect(this._createBullet, this.cbEffect);
            return;
        }// end function

        private function cbEffect(param1:EffectMc, param2:String) : void
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
                        if (_loc_4.questUniqueId != _skillUser.questUniqueId)
                        {
                            playDamage(_loc_4);
                        }
                        _loc_3++;
                    }
                    break;
                }
                case _EFFECT_MC_BULLET:
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

        private function controlBulletCreate() : void
        {
            return;
        }// end function

        private function phaseBullet() : void
        {
            var _loc_1:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                if (isBoss())
                {
                    _bossEffect.gotoAndPlay(_ACT_LABEL_BACK);
                }
            }
            this._aBullet = [];
            this._aBulletUp = [];
            this._aBulletDown = [];
            var _loc_2:* = _baseMc.moveNull;
            var _loc_3:* = _skillUserDisplay.pos;
            if (_bReverse)
            {
                _loc_1 = this._skillUserEffectNull;
            }
            else
            {
                _loc_1 = new Point(_loc_3.x + _loc_2.x, _loc_3.y + _loc_2.y);
            }
            var _loc_4:* = this.getSpeedVector(_targetHitFrontPos, _loc_1, this.BULLET_SPEED);
            var _loc_5:* = this.getHitTime(_targetHitFrontPos, _loc_1, this.BULLET_SPEED);
            var _loc_6:* = 0;
            while (_loc_6 < 5)
            {
                
                _loc_7 = {vec:_loc_4, time:_loc_5, pos:_targetHitFrontPos};
                this._aBullet.push(_loc_7);
                _loc_8 = ResourceManager.getInstance().createMovieClip(getResource(), "bullet");
                _loc_8.visible = false;
                _loc_8.gotoAndPlay((_loc_6 + 1));
                _layer.getLayer(LayerBattle.FRONT_EFFECT).addChild(_loc_8);
                _loc_9 = {mc:_loc_8, vec:_loc_4, time:_loc_5, pos:_targetHitFrontPos, throwHAcc:-20, throwH:0, throwHTime:_loc_5 / 2};
                this._aBulletUp.push(_loc_9);
                _loc_10 = ResourceManager.getInstance().createMovieClip(getResource(), "bullet");
                _loc_10.visible = false;
                _loc_10.gotoAndPlay((_loc_6 + 1));
                _layer.getLayer(LayerBattle.FRONT_EFFECT).addChild(_loc_10);
                _loc_11 = {mc:_loc_10, vec:_loc_4, time:_loc_5, pos:_targetHitFrontPos, throwHAcc:15, throwH:0, throwHTime:_loc_5 / 2};
                this._aBulletDown.push(_loc_11);
                _loc_6++;
            }
            SoundManager.getInstance().playSe(SoundId.SE_WINDOW_CLOSE);
            this._aMoveBullet = [];
            this._aMoveBulletUp = [];
            this._aMoveBulletDown = [];
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
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (this._waitTime > 0)
            {
                this._waitTime = this._waitTime - param1;
                if (this._waitTime <= 0)
                {
                    if (this._aBullet.length > 0)
                    {
                        _loc_3 = this._aBullet.pop();
                        _loc_4 = ResourceManager.getInstance().createMovieClip(getResource(), "bullet");
                        _loc_4.gotoAndPlay((this.count + 1));
                        _loc_5 = new SkillPartsArrow(_layer.getLayer(LayerBattle.CHARACTER), _loc_4, _loc_3.pos, _loc_3.vec);
                        _loc_5.setHitMake(_loc_3.time);
                        this._aMoveBullet.push(_loc_5);
                        this._waitTime = this.WAIT_INTERVAL;
                    }
                    if (this.count > 3)
                    {
                        if (this._aBulletUp.length > 0)
                        {
                            _loc_6 = this._aBulletUp.shift();
                            _loc_6.mc.visible = true;
                            this._aMoveBulletUp.push(_loc_6);
                            this._waitTime = this.WAIT_INTERVAL;
                        }
                    }
                    if (this.count > 7)
                    {
                        if (this._aBulletDown.length > 0)
                        {
                            _loc_7 = this._aBulletDown.shift();
                            _loc_7.mc.visible = true;
                            this._aMoveBulletDown.push(_loc_7);
                            this._waitTime = this.WAIT_INTERVAL;
                        }
                    }
                    var _loc_10:* = this;
                    var _loc_11:* = this.count + 1;
                    _loc_10.count = _loc_11;
                }
            }
            if (this._aMoveBulletUp != null)
            {
                this.bulletMove(param1, this._aMoveBulletUp, 20);
                if (this.count == 4)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_WINDOW_CLOSE);
                }
            }
            if (this._aMoveBulletDown != null)
            {
                this.bulletMove(param1, this._aMoveBulletDown, -15);
                if (this.count == 8)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_WINDOW_CLOSE);
                }
            }
            var _loc_2:* = this._aMoveBullet.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_8 = this._aMoveBullet[_loc_2];
                _loc_8.control(param1);
                if (_loc_8.bHit)
                {
                    _loc_8.release();
                    this._aMoveBullet.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            if (this._aBullet.length == 0 && this._aMoveBullet.length == 0 && this._aBulletUp.length == 0 && this._aMoveBulletUp.length == 0 && this._aBulletDown.length == 0 && this._aMoveBulletDown.length == 0)
            {
                skillUserPosMove(_skillUser);
                _loc_9 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _buffTargetDisPlay, _bReverse);
                addEffect(_loc_9, this.cbSetEffectPhase, cbEffectControl);
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
                    SoundManager.getInstance().playSe(SoundId.SE_CHARM);
                    playDamage(_skillUser);
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
            return ResourcePath.SKILL_ENEMY_PATH + "Magic_Hades_SuckingBlood.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_BATTLE_SPACE, SoundId.SE_WINDOW_CLOSE, SoundId.SE_CHARM];
            return _loc_1;
        }// end function

    }
}
