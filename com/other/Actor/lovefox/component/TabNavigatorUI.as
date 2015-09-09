package lovefox.component
{
    import flash.display.*;
    import flash.events.*;

    public class TabNavigatorUI extends Sprite
    {
        private var container:Sprite;
        private var tabarr:Array;
        private var m_width:Number = 200;
        private var m_height:Number = 100;
        private var m_btnlen:uint = 60;
        private var m_btnheight:Number = 20;
        private var selectpanel:String = "";
        private var m_bgalpha:Number = 0.1;
        private var _verticalScrollPolicy:Boolean = true;

        public function TabNavigatorUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:Number = 200, param5:Number = 100)
        {
            this.tabarr = new Array();
            this.move(param2, param3);
            if (param1 != null)
            {
                param1.addChild(this);
            }
            this.width = param4;
            this.height = param5;
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            this.container = new Sprite();
            this.addChild(this.container);
            this.container.y = this.m_btnheight;
            this.bgreset();
            return;
        }// end function

        private function bgreset() : void
        {
            this.container.graphics.clear();
            this.container.graphics.beginFill(16777215, this.m_bgalpha);
            this.container.graphics.drawRoundRect(0, 0, this.m_width, this.m_height - this.m_btnheight, 5);
            this.container.graphics.endFill();
            return;
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            x = Math.round(param1);
            y = Math.round(param2);
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this.m_width = param1;
            var _loc_2:* = 0;
            while (_loc_2 < this.tabarr.length)
            {
                
                this.tabarr[_loc_2].tabpanel.width = param1;
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function get width() : Number
        {
            return this.m_width;
        }// end function

        override public function set height(param1:Number) : void
        {
            this.m_height = param1;
            var _loc_2:* = 0;
            while (_loc_2 < this.tabarr.length)
            {
                
                this.tabarr[_loc_2].tabpanel.height = param1;
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function get height() : Number
        {
            return this.m_height;
        }// end function

        public function addTabList(param1:Array) : void
        {
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                this.addTab(param1[_loc_3].label, param1[_loc_3].name);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function addTab(param1:String, param2:String, param3:DisplayObject = null) : void
        {
            var _loc_6:* = null;
            var _loc_4:* = new Object();
            new Object().label = param1;
            _loc_4.name = param2;
            var _loc_5:* = new ButtonList(this, this.tabarr.length * this.m_btnlen, 0, param1, false, this.create(this.btnselect, _loc_4.name));
            new ButtonList(this, this.tabarr.length * this.m_btnlen, 0, param1, false, this.create(this.btnselect, _loc_4.name)).group = this.name;
            _loc_4.tabbtn = _loc_5;
            if (param3 != null)
            {
                _loc_4.tabpanel = param3;
            }
            else
            {
                _loc_6 = new CanvasUI();
                _loc_6.width = this.m_width;
                _loc_6.height = this.m_height;
                _loc_4.tabpanel = _loc_6;
            }
            this.tabarr.push(_loc_4);
            if (this.tabarr.length == 1)
            {
                this.selectedIndex = this.tabarr[0].name;
                _loc_5.selected = true;
            }
            return;
        }// end function

        private function btnselect(event:Event, param2:String) : void
        {
            this.selectedIndex = param2;
            return;
        }// end function

        public function get selected() : String
        {
            return this.selectpanel;
        }// end function

        public function set selected(param1:String) : void
        {
            this.selectedIndex = param1;
            return;
        }// end function

        public function set selectedIndex(param1:String) : void
        {
            var _loc_2:* = this.tabarr.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this.tabarr[_loc_3].name == param1)
                {
                    this.removeAllChildren(this.container);
                    this.container.addChild(this.tabarr[_loc_3].tabpanel);
                    this.selectpanel = this.tabarr[_loc_3].name;
                    dispatchEvent(new Event(Event.SELECT));
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function get selectedIndex() : String
        {
            return this.selectpanel;
        }// end function

        public function removeAllChildren(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        public function getTab(param1:String) : CanvasUI
        {
            var _loc_2:* = this.tabarr.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this.tabarr[_loc_3].name == param1)
                {
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            return this.tabarr[_loc_3].tabpanel;
        }// end function

        private function create(param1:Function, ... args) : Function
        {
            args = new activation;
            var F:Boolean;
            var f:* = param1;
            var arg:* = args;
            F;
            var _f:* = function (param1) : void
            {
                var _loc_2:* = arg;
                if (!F)
                {
                    F = true;
                    _loc_2.unshift(param1);
                }
                f.apply(null, _loc_2);
                return;
            }// end function
            ;
            return ;
        }// end function

        public function setStyle(param1:Number = 60, param2:Number = 20, param3:Number = 0.4) : void
        {
            this.m_btnlen = param1;
            this.m_btnheight = param2;
            this.m_bgalpha = param3;
            this.bgreset();
            return;
        }// end function

        public function set deleteIndex(param1:String) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this.tabarr.length)
            {
                
                if (this.tabarr[_loc_2].name == param1)
                {
                    this.removeChild(this.tabarr[_loc_2].tabbtn);
                    this.container.removeChild(this.tabarr[_loc_2].tabpanel);
                    this.tabarr.splice(_loc_2, 1);
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.tabarr.length)
            {
                
                this.tabarr[_loc_3].tabbtn.x = _loc_2 * this.m_btnlen;
                _loc_3 = _loc_3 + 1;
            }
            if (this.selectpanel == param1)
            {
                if (this.tabarr.length != 0)
                {
                    this.selectedIndex = this.tabarr[0].name;
                }
                else
                {
                    this.selectpanel = "";
                }
            }
            return;
        }// end function

        public function set verticalScrollPolicy(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            this._verticalScrollPolicy = param1;
            if (this._verticalScrollPolicy)
            {
                _loc_2 = 0;
                while (_loc_2 < this.tabarr.length)
                {
                    
                    this.tabarr[_loc_2].tabpanel.verticalScrollPolicy = true;
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                _loc_3 = 0;
                while (_loc_3 < this.tabarr.length)
                {
                    
                    this.tabarr[_loc_3].tabpanel.verticalScrollPolicy = false;
                    _loc_3 = _loc_3 + 1;
                }
            }
            return;
        }// end function

        public function get verticalScrollPolicy() : Boolean
        {
            return this._verticalScrollPolicy;
        }// end function

    }
}
