package employment
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import utility.*;

    public class EmploymentFightGroup10 extends Object
    {
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _aCandidatePlayerId:Array;
        private var _animBox:WinLoseAnimBox;
        private var _aFighter:Array;
        private var _cbOpen:Function;
        private var _cbClose:Function;
        private var _bIn:Boolean;
        private var _bFinish:Boolean;
        private var _bOut:Boolean;
        private var _bEnd:Boolean;
        public var delay:Number;
        private static const _PHASE_STOP:int = 0;
        private static const _PHASE_READY:int = 1;
        private static const _PHASE_FIGHTING:int = 2;
        private static const _PHASE_OVER:int = 3;
        private static const _PHASE_CLOSE:int = 4;

        public function EmploymentFightGroup10(param1:MovieClip, param2:int, param3:int, param4:Function)
        {
            this.delay = Random.range(500, 1000);
            this._cbOpen = param4;
            this._cbClose = null;
            this._mcBase = param1;
            this._aCandidatePlayerId = [param2, param3];
            this._aFighter = null;
            this._bIn = false;
            this._bFinish = false;
            this._bEnd = false;
            this._bOut = false;
            this._animBox = new WinLoseAnimBox(this._mcBase["Cha01"]);
            this._aFighter = [new EmploymentFighter(this._mcBase["Cha01"]), new EmploymentFighter(this._mcBase["Cha02"])];
            this.setPhase(_PHASE_STOP);
            return;
        }// end function

        public function get bIn() : Boolean
        {
            return this._bIn;
        }// end function

        public function get bFinish() : Boolean
        {
            return this._bFinish;
        }// end function

        public function get bOut() : Boolean
        {
            return this._bOut;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aFighter)
            {
                
                _loc_1.release();
            }
            this._aFighter = null;
            this._animBox.release();
            this._animBox = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_STOP:
                {
                    this.initPhaseStop();
                    break;
                }
                case _PHASE_READY:
                {
                    this.initPhaseReady();
                    break;
                }
                case _PHASE_FIGHTING:
                {
                    this.initPhaseFighting();
                    break;
                }
                case _PHASE_OVER:
                {
                    this.initPhaseOver();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.initPhaseClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case _PHASE_READY:
                {
                    this.controlPhaseReady(param1);
                    break;
                }
                case _PHASE_FIGHTING:
                {
                    this.controlPhaseFighting(param1);
                    break;
                }
                case _PHASE_OVER:
                {
                    this.controlPhaseOver(param1);
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.controlPhaseClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function initPhaseStop() : void
        {
            return;
        }// end function

        private function initPhaseReady() : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_1:* = new Array(this._aFighter.length);
            var _loc_2:* = Random.range(0, (this._aFighter.length - 1));
            var _loc_3:* = this._animBox.lot(this._aFighter.length, _loc_2);
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < this._aCandidatePlayerId.length && _loc_5 < _loc_3.length)
            {
                
                if (_loc_5 == _loc_2)
                {
                    _loc_1[_loc_5] = this._aCandidatePlayerId[0];
                }
                else
                {
                    _loc_1[_loc_5] = this._aCandidatePlayerId[(_loc_4 + 1)];
                    _loc_4++;
                }
                _loc_5++;
            }
            _loc_4 = 0;
            for each (_loc_6 in this._aFighter)
            {
                
                if (_loc_6 == this._aFighter[0])
                {
                    _loc_7 = 0;
                }
                if (_loc_6 == this._aFighter[1])
                {
                    _loc_7 = 1;
                }
                _loc_6.setAnimationNo(_loc_3[_loc_4], _loc_1[_loc_4], _loc_7);
                _loc_6.setIn();
                _loc_4++;
            }
            return;
        }// end function

        private function controlPhaseReady(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = true;
            for each (_loc_3 in this._aFighter)
            {
                
                _loc_3.control(param1);
                if (_loc_3.isStay() == false)
                {
                    _loc_2 = false;
                }
            }
            if (_loc_2)
            {
                this._bIn = true;
            }
            return;
        }// end function

        private function initPhaseFighting() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aFighter)
            {
                
                _loc_1.setFight();
            }
            return;
        }// end function

        private function controlPhaseFighting(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = true;
            for each (_loc_3 in this._aFighter)
            {
                
                _loc_3.control(param1);
                if (_loc_3.isFinish() == false)
                {
                    _loc_2 = false;
                }
            }
            if (_loc_2)
            {
                this._bFinish = true;
            }
            return;
        }// end function

        private function initPhaseOver() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aFighter)
            {
                
                _loc_1.setOut();
            }
            return;
        }// end function

        private function controlPhaseOver(param1:Number) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aFighter)
            {
                
                _loc_2.control(param1);
            }
            return;
        }// end function

        private function initPhaseClose() : void
        {
            return;
        }// end function

        private function controlPhaseClose() : void
        {
            return;
        }// end function

        public function playAnimation() : void
        {
            var PlayTimer:* = new Timer(this.delay, 1);
            PlayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                setPhase(_PHASE_READY);
                return;
            }// end function
            );
            PlayTimer.start();
            return;
        }// end function

        public function playFighting() : void
        {
            var PlayTimer:* = new Timer(this.delay, 1);
            PlayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                setPhase(_PHASE_FIGHTING);
                return;
            }// end function
            );
            PlayTimer.start();
            return;
        }// end function

        public function playOver() : void
        {
            var PlayTimer:* = new Timer(this.delay, 1);
            PlayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                setPhase(_PHASE_OVER);
                return;
            }// end function
            );
            PlayTimer.start();
            return;
        }// end function

        public function close(param1:Function) : void
        {
            this._cbClose = param1;
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

    }
}
