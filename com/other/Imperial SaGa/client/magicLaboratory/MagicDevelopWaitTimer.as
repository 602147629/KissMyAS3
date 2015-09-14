package magicLaboratory
{
    import button.*;
    import flash.display.*;
    import utility.*;

    public class MagicDevelopWaitTimer extends MagicDevelopBase
    {
        private var _timerDisp:NumericNumberMc;

        public function MagicDevelopWaitTimer(param1:MovieClip, param2:Boolean, param3:Boolean = false)
        {
            super(param1, param2, param3);
            if (!param2)
            {
                _isoMain.setEnd();
            }
            this._timerDisp = new NumericNumberMc(param1.remainingTimeMc, 0, 0);
            this.control(0);
            return;
        }// end function

        public function get bOpened() : Boolean
        {
            return _isoMain.bOpened;
        }// end function

        public function get bTimeOut() : Boolean
        {
            return MagicLabolatoryManager.getInstance().isDevelopTimeOut();
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (this.bTimeOut)
            {
                this._timerDisp.setNum(0);
            }
            else
            {
                _loc_2 = MagicLabolatoryManager.getInstance().getDevelopWaitTime();
                _loc_3 = _loc_2 % 60;
                _loc_4 = _loc_2 / 60 % 60;
                _loc_5 = _loc_2 / 60 / 60;
                this._timerDisp.setNum(_loc_5 * 10000 + _loc_4 * 100 + _loc_3);
            }
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in _aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            _aButton = [];
            if (_isoMain)
            {
                _isoMain.release();
            }
            _isoMain = null;
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.control(0);
            return;
        }// end function

    }
}
