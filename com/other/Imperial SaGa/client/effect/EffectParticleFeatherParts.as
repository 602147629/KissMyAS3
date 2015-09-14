package effect
{
    import flash.display.*;
    import flash.geom.*;

    public class EffectParticleFeatherParts extends EffectParticleFallParts
    {
        private static const _MAX_VEC:Number = 200;

        public function EffectParticleFeatherParts(param1:DisplayObjectContainer, param2:BitmapData, param3:Point, param4:Number, param5:Number, param6:Number)
        {
            super(param1, param2, param3, param4, param5, param6);
            _friction = 0.95;
            return;
        }// end function

        public function addVec(param1:Number, param2:Point) : void
        {
            _vec.x = _vec.x + param2.x;
            _vec.y = _vec.y + param2.y;
            if (_vec.length > _MAX_VEC)
            {
                _vec.normalize(1);
                _vec.x = _vec.x * _MAX_VEC;
                _vec.y = _vec.y * _MAX_VEC;
            }
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

    }
}
