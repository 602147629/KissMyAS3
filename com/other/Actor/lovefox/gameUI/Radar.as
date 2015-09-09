package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.gui.*;
    import lovefox.isometric.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class Radar extends Sprite
    {
        private var _map:Map;
        private var _mc:Sprite;
        private var _zoom:Object;
        private var _mapBmp:Bitmap;
        private var _mapWidth:Object;
        private var _mapRatio:Object;
        private var _mapMask:Shape;
        private var _mapShade:Shape;
        private var _positionTxt:Label;
        public var _unitDic:Dictionary;
        private var _npcDic:Dictionary;
        private var _npcFlagDic:Dictionary;
        public var _autoBtn:PushButton;
        public var _effectBtn:PushButton;
        public var _marketBtn:PushButton;
        public var _mallBtn:PushButton;
        public var _mailBtn:PushButton;
        public var _teamBtn:PushButton;
        public var _mapBtn:PushButton;
        public var _jianBtn:PushButton;
        public var _actBtn:PushButton;
        public var _pkBtn:PushButton;
        public var _fbBtn:Object;
        public var _tzBtn:Object;
        private var tempallbtn:PushButton;
        private var tempyabiaobtn:PushButton;
        private var templeftyabiaobtn:PushButton;
        private var giftLeftBtn:PushButton;
        private var paoLeftBtn:PushButton;
        private var toAirLeftBtn:PushButton;
        private var landLeftBtn:PushButton;
        private var landInfoBtn:PushButton;
        private var interPkBtn:PushButton;
        private var pkraceBtn:PushButton;
        private var interwarBtn:PushButton;
        private var lookmapBtn:PushButton;
        private var leaverfollowmapBtn:PushButton;
        private var manytoAirLeftBtn:PushButton;
        private var _sppt:Sprite;
        private var _npcList:List;
        private var linesprite:Panel;
        private var linetext:ClickLabel;
        public var linebtn:ComboBox;
        private var linearr:Array;
        private var _linenum:int = 0;
        private var mailbtn:PushButton;
        private var linetime:Timer;
        private var linetimenum:int = 5;
        public var _hangPB:PushButton;
        private var _lagPanel:Panel;
        private var _v2:Object;
        public var _fbUI:FbUI;
        private var _fullEffectCB:CheckBox;
        private var _fullEffectBG:Table;
        private var _preFullEffect:Boolean = true;
        public var _recorderUI:RecorderUI;
        private var _fbButton:PushButton;
        private var _fbTipLayer:Sprite;
        private var _fbTipTf:TextField;
        private var _fbTipCloseTimer:Number;
        private var gildId:int = 0;
        private var Bflag:Boolean = false;
        private var _gclip:GClip;
        private var _inforsprite:Sprite;

        public function Radar(param1)
        {
            this._map = param1;
            this.init();
            return;
        }// end function

        public function getNpcIcon(param1)
        {
            return this._npcDic[param1];
        }// end function

        public function init()
        {
            var _loc_1:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_GET_INSTANCE_LIST, this.backlinelist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_MAP_INSTANCE_CHANGE, this.backchangeline);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BDG_ENTER, this.enterend);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BDG_LEFT, this.leftmap);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BDG_START, this.activestart);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BDG_STATUS, this.activeonline);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PK_ACTIVITY_START, this.pkactivestart);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BUTTON_STATUS, this.showing);
            this.linetime = new Timer(1000);
            this.linetime.addEventListener(TimerEvent.TIMER, this.linetimefuc);
            var _loc_2:* = new Shape();
            _loc_2.graphics.beginFill(0, 0.5);
            _loc_2.graphics.drawCircle(-71, 86, 60);
            _loc_2.graphics.endFill();
            addChild(_loc_2);
            this._unitDic = new Dictionary(true);
            this._npcDic = new Dictionary(true);
            this._npcFlagDic = new Dictionary(true);
            this._mc = new Sprite();
            this._mapBmp = new Bitmap();
            this._mc.addChild(this._mapBmp);
            this._mapBmp.alpha = 0.8;
            this._map.addEventListener("scroll", this.handleMapScroll);
            this._mapMask = new Shape();
            this._mapMask.graphics.beginFill(0);
            this._mapMask.graphics.drawCircle(-71, 86, 60);
            this._mapMask.graphics.endFill();
            addChild(this._mapMask);
            this._mc.mask = this._mapMask;
            addChild(this._mc);
            if (this._map._state == "ready")
            {
                this.subInit();
            }
            else
            {
                this._map.addEventListener("complete", this.handleMapComplete);
            }
            removeEventListener(MouseEvent.CLICK, this.handleMapClick);
            addEventListener(MouseEvent.CLICK, this.handleMapClick);
            _loc_3 = new GPanel(Config.findUI("radarui").bg);
            addChild(_loc_3);
            _loc_3.x = -167;
            _loc_3.y = 23;
            _loc_3 = new Table("table2");
            addChild(_loc_3);
            _loc_3.x = -326;
            _loc_3.y = 2;
            _loc_3.resize(280);
            this._positionTxt = new Label(this, -120, 3);
            this._positionTxt.mouseEnabled = false;
            this._positionTxt.mouseChildren = false;
            this._positionTxt.textColor = 16775113;
            this.linetext = new ClickLabel(this, -294, 3, "", this.handleLinetextClick);
            this.linetext.clickColor([16777215, 15590819]);
            this.linebtn = new ComboBox(this, -48, 2, this.lineclick);
            this.linebtn.list.selectable = false;
            this.linebtn.btnfuc = this.sendlinelist;
            this.linebtn.width = 48;
            this.linebtn.height = 200;
            this.linebtn.list.autoHeight = true;
            this.linebtn.showValue = false;
            this.linebtn.label = Config.language("Radar", 1);
            this.linebtn.button.roundCorner = 6;
            this.linebtn.button.width = 48;
            this.linebtn.button.x = 0;
            this._lagPanel = new Panel(this, -20, 27);
            this._lagPanel.data = Config.language("Radar", 13, 0, Config.fps);
            this._lagPanel.height = 12;
            this._lagPanel.width = 12;
            this._lagPanel.roundCorner = 6;
            this._lagPanel.addEventListener(MouseEvent.ROLL_OVER, this.handleLagOver);
            this._lagPanel.addEventListener(MouseEvent.ROLL_OUT, this.handleLagOut);
            var _loc_6:* = this.setmainbtn("btn3", -28, 45 - 0, "", Config.ui._zoommap, "button2");
            _loc_4 = this.setmainbtn("btn3", -28, 45 - 0, "", Config.ui._zoommap, "button2");
            this._mapBtn = _loc_6;
            this.setTip(_loc_4, Config.language("Radar", 4));
            var _loc_6:* = this.setmainbtn("btn2", -28, 72 - 0, "", Config.ui._mailpanel, "button6");
            this.mailbtn = this.setmainbtn("btn2", -28, 72 - 0, "", Config.ui._mailpanel, "button6");
            _loc_4 = _loc_6;
            this._mailBtn = _loc_6;
            this.mailbtn.setStyle(Config.findUI("radarui")["button3"]);
            this.setTip(_loc_4, Config.language("Radar", 3));
            _loc_4 = this.setmainbtn("btn1", -28, 99 - 0, "", Config.ui._gamesystem, "button4");
            this.setTip(_loc_4, Config.language("Radar", 2));
            this._pkBtn = new PushButton(this, -151, 105, "", null, Config.findUI("radarui")["button11"]);
            this._pkBtn.overshow = true;
            this.setJJTip(this._pkBtn);
            this._marketBtn = this.setmainbtn("btn4", -142, 26, "", Config.ui._blackmarket, "button1");
            this.setTip(this._marketBtn, Config.language("Radar", 5));
            this._mallBtn = this.setmainbtn("btn4", -206, 23, "", Config.ui._shopmail, "button5");
            this.setTip(this._mallBtn, Config.language("Radar", 6));
            this._hangPB = this.setmainbtn("btn5", -34, 126, "", Config.ui._monsterIndexUI, "button7");
            this.setTip(this._hangPB, Config.language("Radar", 7));
            var _loc_6:* = this.setmainbtn("btn6", -155, 51, "", Config.ui._recomPanel, "button8");
            _loc_4 = this.setmainbtn("btn6", -155, 51, "", Config.ui._recomPanel, "button8");
            this._jianBtn = _loc_6;
            this.setTip(_loc_4, Config.language("Radar", 8));
            this._teamBtn = this.setmainbtn("btn7", -56, 141, "", Config.ui._teamUI, "button9");
            this.setTip(this._teamBtn, Config.language("Radar", 9));
            this._actBtn = this.setmainbtn("btn8", -158, 78, "", Config.ui._activePanel, "button10");
            this.setTip(this._actBtn, Config.language("Radar", 10));
            _loc_4 = this.setmainbtn("btn9", -84, 146, "", Config.ui._billboardpanel, "button12");
            this.setTip(_loc_4, Config.language("Radar", 11));
            var _loc_6:* = new PushButton(this, -134, 127, "", null, Config.findUI("radarui")["button13"]);
            _loc_4 = new PushButton(this, -134, 127, "", null, Config.findUI("radarui")["button13"]);
            this._fbBtn = _loc_6;
            _loc_4.overshow = true;
            this.setFbTip(_loc_4);
            this.makeFbButton(_loc_4);
            this._tzBtn = new PushButton(this, -110, 141, "", null, Config.findUI("radarui")["button14"]);
            this._tzBtn.overshow = true;
            this.setTzTip(this._tzBtn);
            this.tempallbtn = new PushButton(null, -230, 55, Config.language("Radar", 27), Config.ui._bigWar.onwar);
            this.tempallbtn.setTable("table18", "table31");
            this.tempallbtn.width = 70;
            this.tempallbtn.height = 25;
            this.tempallbtn.textColor = Style.GOLD_FONT;
            this.tempyabiaobtn = new PushButton(null, -230, 55, "", this.entermap);
            this.tempyabiaobtn.setTable("table18", "table31");
            this.tempyabiaobtn.width = 70;
            this.tempyabiaobtn.height = 25;
            this.tempyabiaobtn.textColor = Style.GOLD_FONT;
            this.templeftyabiaobtn = new PushButton(null, -230, 85, Config.language("Radar", 29), this.leftactivemap);
            this.templeftyabiaobtn.setTable("table18", "table31");
            this.templeftyabiaobtn.width = 70;
            this.templeftyabiaobtn.height = 25;
            this.templeftyabiaobtn.textColor = Style.GOLD_FONT;
            this.giftLeftBtn = new PushButton(null, -230, 85, Config.language("Radar", 30), this.backLoginMap);
            this.giftLeftBtn.setTable("table18", "table31");
            this.giftLeftBtn.width = 70;
            this.giftLeftBtn.height = 25;
            this.giftLeftBtn.textColor = Style.GOLD_FONT;
            this.pkraceBtn = new PushButton(null, -230, 55, Config.language("Radar", 48), Config.ui._pkrace.sendenterPkmap);
            this.pkraceBtn.setTable("table18", "table31");
            this.pkraceBtn.width = 70;
            this.pkraceBtn.height = 25;
            this.pkraceBtn.textColor = Style.GOLD_FONT;
            this.paoLeftBtn = new PushButton(null, -230, 85, Config.language("Radar", 30), this.backPaoMap);
            this.paoLeftBtn.setTable("table18", "table31");
            this.paoLeftBtn.width = 70;
            this.paoLeftBtn.height = 25;
            this.paoLeftBtn.textColor = Style.GOLD_FONT;
            this.toAirLeftBtn = new PushButton(null, -230, 85, Config.language("Radar", 30), this.backToAirMap);
            this.toAirLeftBtn.setTable("table18", "table31");
            this.toAirLeftBtn.width = 70;
            this.toAirLeftBtn.height = 25;
            this.toAirLeftBtn.textColor = Style.GOLD_FONT;
            this.landLeftBtn = new PushButton(null, -230, 85, Config.language("Radar", 30), this.backlandLeft);
            this.landLeftBtn.setTable("table18", "table31");
            this.landLeftBtn.width = 70;
            this.landLeftBtn.height = 25;
            this.landLeftBtn.textColor = Style.GOLD_FONT;
            this.interwarBtn = new PushButton(null, -230, 85, Config.language("Radar", 55), this.interwarleft);
            this.interwarBtn.setTable("table18", "table31");
            this.interwarBtn.width = 70;
            this.interwarBtn.height = 25;
            this.interwarBtn.textColor = Style.GOLD_FONT;
            this.landInfoBtn = new PushButton(null, -230, 115, Config.language("Radar", 49), this.showLandInfo);
            this.landInfoBtn.setTable("table18", "table31");
            this.landInfoBtn.width = 70;
            this.landInfoBtn.height = 25;
            this.landInfoBtn.textColor = Style.GOLD_FONT;
            this.interPkBtn = new PushButton(null, -230, 85, Config.language("Radar", 51), this.leftInterPk);
            this.interPkBtn.setTable("table18", "table31");
            this.interPkBtn.width = 70;
            this.interPkBtn.height = 25;
            this.interPkBtn.textColor = Style.GOLD_FONT;
            this.leaverfollowmapBtn = new PushButton(null, -230, 85, Config.language("Radar", 29), this.leaverfollowmap);
            this.leaverfollowmapBtn.setTable("table18", "table31");
            this.leaverfollowmapBtn.width = 70;
            this.leaverfollowmapBtn.height = 25;
            this.leaverfollowmapBtn.textColor = Style.GOLD_FONT;
            this.manytoAirLeftBtn = new PushButton(null, -230, 85, Config.language("Radar", 29), this.leavermanyairmap);
            this.manytoAirLeftBtn.setTable("table18", "table31");
            this.manytoAirLeftBtn.width = 70;
            this.manytoAirLeftBtn.height = 25;
            this.manytoAirLeftBtn.textColor = Style.GOLD_FONT;
            this.lookmapBtn = new PushButton(null, (-(Config.ui._width - 100)) / 2 - 160, Config.ui._height - 160, Config.language("Radar", 50), this.showlookmap);
            this.lookmapBtn.setTable("table18", "table31");
            this.lookmapBtn.width = 70;
            this.lookmapBtn.height = 25;
            this.lookmapBtn.textColor = Style.GOLD_FONT;
            this._npcList = new List(null, -294, 20, this.handleNpcListSelect);
            this._npcList.width = 220;
            this._npcList.overshow = true;
            this._npcList.selectable = false;
            this._npcList.autoHeight = true;
            var _loc_5:* = new AwardPanel(this);
            new AwardPanel(this).x = -285;
            _loc_5.y = 40;
            if (!Config._switchMobage)
            {
                this._recorderUI = new RecorderUI(this, -413, 0);
            }
            this._fbUI = new FbUI();
            addChild(this.linebtn);
            this._fullEffectBG = new Table("table31");
            this._fullEffectBG.resize(90, 21);
            this._fullEffectBG.x = -300;
            this._fullEffectBG.y = 60;
            this._fullEffectCB = new CheckBox(this._fullEffectBG, 6, 5, Config.language("Radar", 32), this.handleFullEffectCB);
            this._fullEffectCB.subColor = 13369344;
            this._fullEffectCB.textColor = Style.WHITE_FONT;
            this._fullEffectCB.addEventListener(MouseEvent.ROLL_OVER, this.handleFullEffectRollOver);
            this._fullEffectCB.addEventListener(MouseEvent.ROLL_OUT, this.handleFullEffectRollOut);
            return;
        }// end function

        private function handleFullEffectRollOver(param1)
        {
            Holder.showInfo(Config.language("Radar", 31), new Rectangle(this._fullEffectBG.x + x, this._fullEffectBG.y + y, this._fullEffectBG.width, this._fullEffectBG.height), false, 0, 124);
            return;
        }// end function

        private function handleFullEffectRollOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function makeFbButton(param1:PushButton)
        {
            this._fbButton = param1;
            this._fbTipLayer = new Sprite();
            this._fbTipLayer.x = Config.ui._width + param1.x + 14;
            this._fbTipLayer.y = param1.y + 14;
            this._fbTipLayer.addEventListener(MouseEvent.CLICK, this.closeFbButton);
            this._fbTipLayer.buttonMode = true;
            this._fbTipTf = Config.getSimpleTextField();
            this._fbTipTf.textColor = Style.WHITE_FONT;
            this._fbTipLayer.addChild(this._fbTipTf);
            return;
        }// end function

        private function closeFbButton(param1 = null)
        {
            clearTimeout(this._fbTipCloseTimer);
            if (this._fbTipLayer.parent != null)
            {
                this._fbTipLayer.parent.removeChild(this._fbTipLayer);
            }
            return;
        }// end function

        public function setFbButton(param1:String)
        {
            this._fbTipLayer.x = x + this._fbButton.x + 14;
            this._fbTipLayer.y = y + this._fbButton.y + 14;
            this._fbTipTf.htmlText = param1;
            this._fbTipTf.x = -this._fbTipTf.width - 5;
            this._fbTipTf.y = 30;
            this._fbTipLayer.graphics.clear();
            this._fbTipLayer.graphics.lineStyle(3, 8870456, 1);
            this._fbTipLayer.graphics.beginFill(5912103, 0.6);
            this._fbTipLayer.graphics.moveTo(0, 0);
            this._fbTipLayer.graphics.lineTo(-20, 20);
            this._fbTipLayer.graphics.lineTo(-this._fbTipTf.width - 10, 20);
            this._fbTipLayer.graphics.lineTo(-this._fbTipTf.width - 10, this._fbTipTf.y + this._fbTipTf.height + 10);
            this._fbTipLayer.graphics.lineTo(0, this._fbTipTf.y + this._fbTipTf.height + 10);
            this._fbTipLayer.graphics.lineTo(0, 20);
            this._fbTipLayer.graphics.lineTo(-10, 20);
            this._fbTipLayer.graphics.lineTo(0, 0);
            this._fbTipLayer.graphics.endFill();
            this._fbTipLayer.graphics.lineStyle(1, 16563809, 1);
            this._fbTipLayer.graphics.moveTo(0, 0);
            this._fbTipLayer.graphics.lineTo(-20, 20);
            this._fbTipLayer.graphics.lineTo(-this._fbTipTf.width - 10, 20);
            this._fbTipLayer.graphics.lineTo(-this._fbTipTf.width - 10, this._fbTipTf.y + this._fbTipTf.height + 10);
            this._fbTipLayer.graphics.lineTo(0, this._fbTipTf.y + this._fbTipTf.height + 10);
            this._fbTipLayer.graphics.lineTo(0, 20);
            this._fbTipLayer.graphics.lineTo(-10, 20);
            this._fbTipLayer.graphics.lineTo(0, 0);
            Config.ui._layer4.addChild(this._fbTipLayer);
            clearTimeout(this._fbTipCloseTimer);
            this._fbTipCloseTimer = setTimeout(this.closeFbButton, 5000);
            return;
        }// end function

        public function handleFullEffectCB(param1)
        {
            Unit.fullEffect = !this._fullEffectCB.selected;
            return;
        }// end function

        public function openFullEffectCB()
        {
            if (this._fullEffectBG.parent == null)
            {
                Unit.fullEffect = this._preFullEffect;
                this._fullEffectCB.selected = !this._preFullEffect;
                addChild(this._fullEffectBG);
            }
            return;
        }// end function

        public function closeFullEffectCB()
        {
            if (this._fullEffectBG.parent != null)
            {
                this._preFullEffect = !this._fullEffectCB.selected;
                this._fullEffectBG.parent.removeChild(this._fullEffectBG);
            }
            return;
        }// end function

        private function handleLagOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleLagOver(param1)
        {
            var _loc_2:* = param1.currentTarget;
            Holder.showInfo(_loc_2.data, new Rectangle(_loc_2.x + _loc_2.parent.x, _loc_2.y + _loc_2.parent.y, _loc_2.width, _loc_2.height), true);
            return;
        }// end function

        public function set lag(param1)
        {
            this._lagPanel.data = Config.language("Radar", 13, param1, Config.fps);
            if (param1 <= 100)
            {
                this._lagPanel.color = 52224;
            }
            else if (param1 <= 200)
            {
                this._lagPanel.color = Math.floor(204 * (param1 - 100) / 100) * 256 * 256 + 204 * 256;
            }
            else if (param1 <= 300)
            {
                this._lagPanel.color = Math.floor(204 * (300 - param1) / 100) * 256 + 204 * 256 * 256;
            }
            else
            {
                this._lagPanel.color = 13369344;
            }
            return;
        }// end function

        private function setmainbtn(param1:String, param2:int, param3:int, param4:String, param5 = null, param6 = null)
        {
            var _loc_7:* = null;
            _loc_7 = new PushButton(this, param2, param3, "", Config.create(this.switchOpenUI, param5), Config.findUI("radarui")[param6]);
            _loc_7.overshow = true;
            return _loc_7;
        }// end function

        public function addwarbtn()
        {
            if (Config.player.level >= 30)
            {
                this.addChild(this.tempallbtn);
            }
            return;
        }// end function

        public function removewarbtn()
        {
            if (this.tempallbtn != null)
            {
                if (this.tempallbtn.parent != null)
                {
                    this.removeChild(this.tempallbtn);
                }
            }
            return;
        }// end function

        public function setmail(param1:Boolean) : void
        {
            if (param1)
            {
                this.mailbtn.setStyle(Config.findUI("radarui")["button6"]);
            }
            else
            {
                this.mailbtn.setStyle(Config.findUI("radarui")["button3"]);
            }
            return;
        }// end function

        private function switchOpenUI(param1, param2) : void
        {
            if (param2 != null)
            {
                param2.switchOpen();
            }
            return;
        }// end function

        private function handleNpcListSelect(param1)
        {
            Hang.hangNpc(this._npcList.selectedItem.data);
            if (this._npcList.parent != null)
            {
                this.closeNpcList();
            }
            return;
        }// end function

        private function handleClickOutside(param1)
        {
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
            if (!hitTestPoint(stage.mouseX, stage.mouseY, true))
            {
                this.closeNpcList();
            }
            return;
        }// end function

        private function handleAuto(param1)
        {
            if (this._autoBtn.selected)
            {
                this._autoBtn.selected = false;
                SoundManager.on = false;
            }
            else
            {
                this._autoBtn.selected = true;
                SoundManager.on = true;
            }
            return;
        }// end function

        private function handleMapClick(event:MouseEvent)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            if (event.target == this._mc)
            {
                _loc_2 = {_x:this._mc.mouseX / this._zoom - (this._map._height - this._map._exBorder) * Map._ptPerTile, _y:this._mc.mouseY / this._zoom};
                _loc_3 = this._map.positionToMap(_loc_2);
                if (Config.player != null)
                {
                    Config.stopAuto();
                    Config.player.go(_loc_3);
                }
            }
            return;
        }// end function

        public function addNpc(param1:Npc)
        {
            var _loc_2:* = undefined;
            this.removeNpc(param1);
            if (param1.taskState == 2)
            {
                _loc_2 = GClip.newGClip("task2_1");
            }
            else if (param1.taskState == 1)
            {
                _loc_2 = GClip.newGClip("task2_1");
            }
            else if (param1.taskState == 0)
            {
                _loc_2 = GClip.newGClip("task4_1");
            }
            else if (param1.taskState == 4)
            {
                _loc_2 = GClip.newGClip("task1_1");
            }
            else
            {
                _loc_2 = GClip.newGClip(param1.getNormalIcon());
            }
            this._mc.addChild(_loc_2);
            _loc_2.buttonMode = true;
            _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.handleNpcMouseOver);
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.handleNpcMouseOut);
            _loc_2.addEventListener(MouseEvent.CLICK, this.handleNpcClick);
            var _loc_3:* = Config.map.mapToUnit(param1);
            _loc_2.x = _loc_3._x * this._zoom + this._mapWidth * this._mapRatio;
            _loc_2.y = _loc_3._y * this._zoom - this._map._exBorder * Map._ptPerTile * this._zoom;
            this._npcDic[param1] = _loc_2;
            this._npcFlagDic[_loc_2] = param1;
            return;
        }// end function

        public function removeNpc(param1)
        {
            if (this._npcDic[param1] != null)
            {
                this._npcDic[param1].clear();
                this._npcDic[param1].removeEventListener(MouseEvent.ROLL_OVER, this.handleNpcMouseOver);
                this._npcDic[param1].removeEventListener(MouseEvent.ROLL_OUT, this.handleNpcMouseOut);
                this._npcDic[param1].removeEventListener(MouseEvent.CLICK, this.handleNpcClick);
                if (this._npcDic[param1].parent != null)
                {
                    this._npcDic[param1].parent.removeChild(this._npcDic[param1]);
                }
                delete this._npcDic[param1];
            }
            return;
        }// end function

        private function handleNpcMouseOver(param1)
        {
            var _loc_2:* = param1.currentTarget;
            var _loc_3:* = this._npcFlagDic[_loc_2];
            var _loc_4:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            Holder.showInfo(_loc_3.name, new Rectangle(_loc_4.x, _loc_4.y - _loc_2.height / 2, _loc_2.width, _loc_2.height), true);
            return;
        }// end function

        private function handleNpcMouseOut(param1)
        {
            var _loc_2:* = this._npcFlagDic[param1.currentTarget];
            Holder.closeInfo();
            return;
        }// end function

        private function handleNpcClick(param1)
        {
            Config.stopAuto();
            var _loc_2:* = this._npcFlagDic[param1.currentTarget];
            Config.player.target = _loc_2;
            return;
        }// end function

        private function handleMapComplete(param1)
        {
            this.subInit();
            return;
        }// end function

        private function subInit()
        {
            var _loc_2:* = undefined;
            var _loc_4:* = undefined;
            var _loc_1:* = Map._ptPerTile * (this._map._width + this._map._height - this._map._exBorder * 2);
            this._mapWidth = _loc_1 / 12;
            this._mapRatio = 1 - (this._map._width - this._map._exBorder) / (this._map._width + this._map._height - this._map._exBorder * 2);
            this._zoom = this._mapWidth / _loc_1;
            if (this._mapBmp.bitmapData != null)
            {
                this._mapBmp.bitmapData.dispose();
                this._mapBmp.bitmapData = null;
            }
            this._mapBmp.bitmapData = this._map.getBlockMap(this._mapWidth, 13421772);
            var _loc_3:* = [];
            var _loc_5:* = Config._mapMap[Config.map.id];
            if (Config._mapMap[Config.map.id].npcData != null && _loc_5.npcData.data != null)
            {
                if (_loc_5.npcData.data is Array)
                {
                    _loc_2 = 0;
                    while (_loc_2 < _loc_5.npcData.data.length)
                    {
                        
                        _loc_4 = Config._npcMap[_loc_5.npcData.data[_loc_2].id];
                        if (Number(_loc_4.effectOnly) == 0)
                        {
                            _loc_3.push(_loc_4);
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                }
                else
                {
                    _loc_4 = Config._npcMap[_loc_5.npcData.data.id];
                    if (Number(_loc_4.effectOnly) == 0)
                    {
                        _loc_3.push(_loc_4);
                    }
                }
            }
            var _loc_6:* = [];
            for (_loc_2 in _loc_3)
            {
                
                if (_loc_3[_loc_2].forceClip != -1)
                {
                    if (_loc_3[_loc_2].title == null)
                    {
                        _loc_6.push({label:_loc_3[_loc_2].name, data:Number(_loc_3[_loc_2].id)});
                        continue;
                    }
                    _loc_6.push({label:_loc_3[_loc_2].title + _loc_3[_loc_2].name, data:Number(_loc_3[_loc_2].id)});
                }
            }
            this._npcList.itemArray = _loc_6;
            this.handleMapScroll();
            return;
        }// end function

        private function handleMapScroll(param1 = null)
        {
            var _loc_2:* = {_x:this._map._x, _y:this._map._y};
            _loc_2 = this._map.mapToTile(_loc_2);
            this._positionTxt.text = Config.language("Radar", 57, _loc_2._x, _loc_2._y);
            var _loc_3:* = this._map._x - this._map._y;
            var _loc_4:* = (this._map._x + this._map._y) / 2;
            this._mc.x = (-_loc_3) * this._zoom - this._mapWidth * this._mapRatio - 70;
            this._mc.y = (-_loc_4) * this._zoom + 86;
            return;
        }// end function

        private function getcolor(param1:int, param2:Sprite, param3 = 0, param4 = null) : int
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (param3 == 0)
            {
                _loc_5 = 204;
                _loc_6 = Config.ui._friendUI.judgefriend(param1);
                if (_loc_6 == 1)
                {
                    _loc_5 = 16242957;
                }
                else if (_loc_6 == 2)
                {
                    _loc_5 = 16777215;
                }
                else if (_loc_6 == 3)
                {
                    _loc_5 = 0;
                }
                if (Config.ui._teamUI.inTeam(param1))
                {
                    _loc_5 = 4854398;
                    param2.graphics.beginFill(16118434);
                    param2.graphics.drawCircle(0, 0, 3);
                }
                return _loc_5;
            }
            else
            {
                if (param4.testPk())
                {
                    return 13369344;
                }
                return 204;
            }
        }// end function

        public function addUnit(param1)
        {
            if (param1._focus)
            {
                this._unitDic[param1] = new Sprite();
                if (param1._type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
                {
                    this._unitDic[param1].graphics.beginFill(52224);
                }
                this._unitDic[param1].graphics.lineStyle(0, 0, 0);
                this._unitDic[param1].graphics.drawCircle(0, 0, 1.5);
                this._unitDic[param1].graphics.endFill();
                this._unitDic[param1].x = -70;
                this._unitDic[param1].y = 86;
                addChild(this._unitDic[param1]);
            }
            else
            {
                this.removeUnit(param1);
                this._unitDic[param1] = new Sprite();
                if (param1._type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
                {
                    this._unitDic[param1].graphics.beginFill(this.getcolor(param1.id, this._unitDic[param1]));
                }
                else if (param1._type == UNIT_TYPE_ENUM.TYPEID_UNIT)
                {
                    this._unitDic[param1].graphics.beginFill(this.getcolor(param1.id, this._unitDic[param1], 1, param1));
                }
                else
                {
                    this._unitDic[param1].graphics.beginFill(0, 0);
                }
                this._unitDic[param1].graphics.lineStyle(0, 0, 0);
                this._unitDic[param1].graphics.drawCircle(0, 0, 1.5);
                this._unitDic[param1].graphics.endFill();
                if (param1._mc != null)
                {
                    this._unitDic[param1].x = param1._mc.x * this._zoom + this._mapWidth * this._mapRatio;
                    this._unitDic[param1].y = param1._mc.y * this._zoom - this._map._exBorder * Map._ptPerTile * this._zoom;
                }
                this._mc.addChild(this._unitDic[param1]);
                param1.addEventListener("pass", this.onUnitMove);
            }
            return;
        }// end function

        public function removeUnit(param1)
        {
            param1.removeEventListener("pass", this.onUnitMove);
            if (this._unitDic[param1] != null)
            {
                this._unitDic[param1].parent.removeChild(this._unitDic[param1]);
            }
            delete this._unitDic[param1];
            this._unitDic[param1] = null;
            return;
        }// end function

        private function onUnitMove(event:Event)
        {
            this._unitDic[event.target].x = event.target._mc.x * this._zoom + this._mapWidth * this._mapRatio;
            this._unitDic[event.target].y = event.target._mc.y * this._zoom - this._map._exBorder * Map._ptPerTile * this._zoom;
            return;
        }// end function

        private function sendlinelist(event:MouseEvent) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_GET_INSTANCE_LIST);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backlinelist(event:SocketEvent = null) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            this.linearr = new Array();
            if (event != null)
            {
            }
            else
            {
                _loc_2 = 1;
                while (_loc_2 <= this._linenum)
                {
                    
                    _loc_3 = new Object();
                    _loc_3.label = this.getlinestr(_loc_2);
                    _loc_3.data = _loc_2;
                    _loc_3.forceColor = Style.SELECTED_ITEM;
                    this.linearr.push(_loc_3);
                    _loc_2 = _loc_2 + 1;
                }
            }
            this.linebtn.itemArray = this.linearr;
            return;
        }// end function

        private function lineclick(param1) : void
        {
            if (!Config.player.lock)
            {
                if (Config.ui._pkmode.warStatus)
                {
                    Config.message(Config.language("Radar", 14));
                }
                else
                {
                    this.changeLine(Number(this.linebtn.selectedItem.data));
                }
            }
            else
            {
                Config.message(Config.language("Radar", 15));
            }
            return;
        }// end function

        public function clearchangeline() : void
        {
            this.linetime.stop();
            return;
        }// end function

        private function linetimefuc(event:TimerEvent) : void
        {
            if (this.linetimenum > 0)
            {
                Neon.show(String(this.linetimenum));
                var _loc_2:* = this;
                var _loc_3:* = this.linetimenum - 1;
                _loc_2.linetimenum = _loc_3;
            }
            else
            {
                this.linetime.stop();
                this.changeLine(Number(this.linebtn.selectedItem.data));
            }
            return;
        }// end function

        public function changeLine(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LINE_CHANGE);
            _loc_2.add32(Config.map.id);
            _loc_2.add8(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backchangeline(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readUnsignedInt();
            Config.mapLine = _loc_4;
            switch(_loc_3)
            {
                case 0:
                {
                    Config.message(Config.language("Radar", 16));
                    this.setLinetext(String(this._map._data.name) + this.getlinestr(_loc_4));
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("Radar", 17));
                    break;
                }
                case 2:
                {
                    Config.message(Config.language("Radar", 18, this.getlinestr(_loc_4)));
                    break;
                }
                case 3:
                {
                    Config.message(this.getlinestr(_loc_4) + Config.language("Radar", 20));
                    break;
                }
                case 4:
                {
                    Config.message(Config.language("Radar", 21));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function handleLinetextClick(param1)
        {
            if (this._npcList.parent != null)
            {
                this.closeNpcList();
            }
            else
            {
                addChild(this._npcList);
                stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
                stage.addEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
            }
            return;
        }// end function

        private function closeNpcList()
        {
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
            this._npcList.parent.removeChild(this._npcList);
            return;
        }// end function

        private function setLinetext(param1:String)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            var _loc_2:* = Unit.getNpclist();
            if (_loc_2 == null || _loc_2.length == 0)
            {
                this.linetext.text = param1;
            }
            else
            {
                _loc_4 = [];
                for (_loc_3 in _loc_2)
                {
                    
                    if (Number(_loc_2[_loc_3]._data.effectOnly) == 0)
                    {
                        _loc_5 = "";
                        if (Number(_loc_2[_loc_3]._data.shopId) != 0)
                        {
                            _loc_5 = _loc_5 + Config.language("Radar", 22);
                        }
                        if (Number(_loc_2[_loc_3]._data.portalId) != 0)
                        {
                            _loc_5 = _loc_5 + Config.language("Radar", 23);
                        }
                        _loc_4.push({label:_loc_5 + _loc_2[_loc_3].name, data:_loc_2[_loc_3]});
                    }
                }
                this.linetext.text = param1;
            }
            return;
        }// end function

        public function linenum(param1:int, param2:int) : void
        {
            this._linenum = param1;
            if (this._linenum == 1)
            {
                this._v2 = param2;
                if (this._map._data != null)
                {
                    this.setLinetext(String(this._map._data.name));
                }
                else
                {
                    this._map.addEventListener("complete", this.subLineText);
                }
                this.linebtn.enabled = false;
            }
            else
            {
                this._v2 = param2;
                if (this._map._data != null)
                {
                    this.setLinetext(String(this._map._data.name) + this.getlinestr(this._v2));
                }
                else
                {
                    this._map.addEventListener("complete", this.subLineText);
                }
                this.linebtn.enabled = true;
                this.backlinelist();
                this.linebtn.selectedItem = this.linebtn.itemArray[(param2 - 1)];
            }
            return;
        }// end function

        private function subLineText(param1)
        {
            this._map.removeEventListener("complete", this.subLineText);
            if (this._linenum == 1)
            {
                this.setLinetext(String(this._map._data.name));
            }
            else
            {
                this.setLinetext(String(this._map._data.name) + this.getlinestr(this._v2));
            }
            return;
        }// end function

        private function getlinestr(param1:int) : String
        {
            var _loc_2:* = Config.language("Radar", 24, int(param1));
            return _loc_2;
        }// end function

        private function setTip(param1, param2)
        {
            param1.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.handleSlotOver, param2));
            param1.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            return;
        }// end function

        private function setJJTip(param1)
        {
            param1.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOverJJ);
            param1.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            param1.addEventListener(MouseEvent.CLICK, this.handleJJPBClick);
            return;
        }// end function

        private function handleJJPBClick(param1)
        {
            if (Player.level >= 30)
            {
                Config.ui._interPkPanel.switchOpen();
            }
            return;
        }// end function

        private function handleSlotOverJJ(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = param1.currentTarget;
            if (Player.level >= 30)
            {
                _loc_3 = Config.language("Radar", 52);
            }
            else
            {
                _loc_3 = Config.language("Radar", 53);
            }
            Holder.showInfo(_loc_3, new Rectangle(_loc_2.x + _loc_2.parent.x, _loc_2.y + _loc_2.parent.y + 5, _loc_2.width, _loc_2.height), true);
            return;
        }// end function

        private function setFbTip(param1)
        {
            param1.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOverFb);
            param1.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            param1.addEventListener(MouseEvent.CLICK, this.handleFbPBClick);
            return;
        }// end function

        private function handleFbPBClick(param1)
        {
            if (Player.level >= 20)
            {
                Config.ui._fbEntranceUI.switchOpen();
            }
            return;
        }// end function

        private function handleSlotOverFb(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            if (!Config.ui._fbEntranceUI._opening && Config.ui._fbEntranceUI._inFb && Config.ui._fbEntranceUI._inPlayerList)
            {
                _loc_3 = Config._fbInfo[Config.ui._fbEntranceUI._fbId];
                _loc_4 = Config.language("Radar", 33, _loc_3.name);
            }
            else if (!Config.ui._fbEntranceUI._opening && Config.ui._fbEntranceUI._inFb && Config.ui._teamUI.inTeam(Player._playerId))
            {
                _loc_3 = Config._fbInfo[Config.ui._fbEntranceUI._fbId];
                _loc_4 = Config.language("Radar", 34, _loc_3.name);
            }
            else if (Player.level >= 20)
            {
                _loc_4 = Config.language("Radar", 25);
            }
            else
            {
                _loc_4 = Config.language("Radar", 43);
            }
            var _loc_2:* = this._fbBtn;
            Holder.showInfo(_loc_4, new Rectangle(_loc_2.x + _loc_2.parent.x, _loc_2.y + _loc_2.parent.y + 5, _loc_2.width, _loc_2.height), true);
            return;
        }// end function

        private function setTzTip(param1)
        {
            param1.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOverTz);
            param1.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            param1.addEventListener(MouseEvent.CLICK, this.handleTzPBClick);
            return;
        }// end function

        private function handleTzPBClick(param1)
        {
            Config.ui._activePanel.opengiftdare();
            return;
        }// end function

        private function handleSlotOverTz(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = param1.currentTarget;
            if (Player.level >= 35)
            {
                _loc_3 = Config.language("Radar", 26);
            }
            else
            {
                _loc_3 = Config.language("Radar", 44);
            }
            Holder.showInfo(_loc_3, new Rectangle(_loc_2.x + _loc_2.parent.x, _loc_2.y + _loc_2.parent.y + 5, _loc_2.width, _loc_2.height), true);
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleSlotOver(param1, param2)
        {
            var _loc_3:* = param1.currentTarget;
            Holder.showInfo(param2, new Rectangle(_loc_3.x + _loc_3.parent.x, _loc_3.y + _loc_3.parent.y + 5, _loc_3.width, _loc_3.height), true);
            return;
        }// end function

        private function enterend(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.gildId = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            Config.ui._yabiao.gildName = _loc_2.readUTFBytes(_loc_4);
            if (this.tempyabiaobtn.parent != null)
            {
                this.removeChild(this.tempyabiaobtn);
            }
            this.addChild(this.templeftyabiaobtn);
            Config.ui._yabiao.openscPanel();
            return;
        }// end function

        private function leftmap(event:SocketEvent)
        {
            if (this.templeftyabiaobtn.parent != null)
            {
                this.removeChild(this.templeftyabiaobtn);
            }
            if (!this.Bflag)
            {
                this.addChild(this.tempyabiaobtn);
                if (Config.player._gildid == this.gildId)
                {
                    this.tempyabiaobtn.label = Config.language("Radar", 45);
                }
                else
                {
                    this.tempyabiaobtn.label = Config.language("Radar", 46);
                }
            }
            return;
        }// end function

        private function activestart(event:SocketEvent)
        {
            this.Bflag = false;
            var _loc_2:* = event.data;
            this.gildId = _loc_2.readUnsignedInt();
            if (Config.player.level >= 15)
            {
                if (Config.map.data.type != 13)
                {
                    this.addChild(this.tempyabiaobtn);
                    if (Config.player._gildid == this.gildId)
                    {
                        this.tempyabiaobtn.label = Config.language("Radar", 45);
                    }
                    else
                    {
                        this.tempyabiaobtn.label = Config.language("Radar", 46);
                    }
                }
            }
            return;
        }// end function

        private function activeonline(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 1)
            {
                this.Bflag = false;
                this.gildId = _loc_2.readUnsignedInt();
                if (Config.player.level >= 15)
                {
                    if (Config.map.data.type == 13)
                    {
                        this.addChild(this.templeftyabiaobtn);
                    }
                    else
                    {
                        this.addChild(this.tempyabiaobtn);
                        if (Config.player._gildid == this.gildId)
                        {
                            this.tempyabiaobtn.label = Config.language("Radar", 45);
                        }
                        else
                        {
                            this.tempyabiaobtn.label = Config.language("Radar", 46);
                        }
                    }
                }
            }
            else if (_loc_3 == 0)
            {
                if (Config.player.level >= 15)
                {
                    this.Bflag = true;
                    if (this.tempyabiaobtn.parent != null)
                    {
                        this.removeChild(this.tempyabiaobtn);
                    }
                    if (Config.map != null)
                    {
                        if (Config.map.data != null)
                        {
                            if (Config.map.data.type == 13)
                            {
                                if (this.templeftyabiaobtn.parent == null)
                                {
                                    this.addChild(this.templeftyabiaobtn);
                                }
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        public function entermap(event:MouseEvent = null)
        {
            if (Config.map._type != 13)
            {
                AlertUI.alert(Config.language("Radar", 35), Config.language("Radar", 36), [Config.language("Radar", 37), Config.language("Radar", 38)], [this.sendentermap]);
            }
            else
            {
                Config.message(Config.language("Radar", 39));
            }
            return;
        }// end function

        public function sendentermap(param1 = null)
        {
            var _loc_2:* = null;
            if (Config.player.level >= 15)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_BDG_ENTER);
                ClientSocket.send(_loc_2);
            }
            else
            {
                Config.message(Config.language("Radar", 47));
            }
            return;
        }// end function

        private function leftactivemap(event:MouseEvent)
        {
            AlertUI.alert(Config.language("Radar", 35), Config.language("Radar", 40), [Config.language("Radar", 37), Config.language("Radar", 38)], [this.sendleftmap]);
            return;
        }// end function

        private function backLoginMap(event:MouseEvent) : void
        {
            AlertUI.alert(Config.language("Radar", 41), Config.language("Radar", 42), [Config.language("Radar", 37), Config.language("Radar", 38)], [this.centerBack]);
            return;
        }// end function

        private function backPaoMap(event:MouseEvent) : void
        {
            AlertUI.alert(Config.language("Radar", 41), Config.language("Radar", 42), [Config.language("Radar", 37), Config.language("Radar", 38)], [this.centerPaoBack]);
            return;
        }// end function

        private function backToAirMap(event:MouseEvent) : void
        {
            Config.ui._toAirPanel.leftCheck();
            return;
        }// end function

        private function backlandLeft(event:MouseEvent) : void
        {
            AlertUI.alert(Config.language("Radar", 41), Config.language("Radar", 56), [Config.language("Radar", 37), Config.language("Radar", 38)], [this.surebacklandLeft]);
            return;
        }// end function

        private function surebacklandLeft(event:MouseEvent)
        {
            Config.ui._landGravePanel.sendLandLeft();
            return;
        }// end function

        private function showLandInfo(event:MouseEvent) : void
        {
            Config.ui._landGravePanel.showLandInfo();
            return;
        }// end function

        private function leftInterPk(event:MouseEvent) : void
        {
            Config.ui._interPkPanel.leftInterPk();
            return;
        }// end function

        private function showlookmap(event:MouseEvent)
        {
            Config.ui._lookmapanel.lookmap(event.currentTarget.data);
            return;
        }// end function

        private function leaverfollowmap(event:MouseEvent)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LEAVE_ACCGUARD);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function leavermanyairmap(event:MouseEvent) : void
        {
            AlertUI.alert(Config.language("Radar", 41), Config.language("Radar", 58), [Config.language("Radar", 29), Config.language("Radar", 38)], [this.quickfb]);
            return;
        }// end function

        private function quickfb(event:MouseEvent)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LEAVE_MULTISKYTOWER);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function addlookmapBtn(param1:String)
        {
            this.addChild(this.lookmapBtn);
            this.lookmapBtn.x = (-(Config.ui._width - 100)) / 2 - 160;
            this.lookmapBtn.y = Config.ui._height - 160;
            this.lookmapBtn.data = param1;
            return;
        }// end function

        public function changresizey()
        {
            if (this.lookmapBtn.parent != null)
            {
                this.lookmapBtn.x = (-(Config.ui._width - 100)) / 2 - 160;
                this.lookmapBtn.y = Config.ui._height - 160;
            }
            return;
        }// end function

        public function remlookmapBtn()
        {
            if (this.lookmapBtn.parent != null)
            {
                this.removeChild(this.lookmapBtn);
            }
            return;
        }// end function

        public function visiblelookmapBtn(param1:Boolean)
        {
            if (this.lookmapBtn.parent != null)
            {
                if (param1)
                {
                    this.lookmapBtn.visible = true;
                }
                else
                {
                    this.lookmapBtn.visible = false;
                }
            }
            return;
        }// end function

        private function centerBack(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LEFT_UMAP);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function centerPaoBack(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_CANNON_OUT);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function showGiftBack() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (Config._giftMap[Config.map.id] != null)
            {
                this.addChild(this.giftLeftBtn);
                Config.ui._giftDare.close();
            }
            else if (this.giftLeftBtn.parent != null)
            {
                this.removeChild(this.giftLeftBtn);
                this.removecultivation();
            }
            if (Config.map._type == 19)
            {
                this.addChild(this.paoLeftBtn);
            }
            else if (this.paoLeftBtn.parent != null)
            {
                this.removeChild(this.paoLeftBtn);
            }
            if (Config.map._type == 20)
            {
                this.addChild(this.toAirLeftBtn);
            }
            else if (this.toAirLeftBtn.parent != null)
            {
                this.removeChild(this.toAirLeftBtn);
            }
            if (Config.map._type == 21)
            {
                this.addChild(this.landLeftBtn);
                this.addChild(this.landInfoBtn);
                Config.ui._landGravePanel.addLandWar(this);
                Config.ui._activePanel.close();
                Config.ui._landGravePanel.close();
            }
            else
            {
                if (this.landLeftBtn.parent != null)
                {
                    this.removeChild(this.landLeftBtn);
                }
                if (this.landInfoBtn.parent != null)
                {
                    this.removeChild(this.landInfoBtn);
                }
                Config.ui._landGravePanel.removeLandWar();
            }
            if (Config.map._type == 22)
            {
                this.addChild(this.interPkBtn);
                Config.ui._interPkPanel.addPkTime(this);
            }
            else if (this.interPkBtn.parent != null)
            {
                this.removeChild(this.interPkBtn);
                Config.ui._interPkPanel.removePkTime();
            }
            if (Config.map._type == 23)
            {
                if (this.interwarBtn.parent == null)
                {
                    this.addChild(this.interwarBtn);
                }
            }
            else if (this.interwarBtn.parent != null)
            {
                this.removeChild(this.interwarBtn);
            }
            if (Config.map._type == 26)
            {
                if (Config.ui._taskpanel._tasktips.opening)
                {
                    Config.ui._taskpanel._tasktips.close();
                }
                if (this.leaverfollowmapBtn.parent == null)
                {
                    this.addChild(this.leaverfollowmapBtn);
                }
                if (this._inforsprite == null)
                {
                    this._inforsprite = new Sprite();
                    this._inforsprite.x = -150;
                    this._inforsprite.y = 200;
                    Config.ui._radar.addChild(this._inforsprite);
                    _loc_2 = [new GlowFilter(0, 1, 2, 2, 10)];
                    _loc_1 = new Label(this._inforsprite, 0, 0, Config.language("Radar", 59));
                    _loc_1.textColor = 16752190;
                    _loc_1.filters = _loc_2;
                    _loc_1 = new Label(this._inforsprite, 0, 0, "_______________________");
                    _loc_1.textColor = 16752190;
                    _loc_1.filters = _loc_2;
                    _loc_1 = new Label(this._inforsprite, 0, 30);
                    _loc_1.html = true;
                    _loc_1.textColor = 16752190;
                    _loc_1.text = Config.language("Radar", 60);
                    _loc_1.filters = _loc_2;
                }
            }
            else
            {
                if (this.leaverfollowmapBtn.parent != null)
                {
                    this.removeChild(this.leaverfollowmapBtn);
                }
                if (!Config.ui._taskpanel._tasktips.opening)
                {
                    Config.ui._taskpanel._tasktips.open();
                }
                if (this._inforsprite != null)
                {
                    if (this._inforsprite.parent != null)
                    {
                        while (this._inforsprite.numChildren > 0)
                        {
                            
                            this._inforsprite.removeChildAt((this._inforsprite.numChildren - 1));
                        }
                        this.removeChild(this._inforsprite);
                        trace(this._inforsprite);
                        this._inforsprite = null;
                    }
                }
            }
            if (Config.map._type == 27)
            {
                if (this.manytoAirLeftBtn.parent == null)
                {
                    this.addChild(this.manytoAirLeftBtn);
                    Config.ui._manyplayertoair.entermap();
                }
            }
            else if (this.manytoAirLeftBtn.parent != null)
            {
                this.removeChild(this.manytoAirLeftBtn);
                Config.ui._manyplayertoair.backmap();
            }
            return;
        }// end function

        private function sendleftmap(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_BDG_LEFT);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function pkactivestart(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 0)
            {
                this.addChild(this.pkraceBtn);
            }
            else if (_loc_3 == 1)
            {
                if (this.pkraceBtn.parent != null)
                {
                    this.removeChild(this.pkraceBtn);
                }
            }
            return;
        }// end function

        public function hidepkraceBtn()
        {
            if (this.pkraceBtn != null)
            {
                if (this.pkraceBtn.parent != null)
                {
                    this.removeChild(this.pkraceBtn);
                }
            }
            return;
        }// end function

        public function showpkraceBtn()
        {
            this.addChild(this.pkraceBtn);
            return;
        }// end function

        private function interwarleft(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GUILDVS_LEFT);
            ClientSocket.send(_loc_2);
            Config.ui._interBigwar.stoptimer();
            return;
        }// end function

        public function addcultivation() : void
        {
            this._sppt = Config.ui._sellCultivation.addcultivationsprite();
            this.addChild(this._sppt);
            this._sppt.x = (-Config.ui._width) / 2 - 27;
            this._sppt.y = 40;
            return;
        }// end function

        public function changresizecultivate() : void
        {
            this._sppt = Config.ui._sellCultivation.addcultivationsprite();
            if (this._sppt.parent != null)
            {
                this._sppt.x = (-Config.ui._width) / 2 - 27;
            }
            return;
        }// end function

        public function removecultivation() : void
        {
            this._sppt = Config.ui._sellCultivation.addcultivationsprite();
            if (this._sppt.parent != null)
            {
                this.removeChild(this._sppt);
            }
            return;
        }// end function

        private function showing(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 1)
            {
                if (this._gclip == null)
                {
                    this._gclip = GClip.newGClip("activebutton");
                    this._gclip.x = -158 - 15;
                    this._gclip.y = 78 - 14;
                    this._gclip.mouseChildren = false;
                    this._gclip.mouseEnabled = false;
                    this.addChild(this._gclip);
                }
            }
            else if (this._gclip != null)
            {
                if (GClip(this._gclip).parent != null)
                {
                    GClip(this._gclip).parent.removeChild(GClip(this._gclip));
                }
                GClip(this._gclip).destroy();
            }
            Config.ui._activePanel.refresh();
            return;
        }// end function

    }
}
