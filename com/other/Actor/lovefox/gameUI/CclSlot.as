package lovefox.gameUI
{
    import lovefox.gui.*;

    public class CclSlot extends Slot
    {
        private var _openclip:GClip;

        public function CclSlot(param1, param2)
        {
            super(param1, param2);
            this.init();
            return;
        }// end function

        override public function init()
        {
            super.init();
            this._openclip = GClip.newGClip("ccl");
            this._openclip.x = -6;
            this._openclip.y = 2;
            addChild(this._openclip);
            this._openclip.gotoAndStop(0);
            this.reset();
            return;
        }// end function

        public function setState()
        {
            if (enabled)
            {
                this.reset();
            }
            else
            {
                this.setOpened();
            }
            return;
        }// end function

        public function reset()
        {
            this.enabled = true;
            buttonMode = true;
            this._openclip.gotoAndStop(0);
            return;
        }// end function

        public function setOpened()
        {
            this.enabled = false;
            buttonMode = false;
            this._openclip.gotoAndStop(5);
            return;
        }// end function

        public function setOpenEffect(param1:int, param2:int)
        {
            this.enabled = false;
            buttonMode = false;
            this._openclip.gotoAndPlay(0, false);
            return;
        }// end function

    }
}
