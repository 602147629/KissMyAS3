package lovefox.component
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class MailTextAreaUI extends Sprite
    {
        public var mytext:TextField;
        private var _canvas:CanvasUI;
        private var _autoHeight:Boolean = false;
        private var _textColor:int = 6710886;
        private var _maxChars:int;

        public function MailTextAreaUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:Number = 200, param5:Number = 100)
        {
            if (param1 != null)
            {
                param1.addChild(this);
            }
            this._canvas = new CanvasUI(this, 2, 2, param4, param5 - 4);
            x = param2;
            y = param3;
            this.initpanel();
            this.width = param4;
            return;
        }// end function

        private function initpanel() : void
        {
            this.mytext = Config.getSimpleTextField();
            if (Config._switchEnglish)
            {
                this.mytext.restrict = "^一-龥";
            }
            this.addChild(this.mytext);
            this.mytext.height = 20;
            this.mytext.multiline = true;
            this.mytext.wordWrap = true;
            this.mytext.textColor = this._textColor;
            this.mytext.addEventListener(TextEvent.LINK, this.uplink);
            this._canvas.addChildUI(this.mytext);
            return;
        }// end function

        public function set text(param1:String) : void
        {
            this.mytext.htmlText = param1;
            if (this._autoHeight)
            {
                this.height = this.mytext.textHeight + 10;
            }
            this._canvas.reFresh();
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this.mytext.width = param1 - 10;
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            this.mytext.height = param1;
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
            }
            else
            {
                this.textColor = 6710886;
                this.mytext.background = false;
                this.mytext.type = TextFieldType.DYNAMIC;
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
