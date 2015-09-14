package effect
{
    import flash.geom.*;

    public class EffectManager extends Object
    {
        private var _aEffect:Array;

        public function EffectManager()
        {
            this._aEffect = [];
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aEffect)
            {
                
                _loc_1.release();
            }
            this._aEffect = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aEffect.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aEffect[_loc_2];
                _loc_3.control(param1);
                if (_loc_3.isEnd())
                {
                    _loc_3.release();
                    _loc_3 = null;
                    this._aEffect.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        public function addEffect(param1:EffectBase) : void
        {
            this._aEffect.push(param1);
            return;
        }// end function

        public function releaseEffect(param1:EffectBase) : void
        {
            var _loc_2:* = this._aEffect.indexOf(param1);
            if (_loc_2 >= 0)
            {
                this._aEffect.splice(_loc_2, 1);
                param1.release();
            }
            return;
        }// end function

        public function isExist(param1:EffectBase) : Boolean
        {
            var _loc_2:* = this._aEffect.indexOf(param1);
            return _loc_2 >= 0;
        }// end function

        public function setColorTransform(param1:ColorTransform) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aEffect)
            {
                
                _loc_2.setColorTransform(param1);
            }
            return;
        }// end function

        public function getEffectNum() : uint
        {
            return this._aEffect.length;
        }// end function

    }
}
