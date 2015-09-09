package com.bit101.components
{
    import flash.display.*;

    public class PagePushButton extends Component
    {
        protected var _back:Table;
        protected var _selected:Boolean = false;
        protected var _label:Label;
        protected var _labelText:String = "";

        public function PagePushButton(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:String = "", param5:Function = null)
        {
            super(param1, param2, param3);
            if (param5 != null)
            {
                addEventListener(MouseEvent.CLICK, param5);
            }
            this.label = param4;
            return;
        }// end function

        override protected function addChildren() : void
        {
            this._back = new Table("table21");
            addChild(this._back);
            this._label = new Label();
            addChild(this._label);
            this._label.textColor = 5977896;
            buttonMode = true;
            return;
        }// end function

        override public function draw() : void
        {
            super.draw();
            var _loc_1:* = 2;
            if (this._selected)
            {
                this._back.setTable("table21");
            }
            else
            {
                this._back.setTable("table22");
            }
            this._back.resize(_width, _height);
            this._label.autoSize = true;
            this._label.text = this._labelText;
            this._label.move(this._back.width / 2 - this._label.width / 2, this._back.height / 2 - this._label.height / 2 - 1);
            return;
        }// end function

        public function set label(param1:String) : void
        {
            this._labelText = param1;
            this.draw();
            invalidate();
            return;
        }// end function

        public function get label() : String
        {
            return this._labelText;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
            this.draw();
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
        }// end function

        public function set textColor(param1:Number) : void
        {
            this._label.textColor = param1;
            return;
        }// end function

        public function get textColor() : Number
        {
            return this._label.textColor;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            this._label.enabled = param1;
            this.mouseEnabled = param1;
            if (param1)
            {
                highlight = highlight;
                this.mouseEnabled = true;
                this.mouseChildren = true;
            }
            else
            {
                highlight = false;
                this.mouseEnabled = false;
                this.mouseChildren = false;
            }
            return;
        }// end function

    }
}
