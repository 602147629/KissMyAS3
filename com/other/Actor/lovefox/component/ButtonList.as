package lovefox.component
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;

    public class ButtonList extends PagePushButton
    {
        private var _button:Sprite;
        private var _group:String;
        private var _fuc:Function;
        private static var buttons:Array;

        public function ButtonList(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:String = "", param5:Boolean = false, param6:Function = null)
        {
            ButtonList.addButton(this);
            _selected = param5;
            this.label = param4;
            this.width = 60;
            move(param2, param3);
            if (param1 != null)
            {
                param1.addChild(this);
            }
            if (param6 != null)
            {
                this.addEventListener(MouseEvent.CLICK, param6);
                this.addEventListener(MouseEvent.CLICK, this.onlick);
            }
            return;
        }// end function

        private function onlick(event:MouseEvent) : void
        {
            this.selected = true;
            return;
        }// end function

        override public function set selected(param1:Boolean) : void
        {
            super.selected = param1;
            if (super.selected)
            {
                ButtonList.clear(this);
            }
            return;
        }// end function

        public function set group(param1:String) : void
        {
            this._group = param1;
            return;
        }// end function

        public function get group() : String
        {
            return this._group;
        }// end function

        private static function addButton(param1:ButtonList) : void
        {
            if (buttons == null)
            {
                buttons = new Array();
            }
            buttons.push(param1);
            return;
        }// end function

        private static function clear(param1:ButtonList) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < buttons.length)
            {
                
                if (buttons[_loc_2] != param1 && buttons[_loc_2]._group == param1.group)
                {
                    buttons[_loc_2].selected = false;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

    }
}
