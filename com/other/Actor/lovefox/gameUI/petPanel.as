package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class petPanel extends Window
    {
        public var soulPanel:Window;
        private var washPanel:Window;
        private var foodPanel:Window;
        private var noPetPanel:Window;
        private var rhpanel:Window;
        private var mixPanel:Window;
        private var petIcon:CloneSlot;
        private var nameText:Label;
        private var levelText:Label;
        private var soulBar:ProgressBar;
        private var soulBarLabel:Label;
        private var hpText:Label;
        private var mpText:Label;
        private var atkText:Label;
        private var defText:Label;
        private var bhpText:Label;
        private var bmpText:Label;
        private var batkText:Label;
        private var bdefText:Label;
        private var hpBar:ProgressBar;
        private var hpBarLabel:Label;
        private var mpBar:ProgressBar;
        private var mpBarLabel:Label;
        private var atkBar:ProgressBar;
        private var atkBarLabel:Label;
        private var defBar:ProgressBar;
        private var defBarLabel:Label;
        private var giftText:Label;
        private var growBar:ProgressBar;
        private var growBarLabel:Label;
        private var levelMax:Label;
        public var soulPets:Array;
        public var currentPetSlot:CloneSlot;
        private var _orangeCB:CheckBox;
        private var _purpleCB:CheckBox;
        private var currentPetName:Label;
        private var soulValueText:Label;
        private var _pickItemPosition:int = 0;
        private var _skillList:Array;
        private var _learnSkillList:Array;
        private var petItem:Item;
        private var _cdtime:int = 0;
        private var _petflag:Boolean = true;
        private var _skillSlotArr:Array;
        private var typeRba:RadioButton;
        private var typeRbb:RadioButton;
        private var typeRbc:RadioButton;
        private var typeRbd:RadioButton;
        private var washType:int = 3;
        private var washtexta:Label;
        private var washtextb:Label;
        private var washtextc:Label;
        private var washmaxNum:int = 0;
        public var washbtn:PushButton;
        private var hpWashBar:ProgressBar;
        private var hpWashBarLabel:Label;
        private var mpWashBar:ProgressBar;
        private var mpWashBarLabel:Label;
        private var atkWashBar:ProgressBar;
        private var atkWashBarLabel:Label;
        private var defWashBar:ProgressBar;
        private var defWashBarLabel:Label;
        private var washcl:ClickLabel;
        private var washIcon:CloneSlot;
        public var xhBtn:PushButton;
        private var slotarr:Array;
        private var skillCdarr:Array;
        private var radioFlag:int = 0;
        private var updateBtn:PushButton;
        private var getoutBtn:PushButton;
        private var upTipLabel:Label;
        private var templabel1:Label;
        private var templabel2:Label;
        private var mixPetIcon:CloneSlot;
        private var mixNameText:TextField;
        private var mixhp:Label;
        private var mixmp:Label;
        private var mixatk:Label;
        private var mixdef:Label;
        private var mixhp2:Label;
        private var mixmp2:Label;
        private var mixatk2:Label;
        private var mixdef2:Label;
        private var tomixLabel:Label;
        private var tomixName:TextField;
        private var mixslot:CloneSlot;
        private var _tempHp:int = 0;
        private var _tempMp:int = 0;
        private var _tempAtk:int = 0;
        private var _tempDef:int = 0;
        private var mixBtn:PushButton;
        private var mixCenter:PushButton;
        private var mixCancel:PushButton;
        private var _hammerPanel:HammerPanel;
        private var _doSoul0:int = 0;
        private var _doSoul1:int = 0;
        private var _doSoul2:int = 0;
        private var _only1:int = 0;

        public function petPanel(param1:DisplayObjectContainer)
        {
            this.soulPets = [];
            this._skillList = [];
            this._learnSkillList = [];
            this._skillSlotArr = [];
            this.slotarr = [];
            this.skillCdarr = [];
            super(param1);
            this.title = Config.language("petPanel", 1);
            resize(530, 370);
            this.initpanel();
            this.initSoulPanel();
            this.initNoPanel();
            this.initrhPanel();
            this.initmixPanel();
            return;
        }// end function

        override public function switchOpen() : void
        {
            if (this.petItem != null)
            {
                super.switchOpen();
                if (this.parent != null)
                {
                    this.petChange();
                }
            }
            else
            {
                this.noPetPanel.switchOpen();
                this.noPetPanel.x = this.x;
                this.noPetPanel.y = this.y;
            }
            return;
        }// end function

        override public function close()
        {
            super.close();
            this.reFoodUnlock();
            if (this.rhpanel != null)
            {
                this.rhpanel.close();
            }
            if (this.mixPanel != null)
            {
                this.mixPanel.close();
                this.toMixNull();
            }
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            this.templabel1 = new Label(null, 0, 0);
            this.templabel1.html = true;
            this.templabel2 = new Label(null, 0, 0);
            this.templabel2.html = true;
            var _loc_1:* = new Shape();
            this.addChild(_loc_1);
            _loc_1.graphics.beginFill(0, 0.1);
            _loc_1.graphics.drawRoundRect(50 - 35, 120, 220 + 35, 110, 3);
            _loc_1.graphics.drawRoundRect(50 - 35, 240, 220 + 35, 120, 3);
            _loc_1.graphics.drawRoundRect(285, 35, 240, 242, 3);
            _loc_1.graphics.beginFill(16777215, 0.2);
            _loc_1.graphics.drawRoundRect(280, 25, 245, 340, 1);
            _loc_1.graphics.endFill();
            this.petIcon = new CloneSlot(0, 33);
            this.petIcon.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.petIcon.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.addChild(this.petIcon);
            this.petIcon.x = 20;
            this.petIcon.y = 30;
            this.nameText = new Label(this, 60, 40);
            this.nameText.html = true;
            _loc_2 = new Label(this, 25, 70, Config.language("petPanel", 2));
            _loc_2.tip = Config.language("petPanel", 3);
            this.levelText = new Label(this, 100, 70);
            this.levelText.tip = Config.language("petPanel", 3);
            this.levelMax = new Label(this, 145, 70);
            this.levelMax.tip = Config.language("petPanel", 3);
            this.levelMax.html = true;
            _loc_2 = new Label(this, 25, 90, Config.language("petPanel", 4));
            this.soulBar = new ProgressBar(this, 85, 92);
            this.soulBar.height = 15;
            this.soulBar.width = 115;
            this.soulBar.gradientFillDirection = Math.PI;
            this.soulBar.roundCorner = 1;
            this.soulBar.color = 15981107;
            this.soulBar.subColor = 16750899;
            this.soulBarLabel = new Label(this, 40, 90);
            this.xhBtn = new PushButton(this, 205, 90, Config.language("petPanel", 5), this.soulPanelOpen);
            this.xhBtn.width = 62;
            this.xhBtn.setTable("table18", "table31");
            this.xhBtn.textColor = Style.GOLD_FONT;
            this.xhBtn.overshow = true;
            this.xhBtn.addEventListener(MouseEvent.ROLL_OVER, this.xhBtnOver);
            this.xhBtn.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            _loc_3 = new Label(this, 60 - 35, 120, "<b>" + Config.language("petPanel", 6) + "<b>");
            _loc_3.html = true;
            var _loc_4:* = new ClickLabel(this, 110, 120, Config.language("petPanel", 7), this.openrh, true);
            new ClickLabel(this, 110, 120, Config.language("petPanel", 7), this.openrh, true).clickColor([39423, 16544]);
            var _loc_5:* = new PushButton(this, 205, 120, Config.language("petPanel", 130), this.openMixPanel);
            new PushButton(this, 205, 120, Config.language("petPanel", 130), this.openMixPanel).setTable("table18", "table31");
            _loc_5.width = 62;
            _loc_5.textColor = Style.GOLD_FONT;
            _loc_5.overshow = true;
            var _loc_6:* = new PushButton(this, 205, 245, Config.language("petPanel", 8), this.openWashPanel);
            new PushButton(this, 205, 245, Config.language("petPanel", 8), this.openWashPanel).setTable("table18", "table31");
            _loc_6.width = 62;
            _loc_6.textColor = Style.GOLD_FONT;
            _loc_6.overshow = true;
            this.hpText = new Label(this, 25, 145);
            this.mpText = new Label(this, 25, 165);
            this.atkText = new Label(this, 25, 185);
            this.defText = new Label(this, 25, 205);
            this.bhpText = new Label(this, 110, 145);
            this.bmpText = new Label(this, 110, 165);
            this.batkText = new Label(this, 110, 185);
            this.bdefText = new Label(this, 110, 205);
            var _loc_7:* = new Label(this, 240, 145, "]");
            var _loc_8:* = new Label(this, 240, 165, "]");
            var _loc_9:* = new Label(this, 240, 185, "]");
            var _loc_10:* = new Label(this, 240, 205, "]");
            var _loc_11:* = new Label(this, 60 - 35, 245, "<b>" + Config.language("petPanel", 9) + "<b>");
            new Label(this, 60 - 35, 245, "<b>" + Config.language("petPanel", 9) + "<b>").html = true;
            var _loc_12:* = new Label(this, 60 - 35, 270, Config.language("petPanel", 10));
            var _loc_13:* = new Label(this, 60 - 35, 290, Config.language("petPanel", 11));
            var _loc_14:* = new Label(this, 60 - 35, 310, Config.language("petPanel", 12));
            var _loc_15:* = new Label(this, 60 - 35, 330, Config.language("petPanel", 13));
            this.hpBar = new ProgressBar(this, 110, 270);
            this.hpBar.height = 15;
            this.hpBar.width = 130;
            this.hpBar.gradientFillDirection = Math.PI;
            this.hpBar.roundCorner = 1;
            this.hpBar.color = 15981107;
            this.hpBar.subColor = 16750899;
            this.hpBarLabel = new Label(this, 110, 270);
            this.mpBar = new ProgressBar(this, 110, 290);
            this.mpBar.height = 15;
            this.mpBar.width = 130;
            this.mpBar.gradientFillDirection = Math.PI;
            this.mpBar.roundCorner = 1;
            this.mpBar.color = 15981107;
            this.mpBar.subColor = 16750899;
            this.mpBarLabel = new Label(this, 110, 290);
            this.atkBar = new ProgressBar(this, 110, 310);
            this.atkBar.height = 15;
            this.atkBar.width = 130;
            this.atkBar.gradientFillDirection = Math.PI;
            this.atkBar.roundCorner = 1;
            this.atkBar.color = 15981107;
            this.atkBar.subColor = 16750899;
            this.atkBarLabel = new Label(this, 110, 310);
            this.defBar = new ProgressBar(this, 110, 330);
            this.defBar.height = 15;
            this.defBar.width = 130;
            this.defBar.gradientFillDirection = Math.PI;
            this.defBar.roundCorner = 1;
            this.defBar.color = 15981107;
            this.defBar.subColor = 16750899;
            this.defBarLabel = new Label(this, 110, 330);
            this.giftText = new Label(this, 290, 40);
            this.giftText.html = true;
            _loc_3 = new Label(this, 290, 65, Config.language("petPanel", 14));
            this.growBar = new ProgressBar(this, 350, 65);
            this.growBar.height = 15;
            this.growBar.width = 105;
            this.growBar.gradientFillDirection = Math.PI;
            this.growBar.roundCorner = 1;
            this.growBar.color = 15981107;
            this.growBar.subColor = 16750899;
            this.growBarLabel = new Label(this, 350, 65);
            var _loc_16:* = new PushButton(this, 465, 65, Config.language("petPanel", 15), this.openfoodPanel);
            new PushButton(this, 465, 65, Config.language("petPanel", 15), this.openfoodPanel).width = 50;
            _loc_16.setTable("table18", "table31");
            _loc_16.textColor = Style.GOLD_FONT;
            _loc_16.overshow = true;
            var _loc_17:* = Config.findsysUI("petpanel/hammer", 17, 17);
            var _loc_18:* = 0;
            while (_loc_18 < 6)
            {
                
                _loc_21 = {};
                _loc_21.position = _loc_18 + 1;
                _loc_21.contain = new Sprite();
                this.addChild(_loc_21.contain);
                _loc_21.contain.addEventListener(MouseEvent.CLICK, Config.create(this.handleSkillClick, _loc_21));
                _loc_21.contain.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.handleSkillOver, _loc_21));
                _loc_21.contain.addEventListener(MouseEvent.ROLL_OUT, Config.create(this.handleSkillOut, _loc_21));
                _loc_21.contain.x = 290;
                _loc_21.contain.y = 100 + 25 * _loc_18;
                _loc_21.hammer = new Sprite();
                _loc_21.hammer.buttonMode = true;
                _loc_22 = new Bitmap(_loc_17);
                _loc_21.hammer.addChild(_loc_22);
                _loc_21.hammer.x = 192;
                _loc_21.hammer.y = 1;
                _loc_21.hammer.addEventListener(MouseEvent.CLICK, Config.create(this.handleHammer, _loc_21));
                _loc_21.contain.addChild(_loc_21.hammer);
                this._learnSkillList.push(_loc_21);
                _loc_18 = _loc_18 + 1;
            }
            this.updateBtn = new PushButton(this, 290, 252, Config.language("petPanel", 16), this.checkLearn);
            this.updateBtn.width = 50;
            this.updateBtn.setTable("table18", "table31");
            this.updateBtn.textColor = Style.GOLD_FONT;
            this.updateBtn.overshow = true;
            this.updateBtn.addEventListener(MouseEvent.ROLL_OVER, this.learnOver);
            this.updateBtn.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.getoutBtn = new PushButton(this, 455, 252, Config.language("petPanel", 17), this.checkOut);
            this.getoutBtn.width = 50;
            this.getoutBtn.setTable("table18", "table31");
            this.getoutBtn.textColor = Style.GOLD_FONT;
            this.getoutBtn.overshow = true;
            this.getoutBtn.addEventListener(MouseEvent.ROLL_OVER, this.handleBtnOver);
            this.getoutBtn.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.upTipLabel = new Label(this, 350, 252);
            var _loc_19:* = new Label(this, 290, 280, "<b>" + Config.language("petPanel", 18) + "<b>");
            new Label(this, 290, 280, "<b>" + Config.language("petPanel", 18) + "<b>").html = true;
            var _loc_20:* = 0;
            while (_loc_20 < 3)
            {
                
                _loc_21 = {};
                _loc_21.position = _loc_20 + 1;
                _loc_21.skillId = 0;
                _loc_21.lock = 0;
                _loc_21.skillClone = new CloneSlot(_loc_20, 32);
                this.addChild(_loc_21.skillClone);
                _loc_21.skillClone.x = 290 + 55 * _loc_20;
                _loc_21.skillClone.y = 305;
                _loc_21.skillClone.addEventListener("sglClick", Config.create(this.handleSlotClick2, _loc_21));
                _loc_21.skillClone.addEventListener("drag", Config.create(this.handleSlotClick2, _loc_21));
                _loc_21.skillClone.addEventListener("up", Config.create(this.handleSlotUp2, _loc_21));
                _loc_21.skillClone.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                _loc_21.skillClone.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_21.skillClone.buttonMode = true;
                _loc_21.unfit = new ClickLabel(this, 293 + 55 * _loc_20, 340, Config.language("petPanel", 19), Config.create(this.checkCardOut, _loc_21));
                _loc_21.unfit.clickColor([39423, 16544]);
                this._skillList.push(_loc_21);
                _loc_23 = new CloneSlot(0, 32);
                _loc_23.addEventListener(MouseEvent.CLICK, this.handleEntertainClick);
                _loc_23.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                _loc_23.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                this._skillSlotArr.push(_loc_23);
                _loc_20 = _loc_20 + 1;
            }
            this.setNullPet();
            Config.ui._charUI.addEventListener("petchange", this.petChange);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PET_MAKEUP_COOL_DOWN, this.backCd);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PET_MAKEUP_STATUS, this.backPlayerStatus);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PET_POLISH_RESULT, this.backWash);
            return;
        }// end function

        private function handleHammer(event:MouseEvent, param2:Object) : void
        {
            if (this._hammerPanel == null)
            {
                this._hammerPanel = new HammerPanel(Config.ui._layer3, x + 100, y + 150);
            }
            this._hammerPanel.open();
            this._hammerPanel.resetProp(param2.position, param2.skillText.text);
            return;
        }// end function

        private function initSoulPanel() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            Config.ui._charUI.addEventListener("itemchange", this.reshowCL);
            this.soulPanel = new Window(Config.ui._layer3);
            this.soulPanel.title = Config.language("petPanel", 5);
            this.soulPanel.resize(290, 314);
            this.soulPanel.addEventListener("close", this.handleSoulPanelClose);
            _loc_1 = 0;
            while (_loc_1 < 7)
            {
                
                _loc_2 = 0;
                while (_loc_2 < 5)
                {
                    
                    _loc_10 = new CloneSlot(_loc_2 * 7 + _loc_1, 32);
                    _loc_10.x = _loc_1 * 37 + 17;
                    _loc_10.y = _loc_2 * 37 + 86;
                    _loc_10.addEventListener("sglClick", this.handleSoulPetClick);
                    _loc_10.addEventListener(MouseEvent.ROLL_OVER, this.handleSoulPetOver);
                    _loc_10.addEventListener(MouseEvent.ROLL_OUT, this.handleSoulPetOut);
                    this.soulPets[_loc_2 * 7 + _loc_1] = _loc_10;
                    this.soulPanel.addChild(_loc_10);
                    _loc_2++;
                }
                _loc_1++;
            }
            this.currentPetSlot = new CloneSlot(100, 32);
            this.currentPetSlot.addEventListener(MouseEvent.ROLL_OVER, this.handleSoulPetOver);
            this.currentPetSlot.addEventListener(MouseEvent.ROLL_OUT, this.handleSoulPetOut);
            this.currentPetSlot.x = 44;
            this.currentPetSlot.y = 29;
            this.soulPanel.addChild(this.currentPetSlot);
            this._purpleCB = new CheckBox(this.soulPanel, 120, 70, Config.language("petPanel", 149), this.handleReloadSoul);
            this._orangeCB = new CheckBox(this.soulPanel, 200, 70, Config.language("petPanel", 150), this.handleReloadSoul);
            this.currentPetName = new Label(this.soulPanel, 86, 28, "");
            this.currentPetName.html = true;
            var _loc_3:* = new Label(this.soulPanel, 86, 47, Config.language("petPanel", 21));
            this.soulValueText = new Label(this.soulPanel, 178, 47, "0");
            var _loc_4:* = new PushButton(this.soulPanel, 120, 280, Config.language("petPanel", 22), this.sendSoulFuc);
            new PushButton(this.soulPanel, 120, 280, Config.language("petPanel", 22), this.sendSoulFuc).width = 50;
            var _loc_12:* = new Window(Config.ui._layer1);
            this.washPanel = new Window(Config.ui._layer1);
            Config.ui._windowStack.push(_loc_12);
            this.washPanel.title = Config.language("petPanel", 23);
            this.washPanel.resize(250, 330);
            var _loc_5:* = new Shape();
            this.washPanel.addChild(_loc_5);
            _loc_5.graphics.beginFill(16777215, 0.4);
            _loc_5.graphics.drawRoundRect(10, 145, 230, 70, 3);
            _loc_5.graphics.drawRoundRect(10, 225, 230, 45, 3);
            _loc_5.graphics.endFill();
            var _loc_6:* = new Label(this.washPanel, 20, 30, Config.language("petPanel", 24));
            this.typeRba = new RadioButton(this.washPanel, 20, 60, Config.language("petPanel", 121), false, Config.create(this.selectWash, 3));
            this.typeRba.group = "washgroup";
            this.typeRbb = new RadioButton(this.washPanel, 20, 80, Config.language("petPanel", 122), false, Config.create(this.selectWash, 4));
            this.typeRbb.group = "washgroup";
            this.typeRbc = new RadioButton(this.washPanel, 20, 100, Config.language("petPanel", 123), false, Config.create(this.selectWash, 1));
            this.typeRbc.group = "washgroup";
            this.typeRbd = new RadioButton(this.washPanel, 20, 120, Config.language("petPanel", 124), false, Config.create(this.selectWash, 2));
            this.typeRbd.group = "washgroup";
            this.hpWashBar = new ProgressBar(this.washPanel, 90, 60);
            this.hpWashBar.height = 15;
            this.hpWashBar.width = 130;
            this.hpWashBar.gradientFillDirection = Math.PI;
            this.hpWashBar.roundCorner = 1;
            this.hpWashBar.color = 15981107;
            this.hpWashBar.subColor = 16750899;
            this.hpWashBarLabel = new Label(this.washPanel, 90, 60);
            this.mpWashBar = new ProgressBar(this.washPanel, 90, 80);
            this.mpWashBar.height = 15;
            this.mpWashBar.width = 130;
            this.mpWashBar.gradientFillDirection = Math.PI;
            this.mpWashBar.roundCorner = 1;
            this.mpWashBar.color = 15981107;
            this.mpWashBar.subColor = 16750899;
            this.mpWashBarLabel = new Label(this.washPanel, 90, 80);
            this.atkWashBar = new ProgressBar(this.washPanel, 90, 100);
            this.atkWashBar.height = 15;
            this.atkWashBar.width = 130;
            this.atkWashBar.gradientFillDirection = Math.PI;
            this.atkWashBar.roundCorner = 1;
            this.atkWashBar.color = 15981107;
            this.atkWashBar.subColor = 16750899;
            this.atkWashBarLabel = new Label(this.washPanel, 90, 100);
            this.defWashBar = new ProgressBar(this.washPanel, 90, 120);
            this.defWashBar.height = 15;
            this.defWashBar.width = 130;
            this.defWashBar.gradientFillDirection = Math.PI;
            this.defWashBar.roundCorner = 1;
            this.defWashBar.color = 15981107;
            this.defWashBar.subColor = 16750899;
            this.defWashBarLabel = new Label(this.washPanel, 90, 120);
            this.washtexta = new Label(this.washPanel, 20, 150);
            this.washtexta.html = true;
            this.washtextb = new Label(this.washPanel, 20, 170);
            this.washtextb.html = true;
            this.washtextc = new Label(this.washPanel, 20, 190);
            this.washtextc.html = true;
            var _loc_7:* = new Label(this.washPanel, 20, 230, Config.language("petPanel", 125));
            this.washcl = new ClickLabel(this.washPanel, 20, 250, Config.language("petPanel", 126), this.openCLpanel, true);
            this.washcl.clickColor([39423, 16544]);
            this.washIcon = new CloneSlot(0, 32);
            this.washIcon.x = 90;
            this.washIcon.y = 230;
            this.washPanel.addChild(this.washIcon);
            this.washIcon.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.washIcon.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            var _loc_8:* = new LabelUI(this.washPanel, 20, 275, Config.language("petPanel", 25));
            this.washbtn = new PushButton(this.washPanel, 100, 295, Config.language("petPanel", 8), this.checkWashSend);
            this.washbtn.width = 50;
            this.foodPanel = new Window(Config.ui._layer3);
            this.foodPanel.title = Config.language("petPanel", 26);
            this.foodPanel.resize(170, 220);
            this.slotarr = new Array();
            _loc_1 = 0;
            while (_loc_1 < 9)
            {
                
                _loc_11 = new CloneSlot(_loc_1 + 5, 32);
                _loc_11.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                _loc_11.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_11.addEventListener("sglClick", this.handleSlotClick3);
                _loc_11.addEventListener("drag", this.handleSlotClick3);
                _loc_11.addEventListener("up", this.handleSlotUp3);
                this.slotarr.push(_loc_11);
                this.foodPanel.addChild(_loc_11);
                _loc_11.x = _loc_1 % 3 * 40 + 30;
                _loc_11.y = int(_loc_1 / 3) * 40 + 40;
                _loc_1++;
            }
            var _loc_9:* = new PushButton(this.foodPanel, 60, 170, Config.language("petPanel", 15), this.feedFuc);
            new PushButton(this.foodPanel, 60, 170, Config.language("petPanel", 15), this.feedFuc).width = 50;
            return;
        }// end function

        private function handleSoulPetClick(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                _loc_3 = _loc_2.item._drawer[_loc_2.item._position];
                _loc_3.unlock();
                _loc_2.item = null;
                this.countSoulAll();
            }
            return;
        }// end function

        private function handleSoulPetOver(param1)
        {
            var _loc_2:* = param1.currentTarget;
            var _loc_3:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), false, 0, 200);
            }
            return;
        }// end function

        private function handleSoulPetOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function initNoPanel() : void
        {
            var _loc_7:* = new Window(Config.ui._layer1);
            this.noPetPanel = new Window(Config.ui._layer1);
            Config.ui._windowStack.push(_loc_7);
            this.noPetPanel.title = Config.language("petPanel", 27);
            this.noPetPanel.resize(480, 370);
            var _loc_1:* = new Shape();
            this.noPetPanel.addChild(_loc_1);
            _loc_1.graphics.beginFill(6710886, 0.2);
            _loc_1.graphics.drawRoundRect(10, 90, 460, 80, 1);
            _loc_1.graphics.drawRoundRect(10, 200, 460, 150, 1);
            _loc_1.graphics.endFill();
            var _loc_2:* = new Label(this.noPetPanel, 160, 40, Config.language("petPanel", 28));
            var _loc_3:* = new Label(this.noPetPanel, 10, 70, "<b>" + Config.language("petPanel", 29) + "<b>");
            _loc_3.html = true;
            var _loc_4:* = new TextAreaUI(this.noPetPanel, 20, 100, 440, 200);
            new TextAreaUI(this.noPetPanel, 20, 100, 440, 200).autoHeight = true;
            _loc_4.text = Config.language("petPanel", 30);
            var _loc_5:* = new Label(this.noPetPanel, 10, 180, "<b>" + Config.language("petPanel", 31) + "<b>");
            new Label(this.noPetPanel, 10, 180, "<b>" + Config.language("petPanel", 31) + "<b>").html = true;
            var _loc_6:* = new TextAreaUI(this.noPetPanel, 20, 210, 440, 200);
            new TextAreaUI(this.noPetPanel, 20, 210, 440, 200).autoHeight = true;
            _loc_6.text = Config.language("petPanel", 32);
            return;
        }// end function

        private function initrhPanel() : void
        {
            this.rhpanel = new Window(this);
            this.rhpanel.title = Config.language("petPanel", 33);
            this.rhpanel.resize(430, 260);
            this.rhpanel.x = 20;
            this.rhpanel.y = 30;
            var _loc_1:* = new Shape();
            this.rhpanel.addChild(_loc_1);
            _loc_1.graphics.beginFill(16777215, 0.2);
            _loc_1.graphics.drawRoundRect(10, 50, 410, 190, 1);
            _loc_1.graphics.endFill();
            var _loc_2:* = new Label(this.rhpanel, 10, 30, "<b>" + Config.language("petPanel", 33) + "<b>");
            _loc_2.html = true;
            var _loc_3:* = new TextAreaUI(this.rhpanel, 15, 50, 410, 300);
            _loc_3.autoHeight = true;
            _loc_3.text = Config.language("petPanel", 34);
            return;
        }// end function

        public function reFoodUnlock() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this.soulPets.length)
            {
                
                if (this.soulPets[_loc_1].item != null)
                {
                    _loc_2 = this.soulPets[_loc_1].item._drawer[this.soulPets[_loc_1].item._position];
                    _loc_2.unlock();
                    this.soulPets[_loc_1].item = null;
                }
                _loc_1 = _loc_1 + 1;
            }
            if (this.soulValueText != null)
            {
                this.soulValueText.text = "0";
            }
            return;
        }// end function

        private function openWashPanel(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.petItem != null)
            {
                if (this.soulPanel.parent != null)
                {
                    this.soulPanel.close();
                }
                if (this.foodPanel.parent != null)
                {
                    this.foodPanel.close();
                    _loc_2 = 0;
                    while (_loc_2 < this.slotarr.length)
                    {
                        
                        if (this.slotarr[_loc_2].item != null)
                        {
                            _loc_3 = this.slotarr[_loc_2].item._drawer[this.slotarr[_loc_2].item._position];
                            _loc_3.unlock();
                            this.slotarr[_loc_2].item = null;
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                }
                this.washPanel.switchOpen();
                this.washPanel.x = (Config.ui._width - this.washPanel.width) / 2;
                this.washPanel.y = 20;
                this.washmaxNum = 0;
                this.refreshWash();
            }
            else
            {
                Config.message(Config.language("petPanel", 35));
            }
            return;
        }// end function

        private function openfoodPanel(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.petItem != null)
            {
                if (this.soulPanel.parent != null)
                {
                    this.soulPanel.close();
                }
                if (this.washPanel.parent != null)
                {
                    this.washPanel.close();
                }
                this.foodPanel.switchOpen();
                this.foodPanel.x = this.x + 20;
                this.foodPanel.y = this.y + 40;
                _loc_2 = 0;
                while (_loc_2 < this.slotarr.length)
                {
                    
                    if (this.slotarr[_loc_2].item != null)
                    {
                        _loc_3 = this.slotarr[_loc_2].item._drawer[this.slotarr[_loc_2].item._position];
                        _loc_3.unlock();
                        this.slotarr[_loc_2].item = null;
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                Config.message(Config.language("petPanel", 36));
            }
            return;
        }// end function

        private function soulPanelOpen(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.petItem != null)
            {
                if (this.washPanel.parent != null)
                {
                    this.washPanel.close();
                }
                if (this.foodPanel.parent != null)
                {
                    this.foodPanel.close();
                    _loc_2 = 0;
                    while (_loc_2 < this.slotarr.length)
                    {
                        
                        if (this.slotarr[_loc_2].item != null)
                        {
                            _loc_3 = this.slotarr[_loc_2].item._drawer[this.slotarr[_loc_2].item._position];
                            _loc_3.unlock();
                            this.slotarr[_loc_2].item = null;
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                }
                this.soulPanel.switchOpen();
                this.soulPanel.x = this.x + 50;
                this.soulPanel.y = this.y + 40;
                if (this.soulPanel._opening)
                {
                    Config.ui._bagUI.open();
                    Config.ui._bagUI.x = this.soulPanel.x + this.soulPanel.width + 15;
                    Config.ui._bagUI.y = this.soulPanel.y;
                    if (Config.ui._bagUI.x + Config.ui._bagUI.width > Config.ui._width)
                    {
                        this.soulPanel.x = (Config.ui._width - (Config.ui._bagUI.x + Config.ui._bagUI.width - this.soulPanel.x)) / 2;
                        Config.ui._bagUI.x = this.soulPanel.x + this.soulPanel.width + 15;
                    }
                }
                this._orangeCB.selected = false;
                this._purpleCB.selected = false;
                GuideUI.testDoId(219, Config.ui._systemUI._bagPB, Config.ui._bagUI);
                this.loadSoul();
            }
            else
            {
                Config.message(Config.language("petPanel", 37));
            }
            return;
        }// end function

        private function handleSoulPanelClose(param1)
        {
            this.unloadSoul();
            return;
        }// end function

        private function unloadSoul()
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this.soulPets.length)
            {
                
                if (this.soulPets[_loc_1].item != null)
                {
                    _loc_2 = this.soulPets[_loc_1].item._drawer[this.soulPets[_loc_1].item._position];
                    _loc_2.unlock();
                    this.soulPets[_loc_1].item = null;
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function handleReloadSoul(param1 = null)
        {
            this.loadSoul(this._orangeCB.selected, this._purpleCB.selected);
            return;
        }// end function

        private function loadSoul(param1:Boolean = false, param2:Boolean = false)
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            this.unloadSoul();
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < Config.ui._charUI._itemArray.length)
            {
                
                if (Config.ui._charUI._itemArray[_loc_4] != null)
                {
                    _loc_5 = Config.ui._charUI._itemArray[_loc_4];
                    if (_loc_5._itemData.type == 10 && _loc_5._itemData.subType == 12)
                    {
                        if (_loc_5 != this.petItem)
                        {
                            if (_loc_5._itemData.nameColor == 3 && !param1)
                            {
                            }
                            else if (_loc_5._itemData.nameColor == 2 && !param2)
                            {
                            }
                            else
                            {
                                this.soulPets[_loc_3].item = _loc_5;
                                _loc_6 = _loc_5._drawer[_loc_5._position];
                                _loc_6.lock();
                                _loc_3 = _loc_3 + 1;
                                if (_loc_3 >= 35)
                                {
                                    break;
                                }
                            }
                        }
                    }
                }
                _loc_4 = _loc_4 + 1;
            }
            this.countSoulAll();
            return;
        }// end function

        private function countSoulAll()
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this.soulPets.length)
            {
                
                if (this.soulPets[_loc_2].item != null)
                {
                    _loc_1 = _loc_1 + this.soulPets[_loc_2].item._petObj.soulAllValue;
                }
                _loc_2 = _loc_2 + 1;
            }
            this.soulValueText.text = "" + _loc_1;
            return;
        }// end function

        private function selectWash(event:MouseEvent, param2:int) : void
        {
            this.washType = param2;
            this.washmaxNum = this.petItem._petObj.baseProArr[(this.washType - 1)].qual;
            this.refreshWash();
            return;
        }// end function

        public function refreshWash(param1:Boolean = true) : void
        {
            var _loc_2:* = 140;
            var _loc_3:* = 851000;
            var _loc_4:* = 491000;
            if (int(Config._itemMap[this.petItem._data.id].nameColor) == 1)
            {
                _loc_2 = 140;
                _loc_3 = 851000;
                _loc_4 = 491000;
            }
            else if (int(Config._itemMap[this.petItem._data.id].nameColor) == 2)
            {
                _loc_2 = 170;
                _loc_3 = 851003;
                _loc_4 = 491003;
            }
            else if (int(Config._itemMap[this.petItem._data.id].nameColor) == 3)
            {
                _loc_2 = 200;
                _loc_3 = 851004;
                _loc_4 = 491004;
            }
            this.hpWashBar.maximum = _loc_2;
            this.hpWashBar.value = this.petItem._petObj.baseProArr[2].qual;
            this.hpWashBarLabel.text = this.hpBar.value + " / " + this.hpBar.maximum;
            this.hpWashBarLabel.x = this.hpWashBar.x + (this.hpWashBar.width - this.hpWashBarLabel.width) / 2;
            this.mpWashBar.maximum = _loc_2;
            this.mpWashBar.value = this.petItem._petObj.baseProArr[3].qual;
            this.mpWashBarLabel.text = this.mpWashBar.value + " / " + this.mpWashBar.maximum;
            this.mpWashBarLabel.x = this.mpWashBar.x + (this.mpWashBar.width - this.mpWashBarLabel.width) / 2;
            this.atkWashBar.maximum = _loc_2;
            this.atkWashBar.value = this.petItem._petObj.baseProArr[0].qual;
            this.atkWashBarLabel.text = this.atkWashBar.value + " / " + this.atkWashBar.maximum;
            this.atkWashBarLabel.x = this.atkWashBar.x + (this.atkWashBar.width - this.atkWashBarLabel.width) / 2;
            this.defWashBar.maximum = _loc_2;
            this.defWashBar.value = this.petItem._petObj.baseProArr[1].qual;
            this.defWashBarLabel.text = this.defWashBar.value + " / " + this.defWashBar.maximum;
            this.defWashBarLabel.x = this.defWashBar.x + (this.defWashBar.width - this.defWashBarLabel.width) / 2;
            if (this.washType == 1)
            {
                this.typeRbc.selected = true;
            }
            else if (this.washType == 2)
            {
                this.typeRbd.selected = true;
            }
            else if (this.washType == 3)
            {
                this.typeRba.selected = true;
            }
            else if (this.washType == 4)
            {
                this.typeRbb.selected = true;
            }
            if (this.washType == 0)
            {
                return;
            }
            var _loc_5:* = [Config.language("petPanel", 43), Config.language("petPanel", 44), Config.language("petPanel", 45), Config.language("petPanel", 46)];
            var _loc_6:* = ["80－140", "90－170", "100－200"];
            var _loc_7:* = _loc_5[(this.washType - 1)] + Config.language("petPanel", 47) + this.petItem._petObj.baseProArr[(this.washType - 1)].qual;
            this.washtexta.text = _loc_7;
            this.washtextb.text = Config.language("petPanel", 127) + _loc_5[(this.washType - 1)] + " " + this.petItem._petObj.baseProArr[(this.washType - 1)].allproValue;
            this.washtextc.text = _loc_5[(this.washType - 1)] + Config.language("petPanel", 49) + this.petItem._petObj.baseProArr[(this.washType - 1)].washNum;
            this.washbtn.enabled = true;
            var _loc_8:* = Item.newItem(Config._itemMap[_loc_3], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
            Item.newItem(Config._itemMap[_loc_3], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0).display();
            var _loc_9:* = Config.ui._charUI.getItemAmount(_loc_3) + Config.ui._charUI.getItemAmount(_loc_4);
            var _loc_10:* = 1;
            _loc_8.numstr = _loc_9 + "/" + _loc_10;
            if (_loc_9 >= _loc_10)
            {
                _loc_8.numstrcolor = 2092116;
                this.washcl.visible = false;
            }
            else
            {
                _loc_8.numstrcolor = 16777215;
                this.washcl.visible = true;
            }
            if (this.washIcon.item != null)
            {
                this.washIcon.item.destroy();
            }
            this.washIcon.item = _loc_8;
            return;
        }// end function

        private function setBtnEnable(param1) : void
        {
            this.washbtn.enabled = true;
            return;
        }// end function

        public function checkPick() : void
        {
            if (Config.ui._bagUI.bagfull())
            {
                Config.message(Config.language("petPanel", 52));
                return;
            }
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_PET_CATCH);
            _loc_1.add16(this.pickItemPosition);
            ClientSocket.send(_loc_1);
            Skill.selectedSkill = null;
            return;
        }// end function

        public function get pickItemPosition() : int
        {
            return this._pickItemPosition;
        }// end function

        public function set pickItemPosition(param1:int) : void
        {
            this._pickItemPosition = param1;
            return;
        }// end function

        private function handleSlotUp(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (Holder.item != null)
            {
                this.clickSlot(_loc_2);
            }
            return;
        }// end function

        private function handleSlotClick(param1)
        {
            var _loc_2:* = param1.currentTarget;
            this.clickSlot(_loc_2);
            return;
        }// end function

        private function clickSlot(param1:CloneSlot)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (Holder.item == null)
            {
                if (param1.item != null)
                {
                    _loc_3 = param1.item._drawer[param1.item._position];
                    _loc_3.unlock();
                    param1.item = null;
                    this.soulValueText.text = "0";
                }
            }
            else if (Holder.item._drawer == Config.ui._charUI._slotArray)
            {
                if (this.petItem == null)
                {
                    Config.message(Config.language("petPanel", 53));
                    return;
                }
                if (!(Holder.item._itemData.type == 10 && Holder.item._itemData.subType == 12))
                {
                    Config.message(Config.language("petPanel", 20));
                    return;
                }
                if (this.petItem._itemData.reqLevel < Holder.item._itemData.reqLevel)
                {
                    Config.message(Config.language("petPanel", 54));
                    return;
                }
                if (this.petItem._position == Holder.item._position)
                {
                    Config.message(Config.language("petPanel", 55));
                    return;
                }
                if (param1.item != null)
                {
                    _loc_3 = param1.item._drawer[param1.item._position];
                    _loc_3.unlock();
                    param1.item = null;
                }
                _loc_3 = Holder.item._drawer[Holder.item._position];
                _loc_3.lock();
                _loc_3.item = Holder.item;
                param1.item = Holder.item;
                Holder.item = null;
                this.soulValueText.text = param1.item._petObj.soulAllValue;
            }
            return;
        }// end function

        private function sendSoulFuc(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            if (this.petItem == null)
            {
                Config.message(Config.language("petPanel", 37));
                return;
            }
            if (this.petItem._petObj.soulLevel >= this.petItem._petObj.soulLevelMax)
            {
                Config.message(Config.language("petPanel", 56));
                return;
            }
            this._doSoul0 = 0;
            this._doSoul1 = 0;
            this._doSoul2 = 0;
            this._only1 = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this.soulPets.length)
            {
                
                if (this.soulPets[_loc_2].item != null)
                {
                    this.doSoul(this.soulPets[_loc_2].item);
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this._only1 > 0)
            {
                AlertUI.alert(Config.language("petPanel", 50), Config.language("petPanel", 173), [Config.language("petPanel", 171), Config.language("petPanel", 162)], [this.sendSoulFucForce, this.sendSoulFucCancel]);
            }
            else if (this._doSoul0 > 0 || this._doSoul2 > 0)
            {
                _loc_3 = Config.language("petPanel", 151);
                _loc_4 = true;
                if (this._doSoul2 > 0)
                {
                    if (_loc_4)
                    {
                        _loc_4 = false;
                    }
                    else
                    {
                        _loc_3 = _loc_3 + Config.language("petPanel", 152);
                    }
                    _loc_3 = _loc_3 + Config.language("petPanel", 172);
                }
                if (this._doSoul0 > 0)
                {
                    if (_loc_4)
                    {
                        _loc_4 = false;
                    }
                    else
                    {
                        _loc_3 = _loc_3 + Config.language("petPanel", 152);
                    }
                    _loc_3 = _loc_3 + Config.language("petPanel", 153);
                }
                _loc_3 = _loc_3 + Config.language("petPanel", 155);
                AlertUI.alert(Config.language("petPanel", 50), _loc_3, [Config.language("petPanel", 22)]);
            }
            return;
        }// end function

        private function sendSoulFucCancel(param1 = null)
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            this._doSoul0 = 0;
            this._doSoul1 = 0;
            this._doSoul2 = 0;
            this._only1 = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this.soulPets.length)
            {
                
                if (this.soulPets[_loc_2].item != null)
                {
                    this.checkSoul(this.soulPets[_loc_2].item);
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this._doSoul0 > 0 || this._doSoul2 > 0)
            {
                _loc_3 = Config.language("petPanel", 151);
                _loc_4 = true;
                if (this._doSoul2 > 0)
                {
                    if (_loc_4)
                    {
                        _loc_4 = false;
                    }
                    else
                    {
                        _loc_3 = _loc_3 + Config.language("petPanel", 152);
                    }
                    _loc_3 = _loc_3 + Config.language("petPanel", 172);
                }
                if (this._doSoul0 > 0)
                {
                    if (_loc_4)
                    {
                        _loc_4 = false;
                    }
                    else
                    {
                        _loc_3 = _loc_3 + Config.language("petPanel", 152);
                    }
                    _loc_3 = _loc_3 + Config.language("petPanel", 153);
                }
                _loc_3 = _loc_3 + Config.language("petPanel", 155);
                AlertUI.alert(Config.language("petPanel", 50), _loc_3, [Config.language("petPanel", 22)]);
            }
            return;
        }// end function

        private function sendSoulFucForce(param1 = null)
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            this._doSoul0 = 0;
            this._doSoul1 = 0;
            this._doSoul2 = 0;
            this._only1 = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this.soulPets.length)
            {
                
                if (this.soulPets[_loc_2].item != null)
                {
                    this.doSoul(this.soulPets[_loc_2].item, true);
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this._only1 > 0)
            {
                AlertUI.alert(Config.language("petPanel", 50), "您的包裹里含有装配了精灵技能卡的精灵，是否需要把它们都进行吸魂？", ["确定", "取消"], [this.sendSoulFucForce]);
            }
            else if (this._doSoul0 > 0 || this._doSoul2 > 0)
            {
                _loc_3 = Config.language("petPanel", 151);
                _loc_4 = true;
                if (this._doSoul2 > 0)
                {
                    if (_loc_4)
                    {
                        _loc_4 = false;
                    }
                    else
                    {
                        _loc_3 = _loc_3 + Config.language("petPanel", 152);
                    }
                    _loc_3 = _loc_3 + Config.language("petPanel", 172);
                }
                if (this._doSoul0 > 0)
                {
                    if (_loc_4)
                    {
                        _loc_4 = false;
                    }
                    else
                    {
                        _loc_3 = _loc_3 + Config.language("petPanel", 152);
                    }
                    _loc_3 = _loc_3 + Config.language("petPanel", 153);
                }
                _loc_3 = _loc_3 + Config.language("petPanel", 155);
                AlertUI.alert(Config.language("petPanel", 50), _loc_3, [Config.language("petPanel", 22)]);
            }
            return;
        }// end function

        private function checkSoul(param1:Item)
        {
            var _loc_2:* = false;
            var _loc_3:* = false;
            var _loc_4:* = false;
            if (param1 == null)
            {
                Config.message(Config.language("petPanel", 20));
                return;
            }
            if (this.petItem._position == param1._position)
            {
                Config.message(Config.language("petPanel", 55));
                return;
            }
            if (this.petItem._itemData.reqLevel < param1._itemData.reqLevel)
            {
                var _loc_7:* = this;
                var _loc_8:* = this._doSoul0 + 1;
                _loc_7._doSoul0 = _loc_8;
                _loc_2 = true;
            }
            var _loc_5:* = false;
            _loc_5 = false;
            var _loc_6:* = 0;
            while (_loc_6 < param1._petObj.addProArr.length)
            {
                
                if (int(param1._petObj.addProArr[_loc_6].id) > 0)
                {
                    _loc_5 = true;
                    break;
                }
                _loc_6 = _loc_6 + 1;
            }
            if (_loc_5)
            {
                var _loc_7:* = this;
                var _loc_8:* = this._doSoul2 + 1;
                _loc_7._doSoul2 = _loc_8;
                _loc_4 = true;
            }
            return;
        }// end function

        private function doSoul(param1:Item, param2:Boolean = false)
        {
            var _loc_8:* = 0;
            var _loc_3:* = false;
            var _loc_4:* = false;
            var _loc_5:* = false;
            if (param1 == null)
            {
                Config.message(Config.language("petPanel", 20));
                return;
            }
            if (this.petItem._position == param1._position)
            {
                Config.message(Config.language("petPanel", 55));
                return;
            }
            if (this.petItem._itemData.reqLevel < param1._itemData.reqLevel)
            {
                var _loc_9:* = this;
                var _loc_10:* = this._doSoul0 + 1;
                _loc_9._doSoul0 = _loc_10;
                _loc_3 = true;
            }
            var _loc_6:* = false;
            if (!param2)
            {
                _loc_6 = false;
                _loc_8 = 0;
                while (_loc_8 < param1._petObj.skillArr.length)
                {
                    
                    if (param1._petObj.skillArr[_loc_8].skillId > 0)
                    {
                        _loc_6 = true;
                        break;
                    }
                    _loc_8 = _loc_8 + 1;
                }
                if (_loc_6)
                {
                    var _loc_9:* = this;
                    var _loc_10:* = this._doSoul1 + 1;
                    _loc_9._doSoul1 = _loc_10;
                    _loc_4 = true;
                }
            }
            _loc_6 = false;
            var _loc_7:* = 0;
            while (_loc_7 < param1._petObj.addProArr.length)
            {
                
                if (int(param1._petObj.addProArr[_loc_7].id) > 0)
                {
                    _loc_6 = true;
                    break;
                }
                _loc_7 = _loc_7 + 1;
            }
            if (_loc_6)
            {
                var _loc_9:* = this;
                var _loc_10:* = this._doSoul2 + 1;
                _loc_9._doSoul2 = _loc_10;
                _loc_5 = true;
            }
            if (_loc_4 && !_loc_3 && !_loc_5)
            {
                var _loc_9:* = this;
                var _loc_10:* = this._only1 + 1;
                _loc_9._only1 = _loc_10;
            }
            if ((!_loc_4 || param2) && !_loc_3 && !_loc_5)
            {
                this.sendCheck(param1);
            }
            return;
        }// end function

        private function sendCheck(param1:Item) : void
        {
            if (param1 == null)
            {
                return;
            }
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_PET_FIXSOUL);
            _loc_2.add16(param1._position);
            ClientSocket.send(_loc_2);
            this.soulValueText.text = "0";
            return;
        }// end function

        private function checkWashSend(event:MouseEvent) : void
        {
            var _loc_2:* = undefined;
            if (this.petItem != null)
            {
                if (this.washType == 0)
                {
                    Config.message(Config.language("petPanel", 24));
                }
                else
                {
                    if (int(Config._itemMap[this.petItem._data.id].nameColor) == 1)
                    {
                        if (this.petItem._petObj.baseProArr[(this.washType - 1)].qual == 140)
                        {
                            Config.message(Config.language("petPanel", 59));
                            return;
                        }
                    }
                    else if (int(Config._itemMap[this.petItem._data.id].nameColor) == 2)
                    {
                        if (this.petItem._petObj.baseProArr[(this.washType - 1)].qual == 170)
                        {
                            Config.message(Config.language("petPanel", 59));
                            return;
                        }
                    }
                    else if (int(Config._itemMap[this.petItem._data.id].nameColor) == 3)
                    {
                        if (this.petItem._petObj.baseProArr[(this.washType - 1)].qual == 200)
                        {
                            Config.message(Config.language("petPanel", 59));
                            return;
                        }
                    }
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2G_PET_POLISH);
                    _loc_2.add8(this.washType);
                    ClientSocket.send(_loc_2);
                    this.washmaxNum = Math.max(this.petItem._petObj.baseProArr[(this.washType - 1)].qual, this.washmaxNum);
                    this.washbtn.enabled = false;
                }
            }
            else
            {
                Config.message(Config.language("petPanel", 35));
            }
            return;
        }// end function

        private function showLearnSkill() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            if (this.petItem == null)
            {
                _loc_2 = 0;
                while (_loc_2 < this._learnSkillList.length)
                {
                    
                    this._learnSkillList[_loc_2].id = 0;
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                _loc_2 = 0;
                while (_loc_2 < this._learnSkillList.length)
                {
                    
                    this._learnSkillList[_loc_2].id = 0;
                    _loc_2 = _loc_2 + 1;
                }
                _loc_3 = 0;
                while (_loc_3 < this.petItem._petObj.addProArr.length)
                {
                    
                    _loc_4 = this.petItem._petObj.addProArr[_loc_3];
                    for (_loc_5 in _loc_4)
                    {
                        
                        this._learnSkillList[int((this.petItem._petObj.addProArr[_loc_3].position - 1))][_loc_5] = _loc_4[_loc_5];
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            var _loc_1:* = 0;
            while (_loc_1 < this._learnSkillList.length)
            {
                
                this.updateLearnSkill(this._learnSkillList[_loc_1]);
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function updateLearnSkill(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this.removeAllChildren(param1.contain);
            param1.contain.graphics.clear();
            param1.radio = new RadioButton(param1.contain, 0, 5, "", false, Config.create(this.handleSkillClick, param1));
            param1.radio.group = "petradio";
            param1.radio.color = Style.WINDOW_FONT;
            if (this.radioFlag > 0)
            {
                if (param1.position == this.radioFlag)
                {
                    this.handleSkillClick(null, param1);
                }
            }
            else if (param1.position == 1)
            {
                this.handleSkillClick(null, param1);
            }
            if (param1.id == 0)
            {
                param1.contain.graphics.beginFill(8089425);
                param1.contain.graphics.drawRect(15, 0, 200, 20);
                param1.contain.graphics.endFill();
                param1.skillText = new Label(param1.contain, 25, 0, Config.language("petPanel", 60) + param1.position);
                param1.skillText.textColor = 16762926;
            }
            else
            {
                param1.contain.graphics.beginFill(5458223);
                param1.contain.graphics.drawRect(15, 0, 200, 20);
                param1.contain.graphics.endFill();
                _loc_2 = Config._replace1;
                param1.skillText = new Label(param1.contain, 25, 0, Config.language("petPanel", 61, param1.level, String(Config._itemPropMap[param1.id].prop).replace(_loc_2, param1.value)));
                param1.skillText.textColor = 16762926;
                _loc_3 = String(Config._itemPropMap[param1.id].prop).replace(_loc_2, param1.value);
                _loc_3 = Config._itemPropMap[param1.id].name + "\n" + Config.language("petPanel", 62, Config._itemPropMap[param1.id].name, param1.level, _loc_3);
                if (param1.level < 100)
                {
                    _loc_3 = _loc_3 + ("\n" + Config.language("petPanel", 63, int((param1.level + 1))));
                    _loc_3 = _loc_3 + ("\n" + Config.language("petPanel", 64, String(Config._itemPropMap[param1.id].prop).replace(_loc_2, int(Number(Config._petGift[(param1.level + 1)]["m" + param1.id]) + 0.5))));
                }
                param1.skillText.tip = _loc_3;
                param1.contain.addChild(param1.hammer);
            }
            return;
        }// end function

        private function checkLearn(event:MouseEvent) : void
        {
            if (this.radioFlag > 0)
            {
                if (this._learnSkillList[(this.radioFlag - 1)].id == 0)
                {
                    this.petGrowFuc(null, this.radioFlag, 0);
                }
                else
                {
                    this.petGrowFuc(null, this.radioFlag, 1);
                }
            }
            else
            {
                Config.message(Config.language("petPanel", 65));
            }
            return;
        }// end function

        private function learnOver(event:MouseEvent) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._learnSkillList[(this.radioFlag - 1)].id == 0)
            {
                _loc_2 = event.currentTarget;
                _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(Config.language("petPanel", 66), new Rectangle(_loc_3.x, _loc_3.y, 50, 20), true, 0, 220);
            }
            else if (this._learnSkillList[(this.radioFlag - 1)].level < 100)
            {
                _loc_4 = Config._replace1;
                _loc_2 = event.currentTarget;
                _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                if (this.petItem._itemData.nameColor == 3 && int(this._learnSkillList[(this.radioFlag - 1)].level) == int(this.petItem._itemData.reqLevel + 10))
                {
                    Holder.showInfo(Config.language("petPanel", 175), new Rectangle(_loc_3.x, _loc_3.y, 50, 20), true, 0, 220);
                }
                else if (this.petItem._itemData.nameColor != 3 && int(this._learnSkillList[(this.radioFlag - 1)].level) == int(this.petItem._itemData.reqLevel))
                {
                    Holder.showInfo(Config.language("petPanel", 175), new Rectangle(_loc_3.x, _loc_3.y, 50, 20), true, 0, 220);
                }
                else
                {
                    Holder.showInfo(Config.language("petPanel", 67, int((this._learnSkillList[(this.radioFlag - 1)].level + 1)), (this._learnSkillList[(this.radioFlag - 1)].level + 1), String(Config._itemPropMap[this._learnSkillList[(this.radioFlag - 1)].id].prop).replace(_loc_4, int(Number(Config._petGift[(this._learnSkillList[(this.radioFlag - 1)].level + 1)]["m" + this._learnSkillList[(this.radioFlag - 1)].id]) + 0.5))), new Rectangle(_loc_3.x, _loc_3.y, 50, 20), true, 0, 220);
                }
            }
            return;
        }// end function

        private function checkOut(event:MouseEvent) : void
        {
            if (this.radioFlag > 0)
            {
                if (this._learnSkillList[(this.radioFlag - 1)].id == 0)
                {
                    Config.message(Config.language("petPanel", 70));
                }
                else
                {
                    this.petGrowFuc(null, this.radioFlag, 3, Config._itemPropMap[this._learnSkillList[(this.radioFlag - 1)].id].name);
                }
            }
            else
            {
                Config.message(Config.language("petPanel", 71));
            }
            return;
        }// end function

        private function petGrowFuc(event:MouseEvent, param2:int, param3:int, param4:String = "") : void
        {
            switch(param3)
            {
                case 0:
                case 1:
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                case 3:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param3 == 0)
            {
            }
            else if (param3 == 1)
            {
            }
            else if (param3 == 2)
            {
            }
            else if (param3 == 3)
            {
            }
            return;
        }// end function

        private function handleSkillClick(event:MouseEvent, param2:Object) : void
        {
            param2.radio.selected = true;
            this.radioFlag = param2.position;
            if (param2.id == 0)
            {
                this.updateBtn.textColor = Style.GOLD_FONT;
                this.updateBtn.label = Config.language("petPanel", 78);
                this.upTipLabel.text = Config.language("petPanel", 79);
                this.getoutBtn.visible = false;
            }
            else
            {
                this.updateBtn.label = Config.language("petPanel", 80);
                trace(this.petItem._itemData.reqLevel, this.petItem._itemData.nameColor);
                if (this.petItem._itemData.nameColor == 3 && int(param2.level) == int(this.petItem._itemData.reqLevel + 10))
                {
                    this.updateBtn.textColor = Style.WINDOW_FONT_DISABLE;
                }
                else if (this.petItem._itemData.nameColor != 3 && int(param2.level) == int(this.petItem._itemData.reqLevel))
                {
                    this.updateBtn.textColor = Style.WINDOW_FONT_DISABLE;
                }
                else
                {
                    this.updateBtn.textColor = Style.GOLD_FONT;
                }
                this.upTipLabel.text = Config.language("petPanel", 81) + int((param2.level + 1)) + Config.language("petPanel", 82);
                this.getoutBtn.visible = true;
            }
            return;
        }// end function

        private function handleSkillOver(event:MouseEvent, param2:Object) : void
        {
            param2.contain.graphics.clear();
            param2.contain.graphics.beginFill(5520135);
            param2.contain.graphics.drawRect(15, 0, 200, 20);
            param2.contain.graphics.endFill();
            return;
        }// end function

        private function handleSkillOut(event:MouseEvent, param2:Object) : void
        {
            param2.contain.graphics.clear();
            if (param2.id == 0)
            {
                param2.contain.graphics.clear();
                param2.contain.graphics.beginFill(8089425);
                param2.contain.graphics.drawRect(15, 0, 200, 20);
                param2.contain.graphics.endFill();
            }
            else
            {
                param2.contain.graphics.clear();
                param2.contain.graphics.beginFill(5458223);
                param2.contain.graphics.drawRect(15, 0, 200, 20);
                param2.contain.graphics.endFill();
            }
            return;
        }// end function

        private function checkPetGrow(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_PET_GROW);
            _loc_2.add8(param1.site);
            _loc_2.add8(param1.num);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function checkPetGrowGet(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_PET_EXTRACT);
            _loc_2.add8(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function removeAllChildren(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        private function feedFuc(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (this.petItem != null)
            {
                _loc_2 = 0;
                _loc_3 = 0;
                while (_loc_3 < this.slotarr.length)
                {
                    
                    if (this.slotarr[_loc_3].item != null)
                    {
                        _loc_2++;
                    }
                    _loc_3 = _loc_3 + 1;
                }
                if (_loc_2 > 0)
                {
                    _loc_4 = new DataSet();
                    _loc_4.addHead(CONST_ENUM.C2G_PET_FEEDING);
                    _loc_4.add8(_loc_2);
                    _loc_5 = 0;
                    while (_loc_5 < this.slotarr.length)
                    {
                        
                        if (this.slotarr[_loc_5].item != null)
                        {
                            _loc_4.add16(this.slotarr[_loc_5].item._position);
                        }
                        _loc_5 = _loc_5 + 1;
                    }
                    ClientSocket.send(_loc_4);
                }
                else
                {
                    Config.message(Config.language("petPanel", 83));
                }
            }
            else
            {
                Config.message(Config.language("petPanel", 36));
            }
            return;
        }// end function

        private function showSkill() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = undefined;
            if (this.petItem == null)
            {
                _loc_1 = 0;
                while (_loc_1 < this._skillList.length)
                {
                    
                    this._skillList[_loc_1].lock = 0;
                    this._skillList[_loc_1].skillId = 0;
                    this.updateSkill(this._skillList[_loc_1]);
                    _loc_1 = _loc_1 + 1;
                }
            }
            else
            {
                _loc_1 = 0;
                while (_loc_1 < this.petItem._petObj.skillArr.length)
                {
                    
                    for (_loc_2 in this.petItem._petObj.skillArr[_loc_1])
                    {
                        
                        this._skillList[_loc_1][_loc_2] = this.petItem._petObj.skillArr[_loc_1][_loc_2];
                    }
                    this.updateSkill(this._skillList[_loc_1]);
                    _loc_1 = _loc_1 + 1;
                }
            }
            return;
        }// end function

        private function updateSkill(param1:Object) : void
        {
            if (param1.lock == 1)
            {
                param1.skillClone.bg = Config.findUI("charui")["icon100"];
                if (param1.skillId == 0)
                {
                    param1.skillClone.skill = null;
                    param1.unfit.text = Config.language("petPanel", 84);
                }
                else
                {
                    param1.skillClone.skill = Skill.getSkill(param1.skillId);
                    this.addChild(param1.unfit);
                    param1.unfit.text = Config.language("petPanel", 19);
                }
            }
            else
            {
                if (param1.unfit.parent != null)
                {
                    param1.unfit.text = Config.language("petPanel", 85);
                }
                param1.skillClone.skill = null;
                param1.skillClone.bg = Config.findUI("charui")["icon101"];
            }
            return;
        }// end function

        private function petChange(event:Event = null) : void
        {
            this.petItem = Config.ui._charUI._slotArray[1013].item;
            if (this.petItem == null)
            {
                if (this.parent != null)
                {
                    this.setNullPet();
                }
                Config.ui._quickUI.closePetSlot();
            }
            else
            {
                if (this.parent != null)
                {
                    this.setPet();
                }
                this.setPetSkill();
                if (this.washPanel.parent != null)
                {
                    this.refreshWash(false);
                }
            }
            return;
        }// end function

        public function setPetSkill() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            this.removeAllChildren(Config.ui._quickUI._pethandLayer);
            if (this.petItem == null)
            {
                return;
            }
            Config.ui._quickUI.openPetSlot();
            if (this.petflag)
            {
                _loc_1 = 0;
                if (Config.ui._quickUI._pethandSlot.skill != null)
                {
                    _loc_1 = Config.ui._quickUI._pethandSlot.skill.cd;
                }
                Skill._petChangeSkill.icon = this.petItem._data.icon;
                Skill._petChangeSkill.name = Config.language("petPanel", 86, this.petItem._data.name);
                Config.ui._quickUI._pethandSlot.skill = new Skill(Skill._petChangeSkill);
                Skill.selectedSkill = null;
                if (_loc_1 > 0)
                {
                    Config.ui._quickUI._pethandSlot.skill.cd = _loc_1;
                }
            }
            else
            {
                Config.ui._quickUI._pethandSlot.skill = new Skill(Skill._petBackSkill);
                while (_loc_2 < this._skillSlotArr.length)
                {
                    
                    if (this._skillSlotArr[_loc_2].parent != null)
                    {
                        this._skillSlotArr[_loc_2].skill = null;
                        this._skillSlotArr[_loc_2].parent.removeChild(this._skillSlotArr[_loc_2]);
                    }
                    _loc_2 = _loc_2 + 1;
                }
                _loc_3 = 0;
                while (_loc_3 < this.petItem._petObj.skillArr.length)
                {
                    
                    if (this.petItem._petObj.skillArr[_loc_3].skillId > 0)
                    {
                        Config.ui._quickUI._pethandLayer.addChild(this._skillSlotArr[_loc_3]);
                        this._skillSlotArr[_loc_3].skill = Skill.getSkill(this.petItem._petObj.skillArr[_loc_3].skillId);
                        this._skillSlotArr[_loc_3].x = (-(_loc_3 + 1)) * 40;
                        this._skillSlotArr[_loc_3].skill.level = Config._skillMap[this.petItem._petObj.skillArr[_loc_3].skillId].level;
                        this._skillSlotArr[_loc_3].skill.cdMax = int(Config._skillMap[this.petItem._petObj.skillArr[_loc_3].skillId].coolDown);
                        this._skillSlotArr[_loc_3].skill.cd = Skill.getSkill(this.petItem._petObj.skillArr[_loc_3].skillId).cd;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            return;
        }// end function

        private function setNullPet() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            this.radioFlag = 0;
            this.petIcon.item = null;
            this.levelMax.text = Config.language("petPanel", 87);
            this.nameText.text = "<b>" + Config.language("petPanel", 88) + "<b>";
            if (this.currentPetSlot != null)
            {
                this.currentPetSlot.item = null;
                this.currentPetName.text = this.nameText.text;
            }
            this.levelText.text = "";
            this.soulBar.value = 0;
            this.soulBar.maximum = 0;
            this.soulBarLabel.text = this.soulBar.value + " / " + this.soulBar.maximum;
            this.soulBarLabel.x = this.soulBar.x + (this.soulBar.width - this.soulBarLabel.width) / 2;
            this.hpText.text = Config.language("petPanel", 89);
            this.mpText.text = Config.language("petPanel", 90);
            this.atkText.text = Config.language("petPanel", 91);
            this.defText.text = Config.language("petPanel", 92);
            this.giftText.text = "<b>" + Config.language("petPanel", 82);
            this.growBar.value = 0;
            this.growBar.maximum = 10000;
            this.growBarLabel.text = this.growBar.value + " / " + this.growBar.maximum;
            this.growBarLabel.x = this.growBar.x + (this.growBar.width - this.growBarLabel.width) / 2;
            _loc_1 = 0;
            while (_loc_1 < this.soulPets.length)
            {
                
                if (this.soulPets[_loc_1].item != null)
                {
                    _loc_2 = this.soulPets[_loc_1].item._drawer[this.soulPets[_loc_1].item._position];
                    _loc_2.unlock();
                    this.soulPets[_loc_1].item = null;
                }
                _loc_1 = _loc_1 + 1;
            }
            if (this.soulValueText != null)
            {
                this.soulValueText.text = "0";
            }
            this.showLearnSkill();
            this.showSkill();
            if (this.soulPanel != null)
            {
                if (this.soulPanel.parent != null)
                {
                    this.soulPanel.close();
                }
            }
            if (this.washPanel != null)
            {
                if (this.washPanel.parent != null)
                {
                    this.washPanel.close();
                }
            }
            if (this.foodPanel != null)
            {
                if (this.foodPanel.parent != null)
                {
                    this.foodPanel.close();
                    _loc_1 = 0;
                    while (_loc_1 < this.slotarr.length)
                    {
                        
                        if (this.slotarr[_loc_1].item != null)
                        {
                            _loc_2 = this.slotarr[_loc_1].item._drawer[this.slotarr[_loc_1].item._position];
                            _loc_2.unlock();
                            this.slotarr[_loc_1].item = null;
                        }
                        _loc_1 = _loc_1 + 1;
                    }
                }
            }
            this.close();
            return;
        }// end function

        private function setPet() : void
        {
            var _loc_7:* = null;
            if (this.noPetPanel.parent != null)
            {
                this.noPetPanel.close();
                this.open();
            }
            this.petIcon.item = this.petItem;
            this.levelMax.text = "<font color=\'" + Style.FONT_Red + "\'>" + Config.language("petPanel", 93, this.petItem._petObj.soulLevelMax) + "</font>";
            this.nameText.text = "<b>" + Config._itemMap[this.petItem._data.id].name + "<b>" + "<font color=\'" + Style.FONT_Green + "\'> " + Config.language("petPanel", 94) + " </font>";
            this.currentPetSlot.item = this.petItem;
            this.currentPetName.text = this.nameText.text;
            this.levelText.text = this.petItem._petObj.soulLevel;
            this.soulBar.maximum = this.petItem._petObj.soulValueMax;
            this.soulBar.value = this.petItem._petObj.soulValue;
            this.soulBarLabel.text = this.soulBar.value + " / " + this.soulBar.maximum;
            this.soulBarLabel.x = this.soulBar.x + (this.soulBar.width - this.soulBarLabel.width) / 2;
            if (this.petItem._petObj.soulLevel >= this.petItem._petObj.soulLevelMax)
            {
                this.soulBarLabel.text = Config.language("petPanel", 95);
                this.soulBar.value = this.petItem._petObj.soulValueMax;
            }
            var _loc_1:* = 0;
            while (_loc_1 < this.petItem._petObj.addProArr.length)
            {
                
                _loc_7 = this.petItem._petObj.addProArr[_loc_1];
                if (int(_loc_7.id) == 130)
                {
                    this.petItem._petObj.baseProArr[0].allproValue = _loc_7.value + this.petItem._petObj.baseProArr[0].proValue;
                }
                if (int(_loc_7.id) == 131)
                {
                    this.petItem._petObj.baseProArr[1].allproValue = _loc_7.value + this.petItem._petObj.baseProArr[1].proValue;
                }
                if (int(_loc_7.id) == 1)
                {
                    this.petItem._petObj.baseProArr[2].allproValue = _loc_7.value + this.petItem._petObj.baseProArr[2].proValue;
                }
                if (int(_loc_7.id) == 2)
                {
                    this.petItem._petObj.baseProArr[3].allproValue = _loc_7.value + this.petItem._petObj.baseProArr[3].proValue;
                }
                _loc_1 = _loc_1 + 1;
            }
            this.hpText.text = Config.language("petPanel", 96, int(this.petItem._petObj.baseProArr[2].allValue));
            this.mpText.text = Config.language("petPanel", 97, int(this.petItem._petObj.baseProArr[3].allValue));
            this.atkText.text = Config.language("petPanel", 98, int(this.petItem._petObj.baseProArr[0].allValue));
            this.defText.text = Config.language("petPanel", 99, int(this.petItem._petObj.baseProArr[1].allValue));
            this.bhpText.text = Config.language("petPanel", 100, int(this.petItem._petObj.baseProArr[2].baseValue));
            this.bmpText.text = Config.language("petPanel", 101, int(this.petItem._petObj.baseProArr[3].baseValue));
            this.batkText.text = Config.language("petPanel", 102, int(this.petItem._petObj.baseProArr[0].baseValue));
            this.bdefText.text = Config.language("petPanel", 103, int(this.petItem._petObj.baseProArr[1].baseValue));
            var _loc_2:* = 140;
            if (int(Config._itemMap[this.petItem._data.id].nameColor) == 1)
            {
                _loc_2 = 140;
            }
            else if (int(Config._itemMap[this.petItem._data.id].nameColor) == 2)
            {
                _loc_2 = 170;
            }
            else if (int(Config._itemMap[this.petItem._data.id].nameColor) == 3)
            {
                _loc_2 = 200;
            }
            this.hpBar.maximum = _loc_2;
            this.hpBar.value = this.petItem._petObj.baseProArr[2].qual;
            this.hpBarLabel.text = this.hpBar.value + " / " + this.hpBar.maximum;
            this.hpBarLabel.x = this.hpBar.x + (this.hpBar.width - this.hpBarLabel.width) / 2;
            this.mpBar.maximum = _loc_2;
            this.mpBar.value = this.petItem._petObj.baseProArr[3].qual;
            this.mpBarLabel.text = this.mpBar.value + " / " + this.mpBar.maximum;
            this.mpBarLabel.x = this.mpBar.x + (this.mpBar.width - this.mpBarLabel.width) / 2;
            this.atkBar.maximum = _loc_2;
            this.atkBar.value = this.petItem._petObj.baseProArr[0].qual;
            this.atkBarLabel.text = this.atkBar.value + " / " + this.atkBar.maximum;
            this.atkBarLabel.x = this.atkBar.x + (this.atkBar.width - this.atkBarLabel.width) / 2;
            this.defBar.maximum = _loc_2;
            this.defBar.value = this.petItem._petObj.baseProArr[1].qual;
            this.defBarLabel.text = this.defBar.value + " / " + this.defBar.maximum;
            this.defBarLabel.x = this.defBar.x + (this.defBar.width - this.defBarLabel.width) / 2;
            var _loc_3:* = this.getLenStr(String(this.petItem._petObj.baseProArr[2].baseValue), String(this.petItem._petObj.baseProArr[2].qual / 100), 90);
            _loc_3 = this.getLenStr(_loc_3, String(this.petItem._petObj.baseProArr[2].mixValue), 150);
            _loc_3 = Config.language("petPanel", 104) + "\n" + _loc_3;
            this.hpText.tip = _loc_3;
            var _loc_4:* = this.getLenStr(String(this.petItem._petObj.baseProArr[3].baseValue), String(this.petItem._petObj.baseProArr[3].qual / 100), 90);
            _loc_4 = this.getLenStr(_loc_4, String(this.petItem._petObj.baseProArr[3].mixValue), 150);
            _loc_4 = Config.language("petPanel", 105) + "\n" + _loc_4;
            this.mpText.tip = _loc_4;
            var _loc_5:* = this.getLenStr(String(this.petItem._petObj.baseProArr[0].baseValue), String(this.petItem._petObj.baseProArr[0].qual / 100), 90);
            _loc_5 = this.getLenStr(_loc_5, String(this.petItem._petObj.baseProArr[0].mixValue), 150);
            _loc_5 = Config.language("petPanel", 106) + "\n" + _loc_5;
            this.atkText.tip = _loc_5;
            var _loc_6:* = this.getLenStr(String(this.petItem._petObj.baseProArr[1].baseValue), String(Number(this.petItem._petObj.baseProArr[1].qual / 100)), 90);
            _loc_6 = this.getLenStr(_loc_6, String(this.petItem._petObj.baseProArr[1].mixValue), 150);
            _loc_6 = Config.language("petPanel", 107) + "\n" + _loc_6;
            this.defText.tip = _loc_6;
            this.giftText.text = "<b>" + Config.language("petPanel", 108) + "</b>" + this.petItem._petObj.giftValue;
            this.growBar.maximum = 10000;
            this.growBar.value = this.petItem._petObj.growValue;
            this.growBarLabel.text = this.growBar.value + " / " + this.growBar.maximum;
            this.growBarLabel.x = this.growBar.x + (this.growBar.width - this.growBarLabel.width) / 2;
            this.showLearnSkill();
            this.showSkill();
            this.reMix();
            if (this.petItem._petObj.giftValue > 0)
            {
                GuideUI.testDoId(211, Config.ui._systemUI._petPB, this);
            }
            return;
        }// end function

        private function handleSlotUp2(param1, param2:Object)
        {
            if (Holder.item != null)
            {
                this.clickSlot2(param2);
            }
            return;
        }// end function

        private function handleSlotClick2(param1, param2:Object)
        {
            this.clickSlot2(param2);
            return;
        }// end function

        private function clickSlot2(param1:Object)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = param1.skillClone;
            if (Holder.item == null)
            {
                if (this.petItem == null)
                {
                    Config.message(Config.language("petPanel", 109));
                    return;
                }
                if (param1.lock == 0)
                {
                    AlertUI.alert(Config.language("petPanel", 50), Config.language("petPanel", 110) + "</font>", [Config.language("petPanel", 22), Config.language("petPanel", 58)], [this.checkOpenClone, null], {position:param1.position});
                }
            }
            else if (Holder.item._drawer == Config.ui._charUI._slotArray)
            {
                if (!(Holder.item._itemData.type == 10 && Holder.item._itemData.subType == 4))
                {
                    Config.message(Config.language("petPanel", 112));
                    return;
                }
                if (param1.lock == 0)
                {
                    Config.message(Config.language("petPanel", 113));
                    return;
                }
                if (_loc_2.skill != null)
                {
                    AlertUI.alert(Config.language("petPanel", 50), Config.language("petPanel", 114), [Config.language("petPanel", 22), Config.language("petPanel", 58)], [this.reSkill, null], {position:param1.position, cardpos:Holder.item._position});
                    return;
                }
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_PET_SKILL_LEARN);
                _loc_3.add8(param1.position);
                _loc_3.add16(Holder.item._position);
                ClientSocket.send(_loc_3);
            }
            return;
        }// end function

        private function checkOpenClone(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_PET_SKILLSLOT_UNLOCK);
            _loc_2.add8(param1.position);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function reSkill(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_PET_SKILL_LEARN);
            _loc_2.add8(param1.position);
            _loc_2.add16(param1.cardpos);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function checkCardOut(param1, param2:Object) : void
        {
            if (param2.lock == 0)
            {
                AlertUI.alert(Config.language("petPanel", 50), Config.language("petPanel", 110) + "</font>", [Config.language("petPanel", 22), Config.language("petPanel", 58)], [this.checkOpenClone, null], {position:param2.position});
            }
            else if (param2.skillId == 0)
            {
                Config.ui._bagUI.open();
                Config.ui._bagUI.selectPage(null, 4);
            }
            else
            {
                AlertUI.alert(Config.language("petPanel", 50), Config.language("petPanel", 115) + "</font>", [Config.language("petPanel", 22), Config.language("petPanel", 58)], [this.removeCard, null], {position:param2.position});
            }
            return;
        }// end function

        private function removeCard(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_PET_SKILL_REMOVE);
            _loc_2.add8(param1.position);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.currentTarget;
            var _loc_3:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), false, 0, 200);
            }
            else if (_loc_2.skill != null)
            {
                Holder.showInfo(_loc_2.skill.outputInfoSimple(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), true, 0, 220);
            }
            else if (this.petItem != null)
            {
                if (_loc_2._id < 4)
                {
                    if (this.petItem._petObj.skillArr[_loc_2._id].lock == 0)
                    {
                        Holder.showInfo(Config.language("petPanel", 117), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), true, 0, 220);
                    }
                    else
                    {
                        Holder.showInfo(Config.language("petPanel", 118), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), true, 0, 220);
                    }
                }
                else if (_loc_2._id == 4)
                {
                    Holder.showInfo(Config.language("petPanel", 20), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), true, 0, 220);
                }
                else if (_loc_2._id == 5)
                {
                    _loc_4 = Config.language("petPanel", 131);
                    Holder.showInfo(_loc_4, new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), true, 0, 220);
                }
                else
                {
                    Holder.showInfo(Config.language("petPanel", 83), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), true, 0, 220);
                }
            }
            return;
        }// end function

        private function handleBtnOver(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget;
            var _loc_3:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            Holder.showInfo(Config.language("petPanel", 119), new Rectangle(_loc_3.x, _loc_3.y, 50, 20), true, 0, 220);
            return;
        }// end function

        private function xhBtnOver(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget;
            var _loc_3:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            Holder.showInfo(Config.language("petPanel", 120), new Rectangle(_loc_3.x, _loc_3.y, 50, 20), true, 0, 220);
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        public function petTOPlayer() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_PET_MAKEUP);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        public function palyerBack() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_PET_MAKEUP_OUT);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function backCd(event:SocketEvent) : void
        {
            this._cdtime = event.data.readUnsignedInt() * 1000;
            Config.ui._quickUI._pethandSlot.skill.cdMax = 60000;
            Config.ui._quickUI._pethandSlot.skill.cd = this._cdtime;
            return;
        }// end function

        public function get petflag() : Boolean
        {
            return this._petflag;
        }// end function

        public function set petflag(param1:Boolean) : void
        {
            this._petflag = param1;
            this.setPetSkill();
            return;
        }// end function

        private function backPlayerStatus(event:SocketEvent) : void
        {
            var _loc_2:* = event.data.readByte();
            if (_loc_2 == 1)
            {
                this.petflag = false;
            }
            else if (_loc_2 == 0)
            {
                this.petflag = true;
            }
            return;
        }// end function

        private function handleEntertainClick(param1)
        {
            var _loc_2:* = 0;
            param1.currentTarget.skill.select();
            while (_loc_2 < this._skillSlotArr.length)
            {
                
                this._skillSlotArr[_loc_2].selected = false;
                _loc_2 = _loc_2 + 1;
            }
            if (Skill.selectedSkill != null)
            {
                param1.currentTarget.selected = true;
            }
            return;
        }// end function

        public function setSkillCd(param1:int, param2:int) : void
        {
            var _loc_3:* = 0;
            while (_loc_3 < this._skillSlotArr.length)
            {
                
                if (this._skillSlotArr[_loc_3].skill != null)
                {
                    if (this._skillSlotArr[_loc_3].skill._skillData.id == param1)
                    {
                        this._skillSlotArr[_loc_3].setCd(param2, Skill._cdMaxStack[param1]);
                        this._skillSlotArr[_loc_3].selected = false;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        private function handleSlotUp3(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (Holder.item != null)
            {
                this.clickSlot3(_loc_2);
            }
            return;
        }// end function

        private function handleSlotClick3(param1)
        {
            var _loc_2:* = param1.currentTarget;
            this.clickSlot3(_loc_2);
            return;
        }// end function

        private function clickSlot3(param1:CloneSlot)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (Holder.item == null)
            {
                if (param1.item != null)
                {
                    _loc_3 = param1.item._drawer[param1.item._position];
                    _loc_3.unlock();
                    param1.item = null;
                }
            }
            else if (Holder.item._drawer == Config.ui._charUI._slotArray)
            {
                if (int(Holder.item._itemData.type) == 10 && int(Holder.item._itemData.subType) == 5)
                {
                    if (param1.item != null)
                    {
                        _loc_3 = param1.item._drawer[param1.item._position];
                        _loc_3.unlock();
                        param1.item = null;
                    }
                    _loc_3 = Holder.item._drawer[Holder.item._position];
                    _loc_3.lock();
                    _loc_3.item = Holder.item;
                    param1.item = Holder.item;
                    Holder.item = null;
                }
                else
                {
                    Config.message(Config.language("petPanel", 83));
                }
            }
            return;
        }// end function

        private function openrh(event:TextEvent) : void
        {
            this.rhpanel.switchOpen();
            return;
        }// end function

        private function getLenStr(param1:String, param2:String, param3:int) : String
        {
            var _loc_4:* = "";
            this.templabel1.text = param1;
            this.templabel2.text = param2;
            if (this.templabel1.width + this.templabel2.width <= param3)
            {
                _loc_4 = param1 + this.lenToStr(param3 - this.templabel1.width - this.templabel2.width) + param2;
            }
            else
            {
                _loc_4 = param1 + param2;
            }
            return _loc_4;
        }// end function

        private function lenToStr(param1:int = 0) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = Math.floor(param1 / 3.13);
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2 = _loc_2 + " ";
                _loc_4 = _loc_4 + 1;
            }
            return _loc_2;
        }// end function

        private function backWash(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readByte();
            this.refreshWash();
            var _loc_6:* = [Config.language("petPanel", 43), Config.language("petPanel", 44), Config.language("petPanel", 45), Config.language("petPanel", 46)];
            if (_loc_4 > _loc_3)
            {
                this.washtexta.text = _loc_6[(this.washType - 1)] + Config.language("petPanel", 47) + _loc_3 + "        <font color=\'" + Style.FONT_5_Green + "\'>+ " + (_loc_4 - _loc_3) + "</font>";
                this.washtextb.text = Config.language("petPanel", 127) + _loc_6[(this.washType - 1)] + " " + (this.petItem._petObj.baseProArr[(this.washType - 1)].allproValue - int((_loc_4 - _loc_3) / 100 * this.petItem._petObj.baseProArr[(this.washType - 1)].baseValue)) + "        <font color=\'" + Style.FONT_5_Green + "\'>+ " + int((_loc_4 - _loc_3) / 100 * this.petItem._petObj.baseProArr[(this.washType - 1)].baseValue) + "</font>";
                this.washbtn.enabled = false;
                AlertUI.alert(Config.language("petPanel", 50), Config.language("petPanel", 51, _loc_6[(this.washType - 1)]), [Config.language("petPanel", 22)], [this.setBtnEnable]);
            }
            else if (_loc_4 <= _loc_3)
            {
                this.washtexta.text = _loc_6[(this.washType - 1)] + Config.language("petPanel", 47) + _loc_3 + "        <font color=\'" + Style.FONT_Red + "\'>- " + (_loc_3 - _loc_4) + Config.language("petPanel", 128) + "</font>";
                this.washtextb.text = Config.language("petPanel", 127) + _loc_6[(this.washType - 1)] + " " + this.petItem._petObj.baseProArr[(this.washType - 1)].allproValue;
                this.washbtn.enabled = true;
            }
            return;
        }// end function

        private function openCLpanel(event:TextEvent) : void
        {
            Config.ui._shopmail.openListPanel(8);
            return;
        }// end function

        private function reshowCL(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (this.washPanel.parent != null)
            {
                _loc_2 = 851000;
                _loc_3 = 491000;
                if (int(Config._itemMap[this.petItem._data.id].nameColor) == 1)
                {
                    _loc_2 = 851000;
                    _loc_3 = 491000;
                }
                else if (int(Config._itemMap[this.petItem._data.id].nameColor) == 2)
                {
                    _loc_2 = 851003;
                    _loc_3 = 491003;
                }
                else if (int(Config._itemMap[this.petItem._data.id].nameColor) == 3)
                {
                    _loc_2 = 851004;
                    _loc_3 = 491004;
                }
                _loc_4 = Config.ui._charUI.getItemAmount(_loc_2) + Config.ui._charUI.getItemAmount(_loc_3);
                _loc_5 = 1;
                if (this.washIcon.item != null)
                {
                    if (_loc_4 >= _loc_5)
                    {
                        this.washIcon.item.numstrcolor = 2092116;
                        this.washcl.visible = false;
                    }
                    else
                    {
                        this.washIcon.item.numstrcolor = 16777215;
                        this.washcl.visible = true;
                    }
                    this.washIcon.item.numstr = _loc_4 + "/" + _loc_5;
                }
            }
            return;
        }// end function

        override public function testGuide()
        {
            GuideUI.testDoId(212, this.updateBtn);
            GuideUI.testDoId(216, this._skillList[0].skillClone);
            GuideUI.testDoId(218, this.xhBtn);
            return;
        }// end function

        private function initmixPanel() : void
        {
            var _loc_3:* = new Window(Config.ui._layer1);
            this.mixPanel = new Window(Config.ui._layer1);
            Config.ui._windowStack.push(_loc_3);
            this.mixPanel.title = Config.language("petPanel", 132);
            this.mixPanel.resize(320, 320);
            var _loc_1:* = new Shape();
            this.mixPanel.addChild(_loc_1);
            _loc_1.graphics.beginFill(16777215, 0.4);
            _loc_1.graphics.drawRoundRect(49, 121, 230, 70, 3);
            _loc_1.graphics.drawRoundRect(49, 201, 230, 70, 3);
            _loc_1.graphics.endFill();
            this.mixPetIcon = new CloneSlot(0, 33);
            this.mixPetIcon.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.mixPetIcon.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.mixPanel.addChild(this.mixPetIcon);
            this.mixPetIcon.x = 79;
            this.mixPetIcon.y = 38;
            this.mixslot = new CloneSlot(5, 33);
            this.mixslot.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.mixslot.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.mixslot.addEventListener("sglClick", this.handleSlotClick4);
            this.mixslot.addEventListener("drag", this.handleSlotClick4);
            this.mixslot.addEventListener("up", this.handleSlotUp4);
            this.mixPanel.addChild(this.mixslot);
            this.mixslot.x = 200;
            this.mixslot.y = 38;
            this.mixNameText = Config.getSimpleTextField();
            this.mixNameText.textColor = Style.WINDOW_FONT;
            this.mixPanel.addChild(this.mixNameText);
            this.mixNameText.x = 97;
            this.mixNameText.y = 83;
            var _loc_2:* = new Label(this.mixPanel, 56, 124, Config.language("petPanel", 133));
            this.mixhp = new Label(this.mixPanel, 57, 143 + 3);
            this.mixmp = new Label(this.mixPanel, 57, 163 + 3);
            this.mixatk = new Label(this.mixPanel, 180, 143 + 3);
            this.mixdef = new Label(this.mixPanel, 180, 163 + 3);
            this.mixhp.html = true;
            this.mixmp.html = true;
            this.mixatk.html = true;
            this.mixdef.html = true;
            this.tomixLabel = new Label(this.mixPanel, 57, 204, Config.language("petPanel", 134));
            this.mixhp2 = new Label(this.mixPanel, 57, 223 + 3);
            this.mixmp2 = new Label(this.mixPanel, 57, 243 + 3);
            this.mixatk2 = new Label(this.mixPanel, 180, 223 + 3);
            this.mixdef2 = new Label(this.mixPanel, 180, 243 + 3);
            this.mixhp2.html = true;
            this.mixmp2.html = true;
            this.mixatk2.html = true;
            this.mixdef2.html = true;
            this.tomixName = Config.getSimpleTextField();
            this.tomixName.textColor = Style.WINDOW_FONT;
            this.mixPanel.addChild(this.tomixName);
            this.tomixName.x = 217;
            this.tomixName.y = 83;
            this.mixBtn = new PushButton(this.mixPanel, 136, 285, Config.language("petPanel", 135), this.sendMix);
            this.mixBtn.width = 50;
            this.mixCenter = new PushButton(this.mixPanel, 99, 285, Config.language("petPanel", 136), Config.create(this.sendCenter, 1));
            this.mixCenter.setTable("table18", "table31");
            this.mixCenter.width = 50;
            this.mixCenter.textColor = Style.GOLD_FONT;
            this.mixCenter.overshow = true;
            this.mixCancel = new PushButton(this.mixPanel, 179, 285, Config.language("petPanel", 137), Config.create(this.sendCenter, 0));
            this.mixCancel.setTable("table18", "table31");
            this.mixCancel.width = 50;
            this.mixCancel.textColor = Style.GOLD_FONT;
            this.mixCancel.overshow = true;
            return;
        }// end function

        private function openMixPanel(event:MouseEvent = null) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.petItem != null)
            {
                if (this.soulPanel.parent != null)
                {
                    this.soulPanel.close();
                }
                if (this.foodPanel.parent != null)
                {
                    this.foodPanel.close();
                    _loc_2 = 0;
                    while (_loc_2 < this.slotarr.length)
                    {
                        
                        if (this.slotarr[_loc_2].item != null)
                        {
                            _loc_3 = this.slotarr[_loc_2].item._drawer[this.slotarr[_loc_2].item._position];
                            _loc_3.unlock();
                            this.slotarr[_loc_2].item = null;
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                }
                if (this.washPanel.parent != null)
                {
                    this.washPanel.close();
                }
                this.mixPanel.switchOpen();
                this.mixPanel.x = (Config.ui._width - this.mixPanel.width) / 2;
                this.mixPanel.y = 20;
                this.reMix();
                GuideUI.testDoId(18, this.mixslot);
            }
            else
            {
                Config.message(Config.language("petPanel", 35));
            }
            return;
        }// end function

        private function sendMix(event:MouseEvent) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = 0;
            if (this.mixslot.item != null)
            {
                _loc_2 = false;
                _loc_3 = 0;
                while (_loc_3 < this.mixslot.item._petObj.addProArr.length)
                {
                    
                    if (this.mixslot.item._petObj.addProArr[_loc_3].id > 0)
                    {
                        _loc_2 = true;
                        break;
                    }
                    _loc_3 = _loc_3 + 1;
                }
                if (!_loc_2)
                {
                    this.sendcomp(this.mixslot.item._position);
                    GuideUI.testDoId(28, this.mixCenter);
                }
                else
                {
                    AlertUI.alert(Config.language("petPanel", 169), Config.language("petPanel", 174), [Config.language("petPanel", 171), Config.language("petPanel", 167)], [this.sendcomp], this.mixslot.item._position);
                }
            }
            else
            {
                Config.message(Config.language("petPanel", 138));
            }
            return;
        }// end function

        private function sendcomp(param1:int)
        {
            var _loc_2:* = this.mixslot.releaseParticle(500);
            this.mixPetIcon.receiveParticle(_loc_2);
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_PET_MERGE_REQUEST);
            _loc_3.add16(param1);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function sendCenter(event:MouseEvent, param2:int) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_PET_MERGE_RESPONSE);
            _loc_3.add8(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function handleSlotUp4(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (Holder.item != null)
            {
                this.clickSlot4(_loc_2);
            }
            return;
        }// end function

        private function handleSlotClick4(param1)
        {
            var _loc_2:* = param1.currentTarget;
            this.clickSlot4(_loc_2);
            return;
        }// end function

        private function clickSlot4(param1:CloneSlot)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            Config.stopLoop(this.startMixLoop);
            if (Holder.item == null)
            {
                if (param1.item != null)
                {
                    this.toMixNull();
                }
            }
            else if (Holder.item._drawer == Config.ui._charUI._slotArray)
            {
                if (this.petItem == null)
                {
                    Config.message(Config.language("petPanel", 53));
                    return;
                }
                if (!(Holder.item._itemData.type == 10 && Holder.item._itemData.subType == 12))
                {
                    Config.message(Config.language("petPanel", 20));
                    Config.startLoop(this.startMixLoop);
                    return;
                }
                if (this.petItem._position == Holder.item._position)
                {
                    Config.message(Config.language("petPanel", 55));
                    Config.startLoop(this.startMixLoop);
                    return;
                }
                if (Holder.item._petObj.soulLevel < Holder.item._petObj.soulLevelMax)
                {
                    Config.message(Config.language("petPanel", 139));
                    Config.startLoop(this.startMixLoop);
                    return;
                }
                if (int(Config._itemMap[Holder.item._data.id].nameColor) == 1 || int(Config._itemMap[this.petItem._data.id].nameColor) == 1)
                {
                    Config.message(Config.language("petPanel", 140));
                    Config.startLoop(this.startMixLoop);
                    return;
                }
                if (Holder.item._itemData.reqLevel > this.petItem._itemData.reqLevel)
                {
                    Config.message(Config.language("petPanel", 141));
                    Config.startLoop(this.startMixLoop);
                    return;
                }
                if (param1.item != null)
                {
                    _loc_3 = param1.item._drawer[param1.item._position];
                    _loc_3.unlock();
                    param1.item = null;
                }
                _loc_3 = Holder.item._drawer[Holder.item._position];
                _loc_3.lock();
                _loc_3.item = Holder.item;
                param1.item = Holder.item;
                Holder.item = null;
                this.tomixName.htmlText = "<p align=\'center\'><b><font color=\'" + Style.FONT_Green + "\'>" + Config.language("petPanel", 142) + "</font>\n" + param1.item.name + "</b>Lv:" + param1.item._petObj.soulLevel + "</p>";
                this.tomixLabel.text = Config.language("petPanel", 147);
                this.mixhp2.visible = true;
                this.mixmp2.visible = true;
                this.mixatk2.visible = true;
                this.mixdef2.visible = true;
                this.tomixName.x = 217 - int(this.tomixName.width / 2);
                Config.startLoop(this.startMixLoop);
            }
            return;
        }// end function

        private function startMixLoop(param1) : void
        {
            var _loc_2:* = null;
            if (this.mixslot.item == null)
            {
                this.stopMixLoop();
                return;
            }
            var _loc_3:* = 0;
            var _loc_4:* = this.mixslot.item._itemData.reqLevel + ":" + Config._itemMap[this.mixslot.item._data.id].nameColor;
            var _loc_5:* = String(Config._petCombine[_loc_4].minHP);
            if (String(Config._petCombine[_loc_4].minHP) == "a")
            {
                _loc_5 = this.petItem._petObj.baseProArr[2].mixValue;
            }
            _loc_3 = int(_loc_5) + Math.ceil((int(Config._petCombine[_loc_4].maxHP) - int(_loc_5)) * Math.random());
            if (_loc_3 >= this.petItem._petObj.baseProArr[2].mixValue)
            {
                _loc_2 = Style.FONT_Red;
            }
            else
            {
                _loc_2 = Style.FONT_Green;
            }
            this.mixhp2.text = this.getLenStr(Config.language("petPanel", 143) + "<font color=\'" + _loc_2 + "\'>" + _loc_3 + "</font>", "[" + _loc_5 + "-" + Config._petCombine[_loc_4].maxHP + "]", 110);
            _loc_5 = Config._petCombine[_loc_4].minMP;
            if (_loc_5 == "a")
            {
                _loc_5 = this.petItem._petObj.baseProArr[3].mixValue;
            }
            _loc_3 = int(_loc_5) + Math.ceil((int(Config._petCombine[_loc_4].maxMP) - int(_loc_5)) * Math.random());
            if (_loc_3 >= this.petItem._petObj.baseProArr[3].mixValue)
            {
                _loc_2 = Style.FONT_Red;
            }
            else
            {
                _loc_2 = Style.FONT_Green;
            }
            this.mixmp2.text = this.getLenStr(Config.language("petPanel", 144) + "<font color=\'" + _loc_2 + "\'>" + _loc_3 + "</font>", "[" + _loc_5 + "-" + Config._petCombine[_loc_4].maxMP + "]", 110);
            _loc_5 = Config._petCombine[_loc_4].minAtk;
            if (_loc_5 == "a")
            {
                _loc_5 = this.petItem._petObj.baseProArr[0].mixValue;
            }
            _loc_3 = int(_loc_5) + Math.ceil((int(Config._petCombine[_loc_4].maxAtk) - int(_loc_5)) * Math.random());
            if (_loc_3 >= this.petItem._petObj.baseProArr[0].mixValue)
            {
                _loc_2 = Style.FONT_Red;
            }
            else
            {
                _loc_2 = Style.FONT_Green;
            }
            this.mixatk2.text = this.getLenStr(Config.language("petPanel", 145) + "<font color=\'" + _loc_2 + "\'>" + _loc_3 + "</font>", "[" + _loc_5 + "-" + Config._petCombine[_loc_4].maxAtk + "]", 110);
            _loc_5 = Config._petCombine[_loc_4].minDef;
            if (_loc_5 == "a")
            {
                _loc_5 = this.petItem._petObj.baseProArr[1].mixValue;
            }
            _loc_3 = int(_loc_5) + Math.ceil((int(Config._petCombine[_loc_4].maxDef) - int(_loc_5)) * Math.random());
            if (_loc_3 >= this.petItem._petObj.baseProArr[1].mixValue)
            {
                _loc_2 = Style.FONT_Red;
            }
            else
            {
                _loc_2 = Style.FONT_Green;
            }
            this.mixdef2.text = this.getLenStr(Config.language("petPanel", 146) + "<font color=\'" + _loc_2 + "\'>" + _loc_3 + "</font>", "[" + _loc_5 + "-" + Config._petCombine[_loc_4].maxDef + "]", 110);
            return;
        }// end function

        private function stopMixLoop() : void
        {
            Config.stopLoop(this.startMixLoop);
            return;
        }// end function

        private function toMixNull() : void
        {
            var _loc_1:* = null;
            if (this.mixslot.item != null)
            {
                _loc_1 = this.mixslot.item._drawer[this.mixslot.item._position];
                _loc_1.unlock();
                this.mixslot.item = null;
            }
            this.tomixName.htmlText = "";
            this.tomixLabel.text = Config.language("petPanel", 134);
            this.mixhp2.visible = false;
            this.mixmp2.visible = false;
            this.mixatk2.visible = false;
            this.mixdef2.visible = false;
            this.mixhp2.text = Config.language("petPanel", 143);
            this.mixmp2.text = Config.language("petPanel", 144);
            this.mixatk2.text = Config.language("petPanel", 145);
            this.mixdef2.text = Config.language("petPanel", 146);
            return;
        }// end function

        public function get tempHp() : int
        {
            return this._tempHp;
        }// end function

        public function set tempHp(param1:int) : void
        {
            this._tempHp = param1;
            this.recheckMix();
            return;
        }// end function

        public function get tempMp() : int
        {
            return this._tempMp;
        }// end function

        public function set tempMp(param1:int) : void
        {
            this._tempMp = param1;
            this.recheckMix();
            return;
        }// end function

        public function get tempAtk() : int
        {
            return this._tempAtk;
        }// end function

        public function set tempAtk(param1:int) : void
        {
            this._tempAtk = param1;
            this.recheckMix();
            return;
        }// end function

        public function get tempDef() : int
        {
            return this._tempDef;
        }// end function

        public function set tempDef(param1:int) : void
        {
            this._tempDef = param1;
            this.recheckMix();
            return;
        }// end function

        public function recheckMix() : void
        {
            var _loc_1:* = null;
            if (this.petItem == null)
            {
                return;
            }
            if (this.tempHp != 0 || this.tempMp != 0 || this.tempAtk != 0 || this.tempDef != 0)
            {
                this.mixBtn.visible = false;
                this.mixCenter.visible = true;
                this.mixCancel.visible = true;
                this.tomixLabel.text = Config.language("petPanel", 148);
                if (this.tempHp > this.petItem._petObj.baseProArr[2].mixValue)
                {
                    this.mixhp.text = Config.language("petPanel", 143) + this.petItem._petObj.baseProArr[2].mixValue + "  <font color=\'" + Style.FONT_Red + "\'>(+" + (this.tempHp - this.petItem._petObj.baseProArr[2].mixValue) + ")</font>";
                }
                else if (this.tempHp < this.petItem._petObj.baseProArr[2].mixValue)
                {
                    this.mixhp.text = Config.language("petPanel", 143) + this.petItem._petObj.baseProArr[2].mixValue + "  <font color=\'" + Style.FONT_Green + "\'>(-" + (this.petItem._petObj.baseProArr[2].mixValue - this.tempHp) + ")</font>";
                }
                else
                {
                    this.mixhp.text = Config.language("petPanel", 143) + this.petItem._petObj.baseProArr[2].mixValue;
                }
                this.mixhp2.text = Config.language("petPanel", 143) + _loc_1;
                if (this.tempMp > this.petItem._petObj.baseProArr[3].mixValue)
                {
                    this.mixmp.text = Config.language("petPanel", 144) + this.petItem._petObj.baseProArr[3].mixValue + "<font color=\'" + Style.FONT_Red + "\'>(+" + (this.tempMp - this.petItem._petObj.baseProArr[3].mixValue) + ")</font>";
                }
                else if (this.tempMp < this.petItem._petObj.baseProArr[3].mixValue)
                {
                    this.mixmp.text = Config.language("petPanel", 144) + this.petItem._petObj.baseProArr[3].mixValue + "<font color=\'" + Style.FONT_Green + "\'>(-" + (this.petItem._petObj.baseProArr[3].mixValue - this.tempMp) + ")</font>";
                }
                else
                {
                    this.mixmp.text = Config.language("petPanel", 144) + this.petItem._petObj.baseProArr[3].mixValue;
                }
                if (this.tempAtk > this.petItem._petObj.baseProArr[0].mixValue)
                {
                    this.mixatk.text = Config.language("petPanel", 145) + this.petItem._petObj.baseProArr[0].mixValue + "<font color=\'" + Style.FONT_Red + "\'>(+" + (this.tempAtk - this.petItem._petObj.baseProArr[0].mixValue) + ")</font>";
                }
                else if (this.tempAtk < this.petItem._petObj.baseProArr[0].mixValue)
                {
                    this.mixatk.text = Config.language("petPanel", 145) + this.petItem._petObj.baseProArr[0].mixValue + "<font color=\'" + Style.FONT_Green + "\'>(-" + (this.petItem._petObj.baseProArr[0].mixValue - this.tempAtk) + ")</font>";
                }
                else
                {
                    this.mixatk.text = Config.language("petPanel", 145) + this.petItem._petObj.baseProArr[0].mixValue;
                }
                if (this.tempDef > this.petItem._petObj.baseProArr[1].mixValue)
                {
                    this.mixdef.text = Config.language("petPanel", 146) + this.petItem._petObj.baseProArr[1].mixValue + "<font color=\'" + Style.FONT_Red + "\'>(+" + (this.tempDef - this.petItem._petObj.baseProArr[1].mixValue) + ")</font>";
                }
                else if (this.tempDef < this.petItem._petObj.baseProArr[1].mixValue)
                {
                    this.mixdef.text = Config.language("petPanel", 146) + this.petItem._petObj.baseProArr[1].mixValue + "<font color=\'" + Style.FONT_Green + "\'>(-" + (this.petItem._petObj.baseProArr[1].mixValue - this.tempDef) + ")</font>";
                }
                else
                {
                    this.mixdef.text = Config.language("petPanel", 146) + this.petItem._petObj.baseProArr[1].mixValue;
                }
            }
            else
            {
                this.mixBtn.visible = true;
                this.mixCenter.visible = false;
                this.mixCancel.visible = false;
                this.mixhp.text = Config.language("petPanel", 143) + this.petItem._petObj.baseProArr[2].mixValue;
                this.mixmp.text = Config.language("petPanel", 144) + this.petItem._petObj.baseProArr[3].mixValue;
                this.mixatk.text = Config.language("petPanel", 145) + this.petItem._petObj.baseProArr[0].mixValue;
                this.mixdef.text = Config.language("petPanel", 146) + this.petItem._petObj.baseProArr[1].mixValue;
                this.toMixNull();
            }
            return;
        }// end function

        public function reMix() : void
        {
            this.mixPetIcon.item = this.petItem;
            this.mixNameText.htmlText = "<p align=\'center\'><b><font color=\'" + Style.FONT_Green + "\'> " + Config.language("petPanel", 94) + " </font>\n" + Config._itemMap[this.petItem._data.id].name + "</b>Lv:" + this.petItem._petObj.soulLevel + "</p>";
            this.mixNameText.x = 97 - int(this.mixNameText.width / 2);
            this.mixhp.text = Config.language("petPanel", 143) + this.petItem._petObj.baseProArr[2].mixValue;
            this.mixmp.text = Config.language("petPanel", 144) + this.petItem._petObj.baseProArr[3].mixValue;
            this.mixatk.text = Config.language("petPanel", 145) + this.petItem._petObj.baseProArr[0].mixValue;
            this.mixdef.text = Config.language("petPanel", 146) + this.petItem._petObj.baseProArr[1].mixValue;
            this.toMixNull();
            this.recheckMix();
            return;
        }// end function

        public function backMix() : void
        {
            this.toMixNull();
            this.recheckMix();
            return;
        }// end function

        public function onHammerSave()
        {
            if (this._hammerPanel != null)
            {
                this._hammerPanel.onSave();
            }
            return;
        }// end function

        public function checkHammerSaving()
        {
            if (this._hammerPanel != null && this._hammerPanel._opening)
            {
                return this._hammerPanel.checkSaving();
            }
            return false;
        }// end function

        public function closeHammer()
        {
            if (this._hammerPanel != null)
            {
                return this._hammerPanel.close();
            }
            return;
        }// end function

    }
}

