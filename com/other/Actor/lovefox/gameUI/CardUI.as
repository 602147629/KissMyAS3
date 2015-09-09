package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.buffer.*;
    import lovefox.unit.*;

    public class CardUI extends Window
    {
        private var _cardCanvas:Sprite;
        private var _cardBg:Sprite;
        private var _bg:Bitmap;
        private var _sampleClip:UnitClip;
        private var _horseClip:UnitClip;
        private var _charBmp:Bitmap;
        private var _charBmpd:BitmapData;
        private var _charLoaded:Boolean = false;
        private var _cardWidth:Object = 320;
        private var _cardHeight:Object = 160;
        private var _border:int = 5;
        private var _borderTop:int = 33;
        private var _bgBmpd1:BitmapData;
        private var _bgBmpd2:BitmapData;
        private var _mode:int = 1;
        private var _infoTf:TextField;
        private var _signTf:TextField;
        private var _initStep:uint = 0;
        private var _openReady:Boolean = false;
        private var _signFilter1:Object;
        private var _signFilter2:Object;
        private var _titleFiler:Object;
        private var _titleTf:TextField;
        private var _createPB:PushButton;
        private var _radio1:RadioButton;
        private var _radio2:RadioButton;
        private var _URLLoader:URLLoader;
        private var _saveFR:FileReference;

        public function CardUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            super(param1, param2, param3);
            title = Config.language("CardUI", 1);
            this._signFilter1 = [new GlowFilter(Style.WHITE_FONT, 1, 1.2, 1.2), new GlowFilter(Style.WHITE_FONT, 1, 5, 5, 2, 3, true, true)];
            this._signFilter2 = [new GlowFilter(Style.WHITE_FONT, 1, 1.2, 1.2), new GlowFilter(Style.WINDOW_FONT, 1, 2, 2, 2, 3)];
            this._titleFiler = [new GlowFilter(0, 1, 1.2, 1.2), new GlowFilter(Style.GOLD_FONT, 1, 5, 5, 2, 3, true, true), new GlowFilter(16777215, 0.5, 1.5, 1.5, 1, 3)];
            resize(440, 240);
            return;
        }// end function

        public function init()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            if (this._initStep == 0)
            {
                this._initStep = 1;
                _loc_1 = ["stuff/pic/paint/" + this.getId() + ".png", "stuff/pic/head/-1.png", "stuff/ui/login/bg.jpg"];
                _loc_2 = new BitmapLoader();
                _loc_2.addEventListener("complete", this.subInit);
                _loc_2.load(_loc_1);
                this._saveFR = new FileReference();
                this._saveFR.addEventListener(Event.COMPLETE, this.saveCompleteHandler);
                this._saveFR.addEventListener(Event.CANCEL, this.saveCompleteCancel);
            }
            return;
        }// end function

        private function subInit(param1)
        {
            var bgTemp:Sprite;
            var tempLayer:*;
            var bg:Table;
            var titleTable:*;
            var tempBmpd:BitmapData;
            var bgjpg:BitmapData;
            var bgjpgbmp:*;
            var bgjpgLayer:*;
            var bgjpg1:BitmapData;
            var bgMask:*;
            var oriTempBmpd:*;
            var tempBmp:*;
            var signTable:Table;
            var cardMask:*;
            var cardBg:*;
            var charBmpd:*;
            var charBmp:Bitmap;
            var nameTf1:TextField;
            var headBg:Bitmap;
            var nameTf:TextField;
            var bgBmpd:BitmapData;
            var event:* = param1;
            try
            {
                event.target.removeEventListener("complete", this.subInit);
                this._cardCanvas = new Sprite();
                this._cardCanvas.x = (_width - this._cardWidth) / 2;
                this._cardCanvas.y = 30;
                addChild(this._cardCanvas);
                this._cardWidth = 320;
                this._cardHeight = 160;
                this._borderTop = 33;
                bgTemp = new Sprite();
                tempLayer = new Sprite();
                bg = new Table("table30");
                bg.x = 0;
                bg.y = 20;
                bg.resize(this._cardWidth, this._cardHeight - 20);
                tempLayer.addChild(bg);
                titleTable = new Table("table30");
                titleTable.y = 8;
                titleTable.resize(this._cardWidth, 26);
                if (Player.sex == 1)
                {
                    titleTable.setTable("table27");
                }
                else
                {
                    titleTable.setTable("table28");
                }
                tempLayer.addChild(titleTable);
                tempBmpd = new BitmapData(this._cardWidth, this._cardHeight, true, 0);
                tempBmpd.draw(tempLayer);
                bgjpg = BitmapLoader.pick("stuff/ui/login/bg.jpg");
                bgjpgbmp = new Bitmap(bgjpg, PixelSnapping.AUTO, true);
                bgjpgbmp.x = -15;
                bgjpgbmp.width = this._cardWidth + 30;
                bgjpgbmp.height = this._cardHeight;
                bgjpgLayer = new Sprite();
                bgjpgLayer.addChild(bgjpgbmp);
                bgjpg1 = new BitmapData(this._cardWidth, this._cardHeight, true, 0);
                bgjpg1.draw(bgjpgLayer);
                bgMask = new BitmapData(this._cardWidth, this._cardHeight, true, 0);
                bgMask.threshold(tempBmpd, tempBmpd.rect, new Point(), "==", 4667448, 4294967295, 16777215, false);
                oriTempBmpd = tempBmpd.clone();
                tempBmpd.copyPixels(bgjpg1, bgjpg1.rect, new Point(), bgMask, new Point(), true);
                tempBmpd.merge(oriTempBmpd, new Rectangle(0, 0, oriTempBmpd.width, 29), new Point(), 200, 200, 200, 0);
                bgjpg.dispose();
                bgjpg1.dispose();
                bgMask.dispose();
                oriTempBmpd.dispose();
                tempBmp = new Bitmap(tempBmpd, PixelSnapping.AUTO, true);
                bgTemp.addChild(tempBmp);
                signTable = new Table("table18");
                signTable.resize(160, 42);
                signTable.x = 10;
                signTable.y = this._cardHeight - signTable.height - 10;
                bgTemp.addChild(signTable);
                cardMask = new Shape();
                cardMask.graphics.beginFill(0, 1);
                cardMask.graphics.drawRect(this._border, this._borderTop, this._cardWidth - this._border * 2, this._cardHeight - this._border - this._borderTop);
                cardMask.graphics.endFill();
                cardBg = new Sprite();
                bgTemp.addChild(cardBg);
                cardBg.mask = cardMask;
                charBmpd = BitmapLoader.pick("stuff/pic/paint/" + this.getId() + ".png");
                charBmp = new Bitmap(charBmpd, PixelSnapping.AUTO, true);
                cardBg.addChild(charBmp);
                charBmp.scaleY = 0.5;
                if (this.getId() == 0)
                {
                    charBmp.scaleX = -0.5;
                    charBmp.x = 360;
                    charBmp.y = 20;
                }
                else if (this.getId() == 1)
                {
                    charBmp.scaleX = -0.5;
                    charBmp.x = 380;
                    charBmp.y = 30;
                }
                else if (this.getId() == 2)
                {
                    charBmp.scaleX = 0.5;
                    charBmp.x = 120;
                    charBmp.y = 20;
                }
                else if (this.getId() == 3)
                {
                    charBmp.scaleX = 0.5;
                    charBmp.x = 100;
                    charBmp.y = 20;
                }
                else if (this.getId() == 4)
                {
                    charBmp.scaleX = 0.5;
                    charBmp.x = 120;
                    charBmp.y = 20;
                }
                else if (this.getId() == 5)
                {
                    charBmp.scaleX = 0.5;
                    charBmp.x = 130;
                    charBmp.y = -10;
                }
                nameTf1 = Config.getSimpleTextField();
                nameTf1.textColor = Style.WINDOW_FONT;
                nameTf1.filters = this._titleFiler;
                nameTf1.text = Player.name;
                nameTf1.x = 12;
                nameTf1.y = 12;
                bgTemp.addChild(nameTf1);
                headBg = new Bitmap(BitmapLoader.pick("stuff/pic/head/-1.png"), PixelSnapping.AUTO, true);
                var _loc_3:* = 0.5;
                headBg.scaleY = 0.5;
                headBg.scaleX = _loc_3;
                headBg.x = (this._cardWidth - headBg.width) / 2;
                headBg.y = 0;
                bgTemp.addChild(headBg);
                nameTf = Config.getSimpleTextField();
                nameTf.textColor = Style.WINDOW_FONT;
                nameTf.filters = [new GlowFilter(0, 1, 1.2, 1.2), new GlowFilter(Style.WINDOW_FONT, 1, 5, 5, 2, 3, true, true)];
                nameTf.htmlText = "<FONT SIZE=\'16\'><b>" + Player.name + "</b></FONT>";
                nameTf.x = (this._cardWidth - nameTf.width) / 2;
                nameTf.y = 9;
                bgTemp.addChild(nameTf);
                if (nameTf.width / 0.7 > headBg.width)
                {
                    headBg.width = int(nameTf.width / 0.7);
                    headBg.x = int((this._cardWidth - headBg.width) / 2);
                }
                bgBmpd = new BitmapData(this._cardWidth, this._cardHeight, true, 0);
                bgBmpd.draw(bgTemp);
                tempBmpd.dispose();
                charBmpd.dispose();
                headBg.bitmapData.dispose();
                this._bgBmpd1 = bgBmpd;
                this._cardWidth = 420;
                this._cardHeight = 110;
                this._borderTop = 25;
                bgTemp = new Sprite();
                tempLayer = new Sprite();
                bg = new Table("table30");
                bg.x = 0;
                bg.y = 0;
                bg.resize(this._cardWidth, this._cardHeight);
                tempLayer.addChild(bg);
                titleTable = new Table("table30");
                titleTable.y = 0;
                titleTable.resize(this._cardWidth, 26);
                if (Player.sex == 1)
                {
                    titleTable.setTable("table27");
                }
                else
                {
                    titleTable.setTable("table28");
                }
                tempLayer.addChild(titleTable);
                tempBmpd = new BitmapData(this._cardWidth, this._cardHeight, true, 0);
                tempBmpd.draw(tempLayer);
                bgjpg = BitmapLoader.pick("stuff/ui/login/bg.jpg");
                bgjpgbmp = new Bitmap(bgjpg, PixelSnapping.AUTO, true);
                bgjpgbmp.x = -15;
                bgjpgbmp.width = this._cardWidth + 30;
                bgjpgbmp.height = this._cardHeight;
                bgjpgLayer = new Sprite();
                bgjpgLayer.addChild(bgjpgbmp);
                bgjpg1 = new BitmapData(this._cardWidth, this._cardHeight, true, 0);
                bgjpg1.draw(bgjpgLayer);
                bgMask = new BitmapData(this._cardWidth, this._cardHeight, true, 0);
                bgMask.threshold(tempBmpd, tempBmpd.rect, new Point(), "==", 4667448, 4294967295, 16777215, false);
                oriTempBmpd = tempBmpd.clone();
                tempBmpd.copyPixels(bgjpg1, bgjpg1.rect, new Point(), bgMask, new Point(), true);
                tempBmpd.merge(oriTempBmpd, new Rectangle(0, 0, oriTempBmpd.width, this._borderTop - 4), new Point(), 200, 200, 200, 0);
                bgjpg.dispose();
                bgjpg1.dispose();
                bgMask.dispose();
                oriTempBmpd.dispose();
                tempBmp = new Bitmap(tempBmpd, PixelSnapping.AUTO, true);
                bgTemp.addChild(tempBmp);
                signTable = new Table("table18");
                signTable.resize(420, 22);
                signTable.x = 0;
                signTable.y = this._cardHeight - signTable.height;
                bgTemp.addChild(signTable);
                cardMask = new Shape();
                cardMask.graphics.beginFill(0, 1);
                cardMask.graphics.drawRect(this._border, this._border, this._cardWidth - this._border * 2, this._cardHeight - this._border - 22);
                cardMask.graphics.endFill();
                cardBg = new Sprite();
                bgTemp.addChild(cardBg);
                cardBg.mask = cardMask;
                charBmpd = BitmapLoader.pick("stuff/pic/paint/" + this.getId() + ".png");
                charBmp = new Bitmap(charBmpd, PixelSnapping.AUTO, true);
                charBmp.blendMode = BlendMode.DARKEN;
                cardBg.addChild(charBmp);
                charBmp.scaleY = 0.5;
                if (this.getId() == 0)
                {
                    charBmp.scaleX = -0.5;
                    charBmp.x = 360;
                    charBmp.y = 20 - 25;
                }
                else if (this.getId() == 1)
                {
                    charBmp.scaleX = -0.5;
                    charBmp.x = 380;
                    charBmp.y = 30 - 25;
                }
                else if (this.getId() == 2)
                {
                    charBmp.scaleX = 0.5;
                    charBmp.x = 120;
                    charBmp.y = 20 - 25;
                }
                else if (this.getId() == 3)
                {
                    charBmp.scaleX = 0.5;
                    charBmp.x = 100;
                    charBmp.y = 20 - 25;
                }
                else if (this.getId() == 4)
                {
                    charBmp.scaleX = 0.5;
                    charBmp.x = 120;
                    charBmp.y = 20 - 25;
                }
                else if (this.getId() == 5)
                {
                    charBmp.scaleX = 0.5;
                    charBmp.x = 130;
                    charBmp.y = -10 - 25;
                }
                bgBmpd = new BitmapData(this._cardWidth, this._cardHeight, true, 0);
                bgBmpd.draw(bgTemp);
                tempBmpd.dispose();
                charBmpd.dispose();
                headBg.bitmapData.dispose();
                this._bgBmpd2 = bgBmpd;
                this._cardWidth = 320;
                this._cardHeight = 160;
                this._borderTop = 33;
                this._mode = 1;
                this._bg = new Bitmap(this._bgBmpd1);
                this._cardCanvas.addChild(this._bg);
                this._signTf = Config.getSimpleTextField();
                this._signTf.width = 160 - 8;
                this._signTf.height = 42 - 8;
                this._signTf.x = 10 + 4;
                this._signTf.y = this._cardHeight - 42 - 10 + 4;
                this._signTf.textColor = Style.WHITE_FONT;
                this._signTf.wordWrap = true;
                this._signTf.mouseEnabled = true;
                this._signTf.type = TextFieldType.INPUT;
                this._signTf.selectable = true;
                this._signTf.multiline = true;
                this._cardBg = new Sprite();
                this._cardCanvas.addChild(this._cardBg);
                this._sampleClip = UnitClip.newUnitClip();
                this._sampleClip.changeStateTo("idle");
                this._sampleClip.changeDirectionTo(1);
                this._sampleClip.shadow = true;
                this._sampleClip.x = 360;
                this._sampleClip.y = 110;
                this._horseClip = UnitClip.newUnitClip();
                this._horseClip.changeStateTo("idle");
                this._horseClip.changeDirectionTo(1);
                this._horseClip.shadow = true;
                this._horseClip.x = 360;
                this._horseClip.y = 130;
                this._infoTf = Config.getSimpleTextField();
                this._infoTf.x = 10;
                this._infoTf.y = 42;
                this._infoTf.textColor = Style.WHITE_FONT;
                this._infoTf.filters = [new GlowFilter(Style.WHITE_FONT, 1, 1.2, 1.2), new GlowFilter(Style.WINDOW_FONT, 1, 3, 3, 2, 3, true, true)];
                this._titleTf = Config.getSimpleTextField();
                this._titleTf.textColor = Style.WINDOW_FONT;
                this._titleTf.filters = this._titleFiler;
                this._titleTf.y = 12;
                this._cardBg.addChild(this._titleTf);
                this._cardBg.addChild(this._signTf);
                this._cardBg.addChild(this._infoTf);
                this._signTf.text = Config.language("CardUI", 2);
                this._signTf.filters = this._signFilter1;
                this._signTf.addEventListener(FocusEvent.FOCUS_IN, this.handleSignFocusIn);
                this._signTf.addEventListener(FocusEvent.FOCUS_OUT, this.handleSignFocusOut);
                this._initStep = 2;
                this._createPB = new PushButton(this, 290, 205, Config.language("CardUI", 3), this.handleCreate);
                this._radio1 = new RadioButton(this, 50, 210, Config.language("CardUI", 4), true, this.handleMode1);
                this._radio1.group = "signCardRadioGroup";
                this._radio2 = new RadioButton(this, 170, 210, Config.language("CardUI", 5), false, this.handleMode2);
                this._radio2.group = "signCardRadioGroup";
                BitmapLoader.clearBuffArr(["stuff/pic/paint/" + this.getId() + ".png", "stuff/pic/head/-1.png", "stuff/ui/login/bg.jpg"]);
                Config.startLoop(this.gc);
            }
            catch (e)
            {
            }
            this.changemode(1);
            return;
        }// end function

        private function handleMode1(param1)
        {
            this.changemode(1);
            return;
        }// end function

        private function handleMode2(param1)
        {
            this.changemode(2);
            return;
        }// end function

        private function handleCreate(param1)
        {
            this._createPB.enabled = false;
            var _loc_2:* = new BitmapData(this._cardWidth, this._cardHeight, true, 0);
            _loc_2.draw(this._cardCanvas);
            var _loc_3:* = PNGEncoder.encode(_loc_2);
            _loc_2.dispose();
            this._saveFR.save(_loc_3, "sign.png");
            return;
        }// end function

        protected function errorHandler(param1) : void
        {
            this._createPB.enabled = true;
            trace(param1.target.data);
            return;
        }// end function

        protected function completeHandler(param1) : void
        {
            this._createPB.enabled = true;
            if (String(param1.target.data) == "false")
            {
            }
            else
            {
                navigateToURL(new URLRequest(String(param1.target.data) + ".png"));
            }
            return;
        }// end function

        private function gc(param1)
        {
            Config.stopLoop(this.gc);
            Config.gc();
            return;
        }// end function

        private function handleSignFocusIn(param1)
        {
            this._signTf.type = TextFieldType.INPUT;
            this._signTf.filters = this._signFilter2;
            if (this._signTf.text == Config.language("CardUI", 2))
            {
                this._signTf.text = "";
                if (this._mode == 2)
                {
                    this._signTf.x = (this._cardWidth - this._signTf.width) / 2;
                }
            }
            if (Config._switchEnglish)
            {
                this._signTf.restrict = "^一-龥";
            }
            return;
        }// end function

        private function handleSignFocusOut(param1)
        {
            this._signTf.type = TextFieldType.DYNAMIC;
            this._signTf.filters = this._signFilter1;
            if (Config._switchEnglish)
            {
                this._signTf.restrict = "";
            }
            return;
        }// end function

        private function changemode(param1)
        {
            this._mode = param1;
            if (this._mode == 1)
            {
                this._cardWidth = 320;
                this._cardHeight = 160;
                this._borderTop = 33;
            }
            else
            {
                this._cardWidth = 420;
                this._cardHeight = 110;
                this._borderTop = 25;
            }
            if (this._mode == 1)
            {
                if (this._sampleClip.parent != null)
                {
                    this._sampleClip.parent.removeChild(this._sampleClip);
                }
                if (this._horseClip.parent != null)
                {
                    this._horseClip.parent.removeChild(this._horseClip);
                }
            }
            else
            {
                if (this._sampleClip.parent != null)
                {
                    this._sampleClip.parent.removeChild(this._sampleClip);
                }
                if (this._horseClip.parent != null)
                {
                    this._horseClip.parent.removeChild(this._horseClip);
                }
                if (Config.player._img.ready)
                {
                    this._sampleClip.clone(Config.player._img);
                    this._sampleClip.sleepAnimation();
                    if (Config.player.horse == null)
                    {
                        this._sampleClip.y = 80;
                        this._cardBg.addChild(this._sampleClip);
                    }
                    else
                    {
                        this._horseClip.y = 100;
                        this._sampleClip.y = 100 - 28;
                        this._horseClip.clone(Config.player.horse);
                        this._horseClip.sleepAnimation();
                        this._cardBg.addChild(this._horseClip);
                        this._cardBg.addChild(this._sampleClip);
                    }
                }
            }
            this._cardBg.addChild(this._signTf);
            if (this._mode == 1)
            {
                this._bg.bitmapData = this._bgBmpd1;
            }
            else
            {
                this._bg.bitmapData = this._bgBmpd2;
            }
            if (this._mode == 1)
            {
                this._titleTf.text = Bard.getPlayerTitle();
                this._titleTf.x = this._cardWidth - this._titleTf.width - 12;
                this._titleTf.y = 12;
            }
            else
            {
                this._titleTf.htmlText = "<b>" + Player.name + "</b>" + " -- " + Bard.getPlayerTitle();
                this._titleTf.x = 12;
                this._titleTf.y = 4;
            }
            if (this._mode == 1)
            {
                this._infoTf.y = 42;
            }
            else if (Config.player._gilename != "")
            {
                this._infoTf.y = 26;
            }
            else
            {
                this._infoTf.y = 32;
            }
            if (this._mode == 1)
            {
                this._signTf.wordWrap = true;
                this._signTf.width = 160 - 8;
                this._signTf.height = 42 - 8;
                this._signTf.x = 10 + 4;
                this._signTf.y = this._cardHeight - 42 - 10 + 4;
                this._signTf.multiline = true;
                this._signTf.removeEventListener(Event.CHANGE, this.handleSignChange);
            }
            else
            {
                this._signTf.wordWrap = false;
                this._signTf.width = this._cardWidth - 8;
                this._signTf.height = 20;
                this._signTf.x = (this._cardWidth - this._signTf.width) / 2;
                this._signTf.y = this._cardHeight - 21;
                this._signTf.multiline = false;
                this._signTf.removeEventListener(Event.CHANGE, this.handleSignChange);
                this._signTf.addEventListener(Event.CHANGE, this.handleSignChange);
            }
            this._cardCanvas.x = (_width - this._cardWidth) / 2;
            if (this._signTf.text == "")
            {
                this._signTf.text = Config.language("CardUI", 2);
                if (this._mode == 2)
                {
                    this._signTf.x = (this._cardWidth - this._signTf.width) / 2;
                }
            }
            return;
        }// end function

        private function handleSignChange(param1)
        {
            this._signTf.x = (this._cardWidth - this._signTf.width) / 2;
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            var _loc_2:* = undefined;
            if (this._initStep != 2)
            {
                this._openReady = true;
                return;
            }
            super.open(event);
            if (Config.player != null && Config.player._img != null)
            {
                if (Config.player._img.ready)
                {
                    if (this._mode == 2)
                    {
                        if (this._sampleClip.parent != null)
                        {
                            this._sampleClip.parent.removeChild(this._sampleClip);
                        }
                        if (this._horseClip.parent != null)
                        {
                            this._horseClip.parent.removeChild(this._horseClip);
                        }
                        if (Config.player._img.ready)
                        {
                            this._sampleClip.clone(Config.player._img);
                            this._sampleClip.addShadow();
                            this._sampleClip.sleepAnimation();
                            if (Config.player.horse == null)
                            {
                                this._sampleClip.y = 80;
                                this._cardBg.addChild(this._sampleClip);
                            }
                            else
                            {
                                this._horseClip.y = 100;
                                this._sampleClip.y = 100 - 28;
                                this._horseClip.clone(Config.player.horse);
                                this._horseClip.sleepAnimation();
                                this._cardBg.addChild(this._horseClip);
                                this._cardBg.addChild(this._sampleClip);
                            }
                        }
                    }
                    else
                    {
                        if (this._sampleClip.parent != null)
                        {
                            this._sampleClip.parent.removeChild(this._sampleClip);
                        }
                        if (this._horseClip.parent != null)
                        {
                            this._horseClip.parent.removeChild(this._horseClip);
                        }
                    }
                    this._cardBg.addChild(this._signTf);
                    _loc_2 = "";
                    _loc_2 = _loc_2 + (Config.language("CardUI", 6) + Config.player.level + "  " + Config._jobTitleMap[Player.job]);
                    _loc_2 = _loc_2 + ("\n" + Config.language("CardUI", 7) + Config.ui._skillUI.getgname(1) + Config.ui._skillUI.getgiftpoint(1) + " | " + Config.ui._skillUI.getgname(2) + " " + Config.ui._skillUI.getgiftpoint(2) + " | " + Config.ui._skillUI.getgname(3) + " " + Config.ui._skillUI.getgiftpoint(3));
                    _loc_2 = _loc_2 + ("\n" + Config.language("CardUI", 8) + Config.serverName);
                    if (Config.player._gilename != "")
                    {
                        _loc_2 = _loc_2 + ("\n" + Config.language("CardUI", 9) + Config.player._gilename + " " + this.getGuildPower());
                    }
                    this._infoTf.htmlText = _loc_2;
                    if (this._mode == 2)
                    {
                        if (Config.player._gilename != "")
                        {
                            this._infoTf.y = 26;
                        }
                        else
                        {
                            this._infoTf.y = 32;
                        }
                    }
                    if (this._mode == 1)
                    {
                        this._titleTf.text = Bard.getPlayerTitle();
                        this._titleTf.x = this._cardWidth - this._titleTf.width - 12;
                    }
                    else
                    {
                        this._titleTf.htmlText = "<b>" + Player.name + "</b>" + " -- " + Bard.getPlayerTitle();
                        this._titleTf.x = 12;
                    }
                    if (this._signTf.text == "")
                    {
                        this._signTf.text = Config.language("CardUI", 2);
                    }
                }
            }
            return;
        }// end function

        private function getGuildPower()
        {
            var _loc_1:* = "";
            switch(Config.player._gildpower)
            {
                case 1:
                {
                    _loc_1 = Config.language("CardUI", 10);
                    break;
                }
                case 2:
                {
                    _loc_1 = Config.language("CardUI", 11);
                    break;
                }
                case 3:
                {
                    _loc_1 = Config.language("CardUI", 12);
                    break;
                }
                case 4:
                {
                    _loc_1 = "";
                    break;
                }
                case 5:
                {
                    _loc_1 = "";
                    break;
                }
                case 6:
                {
                    _loc_1 = "";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        private function getId()
        {
            if (Player.job == 1)
            {
                if (Player.sex == 1)
                {
                    return 0;
                }
                return 1;
            }
            else if (Player.job == 4)
            {
                if (Player.sex == 1)
                {
                    return 2;
                }
                return 3;
            }
            else if (Player.job == 10)
            {
                if (Player.sex == 1)
                {
                    return 4;
                }
                return 5;
            }
            return;
        }// end function

        private function saveCompleteHandler(event:Event) : void
        {
            trace("saveCompleteHandler");
            this._createPB.enabled = true;
            return;
        }// end function

        private function saveCompleteCancel(event:Event) : void
        {
            trace("saveCompleteCancel");
            this._createPB.enabled = true;
            return;
        }// end function

    }
}
