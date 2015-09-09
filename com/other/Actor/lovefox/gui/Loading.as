package lovefox.gui
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import lovefox.buffer.*;

    public class Loading extends Sprite
    {
        public static var _loading:Loading;
        private static var _progressBar:ProgressBar;
        private static var _width:Object;
        private static var _height:Object;
        private static var _bg:Bitmap;
        private static var _bgBmpd:BitmapData;
        private static var _barBmpd:BitmapData;
        private static var _bgBG:Sprite;
        private static var _bar:Bitmap;
        private static var _barMask:Shape;
        private static var _bgURL:Object;
        private static var _infoLB1:TextField;
        private static var _noticeCount:Object = 0;
        private static var _noticeSpMap:Object = {};
        private static var _noticeArray:Array = [];
        private static var _noticeLayer:Sprite;
        private static var _noticeContentArray:Array = [];
        private static var _picArr:Array = [];
        private static var _picBmpd:BitmapData;
        private static var _opening:Boolean = false;

        public function Loading()
        {
            graphics.clear();
            graphics.lineStyle(0, 0, 0);
            graphics.beginFill(0);
            graphics.drawRect(0, 0, Config.stage.stageWidth, Config.stage.stageHeight);
            graphics.endFill();
            _progressBar = new ProgressBar(this, 5, _height - 20);
            _progressBar.width = _width - 10;
            _progressBar.height = 16;
            _progressBar.color = 563443;
            _progressBar.gradientFillDirection = 0;
            _progressBar.subColor = 12320767;
            _infoLB1 = Config.getSimpleTextField();
            _infoLB1.textColor = Style.WINDOW_FONT;
            _infoLB1.filters = [new GlowFilter(0, 1, 3, 3, 1, 3)];
            _infoLB1.x = int((_width - _infoLB1.width) / 2);
            _infoLB1.y = _progressBar.y - 1;
            addChild(_progressBar);
            addChild(_infoLB1);
            _noticeLayer = new Sprite();
            _noticeLayer.mouseChildren = false;
            _noticeLayer.mouseEnabled = false;
            _noticeLayer.filters = [new GlowFilter(Style.WHITE_FONT, 1, 1.2, 1.2, 3), new GlowFilter(0, 1, 2, 2, 10), new DropShadowFilter(4, 45, 0, 0.5)];
            addChild(_noticeLayer);
            _bgBG = new Sprite();
            _bgBG.blendMode = BlendMode.LAYER;
            addChild(_bgBG);
            _bg = new Bitmap();
            _bgBG.addChild(_bg);
            return;
        }// end function

        public function destroy()
        {
            Config.stage.removeChild(this);
            return;
        }// end function

        public function loadPic(param1)
        {
            _bgURL = param1;
            var _loc_2:* = BitmapLoader.newBitmapLoader();
            _loc_2.addEventListener("complete", this.handleLoadComplete);
            if (_barBmpd == null)
            {
                _loc_2.load([_bgURL, "stuff/pic/loading/bar.png"]);
            }
            else
            {
                _loc_2.load([_bgURL]);
            }
            return;
        }// end function

        private function handleLoadComplete(param1)
        {
            param1.target.removeEventListener("complete", this.handleLoadComplete);
            if (_bgBmpd != null)
            {
                _bgBmpd.dispose();
            }
            _bgBmpd = BitmapLoader.pick(_bgURL);
            _bg.bitmapData = _bgBmpd;
            if (_barBmpd == null)
            {
                _barBmpd = BitmapLoader.pick("stuff/pic/loading/bar.png");
                _bar = new Bitmap(_barBmpd);
                addChild(_bar);
                _barMask = new Shape();
                _barMask.graphics.beginFill(0, 1);
                _barMask.graphics.drawRect(0, 0, _barBmpd.width, _barBmpd.height);
                _barMask.graphics.endFill();
                addChild(_barMask);
                _bar.mask = _barMask;
            }
            if (_infoLB1.parent != null)
            {
                _infoLB1.parent.removeChild(_infoLB1);
            }
            addChild(_noticeLayer);
            resize(_width, _height);
            dispatchEvent(new Event("complete"));
            return;
        }// end function

        public function loadPicTitle(param1)
        {
            _bgURL = param1;
            var _loc_2:* = BitmapLoader.newBitmapLoader();
            _loc_2.addEventListener("complete", this.handleLoadCompleteTitle);
            _loc_2.load([_bgURL]);
            return;
        }// end function

        private function handleLoadCompleteTitle(param1)
        {
            param1.target.removeEventListener("complete", this.handleLoadComplete);
            if (_bgBmpd != null)
            {
                _bgBmpd.dispose();
            }
            _bgBmpd = BitmapLoader.pick(_bgURL);
            _bg.bitmapData = _bgBmpd;
            addChild(_progressBar);
            addChild(_infoLB1);
            addChild(_noticeLayer);
            resize(_width, _height);
            dispatchEvent(new Event("complete"));
            return;
        }// end function

        public static function open()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (_opening)
            {
                return;
            }
            _opening = true;
            if (_loading == null)
            {
                _loading = new Loading;
            }
            setProgress(0, 1);
            Config.stopLoop(closeLoop);
            if (_loading.alpha < 1)
            {
                _loading.alpha = 1;
            }
            Config.stage.addChild(_loading);
            if (_noticeContentArray.length == 0)
            {
                for (_loc_1 in Config._loadingTipMap)
                {
                    
                    if (Number(Config._loadingTipMap[_loc_1].open) == 0)
                    {
                        _noticeContentArray.push(String(Config._loadingTipMap[_loc_1].content));
                        if (Number(Config._loadingTipMap[_loc_1].sp) != 0)
                        {
                            if (_noticeSpMap[Number(Config._loadingTipMap[_loc_1].sp)] == null)
                            {
                                _noticeSpMap[Number(Config._loadingTipMap[_loc_1].sp)] = [];
                            }
                            _noticeSpMap[Number(Config._loadingTipMap[_loc_1].sp)].push(String(Config._loadingTipMap[_loc_1].content));
                        }
                    }
                }
            }
            if (_noticeContentArray.length > 0)
            {
                _loc_1 = 0;
                while (_loc_1 < _noticeArray.length)
                {
                    
                    _noticeLayer.removeChild(_noticeArray[_loc_1]);
                    _loc_1 = _loc_1 + 1;
                }
                _noticeArray = [];
                if (Config._firstInGameSession)
                {
                    _loc_2 = _noticeSpMap[1][Math.floor(_noticeSpMap[1].length * Math.random())];
                }
                else if (!GuideUI.getAct(255) && Config.map.id == 335)
                {
                    _loc_2 = _noticeSpMap[2][Math.floor(_noticeSpMap[2].length * Math.random())];
                    GuideUI.setAct(255);
                }
                else if (Config.map.id == 336)
                {
                    _loc_2 = _noticeSpMap[3][Math.floor(_noticeSpMap[3].length * Math.random())];
                }
                else if (Config.map.id == 352 || Config.map.id == 396 || Config.map.id == 427 || Config.map.id == 433)
                {
                    _loc_2 = _noticeSpMap[4][Math.floor(_noticeSpMap[4].length * Math.random())];
                }
                else
                {
                    _loc_2 = _noticeContentArray[Math.floor(_noticeContentArray.length * Math.random())];
                }
                _loc_3 = _loc_2.split("");
                if (_loc_2.length <= 12)
                {
                    _loc_4 = 24;
                }
                else if (_loc_2.length <= 24)
                {
                    _loc_4 = 20;
                }
                else
                {
                    _loc_4 = 16;
                }
                _loc_5 = 0;
                _loc_1 = 0;
                while (_loc_1 < _loc_3.length)
                {
                    
                    _noticeArray[_loc_1] = Config.getSimpleTextField();
                    _noticeLayer.addChild(_noticeArray[_loc_1]);
                    _noticeArray[_loc_1].htmlText = "<font size=\'" + _loc_4 + "\'>" + _loc_3[_loc_1] + "</font>";
                    _noticeArray[_loc_1].x = _loc_5;
                    _noticeArray[_loc_1].textColor = Style.WHITE_FONT;
                    _loc_5 = _loc_5 + _noticeArray[_loc_1].width;
                    _loc_1 = _loc_1 + 1;
                }
                _noticeCount = -8;
                _noticeLayer.x = (Config.stage.stageWidth - _noticeLayer.width) / 2;
                _noticeLayer.y = Config.stage.stageHeight / 2 + 200;
                Config.startLoop(noticeEnterFrame);
            }
            return;
        }// end function

        private static function noticeEnterFrame(param1)
        {
            var _loc_4:* = undefined;
            var _loc_7:* = undefined;
            var _loc_2:* = 8;
            var _loc_3:* = 16;
            var _loc_5:* = Math.floor((_noticeCount - _loc_3) / _loc_2) - 1;
            var _loc_6:* = Math.ceil((_noticeCount + _loc_3) / _loc_2) + 1;
            _loc_4 = Math.max(0, _loc_5);
            while (_loc_4 < Math.min(_loc_6, _noticeArray.length))
            {
                
                _loc_7 = (_loc_4 * _loc_2 - _noticeCount) / _loc_3;
                if (_loc_7 > -1 && _loc_7 < 1)
                {
                    _noticeArray[_loc_4].y = -Math.abs(Math.cos(_loc_7 * Math.PI / 2) * 10);
                }
                else
                {
                    _noticeArray[_loc_4].y = 0;
                }
                _loc_4 = _loc_4 + 1;
            }
            _noticeCount = _noticeCount + 3;
            if (_noticeCount > _noticeArray.length * _loc_2 + _loc_3 / 2)
            {
                _noticeCount = (-_loc_3) / 2;
            }
            return;
        }// end function

        public static function close(param1 = false)
        {
            var _loc_2:* = undefined;
            if (_loading != null)
            {
                _opening = false;
                Config.stopLoop(closeLoop);
                if (param1)
                {
                    Config.startLoop(closeLoop);
                }
                else if (_loading.parent == Config.stage)
                {
                    Config.stage.removeChild(_loading);
                    setNextPic();
                }
            }
            Config.stopLoop(noticeEnterFrame);
            _loc_2 = 0;
            while (_loc_2 < _noticeArray.length)
            {
                
                _noticeLayer.removeChild(_noticeArray[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            _noticeArray = [];
            return;
        }// end function

        private static function closeLoop(param1)
        {
            _loading.alpha = _loading.alpha - 0.1;
            if (_loading.alpha <= 0)
            {
                if (_loading.parent == Config.stage)
                {
                    Config.stage.removeChild(_loading);
                }
                Config.stopLoop(closeLoop);
                setNextPic();
            }
            return;
        }// end function

        public static function setProgress(param1, param2)
        {
            var _loc_3:* = false;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = null;
            if (_loading != null)
            {
                _loc_3 = false;
                if (_bgURL == "stuff/pic/loading/1.jpg" || _bgURL == "stuff/pic/loading/2.jpg" || _bgURL == "stuff/pic/loading/3.jpg")
                {
                    _loc_3 = true;
                }
                if (!_loc_3)
                {
                    _loc_4 = param1 / param2;
                    _loc_5 = _loc_4 * 200;
                    _loc_6 = Math.floor((_loc_5 - 20) / _loc_5 * 255);
                    _loc_7 = GradientType.RADIAL;
                    _loc_8 = [16711680, 16711680];
                    _loc_9 = [1, 0];
                    _loc_10 = [_loc_6, 255];
                    _loc_11 = new Matrix();
                    _loc_12 = int((-_loc_5) / 2);
                    _loc_13 = 2;
                    _loc_14 = int((-_loc_13) / 2);
                    _loc_11.createGradientBox(_loc_5, _loc_13, 0, _loc_12, _loc_14);
                    _loc_15 = SpreadMethod.PAD;
                    _progressBar.value = _loc_4;
                    _infoLB1.text = "Loading " + int(_loc_4 * 100) + " %";
                    _infoLB1.x = int((_width - _infoLB1.width) / 2);
                }
                else
                {
                    _barMask.scaleX = param1 / param2;
                }
            }
            return;
        }// end function

        public static function resize(param1, param2)
        {
            var _loc_3:* = false;
            _width = param1;
            _height = param2;
            if (_loading != null)
            {
                _loading.graphics.clear();
                _loading.graphics.lineStyle(0, 0, 0);
                _loading.graphics.beginFill(0);
                _loading.graphics.drawRect(0, 0, param1, param2);
                if (_bgBmpd != null)
                {
                    _bg.x = Math.floor((param1 - _bgBmpd.width) / 2);
                    _bg.y = Math.floor((param2 - _bgBmpd.height) / 2);
                    _bgBG.graphics.clear();
                    _bgBG.graphics.lineStyle(0, 0, 0);
                    _bgBG.graphics.beginFill(_bgBmpd.getPixel(0, 0));
                    _bgBG.graphics.drawRect(0, 0, param1, param2);
                    _bgBG.graphics.endFill();
                }
                _loc_3 = false;
                if (_bgURL == "stuff/pic/loading/1.jpg" || _bgURL == "stuff/pic/loading/2.jpg" || _bgURL == "stuff/pic/loading/3.jpg")
                {
                    _loc_3 = true;
                }
                if (!_loc_3)
                {
                    if (_bar != null && _bar.parent != null)
                    {
                        _bar.parent.removeChild(_bar);
                    }
                    _loading.addChild(_progressBar);
                    if (_barBmpd == null)
                    {
                        _loading.addChild(_infoLB1);
                    }
                    _loading.addChild(_noticeLayer);
                    _progressBar.x = 5;
                    _progressBar.width = param1 - 10;
                    _progressBar.y = param2 - 20;
                    _infoLB1.x = int((_width - _infoLB1.width) / 2);
                    _infoLB1.y = _progressBar.y - 1;
                }
                else
                {
                    if (_progressBar.parent != null)
                    {
                        _progressBar.graphics.clear();
                        _progressBar.parent.removeChild(_progressBar);
                    }
                    if (_infoLB1.parent != null)
                    {
                        _infoLB1.parent.removeChild(_infoLB1);
                    }
                    _loading.addChild(_bar);
                    _loading.addChild(_noticeLayer);
                    var _loc_4:* = 74 + _bg.x;
                    _barMask.x = 74 + _bg.x;
                    _bar.x = _loc_4;
                    var _loc_4:* = 346 + _bg.y;
                    _barMask.y = 346 + _bg.y;
                    _bar.y = _loc_4;
                }
                _noticeLayer.x = (Config.stage.stageWidth - _noticeLayer.width) / 2;
                _noticeLayer.y = Config.stage.stageHeight / 2 + 200;
            }
            return;
        }// end function

        public static function addPic(param1)
        {
            var _loc_2:* = undefined;
            _loc_2 = 0;
            while (_loc_2 < _picArr.length)
            {
                
                if (_picArr[_loc_2] == param1)
                {
                    return;
                }
                _loc_2 = _loc_2 + 1;
            }
            _picArr.push(param1);
            return;
        }// end function

        public static function buffAllPic()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = [];
            _loc_1 = 1;
            while (_loc_1 < (Config._switchLoadingNumber + 1))
            {
                
                _loc_3 = true;
                _loc_2 = 0;
                while (_loc_2 < _picArr.length)
                {
                    
                    if (_picArr[_loc_2] == "stuff/pic/loading/" + _loc_1 + ".jpg")
                    {
                        _loc_3 = false;
                        break;
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (_loc_3)
                {
                    _loc_4.push("stuff/pic/loading/" + _loc_1 + ".jpg");
                }
                _loc_1 = _loc_1 + 1;
            }
            var _loc_5:* = BitmapLoader.newBitmapLoader();
            BitmapLoader.newBitmapLoader().addEventListener("complete", handleBuffComplete);
            _loc_5.load(_loc_4);
            return;
        }// end function

        private static function handleBuffComplete(param1)
        {
            var _loc_3:* = undefined;
            param1.target.removeEventListener("complete", handleBuffComplete);
            var _loc_2:* = param1.target._urlArray;
            _loc_3 = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                addPic(_loc_2[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public static function setNextPic()
        {
            var _loc_1:* = null;
            var _loc_2:* = undefined;
            if (_picArr.length > 0)
            {
                if (_bgURL == null || _picArr.length == 1)
                {
                    _loading.loadPic(_picArr[Math.floor(_picArr.length * Math.random())]);
                }
                else
                {
                    _loc_1 = [];
                    _loc_2 = 0;
                    while (_loc_2 < _picArr.length)
                    {
                        
                        if (_picArr[_loc_2] != _bgURL)
                        {
                            _loc_1.push(_picArr[_loc_2]);
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                    _loading.loadPic(_loc_1[Math.floor(_loc_1.length * Math.random())]);
                }
            }
            return;
        }// end function

    }
}
