package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.gui.*;
    import lovefox.socket.*;
    import lovefox.unit.*;
    import lovefox.util.*;

    public class HeadUI extends Sprite
    {
        private var _bg:GPanel;
        private var _front:GPanel;
        private var _headBmp:Bitmap;
        private var headmc:MouseSprite;
        private var headmask:Sprite;
        private var _hpBar:ProgressBar;
        private var _mpBar:ProgressBar;
        private var _expBar:ProgressBar;
        private var _enBarLayer:Sprite;
        private var _enBar:ProgressBar;
        public var _autoHpBar:ProgressBar;
        public var _autoMpBar:ProgressBar;
        public var _autoHpBarLayer:Sprite;
        public var _autoMpBarLayer:Sprite;
        public var _autoEnBar:ProgressBar;
        private var _hpLb:TextField;
        private var _mpLb:TextField;
        private var _enLb:TextField;
        private var _expLb:TextField;
        private var _nameLB:TextField;
        private var _nameBB:Panel;
        public var _menegyLB:Label;
        public var _menegyLBFilter:GlowFilter;
        public var _menegyLBLoopCount:Object;
        private var _menegy:uint = 0;
        private var _menegyBuff:uint = 0;
        public var _menegyPos:Point;
        public var _unit:Unit;
        private var nametext:Label;
        private var leveltext:Label;
        private var selectarr:int = 0;
        private var severtext:Label;
        private var _vipSpr:Sprite;
        private var bufarr:Array;
        private var buftip:Sprite;
        private var buftimer:Timer;
        private var fcmflag:int = 0;
        private var fnum:int = 0;
        private var fcmtime:Timer;
        private var _mouseOn:Boolean = false;
        private var qiuBufNum:int = 0;
        private var _vipBitmapArr:Array;

        public function HeadUI()
        {
            this._menegyLBFilter = new GlowFilter(Style.WINDOW_FONT, 1, 3, 3, 10, 1);
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_1:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._bg = new GPanel(Config.findUI("headui").bg);
            this._front = new GPanel(Config.findUI("headui").front);
            addChild(this._bg);
            this._front.x = 33;
            this._front.y = 15;
            this._autoHpBarLayer = new Sprite();
            this.addChild(this._autoHpBarLayer);
            this._autoHpBar = new ProgressBar(this._autoHpBarLayer, 232, 21);
            this._autoHpBar.gradientFillDirection = Math.PI;
            this._autoHpBar.roundCorner = 5;
            this._autoHpBar.color = 103481221;
            this._autoHpBar.subColor = 1681495;
            this._autoHpBar.width = 20;
            this._autoHpBar.height = 10;
            this._autoHpBar.bgColor = 5459528;
            this._autoHpBar.addEventListener(MouseEvent.ROLL_OVER, this.handleRollover);
            this._autoHpBar.addEventListener(MouseEvent.ROLL_OUT, this.handleEnRollout);
            this._autoHpBar.addEventListener(MouseEvent.CLICK, this.openAutoDrug);
            this._autoHpBar.maximum = 2;
            this._autoHpBar.value = 2;
            this._autoHpBar.buttonMode = true;
            this._autoMpBarLayer = new Sprite();
            this.addChild(this._autoMpBarLayer);
            this._autoMpBar = new ProgressBar(this._autoMpBarLayer, 230, 39);
            this._autoMpBar.gradientFillDirection = Math.PI;
            this._autoMpBar.roundCorner = 5;
            this._autoMpBar.color = 4972287;
            this._autoMpBar.subColor = 26519;
            this._autoMpBar.width = 20;
            this._autoMpBar.height = 10;
            this._autoMpBar.bgColor = 5459528;
            this._autoMpBar.addEventListener(MouseEvent.ROLL_OVER, this.handleRollover);
            this._autoMpBar.addEventListener(MouseEvent.ROLL_OUT, this.handleEnRollout);
            this._autoMpBar.addEventListener(MouseEvent.CLICK, this.openAutoDrug);
            this._autoMpBar.maximum = 2;
            this._autoMpBar.value = 2;
            this._autoMpBar.buttonMode = true;
            this._autoEnBar = new ProgressBar(this, 194, 58);
            this._autoEnBar.gradientFillDirection = Math.PI;
            this._autoEnBar.roundCorner = 5;
            this._autoEnBar.color = 9844735;
            this._autoEnBar.subColor = 5381537;
            this._autoEnBar.width = 9;
            this._autoEnBar.height = 7;
            this._autoEnBar.bgColor = 5459528;
            this._autoEnBar.addEventListener(MouseEvent.ROLL_OVER, this.handleEnRollover);
            this._autoEnBar.addEventListener(MouseEvent.ROLL_OUT, this.handleEnRollout);
            this._autoEnBar.addEventListener(MouseEvent.CLICK, this.handleEnClick);
            this._autoEnBar.maximum = 2;
            this._autoEnBar.value = 2;
            this._autoEnBar.buttonMode = true;
            this._hpBar = new ProgressBar(this, 113, 21);
            this._hpBar.gradientFillDirection = Math.PI;
            this._hpBar.color = 103481221;
            this._hpBar.subColor = 1681495;
            this._hpBar.width = 122;
            this._hpBar.height = 10;
            this._hpBar.bgColor = 5459528;
            this._hpLb = Config.getSimpleTextField();
            this._hpLb.textColor = Style.WHITE_FONT;
            this._hpLb.filters = [new GlowFilter(Style.WINDOW_FONT, 1, 3, 3, 10, 1)];
            this._hpLb.y = 16;
            this._hpLb.mouseEnabled = false;
            this._mpBar = new ProgressBar(this, 110, 39);
            this._mpBar.gradientFillDirection = Math.PI;
            this._mpBar.color = 4972287;
            this._mpBar.subColor = 26519;
            this._mpBar.width = 122;
            this._mpBar.height = 10;
            this._mpBar.bgColor = 5459528;
            this._mpLb = Config.getSimpleTextField();
            this._mpLb.textColor = Style.WHITE_FONT;
            this._mpLb.filters = [new GlowFilter(Style.WINDOW_FONT, 1, 3, 3, 10, 1)];
            this._mpLb.y = 33;
            this._mpLb.mouseEnabled = false;
            this._enBarLayer = new Sprite();
            addChild(this._enBarLayer);
            this._enBar = new ProgressBar(this._enBarLayer, 103, 58);
            this._enBar.gradientFillDirection = Math.PI;
            this._enBar.color = 9844735;
            this._enBar.subColor = 5381537;
            this._enBar.width = 90;
            this._enBar.height = 7;
            this._enBar.bgColor = 5459528;
            this._enBar.maximum = 3000;
            this._enBar.addEventListener(MouseEvent.ROLL_OVER, this.handleEnRollover);
            this._enBar.addEventListener(MouseEvent.ROLL_OUT, this.handleEnRollout);
            this._enBar.addEventListener(MouseEvent.CLICK, this.handleEnClick);
            this._enBar.buttonMode = true;
            this._enLb = Config.getSimpleTextField();
            this._enLb.textColor = Style.WHITE_FONT;
            this._enLb.filters = [new GlowFilter(Style.WINDOW_FONT, 1, 3, 3, 10, 1)];
            this._enLb.y = 51;
            this._expBar = new ProgressBar(this, 35, 71);
            this._expBar.gradientFillDirection = Math.PI;
            this._expBar.roundCorner = 4;
            this._expBar.color = 15321491;
            this._expBar.height = 7;
            this._expBar.width = 70;
            this._expBar.bgColor = 5459528;
            this._menegyLB = new Label(this, 125, 64);
            this._menegyLB.textColor = 16315890;
            this._menegyLB.filters = [this._menegyLBFilter];
            this._menegyPos = new Point(x + this._menegyLB.x + this._menegyLB.width / 2, y + this._menegyLB.y + this._menegyLB.height / 2 + 10);
            this.bufarr = new Array();
            this.headmc = new MouseSprite();
            this.addChild(this.headmc);
            this.headmc.buttonMode = true;
            this.headmc.removeEventListener(MouseEvent.ROLL_OUT, this.headRollOut);
            this.headmc.removeEventListener(MouseEvent.ROLL_OVER, this.headRollOver);
            this.headmc.addEventListener(MouseEvent.ROLL_OUT, this.headRollOut);
            this.headmc.addEventListener(MouseEvent.ROLL_OVER, this.headRollOver);
            Skill.addSelectListener(this.handleSkillSelect);
            this.headmask = new Sprite();
            this.headmask.graphics.beginFill(16777215);
            this.headmask.graphics.drawRect(0, 0, 90, 68);
            this.headmask.graphics.endFill();
            this.headmc.addChild(this.headmask);
            this._headBmp = new Bitmap();
            this._headBmp.x = 0;
            this._headBmp.y = 0;
            this.headmc.addChild(this._headBmp);
            this.headmc.x = 11;
            this.headmc.y = 2;
            var _loc_2:* = [new GlowFilter(0, 1, 2, 2, 10)];
            this.nametext = new Label(this, 125, 2);
            this.nametext.textColor = Style.WHITE_FONT;
            this.nametext.filters = _loc_2;
            this.leveltext = new Label(this, 105, 2);
            this.leveltext.textColor = Style.WHITE_FONT;
            var _loc_3:* = new DropShadowFilter(1, 45, 11868176, 0.3, 1, 1, 10, 1, false, false);
            var _loc_4:* = new Array();
            new Array().push(_loc_3);
            this.leveltext.filters = _loc_2;
            this.severtext = new Label(this, 5, 77, Config.language("HeadUI", 1));
            this.severtext.textColor = 16777215;
            this.severtext.filters = _loc_4;
            this.severtext.tip = Config.language("HeadUI", 2);
            if (!Config._switchMobage)
            {
                this._vipBitmapArr = new Array();
                this._vipSpr = new Sprite();
                this._vipSpr.graphics.beginFill(0, 0.3);
                this._vipSpr.graphics.drawRoundRect(0, 0, 36, 15, 5);
                this._vipSpr.graphics.endFill();
                addChild(this._vipSpr);
                this._vipSpr.addEventListener(MouseEvent.MOUSE_OVER, this.vipbitover);
                this._vipSpr.addEventListener(MouseEvent.MOUSE_OUT, this.vipbitout);
                this._vipSpr.addEventListener(MouseEvent.CLICK, this.vipbitclick);
                this._vipSpr.buttonMode = true;
                _loc_5 = new Bitmap();
                _loc_5.bitmapData = Config.findsysUI("headui/vip0bg", 36, 15);
                _loc_6 = new Bitmap();
                _loc_6.bitmapData = Config.findsysUI("headui/vip0", 36, 15);
                _loc_6.x = 5;
                _loc_6.y = 3;
                _loc_7 = new Bitmap();
                _loc_7.bitmapData = Config.findsysUI("headui/00", 36, 15);
                _loc_7.x = 23;
                _loc_7.y = 3;
                this._vipBitmapArr.push(_loc_5);
                this._vipBitmapArr.push(_loc_7);
                this._vipBitmapArr.push(_loc_6);
                this._vipSpr.addChild(_loc_5);
                this._vipSpr.addChild(_loc_7);
                this._vipSpr.addChild(_loc_6);
            }
            addChild(this._front);
            addChild(this._hpLb);
            addChild(this._mpLb);
            addChild(this._enLb);
            this.buftimer = new Timer(1000);
            this.buftimer.addEventListener(TimerEvent.TIMER, this.changebuftime);
            this.fcmtime = new Timer(300000);
            this.fcmtime.addEventListener(TimerEvent.TIMER, this.fcmshowtip);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_JYDBUFF, this.jydbuff);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKILL_BUFFER_LIST, this.bufflist);
            this.addTip(285 - 202, 259 - 240, 21, 13, Config.language("HeadUI", 22));
            this.addTip(285 - 202, 276 - 240, 19, 14, Config.language("HeadUI", 23));
            this.addTip(279 - 202, 293 - 240, 20, 14, Config.language("HeadUI", 24));
            this.addTip(209 - 202, 304 - 240, 26, 18, Config.language("HeadUI", 25));
            this.addTip(311 - 202, 307 - 240, 13, 13, Config.language("HeadUI", 26));
            return;
        }// end function

        private function addTip(param1, param2, param3, param4, param5)
        {
            var _loc_6:* = new Panel(this, param1, param2);
            new Panel(this, param1, param2).alpha = 0;
            _loc_6.setSize(param3, param4);
            _loc_6.tip = param5;
            return;
        }// end function

        private function openAutoDrug(event:MouseEvent) : void
        {
            Config.ui._autoDrug.switchOpen();
            return;
        }// end function

        private function handleEnRollover(param1)
        {
            var _loc_2:* = "10%";
            if (Config.player.level >= 120)
            {
                _loc_2 = "1%";
            }
            Holder.showInfo(Config.language("HeadUI", 18, _loc_2), new Rectangle(this._enLb.x + this._enLb.parent.x + this._enLb.parent.parent.x + 20, this._enLb.y + this._enLb.parent.y + this._enLb.parent.parent.y - 10, this._enLb.width, this._enLb.height), false, 2, 160);
            return;
        }// end function

        private function handleRollover(param1)
        {
            Holder.showInfo(Config.language("HeadUI", 19, Config.coinShow(Config.player.autoHp), Config.coinShow(Config.player.autoMp)), new Rectangle(this._enLb.x + this._enLb.parent.x + this._enLb.parent.parent.x + 20, this._enLb.y + this._enLb.parent.y + this._enLb.parent.parent.y - 10, this._enLb.width, this._enLb.height), false, 2, 160);
            return;
        }// end function

        private function handleEnRollout(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        public function setEn(param1)
        {
            var _loc_2:* = Math.min(param1, 3000);
            if (_loc_2 < 2500)
            {
                GuideUI.testDoId(205, this._enBar);
            }
            this._enBar.value = _loc_2;
            this._enLb.text = _loc_2 + " / " + 3000;
            this._enLb.x = this._enBar.x + this._enBar.width / 2 - this._enLb.width / 2;
            Config.ui._energyPanel.setEnLabel(param1);
            this.setEnBarColor(param1);
            return;
        }// end function

        private function handleEnClick(event:MouseEvent) : void
        {
            Config.ui._energyPanel.switchOpen();
            return;
        }// end function

        private function handleSkillSelect()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            if (this._mouseOn)
            {
                if (Skill.selectedSkill)
                {
                    _loc_1 = Skill.selectedSkill._skillData.camp;
                    _loc_2 = Config.player;
                    if (_loc_2 != null)
                    {
                        if (_loc_1 == 1 || _loc_1 == 2)
                        {
                            if (!_loc_2.die)
                            {
                                if (Config.player != null)
                                {
                                    this.headmc.filters = [Style.GREENLIGHT];
                                    return;
                                }
                            }
                        }
                    }
                }
                this.headmc.filters = [];
            }
            return;
        }// end function

        public function teamOn()
        {
            return;
        }// end function

        public function teamOff()
        {
            return;
        }// end function

        private function headRollOver(event:MouseEvent) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            this._mouseOn = true;
            if (Skill.selectedSkill)
            {
                _loc_2 = Skill.selectedSkill._skillData.camp;
                _loc_3 = Config.player;
                if (_loc_3 != null)
                {
                    if (_loc_2 == 1 || _loc_2 == 2)
                    {
                        if (!_loc_3.die)
                        {
                            if (Config.player != null)
                            {
                                this.headmc.filters = [Style.GREENLIGHT];
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        private function headRollOut(event:MouseEvent) : void
        {
            this._mouseOn = false;
            this.headmc.filters = [];
            return;
        }// end function

        private function handleClick(event:MouseEvent) : void
        {
            var _loc_2:* = undefined;
            if (Skill.selectedSkill)
            {
                _loc_2 = Skill.selectedSkill._skillData.camp;
                if (Config.player != null)
                {
                    if (_loc_2 == 1 || _loc_2 == 2)
                    {
                        if (!Config.player.die)
                        {
                            Config.player.castSkill(Skill.selectedSkill, Config.player);
                            return;
                        }
                    }
                }
            }
            return;
        }// end function

        private function handleDropDownClick(param1:int) : void
        {
            if (this.selectarr == 1)
            {
                param1 = param1 + 1;
            }
            else if (this.selectarr == 2)
            {
                param1 = param1 + 2;
            }
            switch(param1)
            {
                case 0:
                {
                    Config.ui._teamUI.sendmemberleft();
                    break;
                }
                case 1:
                {
                    Config.ui._teamUI.sendmemberleft();
                    break;
                }
                case 2:
                {
                    Config.ui._charUI.open();
                    break;
                }
                default:
                {
                    break;
                }
            }
            DropDown.close();
            return;
        }// end function

        public function set unit(param1)
        {
            var _loc_2:* = 0;
            if (this._unit != param1)
            {
                if (this._unit != null)
                {
                }
                this._unit = param1;
                if (this._unit != null)
                {
                    this.nametext.text = String(this._unit.name);
                    this._hpBar.maximum = this._unit.hpMax;
                    this._hpBar.value = this._unit.hp;
                    this._mpBar.maximum = this._unit.mpMax;
                    this._mpBar.value = this._unit.mp;
                    this._hpLb.text = this._unit.hp + " / " + this._unit.hpMax;
                    this._mpLb.text = this._unit.mp + " / " + this._unit.mpMax;
                    this._expBar.maximum = this._unit.expUpdate;
                    this._expBar.value = this._unit.exp;
                    this._expBar.tip = Math.floor(this._unit.exp / this._unit.expUpdate * 10000) / 100 + "%   " + this._unit.exp + "/" + this._unit.expUpdate;
                    this._hpLb.x = this._hpBar.x + this._hpBar.width / 2 - this._hpLb.width / 2;
                    this._mpLb.x = this._mpBar.x + this._mpBar.width / 2 - this._mpLb.width / 2;
                    this._unit.addEventListener("update", this.handleUpdate);
                    this._menegy = this._unit.money3;
                    this._menegyLB.text = Config.coinShow(this._unit.money3);
                    this._menegyPos.x = this._menegyLB.x + this._menegyLB.width / 2;
                    this.leveltext.text = this._unit.level;
                    this._headBmp.bitmapData = Config.findHead("b" + ((Player.sex - 1) * 12 + Player.job), 72, 72);
                    this._headBmp.mask = this.headmask;
                    this.headmc.removeEventListener("sglClick", this.handleClick);
                    this.headmc.removeEventListener("dblClick", this.selectAsTArget);
                    this.headmc.addEventListener("sglClick", this.handleClick);
                    this.headmc.addEventListener("dblClick", this.selectAsTArget);
                }
                else
                {
                    visible = false;
                }
            }
            return;
        }// end function

        private function selectAsTArget(param1)
        {
            Config.player.tracingTarget = this._unit;
            return;
        }// end function

        public function get unit() : Unit
        {
            return this._unit;
        }// end function

        private function handleUpdate(param1)
        {
            var _loc_2:* = param1.target;
            if (param1.param == "hp" || param1.param == "hpMax")
            {
                this._hpBar.maximum = _loc_2.hpMax;
                this._hpBar.value = _loc_2.hp;
                this._hpLb.text = this._unit.hp + " / " + this._unit.hpMax;
                this._hpLb.x = this._hpBar.x + this._hpBar.width / 2 - this._hpLb.width / 2;
            }
            else if (param1.param == "mp" || param1.param == "mpMax")
            {
                this._mpBar.maximum = _loc_2.mpMax;
                this._mpBar.value = _loc_2.mp;
                this._mpLb.text = this._unit.mp + " / " + this._unit.mpMax;
                this._mpLb.x = this._mpBar.x + this._mpBar.width / 2 - this._mpLb.width / 2;
            }
            else if (param1.param == "exp" || param1.param == "expUpdate")
            {
                this._expBar.maximum = this._unit.expUpdate;
                this._expBar.value = this._unit.exp;
                this._expBar.tip = Math.floor(this._unit.exp / this._unit.expUpdate * 10000) / 100 + "%   " + this._unit.exp + "/" + this._unit.expUpdate;
            }
            else if (param1.param == "money3")
            {
                if (this._menegy == 0)
                {
                    this._menegyBuff = this._unit.money3;
                    this.menegyChange();
                }
                else
                {
                    this._menegyBuff = this._unit.money3;
                    if (this._menegy > this._menegyBuff)
                    {
                        this.menegyChange();
                    }
                }
            }
            else if (param1.param == "level")
            {
                this.leveltext.text = this._unit.level;
            }
            return;
        }// end function

        public function menegyChange()
        {
            this._menegyLBLoopCount = 0;
            this.menegyChangeLoop();
            Config.startLoop(this.menegyChangeLoop);
            this.subMenegyChange();
            Config.startLoop(this.subMenegyChange);
            return;
        }// end function

        private function menegyChangeLoop(param1 = null)
        {
            var _loc_6:* = this;
            var _loc_7:* = this._menegyLBLoopCount + 1;
            _loc_6._menegyLBLoopCount = _loc_7;
            var _loc_2:* = this._menegyLBLoopCount / 5;
            var _loc_3:* = 1 - _loc_2;
            var _loc_4:* = new ColorMatrixFilter([_loc_2, 0, 0, 0, 0, 0.5 * _loc_3, _loc_2 + 0.5 * _loc_3, 0.5 * _loc_3, 0, 0, 1 * _loc_3, 1 * _loc_3, _loc_2 + 1 * _loc_3, 0, 30, 0, 0, 0, 1, 0]);
            var _loc_5:* = new GlowFilter(55551, _loc_3, this._menegyLBLoopCount * 10, this._menegyLBLoopCount * 10, 2);
            if (this._menegyLBLoopCount >= 5)
            {
                this._menegyLB.filters = [this._menegyLBFilter];
                Config.stopLoop(this.menegyChangeLoop);
            }
            else
            {
                this._menegyLB.filters = [this._menegyLBFilter, _loc_4, _loc_5];
            }
            return;
        }// end function

        private function subMenegyChange(param1 = null)
        {
            this._menegy = this._menegy + Math.ceil((this._menegyBuff - this._menegy) / 4);
            if (Math.abs(this._menegyBuff - this._menegy) <= 3)
            {
                this._menegy = this._menegyBuff;
                Config.stopLoop(this.subMenegyChange);
            }
            this._menegyLB.text = Config.coinShow(this._menegy);
            this._menegyPos.x = this._menegyLB.x + this._menegyLB.width / 2;
            return;
        }// end function

        public function addBuf(param1:int, param2:Sprite, param3:int = 0) : void
        {
            var _loc_4:* = true;
            var _loc_5:* = 0;
            while (_loc_5 < this.bufarr.length)
            {
                
                if (this.bufarr[_loc_5].id == param1 && param1 == 9001)
                {
                    (this.bufarr[_loc_5].num + 1);
                    _loc_4 = false;
                    break;
                }
                else if (this.bufarr[_loc_5].id == param1 && param1 == 15230)
                {
                    (this.bufarr[_loc_5].num + 1);
                    _loc_4 = false;
                    break;
                }
                _loc_5 = _loc_5 + 1;
            }
            if (_loc_4)
            {
                this.bufarr.push({id:param1, buf:param2, num:1});
                this.addChild(param2);
                if (param1 == 11140)
                {
                    this.bufarr[(this.bufarr.length - 1)].time = param3 * 1000 + Config.now.getTime();
                    this.bufarr[(this.bufarr.length - 1)].tlabel = new Label(null, 0, 0, "");
                    this.bufarr[(this.bufarr.length - 1)].tlabel.textColor = 16777215;
                    this.buftimer.stop();
                    this.buftimer.start();
                }
                else if (String(Config._buffMap[param1].icon) != "0" && param1 != 9001)
                {
                    if (param3 > 0)
                    {
                        this.bufarr[(this.bufarr.length - 1)].time = param3 * 1000 + Config.now.getTime();
                    }
                    else
                    {
                        this.bufarr[(this.bufarr.length - 1)].time = int(Config._buffMap[param1].lasting) + Config.now.getTime();
                    }
                    this.bufarr[(this.bufarr.length - 1)].tlabel = new Label(null, 0, 0, "");
                    this.bufarr[(this.bufarr.length - 1)].tlabel.textColor = 16777215;
                    this.buftimer.stop();
                    this.buftimer.start();
                }
            }
            this.sortbuf();
            return;
        }// end function

        public function delBuf(param1:int) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this.bufarr.length)
            {
                
                if (this.bufarr[_loc_2].id == param1)
                {
                    (this.bufarr[_loc_2].num - 1);
                    if (this.bufarr[_loc_2].num == 0)
                    {
                        if (this.bufarr[_loc_2].buf.parent != null)
                        {
                            this.removeChild(this.bufarr[_loc_2].buf);
                        }
                        this.bufarr.splice(_loc_2, 1);
                    }
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            this.sortbuf();
            return;
        }// end function

        private function sortbuf() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this.bufarr.length)
            {
                
                this.bufarr[_loc_1].buf.x = 60 + _loc_1 % 7 * 25;
                this.bufarr[_loc_1].buf.y = 80 + int(_loc_1 / 7) * 25;
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function playerbuf(param1:int, param2:int, param3:int, param4:int = 0) : void
        {
            var _loc_5:* = null;
            switch(param2)
            {
                case 11140:
                {
                    if (param3 == 1)
                    {
                        this.delBuf(param2);
                        _loc_5 = new Sprite();
                        _loc_5.addChild(new Bitmap(Config.findIcon("bufficon/bi0010", 15, 15)));
                        _loc_5.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.showbuftip, param2));
                        _loc_5.addEventListener(MouseEvent.ROLL_OUT, this.closebuftip);
                        this.addBuf(param2, _loc_5, param4);
                    }
                    else
                    {
                        this.delBuf(param2);
                    }
                    break;
                }
                case 9001:
                {
                    if (param3 == 1)
                    {
                        _loc_5 = new Sprite();
                        _loc_5.addChild(new Bitmap(Config.findIcon("bufficon/" + Config._buffMap[param2].icon, 15, 15)));
                        _loc_5.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.showbuftip, param2));
                        _loc_5.addEventListener(MouseEvent.ROLL_OUT, this.closebuftip);
                        this.addBuf(9001, _loc_5);
                        if (GuideUI.testId(40))
                        {
                            GuideUI.doId(40, _loc_5);
                        }
                        else if (GuideUI.testId(135))
                        {
                            GuideUI.doId(135, _loc_5);
                        }
                    }
                    else
                    {
                        this.delBuf(9001);
                    }
                    break;
                }
                case 15230:
                {
                    if (param3 == 1)
                    {
                        _loc_5 = new Sprite();
                        _loc_5.addChild(new Bitmap(Config.findIcon("bufficon/" + Config._buffMap[param2].icon, 15, 15)));
                        _loc_5.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.showbuftip, param2));
                        _loc_5.addEventListener(MouseEvent.ROLL_OUT, this.closebuftip);
                        this.addBuf(15230, _loc_5);
                        var _loc_6:* = this;
                        var _loc_7:* = this.qiuBufNum + 1;
                        _loc_6.qiuBufNum = _loc_7;
                    }
                    else
                    {
                        this.delBuf(15230);
                        var _loc_6:* = this;
                        var _loc_7:* = this.qiuBufNum - 1;
                        _loc_6.qiuBufNum = _loc_7;
                    }
                    if (Config.player != null)
                    {
                        Config.player.qiuBuf = this.qiuBufNum;
                        trace(this.qiuBufNum);
                    }
                    break;
                }
                default:
                {
                    if (Config._buffMap[param2] != null && String(Config._buffMap[param2].icon) != "0")
                    {
                        if (param3 == 1)
                        {
                            _loc_5 = new Sprite();
                            _loc_5.addChild(new Bitmap(Config.findIcon("bufficon/" + Config._buffMap[param2].icon, 15, 15)));
                            _loc_5.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.showbuftip, param2));
                            _loc_5.addEventListener(MouseEvent.ROLL_OUT, this.closebuftip);
                            this.addBuf(param2, _loc_5, param4);
                            if (param2 == 8030)
                            {
                                GuideUI.testDoId(153, _loc_5);
                            }
                        }
                        else
                        {
                            this.delBuf(param2);
                        }
                    }
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function getbuf(param1:String) : Sprite
        {
            var _loc_2:* = new Sprite();
            _loc_2.graphics.beginFill(1207064);
            _loc_2.graphics.drawRoundRect(0, 0, 18, 18, 5);
            _loc_2.graphics.endFill();
            var _loc_3:* = new Label(_loc_2, 2, 0, param1);
            _loc_3.textColor = 16777215;
            return _loc_2;
        }// end function

        private function showbuftip(event:Event, param2:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            _loc_3 = 0;
            while (_loc_3 < this.bufarr.length)
            {
                
                switch(param2)
                {
                    case 11140:
                    {
                        break;
                    }
                    case 9001:
                    {
                        break;
                    }
                    case 15230:
                    {
                        break;
                    }
                    default:
                    {
                        if (_loc_8.length > 0)
                        {
                        }
                        if (_loc_4 < 150)
                        {
                        }
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        private function closebuftip(param1) : void
        {
            if (this.buftip.parent != null)
            {
                this.buftip.parent.removeChild(this.buftip);
                this.buftip = null;
            }
            return;
        }// end function

        private function changebuftime(event:TimerEvent) : void
        {
            var _loc_2:* = true;
            var _loc_3:* = 0;
            while (_loc_3 < this.bufarr.length)
            {
                
                if (this.bufarr[_loc_3].hasOwnProperty("time"))
                {
                    if (this.bufarr[_loc_3].time > Config.now.getTime())
                    {
                        if (this.bufarr[_loc_3].hasOwnProperty("tlabel"))
                        {
                            this.bufarr[_loc_3].tlabel.text = Config.timePoint(this.bufarr[_loc_3].time / 1000, 2);
                            _loc_2 = false;
                        }
                    }
                    else if (this.bufarr[_loc_3].id == 11140)
                    {
                        this.playerbuf(2, this.bufarr[_loc_3].id, 0, 0);
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            if (_loc_2)
            {
                this.buftimer.stop();
            }
            return;
        }// end function

        private function jydbuff(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            trace("bufftime" + _loc_3);
            this.playerbuf(2, 11140, 1, _loc_3);
            return;
        }// end function

        private function bufflist(event:SocketEvent) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_8 = _loc_2.readUnsignedInt();
                _loc_9 = int(((_loc_6 - 1) * _loc_7 + _loc_8) / 1000);
                _loc_10 = 0;
                while (_loc_10 < this.bufarr.length)
                {
                    
                    if (this.bufarr[_loc_10].id == _loc_5)
                    {
                        this.bufarr[_loc_10].time = _loc_9 * 1000 + Config.now.getTime();
                        break;
                    }
                    _loc_10 = _loc_10 + 1;
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        private function fcmstatusfuc(event:SocketEvent) : void
        {
            var _loc_2:* = event.data.readByte();
            this.fcmstatus = this.fcmflag;
            return;
        }// end function

        public function set fcmstatus(param1:int) : void
        {
            this.fcmflag = param1;
            switch(this.fcmflag)
            {
                case 0:
                {
                    this.severtext.text = Config.language("HeadUI", 1);
                    this.severtext.tip = Config.language("HeadUI", 2);
                    this.filters = [];
                    if (this.fcmtime.running)
                    {
                        this.fcmtime.stop();
                    }
                    Billboard.show(Config.language("HeadUI", 9));
                    break;
                }
                case 1:
                {
                    this.severtext.text = Config.language("HeadUI", 10);
                    this.severtext.tip = Config.language("HeadUI", 11);
                    this.filters = [Style.HIGHLIGHT];
                    if (!this.fcmtime.running)
                    {
                        this.fcmtime.start();
                    }
                    Billboard.show(Config.language("HeadUI", 12));
                    this.fcmshowtip();
                    break;
                }
                case 2:
                {
                    this.severtext.text = Config.language("HeadUI", 13);
                    this.severtext.tip = Config.language("HeadUI", 14);
                    this.filters = [Style.PLLIGHT];
                    if (!this.fcmtime.running)
                    {
                        this.fcmtime.start();
                    }
                    Billboard.show(Config.language("HeadUI", 15));
                    this.fcmshowtip();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function fcmshowtip(event:TimerEvent = null) : void
        {
            switch(this.fcmflag)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    if (this.fnum == 0)
                    {
                        this.fnum = 1;
                        return;
                    }
                    this.fnum = 0;
                    Config.ui._chatUI.showSys(Config.language("HeadUI", 16));
                    break;
                }
                case 2:
                {
                    Config.ui._chatUI.showSys(Config.language("HeadUI", 17));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get fcmstatus() : int
        {
            return this.fcmflag;
        }// end function

        public function setbarColor(param1:int, param2:Boolean) : void
        {
            if (param1 == 1)
            {
                if (param2)
                {
                    this._autoHpBarLayer.filters = [];
                }
                else
                {
                    this._autoHpBarLayer.filters = [new ColorMatrixFilter([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0])];
                }
            }
            else if (param2)
            {
                this._autoMpBarLayer.filters = [];
            }
            else
            {
                this._autoMpBarLayer.filters = [new ColorMatrixFilter([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0])];
            }
            return;
        }// end function

        private function setEnBarColor(param1:int) : void
        {
            if (param1 > 0)
            {
                this._autoEnBar.filters = [];
            }
            else
            {
                this._autoEnBar.filters = [new ColorMatrixFilter([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0])];
            }
            return;
        }// end function

        private function vipbitover(event:MouseEvent) : void
        {
            trace("vipbitover(e:MouseEvent)");
            return;
        }// end function

        private function vipbitout(event:MouseEvent) : void
        {
            trace("vipbitout(e:MouseEvent)");
            return;
        }// end function

        private function vipbitclick(event:MouseEvent) : void
        {
            trace("vipbitclick(e:MouseEvent)");
            Config.ui._vipPanel.switchOpen();
            return;
        }// end function

        public function changevipbitmap(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (Config._switchMobage)
            {
                return;
            }
            if (param1 > 0)
            {
                _loc_2 = 0;
                while (_loc_2 < this._vipBitmapArr.length)
                {
                    
                    if (this._vipBitmapArr[_loc_2].hasOwnProperty("bitmapData"))
                    {
                        this._vipBitmapArr[_loc_2].bitmapData.dispose();
                        this._vipBitmapArr[_loc_2] = null;
                    }
                    _loc_2++;
                }
                _loc_3 = new Bitmap();
                _loc_3.bitmapData = Config.findsysUI("headui/vipbg", 36, 15);
                _loc_4 = new Bitmap();
                _loc_4.bitmapData = Config.findsysUI("headui/vip", 36, 15);
                _loc_4.x = 5;
                _loc_4.y = 3;
                this._vipBitmapArr[0] = _loc_3;
                this._vipBitmapArr[1] = _loc_4;
                this._vipSpr.addChild(_loc_3);
                this._vipSpr.addChild(_loc_4);
                _loc_5 = new Bitmap();
                if (param1 < 10)
                {
                    _loc_5.bitmapData = Config.findsysUI("headui/" + param1, 36, 15);
                    _loc_5.x = 23;
                    _loc_5.y = 3;
                    this._vipBitmapArr[2] = _loc_5;
                }
                else
                {
                    this._vipBitmapArr[1].x = 3;
                    _loc_5.bitmapData = Config.findsysUI("headui/" + int(param1 / 10), 36, 15);
                    _loc_5.x = 21;
                    _loc_5.y = 3;
                    this._vipBitmapArr[2] = _loc_5;
                    _loc_6 = new Bitmap();
                    _loc_6.bitmapData = Config.findsysUI("headui/" + int(param1 % 10), 36, 15);
                    _loc_6.x = 25;
                    _loc_6.y = 3;
                    this._vipBitmapArr[3] = _loc_6;
                    this._vipSpr.addChild(_loc_6);
                }
                this._vipSpr.addChild(_loc_5);
            }
            return;
        }// end function

    }
}
