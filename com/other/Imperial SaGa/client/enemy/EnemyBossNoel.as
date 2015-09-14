package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EnemyBossNoel extends EnemyDisplay
    {
        private var _WAIT_STONE:Number = 0.7;
        private var _WAIT_COERCION:Number = 2;
        private var _effectManager:EffectManager;
        private var _buraParent:Sprite;
        private var _effectAfterImagePut:EffectAfterImagePut;
        private const _SHINE_WAIT_TIME:Number = 4;
        private var _shineWaitTime:Number;
        private var _coercionTime:Number;
        private var _aBmpStone:Array;
        private var _stoneWaitTime:Number;
        private var _effectFireMain:EffectParticleBossFireMain;
        private var _waitTime:Number;
        private var _bFireEnd:Boolean;
        private static const _WAIT_TIME:Number = 0.03;
        private static const _EFFECT_FIRE_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "auraBrown.png";
        private static const _EFFECT_PATH1:String = ResourcePath.ENEMY_EFFECT_PATH + "Stone01.png";
        private static const _EFFECT_PATH3:String = ResourcePath.ENEMY_EFFECT_PATH + "Stone03.png";

        public function EnemyBossNoel(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            this._aBmpStone = [];
            this._buraParent = new Sprite();
            super(param1, param2, param3);
            _layer.getLayer(LayerCharacter.BACK_EFFECT).addChild(this._buraParent);
            this._effectManager = new EffectManager();
            this._effectAfterImagePut = new EffectAfterImagePut(this._buraParent, _mc);
            this._effectManager.addEffect(this._effectAfterImagePut);
            this._effectAfterImagePut.bStop = true;
            this._shineWaitTime = this._SHINE_WAIT_TIME;
            this._effectFireMain = new EffectParticleBossFireMain(null, _layer.getLayer(LayerCharacter.BACK_EFFECT), this.cbFireCreate, _WAIT_TIME, _EFFECT_FIRE_PATH, new Point(0.4, 0.4));
            var _loc_4:* = ResourceManager.getInstance().createBitmap(_EFFECT_PATH1);
            ResourceManager.getInstance().createBitmap(_EFFECT_PATH1).smoothing = true;
            var _loc_5:* = ResourceManager.getInstance().createBitmap(_EFFECT_PATH3);
            ResourceManager.getInstance().createBitmap(_EFFECT_PATH3).smoothing = true;
            this._aBmpStone = [_loc_4, _loc_5];
            this._stoneWaitTime = 0;
            this._coercionTime = this._WAIT_COERCION;
            return;
        }// end function

        public function set bFireEnd(param1:Boolean) : void
        {
            this._bFireEnd = param1;
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            super.release();
            if (this._effectFireMain)
            {
                this._effectFireMain.release();
            }
            this._effectFireMain = null;
            for each (_loc_1 in this._aBmpStone)
            {
                
                if (_loc_1.bitmapData)
                {
                    _loc_1.bitmapData.dispose();
                }
            }
            this._aBmpStone = [];
            if (this._effectManager)
            {
                this._effectManager.release();
            }
            this._effectManager = null;
            if (this._buraParent)
            {
                if (this._buraParent.parent)
                {
                    this._buraParent.parent.removeChild(this._buraParent);
                }
            }
            this._buraParent = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = null;
            super.control(param1);
            this._shineWaitTime = this._shineWaitTime - param1;
            if (this._shineWaitTime <= 0)
            {
                this._shineWaitTime = this._SHINE_WAIT_TIME + Random.range(0, 300) * 0.01;
                if (_mc.currentLabel == _LABEL_STAY)
                {
                    _loc_2 = new EffectSharpShines(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _mc, [_mc.monster.swordEffectNull1, _mc.monster.swordEffectNull2], 0.3);
                    this._effectManager.addEffect(_loc_2);
                }
            }
            this._coercionTime = this._coercionTime - param1;
            if (this._coercionTime <= 0)
            {
                this._coercionTime = this._WAIT_COERCION + Random.range(0, 20) * 0.1;
                if (_mc.currentLabel != _LABEL_DEAD)
                {
                    _loc_3 = new EffectCoercionParts(_layer.getLayer(LayerCharacter.BACK_EFFECT));
                    this._effectManager.addEffect(_loc_3);
                    this._stoneWaitTime = 0.3;
                }
            }
            if (this._stoneWaitTime > 0)
            {
                this._stoneWaitTime = this._stoneWaitTime - param1;
                if (this._stoneWaitTime <= 0)
                {
                    _loc_4 = Random.range(2, 3);
                    _loc_5 = 0 + Random.range(10, 50);
                    _loc_6 = 0;
                    while (_loc_6 < _loc_4)
                    {
                        
                        _loc_7 = Random.range(0, (this._aBmpStone.length - 1));
                        _loc_8 = this._aBmpStone[_loc_7];
                        _loc_9 = new Point();
                        _loc_9.x = _loc_5;
                        _loc_10 = new Point();
                        _loc_10.y = Random.range(30, 80) * -1;
                        _loc_11 = Random.range(5, 10);
                        if (Lot.isHit(50))
                        {
                            _loc_11 = _loc_11 * -1;
                        }
                        _loc_12 = Random.range(10, 15) * 0.1;
                        _loc_13 = new EffectFloat(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _loc_8.bitmapData, _loc_9, _loc_10, _loc_11, _loc_12);
                        _loc_13.friction = 1;
                        this._effectManager.addEffect(_loc_13);
                        _loc_5 = _loc_5 + Random.range(50, 100);
                        if (_loc_5 >= 100)
                        {
                            _loc_5 = _loc_5 - 200;
                        }
                        _loc_6++;
                    }
                }
            }
            this._effectAfterImagePut.bStop = _mc.currentLabel != _LABEL_ATTACK;
            this._effectManager.control(param1);
            this._effectFireMain.control(param1);
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            this.playSeMotion();
            return;
        }// end function

        private function cbParticlePartsCreate(param1:DisplayObjectContainer, param2:BitmapData) : EffectParticleBase
        {
            if (_mc.currentLabel == _LABEL_DEAD || _mc.currentLabel == _LABEL_CHANGE_IN || _mc.currentLabel == _LABEL_CHANGE_OUT)
            {
                return null;
            }
            var _loc_3:* = new Point(0, 0);
            _loc_3.x = _loc_3.x + (Random.range(0, 200) - 100);
            _loc_3.x = _loc_3.x + (-param2.width) * 0.5;
            _loc_3.y = _loc_3.y + (-param2.height) * 0.5;
            var _loc_4:* = new Point(0, Random.range(40, 70) * -1);
            var _loc_5:* = Random.range(5, 10);
            if (Lot.isHit(50))
            {
                _loc_5 = _loc_5 * -1;
            }
            var _loc_6:* = new EffectParticleLightParts(param1, param2, _loc_3, _loc_4, _loc_5, 1);
            new EffectParticleLightParts(param1, param2, _loc_3, _loc_4, _loc_5, 1).friction = 2;
            return _loc_6;
        }// end function

        public function cbFireCreate() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this._bFireEnd == false && _mc.currentLabel != _LABEL_DEAD)
            {
                _loc_1 = [_mc.monster.effectGuideNull1, _mc.monster.effectGuideNull2, _mc.monster.effectGuideNull3, _mc.monster.effectGuideNull4, _mc.monster.effectGuideNull5];
                for each (_loc_2 in _loc_1)
                {
                    
                    _loc_3 = new Matrix();
                    _loc_4 = _mc.transform.concatenatedMatrix.clone();
                    _loc_4.invert();
                    _loc_3 = _loc_2.transform.concatenatedMatrix.clone();
                    _loc_3.concat(_loc_4);
                    _loc_5 = this._effectFireMain.offset.add(new Point(_loc_3.tx, _loc_3.ty));
                    this._effectFireMain.offset.add(new Point(_loc_3.tx, _loc_3.ty)).x = _loc_5.x + (Random.range(0, 40) - 20);
                    _loc_5.y = _loc_5.y + (Random.range(0, 40) - 20);
                    _loc_6 = new EffectParticleFireParts(this._effectFireMain.bmpData, this._effectFireMain.fireBitmapData, _loc_5, -100);
                    this._effectFireMain.addEffect(_loc_6);
                }
            }
            return;
        }// end function

        private function playSeMotion() : void
        {
            if (_bLabelAnimDetailChange == false)
            {
                return;
            }
            if (_labelAnimDetail == "se1001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_NOEL_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_NOEL_ATTACK_SWORDSET);
            }
            if (_labelAnimDetail == "se1003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_NOEL_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_NOEL_ATTACK_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_NOEL_MAGIC_TAME);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            var _loc_1:* = [];
            _loc_1.push(_EFFECT_PATH1);
            _loc_1.push(_EFFECT_PATH3);
            _loc_1.push(_EFFECT_FIRE_PATH);
            _loc_1.push(EffectCoercionParts.RESOURCE_PATH);
            _loc_1.push(EffectSharpShines.RESOURCE_PATH);
            return _loc_1;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_NOEL_ATTACK_START, SoundId.SE_REV_NOEL_ATTACK_SWORDSET, SoundId.SE_REV_NOEL_ATTACK_SWISH, SoundId.SE_REV_NOEL_ATTACK_START, SoundId.SE_REV_NOEL_MAGIC_TAME];
        }// end function

    }
}
