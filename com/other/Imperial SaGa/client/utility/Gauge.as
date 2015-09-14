package utility
{
    import flash.display.*;
    import flash.events.*;

    public class Gauge extends Object
    {
        private var _baseMc:MovieClip;
        private var _gaugeMax:int;
        private var _gaugeNow:int;
        private var _gaugeTarget:int;

        public function Gauge(param1:MovieClip, param2:int, param3:int)
        {
            this._baseMc = param1;
            this._gaugeMax = param2;
            this._gaugeNow = param3;
            this.setGauge(this._gaugeNow);
            return;
        }// end function

        public function release() : void
        {
            if (this._baseMc.hasEventListener(Event.ENTER_FRAME))
            {
                this._baseMc.removeEventListener(Event.ENTER_FRAME, this.cbEnterFrame);
            }
            if (this._baseMc)
            {
                if (this._baseMc.parent)
                {
                    this._baseMc.parent.removeChild(this._baseMc);
                }
            }
            this._baseMc = null;
            return;
        }// end function

        public function setGauge(param1:int) : void
        {
            this._gaugeNow = param1;
            this._gaugeTarget = param1;
            var _loc_2:* = this._gaugeMax == 0 ? (100) : (this._gaugeNow / this._gaugeMax * 100);
            this._baseMc.gotoAndStop(_loc_2);
            return;
        }// end function

        public function setTargetGauge(param1:int) : void
        {
            this._gaugeTarget = param1;
            this._baseMc.addEventListener(Event.ENTER_FRAME, this.cbEnterFrame);
            return;
        }// end function

        public function setMaxGauge(param1:int) : void
        {
            this._gaugeMax = param1;
            var _loc_2:* = this._gaugeMax == 0 ? (100) : (this._gaugeNow / this._gaugeMax * 100);
            this._baseMc.gotoAndStop(_loc_2);
            return;
        }// end function

        private function cbEnterFrame(event:Event) : void
        {
            if (this._gaugeNow > this._gaugeTarget)
            {
                this._gaugeNow = this._gaugeNow - Math.max(1, this._gaugeMax / 100);
                if (this._gaugeNow < this._gaugeTarget)
                {
                    this._gaugeNow = this._gaugeTarget;
                }
            }
            if (this._gaugeNow < this._gaugeTarget)
            {
                this._gaugeNow = this._gaugeNow + Math.max(1, this._gaugeMax / 100);
                if (this._gaugeNow > this._gaugeTarget)
                {
                    this._gaugeNow = this._gaugeTarget;
                }
            }
            if (this._gaugeNow == this._gaugeTarget)
            {
                this._baseMc.removeEventListener(Event.ENTER_FRAME, this.cbEnterFrame);
            }
            var _loc_2:* = this._gaugeMax == 0 ? (100) : (this._gaugeNow / this._gaugeMax * 100);
            this._baseMc.gotoAndStop(_loc_2);
            return;
        }// end function

        public function show() : void
        {
            this._baseMc.visible = true;
            return;
        }// end function

        public function hide() : void
        {
            this._baseMc.visible = false;
            return;
        }// end function

        public function isStop() : Boolean
        {
            return this._gaugeNow == this._gaugeTarget;
        }// end function

        public function get gaugeMax() : int
        {
            return this._gaugeMax;
        }// end function

        public function get gaugeNow() : int
        {
            return this._gaugeNow;
        }// end function

        public function get bGaugeMove() : Boolean
        {
            return this._baseMc.hasEventListener(Event.ENTER_FRAME);
        }// end function

    }
}
