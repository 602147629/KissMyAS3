package quest
{
    import flash.display.*;
    import utility.*;

    public class QuestJunctionGauge extends Object
    {
        private var _bAutoGaugeUpdae:Boolean;
        private var _baseMc:MovieClip;
        private var _isoMc:InStayOut;
        private var _nowPoint:int;
        private var _gauge:Gauge;

        public function QuestJunctionGauge(param1:MovieClip)
        {
            this._baseMc = param1;
            this._gauge = new Gauge(this._baseMc.timeGaugeMc.timeGaugeAnimeMc, 100, 0);
            this._isoMc = new InStayOut(this._baseMc);
            this._nowPoint = 0;
            this._bAutoGaugeUpdae = true;
            this.setGauge(true);
            return;
        }// end function

        public function release() : void
        {
            if (this._gauge)
            {
                this._gauge.release();
            }
            this._gauge = null;
            if (this._isoMc)
            {
                this._isoMc.release();
            }
            this._isoMc = null;
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = 0;
            if (this._bAutoGaugeUpdae)
            {
                _loc_2 = QuestManager.getInstance().junctionCount;
                if (this._nowPoint != _loc_2)
                {
                    this.setGauge(false);
                    this._nowPoint = _loc_2;
                }
            }
            return;
        }// end function

        public function setIn() : void
        {
            if (this._isoMc)
            {
                this._isoMc.setIn();
            }
            return;
        }// end function

        public function setOut() : void
        {
            if (this._isoMc)
            {
                this._isoMc.setOut();
            }
            return;
        }// end function

        public function get bGaugeMove() : Boolean
        {
            return this._gauge.bGaugeMove;
        }// end function

        public function set bAutoGaugeUpdae(param1:Boolean) : void
        {
            this._bAutoGaugeUpdae = param1;
            return;
        }// end function

        private function setGauge(param1:Boolean) : void
        {
            var _loc_2:* = QuestManager.getInstance().getJunctionGaugePersent();
            if (param1)
            {
                this._gauge.setGauge(_loc_2);
            }
            else
            {
                this._gauge.setTargetGauge(_loc_2);
            }
            return;
        }// end function

        public function setGaugePercent(param1:int) : void
        {
            this._gauge.setGauge(param1);
            return;
        }// end function

    }
}
