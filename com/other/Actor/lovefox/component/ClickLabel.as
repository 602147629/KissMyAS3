package lovefox.component
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;

    public class ClickLabel extends Label
    {
        private var _clickColor:Array;
        private var _lineflag:Boolean = false;

        public function ClickLabel(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:String = "", param5:Function = null, param6:Boolean = false, param7:int = 0, param8:Boolean = false)
        {
            this._clickColor = [];
            this._lineflag = param6;
            super(param1, param2, param3);
            if (param6)
            {
                if (param8)
                {
                    super.text = "<P ALIGN=\'LEFT\'><u><b><a href=\'event:0\'>" + param4 + "</a></b></u></P>";
                }
                else
                {
                    super.text = "<P ALIGN=\'LEFT\'><u><a href=\'event:0\'>" + param4 + "</a></u></P>";
                }
            }
            else if (param8)
            {
                super.text = "<P ALIGN=\'LEFT\'><b><a href=\'event:0\'>" + param4 + "</a></b></P>";
            }
            else
            {
                super.text = "<P ALIGN=\'LEFT\'><a href=\'event:0\'>" + param4 + "</a></P>";
            }
            this.html = true;
            if (param5 != null)
            {
                this.tf.addEventListener(TextEvent.LINK, param5);
            }
            if (param7 != 0)
            {
                this.autoSize = false;
                this.width = param7;
                this.tf.removeEventListener(TextEvent.LINK, param5);
                this.addEventListener(MouseEvent.CLICK, param5);
                this.useHandCursor = true;
                this.buttonMode = true;
            }
            this.mouseEnabled = true;
            this.addEventListener(MouseEvent.ROLL_OUT, this.rollout);
            this.addEventListener(MouseEvent.ROLL_OVER, this.rollover);
            this._clickColor = [super.textColor, super.textColor, super.textColor];
            return;
        }// end function

        private function rollout(event:MouseEvent) : void
        {
            super.textColor = this._clickColor[0];
            return;
        }// end function

        private function rollover(event:MouseEvent) : void
        {
            super.textColor = this._clickColor[1];
            return;
        }// end function

        public function clickColor(param1:Array) : void
        {
            if (param1.length > 1)
            {
                this._clickColor = param1;
                super.textColor = this._clickColor[0];
            }
            return;
        }// end function

        override public function get text() : String
        {
            return super.tf.text;
        }// end function

        override public function set text(param1:String) : void
        {
            if (this._lineflag)
            {
                super.text = "<P ALIGN=\'LEFT\'><u><a href=\'event:0\'>" + param1 + "</a></u></P>";
            }
            else
            {
                super.text = "<P ALIGN=\'LEFT\'><a href=\'event:0\'>" + param1 + "</a></P>";
            }
            return;
        }// end function

    }
}
