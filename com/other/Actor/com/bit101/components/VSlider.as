package com.bit101.components
{
    import flash.display.*;
    import flash.events.*;

    public class VSlider extends Slider
    {
        private var _scrollTarget:Object;

        public function VSlider(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:Function = null)
        {
            super(Slider.VERTICAL, param1, param2, param3, param4);
            return;
        }// end function

        public function set scrollTarget(param1)
        {
            this._scrollTarget = param1;
            this._scrollTarget.addEventListener(Event.CHANGE, this.handleTargetChange);
            this._scrollTarget.addEventListener(Event.SCROLL, this.handleTargetChange);
            if (this._scrollTarget.maxScrollV != 1)
            {
                _handle.visible = true;
            }
            else
            {
                _handle.visible = false;
            }
            return;
        }// end function

        public function handleTargetChange(param1 = null)
        {
            handleSize = Math.max(10, _height * (this._scrollTarget.numLines - this._scrollTarget.maxScrollV) / (this._scrollTarget.numLines - 1));
            maximum = this._scrollTarget.maxScrollV;
            value = this._scrollTarget.maxScrollV - this._scrollTarget.scrollV;
            if (this._scrollTarget.maxScrollV != 1)
            {
                _handle.visible = true;
            }
            else
            {
                _handle.visible = false;
            }
            return;
        }// end function

        override protected function onSlide(event:MouseEvent) : void
        {
            super.onSlide(event);
            if (this._scrollTarget != null)
            {
                this._scrollTarget.scrollV = Math.round((maximum - value) / maximum * this._scrollTarget.maxScrollV);
            }
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            super.height = param1;
            if (this._scrollTarget != null)
            {
                handleSize = Math.max(_width, _height * (this._scrollTarget.numLines - this._scrollTarget.maxScrollV) / (this._scrollTarget.numLines - 1));
                maximum = this._scrollTarget.maxScrollV;
                value = this._scrollTarget.maxScrollV - (this._scrollTarget.scrollV - 1);
                if (this._scrollTarget.maxScrollV != 1)
                {
                    _handle.visible = true;
                }
                else
                {
                    _handle.visible = false;
                }
            }
            return;
        }// end function

    }
}
