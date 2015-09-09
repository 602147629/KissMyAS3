package lovefox.component
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;

    public class AccordionTree extends CanvasUI
    {
        private var treexml:XMLList;
        private var treearr:Array;

        public function AccordionTree(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:Number = 200, param5:Number = 100)
        {
            this.treearr = new Array();
            this.initpanels();
            if (param1 != null)
            {
                param1.addChild(this);
            }
            width = param4;
            height = param5;
            x = param2;
            y = param3;
            return;
        }// end function

        private function initpanels() : void
        {
            return;
        }// end function

        public function set dataProvider(param1:XML) : void
        {
            this.treexml = param1.children();
            this.showtree();
            return;
        }// end function

        private function showtree() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            this.removeAllChildren();
            _loc_1 = 1;
            while (_loc_1 < this.treexml.length())
            {
                
                _loc_2 = new Object();
                _loc_3 = this.treexml[_loc_1].children();
                _loc_4 = new Sprite();
                _loc_2.childcontainer = _loc_4;
                _loc_2.open = false;
                _loc_5 = 0;
                while (_loc_5 < _loc_3.length())
                {
                    
                    _loc_8 = this.getchildbtn(_loc_3[_loc_5].@label);
                    _loc_4.addChild(_loc_8);
                    _loc_8.y = _loc_5 * 21;
                    _loc_8.addEventListener(MouseEvent.CLICK, this.create(this.checktree, this.treexml[_loc_1].@type, _loc_3[_loc_5].@subtype));
                    _loc_5 = _loc_5 + 1;
                }
                _loc_6 = this.treexml[_loc_1].@label;
                if (_loc_3.length() > 0)
                {
                    _loc_6 = " + " + _loc_6;
                }
                _loc_7 = this.getlistbtn(_loc_6);
                this.addChildUI(_loc_7);
                _loc_7.y = 25 * (_loc_1 - 1);
                _loc_2.listbtn = _loc_7;
                _loc_7.addEventListener(MouseEvent.CLICK, this.create(this.checktree, this.treexml[_loc_1].@type, 0));
                this.treearr.push(_loc_2);
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function getlistbtn(param1:String) : Sprite
        {
            var _loc_2:* = new Sprite();
            var _loc_3:* = new Shape();
            _loc_3.graphics.beginFill(12095576);
            _loc_3.graphics.lineStyle(1, 7164206);
            _loc_3.graphics.drawRoundRect(0, 0, this.width - 15, 20, 0);
            _loc_3.graphics.endFill();
            _loc_2.addChild(_loc_3);
            _loc_3.alpha = 0.5;
            _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.create(this.rollover, _loc_3));
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.create(this.rollout, _loc_3));
            var _loc_4:* = new Label(_loc_2, 15, 2, param1);
            return _loc_2;
        }// end function

        private function getchildbtn(param1:String) : Sprite
        {
            var _loc_2:* = new Sprite();
            var _loc_3:* = new Shape();
            _loc_3.graphics.beginFill(11967034, 0.5);
            _loc_3.graphics.drawRoundRect(0, 0, this.width - 15, 20, 0);
            _loc_3.graphics.endFill();
            _loc_3.alpha = 0.5;
            _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.create(this.rollover, _loc_3));
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.create(this.rollout, _loc_3));
            _loc_2.addChild(_loc_3);
            var _loc_4:* = new Label(_loc_2, 15, 2, param1);
            new Label(_loc_2, 15, 2, param1).textColor = 5586980;
            return _loc_2;
        }// end function

        private function rollover(event:Event, param2:Shape) : void
        {
            param2.alpha = 1;
            return;
        }// end function

        private function rollout(event:Event, param2:Shape) : void
        {
            param2.alpha = 0.5;
            return;
        }// end function

        private function checktree(event:MouseEvent, param2:int, param3:int) : void
        {
            var _loc_4:* = 0;
            trace(param2 + " " + param3);
            if (param3 == 0)
            {
                _loc_4 = 0;
                while (_loc_4 < this.treexml.length())
                {
                    
                    if (this.treexml[_loc_4].@type == param2)
                    {
                        if (this.treexml[_loc_4].children().length() > 0)
                        {
                            if (this.treearr[(_loc_4 - 1)].open)
                            {
                                trace("关闭");
                                this.treearr[(_loc_4 - 1)].open = false;
                                if (this.treearr[(_loc_4 - 1)].childcontainer.parent != null)
                                {
                                    this.removeChildUI(this.treearr[(_loc_4 - 1)].childcontainer);
                                }
                                this.changetreeshow((_loc_4 - 1));
                            }
                            else
                            {
                                trace("打开");
                                this.treearr[(_loc_4 - 1)].open = true;
                                this.addChildUI(this.treearr[(_loc_4 - 1)].childcontainer);
                                this.changetreeshow((_loc_4 - 1));
                            }
                            this.sendeve(param2, param3);
                            super.addremove();
                        }
                        else
                        {
                            this.sendeve(param2, param3);
                        }
                        break;
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            else
            {
                this.sendeve(param2, param3);
            }
            return;
        }// end function

        private function sendeve(param1:int, param2:int) : void
        {
            var _loc_3:* = new AccTreeEvent(AccTreeEvent.TREE_SELECT);
            var _loc_4:* = new Object();
            new Object().type = param1;
            _loc_4.subtype = param2;
            _loc_3.typeobj = _loc_4;
            this.dispatchEvent(_loc_3);
            return;
        }// end function

        private function changetreeshow(param1:int) : void
        {
            var _loc_2:* = param1;
            while (_loc_2 < this.treearr.length)
            {
                
                if (_loc_2 != param1)
                {
                    this.treearr[_loc_2].listbtn.y = this.getlisty(_loc_2);
                }
                this.treearr[_loc_2].childcontainer.y = this.treearr[_loc_2].listbtn.y + 22;
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function getlisty(param1:int) : Number
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < param1)
            {
                
                _loc_2 = _loc_2 + 25;
                if (this.treearr[_loc_3].open)
                {
                    _loc_2 = _loc_2 + this.treearr[_loc_3].childcontainer.height;
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
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

    }
}