import com.bit101.components.*;

import flash.display.*;

import flash.events.*;

import flash.geom.*;

import flash.text.*;

import flash.utils.*;

import lovefox.component.*;

import lovefox.socket.*;

import lovefox.unit.*;

class HammerPanel extends Window
{
    private var _tf1:TextField;
    private var _tf2:TextField;
    private var _id:int;
    private var _disturbCB:CheckBox;
    private var _disturbCBLayer:Sprite;
    private var _washPB:PushButton;
    private var _savePB:PushButton;
    private var _cancelPB:PushButton;
    private var _hammerAlertID:int = -1;

    function HammerPanel(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
    {
        super(param1, param2, param3);
        title = Config.language("petPanel", 156);
        this.initUI();
        return;
    }// end function

    private function initUI()
    {
        var _loc_2:* = null;
        resize(293, 203);
        var _loc_1:* = new Shape();
        _loc_1.graphics.beginFill(5458223, 1);
        _loc_1.graphics.drawRect(98, 35, 173, 20);
        _loc_1.graphics.drawRect(98, 74, 173, 20);
        addChild(_loc_1);
        _loc_2 = new Label(this, 0, 35, Config.language("petPanel", 157));
        _loc_2.tf.setTextFormat(new TextFormat(null, 12, 16711680, true));
        _loc_2.x = 90 - _loc_2.width;
        _loc_2 = new Label(this, 0, 74, Config.language("petPanel", 158));
        _loc_2.tf.setTextFormat(new TextFormat(null, 12, 16711680, true));
        _loc_2.x = 90 - _loc_2.width;
        this._tf1 = Config.getSimpleTextField();
        this._tf1.x = 100;
        this._tf1.y = 35;
        this._tf1.textColor = 16762926;
        addChild(this._tf1);
        this._tf2 = Config.getSimpleTextField();
        this._tf2.x = 100;
        this._tf2.y = 74;
        this._tf2.textColor = 65280;
        addChild(this._tf2);
        var _loc_3:* = Config.getSimpleTextField();
        _loc_3.htmlText = Config.language("petPanel", 159).replace(/\\\
n""\\n/g, "\n");
        _loc_3.x = 25;
        _loc_3.y = 115;
        addChild(_loc_3);
        this._washPB = new PushButton(this, 0, 163, Config.language("petPanel", 160), this.handleWash);
        this._washPB.x = (_width - this._washPB.width) / 2;
        this._savePB = new PushButton(this, 0, 163, Config.language("petPanel", 161), this.handleSave);
        this._savePB.width = 70;
        this._savePB.x = 60;
        this._savePB.visible = false;
        this._cancelPB = new PushButton(this, 0, 163, Config.language("petPanel", 162), this.handleCancel);
        this._cancelPB.width = 70;
        this._cancelPB.x = 163;
        this._cancelPB.visible = false;
        ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PETPOLISH_RESULT, this.handleWashRcv);
        return;
    }// end function

