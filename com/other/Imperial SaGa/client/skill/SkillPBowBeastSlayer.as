package skill
{
    import battle.*;
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPBowBeastSlayer extends SkillPositionBase
    {
        private var _bitmapData:BitmapData;
        private var _bg:Bitmap;
        private var _layerArrow:DisplayObjectContainer;
        private var _speedVector:Point;
        private var _filterMatrix:Matrix;
        private var _hitTime:Number;
        private var _arrowPosition:Point;
        private var _rot:int;
        private const _BULLET_SPEED:Number = 500;
        private const _PHASE_SHOT:int = 20;
        private var _aMoveBullet:Array;
        private var _waitTime:Number;
        private var _moveBullet:Array;
        private var WAIT_TIME:Number = 0.05;

        public function SkillPBowBeastSlayer(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            this._aMoveBullet = [];
            this._moveBullet = [];
            super(param1, param2, param3, param4, param5, getResource());
            this._layerArrow = _layer.getLayer(LayerBattle.FRONT_EFFECT);
            var _loc_6:* = this.createGradationEllipse(new Rectangle(0, 0, 150, 100), 16711680);
            this._bitmapData = new BitmapData(_loc_6.width, _loc_6.height, false, 4286644096);
            this._bitmapData.draw(_loc_6);
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override public function release() : void
        {
            this._layerArrow = null;
            this._bitmapData = null;
            this._bg = null;
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
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (_layer.getLayer(LayerBattle.BACKGROUND).numChildren != Constant.EMPTY_ID)
            {
                _loc_1 = _layer.getLayer(LayerBattle.BACKGROUND) as Sprite;
                this._bg = _loc_1.getChildAt(0) as Bitmap;
            }
            else
            {
                _loc_2 = new BitmapData(_battleManager.battleScreen.getChildByName("bgMc").width, _battleManager.battleScreen.getChildByName("bgMc").height);
                _loc_2.draw(_battleManager.battleScreen.getChildByName("bgMc"));
                this._bg = new Bitmap(_loc_2);
            }
            super.phaseAction();
            return;
        }// end function

        override protected function controlAction() : void
        {
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_BULLET:
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
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = 1;
            var _loc_2:* = 0;
            while (_loc_2 < 4)
            {
                
                _loc_3 = ResourceManager.getInstance().createMovieClip(getResource(), _EFFECT_MC_BULLET);
                _loc_3.alpha = _loc_1;
                _loc_1 = _loc_1 - 0.2;
                this._layerArrow.addChild(_loc_3);
                this._arrowPosition = getStartPosition();
                this._speedVector = getSpeedVector(this._arrowPosition, _targetHitFrontPos, this._BULLET_SPEED);
                this._hitTime = getHitTime(this._arrowPosition, _targetHitFrontPos, this._BULLET_SPEED);
                _loc_4 = new Object();
                _loc_4.bulletMc = _loc_3;
                _loc_4.arrowPosition = this._arrowPosition;
                _loc_4.speedVector = this._speedVector;
                _loc_4.hitTime = this._hitTime;
                _loc_4.rot = 0;
                this._moveBullet.push(_loc_4);
                _loc_2++;
            }
            SoundManager.getInstance().playSe(SoundId.SE_RS3_BOW_BOW);
            this._waitTime = this.WAIT_TIME;
            return;
        }// end function

        private function arrowMove(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            if (this._waitTime > 0)
            {
                this._waitTime = this._waitTime - param1;
                if (this._waitTime <= 0)
                {
                    if (this._moveBullet.length > 0)
                    {
                        this._aMoveBullet.push(this._moveBullet.shift());
                        this._waitTime = this.WAIT_TIME;
                    }
                }
            }
            if (this._aMoveBullet != null)
            {
                for each (_loc_2 in this._aMoveBullet)
                {
                    
                    _loc_3 = new Matrix();
                    _loc_3.scale(param1, param1);
                    _loc_4 = _loc_3.transformPoint(_loc_2.speedVector);
                    _loc_2.arrowPosition = _loc_2.arrowPosition.add(_loc_4);
                    _loc_5 = new Matrix();
                    _loc_2.rot = _loc_2.rot + 30;
                    _loc_6 = Math.sin(_loc_2.rot * Math.PI / 180);
                    _loc_5.translate(0, _loc_6 * 30);
                    _loc_7 = Math.atan2(-_loc_2.speedVector.y, -_loc_2.speedVector.x);
                    _loc_5.rotate(_loc_7);
                    _loc_5.translate(_loc_2.arrowPosition.x, _loc_2.arrowPosition.y);
                    _loc_2.bulletMc.transform.matrix = _loc_5;
                }
            }
            return;
        }// end function

        private function controlShot(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._hitTime > 0)
            {
                this.arrowMove(param1);
                this._hitTime = this._hitTime - param1;
                if (this._hitTime <= 0)
                {
                    for each (_loc_2 in this._aMoveBullet)
                    {
                        
                        _loc_2.bulletMc.visible = false;
                    }
                    if (this._bg)
                    {
                        this._bg.filters = [];
                    }
                    _loc_3 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos.clone(), _bReverse);
                    addEffect(_loc_3, this.cbSetEffectPhase);
                }
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_ARROW_HIT);
                    playDamageAll();
                    break;
                }
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

        private function createGradationEllipse(param1:Rectangle, param2:uint) : Sprite
        {
            var _loc_3:* = new Matrix();
            _loc_3.createGradientBox(param1.width, param1.height, 0);
            var _loc_4:* = new Sprite();
            var _loc_5:* = new Sprite().graphics;
            new Sprite().graphics.beginGradientFill(GradientType.RADIAL, [param2, 8421504], [1, 1], [0, 255], _loc_3);
            _loc_5.drawEllipse(0, 0, param1.width, param1.height);
            _loc_4.x = param1.x;
            _loc_4.y = param1.y;
            return _loc_4;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.SKILL_PATH + "Skill_Bow_BeastSlayer.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_ARROW_HIT, SoundId.SE_RS3_BOW_BOW];
            return _loc_1;
        }// end function

    }
}
