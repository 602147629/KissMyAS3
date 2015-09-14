package process
{
    import resource.*;
    import sound.*;
    import trainingRoom.*;

    public class ProcessTrainingRoom extends ProcessBase
    {
        private var _trainingRoomMain:TrainingRoomMain;

        public function ProcessTrainingRoom()
        {
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._trainingRoomMain)
            {
                this._trainingRoomMain.release();
            }
            this._trainingRoomMain = null;
            return;
        }// end function

        override public function init() : void
        {
            super.init();
            this._trainingRoomMain = new TrainingRoomMain(this);
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
            if (this._trainingRoomMain)
            {
                this._trainingRoomMain.control(param1);
                if (this._trainingRoomMain.bStay)
                {
                    _bTopbarButtonDisable = false;
                }
                else
                {
                    _bTopbarButtonDisable = true;
                }
                if (this._trainingRoomMain.bClose)
                {
                    Main.GetProcess().SetProcessId(this._trainingRoomMain.bJumpTradingPost ? (ProcessMain.PROCESS_TRADING_POST) : (ProcessMain.PROCESS_HOME));
                }
            }
            return;
        }// end function

    }
}
