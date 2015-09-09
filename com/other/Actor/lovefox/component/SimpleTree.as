package lovefox.component
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;

    public class SimpleTree extends CanvasUI
    {
        private var _nodearr:Array;
        private var _selectid:int = -1;
        private var _expandItem:Boolean = false;

        public function SimpleTree(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:Number = 200, param5:Number = 100)
        {
            if (param1 != null)
            {
                param1.addChild(this);
            }
            x = param2;
            y = param3;
            width = param4;
            height = param5;
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            this._nodearr = new Array();
            return;
        }// end function

        public function addNode(param1:String, param2:Boolean = false) : void
        {
            var _loc_3:* = new Object();
            _loc_3.str = param1;
            _loc_3.itemarr = new Array();
            _loc_3.checkarr = new Array();
            _loc_3.openitem = param2;
            _loc_3.nodebox = new CheckBox(null, 10, this.gety(this._nodearr.length), param1, Config.create(this.showhiditem, param1));
            _loc_3.nodebox.iconStyle = 1;
            if (!this._expandItem)
            {
                this.addChildUI(_loc_3.nodebox);
            }
            _loc_3.nodebox.selected = param2;
            this._nodearr.push(_loc_3);
            this.treeRefresh();
            return;
        }// end function

        public function additems(param1:Array, param2:String, param3:int = 0, param4:Boolean = true) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_5:* = 0;
            while (_loc_5 < this._nodearr.length)
            {
                
                if (this._nodearr[_loc_5].str == param2)
                {
                    _loc_6 = new SimplelipUI();
                    if (param4)
                    {
                        _loc_6.width = width - 30;
                    }
                    else
                    {
                        _loc_6.width = width - 15;
                    }
                    _loc_6.label = param1;
                    if (param3 != 0)
                    {
                        _loc_6.textColor = param3;
                    }
                    _loc_7 = new CheckBox();
                    if (this._nodearr[_loc_5].openitem)
                    {
                        _loc_7.x = 10;
                        _loc_7.y = this.gety(_loc_5) + this._nodearr[_loc_5].itemarr.length * 26 + 25;
                        if (param4)
                        {
                            this.addChildUI(_loc_7);
                            _loc_6.x = 25;
                        }
                        else
                        {
                            _loc_6.x = 10;
                        }
                        _loc_6.y = this.gety(_loc_5) + this._nodearr[_loc_5].itemarr.length * 26 + 20;
                        this.addChildUI(_loc_6);
                    }
                    else
                    {
                        if (param4)
                        {
                            _loc_6.x = 25;
                        }
                        else
                        {
                            _loc_6.x = 10;
                        }
                        _loc_7.x = 10;
                    }
                    this._nodearr[_loc_5].itemarr.push(_loc_6);
                    this._nodearr[_loc_5].checkarr.push(_loc_7);
                    this._nodearr[_loc_5].cflag = param4;
                    _loc_6.addEventListener(MouseEvent.CLICK, Config.create(this.selectlip, this._nodearr[_loc_5].itemarr[(this._nodearr[_loc_5].itemarr.length - 1)].id));
                    _loc_7.addEventListener(MouseEvent.CLICK, Config.create(this.checklip, this._nodearr[_loc_5].itemarr[(this._nodearr[_loc_5].itemarr.length - 1)].id, _loc_7));
                    break;
                }
                _loc_5 = _loc_5 + 1;
            }
            if (this._expandItem)
            {
                this.expand();
            }
            else
            {
                this.treeRefresh();
            }
            return;
        }// end function

        private function checklip(event:MouseEvent, param2:int, param3:CheckBox) : void
        {
            var _loc_4:* = new SimpleTreeEvent(SimpleTreeEvent.CHECK_ID);
            new SimpleTreeEvent(SimpleTreeEvent.CHECK_ID).id = param2;
            _loc_4.check = param3.selected;
            this.dispatchEvent(_loc_4);
            return;
        }// end function

        private function selectlip(event:MouseEvent, param2:int) : void
        {
            this.selectid = param2;
            var _loc_3:* = new SimpleTreeEvent(SimpleTreeEvent.SELECT_ID);
            _loc_3.id = param2;
            this.dispatchEvent(_loc_3);
            return;
        }// end function

        private function gety(param1:int) : Number
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < param1)
            {
                
                if (param1 != 0)
                {
                    if (this._nodearr[_loc_3].openitem)
                    {
                        _loc_2 = _loc_2 + (20 + this._nodearr[_loc_3].itemarr.length * 26);
                    }
                    else
                    {
                        _loc_2 = _loc_2 + 20;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        private function showhiditem(event:MouseEvent, param2:String) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_3:* = new Object();
            _loc_3 = this.getnode(param2);
            if (_loc_3.openitem)
            {
                _loc_3.openitem = false;
                _loc_4 = 0;
                while (_loc_4 < _loc_3.itemarr.length)
                {
                    
                    if (_loc_3.itemarr[_loc_4].parent != null)
                    {
                        this.removeChildUI(_loc_3.itemarr[_loc_4]);
                        if (_loc_3.checkarr[_loc_4].parent != null)
                        {
                            this.removeChildUI(_loc_3.checkarr[_loc_4]);
                        }
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            else
            {
                _loc_3.openitem = true;
                _loc_5 = 0;
                while (_loc_5 < _loc_3.itemarr.length)
                {
                    
                    this.addChildUI(_loc_3.itemarr[_loc_5]);
                    if (_loc_3.cflag)
                    {
                        this.addChildUI(_loc_3.checkarr[_loc_5]);
                    }
                    _loc_5 = _loc_5 + 1;
                }
            }
            this.treeRefresh();
            return;
        }// end function

        public function getnode(param1:String) : Object
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._nodearr.length)
            {
                
                if (this._nodearr[_loc_2].str == param1)
                {
                    return this._nodearr[_loc_2];
                }
                _loc_2 = _loc_2 + 1;
            }
            return null;
        }// end function

        public function seletlabel(param1:String, param2:uint = 0) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (this.selectid != -1)
            {
                _loc_3 = 0;
                while (_loc_3 < this._nodearr.length)
                {
                    
                    _loc_4 = 0;
                    while (_loc_4 < this._nodearr[_loc_3].itemarr.length)
                    {
                        
                        if (this._nodearr[_loc_3].itemarr[_loc_4].id == this.selectid)
                        {
                            this._nodearr[_loc_3].itemarr[_loc_4].changeLabel(param1, param2);
                            break;
                        }
                        _loc_4 = _loc_4 + 1;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            return;
        }// end function

        public function changeLabel(param1:int, param2:String, param3:uint = 0) : void
        {
            var _loc_5:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < this._nodearr.length)
            {
                
                _loc_5 = 0;
                while (_loc_5 < this._nodearr[_loc_4].itemarr.length)
                {
                    
                    if (this._nodearr[_loc_4].itemarr[_loc_5].id == param1)
                    {
                        this._nodearr[_loc_4].itemarr[_loc_5].changeLabel(param2, param3);
                        break;
                    }
                    _loc_5 = _loc_5 + 1;
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function treeRefresh() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = 0;
            while (_loc_1 < this._nodearr.length)
            {
                
                this._nodearr[_loc_1].nodebox.y = this.gety(_loc_1);
                if (this._nodearr[_loc_1].openitem)
                {
                    _loc_2 = 0;
                    while (_loc_2 < this._nodearr[_loc_1].itemarr.length)
                    {
                        
                        this._nodearr[_loc_1].itemarr[_loc_2].y = 20 + this.gety(_loc_1) + 26 * _loc_2;
                        this._nodearr[_loc_1].checkarr[_loc_2].y = 25 + this.gety(_loc_1) + 26 * _loc_2;
                        _loc_2 = _loc_2 + 1;
                    }
                }
                _loc_1 = _loc_1 + 1;
            }
            this.reFresh();
            return;
        }// end function

        public function get selectid() : int
        {
            return this._selectid;
        }// end function

        public function set selectid(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (this._selectid != -1)
            {
                _loc_3 = 0;
                while (_loc_3 < this._nodearr.length)
                {
                    
                    _loc_4 = 0;
                    while (_loc_4 < this._nodearr[_loc_3].itemarr.length)
                    {
                        
                        if (this._nodearr[_loc_3].itemarr[_loc_4].id == this._selectid)
                        {
                            this._nodearr[_loc_3].itemarr[_loc_4].select = false;
                            break;
                        }
                        _loc_4 = _loc_4 + 1;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            this._selectid = param1;
            var _loc_2:* = 0;
            while (_loc_2 < this._nodearr.length)
            {
                
                _loc_5 = 0;
                while (_loc_5 < this._nodearr[_loc_2].itemarr.length)
                {
                    
                    if (this._nodearr[_loc_2].itemarr[_loc_5].id == param1)
                    {
                        this._nodearr[_loc_2].itemarr[_loc_5].select = true;
                        break;
                    }
                    _loc_5 = _loc_5 + 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function itemToNode(param1:int, param2:int, param3:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_4:* = 0;
            while (_loc_4 < this._nodearr[param2].itemarr.length)
            {
                
                if (this._nodearr[param2].itemarr[_loc_4].id == param1)
                {
                    _loc_5 = this._nodearr[param2].itemarr[_loc_4];
                    _loc_6 = this._nodearr[param2].checkarr[_loc_4];
                    this._nodearr[param2].itemarr.splice(_loc_4, 1);
                    this._nodearr[param2].checkarr.splice(_loc_4, 1);
                    this._nodearr[param3].itemarr.splice(0, 0, _loc_5);
                    this._nodearr[param3].checkarr.splice(0, 0, _loc_6);
                    if (this._nodearr[param3].openitem)
                    {
                        if (_loc_5.parent == null)
                        {
                            this.addChildUI(_loc_5);
                            if (this._nodearr[param3].cflag)
                            {
                                this.addChildUI(_loc_6);
                            }
                        }
                    }
                    else
                    {
                        this.removeChildUI(_loc_5);
                        if (_loc_6.parent != null)
                        {
                            this.removeChildUI(_loc_6);
                        }
                    }
                    this.treeRefresh();
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function delItem(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this._nodearr.length)
            {
                
                _loc_3 = 0;
                while (_loc_3 < this._nodearr[_loc_2].itemarr.length)
                {
                    
                    if (this._nodearr[_loc_2].itemarr[_loc_3].id == param1)
                    {
                        if (this._nodearr[_loc_2].itemarr[_loc_3].parent != null)
                        {
                            this.removeChildUI(this._nodearr[_loc_2].itemarr[_loc_3]);
                            if (this._nodearr[_loc_2].checkarr[_loc_3].parent != null)
                            {
                                this.removeChildUI(this._nodearr[_loc_2].checkarr[_loc_3]);
                            }
                        }
                        this._nodearr[_loc_2].itemarr.splice(_loc_3, 1);
                        this._nodearr[_loc_2].checkarr.splice(_loc_3, 1);
                        if (this._expandItem)
                        {
                            this.expand();
                        }
                        else
                        {
                            this.treeRefresh();
                        }
                        break;
                    }
                    _loc_3 = _loc_3 + 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function checkrefresh(param1:Array) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = false;
            var _loc_5:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this._nodearr.length)
            {
                
                _loc_3 = 0;
                while (_loc_3 < this._nodearr[_loc_2].checkarr.length)
                {
                    
                    _loc_4 = false;
                    _loc_5 = 0;
                    while (_loc_5 < param1.length)
                    {
                        
                        if (this._nodearr[_loc_2].itemarr[_loc_3].id == param1[_loc_5])
                        {
                            _loc_4 = true;
                            break;
                        }
                        _loc_5 = _loc_5 + 1;
                    }
                    if (_loc_4)
                    {
                        this._nodearr[_loc_2].checkarr[_loc_3].selected = true;
                    }
                    else
                    {
                        this._nodearr[_loc_2].checkarr[_loc_3].selected = false;
                    }
                    _loc_3 = _loc_3 + 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function expand() : void
        {
            var _loc_3:* = 0;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this._nodearr.length)
            {
                
                _loc_3 = 0;
                while (_loc_3 < this._nodearr[_loc_2].itemarr.length)
                {
                    
                    this._nodearr[_loc_2].itemarr[_loc_3].y = _loc_1;
                    this._nodearr[_loc_2].checkarr[_loc_3].y = 5 + _loc_1;
                    _loc_1 = _loc_1 + 26;
                    _loc_3 = _loc_3 + 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            this.reFresh();
            return;
        }// end function

        public function get expandItem() : Boolean
        {
            return this._expandItem;
        }// end function

        public function set expandItem(param1:Boolean) : void
        {
            this._expandItem = param1;
            return;
        }// end function

        public function clearTree() : void
        {
            this._nodearr = [];
            this._selectid = -1;
            this.removeAllChildren();
            return;
        }// end function

    }
}
