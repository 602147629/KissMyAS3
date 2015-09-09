package lovefox.gui
{
    import flash.display.*;
    import flash.text.*;

    public class CustomTextInput extends Sprite
    {
        private var _txt:TextField;

        public function CustomTextInput()
        {
            this._txt = Config.getSimpleTextField();
            this._txt.selectable = true;
            this._txt.mouseEnabled = true;
            this._txt.background = true;
            this._txt.border = true;
            this._txt.type = TextFieldType.INPUT;
            if (Config._switchEnglish)
            {
                this._txt.restrict = "^一-龥";
            }
            addChild(this._txt);
            return;
        }// end function

        public function set selectable(param1)
        {
            this._txt.selectable = param1;
            return;
        }// end function

        public function get selectable()
        {
            return this._txt.selectable;
        }// end function

        public function set text(param1)
        {
            this._txt.text = param1;
            return;
        }// end function

        public function get text()
        {
            return this._txt.text;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._txt.width = param1;
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            this._txt.height = param1;
            return;
        }// end function

        public function set displayAsPassword(param1)
        {
            this._txt.displayAsPassword = param1;
            return;
        }// end function

        public function set maxChars(param1:int) : void
        {
            this._txt.maxChars = param1;
            return;
        }// end function

        public function get maxChars() : int
        {
            return this._txt.maxChars;
        }// end function

        public function restricts(param1:String) : void
        {
            this._txt.restrict = param1;
            return;
        }// end function

        public function set type(param1:Boolean) : void
        {
            if (param1)
            {
                this._txt.type = TextFieldType.INPUT;
                if (Config._switchEnglish)
                {
                    this._txt.restrict = "^一-龥";
                }
            }
            else
            {
                this._txt.type = TextFieldType.DYNAMIC;
                if (Config._switchEnglish)
                {
                    this._txt.restrict = "";
                }
            }
            return;
        }// end function

        public static function create(param1, param2, param3, param4, param5, param6)
        {
            var _loc_7:* = undefined;
            _loc_7 = new CustomTextInput;
            _loc_7.width = param1;
            _loc_7.height = param2;
            _loc_7.x = param3;
            _loc_7.y = param4;
            _loc_7.text = param5;
            param6.addChild(_loc_7);
            return _loc_7;
        }// end function

    }
}
