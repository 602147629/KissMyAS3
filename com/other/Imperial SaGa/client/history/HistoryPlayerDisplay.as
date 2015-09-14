package history
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import player.*;
    import sound.*;
    import utility.*;

    public class HistoryPlayerDisplay extends PlayerDisplay
    {
        private var _personal:PlayerPersonal;
        private var _cbClick:Function;
        private var _timer:Timer;
        private var _timerActionAfterWait:int;
        private var _bAnimation:Boolean;
        private static const RANDOM_WAIT_MIN:int = 8000;
        private static const RANDOM_WAIT_MAX:int = 15000;
        private static const WIN_WAIT_TIME:int = 3000;

        public function HistoryPlayerDisplay(param1:PlayerPersonal)
        {
            super(null, param1.playerId, 0);
            this._personal = param1;
            this._timerActionAfterWait = 0;
            this._cbClick = null;
            this._bAnimation = true;
            this.setTimer();
            return;
        }// end function

        override public function release() : void
        {
            this._bAnimation = false;
            if (_mc.hasEventListener(MouseEvent.CLICK))
            {
                this.removePlayerClick();
            }
            if (this._timer)
            {
                this._timer.stop();
                this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.cbTimer);
            }
            this._timer = null;
            super.release();
            return;
        }// end function

        override public function setParent(param1:DisplayObjectContainer) : void
        {
            if (_layer.parent != null)
            {
                _layer.parent.removeChild(_layer);
            }
            super.setParent(param1);
            return;
        }// end function

        public function setPlayerClick(param1:Function) : void
        {
            this._cbClick = param1;
            _mc.addEventListener(MouseEvent.CLICK, this._cbClick);
            _mc.addEventListener(MouseEvent.MOUSE_OVER, this.cbMouseOver);
            return;
        }// end function

        public function removePlayerClick() : void
        {
            _mc.removeEventListener(MouseEvent.CLICK, this._cbClick);
            if (_mc.hasEventListener(MouseEvent.MOUSE_OVER))
            {
                _mc.removeEventListener(MouseEvent.MOUSE_OVER, this.cbMouseOver);
            }
            this._cbClick = null;
            return;
        }// end function

        public function get personal() : PlayerPersonal
        {
            return this._personal;
        }// end function

        private function setTimer() : void
        {
            if (this._bAnimation == false)
            {
                return;
            }
            setAnimStay();
            if (this._timer == null || this._timer != null && this._timer.running == false)
            {
                this._timer = new Timer(Random.range(RANDOM_WAIT_MIN, RANDOM_WAIT_MAX), 1);
                this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.cbTimer);
                this._timer.start();
            }
            return;
        }// end function

        private function cbTimer(event:TimerEvent) : void
        {
            var _loc_2:* = [{label:PlayerDisplay.LABEL_WIN, wait:WIN_WAIT_TIME}];
            var _loc_3:* = Random.range(0, (_loc_2.length - 1));
            var _loc_4:* = _loc_2[_loc_3].label;
            this._timerActionAfterWait = _loc_2[_loc_3].wait;
            setAnimationWithCallback(_loc_4, this.cbAnimCompleted);
            return;
        }// end function

        private function cbAnimCompleted() : void
        {
            this._timer = new Timer(this._timerActionAfterWait, 1);
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, function (event:TimerEvent) : void
            {
                if (_bAnimation)
                {
                    setTimer();
                }
                return;
            }// end function
            );
            this._timer.start();
            return;
        }// end function

        private function cbMouseOver(event:MouseEvent) : void
        {
            SoundManager.getInstance().playSe(SoundId.SE_BED);
            return;
        }// end function

    }
}
