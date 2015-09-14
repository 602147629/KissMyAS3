package process
{
    import barracks.*;
    import resource.*;
    import sound.*;
    import user.*;

    public class ProcessBarracks extends ProcessBase
    {
        private var _barracksMain:BarracksMain;

        public function ProcessBarracks()
        {
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._barracksMain)
            {
                this._barracksMain.release();
            }
            this._barracksMain = null;
            return;
        }// end function

        override public function init() : void
        {
            UserDataManager.getInstance().updateSp();
            super.init();
            this._barracksMain = new BarracksMain(this);
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
            if (this._barracksMain)
            {
                this._barracksMain.control(param1);
                if (this._barracksMain.bStay == false)
                {
                    _bTopbarButtonDisable = true;
                }
                else
                {
                    _bTopbarButtonDisable = false;
                }
                if (this._barracksMain.bClose)
                {
                    Main.GetProcess().SetProcessId(this._barracksMain.bJumpTradingPost ? (ProcessMain.PROCESS_TRADING_POST) : (ProcessMain.PROCESS_HOME));
                }
            }
            return;
        }// end function

    }
}
