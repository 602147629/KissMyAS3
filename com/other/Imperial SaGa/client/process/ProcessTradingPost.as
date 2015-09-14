package process
{
    import resource.*;
    import sound.*;
    import tradingPost.*;

    public class ProcessTradingPost extends ProcessBase
    {
        private var _tradingPostMain:TradingPostMain;

        public function ProcessTradingPost()
        {
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._tradingPostMain)
            {
                this._tradingPostMain.release();
            }
            this._tradingPostMain = null;
            return;
        }// end function

        override public function init() : void
        {
            super.init();
            this._tradingPostMain = new TradingPostMain(this);
            _bResourceLoadWait = true;
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            if (ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false)
            {
                return;
            }
            _bTopbarButtonDisable = false;
            _bResourceLoadWait = false;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            if (this._tradingPostMain)
            {
                this._tradingPostMain.control(param1);
                if (this._tradingPostMain.bStay)
                {
                    _bTopbarButtonDisable = false;
                }
                else
                {
                    _bTopbarButtonDisable = true;
                }
                if (this._tradingPostMain.bClose)
                {
                    Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
                }
            }
            return;
        }// end function

    }
}
