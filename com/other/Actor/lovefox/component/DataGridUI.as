package lovefox.component
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;

    public class DataGridUI extends Sprite
    {
        private var headrow:ToggleButtonBarUI;
        private var columnarr:Array;
        private var dataarr:Array;
        private var listpanel:CanvasUI;
        private var m_width:Number = 200;
        private var m_height:Number = 100;
        private var rowheight:int = 20;
        private var rowselect:int = -1;
        private var tilearr:Array;
        private var _topshow:Boolean = true;
        private var _listShow:Boolean = false;
        private var _selectable:Boolean = true;
        private var noinfor:Label;

        public function DataGridUI(param1:Array, param2:DisplayObjectContainer = null, param3:Number = 0, param4:Number = 0, param5:Number = 200, param6:Number = 100, param7 = 20)
        {
            this.dataarr = [];
            if (param2 != null)
            {
                param2.addChild(this);
            }
            this.width = param5;
            this.height = param6;
            this.rowheight = param7;
            x = param3;
            y = param4;
            this.columnarr = param1;
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            this.headrow = new ToggleButtonBarUI(this.columnarr);
            if (this._topshow)
            {
                this.addChild(this.headrow);
            }
            this.headrow.addEventListener(AccTreeEvent.TOGGLE_SELECT, this.sortcolumn);
            this.listpanel = new CanvasUI(this, 0, 25, this.m_width + 5, this.m_height - 26);
            return;
        }// end function

        private function sortcolumn(event:AccTreeEvent) : void
        {
            trace(event.typeobj.label + "  " + event.typeobj.i + "  " + event.typeobj.sort);
            var _loc_2:* = new DataGridEvent(DataGridEvent.CLOMN_SORT);
            _loc_2.selectIndex = event.typeobj.i;
            this.columnarr[event.typeobj.i].sort = event.typeobj.sort;
            _loc_2.rowobj = this.columnarr[event.typeobj.i];
            this.dispatchEvent(_loc_2);
            return;
        }// end function

        public function addColumn(param1:String, param2:String, param3:Number = 10, param4:Sprite = null) : void
        {
            this.columnarr.push({datafiled:param1, headertext:param2, len:param3, fuc:param1, childmc:param4});
            return;
        }// end function

        public function delColumn(param1:String) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this.columnarr.length)
            {
                
                if (param1 == this.columnarr[_loc_2].datafiled)
                {
                    this.columnarr.splice(_loc_2, 1);
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function get dataProvider()
        {
            return this.dataarr;
        }// end function

        public function set dataProvider(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            this.dataarr.length = 0;
            var _loc_2:* = 0;
            while (_loc_2 < param1.length)
            {
                
                _loc_3 = {};
                for (_loc_4 in param1[_loc_2])
                {
                    
                    _loc_3[_loc_4] = param1[_loc_2][_loc_4];
                }
                this.dataarr.push(_loc_3);
                _loc_2 = _loc_2 + 1;
            }
            this.showlist();
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this.m_width = param1;
            return;
        }// end function

        override public function get width() : Number
        {
            return this.m_width;
        }// end function

        override public function set height(param1:Number) : void
        {
            this.m_height = param1;
            return;
        }// end function

        override public function get height() : Number
        {
            return this.m_height;
        }// end function

        private function showlist() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            this.listpanel.removeAllChildren();
            this.tilearr = new Array();
            this.rowselect = -1;
            if (this.dataarr.length == 0)
            {
                if (this._listShow)
                {
                    _loc_2 = int(this.m_height / (this.rowheight + 5));
                    _loc_3 = 0;
                    while (_loc_3 < _loc_2)
                    {
                        
                        _loc_4 = new Sprite();
                        this.listpanel.addChildUI(_loc_4);
                        _loc_4.x = 0;
                        _loc_4.y = (this.rowheight + 5) * _loc_3;
                        _loc_5 = new Sprite();
                        _loc_5.graphics.beginFill(11508617);
                        _loc_5.graphics.drawRoundRect(0, 0, this.m_width, this.rowheight, 1);
                        _loc_5.graphics.endFill();
                        _loc_4.addChild(_loc_5);
                        _loc_5.alpha = 0.5;
                        _loc_3 = _loc_3 + 1;
                    }
                }
                else
                {
                    this.noinfor = new Label(null, (this.width - 50) / 2, 20, Config.language("DataGridUI", 1));
                    this.listpanel.addChildUI(this.noinfor);
                    this.noinfor.visible = true;
                }
            }
            var _loc_1:* = 0;
            while (_loc_1 < this.dataarr.length)
            {
                
                _loc_4 = new Sprite();
                this.listpanel.addChildUI(_loc_4);
                _loc_4.x = 0;
                _loc_4.y = (this.rowheight + 5) * _loc_1;
                _loc_5 = new Sprite();
                _loc_5.graphics.beginFill(11508617);
                _loc_5.graphics.drawRoundRect(0, 0, this.m_width, this.rowheight, 1);
                _loc_5.graphics.endFill();
                _loc_4.addChild(_loc_5);
                _loc_4.addEventListener(MouseEvent.ROLL_OVER, this.create(this.rowrollover, _loc_1));
                _loc_4.addEventListener(MouseEvent.ROLL_OUT, this.create(this.rowrollout, _loc_1));
                _loc_4.addEventListener(MouseEvent.CLICK, this.create(this.rowclick, _loc_1));
                _loc_5.alpha = 0.5;
                this.dataarr[_loc_1].rowmc = _loc_5;
                _loc_6 = 0;
                _loc_7 = new Object();
                _loc_8 = 0;
                while (_loc_8 < this.columnarr.length)
                {
                    
                    if (this.dataarr[_loc_1][this.columnarr[_loc_8].childmc] != null)
                    {
                        _loc_4.addChild(this.dataarr[_loc_1][this.columnarr[_loc_8].childmc]);
                        this.dataarr[_loc_1][this.columnarr[_loc_8].childmc].x = _loc_6 + 5;
                        _loc_7[this.columnarr[_loc_8].datafield] = this.dataarr[_loc_1][this.columnarr[_loc_8].childmc];
                    }
                    else
                    {
                        _loc_9 = " ";
                        if (this.dataarr[_loc_1][this.columnarr[_loc_8].datafield] != null)
                        {
                            _loc_9 = this.dataarr[_loc_1][this.columnarr[_loc_8].datafield];
                        }
                        _loc_10 = new Label(_loc_4, 2, 2, _loc_9);
                        _loc_10.x = _loc_6 + (this.columnarr[_loc_8].len - _loc_10.width) / 2;
                        if (this.dataarr[_loc_1].hasOwnProperty("textcolor"))
                        {
                            if (this.dataarr[_loc_1].textcolor != 0)
                            {
                                _loc_10.textColor = this.dataarr[_loc_1].textcolor;
                            }
                        }
                        _loc_7[this.columnarr[_loc_8].datafield] = _loc_10;
                    }
                    _loc_6 = _loc_6 + this.columnarr[_loc_8].len;
                    _loc_8 = _loc_8 + 1;
                }
                this.tilearr.push(_loc_7);
                _loc_1 = _loc_1 + 1;
            }
            if (this._listShow)
            {
                _loc_2 = int(this.m_height / (this.rowheight + 5));
                _loc_3 = this.dataarr.length;
                while (_loc_3 < _loc_2)
                {
                    
                    _loc_4 = new Sprite();
                    this.listpanel.addChildUI(_loc_4);
                    _loc_4.x = 0;
                    _loc_4.y = (this.rowheight + 5) * _loc_3;
                    _loc_5 = new Sprite();
                    _loc_5.graphics.beginFill(11508617);
                    _loc_5.graphics.drawRoundRect(0, 0, this.m_width, this.rowheight, 1);
                    _loc_5.graphics.endFill();
                    _loc_4.addChild(_loc_5);
                    _loc_5.alpha = 0.5;
                    _loc_3 = _loc_3 + 1;
                }
            }
            return;
        }// end function

        private function rowrollover(event:MouseEvent, param2:int) : void
        {
            this.dataarr[param2].rowmc.alpha = 1;
            var _loc_3:* = new DataGridEvent(DataGridEvent.ROW_ROLLOVER);
            _loc_3.selectIndex = this.rowselect;
            _loc_3.rowobj = this.dataarr[param2];
            this.dispatchEvent(_loc_3);
            return;
        }// end function

        private function rowrollout(event:MouseEvent, param2:int) : void
        {
            var _loc_3:* = null;
            if (this.dataarr[param2] == null)
            {
                return;
            }
            if (param2 != this.rowselect)
            {
                if (this.dataarr[param2].hasOwnProperty("rowmc"))
                {
                    this.dataarr[param2].rowmc.alpha = 0.5;
                    _loc_3 = new DataGridEvent(DataGridEvent.ROW_ROLLOUT);
                    _loc_3.selectIndex = this.rowselect;
                    _loc_3.rowobj = this.dataarr[param2];
                    this.dispatchEvent(_loc_3);
                }
            }
            return;
        }// end function

        private function rowclick(event:MouseEvent, param2:int) : void
        {
            var _loc_3:* = null;
            if (this._selectable)
            {
                if (this.dataarr[this.rowselect] != null)
                {
                    this.dataarr[this.rowselect].rowmc.alpha = 0.5;
                }
                this.dataarr[param2].rowmc.alpha = 1;
                this.rowselect = param2;
                _loc_3 = new DataGridEvent(DataGridEvent.ROW_SELECT);
                _loc_3.selectIndex = this.rowselect;
                _loc_3.rowobj = this.dataarr[this.rowselect];
                this.dispatchEvent(_loc_3);
            }
            return;
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

        public function get rowIndex() : int
        {
            return this.rowselect;
        }// end function

        public function set rowIndex(param1:int) : void
        {
            if (this.dataarr[this.rowselect] != null)
            {
                this.dataarr[this.rowselect].rowmc.alpha = 0.5;
            }
            if (param1 >= 0)
            {
                this.dataarr[param1].rowmc.alpha = 1;
            }
            this.rowselect = param1;
            return;
        }// end function

        public function setTile(param1:uint, param2:String, param3:String) : void
        {
            this.tilearr[param1][param2].text = param3;
            this.dataarr[param1][param2] = param3;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < this.columnarr.length)
            {
                
                if (this.columnarr[_loc_5].datafiled != param2)
                {
                    _loc_4 = _loc_4 + this.columnarr[_loc_5].len;
                }
                else
                {
                    this.tilearr[param1][param2].x = _loc_4 + (this.columnarr[_loc_5].len - this.tilearr[param1][param2].width) / 2;
                    break;
                }
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        public function refreshList() : void
        {
            this.showlist();
            return;
        }// end function

        private function removeallchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            param1.graphics.clear();
            return;
        }// end function

        public function get topshow() : Boolean
        {
            return this._topshow;
        }// end function

        public function set topshow(param1:Boolean) : void
        {
            this._topshow = param1;
            if (this._topshow)
            {
                this.addChild(this.headrow);
            }
            else if (this.headrow.parent != null)
            {
                this.removeChild(this.headrow);
            }
            return;
        }// end function

        public function get listShow() : Boolean
        {
            return this._listShow;
        }// end function

        public function set listShow(param1:Boolean) : void
        {
            this._listShow = param1;
            this.showlist();
            return;
        }// end function

        public function set selectable(param1:Boolean) : void
        {
            this._selectable = param1;
            return;
        }// end function

        public function noinforvisib()
        {
            if (this.noinfor != null)
            {
                this.noinfor.visible = false;
            }
            return;
        }// end function

    }
}
