package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EnemyBossRealQueen extends EnemyDisplay
    {
        private var _waitTime:Number;
        private var _bFireEnd:Boolean;
        private var _effectFireMain:EffectParticleBossFireMain;
        private static const _WAIT_TIME:Number = 0.8;
        private static const _EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "fireBlue.png";

        public function EnemyBossRealQueen(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            this._effectFireMain = new EffectParticleBossFireMain(null, _layer.getLayer(LayerCharacter.FRONT_EFFECT), this.cbFireCreate, _WAIT_TIME, _EFFECT_PATH, new Point(0.2, 0.2));
            this._waitTime = 0;
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
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            this._effectFireMain.control(param1);
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            this.playSeMotion();
            return;
        }// end function

        public function cbFireCreate() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (this._bFireEnd == false && _mc.currentLabel != _LABEL_DEAD)
            {
                _loc_1 = Random.range(1, 2);
                _loc_2 = [_mc.monster.SteamGuideNull1, _mc.monster.SteamGuideNull2, _mc.monster.SteamGuideNull3, _mc.monster.SteamGuideNull4, _mc.monster.SteamGuideNull5, _mc.monster.SteamGuideNull6, _mc.monster.SteamGuideNull7, _mc.monster.SteamGuideNull8];
                _loc_3 = 0;
                while (_loc_3 < _loc_1)
                {
                    
                    _loc_4 = _loc_2[Random.range(0, (_loc_2.length - 1))];
                    _loc_5 = new Matrix();
                    _loc_6 = _mc.transform.concatenatedMatrix.clone();
                    _loc_6.invert();
                    _loc_5 = _loc_4.transform.concatenatedMatrix.clone();
                    _loc_5.concat(_loc_6);
                    _loc_7 = new Point(_loc_5.tx, _loc_5.ty);
                    _loc_7 = this._effectFireMain.offset.add(_loc_7);
                    _loc_8 = new EffectParticleFireParts(this._effectFireMain.bmpData, this._effectFireMain.fireBitmapData, _loc_7, -50);
                    new EffectParticleFireParts(this._effectFireMain.bmpData, this._effectFireMain.fireBitmapData, _loc_7, -50).rotAdd = _loc_8.rotAdd * 0.5;
                    _loc_8.maxAlpha = 0.8;
                    _loc_8.setLiveTime(1, 1.5);
                    _loc_8.blendMode = BlendMode.NORMAL;
                    _loc_8.setOffsetColor(255, 255, 255);
                    _loc_8.vecFriction = 2;
                    this._effectFireMain.addEffect(_loc_8);
                    _loc_3++;
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
                SoundManager.getInstance().playSe(SoundId.SE_REV_REALQUEEN_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_REALQUEEN_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_REALQUEEN_ATTACK_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_REALQUEEN_MAGIC_TAME);
            }
            if (_labelAnimDetail == "se2003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_REALQUEEN_MAGIC_SHOT);
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
            return [SoundId.SE_REV_REALQUEEN_ATTACK_START, SoundId.SE_REV_REALQUEEN_ATTACK_SWISH, SoundId.SE_REV_REALQUEEN_ATTACK_START, SoundId.SE_REV_REALQUEEN_MAGIC_TAME, SoundId.SE_REV_REALQUEEN_MAGIC_SHOT];
        }// end function

    }
}
