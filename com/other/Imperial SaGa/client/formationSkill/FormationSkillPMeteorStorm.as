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
    import sound.*;

    public class FormationSkillPMeteorStorm extends FormationSkillBase
    {
        private const _PHASE_BULLET:int = 10;
        private const _PHASE_HIT:int = 20;
        private const _PHASE_JUMP:int = 30;
        private var _mc2:MovieClip;
        private var _mc3:MovieClip;
        private var _mc4:MovieClip;
        private var _mc5:MovieClip;
        private var _mcArray:Array;
        private var _bulletMcArray:Array;
        private var _hitCount:int = 0;
        private var _waitTime:Number;
        private const WAIT_INTERVAL:Number = 0.3;
        private var _count:int = 1;
        private var _jumpCount:int = 1;

        public function FormationSkillPMeteorStorm(param1:LayerBattle, param2:Array, param3:Array, param4:EffectManager)
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            super(param1, param2, param3, param4);
            this.setTarget(_aTarget[0]);
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

        override protected function setTarget(param1:BattleActionBase) : void
        {
            var _loc_2:* = param1.characterDisplay;
            var _loc_3:* = _loc_2.getEffectNullMatrix();
            var _loc_4:* = _loc_2.pos.add(new Point(_loc_3.tx, _loc_3.ty));
            _targetDisplayPos = _loc_4;
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._mcArray)
            {
                
                if (_loc_1 && _loc_1.parent)
                {
                    _loc_1.parent.removeChild(_loc_1);
                }
            }
            this._mcArray = null;
            for each (_loc_2 in this._bulletMcArray)
            {
                
                if (_loc_2 && _loc_2.parent)
                {
                    _loc_2.parent.removeChild(_loc_2);
                }
            }
            this._bulletMcArray = null;
            super.release();
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
                case this._PHASE_JUMP:
                {
                    this.controlJump(param1);
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
                case this._PHASE_JUMP:
                {
                    this.phaseJump();
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
            var _loc_1:* = 0;
            while (_loc_1 < _aAttacer.length)
            {
                
                _loc_2 = _aAttacer[_loc_1];
                _loc_3 = this._mcArray[_loc_1];
                _loc_4 = _loc_2.characterDisplay as PlayerDisplay;
                _loc_4.setAnimationPattern(_loc_3);
                this._mcArray[_loc_1].gotoAndStop(_ACT_LABEL_STOP);
                _loc_1++;
            }
            this._mcArray[0].gotoAndPlay(_ACT_LABEL_START);
            SoundManager.getInstance().playSe(SoundId.SE_JUMP1);
            this._waitTime = this.WAIT_INTERVAL;
            setPhase(this._PHASE_JUMP);
            return;
        }// end function

        override protected function controlAction() : void
        {
            super.controlAction();
            return;
        }// end function

        private function controlJump(param1:Number) : void
        {
            if (this._waitTime > 0)
            {
                this._waitTime = this._waitTime - param1;
                if (this._waitTime <= 0 && this._jumpCount < 5)
                {
                    this._mcArray[this._jumpCount].gotoAndPlay(_ACT_LABEL_START);
                    this._waitTime = this.WAIT_INTERVAL;
                    var _loc_2:* = this;
                    var _loc_3:* = this._jumpCount + 1;
                    _loc_2._jumpCount = _loc_3;
                    SoundManager.getInstance().playSe(SoundId.SE_JUMP1);
                }
            }
            if (this._mcArray[4].currentFrameLabel == "end")
            {
                setPhase(this._PHASE_BULLET);
            }
            return;
        }// end function

        private function phaseJump() : void
        {
            return;
        }// end function

        private function getIntRandom(param1:int, param2:int) : int
        {
            var _loc_3:* = 0;
            if (param1 > param2)
            {
                _loc_3 = param1;
                param1 = param2;
                param2 = _loc_3;
            }
            if (param1 == param2)
            {
                return param1;
            }
            return Math.floor(Math.random() * (param2 - param1)) + param1;
        }// end function

        private function phaseBullet() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            _mc = ResourceManager.getInstance().createMovieClip(getResource(), "advance_chara_act");
            this._mc2 = ResourceManager.getInstance().createMovieClip(getResource(), "advance_chara_act");
            this._mc3 = ResourceManager.getInstance().createMovieClip(getResource(), "advance_chara_act");
            this._mc4 = ResourceManager.getInstance().createMovieClip(getResource(), "advance_chara_act");
            this._mc5 = ResourceManager.getInstance().createMovieClip(getResource(), "advance_chara_act");
            this._bulletMcArray = [];
            this._bulletMcArray.push(_mc, this._mc2, this._mc3, this._mc4, this._mc5);
            var _loc_1:* = 0;
            while (_loc_1 < 5)
            {
                
                _loc_2 = _aAttacer[_loc_1];
                _layer.getLayer(LayerBattle.CHARACTER).addChild(this._bulletMcArray[_loc_1]);
                _loc_3 = this._bulletMcArray[_loc_1].charaNull;
                _loc_4 = _loc_2.characterDisplay as PlayerDisplay;
                _loc_4.setAnimationPattern(_loc_3);
                if (_loc_1 != 4)
                {
                    this._bulletMcArray[_loc_1].x = _targetDisplayPos.x + this.getIntRandom(-50, 50);
                    this._bulletMcArray[_loc_1].y = _targetDisplayPos.y + this.getIntRandom(-50, 50);
                }
                else
                {
                    this._bulletMcArray[_loc_1].x = _targetDisplayPos.x;
                    this._bulletMcArray[_loc_1].y = _targetDisplayPos.y;
                }
                this._bulletMcArray[_loc_1].gotoAndStop(_ACT_LABEL_STOP);
                _loc_1++;
            }
            this._bulletMcArray[0].gotoAndPlay(_ACT_LABEL_START);
            this._waitTime = this.WAIT_INTERVAL;
            return;
        }// end function

        private function targetpoint(param1:MovieClip) : Point
        {
            var _loc_2:* = new Point(param1.x, param1.y);
            return _loc_2;
        }// end function

        private function controlBullet(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._waitTime > 0)
            {
                this._waitTime = this._waitTime - param1;
                if (this._waitTime <= 0 && this._count < 5)
                {
                    this._bulletMcArray[this._count].gotoAndPlay(_ACT_LABEL_START);
                    this._waitTime = this.WAIT_INTERVAL;
                    var _loc_6:* = this;
                    var _loc_7:* = this._count + 1;
                    _loc_6._count = _loc_7;
                }
            }
            var _loc_3:* = 0;
            while (_loc_3 < 4)
            {
                
                if (this._bulletMcArray[_loc_3].currentLabel == _ACT_LABEL_HIT)
                {
                    if (_loc_3 == 0)
                    {
                        _loc_4 = new EffectShake(_layer, 6, 6, 1.7);
                        _effectManager.addEffect(_loc_4);
                        if (_layer.getLayer(LayerBattle.BACKGROUND).numChildren == Constant.EMPTY_ID)
                        {
                            _loc_5 = new EffectShake(_battleManager.battleScreen, 6, 6, 1.7);
                            _effectManager.addEffect(_loc_5);
                        }
                    }
                    _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, this.targetpoint(this._bulletMcArray[_loc_3]));
                    addEffect(_loc_2);
                    SoundManager.getInstance().playSe(SoundId.SE_METEORSTORM);
                    this._bulletMcArray[_loc_3].gotoAndStop(_ACT_LABEL_STOP);
                    this.setJump(_loc_3);
                }
                _loc_3++;
            }
            switch(this._bulletMcArray[4].currentLabel)
            {
                case _ACT_LABEL_HIT:
                {
                    if (this._hitCount == 0)
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_METEORSTORM);
                        var _loc_6:* = this;
                        var _loc_7:* = this._hitCount + 1;
                        _loc_6._hitCount = _loc_7;
                    }
                    _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_GRAND, _targetDisplayPos);
                    addEffect(_loc_2, this.cbSetEffectPhase);
                    this.setJump(4);
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
                    setPhase(_PHASE_LEAVE);
                    this._bulletMcArray[4].gotoAndStop(_ACT_LABEL_STOP);
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

        private function setJump(param1:int) : void
        {
            var _loc_2:* = _aAttacer[param1];
            var _loc_3:* = this._bulletMcArray[param1].charaNull;
            var _loc_4:* = _loc_2.characterDisplay as PlayerDisplay;
            var _loc_5:* = new Point(_mc.x, _mc.y);
            _loc_4.pos = _loc_5.add(new Point(_loc_3.x, _loc_3.y));
            _loc_4.setTargetJump(_loc_4.backupPosition);
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
            return ResourcePath.FORMATION_SKILL_PATH + "FormationSkill_MeteorStorm.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP1, SoundId.SE_METEORSTORM];
            return _loc_1;
        }// end function

    }
}
