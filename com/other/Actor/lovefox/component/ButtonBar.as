package lovefox.component
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;

    public class ButtonBar extends Component
    {
        private var backmc:Sprite;
        public var tabarr:Array;
        private var tabDateArr:Array;
        private var _selectpage:int = 0;
        private var _lineFlag:Boolean = true;

        public function ButtonBar(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:int = 0, param5 = -12)
        {
            if (param4 == 0)
            {
                param4 = param1.width - 14;
            }
            if (param1 != null)
            {
                param1.addChild(this);
            }
            x = param2;
            y = param3;
            this.tabarr = new Array();
            this.tabDateArr = [];
            this.backmc = new Sprite();
            this.addChild(this.backmc);
            this.backmc.graphics.lineStyle(1, 10975316, 1, true, "normal");
            this.backmc.graphics.moveTo(param5, 21);
            this.backmc.graphics.lineTo(param4 - 5, 21);
            return;
        }// end function

        public function addTab(param1:String, param2:Function = null, param3 = 60)
        {
            var _loc_5:* = undefined;
            var _loc_4:* = 0;
            if (this.tabarr.length > 0)
            {
                _loc_4 = this.tabDateArr[(this.tabarr.length - 1)].width + this.tabarr[(this.tabarr.length - 1)].x;
            }
            if (this._lineFlag)
            {
                _loc_5 = new PagePushButton(this, _loc_4, 0, param1, null);
            }
            else
            {
                _loc_5 = new PushButton(this, _loc_4, 0, param1, null);
                _loc_5.setTable("table18", "table31");
                _loc_5.textColor = Style.GOLD_FONT;
                _loc_5.color = 16777215;
            }
            _loc_5.width = param3;
            _loc_5.addEventListener(MouseEvent.CLICK, Config.create(this.selectbtn, _loc_5, param2));
            if (this.tabarr.length == 0)
            {
                _loc_5.selected = true;
            }
            this.tabarr.push(_loc_5);
            this.tabDateArr.push({width:param3});
            return _loc_5;
        }// end function

        private function selectbtn(event:MouseEvent, param2, param3:Function) : void
        {
            var _loc_4:* = 0;
            while (_loc_4 < this.tabarr.length)
            {
                
                if (this.tabarr[_loc_4] == param2)
                {
                    this.selectpage = _loc_4;
                    if (param3 != null)
                    {
                        this.param3(event);
                    }
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function get selectpage() : int
        {
            return this._selectpage;
        }// end function

        public function set selectpage(param1:int) : void
        {
            if (param1 < this.tabarr.length)
            {
                this.tabarr[this._selectpage].selected = false;
                if (!this._lineFlag)
                {
                    this.tabarr[this._selectpage].setTable("table18", "table31");
                }
                this.tabarr[param1].selected = true;
                this._selectpage = param1;
                if (!this._lineFlag)
                {
                    this.tabarr[param1].setTable("table24", "table24");
                }
            }
            return;
        }// end function

        public function clearBar() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this.tabarr.length)
            {
                
                this.removeChild(this.tabarr[_loc_1]);
                _loc_1 = _loc_1 + 1;
            }
            this.tabarr = [];
            this.tabDateArr = [];
            this._selectpage = 0;
            return;
        }// end function

        public function set lineFlag(param1:Boolean) : void
        {
            this._lineFlag = param1;
            this.backmc.visible = param1;
            return;
        }// end function

        public function bartextcolor(param1:int, param2:int) : void
        {
            if (this.tabarr[param1] != null)
            {
                this.tabarr[param1].textColor = param2;
            }
            return;
        }// end function

    }
}
