package utility
{
    import flash.display.*;

    public class Fade extends Object
    {
        private const _FADE_NON:int = 0;
        private const _FADE_OUT:int = 1;
        private const _FADE_IN:int = 2;
        private var _sprFade:Sprite;
        private var _fadeState:int = 0;
        private var _fadeSpeed:Number;
        private var _minAlpha:Number;
        private var _maxAlpha:Number;
        private var _cbFadeComplete:Function;

        public function Fade(param1:DisplayObjectContainer, param2:Number = 1)
        {
            this._sprFade = new Sprite();
            param1.addChild(this._sprFade);
            this.setColor(0);
            this._fadeSpeed = 1;
            this._minAlpha = 0;
            this._maxAlpha = param2;
            return;
        }// end function

        public function get minAlpha() : Number
        {
            return this._minAlpha;
        }// end function

        public function get maxAlpha() : Number
        {
            return this._maxAlpha;
        }// end function

        public function set maxAlpha(param1:Number) : void
        {
            this._maxAlpha = param1;
            this._sprFade.alpha = this._maxAlpha;
            return;
        }// end function

        public function isFade() : Boolean
        {
            return this._sprFade.visible;
        }// end function

        public function isFadeEnd() : Boolean
        {
            return this._fadeState == this._FADE_NON;
        }// end function

        public function setColor(param1:uint) : void
        {
            var _loc_2:* = this._sprFade.graphics;
            _loc_2.clear();
            _loc_2.beginFill(param1);
            _loc_2.drawRect(0, 0, Constant.SCREEN_WIDTH, Constant.SCREEN_HEIGHT);
            _loc_2.endFill();
            return;
        }// end function

        public function setAlphaRange(param1:Number, param2:Number) : void
        {
            this._minAlpha = param1;
            this._maxAlpha = param2;
            return;
        }// end function

        public function release() : void
        {
            if (this._sprFade.parent)
            {
                this._sprFade.parent.removeChild(this._sprFade);
            }
            this._sprFade = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._fadeState)
            {
                case this._FADE_NON:
                {
                    break;
                }
                case this._FADE_OUT:
                {
                    this.controlFadeOut(param1);
                    break;
                }
                case this._FADE_IN:
                {
                    this.controlFadeIn(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function controlFadeOut(param1:Number) : void
        {
            var _loc_2:* = this._sprFade.alpha;
            _loc_2 = _loc_2 + this._fadeSpeed * param1;
            if (_loc_2 >= this._maxAlpha)
            {
                _loc_2 = this._maxAlpha;
                this._fadeState = this._FADE_NON;
            }
            this._sprFade.alpha = _loc_2;
            if (this._cbFadeComplete != null && this._fadeState == this._FADE_NON)
            {
                this._cbFadeComplete();
                this._cbFadeComplete = null;
            }
            return;
        }// end function

        private function controlFadeIn(param1:Number) : void
        {
            var _loc_2:* = this._sprFade.alpha;
            _loc_2 = _loc_2 - this._fadeSpeed * param1;
            if (_loc_2 <= this._minAlpha)
            {
                _loc_2 = this._minAlpha;
                this._fadeState = this._FADE_NON;
                this._sprFade.visible = false;
            }
            this._sprFade.alpha = _loc_2;
            if (this._cbFadeComplete != null && this._fadeState == this._FADE_NON)
            {
                this._cbFadeComplete();
                this._cbFadeComplete = null;
            }
            return;
        }// end function

        public function setFadeOut(param1:Number, param2:Function = null) : void
        {
            this._sprFade.visible = true;
            this._fadeState = this._FADE_OUT;
            this._sprFade.alpha = this._minAlpha;
            if (param1 == 0)
            {
                this._sprFade.alpha = this._maxAlpha;
                return;
            }
            this._fadeSpeed = 1 / param1;
            this._cbFadeComplete = param2;
            return;
        }// end function

        public function setFadeIn(param1:Number, param2:Function = null) : void
        {
            this._sprFade.visible = true;
            this._fadeState = this._FADE_IN;
            this._sprFade.alpha = this._maxAlpha;
            if (param1 == 0)
            {
                this._sprFade.alpha = this._minAlpha;
                return;
            }
            this._fadeSpeed = 1 / param1;
            this._cbFadeComplete = param2;
            return;
        }// end function

    }
}
