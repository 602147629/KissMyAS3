package lovefox.component
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class TextAreaUI extends Sprite
    {
        public var mytext:TextField;
        private var scrollbar:TextScrollBar;
        private var _autoHeight:Boolean = false;
        private var _textColor:int = 6710886;
        private var _maxChars:int;

        public function TextAreaUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:Number = 200, param5:Number = 100)
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
            this.mytext = Config.getSimpleTextField();
            this.mytext.mouseEnabled = true;
            this.addChild(this.mytext);
            this.mytext.height = 20;
            this.mytext.x = 5;
            this.mytext.y = 5;
            this.mytext.multiline = true;
            this.mytext.wordWrap = true;
            this.mytext.textColor = this._textColor;
            this.mytext.addEventListener(TextEvent.LINK, this.uplink);
            this.scrollbar = new TextScrollBar(this.mytext);
            this.scrollbar.x = this.width - 10;
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this.mytext.width = param1 - 10;
            this.scrollbar.x = this.mytext.width;
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            this.mytext.height = param1;
            this.scrollbar.height = param1;
            this.scrollbar.y = 5;
            return;
        }// end function

        public function set text(param1:String) : void
        {
            this.mytext.htmlText = param1;
            if (this._autoHeight)
            {
                this.height = this.mytext.textHeight + 10;
            }
            return;
        }// end function

        public function get text() : String
        {
            return this.mytext.text;
        }// end function

        private function uplink(event:TextEvent) : void
        {
            var _loc_2:* = new ScrollBarEvent(ScrollBarEvent.TEXTAREAuiEVENT);
            _loc_2.text = event.text;
            this.dispatchEvent(_loc_2);
            return;
        }// end function

        public function set edit(param1:Boolean) : void
        {
            if (param1)
            {
                this.mytext.selectable = true;
                this.mytext.type = TextFieldType.INPUT;
                this.mytext.background = true;
                if (Config._switchEnglish)
                {
                    this.mytext.restrict = "^一-龥";
                }
            }
            else
            {
                this.textColor = 6710886;
                this.mytext.background = false;
                this.mytext.type = TextFieldType.DYNAMIC;
                if (Config._switchEnglish)
                {
                    this.mytext.restrict = "";
                }
            }
            return;
        }// end function

        public function get edit() : Boolean
        {
            if (this.mytext.type == TextFieldType.INPUT)
            {
                return true;
            }
            return false;
        }// end function

        public function set autoHeight(param1:Boolean) : void
        {
            this._autoHeight = true;
            return;
        }// end function

        public function get textColor() : int
        {
            return this._textColor;
        }// end function

        public function set textColor(param1:int) : void
        {
            this._textColor = param1;
            this.mytext.textColor = this._textColor;
            return;
        }// end function

        public function get maxChars() : int
        {
            return this._maxChars;
        }// end function

        public function set maxChars(param1:int) : void
        {
            this._maxChars = param1;
            this.mytext.maxChars = param1;
            return;
        }// end function

        public function set restrict(param1:String) : void
        {
            this.mytext.restrict = param1;
            return;
        }// end function

        public function get restrict() : String
        {
            return this.mytext.restrict;
        }// end function

    }
}
