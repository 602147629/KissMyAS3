package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.text.*;
    import lovefox.component.*;

    public class KitBardUI extends Window
    {
        private var _msgIT:RichTextField;
        private var _musicIT:Text;
        private var _ubbCB:ComboBox;
        private var _effectCB:ComboBox;
        private var _submitPB:PushButton;
        private var _testOk:Shape;
        private var _testError:Shape;
        private static var _instance:KitBardUI;

        public function KitBardUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            super(param1, param2, param3);
            this.title = Config.language("KitBardUI", 1);
            this.resize(400, 250);
            this.initUI();
            _instance = this;
            return;
        }// end function

        private function initUI()
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            _loc_2 = new Label(this, 10, 25, Config.language("KitBardUI", 2));
            _loc_3 = new Panel(this, 10, 50);
            _loc_3.setSize(380, 85);
            this._msgIT = new RichTextField(380, 85, RichTextField.INPUT);
            this._msgIT.x = 10;
            this._msgIT.y = 50;
            addChild(this._msgIT);
            this._msgIT.maxChars = 512;
            if (Config._switchEnglish)
            {
                this._msgIT._textfield.restrict = "^<>一-龥";
            }
            else
            {
                this._msgIT._textfield.restrict = "^<>";
            }
            this._msgIT._textfield.multiline = true;
            this._msgIT.textColor = 0;
            this._msgIT.placeholderColor = 0;
            var _loc_4:* = new TextFormat();
            new TextFormat().size = 12;
            _loc_4.color = Style.WINDOW_FONT;
            this._msgIT.defaultTextFormat = _loc_4;
            this._effectCB = new ComboBox(this, 320, 25);
            this._effectCB.width = 48;
            this._effectCB.rowHeight = 24;
            this._effectCB.rows = 2;
            this._effectCB.showValue = false;
            this._effectCB.label = "";
            this._effectCB.button.width = 40;
            this._effectCB.button.label = Config.language("KitBardUI", 3);
            this._effectCB.list.selectable = true;
            this._effectCB.button.x = 0;
            _loc_7 = [];
            _loc_6 = 0;
            while (_loc_6 < 4)
            {
                
                _loc_5 = GClip.newGClip("music" + (_loc_6 + 1));
                _loc_7.push({icon:_loc_5, id:_loc_6});
                _loc_6 = _loc_6 + 1;
            }
            this._effectCB.setItems(_loc_7);
            this._effectCB.selectedItem = _loc_7[0];
            this._ubbCB = new ComboBox(this, 245, 25, this.handleUbbClick);
            this._ubbCB.width = 68;
            this._ubbCB.rowHeight = 16;
            this._ubbCB.rows = 4;
            this._ubbCB.showValue = false;
            this._ubbCB.label = "";
            this._ubbCB.button.width = 40;
            this._ubbCB.button.label = Config.language("KitBardUI", 4);
            this._ubbCB.list.selectable = false;
            this._ubbCB.button.x = 30;
            _loc_7 = [];
            for (_loc_6 in Config._ubbMap)
            {
                
                _loc_5 = new Ubb("<f:" + Config._ubbMap[_loc_6].id + ">");
                _loc_5.x = 1;
                _loc_5.y = 2;
                _loc_7.push({icon:_loc_5, id:Config._ubbMap[_loc_6].id});
            }
            this._ubbCB.setItems(_loc_7);
            _loc_2 = new Label(this, 10, 140, Config.language("KitBardUI", 5));
            _loc_1 = new PushButton(this, 250, 140, Config.language("KitBardUI", 6), this.testMusic, null, "table18", "table31");
            _loc_1.textColor = Style.GOLD_FONT;
            _loc_1.width = 110;
            this._musicIT = new Text(this, 10, 165, "");
            this._musicIT.setSize(380, 40);
            if (Config._switchEnglish)
            {
                this._musicIT.tf.restrict = "^<>一-龥";
            }
            else
            {
                this._musicIT.tf.restrict = "^<>";
            }
            this._submitPB = new PushButton(this, 160, 215, Config.language("KitBardUI", 7), this.handleSubmit);
            this._submitPB.width = 80;
            this._testOk = new Shape();
            this._testOk.x = 370;
            this._testOk.y = 145;
            this._testOk.graphics.beginFill(44646, 1);
            this._testOk.graphics.moveTo(-2, 4);
            this._testOk.graphics.lineTo(3, 11);
            this._testOk.graphics.lineTo(13, -1);
            this._testOk.graphics.lineTo(3, 6);
            this._testOk.graphics.lineTo(-2, 4);
            this._testOk.graphics.endFill();
            this._testError = new Shape();
            this._testError.x = 370;
            this._testError.y = 145;
            this._testError.graphics.beginFill(14429696, 1);
            this._testError.graphics.moveTo(4, 7);
            this._testError.graphics.lineTo(-2, 2);
            this._testError.graphics.lineTo(2, -2);
            this._testError.graphics.lineTo(5, 5);
            this._testError.graphics.lineTo(9, -1);
            this._testError.graphics.lineTo(12, 3);
            this._testError.graphics.lineTo(7, 7);
            this._testError.graphics.lineTo(11, 10);
            this._testError.graphics.lineTo(8, 13);
            this._testError.graphics.lineTo(6, 8);
            this._testError.graphics.lineTo(0, 13);
            this._testError.graphics.lineTo(-2, 10);
            this._testError.graphics.lineTo(4, 7);
            this._testError.graphics.endFill();
            return;
        }// end function

        private function handleUbbClick(param1)
        {
            if (this._msgIT.length < this._msgIT.maxChars)
            {
                this._msgIT.addSprite(new Ubb("<f:" + this._ubbCB.selectedItem.id + ">"));
            }
            return;
        }// end function

        private function handleTestSuc()
        {
            if (this._testOk.parent == null)
            {
                this.addChild(this._testOk);
            }
            if (this._testError.parent != null)
            {
                this._testError.parent.removeChild(this._testError);
            }
            return;
        }// end function

        private function handleTestFail()
        {
            if (this._testError.parent == null)
            {
                this.addChild(this._testError);
            }
            if (this._testOk.parent != null)
            {
                this._testOk.parent.removeChild(this._testOk);
            }
            return;
        }// end function

        private function testMusic(param1)
        {
            Music.testMusic(this._musicIT.text, this.handleTestSuc, this.handleTestFail, true);
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open(event);
            if (this._testOk.parent != null)
            {
                this._testOk.parent.removeChild(this._testOk);
            }
            if (this._testError.parent != null)
            {
                this._testError.parent.removeChild(this._testError);
            }
            this._submitPB.enabled = true;
            return;
        }// end function

        override public function close()
        {
            super.close();
            Music.stopTestMusic();
            return;
        }// end function

        private function handleSubmit(param1)
        {
            this._submitPB.enabled = false;
            this.upload();
            return;
        }// end function

        public function upload()
        {
            if (this._msgIT.text.length < 10)
            {
                AlertUI.alert(Config.language("KitBardUI", 8), Config.language("KitBardUI", 10), [Config.language("KitBardUI", 9)]);
                return;
            }
            if (!FilterWords.chickwords(this._msgIT.ubbText))
            {
                AlertUI.alert(Config.language("KitBardUI", 8), Config.language("KitBardUI", 11), [Config.language("KitBardUI", 9)]);
                return;
            }
            var _loc_1:* = new URLVariables();
            _loc_1.server = Config.serverName;
            _loc_1.name = Player.name;
            _loc_1.account = Config.account;
            _loc_1.msg = this._msgIT.ubbText.split("\n").join("|");
            _loc_1.music = this._musicIT.text;
            _loc_1.effect = this._effectCB.selectedItem.id;
            var _loc_2:* = new URLRequest(Config.bardURL + "bard_dj.php");
            _loc_2.data = _loc_1;
            _loc_2.method = URLRequestMethod.POST;
            var _loc_3:* = new URLLoader();
            _loc_3.addEventListener(Event.COMPLETE, this.handleMoreRcv0);
            _loc_3.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleMoreError);
            _loc_3.addEventListener(IOErrorEvent.IO_ERROR, this.handleMoreError);
            _loc_3.load(_loc_2);
            return;
        }// end function

        private function handleMoreRcv0(param1)
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            this.close();
            var _loc_2:* = URLLoader(param1.target);
            _loc_2.removeEventListener(Event.COMPLETE, this.handleMoreRcv0);
            _loc_2.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleMoreError);
            _loc_2.removeEventListener(IOErrorEvent.IO_ERROR, this.handleMoreError);
            var _loc_3:* = XML(_loc_2.data);
            if (String(_loc_3.rs) == "0")
            {
                _loc_4 = new Date(Number(_loc_3.time) * 1000);
                if (String(_loc_4.minutes).length == 1)
                {
                    _loc_5 = _loc_4.hours + ":0" + _loc_4.minutes;
                }
                else
                {
                    _loc_5 = _loc_4.hours + ":" + _loc_4.minutes;
                }
                AlertUI.alert(Config.language("KitBardUI", 12), Config.language("KitBardUI", 13, _loc_5), [Config.language("KitBardUI", 14), Config.language("KitBardUI", 15)], [this.sendToChat], Config.language("KitBardUI", 24, _loc_5));
            }
            else if (String(_loc_3.rs) == "-1")
            {
                AlertUI.alert(Config.language("KitBardUI", 16), Config.language("KitBardUI", 17), [Config.language("KitBardUI", 9)]);
            }
            else if (String(_loc_3.rs) == "3")
            {
                AlertUI.alert(Config.language("KitBardUI", 18), Config.language("KitBardUI", 19), [Config.language("KitBardUI", 9)]);
            }
            else if (String(_loc_3.rs) == "1")
            {
                _loc_4 = new Date(Number(_loc_3.time) * 1000);
                if (String(_loc_4.minutes).length == 1)
                {
                    _loc_5 = _loc_4.hours + ":0" + _loc_4.minutes;
                }
                else
                {
                    _loc_5 = _loc_4.hours + ":" + _loc_4.minutes;
                }
                AlertUI.alert(Config.language("KitBardUI", 20), Config.language("KitBardUI", 21, _loc_5), [Config.language("KitBardUI", 9)]);
            }
            else if (String(_loc_3.rs) == "2")
            {
                _loc_4 = new Date(Number(_loc_3.time) * 1000);
                if (String(_loc_4.minutes).length == 1)
                {
                    _loc_5 = _loc_4.hours + ":0" + _loc_4.minutes;
                }
                else
                {
                    _loc_5 = _loc_4.hours + ":" + _loc_4.minutes;
                }
                AlertUI.alert(Config.language("KitBardUI", 20), Config.language("KitBardUI", 22, _loc_5), [Config.language("KitBardUI", 9)]);
            }
            return;
        }// end function

        private function sendToChat(param1)
        {
            Config.ui._chatUI.addText(param1);
            return;
        }// end function

        private function handleMoreError(param1)
        {
            this.close();
            var _loc_2:* = URLLoader(param1.target);
            _loc_2.removeEventListener(Event.COMPLETE, this.handleMoreRcv0);
            _loc_2.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleMoreError);
            _loc_2.removeEventListener(IOErrorEvent.IO_ERROR, this.handleMoreError);
            AlertUI.alert(Config.language("KitBardUI", 18), Config.language("KitBardUI", 23), [Config.language("KitBardUI", 9)]);
            return;
        }// end function

        public static function open()
        {
            if (_instance == null)
            {
                _instance = new KitBardUI(Config.ui._layer1);
            }
            _instance.open();
            resize();
            return;
        }// end function

        public static function close()
        {
            if (_instance != null)
            {
                _instance.close();
            }
            return;
        }// end function

        public static function resize()
        {
            if (_instance != null)
            {
                _instance.x = (Config.ui._width - _instance.width) / 2;
                _instance.y = (Config.ui._height - _instance.height) / 2;
            }
            return;
        }// end function

    }
}
