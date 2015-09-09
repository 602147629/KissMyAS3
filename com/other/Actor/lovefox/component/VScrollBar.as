package lovefox.component
{
    import flash.display.*;
    import flash.events.*;

    public class VScrollBar extends Sprite
    {
        private var container:Sprite;
        private var scrollbtn:Sprite;
        private var barbg:Sprite;
        private var masksp:Sprite;
        private var _height:Number = 30;
        private var moveflag:Boolean = false;
        private var mousedowny:Number = 0;
        private var percent:int = 0;
        private var _lineScrollSize:int = 10;
        private var _data:Object;

        public function VScrollBar()
        {
            this._data = Config.findUI("general").scrollBar2;
            return;
        }// end function

        private function initpanel() : void
        {
            this.barbg = new Sprite();
            this.addChild(this.barbg);
            this.barbg.graphics.beginFill(16314584, 1);
            this.barbg.graphics.drawRect(0, 0, 10, 5);
            this.barbg.graphics.endFill();
            this.barbg.filters = [new DropShadowFilter(2, 45, 0, 1, 2, 2, 0.3, 1, true)];
            this.scrollbtn = new Sprite();
            this.scrollbtn.filters = [new DropShadowFilter(1, 45, 0, 1, 1, 1, 0.3, 1, false)];
            this.scrollbtn.buttonMode = true;
            this.addChild(this.scrollbtn);
            var _loc_1:* = new Sprite();
            _loc_1.name = "scrollshape";
            this.scrollbtn.addChild(_loc_1);
            _loc_1.graphics.beginFill(11239270, 1);
            _loc_1.graphics.drawRect(0, 0, 10, 5);
            _loc_1.graphics.endFill();
            this.scrollbtn.addEventListener(MouseEvent.MOUSE_DOWN, this.movebar);
            return;
        }// end function

        public function set scrollTarget(param1:Sprite) : void
        {
            this.container = param1;
            this.initpanel();
            return;
        }// end function

        public function get scrollTarget() : Sprite
        {
            return this.container;
        }// end function

        public function resize(param1:Number, param2:Boolean) : void
        {
            if (param1 != NaN)
            {
                this._height = param1;
                this.barbg.height = this._height;
                this.changelen(param2);
            }
            return;
        }// end function

        public function changelen(param1:Boolean) : void
        {
            if (this.container.height < this._height)
            {
                this.scrollbtn.getChildByName("scrollshape").height = this._height;
                this.visible = false;
            }
            else
            {
                if (param1)
                {
                    this.visible = true;
                }
                this.scrollbtn.getChildByName("scrollshape").height = this._height * this._height / this.container.height;
            }
            this.changey(this.percent);
            return;
        }// end function

        public function changey(param1:int) : void
        {
            this.percent = param1;
            this.scrollbtn.y = (this._height - this.scrollbtn.height) * (this.percent / 100);
            return;
        }// end function

        private function movebar(event:MouseEvent) : void
        {
            this.mousedowny = this.scrollbtn.mouseY;
            this.moveflag = true;
            Config.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.stagemousemove);
            Config.stage.addEventListener(MouseEvent.MOUSE_UP, this.stagemouseup);
            return;
        }// end function

        private function stagemousemove(event:MouseEvent) : void
        {
            if (this.mouseY - this.mousedowny < 0)
            {
                this.scrollbtn.y = 0;
            }
            else if (this.mouseY + (this.scrollbtn.height - this.mousedowny) > this._height)
            {
                this.scrollbtn.y = this._height - this.scrollbtn.height;
            }
            else
            {
                this.scrollbtn.y = this.mouseY - this.mousedowny;
            }
            this.percent = int(100 * this.scrollbtn.y / (this._height - this.scrollbtn.height));
            var _loc_2:* = new ScrollBarEvent(ScrollBarEvent.VSCROLL_UPPERCENT);
            _loc_2.percent = this.percent;
            this.dispatchEvent(_loc_2);
            event.updateAfterEvent();
            return;
        }// end function

        private function stagemouseup(event:MouseEvent) : void
        {
            if (this.moveflag)
            {
                Config.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.stagemousemove);
                Config.stage.removeEventListener(MouseEvent.MOUSE_UP, this.stagemouseup);
                this.moveflag = false;
            }
            return;
        }// end function

        private function upscroll(event:MouseEvent) : void
        {
            this.addEventListener(Event.ENTER_FRAME, this.upadd);
            return;
        }// end function

        private function ups(param1) : void
        {
            this.removeEventListener(Event.ENTER_FRAME, this.upadd);
            return;
        }// end function

        private function upadd(param1) : void
        {
            if (this.percent - this._lineScrollSize >= 0)
            {
                this.percent = this.percent - this._lineScrollSize;
            }
            else
            {
                this.percent = 0;
            }
            this.changey(this.percent);
            var _loc_2:* = new ScrollBarEvent(ScrollBarEvent.VSCROLL_UPPERCENT);
            _loc_2.percent = this.percent;
            this.dispatchEvent(_loc_2);
            return;
        }// end function

        private function downs(param1) : void
        {
            this.removeEventListener(Event.ENTER_FRAME, this.downadd);
            return;
        }// end function

        private function downscroll(event:MouseEvent) : void
        {
            this.addEventListener(Event.ENTER_FRAME, this.downadd);
            return;
        }// end function

        private function downadd(param1) : void
        {
            if (this.percent + this._lineScrollSize <= 100)
            {
                this.percent = this.percent + this._lineScrollSize;
            }
            else
            {
                this.percent = 100;
            }
            this.changey(this.percent);
            var _loc_2:* = new ScrollBarEvent(ScrollBarEvent.VSCROLL_UPPERCENT);
            _loc_2.percent = this.percent;
            this.dispatchEvent(_loc_2);
            return;
        }// end function

        public function changeyNoPercent(param1:Number) : Number
        {
            var _loc_2:* = Math.min(this._height - this.scrollbtn.height, Math.max(0, this.scrollbtn.y + param1));
            this.percent = _loc_2 / (this._height - this.scrollbtn.height) * 100;
            this.scrollbtn.y = _loc_2;
            return this.percent;
        }// end function

    }
}
