package lovefox.component
{
    import flash.display.*;
    import flash.events.*;

    public class AccordionContain extends CanvasUI
    {
        private var itemarr:Array;

        public function AccordionContain(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:Number = 200, param5:Number = 100)
        {
            this.initpanels();
            if (param1 != null)
            {
                param1.addChild(this);
            }
            width = param4;
            height = param5;
            x = param2;
            y = param3;
            this.itemarr = new Array();
            return;
        }// end function

        private function initpanels() : void
        {
            return;
        }// end function

        public function addItem(param1:int, param2:Sprite, param3:Sprite, param4:Boolean = false) : void
        {
            var _loc_5:* = {};
            {}.id = param1;
            _loc_5.title = param2;
            _loc_5.contain = param3;
            _loc_5.open = param4;
            this.itemarr.push(_loc_5);
            _loc_5.title.graphics.beginFill(12424040);
            _loc_5.title.graphics.lineStyle(1, 14007175);
            _loc_5.title.graphics.drawRoundRect(0, -5, width, _loc_5.title.height + 15, 3);
            _loc_5.title.graphics.endFill();
            _loc_5.contain.graphics.beginFill(15523521);
            _loc_5.contain.graphics.lineStyle(1, 14007175);
            _loc_5.contain.graphics.drawRoundRect(0, -5, width, _loc_5.contain.height + 5, 1);
            _loc_5.contain.graphics.endFill();
            var _loc_6:* = new Sprite();
            new Sprite().graphics.beginFill(12424040, 0);
            _loc_6.graphics.drawRoundRect(0, 0, width, _loc_5.title.height, 3);
            _loc_6.graphics.endFill();
            _loc_5.title.addChildAt(_loc_6, 0);
            _loc_6.addEventListener(MouseEvent.CLICK, Config.create(this.changeOpen, (this.itemarr.length - 1)));
            return;
        }// end function

        public function reSetShow(param1:int = -1) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < param1)
            {
                
                _loc_2 = _loc_2 + this.itemarr[_loc_3].title.height;
                if (this.itemarr[_loc_3].open)
                {
                    _loc_2 = _loc_2 + (this.itemarr[_loc_3].contain.height + 5);
                }
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = 0;
            if (param1 < 0)
            {
                _loc_4 = 0;
            }
            else
            {
                _loc_4 = param1;
            }
            var _loc_5:* = _loc_4;
            while (_loc_5 < this.itemarr.length)
            {
                
                this.addChildUI(this.itemarr[_loc_5].title);
                if (param1 == -1)
                {
                    this.itemarr[_loc_5].title.y = _loc_2;
                }
                else
                {
                    TweenLite.to(this.itemarr[_loc_5].title, 0.5, {x:this.itemarr[_loc_5].title.x, y:_loc_2});
                }
                _loc_2 = _loc_2 + this.itemarr[_loc_5].title.height;
                if (this.itemarr[_loc_5].open)
                {
                    if (param1 == -1 || this.itemarr[_loc_5].contain.parent == null)
                    {
                        this.itemarr[_loc_5].contain.y = _loc_2;
                    }
                    else
                    {
                        TweenLite.to(this.itemarr[_loc_5].contain, 0.5, {x:this.itemarr[_loc_5].contain.x, y:_loc_2});
                    }
                    this.addChildUI(this.itemarr[_loc_5].contain);
                    _loc_2 = _loc_2 + (this.itemarr[_loc_5].contain.height + 5);
                }
                else if (this.itemarr[_loc_5].contain.parent != null)
                {
                    this.removeChildUI(this.itemarr[_loc_5].contain);
                }
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        private function changeOpen(event:MouseEvent, param2:int) : void
        {
            this.itemarr[param2].open = !this.itemarr[param2].open;
            this.reSetShow(param2);
            var _loc_3:* = new AccTreeEvent(AccTreeEvent.ACCORDCONTAIN_OPEN);
            var _loc_4:* = {};
            var _loc_5:* = 0;
            while (_loc_5 < this.itemarr.length)
            {
                
                _loc_4[this.itemarr[_loc_5].id] = this.itemarr[_loc_5].open;
                _loc_5 = _loc_5 + 1;
            }
            _loc_3.typeobj = _loc_4;
            this.dispatchEvent(_loc_3);
            return;
        }// end function

        override public function removeAllChildren() : void
        {
            super.removeAllChildren();
            this.itemarr = [];
            return;
        }// end function

    }
}
