package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import sound.*;

    public class EnemyBossGiantArmor extends EnemyDisplay
    {
        private var _effectManager:EffectManager;
        private var _bulrParent:Sprite;
        private var _effectAfterImagePut:EffectAfterImagePut;

        public function EnemyBossGiantArmor(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            this._effectManager = new EffectManager();
            this._bulrParent = new Sprite();
            _layer.getLayer(LayerCharacter.BACK_EFFECT).addChild(this._bulrParent);
            this._effectAfterImagePut = new EffectAfterImagePut(this._bulrParent, _mc);
            this._effectManager.addEffect(this._effectAfterImagePut);
            this.setBlurEffect();
            return;
        }// end function

        override public function release() : void
        {
            super.release();
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
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            this.playSeMotion();
            return;
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
                SoundManager.getInstance().playSe(SoundId.SE_REV_ATITAN_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_ATITAN_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_ATITAN_MAGIC_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_ATITAN_MAGIC_TAME);
            }
            if (_labelAnimDetail == "se2003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_ATITAN_MAGIC_SHOT);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            var _loc_1:* = [];
            return _loc_1;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_ATITAN_ATTACK_START, SoundId.SE_REV_ATITAN_ATTACK_SWISH, SoundId.SE_REV_ATITAN_MAGIC_START, SoundId.SE_REV_ATITAN_MAGIC_TAME, SoundId.SE_REV_ATITAN_MAGIC_SHOT];
        }// end function

    }
}
