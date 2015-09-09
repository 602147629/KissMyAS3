package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.text.*;

    public class MoneyUI extends Sprite
    {
        private var _value:Object;
        private var _goldPanel:Panel;
        private var _silverPanel:Panel;
        private var _bronzePanel:Panel;
        private var _goldTf:TextField;
        private var _silverTf:TextField;
        private var _bronzeTf:TextField;
        private var _width:Object;

        public function MoneyUI(param1 = null, param2:Number = 0, param3:Number = 0)
        {
            x = Math.round(param2);
            y = Math.round(param3);
            if (param1 != null)
            {
                param1.addChild(this);
            }
            this.init();
            return;
        }// end function

        private function init()
        {
            this._goldTf = Config.getSimpleTextField();
            addChild(this._goldTf);
            this._goldTf.autoSize = TextFieldAutoSize.RIGHT;
            this._goldTf.x = 25;
            this._silverTf = Config.getSimpleTextField();
            addChild(this._silverTf);
            this._silverTf.autoSize = TextFieldAutoSize.RIGHT;
            this._silverTf.x = 65;
            this._bronzeTf = Config.getSimpleTextField();
            addChild(this._bronzeTf);
            this._bronzeTf.autoSize = TextFieldAutoSize.RIGHT;
            this._bronzeTf.x = 105;
            this._goldPanel = new Panel(this, 30, 5);
            this._goldPanel.width = 10;
            this._goldPanel.height = 10;
            this._goldPanel.roundCorner = 10;
            this._goldPanel.color = 16763904;
            this._goldPanel.tip = Config.language("MoneyUI", 1);
            this._silverPanel = new Panel(this, 70, 5);
            this._silverPanel.width = 10;
            this._silverPanel.height = 10;
            this._silverPanel.roundCorner = 10;
            this._silverPanel.color = 13421772;
            this._silverPanel.tip = Config.language("MoneyUI", 2);
            this._bronzePanel = new Panel(this, 110, 5);
            this._bronzePanel.width = 10;
            this._bronzePanel.height = 10;
            this._bronzePanel.roundCorner = 10;
            this._bronzePanel.color = 13395558;
            this._bronzePanel.tip = Config.language("MoneyUI", 3);
            return;
        }// end function

        public function set value(param1:Number) : void
        {
            this._value = param1;
            var _loc_2:* = String(this._value);
            this._bronzeTf.htmlText = _loc_2.substring(_loc_2.length - 3);
            if (_loc_2.length > 3)
            {
                this._silverTf.htmlText = _loc_2.substring(_loc_2.length - 6, _loc_2.length - 3);
            }
            else
            {
                this._silverTf.htmlText = "";
            }
            if (_loc_2.length > 6)
            {
                this._goldTf.htmlText = _loc_2.substring(0, _loc_2.length - 6);
            }
            else
            {
                this._goldTf.htmlText = "";
            }
            return;
        }// end function

        public function get value()
        {
            return this._value;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._width = param1;
            return;
        }// end function

        override public function get width() : Number
        {
            return this._width;
        }// end function

        public function set autoSize(param1)
        {
            return;
        }// end function

    }
}
