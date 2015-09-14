package process
{
    import employment.*;
    import resource.*;
    import sound.*;
    import tradingPost.*;

    public class ProcessEmployment extends ProcessBase
    {
        private var _employmentMain:EmploymentMain;

        public function ProcessEmployment()
        {
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._employmentMain)
            {
                this._employmentMain.release();
            }
            this._employmentMain = null;
            return;
        }// end function

        override public function init() : void
        {
            super.init();
            this._employmentMain = new EmploymentMain(this);
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
            if (this._employmentMain)
            {
                this._employmentMain.control(param1);
                if (this._employmentMain.bStay)
                {
                    _bTopbarButtonDisable = false;
                }
                else
                {
                    _bTopbarButtonDisable = true;
                }
                if (this._employmentMain.bClose)
                {
                    if (this._employmentMain.bGoTradingPost)
                    {
                        TradingPostStartPageRequest.getInstance().setRequestWarriorIncrease();
                        Main.GetProcess().SetProcessId(ProcessMain.PROCESS_TRADING_POST);
                    }
                    else if (this._employmentMain.bGoRetire)
                    {
                        Main.GetProcess().SetProcessId(ProcessMain.PROCESS_RETIRE);
                    }
                    else
                    {
                        Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
                    }
                }
            }
            return;
        }// end function

    }
}
