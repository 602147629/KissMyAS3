package enemy
{
    import flash.display.*;
    import flash.geom.*;
    import sound.*;

    public class EnemyBossBokuorn extends EnemyDisplayAfterImage
    {

        public function EnemyBossBokuorn(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            _blurPow = new Point(5, 5);
            _blurTime = 0.2;
            _blurLiveTime = 0.4;
            _blurVec = new Point(0, 0);
            _blurColor = new ColorTransform(1, 0.8, 1, 0.5, 100, 0, 100, 0);
            _blurEndColor = new ColorTransform(1, 0.8, 1, 0, 100, 0, 100, 0);
            setBlurEffect();
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
                SoundManager.getInstance().playSe(SoundId.SE_REV_BOKUOHN_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_BOKUOHN_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_BOKUOHN_ATTACK_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_BOKUOHN_MAGIC_TAME);
            }
            return;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_BOKUOHN_ATTACK_START, SoundId.SE_REV_BOKUOHN_ATTACK_SWISH, SoundId.SE_REV_BOKUOHN_MAGIC_TAME];
        }// end function

    }
}
