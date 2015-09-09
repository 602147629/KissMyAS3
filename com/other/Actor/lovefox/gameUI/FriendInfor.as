package lovefox.gameUI
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import lovefox.gui.*;

    public class FriendInfor extends Sprite
    {
        private var panelbg:Shape;
        private var friendname:TextField;
        private var online:TextField;
        private var delfriendbtn:CustomButton;
        private var friendid:int;
        private var _friendname:String;

        public function FriendInfor(param1:Object)
        {
            this.initpanel(param1);
            return;
        }// end function

        private function initpanel(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.panelbg = new Shape();
            addChild(this.panelbg);
            this.friendname = Config.getSimpleTextField();
            this.addChild(this.friendname);
            this.friendname.x = 10;
            this.friendname.y = 10;
            this.friendname.text = param1.name;
            this.online = Config.getSimpleTextField();
            this.addChild(this.online);
            this.online.x = 10;
            this.online.y = 40;
            if (String(param1.online) == "1")
            {
                this.online.text = Config.language("FriendInfor", 1);
            }
            else
            {
                this.online.text = Config.language("FriendInfor", 2);
            }
            this.friendid = param1.id;
            this._friendname = param1.name;
            if (param1.type == 1)
            {
                this.delfriendbtn = new CustomButton();
                this.delfriendbtn.label = Config.language("FriendInfor", 3);
                this.addChild(this.delfriendbtn);
                this.delfriendbtn.addEventListener(MouseEvent.CLICK, this.delevent);
                this.delfriendbtn.x = 10;
                this.delfriendbtn.y = 60;
                _loc_3 = new CustomButton();
                _loc_3.label = Config.language("FriendInfor", 4);
                this.addChild(_loc_3);
                _loc_3.addEventListener(MouseEvent.CLICK, this.addblack);
                _loc_3.x = 10;
                _loc_3.y = 80;
            }
            else
            {
                _loc_4 = new CustomButton();
                _loc_4.label = Config.language("FriendInfor", 5);
                this.addChild(_loc_4);
                _loc_4.addEventListener(MouseEvent.CLICK, this.delblack);
                _loc_4.x = 10;
                _loc_4.y = 60;
            }
            var _loc_2:* = new CustomButton();
            _loc_2.label = Config.language("FriendInfor", 6);
            this.addChild(_loc_2);
            _loc_2.addEventListener(MouseEvent.CLICK, this.close);
            _loc_2.x = 10;
            _loc_2.y = 100;
            this.resize(200, 120);
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.startmove);
            this.addEventListener(MouseEvent.MOUSE_UP, this.stopmove);
            return;
        }// end function

        public function resize(param1:Number, param2:Number) : void
        {
            this.panelbg.graphics.clear();
            this.panelbg.graphics.lineStyle(0, 0, 0);
            this.panelbg.graphics.beginFill(0, 0.6);
            this.panelbg.graphics.drawRoundRect(4, 2, param1 - 8, param2 - 5, 10, 10);
            this.panelbg.graphics.endFill();
            return;
        }// end function

        public function close(event:MouseEvent = null) : void
        {
            if (this.parent != null)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

        private function delevent(event:MouseEvent) : void
        {
            var _loc_2:* = new FriendEvent(FriendEvent.DEL_FRIEND);
            _loc_2.inum = this.friendid;
            this.dispatchEvent(_loc_2);
            this.close();
            return;
        }// end function

        private function addblack(event:MouseEvent) : void
        {
            var _loc_2:* = new FriendEvent(FriendEvent.ADD_BLACK);
            _loc_2.sendname = this._friendname;
            this.dispatchEvent(_loc_2);
            this.close();
            return;
        }// end function

        private function delblack(event:MouseEvent) : void
        {
            var _loc_2:* = new FriendEvent(FriendEvent.DEL_BLACK);
            _loc_2.inum = this.friendid;
            this.dispatchEvent(_loc_2);
            this.close();
            return;
        }// end function

        private function startmove(event:MouseEvent) : void
        {
            this.startDrag();
            return;
        }// end function

        private function stopmove(event:MouseEvent) : void
        {
            this.stopDrag();
            return;
        }// end function

    }
}
