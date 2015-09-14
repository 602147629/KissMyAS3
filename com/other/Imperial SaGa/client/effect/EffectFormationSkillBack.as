package effect
{
    import flash.display.*;
    import flash.geom.*;
    import player.*;
    import resource.*;

    public class EffectFormationSkillBack extends EffectMc
    {
        private var _cutInMc:MovieClip;
        private var _cutInCharaMc:MovieClip;
        private var _cutInBustUp:Bitmap;

        public function EffectFormationSkillBack(param1:DisplayObjectContainer, param2:String, param3:String, param4:Point, param5:int)
        {
            super(param1, param2, param3, param4);
            this._cutInMc = _mcEffect.battleCutInMc;
            this._cutInMc.x = this._cutInMc.x - (this._cutInMc.x + param4.x);
            var _loc_6:* = PlayerManager.getInstance().getPlayerInformation(param5);
            this._cutInBustUp = ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + _loc_6.bustUpFileName);
            if (this._cutInBustUp != null)
            {
                this._cutInBustUp.smoothing = true;
                this._cutInBustUp.x = this._cutInBustUp.x - this._cutInBustUp.width / 2;
                this._cutInBustUp.y = this._cutInBustUp.y - this._cutInBustUp.height;
                this._cutInMc.skillCutInMoveMc.cutInCharaNull.addChild(this._cutInBustUp);
            }
            return;
        }// end function

        public function setStop() : void
        {
            _mcEffect.stop();
            return;
        }// end function

        public function setPlay() : void
        {
            _mcEffect.play();
            return;
        }// end function

        override public function release() : void
        {
            if (this._cutInCharaMc)
            {
                this._cutInCharaMc.parent.removeChild(this._cutInCharaMc);
            }
            this._cutInCharaMc = null;
            if (this._cutInBustUp && this._cutInBustUp.parent != null)
            {
                this._cutInBustUp.parent.removeChild(this._cutInBustUp);
            }
            this._cutInBustUp = null;
            this._cutInMc = null;
            super.release();
            return;
        }// end function

    }
}
