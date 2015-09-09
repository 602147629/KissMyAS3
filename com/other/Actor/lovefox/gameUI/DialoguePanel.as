package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import lovefox.component.*;

    public class DialoguePanel extends Sprite
    {
        private var container:DisplayObjectContainer;
        private var dial:TextAreaUI;
        private var mainpanel:CanvasUI;
        private var namelabel:Label;
        private var _headBmp:Bitmap;
        private var listpanel:CanvasUI;
        private var maskmc:Sprite;
        private var listypos:int = 0;

        public function DialoguePanel(param1:DisplayObjectContainer)
        {
            this.container = param1;
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_1:* = null;
            var _loc_3:* = null;
            _loc_1 = new Sprite();
            this.addChild(_loc_1);
            _loc_1.x = 60;
            _loc_1.y = 60;
            _loc_1.graphics.beginFill(0, 0.8);
            _loc_1.graphics.drawRoundRect(10, 0, 420, 130, 5);
            _loc_1.graphics.endFill();
            var _loc_2:* = new PushButton(this, 470, 64, "", this.closepanel);
            _loc_2.overshow = true;
            _loc_2.setStyle(Config.findUI("window")["closebutton"]);
            this.maskmc = new Sprite();
            this.maskmc.x = 170;
            this.maskmc.y = 190;
            this.maskmc.graphics.beginFill(4473924, 0.8);
            this.maskmc.graphics.drawRoundRect(0, 0, 320, 130, 0);
            this.maskmc.graphics.endFill();
            this.listpanel = new CanvasUI(null, 170, 197, 315, 100);
            this._headBmp = new Bitmap();
            this.addChild(this._headBmp);
            this.mainpanel = new CanvasUI(this, 180, 20, 290, 190);
            _loc_3 = new Bitmap();
            this.addChild(_loc_3);
            _loc_3.y = 130;
            _loc_3.x = -40;
            _loc_3.bitmapData = Config.findHead(-1, 222, 87);
            this.namelabel = new Label(this, 0, 160);
            return;
        }// end function

        public function open() : void
        {
            this.container.addChild(this);
            return;
        }// end function

        public function close() : void
        {
            if (this.parent != null)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

        public function showdialog(param1:int, param2:String, param3:Array, param4:DisplayObject = null, param5:Boolean = true)
        {
            var _loc_7:* = undefined;
            this.mainpanel.removeAllChildren();
            if (this._headBmp.bitmapData != null)
            {
                this._headBmp.bitmapData.dispose();
            }
            this._headBmp.bitmapData = Config.findHead(Config._npcMap[param1].portrait, 140, 160);
            if (param2 == "" && param3.length == 0)
            {
                return;
            }
            var _loc_6:* = 65;
            this.dial = new TextAreaUI(null, 0, _loc_6, 290);
            this.mainpanel.addChildUI(this.dial);
            this.dial.autoHeight = true;
            this.dial.text = param2;
            this.dial.textColor = 16777215;
            this.dial.y = (130 - this.dial.height) / 2 + 30;
            _loc_6 = _loc_6 + this.dial.height;
            if (param3.length > 0 || param4 != null)
            {
                _loc_7 = this.addlist(param3, param4);
            }
            else if (this.listpanel.parent != null)
            {
                this.removeChild(this.listpanel);
            }
            this.namelabel.html = true;
            this.namelabel.text = "<FONT SIZE=\'22\'><b>" + Config._npcMap[param1].name + "</b></FONT>";
            this.namelabel.x = (140 - this.namelabel.width) / 2;
            this.listpanel.verticalScrollPolicy = param5;
            this.open();
            return _loc_7;
        }// end function

        private function addlist(param1:Array, param2:DisplayObject = null)
        {
            var _loc_6:* = null;
            this.listpanel.removeAllChildren();
            this.listpanel.graphics.clear();
            this.addChild(this.listpanel);
            var _loc_3:* = [];
            var _loc_4:* = 0;
            while (_loc_4 < param1.length)
            {
                
                _loc_6 = new ClickLabel(null, 10, _loc_4 * 25, param1[_loc_4].label, param1[_loc_4].handler, true);
                _loc_3.push(_loc_6);
                this.listpanel.addChildUI(_loc_6);
                _loc_6.clickColor([16776960, 13408512]);
                if (GuideUI.testId(142))
                {
                    if (param1[_loc_4].label == Config.language("TaskPanel", 98))
                    {
                        GuideUI.doId(142, _loc_6);
                    }
                }
                if (param1[_loc_4].hasOwnProperty("closeflag"))
                {
                    if (param1[_loc_4].closeflag)
                    {
                        _loc_6.addEventListener(MouseEvent.CLICK, this.closepanel);
                    }
                }
                _loc_4 = _loc_4 + 1;
            }
            var _loc_5:* = 0;
            if (param2 != null)
            {
                this.listpanel.addChildUI(param2);
                _loc_5 = param2.height + 10;
            }
            if (param1.length > 0)
            {
                if (param1.length <= 5)
                {
                    _loc_5 = _loc_5 + 25 * param1.length;
                }
                else
                {
                    _loc_5 = _loc_5 + (25 * 5 + 10);
                }
            }
            this.listpanel.height = _loc_5;
            this.listpanel.graphics.beginFill(0, 0.8);
            this.listpanel.graphics.drawRoundRect(0, -5, 320, _loc_5 + 10, 7);
            this.listpanel.graphics.endFill();
            this.listpanel.reFresh();
            this.listypos = this.listpanel.height;
            return _loc_3;
        }// end function

        private function closepanel(event:MouseEvent = null) : void
        {
            this.close();
            this.mainpanel.removeAllChildren();
            if (this.listpanel.parent != null)
            {
                this.removeChild(this.listpanel);
            }
            return;
        }// end function

        private function removeallchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        public function closedialogue() : void
        {
            if (this != null)
            {
                if (this.parent != null)
                {
                    this.close();
                }
            }
            return;
        }// end function

    }
}
