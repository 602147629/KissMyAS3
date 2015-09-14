package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EnemyBossTinyFather extends EnemyDisplayAfterImage
    {
        private var _particle:EnemyParticleMain;
        private var _effectManager:EffectManager;
        private var _label:String;
        private static const _WAIT_TIME:Number = 1.3;
        private static const _VEC_FATHER_MAGIC:Point = new Point(100, 0);
        private static const _EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "Feather.png";

        public function EnemyBossTinyFather(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            this._label = "";
            super(param1, param2, param3);
            _blurPow = new Point(15, 10);
            _blurTime = 0.2;
            _blurLiveTime = 0.4;
            _blurVec = new Point(0, -30);
            _blurColor = new ColorTransform(1, 1, 1, 1, 25, 25, 25, 0);
            _blurEndColor = new ColorTransform(1, 1, 1, 0, 25, 25, 25, 0);
            setBlurEffect();
            this._effectManager = new EffectManager();
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._effectManager != null)
            {
                this._effectManager.release();
            }
            this._effectManager = null;
            if (this._particle != null)
            {
                this._particle.release();
            }
            this._particle = null;
            return;
        }// end function

        private function removeBmp(param1:Bitmap) : void
        {
            if (param1)
            {
                if (param1.parent)
                {
                    param1.parent.removeChild(param1);
                }
                if (param1.bitmapData != null)
                {
                    param1.bitmapData.dispose();
                }
            }
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            super.control(param1);
            if (this._effectManager)
            {
                this._effectManager.control(param1);
            }
            if (this._particle)
            {
                this._particle.control(param1);
            }
            var _loc_2:* = _mc.monster.currentLabel;
            if (_loc_2 != this._label)
            {
                if (_mc.currentLabel == _LABEL_STAY && _loc_2 == "flapping" || _mc.currentLabel == _LABEL_ATTACK && _loc_2 == "flapping" || _mc.currentLabel == _LABEL_MAGIC && _loc_2 == "flapping")
                {
                    _loc_3 = new EffectDustParts(_layer.getLayer(LayerCharacter.FRONT_EFFECT), new Point(0, 0), new Point(500, 0), 0.5);
                    this._effectManager.addEffect(_loc_3);
                    _loc_4 = new EffectDustParts(_layer.getLayer(LayerCharacter.FRONT_EFFECT), new Point(0, 0), new Point(300, 0), 0.75);
                    this._effectManager.addEffect(_loc_4);
                    if (_mc.currentLabel == _LABEL_ATTACK || _mc.currentLabel == _LABEL_MAGIC)
                    {
                        _loc_5 = new EffectDustParts(_layer.getLayer(LayerCharacter.FRONT_EFFECT), new Point(0, 0), new Point(100, 0), 1);
                        this._effectManager.addEffect(_loc_5);
                    }
                }
            }
            this._label = _loc_2;
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
            if (_mc.currentLabel != _LABEL_MAGIC)
            {
                return null;
            }
            var _loc_3:* = new Point(0, 0);
            _loc_3.x = _loc_3.x + (Random.range(0, 200) - 100);
            _loc_3.y = _loc_3.y + Random.range(100, 200) * -1;
            _loc_3.x = _loc_3.x + (-param2.width) * 0.5;
            _loc_3.y = _loc_3.y + (-param2.height) * 0.5;
            var _loc_4:* = Random.range(1, 3);
            if (Lot.isHit(50))
            {
                _loc_4 = _loc_4 * -1;
            }
            var _loc_5:* = 75;
            _loc_5 = 75 - Random.range(0, 50);
            return new EffectParticleFeatherParts(param1, param2, _loc_3, _loc_5, _loc_4, 3);
        }// end function

        private function cbParticleControl(param1:Number, param2:EffectParticleFeatherParts) : void
        {
            if (_mc.currentLabel == _LABEL_MAGIC)
            {
                param2.addVec(param1, _VEC_FATHER_MAGIC);
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
                SoundManager.getInstance().playSe(SoundId.SE_REV_TINYFEATHER_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_TINYFEATHER_ATTACK_SWORDSET);
            }
            if (_labelAnimDetail == "se1003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_TINYFEATHER_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_TINYFEATHER_ATTACK_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_TINYFEATHER_MAGIC_TAME);
            }
            if (_labelAnimDetail == "se2003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_TINYFEATHER_MAGIC_SWISH01);
            }
            if (_labelAnimDetail == "se2004")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_TINYFEATHER_MAGIC_SWISH01);
            }
            if (_labelAnimDetail == "se2005")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_TINYFEATHER_MAGIC_SWISH01);
            }
            if (_labelAnimDetail == "se2006")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_TINYFEATHER_MAGIC_SWISH02);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            var _loc_1:* = [];
            _loc_1.push(EffectDustParts.RESOURCE_PATH);
            return _loc_1;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_TINYFEATHER_ATTACK_START, SoundId.SE_REV_TINYFEATHER_ATTACK_SWORDSET, SoundId.SE_REV_TINYFEATHER_ATTACK_SWISH, SoundId.SE_REV_TINYFEATHER_MAGIC_TAME, SoundId.SE_REV_TINYFEATHER_MAGIC_SWISH01, SoundId.SE_REV_TINYFEATHER_MAGIC_SWISH02];
        }// end function

    }
}
