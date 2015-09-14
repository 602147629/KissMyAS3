package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class EnemyBossForneus extends EnemyDisplay
    {
        private var _effectManager:EffectManager;
        private var _effectFront:EffectMc;
        private var _effectBack:EffectMc;
        private static const _EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_SWF_PATH + "Effect_Forneus_EF00.swf";

        public function EnemyBossForneus(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            this._effectManager = new EffectManager();
            this._effectFront = new EffectMc(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _EFFECT_PATH, "effectFrontMc", new Point());
            this._effectManager.addEffect(this._effectFront);
            this._effectBack = new EffectMc(_layer.getLayer(LayerCharacter.BACK_EFFECT), _EFFECT_PATH, "effectBackMc", new Point());
            this._effectManager.addEffect(this._effectBack);
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

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            this.playSeMotion();
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
                SoundManager.getInstance().playSe(SoundId.SE_REV_FORNEUS_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_FORNEUS_ATTACK_SWORDSET);
            }
            if (_labelAnimDetail == "se1003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_FORNEUS_ATTAVK_SWISH);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_FORNEUS_ATTACK_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_FORNEUS_MAGIC_TAME);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            return [_EFFECT_PATH];
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_FORNEUS_ATTACK_START, SoundId.SE_REV_FORNEUS_ATTACK_SWORDSET, SoundId.SE_REV_FORNEUS_ATTAVK_SWISH, SoundId.SE_REV_FORNEUS_MAGIC_TAME];
        }// end function

    }
}
