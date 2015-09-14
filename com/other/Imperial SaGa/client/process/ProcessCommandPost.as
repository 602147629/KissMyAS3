package process
{
    import commandPost.*;
    import resource.*;
    import sound.*;
    import user.*;

    public class ProcessCommandPost extends ProcessBase
    {
        private var _commandPostMain:CommandPostMain;

        public function ProcessCommandPost()
        {
            Main.GetProcess().createLoadingScreen();
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._commandPostMain)
            {
                this._commandPostMain.release();
            }
            this._commandPostMain = null;
            return;
        }// end function

        override public function init() : void
        {
            UserDataManager.getInstance().updateSp();
            super.init();
            this._commandPostMain = new CommandPostMain(this);
            _bResourceLoadWait = true;
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            if (ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false)
            {
                return;
            }
            if (Main.GetProcess().isNowLoading())
            {
                Main.GetProcess().closeLoadingScreen();
                return;
            }
            _bResourceLoadWait = false;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            if (this._commandPostMain != null)
            {
                this._commandPostMain.control(param1);
                if (this._commandPostMain.bStay)
                {
                    _bTopbarButtonDisable = false;
                }
                else
                {
                    _bTopbarButtonDisable = true;
                }
                if (this._commandPostMain.bClose)
                {
                    Main.GetProcess().SetProcessId(this._commandPostMain.nextProcessId);
                }
            }
            return;
        }// end function

    }
}