    private function handleSave(param1)
    {
        var _loc_2:* = new DataSet();
        _loc_2.addHead(CONST_ENUM.C2G_PETPOLISH_SAVE);
        _loc_2.add8(1);
        ClientSocket.send(_loc_2);
        return;
    }// end function

    private function handleCancel(param1)
    {
        var _loc_2:* = new DataSet();
        _loc_2.addHead(CONST_ENUM.C2G_PETPOLISH_SAVE);
        _loc_2.add8(0);
        ClientSocket.send(_loc_2);
        this._tf2.text = "";
        this._washPB.visible = true;
        this._savePB.visible = false;
        this._cancelPB.visible = false;
        return;
    }// end function

    private function handleWashRcv(event:SocketEvent) : void
    {
        var _loc_2:* = event.data;
        var _loc_3:* = _loc_2.readUnsignedShort();
        var _loc_4:* = _loc_2.readUnsignedByte();
        var _loc_5:* = _loc_2.readUnsignedInt();
        var _loc_6:* = Config.language("petPanel", 61, _loc_3, String(Config._itemPropMap[_loc_4].prop).replace(Config._replace1, _loc_5));
        this._tf2.text = _loc_6;
        this._washPB.visible = false;
        this._savePB.visible = true;
        this._cancelPB.visible = true;
        return;
    }// end function

