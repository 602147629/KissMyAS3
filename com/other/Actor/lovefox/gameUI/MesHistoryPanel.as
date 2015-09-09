package lovefox.gameUI
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import lovefox.component.*;
    import lovefox.gui.*;

    public class MesHistoryPanel extends Window
    {
        private var listArr:Array;
        private var maxLen:int = 100;
        private var mesCanvas:CanvasUI;
        private var mesText:TextAreaUI;
        private var position:int = 0;
        private var smallPanel:Sprite;
        private var eventIcon:Bitmap;
        private var playerIcon:Bitmap;
        private var p1:BitmapData;
        private var p2:BitmapData;
        private var t3:Sprite;

        public function MesHistoryPanel(param1:DisplayObjectContainer = null)
        {
            this.listArr = [];
            super(param1);
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            resize(420, 300);
            this.title = Config.language("MesHistoryPanel", 1);
            this.mesCanvas = new CanvasUI(this, 10, 25, 400, 260);
            this.mesText = new TextAreaUI(null, 0, 0, 400, 260);
            this.mesText.autoHeight = true;
            this.mesText.mytext.selectable = true;
            this.mesCanvas.addChildUI(this.mesText);
            this.smallPanel = new Sprite();
            var _loc_1:* = new Sprite();
            _loc_1.buttonMode = true;
            var _loc_2:* = new Sprite();
            _loc_2.buttonMode = true;
            this.t3 = new Sprite();
            this.t3.buttonMode = true;
            _loc_1.y = 34;
            _loc_2.y = 17;
            this.smallPanel.addChild(_loc_1);
            this.smallPanel.addChild(_loc_2);
            this.smallPanel.addChild(this.t3);
            this.eventIcon = new Bitmap();
            _loc_1.addChild(this.eventIcon);
            this.playerIcon = new Bitmap();
            _loc_2.addChild(this.playerIcon);
            _loc_1.addEventListener(MouseEvent.ROLL_OUT, this.iconOut);
            _loc_1.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.iconOver, 1));
            _loc_1.addEventListener(MouseEvent.CLICK, this.showThisPanel);
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.iconOut);
            _loc_2.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.iconOver, 2));
            _loc_2.addEventListener(MouseEvent.CLICK, this.showHidePlayer);
            this.p1 = BitmapLoader.pick(String(Config.findUI("history").p1.dir));
            this.p2 = BitmapLoader.pick(String(Config.findUI("history").p2.dir));
            this.eventIcon.bitmapData = BitmapLoader.pick(String(Config.findUI("history").ev.dir));
            this.playerIcon.bitmapData = this.p1;
            var _loc_3:* = GClip.newGClip("rose");
            _loc_3.mouseChildren = true;
            _loc_3.mouseEnabled = true;
            this.t3.addChild(_loc_3);
            this.t3.addEventListener(MouseEvent.CLICK, this.openresive);
            this.t3.visible = false;
            Config.ui._layer1.addChild(this.smallPanel);
            this.smallPanel.x = Config.stage.stageWidth - 30;
            this.smallPanel.y = Config.stage.stageHeight - 110;
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            this.showMessage();
            return;
        }// end function

        public function resetXY(param1:int, param2:int) : void
        {
            this.smallPanel.x = param1 - 30;
            this.smallPanel.y = param2 - 100;
            return;
        }// end function

        public function addHistory(param1:String) : void
        {
            var _loc_2:* = Config.now;
            this.listArr.splice(0, 0, "<font size=\'12\' color=\'#481008\'>" + param1 + "</font>" + "  [ " + _loc_2.getHours() + ":" + _loc_2.getMinutes() + ":" + _loc_2.getSeconds() + "  " + (_loc_2.getMonth() + 1) + "-" + _loc_2.getDate() + " ]");
            if (this.listArr.length > this.maxLen)
            {
                this.listArr.length = this.maxLen;
            }
            if (this.stage != null)
            {
                this.showMessage();
            }
            else
            {
                var _loc_3:* = this;
                var _loc_4:* = this.position + 1;
                _loc_3.position = _loc_4;
            }
            return;
        }// end function

        private function showMessage() : void
        {
            var _loc_1:* = "";
            var _loc_2:* = 0;
            while (_loc_2 < this.listArr.length)
            {
                
                _loc_1 = _loc_1 + (this.listArr[_loc_2] + "\n");
                _loc_2 = _loc_2 + 1;
            }
            if (_loc_1.length > 0)
            {
                this.mesText.text = _loc_1;
            }
            else
            {
                this.mesText.text = Config.language("MesHistoryPanel", 2);
            }
            this.mesCanvas.reFresh();
            return;
        }// end function

        private function iconOver(event:Event, param2:int) : void
        {
            var _loc_3:* = null;
            if (param2 == 2)
            {
                if (Unit.otherVisible)
                {
                    _loc_3 = Config.language("MesHistoryPanel", 3);
                }
                else
                {
                    _loc_3 = Config.language("MesHistoryPanel", 4);
                }
            }
            else
            {
                _loc_3 = Config.language("MesHistoryPanel", 5);
            }
            var _loc_4:* = event.currentTarget;
            var _loc_5:* = event.currentTarget.parent.localToGlobal(new Point(_loc_4.x, _loc_4.y));
            Holder.showInfo(_loc_3, new Rectangle(_loc_5.x, _loc_5.y, 20, 20), true, 0, 220);
            event.currentTarget.filters = [Style.GREENLIGHT];
            return;
        }// end function

        private function iconOut(event:Event)
        {
            Holder.closeInfo();
            event.currentTarget.filters = [];
            return;
        }// end function

        private function showThisPanel(event:MouseEvent) : void
        {
            this.switchOpen();
            return;
        }// end function

        private function showHidePlayer(event:MouseEvent) : void
        {
            Unit.otherVisible = !Unit.otherVisible;
            return;
        }// end function

        public function setShowHide() : void
        {
            if (Unit.otherVisible)
            {
                this.playerIcon.bitmapData = this.p1;
            }
            else
            {
                this.playerIcon.bitmapData = this.p2;
            }
            return;
        }// end function

        public function showicon() : void
        {
            this.t3.visible = true;
            return;
        }// end function

        public function hideicon() : void
        {
            this.t3.visible = false;
            return;
        }// end function

        public function openresive(event:MouseEvent = null) : void
        {
            Config.ui._giveflower.openalert();
            return;
        }// end function

    }
}
