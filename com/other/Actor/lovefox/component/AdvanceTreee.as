package lovefox.component
{
    import flash.display.*;
    import flash.events.*;

    public class AdvanceTreee extends CanvasUI
    {
        private var _nodearr:Array;
        public var _treearr:Array;
        private var _selectid:int = -1;
        private var _expandItem:Boolean = false;
        private var itemypos:int = 0;
        private var _indentation:int = 15;
        private var linebg:Sprite;

        public function AdvanceTreee(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:Number = 200, param5:Number = 100)
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
            this.addEventListener("iconcheck", this.showTree);
            this.addEventListener(AdvanceTreeeEvent.CHECK_ID, this.selectitem);
            this.linebg = new Sprite();
            return;
        }// end function

        private function initpanel() : void
        {
            this._nodearr = new Array();
            this._treearr = new Array();
            return;
        }// end function

        public function adddata(param1:XML, param2:int, param3:int, param4:int, param5:Array, param6:Boolean = false, param7:Boolean = true, param8:int = 1540636, param9:int = 0, param10:int = 0) : void
        {
            var _loc_11:* = null;
            _loc_11 = new AdvanceTreeeItem();
            param5[0].len = param5[0].len - this._indentation * param4;
            _loc_11.itemxml = param1;
            _loc_11.id = param2;
            _loc_11.their = param3;
            _loc_11.layer = param4;
            _loc_11.label = param5;
            _loc_11.openItems = param6;
            _loc_11.itemenabled = param7;
            _loc_11.textColor = param8;
            _loc_11.x = this._indentation * param4;
            _loc_11.sortnum = param9;
            _loc_11.sortnum2 = param10;
            this._nodearr.push(_loc_11);
            if (_loc_11.their == 0)
            {
                this._treearr.push(_loc_11);
            }
            return;
        }// end function

        public function additems(param1:XML, param2:int, param3:int, param4:int, param5:Array, param6:Boolean = false, param7:Boolean = true, param8:int = 1540636, param9:int = 0, param10:int = 0) : void
        {
            var _loc_11:* = 0;
            this.adddata(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
            if (this._nodearr[(this._nodearr.length - 1)].their != 0)
            {
                _loc_11 = 0;
                while (_loc_11 < this._nodearr.length)
                {
                    
                    if (this._nodearr[(this._nodearr.length - 1)].their == this._nodearr[_loc_11].id)
                    {
                        this._nodearr[_loc_11].itemarrpush(this._nodearr[(this._nodearr.length - 1)]);
                        break;
                    }
                    _loc_11 = _loc_11 + 1;
                }
            }
            return;
        }// end function

        private function resettree() : void
        {
            var _loc_3:* = 0;
            var _loc_1:* = 0;
            while (_loc_1 < this._nodearr.length)
            {
                
                this._nodearr[_loc_1].itemarrclear();
                _loc_1 = _loc_1 + 1;
            }
            this._nodearr.sortOn(["layer", "id"], [Array.NUMERIC, Array.NUMERIC]);
            var _loc_2:* = 0;
            while (_loc_2 < this._nodearr.length)
            {
                
                if (this._nodearr[_loc_2].their != 0)
                {
                    _loc_3 = 0;
                    while (_loc_3 < this._nodearr.length)
                    {
                        
                        if (this._nodearr[_loc_2].their == this._nodearr[_loc_3].id)
                        {
                            this._nodearr[_loc_3].itemarrpush(this._nodearr[_loc_2]);
                            break;
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function showTree(event:Event = null) : void
        {
            this.linebg.graphics.clear();
            this.addChildUI(this.linebg);
            this.resettree();
            this.itemypos = 0;
            this.linebg.graphics.lineStyle(1, 13421772, 1);
            this.linebg.graphics.moveTo(3, this.itemypos + 10);
            var _loc_2:* = 0;
            while (_loc_2 < this._treearr.length)
            {
                
                this.getnodeitem(this._treearr[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            this.linebg.graphics.moveTo(3, this.itemypos - 27 + 10);
            this.linebg.graphics.lineTo(3, 10);
            this.linebg.graphics.endFill();
            this.reFresh();
            return;
        }// end function

        public function set sortTree(param1:Boolean) : void
        {
            if (param1)
            {
                this._treearr.sortOn(["sortnum2", "sortnum"], [Array.NUMERIC, Array.NUMERIC]);
            }
            return;
        }// end function

        private function getnodeitem(param1:AdvanceTreeeItem) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            this.addChildUI(param1);
            param1.y = this.itemypos;
            this.linebg.graphics.moveTo(param1.x + 20, this.itemypos + 10);
            this.linebg.graphics.lineTo(3, this.itemypos + 10);
            this.itemypos = this.itemypos + 27;
            if (param1.openItems)
            {
                _loc_2 = 0;
                while (_loc_2 < param1.itemarr.length)
                {
                    
                    this.getnodeitem(param1.itemarr[_loc_2]);
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                _loc_3 = 0;
                while (_loc_3 < param1.itemarr.length)
                {
                    
                    this.removeitem(param1.itemarr[_loc_3]);
                    _loc_3 = _loc_3 + 1;
                }
            }
            return;
        }// end function

        private function removeitem(param1:AdvanceTreeeItem) : void
        {
            var _loc_2:* = 0;
            if (param1.parent != null)
            {
                this.removeChildUI(param1);
            }
            if (param1.itemarr.length != 0)
            {
                _loc_2 = 0;
                while (_loc_2 < param1.itemarr.length)
                {
                    
                    this.removeitem(param1.itemarr[_loc_2]);
                    _loc_2 = _loc_2 + 1;
                }
            }
            return;
        }// end function

        public function set indentation(param1:int) : void
        {
            this._indentation = param1;
            return;
        }// end function

        public function itemAllClear() : void
        {
            this.removeAllChildren();
            this._nodearr = [];
            this._treearr = [];
            this._expandItem = false;
            this.itemypos = 0;
            this.linebg.graphics.clear();
            return;
        }// end function

        private function selectitem(event:AdvanceTreeeEvent) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._nodearr.length)
            {
                
                if (this._nodearr[_loc_2].id == event.id)
                {
                    this._nodearr[_loc_2].simplelip.select = true;
                }
                else
                {
                    this._nodearr[_loc_2].simplelip.select = false;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function selectid(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < this._nodearr.length)
            {
                
                if (this._nodearr[_loc_3].id == param1)
                {
                    _loc_2 = this._nodearr[_loc_3].their;
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = 0;
            while (_loc_4 < this._nodearr.length)
            {
                
                if (this._nodearr[_loc_4].id == param1)
                {
                    this._nodearr[_loc_4].simplelip.select = true;
                }
                else
                {
                    this._nodearr[_loc_4].simplelip.select = false;
                }
                if (this._nodearr[_loc_4].id == _loc_2)
                {
                    this._nodearr[_loc_4].openItems = true;
                }
                else
                {
                    this._nodearr[_loc_4].openItems = false;
                }
                _loc_4 = _loc_4 + 1;
            }
            this.showTree();
            return;
        }// end function

    }
}
