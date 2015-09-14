package battle
{
    import flash.display.*;
    import message.*;
    import player.*;
    import resource.*;
    import utility.*;

    public class BattleCutIn extends Object
    {
        private var _mcCutIn:MovieClip;
        private var _isoMain:InStayOut;
        private var _mcWordTop:MovieClip;
        private var _mcWordBottom:MovieClip;
        private var _mcBustUp:MovieClip;
        private var _bmBustUp:Bitmap;

        public function BattleCutIn(param1:int, param2:MovieClip)
        {
            var _loc_3:* = PlayerManager.getInstance().getPlayerInformation(param1);
            this._bmBustUp = ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + _loc_3.bustUpFileName);
            this._bmBustUp.smoothing = true;
            this._bmBustUp.x = this._bmBustUp.x - this._bmBustUp.width / 2;
            this._bmBustUp.y = this._bmBustUp.y - this._bmBustUp.height;
            this._mcCutIn = param2;
            this._mcWordTop = this._mcCutIn.chrCutInMc.chrCutInBalloonMc;
            this._mcWordBottom = this._mcCutIn.chrCutInMc.chrCutInBalloon2Mc;
            this._mcWordTop.visible = false;
            this._mcWordBottom.visible = false;
            this._mcCutIn.chrCutInMc.cutInCharaNull.addChild(this._bmBustUp);
            this._isoMain = new InStayOut(this._mcCutIn);
            this._isoMain.setIn();
            return;
        }// end function

        public function get bOpened() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoMain.bEnd;
        }// end function

        public function release() : void
        {
            if (this._mcBustUp)
            {
                if (this._mcBustUp.parent)
                {
                    this._mcBustUp.parent.removeChild(this._mcBustUp);
                }
            }
            this._mcBustUp = null;
            if (this._bmBustUp && this._bmBustUp.parent != null)
            {
                this._bmBustUp.parent.removeChild(this._bmBustUp);
            }
            this._bmBustUp = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            this._mcWordTop = null;
            this._mcWordBottom = null;
            this._mcCutIn = null;
            return;
        }// end function

        public function setClose() : void
        {
            this._isoMain.setOut();
            return;
        }// end function

        public function setWordTop(param1:String) : void
        {
            this._mcWordTop.visible = true;
            this.setMessage(param1, this._mcWordTop);
            return;
        }// end function

        private function setMessage(param1:String, param2:MovieClip) : void
        {
            TextControl.setText(param2.textMc.textDt, param1);
            return;
        }// end function

    }
}
