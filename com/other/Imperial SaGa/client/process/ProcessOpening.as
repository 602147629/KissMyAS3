package process
{
    import opening.*;
    import resource.*;
    import sound.*;
    import user.*;

    public class ProcessOpening extends ProcessBase
    {
        private var _openingMain:OpeningMain;

        public function ProcessOpening()
        {
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._openingMain)
            {
                this._openingMain.release();
            }
            this._openingMain = null;
            return;
        }// end function

        override public function init() : void
        {
            super.init();
            this._openingMain = new OpeningMain(this);
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
            if (this._openingMain)
            {
                this._openingMain.control(param1);
                if (this._openingMain.bClose)
                {
                    UserDataManager.getInstance().userData.statusType = CommonConstant.USER_STATE_TUTORIAL;
                    Main.GetProcess().SetProcessId(ProcessMain.PROCESS_LOGIN_AFTER);
                }
            }
            return;
        }// end function

    }
}