    private function handleWash(param1)
    {
        if (this._disturbCB == null || !this._disturbCB.selected)
        {
            if (this._disturbCB == null)
            {
                this._disturbCBLayer = new Sprite();
                this._disturbCB = new CheckBox(this._disturbCBLayer, 12, 5, Config.language("petPanel", 163));
            }
            this._disturbCB.selected = false;
            AlertUI.alert(Config.language("petPanel", 164), Config.language("petPanel", 165), [Config.language("petPanel", 166), Config.language("petPanel", 167)], [this.doWash], true, false, true, false, this._disturbCBLayer, false, null, null, null, 209);
        }
        else
        {
            this.doWash();
        }
        return;
    }// end function

    private function doWash(param1 = null)
    {
        var _loc_2:* = new DataSet();
        _loc_2.addHead(CONST_ENUM.C2G_PETPOLISH);
        _loc_2.add16(this._id);
        ClientSocket.send(_loc_2);
        return;
    }// end function

    public function resetProp(param1, param2:String)
    {
        this._tf1.text = param2;
        this._tf2.text = "";
        this._id = param1;
        this._washPB.visible = true;
        this._savePB.visible = false;
        this._cancelPB.visible = false;
        return;
    }// end function

    public function onSave()
    {
        Config.message(Config.language("petPanel", 168));
        this._tf1.text = this._tf2.text;
        this._tf2.text = "";
        this._washPB.visible = true;
        this._savePB.visible = false;
        this._cancelPB.visible = false;
        return;
    }// end function

    override protected function handleCloseBtn(param1)
    {
        if (this.checkSaving())
        {
            AlertUI.remove(this._hammerAlertID);
            this._hammerAlertID = AlertUI.alert(Config.language("petPanel", 169), Config.language("petPanel", 170), [Config.language("petPanel", 171), Config.language("petPanel", 167)], [this.confirmClose]);
        }
        else
        {
            close();
        }
        return;
    }// end function

    private function confirmClose(param1)
    {
        close();
        return;
    }// end function

    public function checkSaving()
    {
        return !this._washPB.visible;
    }// end function

}

