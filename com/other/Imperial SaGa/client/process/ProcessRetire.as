package process
{
    import resource.*;
    import retire.*;
    import sound.*;

    public class ProcessRetire extends ProcessBase
    {
        private var _retireMain:RetireMain;

        public function ProcessRetire()
        {
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._retireMain)
            {
                this._retireMain.release();
            }
            this._retireMain = null;
            return;
        }// end function

        override public function init() : void
        {
            super.init();
            this._retireMain = new RetireMain(this);
            _bResourceLoadWait = true;
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            if (ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false)
            {
                return;
            }
            _bResourceLoadWait = false;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            if (this._retireMain)
            {
                this._retireMain.control(param1);
                if (this._retireMain.bStay == false)
                {
                    _bTopbarButtonDisable = true;
                }
                else
                {
                    _bTopbarButtonDisable = false;
                }
                if (this._retireMain.bClose)
                {
                    Main.GetProcess().SetProcessId(this._retireMain.bJumpTradingPost ? (ProcessMain.PROCESS_TRADING_POST) : (Main.GetProcess().prevProcessId));
                }
            }
            return;
        }// end function

    }
}
