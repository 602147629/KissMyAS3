package effect
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;

    public class EffectMc extends EffectBase
    {

        public function EffectMc(param1:DisplayObjectContainer, param2:String, param3:String, param4:Point, param5:Boolean = false)
        {
            var _loc_6:* = param5 == false ? (1) : (-1);
            var _loc_7:* = ResourceManager.getInstance().createMovieClip(param2, param3);
            ResourceManager.getInstance().createMovieClip(param2, param3).scaleX = _loc_6;
            super(param1, _loc_7, param4);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override public function isEnd() : Boolean
        {
            if (!_mcEffect)
            {
                return true;
            }
            var _loc_1:* = _mcEffect.currentLabel;
            return _loc_1 == "end";
        }// end function

        override public function setColorTransform(param1:ColorTransform) : void
        {
            if (_mcEffect)
            {
                _mcEffect.transform.colorTransform = param1;
            }
            return;
        }// end function

    }
}
