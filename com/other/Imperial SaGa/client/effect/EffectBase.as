package effect
{
    import flash.display.*;
    import flash.geom.*;

    public class EffectBase extends Object
    {
        protected var _mcEffect:MovieClip;

        public function EffectBase(param1:DisplayObjectContainer, param2:MovieClip, param3:Point = null)
        {
            this._mcEffect = param2;
            if (this._mcEffect)
            {
                param1.addChild(this._mcEffect);
                if (param3 != null)
                {
                    this._mcEffect.x = param3.x;
                    this._mcEffect.y = param3.y;
                }
            }
            return;
        }// end function

        public function release() : void
        {
            if (this._mcEffect)
            {
                if (this._mcEffect.parent)
                {
                    this._mcEffect.parent.removeChild(this._mcEffect);
                }
                this._mcEffect = null;
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            return;
        }// end function

        public function isEnd() : Boolean
        {
            return false;
        }// end function

        public function setColorTransform(param1:ColorTransform) : void
        {
            return;
        }// end function

        public function get mcEffect() : MovieClip
        {
            return this._mcEffect;
        }// end function

    }
}
