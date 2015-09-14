package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EnemyBossKujinshi extends EnemyDisplay
    {
        private var _waitTime:Number;
        private var _bFireEnd:Boolean;
        private var _effectFireMain:EffectParticleBossFireMain;
        private var _effectBatibatiMain:EffectBatibatiMain;
        private static const _WAIT_TIME:Number = 0.03;
        private static const _EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "fireBlue.png";

        public function EnemyBossKujinshi(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            this._effectFireMain = new EffectParticleBossFireMain(null, _layer.getLayer(LayerCharacter.BACK_EFFECT), this.cbFireCreate, _WAIT_TIME, _EFFECT_PATH, new Point(0.4, 0.4));
            this._waitTime = 0;
            this._effectBatibatiMain = new EffectBatibatiMain(this.cbCreateBatibati);
            this._effectBatibatiMain.setWaitTimeBase(1);
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
            if (this._effectFireMain)
            {
                this._effectFireMain.release();
            }
            this._effectFireMain = null;
            this._effectBatibatiMain.release();
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
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            if (_mc.currentLabel == _LABEL_DEAD)
            {
                return;
            }
            var _loc_1:* = 1;
            var _loc_2:* = [_mc.monster.effectGuideNull1, _mc.monster.effectGuideNull2, _mc.monster.effectGuideNull3, _mc.monster.effectGuideNull4, _mc.monster.fireGuideNull5, _mc.monster.fireGuideNull4];
            var _loc_3:* = _mc.transform.concatenatedMatrix.clone();
            _loc_3.invert();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_1)
            {
                
                _loc_5 = Random.range(0, _loc_2.length - 2);
                _loc_6 = _loc_2[_loc_5];
                _loc_7 = _loc_2[(_loc_5 + 1)];
                if (_loc_6 == null || _loc_7 == null)
                {
                }
                else
                {
                    _loc_8 = new Matrix();
                    _loc_8 = _loc_6.transform.concatenatedMatrix.clone();
                    _loc_8.concat(_loc_3);
                    _loc_9 = new Matrix();
                    _loc_9 = _loc_7.transform.concatenatedMatrix.clone();
                    _loc_9.concat(_loc_3);
                    _loc_10 = new Point(_loc_8.tx, _loc_8.ty);
                    _loc_11 = new Point(_loc_9.tx - _loc_8.tx, _loc_9.ty - _loc_8.ty);
                    _loc_11.normalize(200);
                    _loc_12 = _loc_10.add(_loc_11);
                    _loc_13 = new EffectBatibati(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _loc_10, _loc_12);
                    _loc_13.setSpeedSlow();
                    _loc_13.setLength(7, 12);
                    _loc_13.setColor(200, 200, 255);
                    this._effectBatibatiMain.addEffect(_loc_13);
                }
                _loc_4++;
            }
            return;
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
                _loc_1 = [_mc.monster.fireGuideNull1, _mc.monster.fireGuideNull2, _mc.monster.fireGuideNull3, _mc.monster.fireGuideNull4, _mc.monster.fireGuideNull5];
                for each (_loc_2 in _loc_1)
                {
                    
                    _loc_3 = new Matrix();
                    _loc_4 = _mc.transform.concatenatedMatrix.clone();
                    _loc_4.invert();
                    _loc_3 = _loc_2.transform.concatenatedMatrix.clone();
                    _loc_3.concat(_loc_4);
                    _loc_5 = this._effectFireMain.offset.add(new Point(_loc_3.tx, _loc_3.ty));
                    this._effectFireMain.offset.add(new Point(_loc_3.tx, _loc_3.ty)).x = _loc_5.x + (Random.range(0, 0) - 0);
                    _loc_5.y = _loc_5.y + (Random.range(0, 0) - 0);
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
                SoundManager.getInstance().playSe(SoundId.SE_REV_KUJINSHI_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_KUJINSHI_ATTACK_SWORDSET);
            }
            if (_labelAnimDetail == "se1003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_KUJINSHI_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_KUJINSHI_ATTACK_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_KUJINSHI_MAGIC_TAME);
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
            return [SoundId.SE_REV_KUJINSHI_ATTACK_START, SoundId.SE_REV_KUJINSHI_ATTACK_SWORDSET, SoundId.SE_REV_KUJINSHI_ATTACK_SWISH, SoundId.SE_REV_KUJINSHI_ATTACK_START, SoundId.SE_REV_KUJINSHI_MAGIC_TAME];
        }// end function

    }
}
