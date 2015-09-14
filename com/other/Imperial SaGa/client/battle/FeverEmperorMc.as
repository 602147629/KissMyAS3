package battle
{
    import flash.display.*;
    import player.*;
    import resource.*;

    public class FeverEmperorMc extends Object
    {
        private var _WAIT_COUNT:Number = 0.5;
        private var _baseMc:MovieClip;
        private var _bmBustUp:Bitmap;
        private var _waitCount:Number;
        private var _bEnd:Boolean;

        public function FeverEmperorMc(param1:MovieClip, param2:int)
        {
            this._baseMc = param1;
            this._waitCount = this._WAIT_COUNT;
            var _loc_3:* = PlayerManager.getInstance().getPlayerInformation(param2);
            this._bmBustUp = ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + _loc_3.bustUpFileName);
            this._bmBustUp.smoothing = true;
            this._bmBustUp.x = this._bmBustUp.x - this._bmBustUp.width / 2;
            this._bmBustUp.y = this._bmBustUp.y - this._bmBustUp.height;
            this._baseMc.emperorNull.addChild(this._bmBustUp);
            return;
        }// end function

        public function release() : void
        {
            if (this._bmBustUp && this._bmBustUp.parent)
            {
                this._bmBustUp.parent.removeChild(this._bmBustUp);
            }
            this._bmBustUp = null;
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bEnd == false && this._baseMc.currentLabel == "end")
            {
                this._waitCount = this._waitCount - param1;
                if (this._waitCount <= 0)
                {
                    this._bEnd = true;
                }
            }
            return;
        }// end function

        public function start() : void
        {
            this._bEnd = false;
            this._baseMc.gotoAndPlay("in");
            return;
        }// end function

        public function visible(param1:Boolean) : void
        {
            if (this._baseMc)
            {
                this._baseMc.visible = param1;
            }
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

    }
}
