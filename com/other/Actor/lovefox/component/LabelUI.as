package lovefox.component
{
    import flash.display.*;
    import flash.text.*;

    public class LabelUI extends TextField
    {
        private var maxchar:int = 255;

        public function LabelUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:String = "")
        {
            if (Config._switchEnglish)
            {
                this.defaultTextFormat = new TextFormat("Tahoma", 12);
            }
            this.initpanel();
            if (param1 != null)
            {
                param1.addChild(this);
            }
            x = param2;
            y = param3;
            this.text = param4;
            return;
        }// end function

        private function initpanel() : void
        {
            this.height = 20;
            this.autoSize = TextFieldAutoSize.LEFT;
            this.textColor = 6710886;
            this.selectable = false;
            this.mouseEnabled = false;
            return;
        }// end function

        public function set truncateToFit(param1:uint) : void
        {
            this.maxchar = param1;
            return;
        }// end function

        override public function set text(param1:String) : void
        {
            var _loc_2:* = null;
            if (param1 != null)
            {
                if (param1.length <= this.maxchar)
                {
                    super.htmlText = param1;
                }
                else
                {
                    _loc_2 = param1.substr(0, this.maxchar) + "...";
                    super.htmlText = _loc_2;
                }
            }
            return;
        }// end function

    }
}
