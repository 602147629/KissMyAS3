package lovefox.component
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;

    public class AdvanceTreeeItem extends Sprite
    {
        public var itemxml:XML;
        public var id:int;
        public var their:int;
        private var _openItems:Boolean = false;
        private var _itemenabled:Boolean = true;
        public var layer:int = 0;
        private var _itemarr:Array;
        public var checkbtn:PushButton;
        public var simplelip:SimplelipUI;
        public var sortnum:int = 0;
        public var sortnum2:int = 0;
        private var _textColor:int = 0;

        public function AdvanceTreeeItem()
        {
            this._itemarr = new Array();
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            this.checkbtn = new PushButton(null, 0, 3, "", this.showhiditem, Config.findUI("treeItem").button1);
            this.checkbtn.overshow = true;
            this.simplelip = new SimplelipUI(this, 13, 0, 200);
            this.simplelip.addEventListener(MouseEvent.ROLL_OUT, Config.create(this.rollfuc, 0));
            this.simplelip.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.rollfuc, 1));
            this.simplelip.addEventListener("sglClick", Config.create(this.rollfuc, 2));
            this.simplelip.addEventListener("dblClick", this.showhiditem);
            return;
        }// end function

        public function get openItems() : Boolean
        {
            return this._openItems;
        }// end function

        public function set openItems(param1:Boolean) : void
        {
            this._openItems = param1;
            if (this._openItems)
            {
                this.checkbtn.setStyle(Config.findUI("treeItem").button2);
            }
            else
            {
                this.checkbtn.setStyle(Config.findUI("treeItem").button1);
            }
            return;
        }// end function

        public function get itemarr() : Array
        {
            return this._itemarr;
        }// end function

        public function itemarrpush(param1:AdvanceTreeeItem) : void
        {
            this._itemarr.push(param1);
            this.addChild(this.checkbtn);
            return;
        }// end function

        public function itemarrclear() : void
        {
            this._itemarr = [];
            if (this.checkbtn.parent != null)
            {
                this.removeChild(this.checkbtn);
            }
            return;
        }// end function

        public function set label(param1:Array) : void
        {
            this.simplelip.label = param1;
            return;
        }// end function

        private function showhiditem(event:MouseEvent) : void
        {
            this.openItems = !this.openItems;
            this.dispatchEvent(new Event("iconcheck", true));
            return;
        }// end function

        private function rollfuc(event:MouseEvent, param2:int) : void
        {
            var _loc_3:* = null;
            if (param2 == 0)
            {
                _loc_3 = new AdvanceTreeeEvent(AdvanceTreeeEvent.ROLL_OUT_ID, true);
            }
            else if (param2 == 1)
            {
                _loc_3 = new AdvanceTreeeEvent(AdvanceTreeeEvent.ROLL_OVER_ID, true);
            }
            else if (this.itemenabled)
            {
                _loc_3 = new AdvanceTreeeEvent(AdvanceTreeeEvent.CHECK_ID, true);
            }
            if (_loc_3 != null)
            {
                _loc_3.id = this.id;
                this.dispatchEvent(_loc_3);
            }
            return;
        }// end function

        public function get itemenabled() : Boolean
        {
            return this._itemenabled;
        }// end function

        public function set itemenabled(param1:Boolean) : void
        {
            this._itemenabled = param1;
            this.simplelip.enabled = param1;
            return;
        }// end function

        public function set textColor(param1:int) : void
        {
            this.simplelip.textColor = param1;
            this._textColor = param1;
            return;
        }// end function

    }
}
