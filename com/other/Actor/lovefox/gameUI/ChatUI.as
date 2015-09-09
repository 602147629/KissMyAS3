package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class ChatUI extends Sprite
    {
        private var _line:uint = 0;
        private var _line1:uint = 0;
        private var _line2:uint = 0;
        private var _line3:uint = 0;
        public var _sayFlag:Boolean;
        public var _sayIcon:Shape;
        public var _sayText:RichTextField;
        public var _sayTextBg:Panel;
        public var _sayType:uint;
        public var _width:Number = 200;
        public var _height:Number = 120;
        public var _yRevise:Number;
        public var _channelBg:Sprite;
        private var _channelScrollBar:VSlider;
        public var _channelRtf:RichTextField;
        private var _channelScrollBar1:VSlider;
        public var _channelRtf1:RichTextField;
        private var _channelScrollBar2:VSlider;
        public var _channelRtf2:RichTextField;
        private var _split1:PushButton;
        private var _split2:PushButton;
        private var _split3:PushButton;
        private var _bg:Table;
        private var _localBtn:CheckBox;
        private var _privateBtn:CheckBox;
        private var _teamBtn:CheckBox;
        private var _guildBtn:CheckBox;
        private var _worldBtn:CheckBox;
        private var _localBtn1:CheckBox;
        private var _privateBtn1:CheckBox;
        private var _teamBtn1:CheckBox;
        private var _guildBtn1:CheckBox;
        private var _worldBtn1:CheckBox;
        private var _localBtn2:CheckBox;
        private var _privateBtn2:CheckBox;
        private var _teamBtn2:CheckBox;
        private var _guildBtn2:CheckBox;
        private var _worldBtn2:CheckBox;
        private var _heightSwitch:PushButton;
        private var _clearPB:PushButton;
        private var _sayBtn:PushButton;
        public var _sayTypePBL:ComboBox;
        private var _ubbPBL:PushButtonList;
        private var _ubbCB:ComboBox;
        private var _localFormat:TextFormat;
        private var _teamFormat:TextFormat;
        private var _guildFormat:TextFormat;
        private var _privateFormat:TextFormat;
        private var _privateOwnFormat:TextFormat;
        private var _privateOwnPreSay:String;
        private var _worldFormat:TextFormat;
        private var _systemFormat:TextFormat;
        private var _bullFormat:TextFormat;
        private var _sp1Format:TextFormat;
        private var _localStack:Array;
        private var _teamStack:Array;
        private var _guildStack:Array;
        private var _privateStack:Array;
        private var _worldStack:Array;
        private var _systemStack:Array;
        private var _bullStack:Array;
        private var _preSayBuff:Array;
        private var _preSayIndex:Object = 0;
        private var _ubbList:Sprite;
        public var _opening:Object = true;
        private var _privateNameStack:Array;
        private var _sayTypeArrayBigWar:Array;
        private var _sayTypeArray:Array;
        private var _preWorldTime:Object;
        private var _preSayType:Object;
        public var _preHeight:uint = 120;
        private var _mode:uint = 0;
        private var _splitPercent:Number = 0.5;
        private var _splitMouseY:int;
        private var _preSplitPercent:Number;
        private var _cls:CheckBox;
        public var _modeChange:CheckBox;
        private var _locker:CheckBox;
        private var _locker1:CheckBox;
        private var _locker2:CheckBox;
        private var _bigWar:Boolean = false;
        private var _koreaSys1Timer:Number;
        public static var MAX_STACK:Object = 20;
        public static var MAX_LINE:Object = 40;

        public function ChatUI()
        {
            this._sayType = CHAT_TYPE_ENUM.CHAT_MSG_MAP;
            this._localStack = [];
            this._teamStack = [];
            this._guildStack = [];
            this._privateStack = [];
            this._worldStack = [];
            this._systemStack = [];
            this._bullStack = [];
            this._preSayBuff = [];
            this._privateNameStack = [];
            this._sayTypeArrayBigWar = [];
            this._sayTypeArray = [];
            this.init();
            return;
        }// end function

        public function set bigWar(param1)
        {
            this._bigWar = param1;
            if (this._bigWar)
            {
                this._sayTypePBL.itemArray = this._sayTypeArrayBigWar.concat(this._privateNameStack);
                this._sayTypePBL.selectedItem = this._sayTypeArrayBigWar[0];
                this._sayTypePBL.button.label = this._sayTypePBL.selectedItem.label + " ";
                this.handleSayTypeChange();
            }
            else
            {
                this._sayTypePBL.itemArray = this._sayTypeArray.concat(this._privateNameStack);
                if (this._sayTypePBL.selectedItem.id == 6)
                {
                    this._sayTypePBL.selectedItem = this._sayTypeArray[0];
                    this._sayTypePBL.button.label = this._sayTypePBL.selectedItem.label + " ";
                    this.handleSayTypeChange();
                }
            }
            return;
        }// end function

        public function get bigWar()
        {
            return this._bigWar;
        }// end function

        public function set mode(param1)
        {
            if (this._mode != param1)
            {
                this._mode = param1;
                removeEventListener(MouseEvent.ROLL_OVER, this.handleMouseOver);
                removeEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
                this._channelRtf.clear();
                this._channelRtf1.clear();
                this._channelRtf2.clear();
                if (this._mode == 0)
                {
                    this._modeChange.selected = 0;
                    this._channelBg.addChild(this._localBtn);
                    if (this._privateBtn != null)
                    {
                        this._channelBg.addChild(this._privateBtn);
                    }
                    if (this._teamBtn != null)
                    {
                        this._channelBg.addChild(this._teamBtn);
                    }
                    this._channelBg.addChild(this._guildBtn);
                    this._channelBg.addChild(this._worldBtn);
                    this._channelBg.addChild(this._locker);
                    this._channelBg.addChild(this._cls);
                    this._channelBg.addChild(this._modeChange);
                    this._cls.x = 60;
                    this._modeChange.x = 110;
                    this._cls.textColor = Style.WHITE_FONT;
                    this._modeChange.textColor = Style.WHITE_FONT;
                    this._cls.filters = [new GlowFilter(0, 1, 2, 2, 10)];
                    this._modeChange.filters = [new GlowFilter(0, 1, 2, 2, 10)];
                    addChild(this._heightSwitch);
                    removeChild(this._split1);
                    removeChild(this._split2);
                    removeChild(this._split3);
                    removeChild(this._channelRtf1);
                    removeChild(this._channelRtf2);
                    this._channelBg.removeChild(this._channelScrollBar1);
                    this._channelBg.removeChild(this._channelScrollBar2);
                    addEventListener(MouseEvent.ROLL_OVER, this.handleMouseOver);
                    addEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
                    this._channelBg.removeEventListener(Event.ENTER_FRAME, this.bgAlphaDownLoop);
                    this._channelBg.removeEventListener(Event.ENTER_FRAME, this.bgAlphaUpLoop);
                    this._channelBg.visible = true;
                    this._channelBg.alpha = 0;
                    this._channelBg.addEventListener(Event.ENTER_FRAME, this.bgAlphaDownLoop);
                    if (!Config._switchMobage)
                    {
                        this._ubbCB.list.selectable = false;
                    }
                    this._channelRtf.resize(this._width - 30, this._height - 16);
                    this._channelBg.graphics.clear();
                    this._channelBg.graphics.beginFill(0, 0.5);
                    this._channelBg.graphics.drawRect(0, -this._height - 16, 170, 16);
                    this._channelBg.graphics.endFill();
                    this._channelBg.graphics.beginFill(0, 0.5);
                    this._channelBg.graphics.drawRect(0, -this._height, this._width - 12, this._height + 14);
                    this._channelBg.graphics.endFill();
                    this.refresh();
                }
                else if (this._mode == 1)
                {
                    this._modeChange.selected = 1;
                    if (this._locker.parent != null)
                    {
                        this._locker.parent.removeChild(this._locker);
                    }
                    this._channelBg.removeChild(this._localBtn);
                    if (this._privateBtn != null)
                    {
                        this._channelBg.removeChild(this._privateBtn);
                    }
                    if (this._teamBtn != null)
                    {
                        this._channelBg.removeChild(this._teamBtn);
                    }
                    this._channelBg.removeChild(this._guildBtn);
                    this._channelBg.removeChild(this._worldBtn);
                    addChild(this._split1);
                    addChild(this._split2);
                    addChild(this._split3);
                    addChild(this._channelRtf1);
                    addChild(this._channelRtf2);
                    this._channelBg.addChild(this._channelScrollBar1);
                    this._channelBg.addChild(this._channelScrollBar2);
                    this._channelBg.removeEventListener(Event.ENTER_FRAME, this.bgAlphaDownLoop);
                    this._channelBg.removeEventListener(Event.ENTER_FRAME, this.bgAlphaUpLoop);
                    this._channelBg.visible = true;
                    this._channelBg.alpha = 1;
                    if (!Config._switchMobage)
                    {
                        addChild(this._ubbCB);
                    }
                    addChild(this._sayTypePBL);
                    if (this._heightSwitch.parent != null)
                    {
                        this._heightSwitch.parent.removeChild(this._heightSwitch);
                    }
                    this._channelRtf.resize(this._width - 20, this._height - 16);
                    this._channelBg.graphics.clear();
                    this._channelBg.graphics.beginFill(4338226, 1);
                    this._channelBg.graphics.drawRect(0, -this._height, this._width - 12, this._height + 14);
                    this._channelBg.graphics.endFill();
                    addChild(this._cls);
                    addChild(this._modeChange);
                    this._cls.textColor = Style.WINDOW_FONT;
                    this._modeChange.textColor = Style.WINDOW_FONT;
                    this._cls.filters = [];
                    this._modeChange.filters = [];
                    this._cls.x = 10;
                    this._modeChange.x = 55;
                    this.refresh1();
                    this.refresh2();
                    this.refresh3();
                }
            }
            return;
        }// end function

        public function get mode()
        {
            return this._mode;
        }// end function

        public function addPrivate(param1:String, param2:Boolean = false)
        {
            var _loc_3:* = undefined;
            if (Config._switchMobage)
            {
                return;
            }
            _loc_3 = 0;
            while (_loc_3 < this._privateNameStack.length)
            {
                
                if (this._privateNameStack[_loc_3].name == param1)
                {
                    this._privateNameStack.splice(_loc_3, 1);
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = {label:param1 + ":", id:100, name:param1};
            this._privateNameStack.push(_loc_4);
            if (this._privateNameStack.length > 5)
            {
                this._privateNameStack.shift();
            }
            if (this._bigWar)
            {
                this._sayTypePBL.itemArray = this._sayTypeArrayBigWar.concat(this._privateNameStack);
            }
            else
            {
                this._sayTypePBL.itemArray = this._sayTypeArray.concat(this._privateNameStack);
            }
            if (param2)
            {
                this._sayTypePBL.selectedItem = _loc_4;
                this._sayTypePBL.button.label = _loc_4.label;
                this.handleSayTypeChange();
            }
            return;
        }// end function

        private function handleClear(param1)
        {
            param1.currentTarget.selected = false;
            this.clear();
            return;
        }// end function

        private function handleLocker(param1)
        {
            this._channelRtf.autoScroll = !param1.currentTarget.selected;
            if (this._channelRtf.autoScroll)
            {
                this.refresh();
            }
            return;
        }// end function

        private function handleLocker1(param1)
        {
            this._channelRtf.autoScroll = !param1.currentTarget.selected;
            if (this._channelRtf.autoScroll)
            {
                this.refresh2();
            }
            return;
        }// end function

        private function handleLocker2(param1)
        {
            this._channelRtf2.autoScroll = !param1.currentTarget.selected;
            if (this._channelRtf2.autoScroll)
            {
                this.refresh3();
            }
            return;
        }// end function

        private function handleModeChange(param1)
        {
            Config.chatMode = param1.currentTarget.selected;
            return;
        }// end function

        private function init()
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            this._localFormat = new TextFormat();
            this._localFormat.color = 16777215;
            this._teamFormat = new TextFormat();
            this._teamFormat.color = 44880;
            this._guildFormat = new TextFormat();
            this._guildFormat.color = 5094136;
            this._privateFormat = new TextFormat();
            this._privateFormat.color = 15086280;
            this._privateOwnFormat = new TextFormat();
            this._privateOwnFormat.color = 16157924;
            this._worldFormat = new TextFormat();
            this._worldFormat.color = 9895880;
            this._systemFormat = new TextFormat();
            this._systemFormat.color = 16711680;
            this._bullFormat = new TextFormat();
            this._bullFormat.color = 16737295;
            this._sp1Format = new TextFormat();
            this._sp1Format.color = 3272944;
            this._channelBg = new Sprite();
            addChild(this._channelBg);
            mouseEnabled = false;
            this._bg = new Table("table9");
            addChild(this._bg);
            this._bg.resize(300);
            this._modeChange = new CheckBox(this._channelBg, 110, -100, Config.language("ChatUI", 1), this.handleModeChange);
            this._modeChange.selected = false;
            this._modeChange.textColor = Style.WHITE_FONT;
            this._modeChange.subColor = 16711680;
            this._cls = new CheckBox(this._channelBg, 60, -100, Config.language("ChatUI", 2), this.handleClear);
            this._cls.selected = false;
            this._cls.textColor = Style.WHITE_FONT;
            this._cls.subColor = 16711680;
            this._cls.filters = [new GlowFilter(0, 1, 2, 2, 10)];
            this._modeChange.filters = [new GlowFilter(0, 1, 2, 2, 10)];
            this._locker = new CheckBox(this._channelBg, 10, -100, Config.language("ChatUI", 3), this.handleLocker);
            this._locker.selected = false;
            this._locker.textColor = Style.WHITE_FONT;
            this._locker.subColor = 16711680;
            this._locker.filters = [new GlowFilter(0, 1, 2, 2, 10)];
            this._localBtn = new CheckBox(this._channelBg, 5, -12, Config.language("ChatUI", 4), this.handleChannelSelect);
            this._localBtn.selected = true;
            this._localBtn.textColor = Style.WHITE_FONT;
            this._localBtn.subColor = 16711680;
            if (!Config._switchMobage)
            {
                this._privateBtn = new CheckBox(this._channelBg, 65, -12, Config.language("ChatUI", 5), this.handleChannelSelect);
                this._privateBtn.selected = true;
                this._privateBtn.textColor = Style.WHITE_FONT;
                this._privateBtn.subColor = 16711680;
                this._teamBtn = new CheckBox(this._channelBg, 125, -12, Config.language("ChatUI", 6), this.handleChannelSelect);
                this._teamBtn.selected = true;
                this._teamBtn.textColor = Style.WHITE_FONT;
                this._teamBtn.subColor = 16711680;
            }
            this._guildBtn = new CheckBox(this._channelBg, 185, -12, Config.language("ChatUI", 7), this.handleChannelSelect);
            this._guildBtn.selected = true;
            this._guildBtn.textColor = Style.WHITE_FONT;
            this._guildBtn.subColor = 16711680;
            this._worldBtn = new CheckBox(this._channelBg, 245, -12, Config.language("ChatUI", 8), this.handleChannelSelect);
            this._worldBtn.selected = true;
            this._worldBtn.textColor = Style.WHITE_FONT;
            this._worldBtn.subColor = 16711680;
            this._sayText = new RichTextField(this._width - 145, 10, RichTextField.INPUT);
            this._sayText.textColor = 0;
            this._sayText.placeholderColor = 0;
            if (Config._switchEnglish)
            {
                this._sayText.maxChars = 150;
            }
            else
            {
                this._sayText.maxChars = 30;
            }
            if (Config._switchEnglish)
            {
                this._sayText._textfield.restrict = "^<>一-龥" + this._sayText.PLACEHOLDER;
            }
            else
            {
                this._sayText._textfield.restrict = "^<>" + this._sayText.PLACEHOLDER;
            }
            this._sayText.y = 4;
            this._sayText.x = 65;
            this._sayText.addEventListener(FocusEvent.FOCUS_IN, this.handleFocusIn);
            var _loc_1:* = new TextFormat();
            _loc_1.size = 12;
            _loc_1.color = 16775113;
            if (Config._switchEnglish)
            {
                _loc_1.font = "Tahoma";
            }
            this._sayText.defaultTextFormat = _loc_1;
            this._sayText.addEventListener(TextEvent.TEXT_INPUT, this.handleSayTextInput);
            addChild(this._sayText);
            this._channelRtf = new RichTextField(this._width - 15, 100);
            this._channelRtf.mouseEnabled = false;
            this._channelRtf._textfield.mouseEnabled = false;
            this._channelRtf.autoScroll = true;
            this._channelRtf.selectable = false;
            this._channelRtf.x = 5;
            this._channelRtf.y = -150;
            this._channelRtf.filters = [new GlowFilter(0, 1, 2, 2, 10)];
            addChild(this._channelRtf);
            this._channelScrollBar = new VSlider(this._channelBg, 0, 0);
            this._channelScrollBar.width = 12;
            this._channelScrollBar.backClick = true;
            this._channelScrollBar.scrollTarget = this._channelRtf;
            this._channelRtf1 = new RichTextField(this._width - 15, 100);
            this._channelRtf1.mouseEnabled = false;
            this._channelRtf1._textfield.mouseEnabled = false;
            this._channelRtf1.autoScroll = true;
            this._channelRtf1.selectable = false;
            this._channelRtf1.x = 5;
            this._channelRtf1.y = -150;
            this._channelRtf1.filters = [new GlowFilter(0, 1, 2, 2, 10)];
            this._channelScrollBar1 = new VSlider(null, 0, 0);
            this._channelScrollBar1.width = 12;
            this._channelScrollBar1.backClick = true;
            this._channelScrollBar1.scrollTarget = this._channelRtf1;
            this._channelRtf2 = new RichTextField(this._width - 15, 100);
            this._channelRtf2.mouseEnabled = false;
            this._channelRtf2._textfield.mouseEnabled = false;
            this._channelRtf2.autoScroll = true;
            this._channelRtf2.selectable = false;
            this._channelRtf2.x = 5;
            this._channelRtf2.y = -150;
            this._channelRtf2.filters = [new GlowFilter(0, 1, 2, 2, 10)];
            this._split1 = new PushButton(null, 0, 0, Config.language("ChatUI", 9));
            this._split1.setTable("table8");
            this._split1.mouseChildren = false;
            this._split1.mouseEnabled = false;
            this._split1.buttonMode = false;
            this._split2 = new PushButton(null, 0, 0, "");
            this._split2.setTable("table8");
            this._split2.enabled = true;
            this._split2.mouseEnabled = false;
            this._split2.buttonMode = false;
            this._locker1 = new CheckBox(this._split2, 10, 5, Config.language("ChatUI", 3), this.handleLocker1);
            this._locker1.selected = false;
            this._locker1.textColor = Style.WINDOW_FONT;
            this._locker1.subColor = 16711680;
            this._localBtn1 = new CheckBox(this._split2, 70, 5, Config.language("ChatUI", 4), this.handleChannelSelect1);
            this._localBtn1.selected = true;
            this._localBtn1.textColor = Style.WINDOW_FONT;
            this._localBtn1.subColor = 16711680;
            if (!Config._switchMobage)
            {
                this._privateBtn1 = new CheckBox(this._split2, 115, 5, Config.language("ChatUI", 5), this.handleChannelSelect1);
                this._privateBtn1.selected = false;
                this._privateBtn1.textColor = Style.WINDOW_FONT;
                this._privateBtn1.subColor = 16711680;
                this._teamBtn1 = new CheckBox(this._split2, 160, 5, Config.language("ChatUI", 6), this.handleChannelSelect1);
                this._teamBtn1.selected = false;
                this._teamBtn1.textColor = Style.WINDOW_FONT;
                this._teamBtn1.subColor = 16711680;
            }
            this._guildBtn1 = new CheckBox(this._split2, 205, 5, Config.language("ChatUI", 7), this.handleChannelSelect1);
            this._guildBtn1.selected = false;
            this._guildBtn1.textColor = Style.WINDOW_FONT;
            this._guildBtn1.subColor = 16711680;
            this._worldBtn1 = new CheckBox(this._split2, 250, 5, Config.language("ChatUI", 8), this.handleChannelSelect1);
            this._worldBtn1.selected = true;
            this._worldBtn1.textColor = Style.WINDOW_FONT;
            this._worldBtn1.subColor = 16711680;
            this._split3 = new PushButton(null, 0, 0, "");
            this._split3.setTable("table8");
            this._locker2 = new CheckBox(this._split3, 10, 5, Config.language("ChatUI", 3), this.handleLocker2);
            this._locker2.selected = false;
            this._locker2.textColor = Style.WINDOW_FONT;
            this._locker2.subColor = 16711680;
            this._localBtn2 = new CheckBox(this._split3, 70, 5, Config.language("ChatUI", 4), this.handleChannelSelect2);
            this._localBtn2.selected = false;
            this._localBtn2.textColor = Style.WINDOW_FONT;
            this._localBtn2.subColor = 16711680;
            if (!Config._switchMobage)
            {
                this._privateBtn2 = new CheckBox(this._split3, 115, 5, Config.language("ChatUI", 5), this.handleChannelSelect2);
                this._privateBtn2.selected = true;
                this._privateBtn2.textColor = Style.WINDOW_FONT;
                this._privateBtn2.subColor = 16711680;
                this._teamBtn2 = new CheckBox(this._split3, 160, 5, Config.language("ChatUI", 6), this.handleChannelSelect2);
                this._teamBtn2.selected = true;
                this._teamBtn2.textColor = Style.WINDOW_FONT;
                this._teamBtn2.subColor = 16711680;
            }
            this._guildBtn2 = new CheckBox(this._split3, 205, 5, Config.language("ChatUI", 7), this.handleChannelSelect2);
            this._guildBtn2.selected = true;
            this._guildBtn2.textColor = Style.WINDOW_FONT;
            this._guildBtn2.subColor = 16711680;
            this._worldBtn2 = new CheckBox(this._split3, 250, 5, Config.language("ChatUI", 8), this.handleChannelSelect2);
            this._worldBtn2.selected = false;
            this._worldBtn2.textColor = Style.WINDOW_FONT;
            this._worldBtn2.subColor = 16711680;
            this._split3.addEventListener(MouseEvent.MOUSE_DOWN, this.handleSplitMouseDown);
            this._channelScrollBar2 = new VSlider(null, 0, 0);
            this._channelScrollBar2.width = 12;
            this._channelScrollBar2.backClick = true;
            this._channelScrollBar2.scrollTarget = this._channelRtf2;
            this._sayBtn = new PushButton(this, this._width - 64, 2, Config.language("ChatUI", 10), this.handleSayBtnClick);
            this._sayBtn.width = 48;
            this._heightSwitch = new PushButton(this, this._width - 29, 0, "", this.handleHeightSwitchMouseClick, Config.findUI("chatui")["button1"]);
            if (!Config._switchMobage)
            {
                this._ubbCB = new ComboBox(this, this._width - 108, 7, this.handleUbbClick);
                this._ubbCB.width = 68;
                this._ubbCB.rowHeight = 16;
                this._ubbCB.rows = 4;
                this._ubbCB.orientation = ComboBox.UP;
                this._ubbCB.showValue = false;
                this._ubbCB.label = "";
                this._ubbCB.button.width = 32;
                this._ubbCB.button.height = 18;
                this._ubbCB.button.setStyle(Config.findUI("chatui")["button2"]);
                this._ubbCB.list.selectable = false;
                this._ubbCB.button.x = 30;
                _loc_5 = [];
                for (_loc_4 in Config._ubbMap)
                {
                    
                    _loc_2 = new Ubb("<f:" + Base64.encode(Config._ubbMap[_loc_4].id) + ">");
                    _loc_2.x = 1;
                    _loc_2.y = 2;
                    _loc_5.push({icon:_loc_2, id:Config._ubbMap[_loc_4].id});
                }
                this._ubbCB.setItems(_loc_5);
            }
            this._sayTypePBL = new ComboBox(this, 0, 2, this.handleSayTypeChange);
            this._sayTypePBL.width = 100;
            this._sayTypePBL.rowHeight = 16;
            this._sayTypePBL.rows = 1;
            this._sayTypePBL.orientation = ComboBox.UP;
            this._sayTypePBL.showValue = false;
            this._sayTypePBL.list.overshow = true;
            this._sayTypePBL.addEventListener(Event.OPEN, this.handleSayTypeOpen);
            this._sayTypePBL.button.width = 64;
            this._sayTypePBL.button.textColor = Style.WINDOW_FONT;
            this._sayTypePBL.label = "";
            this._sayTypePBL.button.setTable("table10", "table11");
            this._sayTypePBL.list.selectable = false;
            if (Config._switchMobage)
            {
                _loc_5 = [Config.language("ChatUI", 4), Config.language("ChatUI", 7), Config.language("ChatUI", 8)];
            }
            else
            {
                _loc_5 = [Config.language("ChatUI", 4), Config.language("ChatUI", 6), Config.language("ChatUI", 7), Config.language("ChatUI", 8), Config.language("ChatUI", 5)];
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_5.length)
            {
                
                this._sayTypeArray.push({label:_loc_5[_loc_4], id:_loc_4, color:15060648});
                _loc_4 = _loc_4 + 1;
            }
            this._sayTypeArrayBigWar = [{label:Config.language("ChatUI", 11), id:6, color:13369344}];
            if (this._bigWar)
            {
                this._sayTypePBL.itemArray = this._sayTypeArrayBigWar;
                this._sayTypePBL.selectedItem = this._sayTypeArrayBigWar[0];
            }
            else
            {
                this._sayTypePBL.itemArray = this._sayTypeArray;
                this._sayTypePBL.selectedItem = this._sayTypeArray[0];
            }
            this._sayTypePBL.button.label = Config.language("ChatUI", 4);
            this.handleSayTypeChange();
            this.height = this._height;
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_CHAT, this.handleChat);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GR_CHAT, this.handleChatBigWar);
            addEventListener(MouseEvent.MOUSE_DOWN, this.handleMouseDown);
            addEventListener(MouseEvent.ROLL_OVER, this.handleMouseOver);
            addEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
            this._channelBg.alpha = 0;
            this._channelBg.visible = false;
            Config.startLoop(this.subInit);
            return;
        }// end function

        private function handleSayTypeOpen(param1)
        {
            var _loc_2:* = undefined;
            if (GuideUI.testId(180))
            {
                _loc_2 = 0;
                while (_loc_2 < this._sayTypePBL.itemArray.length)
                {
                    
                    if (this._sayTypePBL.itemArray[_loc_2].label == Config.language("ChatUI", 8))
                    {
                        GuideUI.doId(180, this._sayTypePBL.itemArray[_loc_2]._bindingPushButton);
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            return;
        }// end function

        private function subInit(param1)
        {
            Config.stopLoop(this.subInit);
            this._modeChange.selected = Config.chatMode;
            return;
        }// end function

        private function handleSplitMouseDown(param1)
        {
            this._splitMouseY = mouseY;
            this._preSplitPercent = this._splitPercent;
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.handleSplitMouseMove);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.handleSplitMouseUp);
            return;
        }// end function

        private function handleSplitMouseMove(param1)
        {
            var _loc_2:* = Math.round((this._height - 160) * this._preSplitPercent);
            _loc_2 = _loc_2 + (mouseY - this._splitMouseY);
            this.splitChange(_loc_2 / (this._height - 160));
            param1.updateAfterEvent();
            return;
        }// end function

        private function handleSplitMouseUp(param1)
        {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleSplitMouseMove);
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.handleSplitMouseUp);
            return;
        }// end function

        private function splitChange(param1)
        {
            this._splitPercent = Math.min(0.9, Math.max(0.1, param1));
            var _loc_2:* = Math.round((this._height - 160) * this._splitPercent);
            var _loc_3:* = this._height - 160 - _loc_2;
            this._channelRtf.y = -(this._height - 140);
            this._channelRtf.resize(this._width - 20, Math.max(0, _loc_2));
            this._channelScrollBar.y = -(this._height - 140);
            this._channelScrollBar.height = _loc_2;
            this._split3.y = -_loc_3 - 20;
            this._split3.height = 20;
            this._channelRtf2.y = -_loc_3;
            this._channelRtf2.resize(this._width - 20, _loc_3);
            this._channelScrollBar2.y = -_loc_3;
            this._channelScrollBar2.height = _loc_3;
            return;
        }// end function

        private function handleMouseOver(param1)
        {
            this._channelBg.removeEventListener(Event.ENTER_FRAME, this.bgAlphaDownLoop);
            this._channelBg.removeEventListener(Event.ENTER_FRAME, this.bgAlphaUpLoop);
            this._channelBg.visible = true;
            this._channelBg.addEventListener(Event.ENTER_FRAME, this.bgAlphaUpLoop);
            return;
        }// end function

        private function handleMouseOut(param1)
        {
            this._channelBg.removeEventListener(Event.ENTER_FRAME, this.bgAlphaDownLoop);
            this._channelBg.removeEventListener(Event.ENTER_FRAME, this.bgAlphaUpLoop);
            this._channelBg.visible = true;
            this._channelBg.addEventListener(Event.ENTER_FRAME, this.bgAlphaDownLoop);
            return;
        }// end function

        private function bgAlphaUpLoop(param1)
        {
            param1.currentTarget.alpha = param1.currentTarget.alpha + (1 - param1.currentTarget.alpha) / 3;
            if (param1.currentTarget.alpha >= 0.98)
            {
                param1.currentTarget.alpha = 1;
                param1.currentTarget.removeEventListener(Event.ENTER_FRAME, this.bgAlphaUpLoop);
            }
            return;
        }// end function

        private function bgAlphaDownLoop(param1)
        {
            param1.currentTarget.alpha = param1.currentTarget.alpha + -param1.currentTarget.alpha / 2;
            if (param1.currentTarget.alpha <= 0.02)
            {
                param1.currentTarget.alpha = 0;
                param1.currentTarget.visible = false;
                param1.currentTarget.removeEventListener(Event.ENTER_FRAME, this.bgAlphaDownLoop);
            }
            return;
        }// end function

        private function handleClearScreen(param1)
        {
            this.clear();
            return;
        }// end function

        private function clear()
        {
            this._channelRtf.clear();
            this._channelRtf1.clear();
            this._channelRtf2.clear();
            this._localStack = [];
            this._privateStack = [];
            this._teamStack = [];
            this._guildStack = [];
            this._worldStack = [];
            this._systemStack = [];
            this._bullStack = [];
            this._line = 0;
            this._line1 = 0;
            this._line2 = 0;
            this._line3 = 0;
            return;
        }// end function

        private function handleSayTypeChange(param1 = null)
        {
            var _loc_2:* = this._sayTypePBL.selectedItem.label;
            this._sayTypePBL.button.label = _loc_2.substring(0, Math.min(_loc_2.length, 4)) + " ";
            var _loc_3:* = true;
            var _loc_4:* = this._sayTypePBL.selectedItem.id;
            if (Config._switchMobage)
            {
                if (_loc_4 > 0)
                {
                    _loc_4++;
                }
                if (_loc_4 > 3)
                {
                    _loc_4++;
                }
            }
            switch(_loc_4)
            {
                case 0:
                {
                    this._sayType = CHAT_TYPE_ENUM.CHAT_MSG_MAP;
                    break;
                }
                case 1:
                {
                    this._sayType = CHAT_TYPE_ENUM.CHAT_MSG_TEAM;
                    break;
                }
                case 2:
                {
                    this._sayType = CHAT_TYPE_ENUM.CHAT_MSG_GUILD;
                    break;
                }
                case 3:
                {
                    this._sayType = CHAT_TYPE_ENUM.CHAT_MSG_WORLD;
                    if (GuideUI.testId(181))
                    {
                        GuideUI.doId(181, this._sayText);
                    }
                    break;
                }
                case 4:
                {
                    AlertUI.alert(Config.language("ChatUI", 12), "", [Config.language("ChatUI", 13), Config.language("ChatUI", 14)], [this.handleWhisper], null, true);
                    this._sayTypePBL.selectedItem = this._preSayType;
                    this._sayTypePBL.button.label = this._preSayType.label;
                    this.handleSayTypeChange();
                    _loc_3 = false;
                    break;
                }
                case 5:
                {
                    this._sayType = CHAT_TYPE_ENUM.CHAT_MSG_GM;
                    break;
                }
                case 6:
                {
                    this._sayType = CHAT_TYPE_ENUM.CHAT_MSG_BIGWAR;
                    break;
                }
                case 100:
                {
                    this._sayType = CHAT_TYPE_ENUM.CHAT_MSG_WHISPER;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._preSayType = this._sayTypePBL.selectedItem;
            if (_loc_3)
            {
                this.focus = true;
            }
            return;
        }// end function

        public function handleWhisper(param1, param2)
        {
            if (param2 != "")
            {
                this.whisperTo(param2);
            }
            return;
        }// end function

        public function whisperTo(param1)
        {
            if (param1 != "")
            {
                this.addPrivate(param1, true);
            }
            return;
        }// end function

        public function handleMouseDown(param1)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (Holder.item != null)
            {
                if (Holder.item._drawer == Config.ui._charUI._slotArray)
                {
                    if (this._sayText.length < this._sayText.maxChars)
                    {
                        if (this.howmanyItem() < 4)
                        {
                            _loc_2 = {};
                            _loc_3 = ["", Config.language("ProducePanel", 70), Config.language("ProducePanel", 71), Config.language("ProducePanel", 72), Config.language("ProducePanel", 73), Config.language("ProducePanel", 111)];
                            _loc_2.qual = Holder.item._itemData.addEffect.length;
                            _loc_2.name = Holder.item._itemData.name + _loc_3[_loc_2.qual];
                            _loc_2.id = Holder.item._itemData.id;
                            _loc_2.binding = Holder.item._itemData.binding;
                            _loc_2.washgrade = Holder.item._itemData.washgrade;
                            _loc_2.finegrade = Holder.item._itemData.finegrade;
                            _loc_2.amount = Holder.item._itemData.amount;
                            _loc_2.timeout = Holder.item._itemData.timeout;
                            _loc_2.suitID = Holder.item._itemData.suitID;
                            _loc_2.addEffect = Holder.item._itemData.addEffect;
                            _loc_2.gem = Holder.item._itemData.gem;
                            _loc_2._petBookObj = Holder.item._petBookObj;
                            _loc_2._petObj = Holder.item._petObj;
                            this._sayText.addSprite(new Ubb("<i:" + JSON.encode(_loc_2) + ">"));
                        }
                        else
                        {
                            Config.message(Config.language("ChatUI", 15));
                        }
                    }
                    this.focus = true;
                    Holder.item._drawer[Holder.item._position].item = Holder.item;
                    Holder.item = null;
                }
            }
            return;
        }// end function

        public function addLink(param1, param2)
        {
            if (this._sayText.length < this._sayText.maxChars)
            {
                this._sayText.addSprite(new Ubb("<l:" + Base64.encode(param1 + "," + param2) + ">"));
            }
            this.focus = true;
            return;
        }// end function

        public function addText(param1)
        {
            this._sayText.appendUbbText(param1, null, false);
            this.focus = true;
            return;
        }// end function

        private function refresh1()
        {
            var _loc_2:* = undefined;
            this._channelRtf1.clear();
            this._line1 = 0;
            var _loc_1:* = [];
            _loc_1 = _loc_1.concat(this._systemStack);
            _loc_1 = _loc_1.concat(this._bullStack);
            _loc_1.sortOn("t", Array.NUMERIC);
            var _loc_3:* = _loc_1.length;
            var _loc_4:* = Math.max(0, _loc_3 - MAX_LINE);
            _loc_2 = Math.max(0, _loc_3 - MAX_LINE);
            while (_loc_2 < _loc_3)
            {
                
                this._channelRtf1.appendUbbText(DescriptionTranslate.translate(_loc_1[_loc_2].s, this._channelRtf._textfield), _loc_1[_loc_2].f);
                var _loc_5:* = this;
                var _loc_6:* = this._line1 + 1;
                _loc_5._line1 = _loc_6;
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function refresh2()
        {
            var _loc_2:* = undefined;
            this._channelRtf.clear();
            this._line2 = 0;
            var _loc_1:* = [];
            if (this._localBtn1.selected)
            {
                _loc_1 = _loc_1.concat(this._localStack);
            }
            if (this._privateBtn1 != null && this._privateBtn1.selected)
            {
                _loc_1 = _loc_1.concat(this._privateStack);
            }
            if (this._teamBtn1 != null && this._teamBtn1.selected)
            {
                _loc_1 = _loc_1.concat(this._teamStack);
            }
            if (this._guildBtn1.selected)
            {
                _loc_1 = _loc_1.concat(this._guildStack);
            }
            if (this._worldBtn1.selected)
            {
                _loc_1 = _loc_1.concat(this._worldStack);
            }
            _loc_1.sortOn("t", Array.NUMERIC);
            var _loc_3:* = _loc_1.length;
            var _loc_4:* = Math.max(0, _loc_3 - MAX_LINE);
            _loc_2 = Math.max(0, _loc_3 - MAX_LINE);
            while (_loc_2 < _loc_3)
            {
                
                this._channelRtf.appendUbbText(DescriptionTranslate.translate(_loc_1[_loc_2].s, this._channelRtf._textfield), _loc_1[_loc_2].f);
                var _loc_5:* = this;
                var _loc_6:* = this._line2 + 1;
                _loc_5._line2 = _loc_6;
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function refresh3()
        {
            var _loc_2:* = undefined;
            this._channelRtf2.clear();
            this._line3 = 0;
            var _loc_1:* = [];
            if (this._localBtn2.selected)
            {
                _loc_1 = _loc_1.concat(this._localStack);
            }
            if (this._privateBtn2 != null && this._privateBtn2.selected)
            {
                _loc_1 = _loc_1.concat(this._privateStack);
            }
            if (this._teamBtn2 != null && this._teamBtn2.selected)
            {
                _loc_1 = _loc_1.concat(this._teamStack);
            }
            if (this._guildBtn2.selected)
            {
                _loc_1 = _loc_1.concat(this._guildStack);
            }
            if (this._worldBtn2.selected)
            {
                _loc_1 = _loc_1.concat(this._worldStack);
            }
            _loc_1.sortOn("t", Array.NUMERIC);
            var _loc_3:* = _loc_1.length;
            var _loc_4:* = Math.max(0, _loc_3 - MAX_LINE);
            _loc_2 = Math.max(0, _loc_3 - MAX_LINE);
            while (_loc_2 < _loc_3)
            {
                
                this._channelRtf2.appendUbbText(DescriptionTranslate.translate(_loc_1[_loc_2].s, this._channelRtf._textfield), _loc_1[_loc_2].f);
                var _loc_5:* = this;
                var _loc_6:* = this._line3 + 1;
                _loc_5._line3 = _loc_6;
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function refresh()
        {
            var _loc_2:* = undefined;
            this._channelRtf.clear();
            this._line = 0;
            var _loc_1:* = [];
            if (this._localBtn.selected)
            {
                _loc_1 = _loc_1.concat(this._localStack);
            }
            if (this._privateBtn != null && this._privateBtn.selected)
            {
                _loc_1 = _loc_1.concat(this._privateStack);
            }
            if (this._teamBtn != null && this._teamBtn.selected)
            {
                _loc_1 = _loc_1.concat(this._teamStack);
            }
            if (this._guildBtn.selected)
            {
                _loc_1 = _loc_1.concat(this._guildStack);
            }
            if (this._worldBtn.selected)
            {
                _loc_1 = _loc_1.concat(this._worldStack);
            }
            _loc_1 = _loc_1.concat(this._systemStack);
            _loc_1 = _loc_1.concat(this._bullStack);
            _loc_1.sortOn("t", Array.NUMERIC);
            var _loc_3:* = _loc_1.length;
            var _loc_4:* = Math.max(0, _loc_3 - MAX_LINE);
            _loc_2 = Math.max(0, _loc_3 - MAX_LINE);
            while (_loc_2 < _loc_3)
            {
                
                this._channelRtf.appendUbbText(DescriptionTranslate.translate(_loc_1[_loc_2].s, this._channelRtf._textfield), _loc_1[_loc_2].f);
                var _loc_5:* = this;
                var _loc_6:* = this._line + 1;
                _loc_5._line = _loc_6;
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function handleChannelSelect(event:MouseEvent)
        {
            if (event.currentTarget == this._localBtn && this._localStack.length == 0)
            {
                return;
            }
            if (event.currentTarget == this._privateBtn && this._privateStack.length == 0)
            {
                return;
            }
            if (event.currentTarget == this._teamBtn && this._teamStack.length == 0)
            {
                return;
            }
            if (event.currentTarget == this._guildBtn && this._guildStack.length == 0)
            {
                return;
            }
            if (event.currentTarget == this._worldBtn && this._worldStack.length == 0)
            {
                return;
            }
            this.refresh();
            return;
        }// end function

        private function handleChannelSelect1(event:MouseEvent)
        {
            if (event.currentTarget == this._localBtn1 && this._localStack.length == 0)
            {
                return;
            }
            if (event.currentTarget == this._privateBtn1 && this._privateStack.length == 0)
            {
                return;
            }
            if (event.currentTarget == this._teamBtn1 && this._teamStack.length == 0)
            {
                return;
            }
            if (event.currentTarget == this._guildBtn1 && this._guildStack.length == 0)
            {
                return;
            }
            if (event.currentTarget == this._worldBtn1 && this._worldStack.length == 0)
            {
                return;
            }
            this.refresh2();
            return;
        }// end function

        private function handleChannelSelect2(event:MouseEvent)
        {
            if (event.currentTarget == this._localBtn2 && this._localStack.length == 0)
            {
                return;
            }
            if (event.currentTarget == this._privateBtn2 && this._privateStack.length == 0)
            {
                return;
            }
            if (event.currentTarget == this._teamBtn2 && this._teamStack.length == 0)
            {
                return;
            }
            if (event.currentTarget == this._guildBtn2 && this._guildStack.length == 0)
            {
                return;
            }
            if (event.currentTarget == this._worldBtn2 && this._worldStack.length == 0)
            {
                return;
            }
            this.refresh3();
            return;
        }// end function

        private function handleSayTextInput(param1)
        {
            this._preSayIndex = -1;
            return;
        }// end function

        public function upPreSay()
        {
            if (this._preSayBuff.length > 0)
            {
                if (this._preSayIndex < (this._preSayBuff.length - 1))
                {
                    var _loc_1:* = this;
                    var _loc_2:* = this._preSayIndex + 1;
                    _loc_1._preSayIndex = _loc_2;
                }
                this._sayText.ubbText = this._preSayBuff[this._preSayIndex];
            }
            return;
        }// end function

        public function downPreSay()
        {
            if (this._preSayBuff.length > 0)
            {
                if (this._preSayIndex > 0)
                {
                    var _loc_1:* = this;
                    var _loc_2:* = this._preSayIndex - 1;
                    _loc_1._preSayIndex = _loc_2;
                }
                this._sayText.ubbText = this._preSayBuff[this._preSayIndex];
            }
            return;
        }// end function

        private function handleSayBtnClick(param1)
        {
            this.say();
            return;
        }// end function

        private function handleHeightSwitchMouseClick(param1)
        {
            if (this.height == 40)
            {
                this.height = 120;
                this._preHeight = 120;
            }
            else if (this.height == 120)
            {
                this.height = 350;
                this._preHeight = 350;
            }
            else if (this.height == 350)
            {
                this.height = 40;
                this._preHeight = 40;
            }
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._width = Math.min(Config.ui._width, param1);
            this._heightSwitch.x = this._width - 29;
            this._localBtn.x = 5;
            if (Config._switchMobage)
            {
                this._guildBtn.x = int(5 + this._width / 3 * 1);
                this._worldBtn.x = int(5 + this._width / 3 * 2);
            }
            else
            {
                this._privateBtn.x = int(5 + this._width / 5.3 * 1);
                this._teamBtn.x = int(5 + this._width / 5.3 * 2);
                this._guildBtn.x = int(5 + this._width / 5.3 * 3);
                this._worldBtn.x = int(5 + this._width / 5.3 * 4);
            }
            this._locker1.x = 3;
            this._locker2.x = 3;
            if (Config._switchMobage)
            {
                this._localBtn1.x = int(-4 + this._width / 4 * 1);
                this._guildBtn1.x = int(-4 + this._width / 4 * 2);
                this._worldBtn1.x = int(-4 + this._width / 4 * 3);
            }
            else
            {
                this._localBtn1.x = int(-4 + this._width / 5.7 * 1);
                this._privateBtn1.x = int(-4 + this._width / 5.7 * 2);
                this._teamBtn1.x = int(-4 + this._width / 5.7 * 3);
                this._guildBtn1.x = int(-4 + this._width / 5.7 * 4);
                this._worldBtn1.x = int(-4 + this._width / 5.7 * 5);
            }
            if (Config._switchMobage)
            {
                this._localBtn2.x = int(-4 + this._width / 4 * 1);
                this._guildBtn2.x = int(-4 + this._width / 4 * 2);
                this._worldBtn2.x = int(-4 + this._width / 4 * 3);
            }
            else
            {
                this._localBtn2.x = int(-4 + this._width / 5.7 * 1);
                this._privateBtn2.x = int(-4 + this._width / 5.7 * 2);
                this._teamBtn2.x = int(-4 + this._width / 5.7 * 3);
                this._guildBtn2.x = int(-4 + this._width / 5.7 * 4);
                this._worldBtn2.x = int(-4 + this._width / 5.7 * 5);
            }
            if (this._mode == 0)
            {
                this._channelScrollBar.x = this._width - 24;
                this._channelRtf.resize(this._width - 30, this._height - 16);
                this._bg.resize(this._width - 16);
                this._sayBtn.x = this._width - 64;
                this._sayText.resize(this._width - 143, 20);
                if (!Config._switchMobage)
                {
                    this._ubbCB.x = this._width - 108;
                }
            }
            else if (this._mode == 1)
            {
                this._split1.width = this._width;
                this._split2.width = this._width;
                this._split3.width = this._width;
                this._channelScrollBar.x = this._width - 12;
                this._channelScrollBar1.x = this._width - 12;
                this._channelScrollBar2.x = this._width - 12;
                this._channelRtf.resize(this._width - 20, this._height - 16);
                this._bg.resize(this._width);
                this._sayBtn.x = this._width - 38;
                this._sayText.resize(this._width - 117, 20);
                if (!Config._switchMobage)
                {
                    this._ubbCB.x = this._width - 82;
                }
            }
            this._channelBg.graphics.clear();
            if (this._mode == 0)
            {
                this._channelBg.graphics.beginFill(0, 0.5);
                this._channelBg.graphics.drawRect(0, -this._height - 16, 180, 16);
                this._channelBg.graphics.endFill();
                this._channelBg.graphics.beginFill(0, 0.5);
            }
            else
            {
                this._channelBg.graphics.beginFill(4338226, 1);
            }
            this._channelBg.graphics.drawRect(0, -this._height, this._width - 12, this._height + 14);
            this._channelBg.graphics.endFill();
            return;
        }// end function

        override public function get width() : Number
        {
            return this._width;
        }// end function

        override public function set height(param1:Number) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            this._height = param1;
            if (this._mode == 0)
            {
                this._locker.y = -this._height - 12;
                this._cls.y = -this._height - 12;
                this._modeChange.y = -this._height - 12;
                this._channelRtf.y = -this._height;
                this._channelRtf.resize(this._width - 30, Math.max(0, this._height - 16));
                this._channelScrollBar.height = this._height;
                this._channelScrollBar.y = -this._height;
            }
            else if (this._mode == 1)
            {
                this._cls.y = -this._height + 5;
                this._modeChange.y = -this._height + 5;
                this._split1.y = -this._height;
                this._split1.height = 20;
                this._channelRtf1.y = -(this._height - 20);
                this._channelRtf1.resize(this._width - 20, 100);
                this._channelScrollBar1.y = -(this._height - 20);
                this._channelScrollBar1.height = 100;
                this._split2.y = -(this._height - 120);
                this._split2.height = 20;
                _loc_2 = Math.round((this._height - 160) * this._splitPercent);
                _loc_3 = this._height - 160 - _loc_2;
                this._channelRtf.y = -(this._height - 140);
                this._channelRtf.resize(this._width - 20, Math.max(0, _loc_2));
                this._channelScrollBar.y = -(this._height - 140);
                this._channelScrollBar.height = _loc_2;
                this._split3.y = -_loc_3 - 20;
                this._split3.height = 20;
                this._channelRtf2.y = -_loc_3;
                this._channelRtf2.resize(this._width - 20, _loc_3);
                this._channelScrollBar2.y = -_loc_3;
                this._channelScrollBar2.height = _loc_3;
            }
            this._channelBg.graphics.clear();
            if (this._mode == 0)
            {
                this._channelBg.graphics.beginFill(0, 0.5);
                this._channelBg.graphics.drawRect(0, -this._height - 16, 170, 16);
                this._channelBg.graphics.endFill();
                this._channelBg.graphics.beginFill(0, 0.5);
            }
            else
            {
                this._channelBg.graphics.beginFill(4338226, 1);
            }
            this._channelBg.graphics.drawRect(0, -this._height, this._width - 12, this._height + 14);
            this._channelBg.graphics.endFill();
            return;
        }// end function

        override public function get height() : Number
        {
            return this._height;
        }// end function

        private function handleChatBigWar(param1)
        {
            var _loc_2:* = undefined;
            var _loc_4:* = undefined;
            var _loc_3:* = param1.data;
            var _loc_5:* = _loc_3.readUnsignedInt();
            _loc_4 = _loc_3.readUnsignedShort();
            var _loc_6:* = _loc_3.readUTFBytes(_loc_4);
            _loc_4 = _loc_3.readUnsignedShort();
            var _loc_7:* = _loc_3.readUTFBytes(_loc_4);
            var _loc_8:* = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_5);
            if (Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_5) != null)
            {
                _loc_8.say(_loc_7);
            }
            _loc_2 = Config.language("ChatUI", 16, Base64.encode(_loc_6)) + _loc_7;
            this._localStack.push({t:getTimer(), s:_loc_2, f:this._localFormat});
            while (this._localStack.length > MAX_STACK)
            {
                
                this._localStack.shift();
            }
            if (this._mode == 0)
            {
                if (this._localBtn.selected && !this._locker.selected)
                {
                    if (this._line > MAX_LINE * 2)
                    {
                        this.refresh();
                    }
                    else
                    {
                        this._channelRtf.appendUbbText(_loc_2, this._localFormat);
                        var _loc_9:* = this;
                        var _loc_10:* = this._line + 1;
                        _loc_9._line = _loc_10;
                    }
                }
            }
            else
            {
                if (this._localBtn1.selected && !this._locker1.selected)
                {
                    if (this._line2 > MAX_LINE * 2)
                    {
                        this.refresh2();
                    }
                    else
                    {
                        this._channelRtf.appendUbbText(_loc_2, this._localFormat);
                        var _loc_9:* = this;
                        var _loc_10:* = this._line2 + 1;
                        _loc_9._line2 = _loc_10;
                    }
                }
                if (this._localBtn2.selected && !this._locker2.selected)
                {
                    if (this._line3 > MAX_LINE * 2)
                    {
                        this.refresh3();
                    }
                    else
                    {
                        this._channelRtf2.appendUbbText(_loc_2, this._localFormat);
                        var _loc_9:* = this;
                        var _loc_10:* = this._line3 + 1;
                        _loc_9._line3 = _loc_10;
                    }
                }
            }
            return;
        }// end function

        private function handleChat(param1)
        {
            var _loc_2:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = undefined;
            var _loc_17:* = undefined;
            var _loc_18:* = undefined;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = null;
            var _loc_23:* = undefined;
            var _loc_3:* = param1.data;
            if (Recorder.recording)
            {
                _loc_14 = new ByteArray();
                _loc_14.endian = Endian.LITTLE_ENDIAN;
                _loc_14.writeShort(CONST_ENUM.G2C_CHAT);
                _loc_14.writeBytes(_loc_3, 0, _loc_3.length);
                _loc_14.position = 0;
            }
            var _loc_6:* = _loc_3.readByte();
            var _loc_7:* = _loc_3.readUnsignedShort();
            var _loc_8:* = _loc_3.readUnsignedInt();
            _loc_4 = _loc_3.readUnsignedShort();
            var _loc_9:* = _loc_3.readUTFBytes(_loc_4);
            var _loc_10:* = _loc_3.readUnsignedByte();
            var _loc_11:* = _loc_3.readUnsignedShort();
            var _loc_12:* = _loc_3.readUnsignedShort();
            _loc_4 = _loc_3.readUnsignedShort();
            var _loc_13:* = _loc_3.readUTFBytes(_loc_4);
            if (_loc_3.readUTFBytes(_loc_4).substring(0, 3) == "fb:")
            {
                _loc_13 = Config._actorMsg[int(_loc_13.substring(3))].msg;
            }
            if (_loc_6 == CHAT_TYPE_ENUM.CHAT_MSG_WHISPER)
            {
                _loc_4 = _loc_3.readUnsignedShort();
                _loc_16 = _loc_3.readUTFBytes(_loc_4);
                _loc_17 = _loc_3.readUnsignedInt();
                _loc_18 = _loc_3.readUnsignedByte();
                _loc_19 = _loc_3.readUnsignedShort();
                _loc_20 = _loc_3.readUnsignedShort();
            }
            if (_loc_6 == CHAT_TYPE_ENUM.CHAT_MSG_WHISPER)
            {
                _loc_21 = Config.ui._friendUI.judgeblakname(_loc_9);
                if (_loc_21 == 3)
                {
                    return;
                }
                if (_loc_9 == Player.name)
                {
                    _loc_2 = Config.language("ChatUI", 17, Base64.encode(_loc_16 + "^" + _loc_17 + "^" + _loc_18 + "^" + _loc_19 + "^" + _loc_20), _loc_13);
                    _loc_15 = this._privateOwnFormat;
                }
                else
                {
                    _loc_2 = Config.language("ChatUI", 19, Base64.encode(_loc_9 + "^" + _loc_8 + "^" + _loc_10 + "^" + _loc_11 + "^" + _loc_12), _loc_13);
                    _loc_15 = this._privateFormat;
                }
                this._privateStack.push({t:getTimer(), s:_loc_2, f:_loc_15});
                while (this._privateStack.length > MAX_STACK)
                {
                    
                    this._privateStack.shift();
                }
                if (this._mode == 0)
                {
                    if (this._privateBtn != null && this._privateBtn.selected && !this._locker.selected)
                    {
                        if (this._line > MAX_LINE * 2)
                        {
                            this.refresh();
                        }
                        else
                        {
                            this._channelRtf.appendUbbText(_loc_2, _loc_15);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line + 1;
                            _loc_24._line = _loc_25;
                        }
                    }
                }
                else
                {
                    if (this._privateBtn1 != null && this._privateBtn1.selected && !this._locker1.selected)
                    {
                        if (this._line2 > MAX_LINE * 2)
                        {
                            this.refresh2();
                        }
                        else
                        {
                            this._channelRtf.appendUbbText(_loc_2, _loc_15);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line2 + 1;
                            _loc_24._line2 = _loc_25;
                        }
                    }
                    if (this._privateBtn2 != null && this._privateBtn2.selected && !this._locker2.selected)
                    {
                        if (this._line3 > MAX_LINE * 2)
                        {
                            this.refresh3();
                        }
                        else
                        {
                            this._channelRtf2.appendUbbText(_loc_2, _loc_15);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line3 + 1;
                            _loc_24._line3 = _loc_25;
                        }
                    }
                }
            }
            else if (_loc_6 == CHAT_TYPE_ENUM.CHAT_MSG_WORLD)
            {
                _loc_21 = Config.ui._friendUI.judgeblakname(_loc_9);
                if (_loc_21 == 3)
                {
                    return;
                }
                _loc_2 = Config.language("ChatUI", 21, Base64.encode(_loc_9 + "^" + _loc_8 + "^" + _loc_10) + "^" + _loc_11 + "^" + _loc_12) + _loc_13;
                this._worldStack.push({t:getTimer(), s:_loc_2, f:this._worldFormat});
                while (this._worldStack.length > MAX_STACK)
                {
                    
                    this._worldStack.shift();
                }
                if (this._mode == 0)
                {
                    if (this._worldBtn.selected && !this._locker.selected)
                    {
                        if (this._line > MAX_LINE * 2)
                        {
                            this.refresh();
                        }
                        else
                        {
                            this._channelRtf.appendUbbText(_loc_2, this._worldFormat);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line + 1;
                            _loc_24._line = _loc_25;
                        }
                    }
                }
                else
                {
                    if (this._worldBtn1.selected && !this._locker1.selected)
                    {
                        if (this._line2 > MAX_LINE * 2)
                        {
                            this.refresh2();
                        }
                        else
                        {
                            this._channelRtf.appendUbbText(_loc_2, this._worldFormat);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line2 + 1;
                            _loc_24._line2 = _loc_25;
                        }
                    }
                    if (this._worldBtn2.selected && !this._locker2.selected)
                    {
                        if (this._line3 > MAX_LINE * 2)
                        {
                            this.refresh3();
                        }
                        else
                        {
                            this._channelRtf2.appendUbbText(_loc_2, this._worldFormat);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line3 + 1;
                            _loc_24._line3 = _loc_25;
                        }
                    }
                }
            }
            else if (_loc_6 == CHAT_TYPE_ENUM.CHAT_MSG_GUILD)
            {
                _loc_2 = Config.language("ChatUI", 22, Base64.encode(_loc_9 + "^" + _loc_8 + "^" + _loc_10) + "^" + _loc_11 + "^" + _loc_12) + _loc_13;
                this._guildStack.push({t:getTimer(), s:_loc_2, f:this._guildFormat});
                while (this._guildStack.length > MAX_STACK)
                {
                    
                    this._guildStack.shift();
                }
                if (this._mode == 0)
                {
                    if (this._guildBtn.selected && !this._locker.selected)
                    {
                        if (this._line > MAX_LINE * 2)
                        {
                            this.refresh();
                        }
                        else
                        {
                            this._channelRtf.appendUbbText(_loc_2, this._guildFormat);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line + 1;
                            _loc_24._line = _loc_25;
                        }
                    }
                }
                else
                {
                    if (this._guildBtn1.selected && !this._locker1.selected)
                    {
                        if (this._line2 > MAX_LINE * 2)
                        {
                            this.refresh2();
                        }
                        else
                        {
                            this._channelRtf.appendUbbText(_loc_2, this._guildFormat);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line2 + 1;
                            _loc_24._line2 = _loc_25;
                        }
                    }
                    if (this._guildBtn2.selected && !this._locker2.selected)
                    {
                        if (this._line3 > MAX_LINE * 2)
                        {
                            this.refresh3();
                        }
                        else
                        {
                            this._channelRtf2.appendUbbText(_loc_2, this._guildFormat);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line3 + 1;
                            _loc_24._line3 = _loc_25;
                        }
                    }
                }
            }
            else if (_loc_6 == CHAT_TYPE_ENUM.CHAT_MSG_FRIEND)
            {
            }
            else if (_loc_6 == CHAT_TYPE_ENUM.CHAT_MSG_TEAM)
            {
                _loc_2 = Config.language("ChatUI", 23, Base64.encode(_loc_9 + "^" + _loc_8 + "^" + _loc_10) + "^" + _loc_11 + "^" + _loc_12) + _loc_13;
                this._teamStack.push({t:getTimer(), s:_loc_2, f:this._teamFormat});
                while (this._teamStack.length > MAX_STACK)
                {
                    
                    this._teamStack.shift();
                }
                if (this._mode == 0)
                {
                    if (this._teamBtn != null && this._teamBtn.selected && !this._locker.selected)
                    {
                        if (this._line > MAX_LINE * 2)
                        {
                            this.refresh();
                        }
                        else
                        {
                            this._channelRtf.appendUbbText(_loc_2, this._teamFormat);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line + 1;
                            _loc_24._line = _loc_25;
                        }
                    }
                }
                else
                {
                    if (this._teamBtn1 != null && this._teamBtn1.selected && !this._locker1.selected)
                    {
                        if (this._line2 > MAX_LINE * 2)
                        {
                            this.refresh2();
                        }
                        else
                        {
                            this._channelRtf.appendUbbText(_loc_2, this._teamFormat);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line2 + 1;
                            _loc_24._line2 = _loc_25;
                        }
                    }
                    if (this._teamBtn2 != null && this._teamBtn2.selected && !this._locker2.selected)
                    {
                        if (this._line3 > MAX_LINE * 2)
                        {
                            this.refresh3();
                        }
                        else
                        {
                            this._channelRtf2.appendUbbText(_loc_2, this._teamFormat);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line3 + 1;
                            _loc_24._line3 = _loc_25;
                        }
                    }
                }
            }
            else if (_loc_6 == CHAT_TYPE_ENUM.CHAT_MSG_MAP)
            {
                Recorder.pushAction(_loc_14);
                if (_loc_7 == 0)
                {
                    _loc_5 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_8);
                }
                else if (_loc_7 == 1)
                {
                    _loc_5 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_UNIT, _loc_8);
                }
                else if (_loc_7 == 2)
                {
                    _loc_5 = Unit.getGameObject(_loc_8);
                }
                if (_loc_5 != null)
                {
                    _loc_5.say(_loc_13);
                }
                if (_loc_9 == "")
                {
                    if (_loc_5 != null)
                    {
                        _loc_9 = _loc_5.name;
                    }
                    else
                    {
                        _loc_9 = Config.language("ChatUI", 24);
                    }
                }
                _loc_2 = Config.language("ChatUI", 25, Base64.encode(_loc_9 + "^" + _loc_8 + "^" + _loc_10) + "^" + _loc_11 + "^" + _loc_12) + _loc_13;
                this._localStack.push({t:getTimer(), s:_loc_2, f:this._localFormat});
                while (this._localStack.length > MAX_STACK)
                {
                    
                    this._localStack.shift();
                }
                if (this._mode == 0)
                {
                    if (this._localBtn.selected && !this._locker.selected)
                    {
                        if (this._line > MAX_LINE * 2)
                        {
                            this.refresh();
                        }
                        else
                        {
                            this._channelRtf.appendUbbText(_loc_2, this._localFormat);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line + 1;
                            _loc_24._line = _loc_25;
                        }
                    }
                }
                else
                {
                    if (this._localBtn1.selected && !this._locker1.selected)
                    {
                        if (this._line2 > MAX_LINE * 2)
                        {
                            this.refresh2();
                        }
                        else
                        {
                            this._channelRtf.appendUbbText(_loc_2, this._localFormat);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line2 + 1;
                            _loc_24._line2 = _loc_25;
                        }
                    }
                    if (this._localBtn2.selected && !this._locker2.selected)
                    {
                        if (this._line3 > MAX_LINE * 2)
                        {
                            this.refresh3();
                        }
                        else
                        {
                            this._channelRtf2.appendUbbText(_loc_2, this._localFormat);
                            var _loc_24:* = this;
                            var _loc_25:* = this._line3 + 1;
                            _loc_24._line3 = _loc_25;
                        }
                    }
                }
            }
            else if (_loc_6 == CHAT_TYPE_ENUM.CHAT_MSG_SYS)
            {
                _loc_13 = DescriptionTranslate.transSystem(_loc_13);
                this.showSys(_loc_13);
            }
            else if (_loc_6 == CHAT_TYPE_ENUM.CHAT_MSG_BULLETIN)
            {
                _loc_22 = _loc_13.substring(5).split("|");
                _loc_23 = Number(_loc_22[0]);
                if (_loc_23 == 94001 || _loc_23 == 94002 || _loc_23 == 94003 || _loc_23 == 94004 || _loc_23 == 94009 || _loc_23 == 94008)
                {
                    _loc_13 = DescriptionTranslate.transSystem(_loc_13);
                    _loc_13 = _loc_13.replace(/<br\/>""<br\/>/g, "\n");
                    if (_loc_23 == 94008)
                    {
                        this.showBull(_loc_13, false, this._sp1Format);
                    }
                    else
                    {
                        this.showBull(_loc_13, false);
                    }
                }
                else if (_loc_23 == 94005)
                {
                    this._koreaSys1Timer = setTimeout(this.koreaSys1, 1000, _loc_13, getTimer());
                }
                else if (_loc_23 == 94006)
                {
                    _loc_13 = DescriptionTranslate.transSystem(_loc_13);
                    AlertUI.alert(Config.language("ChatUI", 31), _loc_13, [Config.language("DescriptionTranslate", 220)], [this.handleShutdown]);
                    AlertUI._locked = true;
                }
                else
                {
                    _loc_13 = DescriptionTranslate.transSystem(_loc_13);
                    if (_loc_23 == 15500 || _loc_23 == 15501)
                    {
                        this.showBull(_loc_13, false);
                    }
                    else
                    {
                        this.showBull(_loc_13);
                    }
                }
            }
            return;
        }// end function

        private function handleShutdown(param1 = null)
        {
            var _loc_2:* = "http://kl.koramgame.co.kr/2011/1226/article_126.html";
            var _loc_3:* = new URLRequest(_loc_2);
            navigateToURL(_loc_3, "_self");
            return;
        }// end function

        private function koreaSys1(param1, param2)
        {
            clearTimeout(this._koreaSys1Timer);
            if (getTimer() - param2 >= 49 * 1000)
            {
                param1 = DescriptionTranslate.transSystem(param1);
                param1 = param1.replace(/<br\/>""<br\/>/g, "\n");
                this.showBull(param1, false);
            }
            else
            {
                this._koreaSys1Timer = setTimeout(this.koreaSys1, 1000, param1, param2);
            }
            return;
        }// end function

        public function showSys(param1)
        {
            var _loc_2:* = Config.language("ChatUI", 26) + param1;
            this._systemStack.push({t:getTimer(), s:_loc_2, f:this._systemFormat});
            while (this._systemStack.length > MAX_STACK)
            {
                
                this._systemStack.shift();
            }
            if (this._mode == 0)
            {
                if (!this._locker.selected)
                {
                    if (this._line > MAX_LINE * 2)
                    {
                        this.refresh();
                    }
                    else
                    {
                        this._channelRtf.appendUbbText(DescriptionTranslate.translate(_loc_2, this._channelRtf._textfield), this._systemFormat);
                        var _loc_3:* = this;
                        var _loc_4:* = this._line + 1;
                        _loc_3._line = _loc_4;
                    }
                }
            }
            else if (this._line1 > MAX_LINE * 2)
            {
                this.refresh1();
            }
            else
            {
                this._channelRtf1.appendUbbText(DescriptionTranslate.translate(_loc_2, this._channelRtf._textfield), this._systemFormat);
                var _loc_3:* = this;
                var _loc_4:* = this._line1 + 1;
                _loc_3._line1 = _loc_4;
            }
            return;
        }// end function

        public function showGMT(param1:String)
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            while (param1.indexOf("<p><a href=\"") != -1)
            {
                
                _loc_3 = param1.indexOf("<p><a href=\"");
                _loc_4 = param1.indexOf("\">", _loc_3);
                _loc_5 = param1.indexOf("</a></p>", _loc_3);
                if (_loc_3 != -1 && _loc_4 != -1 && _loc_5 != -1)
                {
                    _loc_6 = param1.substring(_loc_3 + 12, _loc_4);
                    _loc_7 = param1.substring(_loc_4 + 2, _loc_5);
                    param1 = param1.substring(0, _loc_3) + "<l:" + _loc_7 + "," + _loc_6 + ">" + param1.substring(_loc_5 + 8);
                    continue;
                }
                break;
            }
            var _loc_2:* = Config.language("ChatUI", 27) + param1;
            this._bullStack.push({t:getTimer(), s:_loc_2, f:this._bullFormat});
            while (this._bullStack.length > MAX_STACK)
            {
                
                this._bullStack.shift();
            }
            if (this._mode == 0)
            {
                if (!this._locker.selected)
                {
                    if (this._line > MAX_LINE * 2)
                    {
                        this.refresh();
                    }
                    else
                    {
                        this._channelRtf.appendUbbText(DescriptionTranslate.translate(_loc_2, this._channelRtf._textfield), this._bullFormat);
                        var _loc_8:* = this;
                        var _loc_9:* = this._line + 1;
                        _loc_8._line = _loc_9;
                    }
                }
            }
            else if (this._line1 > MAX_LINE * 2)
            {
                this.refresh1();
            }
            else
            {
                this._channelRtf1.appendUbbText(DescriptionTranslate.translate(_loc_2, this._channelRtf._textfield), this._bullFormat);
                var _loc_8:* = this;
                var _loc_9:* = this._line1 + 1;
                _loc_8._line1 = _loc_9;
            }
            return;
        }// end function

        private function clearName(param1:String)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            while (true)
            {
                
                _loc_2 = param1.indexOf("<n:");
                if (_loc_2 == -1)
                {
                    return param1;
                }
                _loc_3 = param1.indexOf(">", _loc_2);
                _loc_4 = param1.substring(_loc_2 + 3, _loc_3);
                param1 = param1.substring(0, _loc_2) + Base64.decode(_loc_4) + param1.substring((_loc_3 + 1));
            }
            return;
        }// end function

        public function showBull(param1, param2:Boolean = true, param3:TextFormat = null)
        {
            var _loc_4:* = undefined;
            if (param1 == null)
            {
                return;
            }
            if (param2)
            {
                Billboard.show(this.clearName(DescriptionTranslate.translate(param1)));
            }
            _loc_4 = Config.language("ChatUI", 27) + param1;
            var _loc_5:* = this._bullFormat;
            if (param3 != null)
            {
                _loc_5 = param3;
            }
            this._bullStack.push({t:getTimer(), s:_loc_4, f:_loc_5});
            while (this._bullStack.length > MAX_STACK)
            {
                
                this._bullStack.shift();
            }
            if (this._mode == 0)
            {
                if (!this._locker.selected)
                {
                    if (this._line > MAX_LINE * 2)
                    {
                        this.refresh();
                    }
                    else
                    {
                        _loc_4 = DescriptionTranslate.translate(_loc_4, this._channelRtf._textfield);
                        this._channelRtf.appendUbbText(DescriptionTranslate.translate(_loc_4, this._channelRtf._textfield), _loc_5);
                        var _loc_6:* = this;
                        var _loc_7:* = this._line + 1;
                        _loc_6._line = _loc_7;
                    }
                }
            }
            else if (this._line1 > MAX_LINE * 2)
            {
                this.refresh1();
            }
            else
            {
                this._channelRtf1.appendUbbText(DescriptionTranslate.translate(_loc_4, this._channelRtf._textfield), _loc_5);
                var _loc_6:* = this;
                var _loc_7:* = this._line1 + 1;
                _loc_6._line1 = _loc_7;
            }
            return;
        }// end function

        public function get focus()
        {
            return this._sayText.focus;
        }// end function

        public function set focus(param1)
        {
            this._sayText.focus = param1;
            return;
        }// end function

        private function handleUbbClick(param1)
        {
            if (!Config._switchMobage)
            {
                if (this._sayText.length < this._sayText.maxChars)
                {
                    this._sayText.addSprite(new Ubb("<f:" + Base64.encode(this._ubbCB.selectedItem.id) + ">"));
                    this._preSayIndex = -1;
                    removeEventListener(Event.ENTER_FRAME, this.setFocusOn);
                    addEventListener(Event.ENTER_FRAME, this.setFocusOn);
                }
            }
            return;
        }// end function

        private function setFocusOn(param1)
        {
            removeEventListener(Event.ENTER_FRAME, this.setFocusOn);
            this.focus = true;
            return;
        }// end function

        private function targetEffect(param1, param2, param3)
        {
            param1.hitState(param1, 200, false, String(param2), param3);
            return;
        }// end function

        private function removeTarget(param1)
        {
            param1.destroy();
            return;
        }// end function

        private function howmanyItem()
        {
            var _loc_2:* = undefined;
            var _loc_1:* = this._sayText.ubbText;
            var _loc_3:* = 0;
            do
            {
                
                _loc_2 = _loc_1.indexOf("<i:", (_loc_2 + 1));
                _loc_3 = _loc_3 + 1;
            }while (_loc_2 >= 0)
            return _loc_3;
        }// end function

        public function say()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._sayText.ubbText.length > 0)
            {
                if (this._sayText.ubbText.indexOf("-debug") == 0)
                {
                    Config.debug = !Config.debug;
                    if (Config.debug)
                    {
                        this.showSys(Config.language("ChatUI", 28));
                    }
                    else
                    {
                        this.showSys(Config.language("ChatUI", 29));
                    }
                    return;
                }
                else
                {
                    if (this._sayText.ubbText.indexOf("-ver") == 0)
                    {
                        this.showSys(Config.language("ChatUI", 30) + Config.ver + Config.language("ChatUI", 31) + Config.dataVer);
                        return;
                    }
                    if (this._sayText.ubbText.indexOf("-now") == 0)
                    {
                        this.showSys("now:" + Config.now);
                        return;
                    }
                    if (this._sayText.ubbText.indexOf("-guide") == 0)
                    {
                        GuideUI.reset();
                        return;
                    }
                    if (this._sayText.ubbText.indexOf("-observe") == 0)
                    {
                        if (Observe._power == 2)
                        {
                            if (ObserveUI.instance == null)
                            {
                                new ObserveUI(Config.ui._layer1, 10, 10);
                            }
                            ObserveUI.instance.open();
                        }
                        return;
                    }
                    else
                    {
                        if (this._sayText.ubbText.indexOf("-bull") == 0)
                        {
                            this.showBull(DescriptionTranslate.transSystem(this._sayText.ubbText.substring(6)));
                            return;
                        }
                        if (this._sayText.ubbText.indexOf("-mem") == 0)
                        {
                            if (Config.map._state == "ready")
                            {
                                this.showSys(Config.language("ChatUI", 32) + Config.bytesToString(System.totalMemory));
                                BitmapLoader.clearBuff(true);
                                Config.gc();
                                setTimeout(this.handleMemTest, 1000);
                            }
                            return;
                        }
                        else if (this._sayText.ubbText.indexOf("-automem") == 0)
                        {
                            Config.autoMemoryClear = !Config.autoMemoryClear;
                            if (Config.autoMemoryClear)
                            {
                                this.showSys(Config.language("ChatUI", 33));
                            }
                            else
                            {
                                this.showSys(Config.language("ChatUI", 34));
                            }
                            return;
                        }
                        else if (this._sayText.ubbText.substring(0, 3) == "gm ")
                        {
                            _loc_2 = new DataSet();
                            _loc_2.addHead(CONST_ENUM.C2G_CHAT);
                            _loc_2.add8(CHAT_TYPE_ENUM.CHAT_MSG_GM);
                            _loc_2.addUTF(this._sayText.ubbText.substring(3));
                            ClientSocket.send(_loc_2);
                            return;
                        }
                    }
                }
                if (this._sayType == CHAT_TYPE_ENUM.CHAT_MSG_WORLD)
                {
                    if (Config.player.level < 10)
                    {
                        this._channelRtf.appendUbbText(Config.language("ChatUI", 35), this._systemFormat);
                        var _loc_4:* = this;
                        var _loc_5:* = this._line + 1;
                        _loc_4._line = _loc_5;
                        if (this._line > MAX_LINE * 2)
                        {
                            this.refresh();
                        }
                        return;
                    }
                    if (this._preWorldTime != null && getTimer() - this._preWorldTime < 5000)
                    {
                        this._channelRtf.appendUbbText(Config.language("ChatUI", 36), this._systemFormat);
                        var _loc_4:* = this;
                        var _loc_5:* = this._line + 1;
                        _loc_4._line = _loc_5;
                        if (this._line > MAX_LINE * 2)
                        {
                            this.refresh();
                        }
                        return;
                    }
                    this._preWorldTime = getTimer();
                    GuideUI.testDoId(182);
                }
                if (this._sayType == CHAT_TYPE_ENUM.CHAT_MSG_BIGWAR)
                {
                    _loc_3 = this._sayText.ubbText;
                    while (_loc_3.substring(0, 1) == " ")
                    {
                        
                        _loc_3 = _loc_3.substring(1);
                    }
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2G_GR_CHAT);
                    _loc_2.addUTF(_loc_3);
                    ClientSocket.send(_loc_2);
                }
                else
                {
                    _loc_3 = this._sayText.ubbText;
                    while (_loc_3.substring(0, 1) == " ")
                    {
                        
                        _loc_3 = _loc_3.substring(1);
                    }
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2G_CHAT);
                    _loc_2.add8(this._sayType);
                    _loc_2.addUTF(_loc_3);
                    if (this._sayType == CHAT_TYPE_ENUM.CHAT_MSG_WHISPER)
                    {
                        _loc_2.addUTF(this._sayTypePBL.selectedItem.name);
                    }
                    ClientSocket.send(_loc_2);
                }
                if (this._preSayBuff[0] != this._sayText.ubbText)
                {
                    this._preSayBuff.unshift(this._sayText.ubbText);
                    while (this._preSayBuff.length > 10)
                    {
                        
                        this._preSayBuff.pop();
                    }
                }
                this._preSayIndex = -1;
                this._sayText.clear();
                this.focus = false;
            }
            return;
        }// end function

        private function handleMemTest()
        {
            this.showSys(Config.language("ChatUI", 37) + Config.bytesToString(System.totalMemory));
            return;
        }// end function

        public function handleSayFocusOut(param1)
        {
            return;
        }// end function

        public function sayOpen()
        {
            this._sayFlag = true;
            this._sayText.text = "";
            this._sayText.selectable = true;
            this._sayText.focus = true;
            return;
        }// end function

        public function sayClose()
        {
            this._sayFlag = false;
            this._sayText.text = "";
            this._sayText.selectable = false;
            this._sayText.focus = false;
            return;
        }// end function

        private function handleFocusIn(param1)
        {
            if (EventMouse._imeEnabledPre)
            {
                EventMouse._imeEnabledPre = false;
                IME.enabled = true;
            }
            return;
        }// end function

    }
}
