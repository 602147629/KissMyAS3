package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EnemyBossGiantSuperLarge extends EnemyDisplay
    {
        private var _effectManager:EffectManager;
        private var _bulrParent:Sprite;
        private var _effectAfterImagePut:EffectAfterImagePut;
        private var _effectMistMainFront:EffectParticleBossMistMain;
        private var _effectMistMainBack:EffectParticleBossMistMain;
        private static const _START_WAIT_TIME:Number = 0.1;
        private static const _WAIT_TIME:Number = 0.3;
        private static const _MIST_EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "cloud.png";

        public function EnemyBossGiantSuperLarge(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            this._effectManager = new EffectManager();
            this._bulrParent = new Sprite();
            _layer.getLayer(LayerCharacter.BACK_EFFECT).addChild(this._bulrParent);
            this._effectAfterImagePut = new EffectAfterImagePut(this._bulrParent, _mc);
            this._effectManager.addEffect(this._effectAfterImagePut);
            this.setBlurEffect();
            this._effectMistMainFront = new EffectParticleBossMistMain(null, _layer.getLayer(LayerCharacter.FRONT_EFFECT), this.cbMistCreateFront, _START_WAIT_TIME, _MIST_EFFECT_PATH, new Point(0.8, 0.8));
            this._effectMistMainFront.waitTime = Random.range(0.83, 1.5);
            this._effectMistMainBack = new EffectParticleBossMistMain(null, _layer.getLayer(LayerCharacter.BACK_EFFECT), this.cbMistCreateBack, _START_WAIT_TIME, _MIST_EFFECT_PATH, new Point(0.8, 0.8));
            this._effectMistMainBack.waitTime = Random.range(0.83, 1.5);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._effectMistMainFront)
            {
                this._effectMistMainFront.release();
            }
            this._effectMistMainFront = null;
            if (this._effectMistMainBack)
            {
                this._effectMistMainBack.release();
            }
            this._effectMistMainBack = null;
            if (this._effectManager)
            {
                this._effectManager.release();
            }
            this._effectManager = null;
            if (this._bulrParent)
            {
                if (this._bulrParent.parent)
                {
                    this._bulrParent.parent.removeChild(this._bulrParent);
                }
            }
            this._bulrParent = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            this._effectAfterImagePut.bStop = _mc.currentLabel != _LABEL_ATTACK;
            if (this._effectManager)
            {
                this._effectManager.control(param1);
            }
            if (this._effectMistMainFront)
            {
                this._effectMistMainFront.control(param1);
            }
            if (this._effectMistMainBack)
            {
                this._effectMistMainBack.control(param1);
            }
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            this.playSeMotion();
            return;
        }// end function

        private function cbMistCreateFront() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (_mc.currentLabel != _LABEL_DEAD)
            {
                this._effectMistMainFront.waitTime = _WAIT_TIME;
                _loc_1 = [_mc.monster.SteamGuideNull1, _mc.monster.SteamGuideNull2, _mc.monster.SteamGuideNull3, _mc.monster.SteamGuideNull4];
                _loc_2 = _loc_1[Random.range(0, (_loc_1.length - 1))];
                _loc_3 = this.createMistParts(_loc_2, this._effectMistMainFront.bmpData, this._effectMistMainFront.mistBitmapData);
                this._effectMistMainFront.addEffect(_loc_3);
            }
            return;
        }// end function

        private function cbMistCreateBack() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (_mc.currentLabel != _LABEL_DEAD)
            {
                this._effectMistMainBack.waitTime = _WAIT_TIME;
                _loc_1 = [_mc.monster.SteamGuideNull5, _mc.monster.SteamGuideNull6, _mc.monster.SteamGuideNull7];
                _loc_2 = _loc_1[Random.range(0, (_loc_1.length - 1))];
                _loc_3 = this.createMistParts(_loc_2, this._effectMistMainBack.bmpData, this._effectMistMainBack.mistBitmapData);
                this._effectMistMainBack.addEffect(_loc_3);
            }
            return;
        }// end function

        private function createMistParts(param1:MovieClip, param2:BitmapData, param3:BitmapData) : EffectParticleMistParts
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
            _loc_6 = this._effectMistMainBack.offset.add(_loc_6);
            _loc_7 = new EffectParticleMistParts(param2, param3, _loc_6, 0);
            _loc_7.setLiveTime(4, 4);
            _loc_7.vanishWaitTime = 2;
            _loc_7.rotAdd = 0;
            _loc_7.scale = Random.range(50, 150) * 0.01;
            _loc_7.vec.x = Random.range(0, 50) * -1;
            _loc_7.vec.y = Random.range(0, 50) * -1;
            if (Random.range(1, 2) == 1)
            {
                _loc_7.blendMode = BlendMode.NORMAL;
                _loc_7.bReverse = false;
            }
            else
            {
                _loc_7.blendMode = BlendMode.NORMAL;
                _loc_7.bReverse = true;
            }
            _loc_7.bSmoothing = true;
            return _loc_7;
        }// end function

        private function setBlurEffect() : void
        {
            this._effectAfterImagePut.setBlur(0, 0);
            this._effectAfterImagePut.blurTime = 0.1;
            this._effectAfterImagePut.blurLiveTime = 0.5;
            this._effectAfterImagePut.vec = new Point(0, 0);
            this._effectAfterImagePut.scaleAdd = 0;
            this._effectAfterImagePut.colorTransform = new ColorTransform(0.7, 0.6, 0.5, 0.2);
            this._effectAfterImagePut.endColorTransform = new ColorTransform(0.7, 0.6, 0.5, 0);
            this._effectAfterImagePut.bStop = true;
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
                SoundManager.getInstance().playSe(SoundId.SE_REV_BTITAN_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_BTITAN_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se1003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_BTITAN_ATTACK_HIT);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            var _loc_1:* = [_MIST_EFFECT_PATH];
            return _loc_1;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_BTITAN_ATTACK_START, SoundId.SE_REV_BTITAN_ATTACK_SWISH, SoundId.SE_REV_BTITAN_ATTACK_HIT];
        }// end function

    }
}
