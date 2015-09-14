package effect
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;

    public class EffectParticleBossMistMain extends EffectParticleBossMainBase
    {
        private var _mistBitmapData:BitmapData;

        public function EffectParticleBossMistMain(param1:BitmapData, param2:DisplayObjectContainer, param3:Function, param4:Number, param5:String, param6:Point)
        {
            super(param1, param2, param3, param4);
            var _loc_7:* = ResourceManager.getInstance().createBitmap(param5);
            var _loc_8:* = new BitmapData(_loc_7.width * param6.x, _loc_7.height * param6.y, true, 0);
            var _loc_9:* = new Matrix();
            new Matrix().scale(param6.x, param6.y);
            _loc_8.draw(_loc_7, _loc_9);
            _bmp.y = _bmp.y + _loc_8.height * 0.5;
            this._mistBitmapData = _loc_8;
            _offset.x = -_bmp.x;
            _offset.y = -_bmp.y;
            return;
        }// end function

        public function get mistBitmapData() : BitmapData
        {
            return this._mistBitmapData;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            super.release();
            for each (_loc_1 in _aParticle)
            {
                
                _loc_1.release();
            }
            _aParticle = [];
            if (this._mistBitmapData != null)
            {
                this._mistBitmapData.dispose();
            }
            this._mistBitmapData = null;
            return;
        }// end function

        override protected function controlParticle(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = _aParticle.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = _aParticle[_loc_2];
                _loc_3.control(param1);
                _loc_3.draw();
                if (_loc_3.bEnd)
                {
                    _loc_3.release();
                    _aParticle.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        public function addEffect(param1:EffectParticleMistParts) : void
        {
            _aParticle.push(param1);
            return;
        }// end function

    }
}
