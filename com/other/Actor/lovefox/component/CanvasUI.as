package lovefox.component
{
    import flash.display.*;
    import flash.events.*;

    public class CanvasUI extends Sprite
    {
        private var _width:Number = 200;
        private var _height:Number = 100;
        private var _ellipse:Number = 0;
        private var masksp:Sprite;
        private var bgmc:Sprite;
        private var _canvas:Sprite;
        private var _verticalScrollPolicy:Boolean = true;
        private var _vscrollbar:VScrollBar;
        private var percent:Number = 0;

        public function CanvasUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:Number = 200, param5:Number = 100)
        {
            this.initpanel();
            if (param1 != null)
            {
                param1.addChild(this);
            }
            this.width = param4;
            this.height = param5;
            x = param2;
            y = param3;
            return;
        }// end function

        private function initpanel() : void
        {
            this._canvas = new Sprite();
            this.addChild(this._canvas);
            this._vscrollbar = new VScrollBar();
            this._vscrollbar.scrollTarget = this._canvas;
            this.addChild(this._vscrollbar);
            this._vscrollbar.resize(this._height, this._verticalScrollPolicy);
            this._vscrollbar.x = this._width - 10;
            this._vscrollbar.addEventListener(ScrollBarEvent.VSCROLL_UPPERCENT, this.checkpercent);
            this.addEventListener(MouseEvent.MOUSE_WHEEL, this.whellpanel);
            return;
        }// end function

        public function set verticalScrollPolicy(param1:Boolean) : void
        {
            this._verticalScrollPolicy = param1;
            if (!this._verticalScrollPolicy)
            {
                this._vscrollbar.visible = false;
                this.removeEventListener(MouseEvent.MOUSE_WHEEL, this.whellpanel);
            }
            else
            {
                this.reFresh();
            }
            return;
        }// end function

        public function get verticalScrollPolicy() : Boolean
        {
            return this._verticalScrollPolicy;
        }// end function

        public function removeAllChildren() : void
        {
            while (this._canvas.numChildren > 0)
            {
                
                this._canvas.removeChildAt((this._canvas.numChildren - 1));
            }
            this.addremove();
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._width = param1;
            this._vscrollbar.x = this._width - 10;
            this.refreshhmask();
            return;
        }// end function

        override public function get width() : Number
        {
            return this._width;
        }// end function

        override public function set height(param1:Number) : void
        {
            this._height = param1;
            this._vscrollbar.resize(param1, this._verticalScrollPolicy);
            this.refreshhmask();
            return;
        }// end function

        override public function get height() : Number
        {
            return this._height;
        }// end function

        public function set verticalScrollPosition(param1:int) : void
        {
            if (param1 > 100)
            {
                param1 = 100;
            }
            if (param1 < 0)
            {
                param1 = 0;
            }
            this.percent = param1;
            this.refreshpanel();
            this.refreshvbar();
            this._vscrollbar.changey(this.percent);
            return;
        }// end function

        public function get verticalScrollPosition() : int
        {
            return this.percent;
        }// end function

        public function backPosition(param1:int) : int
        {
            var _loc_2:* = 0;
            if (this._canvas.height > this._height)
            {
                _loc_2 = int(param1 / (this._canvas.height - this._height) * 100);
            }
            else
            {
                _loc_2 = 0;
            }
            return _loc_2;
        }// end function

        private function refreshhmask() : void
        {
            if (this.masksp != null)
            {
                if (this.masksp.parent != null)
                {
                    this.removeChild(this.masksp);
                }
            }
            this.masksp = new Sprite();
            this.masksp.graphics.beginFill(9477027, 0);
            this.masksp.graphics.drawRoundRect(0, 0, this._width, this._height, this._ellipse);
            this.masksp.graphics.endFill();
            this.addChild(this.masksp);
            if (this.bgmc != null)
            {
                if (this.bgmc.parent != null)
                {
                    this.removeChild(this.bgmc);
                }
            }
            this.bgmc = new Sprite();
            this.bgmc.graphics.beginFill(9477027, 0);
            this.bgmc.graphics.drawRoundRect(0, 0, this._width, this._height, this._ellipse);
            this.bgmc.graphics.endFill();
            this.addChild(this.bgmc);
            this.setChildIndex(this.bgmc, 0);
            this.bgmc.alpha = 0;
            return;
        }// end function

        private function refreshvbar() : void
        {
            if (this._canvas.height >= this._height)
            {
                this.percent = (-this._canvas.y) / (this._canvas.height - this._height) * 100;
            }
            this._vscrollbar.changelen(this._verticalScrollPolicy);
            return;
        }// end function

        private function refreshpanel() : void
        {
            if (this._canvas.height >= this._height)
            {
                this._canvas.y = (-(this._canvas.height - this._height)) * this.percent / 100;
            }
            else
            {
                this._canvas.y = 0;
                this.percent = 0;
                this._vscrollbar.changey(this.percent);
            }
            this._canvas.mask = this.masksp;
            return;
        }// end function

        public function addChildUI(param1:DisplayObject) : void
        {
            param1.addEventListener(Event.ADDED, this.addremove);
            this._canvas.addChild(param1);
            return;
        }// end function

        public function removeChildUI(param1:DisplayObject) : void
        {
            param1.addEventListener(Event.REMOVED, this.addremove);
            this._canvas.removeChild(param1);
            return;
        }// end function

        public function addremove(event:Event = null) : void
        {
            this.refreshvbar();
            this.refreshpanel();
            return;
        }// end function

        public function reFresh() : void
        {
            this.refreshpanel();
            this.refreshvbar();
            return;
        }// end function

        private function checkpercent(event:ScrollBarEvent) : void
        {
            this.percent = event.percent;
            this.refreshpanel();
            return;
        }// end function

        private function whellpanel(event:MouseEvent) : void
        {
            this.percent = this._vscrollbar.changeyNoPercent(event.delta > 0 ? (-10) : (10 * 2));
            this.refreshpanel();
            return;
        }// end function

    }
}
