package effect
{
    import utility.*;

    public class EffectBatibatiMain extends Object
    {
        private var _waitTime:Number;
        private var _aBatibati:Array;
        private var _cbCreateFunc:Function;
        private var _waitTimeBase:Number;

        public function EffectBatibatiMain(param1:Function)
        {
            this._aBatibati = [];
            this._waitTime = 1;
            this._waitTimeBase = 0.5;
            this._cbCreateFunc = param1;
            return;
        }// end function

        public function setWaitTimeBase(param1:Number) : void
        {
            this._waitTimeBase = param1;
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aBatibati)
            {
                
                _loc_1.release();
            }
            this._aBatibati = [];
            this._cbCreateFunc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_3:* = null;
            this._waitTime = this._waitTime - param1;
            if (this._waitTime <= 0)
            {
                this._waitTime = this._waitTimeBase + Number(Random.range(0, 5)) * 0.1;
                this._cbCreateFunc();
            }
            var _loc_2:* = this._aBatibati.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aBatibati[_loc_2];
                _loc_3.control(param1);
                if (_loc_3.bEnd)
                {
                    _loc_3.release();
                    this._aBatibati.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        public function addEffect(param1:EffectBatibati) : void
        {
            this._aBatibati.push(param1);
            return;
        }// end function

    }
}
