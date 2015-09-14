package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import enemy.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import player.*;
    import resource.*;

    public class SkillPositionBase extends SkillBase
    {
        protected const _PHASE_WAIT:int = 1;
        protected const _PHASE_ACTION:int = 10;
        protected const _PHASE_END:int = 99;
        protected var __phase:int;
        private var _mcLabel:String;
        private var __bValidateMain:Boolean;
        private var _aEffect:Array;
        protected var _enemyType:EnemyDisplay;
        protected var _bNeedWait:Boolean;
        protected var _monsterMc:MovieClip;
        protected var _monsterChargeNecessary:int;
        protected var _monsterBulletBoolean:Boolean = false;
        protected var _monsterStayBoolean:Boolean = false;
        protected var _bulletFrameNecessary:int;
        protected var _buffTargetDisPlay:Point;

        public function SkillPositionBase(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager, param6:String)
        {
            super(param2, param3, param5, param4);
            _layer = param1;
            this.createBaseMc(param6);
            this._mcLabel = "";
            this._aEffect = [];
            this.setTarget(param3[0]);
            this._bNeedWait = false;
            this._enemyType = _skillUser.characterDisplay as EnemyDisplay;
            this.setBasePosition();
            init();
            return;
        }// end function

        protected function get _phase() : int
        {
            return this.__phase;
        }// end function

        protected function get _bValidateMain() : Boolean
        {
            return this.__bValidateMain;
        }// end function

        protected function createBaseMc(param1:String) : void
        {
            _baseMc = ResourceManager.getInstance().createMovieClip(param1, "position_chara_act");
            _layer.getLayer(LayerBattle.CHARACTER).addChild(_baseMc);
            return;
        }// end function

        protected function setBasePosition() : void
        {
            var _loc_1:* = _skillUserDisplay.pos;
            _baseMc.x = _loc_1.x;
            _baseMc.y = _loc_1.y;
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            if (this._aEffect[0] != null)
            {
                while (this._aEffect.length > 0)
                {
                    
                    _loc_1 = this._aEffect.pop();
                    if (_loc_1 != null)
                    {
                        this.releaseEffect(_loc_1.effect);
                    }
                }
            }
            this._aEffect = null;
            this._enemyType = null;
            super.release();
            return;
        }// end function

        protected function addEffect(param1:EffectMc, param2:Function = null, param3:Function = null) : void
        {
            var _loc_4:* = new Object();
            new Object().effect = param1;
            _loc_4.setCallback = param2;
            _loc_4.controlCallback = param3;
            _loc_4.markedFrame = 0;
            this._aEffect.push(_loc_4);
            _effectManager.addEffect(param1);
            return;
        }// end function

        protected function cbEffectControl(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            for each (_loc_4 in _aTarget)
            {
                
                _loc_5 = _loc_4.characterDisplay;
                _loc_5.mc.transform.colorTransform = param1.mcEffect.monsNull.transform.colorTransform;
            }
            return;
        }// end function

        protected function cbBgEffectControl(param1:EffectMc, param2:String, param3:Number) : void
        {
            if (_layer.getLayer(LayerBattle.BACKGROUND).numChildren != Constant.EMPTY_ID)
            {
                _layer.getLayer(LayerBattle.BACKGROUND).transform.colorTransform = param1.mcEffect.bgColorMc.transform.colorTransform;
            }
            else
            {
                _battleManager.battleScreen.getChildByName("bgMc").transform.colorTransform = param1.mcEffect.bgColorMc.transform.colorTransform;
            }
            return;
        }// end function

        private function controlEffect(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aEffect.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (this._aEffect[_loc_2] != null)
                {
                    _loc_3 = this._aEffect[_loc_2].effect;
                    if (_loc_3 != null)
                    {
                        if (_loc_3.isEnd())
                        {
                            this.releaseEffect(_loc_3);
                            if (this._aEffect[_loc_2].setCallback)
                            {
                                this._aEffect[_loc_2].setCallback(_loc_3, _EFFECT_LABEL_END);
                            }
                            this._aEffect[_loc_2] = null;
                        }
                        else
                        {
                            if (this._aEffect[_loc_2].setCallback && _loc_3.mcEffect.currentFrameLabel != null)
                            {
                                if (_loc_3.mcEffect.currentFrame != this._aEffect[_loc_2].markedFrame)
                                {
                                    this._aEffect[_loc_2].markedFrame = _loc_3.mcEffect.currentFrame;
                                    this._aEffect[_loc_2].setCallback(_loc_3, _loc_3.mcEffect.currentLabel);
                                }
                            }
                            if (this._aEffect[_loc_2].controlCallback)
                            {
                                this._aEffect[_loc_2].controlCallback(_loc_3, _loc_3.mcEffect.currentLabel, param1);
                            }
                            this._aEffect[_loc_2].currentLabel = _loc_3.mcEffect.currentLabel;
                        }
                    }
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        protected function releaseEffect(param1:EffectMc) : void
        {
            _effectManager.releaseEffect(param1);
            return;
        }// end function

        final override public function control(param1:Number) : void
        {
            super.control(param1);
            this.controlMainMc();
            this.selectControl(param1);
            this.controlEffect(param1);
            return;
        }// end function

        protected function selectControl(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_WAIT:
                {
                    this.controlWait();
                    break;
                }
                case this._PHASE_ACTION:
                {
                    this.controlAction();
                    break;
                }
                case this._PHASE_END:
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

        private function controlMainMc() : void
        {
            this.__bValidateMain = this._mcLabel != _baseMc.currentLabel;
            this._mcLabel = _baseMc.currentLabel;
            return;
        }// end function

        final protected function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this.__phase = param1;
                this.selectPhase();
            }
            return;
        }// end function

        protected function selectPhase() : void
        {
            switch(this._phase)
            {
                case this._PHASE_WAIT:
                {
                    this.phaseWait();
                    break;
                }
                case this._PHASE_ACTION:
                {
                    this.phaseAction();
                    break;
                }
                case this._PHASE_END:
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

        protected function phaseWait() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                this._monsterMc = _skillUserDisplay.mc.getChildByName("monster") as MovieClip;
                if (this._monsterMc)
                {
                    for each (_loc_7 in this._monsterMc.currentLabels)
                    {
                        
                        if (_loc_7.name == _MONSTER_LABELNAME_CHARGE)
                        {
                            _loc_1 = _loc_7.frame;
                        }
                        if (_loc_7.name == _MONSTER_LABELNAME_ATTACK)
                        {
                            _loc_2 = _loc_7.frame;
                            this._bNeedWait = true;
                            break;
                        }
                    }
                }
                if (_loc_1 != 0 && _loc_2 != 0)
                {
                    this._monsterChargeNecessary = _loc_2 - _loc_1;
                }
                _loc_3 = 0;
                _loc_4 = 0;
                _loc_5 = 0;
                for each (_loc_6 in _baseMc.currentLabels)
                {
                    
                    if (_loc_6.name == "bullet")
                    {
                        this._monsterBulletBoolean = true;
                        _loc_3 = _loc_6.frame;
                    }
                    if (_loc_6.name == "stay")
                    {
                        this._monsterStayBoolean = true;
                        _loc_4 = _loc_6.frame;
                    }
                    if (_loc_6.name == _ACT_LABEL_START)
                    {
                        _loc_5 = _loc_6.frame;
                    }
                }
                if (_loc_3 != 0 && _loc_4 != 0 && this._monsterStayBoolean)
                {
                    this._bulletFrameNecessary = _loc_4 - _loc_3;
                }
                else
                {
                    this._bulletFrameNecessary = _loc_3 - _loc_5;
                }
            }
            return;
        }// end function

        protected function controlWait() : void
        {
            var _loc_1:* = 0;
            if (this._bNeedWait == false || this._monsterMc == null)
            {
                this.setPhase(this._PHASE_ACTION);
                return;
            }
            if (this._monsterBulletBoolean)
            {
                _loc_1 = this._monsterChargeNecessary - this._bulletFrameNecessary;
                if (_loc_1 <= 0 || this._monsterMc.currentFrame >= _loc_1)
                {
                    this.setPhase(this._PHASE_ACTION);
                }
            }
            else
            {
                switch(this._monsterMc.currentFrameLabel)
                {
                    case _MONSTER_LABELNAME_ATTACK:
                    {
                        if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
                        {
                            if (_bossEffect != null && this.isBoss())
                            {
                                _bossEffect.gotoAndPlay("back");
                            }
                        }
                        this.setPhase(this._PHASE_ACTION);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            this.bossEddextLoop();
            return;
        }// end function

        protected function phaseAction() : void
        {
            this.setAnimationPattarn();
            _baseMc.gotoAndPlay(_ACT_LABEL_START);
            return;
        }// end function

        protected function controlAction() : void
        {
            this.bossEddextLoop();
            return;
        }// end function

        protected function phaseEnd() : void
        {
            setEnd();
            return;
        }// end function

        protected function controlEnd() : void
        {
            return;
        }// end function

        protected function isBoss() : Boolean
        {
            return this._enemyType != null && this._enemyType.info.bossFlag;
        }// end function

        protected function bossEddextLoop() : void
        {
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                if (_bossEffect != null && this.isBoss())
                {
                    if (_bossEffect.currentFrameLabel == "loopEnd")
                    {
                        _bossEffect.gotoAndPlay("loopStart");
                    }
                }
            }
            return;
        }// end function

        protected function setAnimationPattarn() : void
        {
            var _loc_1:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_1 = _skillUserDisplay as PlayerDisplay;
                _loc_1.setAnimationPattern(_baseMc);
            }
            return;
        }// end function

        protected function setTarget(param1:BattleActionBase) : void
        {
            var _loc_5:* = null;
            _target = param1;
            _targetDisplay = param1.characterDisplay;
            var _loc_2:* = _targetDisplay.getEffectNullMatrix();
            var _loc_3:* = _targetDisplay.pos.add(new Point(_loc_2.tx, _loc_2.ty));
            _targetHitFrontPos = _loc_3;
            _targetGrandPos = new Point(_targetDisplay.pos.x, _targetDisplay.pos.y);
            var _loc_4:* = _targetDisplay.getfaceNullMatrix();
            _targetFacePos = _targetGrandPos.add(new Point(_loc_4.tx, _loc_4.ty));
            if (_skillUserDisplay.bulletStartNullMc != null)
            {
                _loc_5 = _skillUserDisplay.getbulletStartNullMcMatrix();
                _skillUserBulletPos = new Point(_loc_5.tx, _loc_5.ty);
            }
            return;
        }// end function

        protected function skillUserPosMove(param1:BattleActionBase, param2:String = null) : void
        {
            var _loc_6:* = 0;
            var _loc_3:* = param1.characterDisplay.getEffectNullMatrix();
            var _loc_4:* = param1.characterDisplay.pos.add(new Point(_loc_3.tx, _loc_3.ty));
            var _loc_5:* = new Point(param1.characterDisplay.pos.x, param1.characterDisplay.pos.y);
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_6 = _baseMc.moveNull.x;
                if (param2 == _EFFECT_MC_GRAND)
                {
                    if (_skillUser.questUniqueId == param1.questUniqueId)
                    {
                        _loc_4 = new Point(_loc_5.x + _loc_6, _loc_5.y);
                    }
                    else
                    {
                        _loc_4 = new Point(_loc_5.x, _loc_5.y);
                    }
                }
                else if (_skillUser.questUniqueId == param1.questUniqueId)
                {
                    _loc_4 = new Point(_loc_5.x + _loc_6, _loc_4.y);
                }
            }
            else if (param2 == _EFFECT_MC_GRAND)
            {
                _loc_4 = new Point(_loc_5.x, _loc_5.y);
            }
            else
            {
                _loc_4 = new Point(_loc_4.x, _loc_4.y);
            }
            this._buffTargetDisPlay = _loc_4;
            return;
        }// end function

        protected function getStartPosition() : Point
        {
            var _loc_1:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_1 = _baseMc.bulletStartNullMc;
            }
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                _loc_1 = _skillUserDisplay.effectNull;
            }
            var _loc_2:* = _skillUserDisplay.pos;
            return new Point(_loc_2.x + _loc_1.x, _loc_2.y + _loc_1.y);
        }// end function

        protected function getSpeedVector(param1:Point, param2:Point, param3:int) : Point
        {
            var _loc_4:* = new Point(param2.x - param1.x, param2.y - param1.y);
            new Point(param2.x - param1.x, param2.y - param1.y).normalize(1);
            var _loc_5:* = new Matrix();
            new Matrix().scale(param3, param3);
            return _loc_5.transformPoint(_loc_4);
        }// end function

        protected function getHitTime(param1:Point, param2:Point, param3:int) : Number
        {
            var _loc_4:* = new Point(param2.x - param1.x, param2.y - param1.y);
            return new Point(param2.x - param1.x, param2.y - param1.y).length / param3;
        }// end function

    }
}
