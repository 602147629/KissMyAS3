package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.net.*;
    import flash.text.*;

    public class KitReplayWindow extends Panel
    {
        private var _url:String;
        private var _title:String;
        private var _titleTxt:TextField;
        private var _infoTxt:TextField;
        private var _loader:Loader;
        private var _nodeArray:Array;
        private var _nodeIndex:int = -1;

        public function KitReplayWindow(param1, param2, param3:DisplayObjectContainer = null, param4:Number = 0, param5:Number = 0)
        {
            this._nodeArray = [];
            super(param3, param4, param5);
            this._url = param1;
            this._title = param2;
            this.initUI();
            return;
        }// end function

        public function reload()
        {
            var _loc_1:* = new URLRequest(Config.replayURL + this._url);
            var _loc_2:* = new URLLoader();
            _loc_2.addEventListener(Event.COMPLETE, this.handleMoreRcv0);
            _loc_2.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleMoreError);
            _loc_2.addEventListener(IOErrorEvent.IO_ERROR, this.handleMoreError);
            _loc_2.load(_loc_1);
            return;
        }// end function

        private function handleMoreRcv0(param1)
        {
            var _loc_4:* = undefined;
            var _loc_2:* = URLLoader(param1.target);
            _loc_2.removeEventListener(Event.COMPLETE, this.handleMoreRcv0);
            _loc_2.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleMoreError);
            _loc_2.removeEventListener(IOErrorEvent.IO_ERROR, this.handleMoreError);
            var _loc_3:* = XML(_loc_2.data);
            this._nodeArray = [];
            this._nodeIndex = -1;
            if (_loc_3.hasOwnProperty("list") && _loc_3.list.length() > 0)
            {
                _loc_4 = 0;
                while (_loc_4 < _loc_3.list.length())
                {
                    
                    this._nodeArray.push(_loc_3.list[_loc_4]);
                    _loc_4 = _loc_4 + 1;
                }
            }
            this.setNode(0);
            return;
        }// end function

        private function handleMouseMove(param1)
        {
            if (this.mouseX < 20)
            {
                this.setNode(3);
            }
            else if (this.mouseX < 45)
            {
                this.setNode(1);
            }
            else if (this.mouseX < 70)
            {
                this.setNode(0);
            }
            else if (this.mouseX < 100)
            {
                this.setNode(2);
            }
            else
            {
                this.setNode(4);
            }
            return;
        }// end function

        private function setNode(param1)
        {
            if (this._nodeIndex != param1)
            {
                if (this._nodeArray[param1] != null)
                {
                    this._nodeIndex = param1;
                    this._titleTxt.text = this._title + "(" + (this._nodeIndex + 1) + "/5)";
                    this.setDisplay(this._nodeArray[this._nodeIndex]);
                }
            }
            return;
        }// end function

        private function setDisplay(param1)
        {
            this._infoTxt.text = param1.title;
            var _loc_2:* = new URLVariables();
            _loc_2.id = Number(param1.id);
            var _loc_3:* = new URLRequest(Config.replayURL + "replay_get_thumb.php");
            _loc_3.data = _loc_2;
            _loc_3.method = URLRequestMethod.POST;
            var _loc_4:* = new URLLoader();
            new URLLoader().dataFormat = URLLoaderDataFormat.BINARY;
            _loc_4.addEventListener(IOErrorEvent.IO_ERROR, this.handleMoreError);
            _loc_4.addEventListener(Event.COMPLETE, this.handlePicComplete0);
            _loc_4.load(_loc_3);
            return;
        }// end function

        private function handlePicComplete0(param1)
        {
            var event:* = param1;
            var loader:* = URLLoader(event.target);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, this.handleMoreError);
            loader.removeEventListener(Event.COMPLETE, this.handlePicComplete0);
            this._loader.unload();
            try
            {
                this._loader.loadBytes(event.target.data);
            }
            catch (e)
            {
            }
            return;
        }// end function

        private function handleMoreError(param1)
        {
            var _loc_2:* = URLLoader(param1.target);
            _loc_2.removeEventListener(Event.COMPLETE, this.handlePicComplete0);
            _loc_2.removeEventListener(Event.COMPLETE, this.handleMoreRcv0);
            _loc_2.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleMoreError);
            _loc_2.removeEventListener(IOErrorEvent.IO_ERROR, this.handleMoreError);
            return;
        }// end function

        private function initUI()
        {
            this.buttonMode = true;
            this.roundCorner = 7;
            this.borderColor = 8410936;
            var _loc_4:* = 16709562;
            this.bgColor = 16709562;
            this.color = _loc_4;
            setSize(120, 110);
            this._titleTxt = Config.getSimpleTextField();
            this._titleTxt.autoSize = TextFieldAutoSize.CENTER;
            this._titleTxt.x = 60;
            this._titleTxt.textColor = Style.WINDOW_FONT;
            this._titleTxt.text = this._title;
            this.addChild(this._titleTxt);
            var _loc_1:* = new Sprite();
            this.addChild(_loc_1);
            this._loader = new Loader();
            this._loader.y = 20;
            _loc_1.addChild(this._loader);
            var _loc_2:* = new Shape();
            _loc_2.graphics.beginFill(0, 0.8);
            _loc_2.graphics.drawRect(0, 0, 120, 20);
            _loc_2.graphics.endFill();
            _loc_2.y = 90;
            _loc_1.addChild(_loc_2);
            this._infoTxt = Config.getSimpleTextField();
            this._infoTxt.autoSize = TextFieldAutoSize.CENTER;
            this._infoTxt.x = 60;
            this._infoTxt.y = 90;
            this._infoTxt.textColor = Style.WHITE_FONT;
            _loc_1.addChild(this._infoTxt);
            var _loc_3:* = new Shape();
            _loc_3.graphics.beginFill(16711680, 1);
            _loc_3.graphics.drawRoundRect(1, 1, _width - 2, _height - 2, 7);
            _loc_3.graphics.endFill();
            this.addChild(_loc_3);
            _loc_1.mask = _loc_3;
            this.addEventListener(MouseEvent.CLICK, this.handleClick);
            this.addEventListener(MouseEvent.ROLL_OVER, this.handleLabelRollOver);
            this.addEventListener(MouseEvent.ROLL_OUT, this.handleLabelRollOut);
            return;
        }// end function

        private function handleClick(param1)
        {
            var _loc_2:* = null;
            if (this._nodeArray[this._nodeIndex] != null)
            {
                _loc_2 = new URLRequest(String(this._nodeArray[this._nodeIndex].url));
                navigateToURL(_loc_2, "_blank");
            }
            ComboBox(parent).innerClose();
            return;
        }// end function

        private function handleLabelRollOver(param1)
        {
            this.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove);
            this.addEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove);
            this.color = Style.SELECTED_ITEM;
            return;
        }// end function

        public function close()
        {
            this.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove);
            if (parent != null)
            {
                parent.removeChild(this);
            }
            return;
        }// end function

        private function handleLabelRollOut(param1)
        {
            this.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove);
            this.color = 16709562;
            return;
        }// end function

    }
}
