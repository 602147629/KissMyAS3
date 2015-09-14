package mainProcess
{
    import flash.display.*;
    import network.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class LoadingWatcher extends Object
    {
        private var _parent:DisplayObjectContainer;
        private var _phase:int;
        private var _checkCount:Number;
        private var _maxTask:int;
        private var _minTime:Number;
        private var _loading:LoadingScreen;
        private static const PHASE_CHECK:int = 0;
        private static const PHASE_NOW_LOADING:int = 1;
        private static const PHASE_CLOSE:int = 2;
        private static const CHECK_COUNT_MAX:Number = 3;

        public function LoadingWatcher(param1:DisplayObjectContainer)
        {
            this._parent = param1;
            this._phase = Constant.UNDECIDED;
            this._loading = null;
            this.setPhase(PHASE_CHECK);
            return;
        }// end function

        public function get bNowLoading() : Boolean
        {
            return this._phase != PHASE_CHECK;
        }// end function

        public function release() : void
        {
            if (this._loading)
            {
                this._loading.release();
            }
            this._loading = null;
            this._parent = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case PHASE_CHECK:
                {
                    this.controlCheck(param1);
                    break;
                }
                case PHASE_NOW_LOADING:
                {
                    this.controlNowLoading(param1);
                    break;
                }
                case PHASE_CLOSE:
                {
                    this.controlClose(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case PHASE_CHECK:
                    {
                        this.phaseCheck();
                        break;
                    }
                    case PHASE_NOW_LOADING:
                    {
                        this.phaseNowLoading();
                        break;
                    }
                    case PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function showNowLoading(param1:Number = 0.5) : void
        {
            this.setPhase(PHASE_NOW_LOADING);
            this._minTime = param1;
            return;
        }// end function

        public function hideNowLoading() : void
        {
            if (this._phase == PHASE_NOW_LOADING)
            {
                if (this._checkCount >= this._minTime)
                {
                    this.setPhase(PHASE_CLOSE);
                }
            }
            return;
        }// end function

        private function phaseCheck() : void
        {
            this._checkCount = 0;
            return;
        }// end function

        private function controlCheck(param1:Number) : void
        {
            if (this.checkLoading())
            {
                if (this._checkCount >= CHECK_COUNT_MAX)
                {
                    this.setPhase(PHASE_NOW_LOADING);
                }
                else
                {
                    this._checkCount = this._checkCount + param1;
                }
            }
            else
            {
                this._checkCount = 0;
            }
            return;
        }// end function

        private function phaseNowLoading() : void
        {
            this._checkCount = 0;
            this._maxTask = this.getTaskNum();
            this._minTime = 0.5;
            if (this._loading != null)
            {
                this._loading.release();
            }
            this._loading = new LoadingScreen(this._parent);
            return;
        }// end function

        private function controlNowLoading(param1:Number) : void
        {
            var _loc_2:* = this.getTaskNum();
            if (this._maxTask < _loc_2)
            {
                this._maxTask = _loc_2;
            }
            this._loading.setProgressGauge(this.getProgressRate(_loc_2));
            this._loading.control(param1);
            this._checkCount = this._checkCount + param1;
            if (this._checkCount >= this._minTime && _loc_2 <= 0)
            {
                this.setPhase(PHASE_CLOSE);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._checkCount = 0;
            this._loading.setProgressGauge(1);
            this._loading.close();
            return;
        }// end function

        private function controlClose(param1:Number) : void
        {
            this._loading.close();
            this._loading.control(param1);
            if (this._loading.bEnd)
            {
                this._loading.release();
                this._loading = null;
                this.setPhase(PHASE_CHECK);
            }
            return;
        }// end function

        private function checkLoading() : Boolean
        {
            return ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false || NetManager.getInstance().isConnected() == false;
        }// end function

        private function getTaskNum() : int
        {
            return ResourceManager.getInstance().getLoadTaskNum() + SoundManager.getInstance().getLoadTaskNum() + NetManager.getInstance().getTaskNum();
        }// end function

        private function getProgressRate(param1:int) : Number
        {
            var _loc_2:* = this._maxTask > 0 ? (Math.min((this._maxTask - param1) / this._maxTask, 1)) : (1);
            var _loc_3:* = this._minTime > 0 ? (Math.min(this._checkCount / this._minTime, 1)) : (1);
            return Math.min(_loc_2, _loc_3);
        }// end function

    }
}
