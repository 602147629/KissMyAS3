package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EnemyBossRocbouquet extends EnemyDisplay
    {
        private var _waitTime:Number;
        private var _bFireEnd:Boolean;
        private var _effectFireMainFront:EffectParticleBossFireMain;
        private var _effectFireMainBack:EffectParticleBossFireMain;
        private var _effectManager:EffectManager;
        private var _effectFront:EffectMc;
        private var _effectBack:EffectMc;
        private var _colorTransform:ColorTransform;
        private static const _WAIT_TIME:Number = 1.66;
        private static const _EFFECT_SKULL_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "skull.png";
        private static const _EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_SWF_PATH + "Effect_Rocbouquet_EF00.swf";

        public function EnemyBossRocbouquet(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            this._waitTime = 0;
            this._effectFireMainFront = new EffectParticleBossFireMain(null, _layer.getLayer(LayerCharacter.FRONT_EFFECT), this.cbFireCreateFront, _WAIT_TIME, _EFFECT_SKULL_PATH, new Point(0.4, 0.4));
            this._effectFireMainFront.waitTime = Random.range(0.83, 1.5);
            this._effectFireMainBack = new EffectParticleBossFireMain(null, _layer.getLayer(LayerCharacter.BACK_EFFECT), this.cbFireCreateBack, _WAIT_TIME, _EFFECT_SKULL_PATH, new Point(0.4, 0.4));
            this._effectFireMainBack.waitTime = Random.range(0.83, 1.5);
            this._effectManager = new EffectManager();
            this._effectFront = new EffectMc(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _EFFECT_PATH, "effectFrontMc", new Point());
            this._effectManager.addEffect(this._effectFront);
            this._effectBack = new EffectMc(_layer.getLayer(LayerCharacter.BACK_EFFECT), _EFFECT_PATH, "effectBackMc", new Point());
            this._effectManager.addEffect(this._effectBack);
            this._colorTransform = new ColorTransform();
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
            if (this._effectFireMainFront)
            {
                this._effectFireMainFront.release();
            }
            this._effectFireMainFront = null;
            if (this._effectFireMainBack)
            {
                this._effectFireMainBack.release();
            }
            this._effectFireMainBack = null;
            if (this._effectManager)
            {
                this._effectManager.release();
            }
            this._effectManager = null;
            if (this._effectFront)
            {
                this._effectFront.release();
            }
            this._effectFront = null;
            if (this._effectBack)
            {
                this._effectBack.release();
            }
            this._effectBack = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            this._effectManager.control(param1);
            this._effectFireMainFront.control(param1);
            this._effectFireMainBack.control(param1);
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            if (_bLabelAnimChange == true)
            {
                if (_mc.currentLabel == _LABEL_DEAD)
                {
                    this._colorTransform.alphaMultiplier = 0;
                    this._effectManager.setColorTransform(this._colorTransform);
                }
                else
                {
                    this._colorTransform.alphaMultiplier = 1;
                    this._effectManager.setColorTransform(this._colorTransform);
                }
            }
            this.playSeMotion();
            return;
        }// end function

        public function cbFireCreateFront() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this._bFireEnd == false && _mc.currentLabel != _LABEL_DEAD)
            {
                this._effectFireMainFront.waitTime = 0.2;
                _loc_1 = [_mc.monster.SteamGuideNull1, _mc.monster.SteamGuideNull2, _mc.monster.SteamGuideNull3, _mc.monster.SteamGuideNull4, _mc.monster.SteamGuideNull5];
                _loc_6 = _loc_1[Random.range(0, (_loc_1.length - 1))];
                _loc_2 = new Matrix();
                _loc_3 = _mc.transform.concatenatedMatrix.clone();
                _loc_3.invert();
                _loc_2 = _loc_6.transform.concatenatedMatrix.clone();
                _loc_2.concat(_loc_3);
                _loc_4 = new Point(_loc_2.tx, _loc_2.ty);
                _loc_4 = this._effectFireMainFront.offset.add(_loc_4);
                _loc_5 = new EffectParticleFireParts(this._effectFireMainFront.bmpData, this._effectFireMainFront.fireBitmapData, _loc_4, -30);
                _loc_5.setLiveTime(0.8, 1);
                _loc_5.vanishWaitTime = 0.3;
                _loc_5.rotAdd = Random.range(-1, 1);
                _loc_5.scale = Random.range(50, 150) * 0.01;
                _loc_5.blendMode = BlendMode.NORMAL;
                if (Random.range(1, 2) == 1)
                {
                    _loc_5.bReverse = false;
                }
                else
                {
                    _loc_5.bReverse = true;
                }
                _loc_5.bSmoothing = true;
                this._effectFireMainFront.addEffect(_loc_5);
            }
            return;
        }// end function

        public function cbFireCreateBack() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this._bFireEnd == false && _mc.currentLabel != _LABEL_DEAD)
            {
                this._effectFireMainBack.waitTime = 0.2;
                _loc_1 = [_mc.monster.SteamGuideNull6, _mc.monster.SteamGuideNull7, _mc.monster.SteamGuideNull8, _mc.monster.SteamGuideNull9, _mc.monster.SteamGuideNull10];
                _loc_6 = _loc_1[Random.range(0, (_loc_1.length - 1))];
                _loc_2 = new Matrix();
                _loc_3 = _mc.transform.concatenatedMatrix.clone();
                _loc_3.invert();
                _loc_2 = _loc_6.transform.concatenatedMatrix.clone();
                _loc_2.concat(_loc_3);
                _loc_4 = new Point(_loc_2.tx, _loc_2.ty);
                _loc_4 = this._effectFireMainBack.offset.add(_loc_4);
                _loc_5 = new EffectParticleFireParts(this._effectFireMainBack.bmpData, this._effectFireMainBack.fireBitmapData, _loc_4, -30);
                _loc_5.setLiveTime(0.8, 1);
                _loc_5.vanishWaitTime = 0.3;
                _loc_5.rotAdd = Random.range(-1, 1);
                _loc_5.scale = Random.range(50, 150) * 0.01;
                _loc_5.blendMode = BlendMode.NORMAL;
                if (Random.range(1, 2) == 1)
                {
                    _loc_5.bReverse = false;
                }
                else
                {
                    _loc_5.bReverse = true;
                }
                _loc_5.bSmoothing = true;
                this._effectFireMainBack.addEffect(_loc_5);
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
                SoundManager.getInstance().playSe(SoundId.SE_REV_ROCBOUQUET_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_ROCBOUQUET_ATTACK_SWORDSET);
            }
            if (_labelAnimDetail == "se1003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_ROCBOUQUET_ATTACK_TAME);
            }
            if (_labelAnimDetail == "se1004")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_ROCBOUQUET_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_ROCBOUQUET_ATTACK_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_ROCBOUQUET_ATTACK_SWORDSET);
            }
            if (_labelAnimDetail == "se2003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_ROCBOUQUET_MAGIC_TAME);
            }
            if (_labelAnimDetail == "se2004")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_ROCBOUQUET_MAGIC_SHOT);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            return [_EFFECT_SKULL_PATH, _EFFECT_PATH];
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_ROCBOUQUET_ATTACK_START, SoundId.SE_REV_ROCBOUQUET_ATTACK_SWORDSET, SoundId.SE_REV_ROCBOUQUET_ATTACK_TAME, SoundId.SE_REV_ROCBOUQUET_ATTACK_SWISH, SoundId.SE_REV_ROCBOUQUET_ATTACK_START, SoundId.SE_REV_ROCBOUQUET_ATTACK_SWORDSET, SoundId.SE_REV_ROCBOUQUET_MAGIC_TAME, SoundId.SE_REV_ROCBOUQUET_MAGIC_SHOT];
        }// end function

    }
}
