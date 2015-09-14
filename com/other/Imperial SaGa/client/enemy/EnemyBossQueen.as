package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import sound.*;

    public class EnemyBossQueen extends EnemyDisplayAfterImage
    {
        private var _effectManager:EffectManager;

        public function EnemyBossQueen(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            _blurPow = new Point(10, 10);
            _blurTime = 2.3;
            _blurLiveTime = 0.8;
            _blurVec = new Point(0, 0);
            _blurColor = new ColorTransform(1, 1, 1, 0.8, 96, 0, 32, 0);
            _blurEndColor = new ColorTransform(1, 1, 1, 0, 0, 0, 0, 0);
            _bBlurFront = true;
            _blendMode = BlendMode.ADD;
            this._effectManager = new EffectManager();
            setBlurEffect();
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
                SoundManager.getInstance().playSe(SoundId.SE_REV_QUEEN_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_QUEEN_ATTACK_SWORDSET);
            }
            if (_labelAnimDetail == "se1003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_QUEEN_ATTACK_STRIKE);
            }
            if (_labelAnimDetail == "se1004")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_QUEEN_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_QUEEN_ATTACK_SWORDSET);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_QUEEN_MAGIC_TAME);
            }
            if (_labelAnimDetail == "se2003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_QUEEN_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se2004")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_QUEEN_MAGIC_SHOT);
            }
            return;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_QUEEN_ATTACK_START, SoundId.SE_REV_QUEEN_ATTACK_STRIKE, SoundId.SE_REV_QUEEN_ATTACK_SWISH, SoundId.SE_REV_QUEEN_ATTACK_SWORDSET, SoundId.SE_REV_QUEEN_MAGIC_TAME, SoundId.SE_REV_QUEEN_MAGIC_SHOT];
        }// end function

    }
}
