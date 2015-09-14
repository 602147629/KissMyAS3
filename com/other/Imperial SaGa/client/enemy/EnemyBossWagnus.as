package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EnemyBossWagnus extends EnemyDisplay
    {
        private var _effectHeloMain:EffectParticleBossMistMain;
        private var _effectHeloRotFlag:int = 1;
        private var _effectLightMain:EffectParticleBossMistMain;
        private static const _HELO_EFFECT_WAIT_TIME:Number = 0.1;
        private static const _LIGHT_EFFECT_WAIT_TIME:Number = 0.1;
        private static const _HELO_EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "Helo01.png";
        private static const _LIGHT_EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "Light01.png";

        public function EnemyBossWagnus(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            _layer.getLayer(LayerCharacter.BACK_EFFECT).blendMode = BlendMode.ADD;
            this._effectHeloMain = new EffectParticleBossMistMain(null, _layer.getLayer(LayerCharacter.BACK_EFFECT), this.cbHeloCreate, _HELO_EFFECT_WAIT_TIME, _HELO_EFFECT_PATH, new Point(1, 1));
            this._effectHeloMain.waitTime = 0;
            this._effectHeloRotFlag = 1;
            this._effectLightMain = new EffectParticleBossMistMain(null, _layer.getLayer(LayerCharacter.BACK_EFFECT), this.cbLightCreate, _LIGHT_EFFECT_WAIT_TIME, _LIGHT_EFFECT_PATH, new Point(1, 1));
            this._effectLightMain.waitTime = Random.range(0.83, 1.5);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._effectHeloMain)
            {
                this._effectHeloMain.release();
            }
            this._effectHeloMain = null;
            if (this._effectLightMain)
            {
                this._effectLightMain.release();
            }
            this._effectLightMain = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            if (_mc.currentLabel != _LABEL_DEAD)
            {
                if (_layer.getLayer(LayerCharacter.BACK_EFFECT).alpha == 0)
                {
                    _layer.getLayer(LayerCharacter.BACK_EFFECT).alpha = 1;
                }
                if (this._effectHeloMain)
                {
                    this._effectHeloMain.control(param1);
                }
                if (this._effectLightMain)
                {
                    this._effectLightMain.control(param1);
                }
            }
            else if (_layer.getLayer(LayerCharacter.BACK_EFFECT).alpha > 0)
            {
                _layer.getLayer(LayerCharacter.BACK_EFFECT).alpha = 0;
            }
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            this.playSeMotion();
            return;
        }// end function

        private function cbHeloCreate() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (_mc.currentLabel != _LABEL_DEAD)
            {
                this._effectHeloMain.waitTime = 2;
                _loc_1 = [_mc.monster.HeloGuideNull1];
                _loc_2 = _loc_1[Random.range(0, (_loc_1.length - 1))];
                _loc_3 = this.createHeloParts(_loc_2, this._effectHeloMain.bmpData, this._effectHeloMain.mistBitmapData);
                this._effectHeloMain.addEffect(_loc_3);
            }
            return;
        }// end function

        private function createHeloParts(param1:MovieClip, param2:BitmapData, param3:BitmapData) : EffectParticleMistParts
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            _loc_4 = new Matrix();
            _loc_5 = _mc.transform.concatenatedMatrix.clone();
            _loc_5.invert();
            _loc_4 = param1.transform.concatenatedMatrix.clone();
            _loc_4.concat(_loc_5);
            _loc_6 = new Point(_loc_4.tx, _loc_4.ty);
            _loc_6 = this._effectHeloMain.offset.add(_loc_6);
            _loc_7 = new EffectParticleMistParts(param2, param3, _loc_6, 0);
            _loc_7.setLiveTime(8, 8);
            _loc_7.vanishWaitTime = 4;
            _loc_7.scale = 2;
            _loc_7.rotAdd = this._effectHeloRotFlag * 0.5;
            this._effectHeloRotFlag = this._effectHeloRotFlag * -1;
            _loc_7.blendMode = BlendMode.OVERLAY;
            _loc_7.vec = new Point(0, 0);
            _loc_7.bSmoothing = true;
            return _loc_7;
        }// end function

        private function cbLightCreate() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (_mc.currentLabel != _LABEL_DEAD)
            {
                this._effectLightMain.waitTime = 0.3;
                _loc_1 = [_mc.monster.LightGuideNull1, _mc.monster.LightGuideNull2, _mc.monster.LightGuideNull3, _mc.monster.LightGuideNull4];
                _loc_2 = _loc_1[Random.range(0, (_loc_1.length - 1))];
                _loc_3 = this.createLightParts(_loc_2, this._effectLightMain.bmpData, this._effectLightMain.mistBitmapData);
                this._effectLightMain.addEffect(_loc_3);
            }
            return;
        }// end function

        private function createLightParts(param1:MovieClip, param2:BitmapData, param3:BitmapData) : EffectParticleMistParts
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            _loc_4 = new Matrix();
            _loc_5 = _mc.transform.concatenatedMatrix.clone();
            _loc_5.invert();
            _loc_4 = param1.transform.concatenatedMatrix.clone();
            _loc_4.concat(_loc_5);
            _loc_6 = new Point(_loc_4.tx, _loc_4.ty);
            _loc_6 = this._effectLightMain.offset.add(_loc_6);
            _loc_7 = new EffectParticleMistParts(param2, param3, _loc_6, 0);
            _loc_7.setLiveTime(2, 2);
            _loc_7.vanishWaitTime = 2;
            _loc_7.rotAdd = Random.range(-2, 2);
            _loc_7.scale = 1;
            _loc_7.vec = new Point(Random.range(50, 80) * Random.range(-1, 1), Random.range(50, 80) * Random.range(-1, 1));
            _loc_7.blendMode = BlendMode.ADD;
            _loc_7.bReverse = true;
            _loc_7.bSmoothing = true;
            return _loc_7;
        }// end function

        private function playSeMotion() : void
        {
            if (_bLabelAnimDetailChange == false)
            {
                return;
            }
            if (_labelAnimDetail == "se1001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_WAGNAS_ATTACK_TAME);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_WAGNAS_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_WAGNAS_MAGIC_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_WAGNAS_MAGIC_TAME);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            var _loc_1:* = [];
            _loc_1.push(_HELO_EFFECT_PATH);
            _loc_1.push(_LIGHT_EFFECT_PATH);
            return _loc_1;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_WAGNAS_ATTACK_TAME, SoundId.SE_REV_WAGNAS_ATTACK_SWISH, SoundId.SE_REV_WAGNAS_MAGIC_START, SoundId.SE_REV_WAGNAS_MAGIC_TAME];
        }// end function

    }
}
