package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EnemyBossDantag extends EnemyDisplay
    {
        private var _fireWaitTime:Number;
        private var _bFireEnd:Boolean;
        private var _effectFireMain:EffectParticleBossFireMain;
        private var _effectBatibatiMain:EffectBatibatiMain;
        private static const _WAIT_TIME:Number = 0.1;
        private static const _EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "fireRed.png";

        public function EnemyBossDantag(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            this._effectBatibatiMain = new EffectBatibatiMain(this.cbCreateBatibati);
            this._effectFireMain = new EffectParticleBossFireMain(null, _layer.getLayer(LayerCharacter.BACK_EFFECT), this.cbFireCreate, _WAIT_TIME, _EFFECT_PATH, new Point(0.2, 0.2));
            this._fireWaitTime = 0;
            return;
        }// end function

        public function set bFireEnd(param1:Boolean) : void
        {
            this._bFireEnd = param1;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._effectBatibatiMain != null)
            {
                this._effectBatibatiMain.release();
            }
            this._effectBatibatiMain = null;
            if (this._effectFireMain)
            {
                this._effectFireMain.release();
            }
            this._effectFireMain = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            this._effectBatibatiMain.control(param1);
            this._effectFireMain.control(param1);
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            this.playSeMotion();
            return;
        }// end function

        private function cbCreateBatibati() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (_mc.currentLabel == _LABEL_DEAD)
            {
                return;
            }
            var _loc_1:* = Random.range(1, 2);
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Point(Random.range(0, 300) - 150, Random.range(0, 300) * -1);
                _loc_4 = new Point(effectNull.x, effectNull.y);
                _loc_5 = new Point(_loc_4.x - _loc_3.x, _loc_4.y - _loc_3.y);
                _loc_5.normalize(200);
                _loc_6 = new EffectBatibati(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _loc_3, _loc_5);
                _loc_6.setColor(255, 255, 255);
                this._effectBatibatiMain.addEffect(_loc_6);
                _loc_2++;
            }
            return;
        }// end function

        public function cbFireCreate() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (_mc.currentLabel == _LABEL_DEAD)
            {
                return;
            }
            var _loc_1:* = 0;
            while (_loc_1 < 2)
            {
                
                _loc_2 = new Point(0, 0);
                _loc_3 = Random.range(30, 120);
                _loc_4 = Random.range(150, 300) * -1;
                if (Lot.isHit(50))
                {
                    _loc_3 = _loc_3 * -1;
                }
                _loc_2.x = _loc_2.x + _loc_3;
                _loc_2.y = _loc_2.y + _loc_4;
                _loc_5 = Random.range(80, 100);
                _loc_6 = effectNull.transform.matrix;
                _loc_7 = new Point(_loc_2.x - _loc_6.tx, _loc_2.y - _loc_6.ty);
                _loc_7.normalize(_loc_5);
                _loc_2 = this._effectFireMain.offset.add(_loc_2);
                _loc_8 = new EffectParticleFireParts(this._effectFireMain.bmpData, this._effectFireMain.fireBitmapData, _loc_2, _loc_5);
                _loc_8.vec = _loc_7;
                _loc_8.maxAlpha = 0.5;
                _loc_8.setLiveTime(0.4, 0.5);
                _loc_8.setOffsetColor(255, 255, 255);
                this._effectFireMain.addEffect(_loc_8);
                _loc_1++;
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
                SoundManager.getInstance().playSe(SoundId.SE_REV_DANTARG_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_DANTARG_ATTACK_SWORDSET);
            }
            if (_labelAnimDetail == "se1003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_DANTARG_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_DANTARG_ATTACK_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_DANTARG_MAGIC_TAME);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            var _loc_1:* = [];
            _loc_1.push(_EFFECT_PATH);
            return _loc_1;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_DANTARG_ATTACK_START, SoundId.SE_REV_DANTARG_ATTACK_SWORDSET, SoundId.SE_REV_DANTARG_ATTACK_SWISH, SoundId.SE_REV_DANTARG_ATTACK_START, SoundId.SE_REV_DANTARG_MAGIC_TAME];
        }// end function

    }
}
