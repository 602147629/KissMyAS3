package process
{
    import dailyMission.*;
    import resource.*;
    import sound.*;

    public class ProcessDailyMission extends ProcessBase
    {
        private var _dailyMissionMain:DailyMissionMain;

        public function ProcessDailyMission()
        {
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._dailyMissionMain)
            {
                this._dailyMissionMain.release();
            }
            this._dailyMissionMain = null;
            return;
        }// end function

        override public function init() : void
        {
            super.init();
            this._dailyMissionMain = new DailyMissionMain(this);
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
            if (this._dailyMissionMain)
            {
                this._dailyMissionMain.control(param1);
                if (this._dailyMissionMain.bStay == false)
                {
                    _bTopbarButtonDisable = true;
                }
                else
                {
                    _bTopbarButtonDisable = false;
                }
                if (this._dailyMissionMain.bClose)
                {
                    Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
                }
            }
            return;
        }// end function

    }
}
