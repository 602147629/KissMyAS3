package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class EnergyPanel extends Window
    {
        private var mbar:ButtonBar;
        private var moneySp:Sprite;
        private var itemSp:Sprite;
        private var enNumStepper:NumericStepper;
        private var leftEn:Label;
        private var mt1:Label;
        private var mt2:Label;
        private var mt3:Label;
        private var expt1:Label;
        private var expt2:Label;
        private var expt3:Label;
        private var _enalert:Object;
        private var enNumStepper2:NumericStepper;
        private var leftEn2:Label;
        private var mt12:Label;
        private var mt22:Label;
        private var mt32:Label;
        private var expt12:Label;
        private var expt22:Label;
        private var expt32:Label;
        private var landtext1:Label;
        private var landtext2:Label;
        private var num1:int = 0;
        private var num2:int = 0;
        private var num3:int = 0;

        public function EnergyPanel(param1:DisplayObjectContainer)
        {
            super(param1);
            this.initPanel();
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            this.x = (Config.ui._width - this.width) / 2;
            this.y = (Config.ui._height - this.height) / 2;
            if (this.mbar.selectpage == 0)
            {
                if (this.enNumStepper.maximum > 50)
                {
                    this.enNumStepper.value = 50;
                    this.setEnNum(50);
                }
                else
                {
                    this.enNumStepper.value = this.enNumStepper.maximum;
                    this.setEnNum(this.enNumStepper.maximum);
                }
            }
            else if (this.enNumStepper2.maximum > 10)
            {
                this.enNumStepper2.value = 10;
                this.setEnNum2(10);
            }
            else
            {
                this.enNumStepper2.value = this.enNumStepper2.maximum;
                this.setEnNum2(this.enNumStepper2.maximum);
            }
            return;
        }// end function

        private function initPanel() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this.title = Config.language("EnergyPanel", 1);
            this.resize(400, 270);
            this.mbar = new ButtonBar(this, 15, 25, 385);
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                this.mbar.addTab(Config.language("EnergyPanel", 18), Config.create(this.selectPage, 1), 60);
            }
            else
            {
                this.mbar.addTab(Config.language("EnergyPanel", 17), Config.create(this.selectPage, 0), 60);
            }
            this.mbar.addTab(Config.language("EnergyPanel", 18), Config.create(this.selectPage, 1), 60);
            this.moneySp = new Sprite();
            this.itemSp = new Sprite();
            _loc_1 = new Shape();
            this.moneySp.addChild(_loc_1);
            _loc_1.graphics.beginFill(16777215, 0.4);
            _loc_1.graphics.drawRoundRect(10, 70, 120, 110, 9);
            _loc_1.graphics.drawRoundRect(140, 70, 120, 110, 9);
            _loc_1.graphics.drawRoundRect(270, 70, 120, 110, 9);
            _loc_2 = new Label(this.moneySp, 10, 35, Config.language("EnergyPanel", 2));
            this.enNumStepper = new NumericStepper(this.moneySp, 110, 35);
            this.enNumStepper.width = 120;
            this.enNumStepper.percent = false;
            this.enNumStepper.minimum = 0;
            this.enNumStepper.addEventListener("add", this.enNumChange1);
            this.enNumStepper.addEventListener("dec", this.enNumChange2);
            this.enNumStepper.addEventListener(Event.CHANGE, this.enNumChange3);
            this.leftEn = new Label(this.moneySp, 240, 35);
            this.mt1 = new Label(this.moneySp, 20, 80);
            this.mt1.html = true;
            this.mt2 = new Label(this.moneySp, 150, 80);
            this.mt2.html = true;
            this.mt3 = new Label(this.moneySp, 280, 80);
            this.mt3.html = true;
            this.expt1 = new Label(this.moneySp, 20, 105);
            this.expt1.html = true;
            this.expt2 = new Label(this.moneySp, 150, 105);
            this.expt2.html = true;
            this.expt3 = new Label(this.moneySp, 280, 105);
            this.expt3.html = true;
            _loc_3 = new PushButton(this.moneySp, 40, 150, Config.language("EnergyPanel", 3), Config.create(this.energySend, 1));
            _loc_3.setTable("table18", "table31");
            _loc_3.textColor = Style.GOLD_FONT;
            _loc_3.width = 60;
            _loc_4 = new PushButton(this.moneySp, 170, 150, Config.language("EnergyPanel", 4), Config.create(this.energySend, 2));
            _loc_4.setTable("table18", "table31");
            _loc_4.textColor = Style.GOLD_FONT;
            _loc_4.width = 60;
            _loc_5 = new PushButton(this.moneySp, 300, 150, Config.language("EnergyPanel", 5), Config.create(this.energySend, 3));
            _loc_5.setTable("table18", "table31");
            _loc_5.textColor = Style.GOLD_FONT;
            _loc_5.width = 60;
            _loc_6 = new Label(this.moneySp, 10, 190, Config.language("EnergyPanel", 6));
            this.landtext1 = new Label(this.moneySp, 20, 210);
            this.landtext1.html = true;
            _loc_1 = new Shape();
            this.itemSp.addChild(_loc_1);
            _loc_1.graphics.beginFill(16777215, 0.4);
            _loc_1.graphics.drawRoundRect(10, 70, 120, 110, 9);
            _loc_1.graphics.drawRoundRect(140, 70, 120, 110, 9);
            _loc_1.graphics.drawRoundRect(270, 70, 120, 110, 9);
            _loc_2 = new Label(this.itemSp, 10, 35, Config.language("EnergyPanel", 2));
            this.enNumStepper2 = new NumericStepper(this.itemSp, 110, 35);
            this.enNumStepper2.width = 120;
            this.enNumStepper2.percent = false;
            this.enNumStepper2.minimum = 0;
            this.enNumStepper2.addEventListener("add", this.enNumChange4);
            this.enNumStepper2.addEventListener("dec", this.enNumChange5);
            this.enNumStepper2.addEventListener(Event.CHANGE, this.enNumChange6);
            this.leftEn2 = new Label(this.itemSp, 240, 35);
            this.mt12 = new Label(this.itemSp, 20, 80);
            this.mt12.html = true;
            this.mt22 = new Label(this.itemSp, 150, 80);
            this.mt22.html = true;
            this.mt32 = new Label(this.itemSp, 280, 80);
            this.mt32.html = true;
            this.expt12 = new Label(this.itemSp, 20, 105);
            this.expt12.html = true;
            this.expt22 = new Label(this.itemSp, 150, 105);
            this.expt22.html = true;
            this.expt32 = new Label(this.itemSp, 280, 105);
            this.expt32.html = true;
            _loc_3 = new PushButton(this.itemSp, 40, 150, Config.language("EnergyPanel", 3), Config.create(this.energySend2, 1));
            _loc_3.setTable("table18", "table31");
            _loc_3.textColor = Style.GOLD_FONT;
            _loc_3.width = 60;
            _loc_4 = new PushButton(this.itemSp, 170, 150, Config.language("EnergyPanel", 4), Config.create(this.energySend2, 2));
            _loc_4.setTable("table18", "table31");
            _loc_4.textColor = Style.GOLD_FONT;
            _loc_4.width = 60;
            _loc_5 = new PushButton(this.itemSp, 300, 150, Config.language("EnergyPanel", 5), Config.create(this.energySend2, 3));
            _loc_5.setTable("table18", "table31");
            _loc_5.textColor = Style.GOLD_FONT;
            _loc_5.width = 60;
            _loc_6 = new Label(this.itemSp, 10, 190, Config.language("EnergyPanel", 19));
            this.selectPage();
            this.landtext2 = new Label(this.itemSp, 20, 210);
            this.landtext2.html = true;
            return;
        }// end function

        private function enNumChange1(event:Event) : void
        {
            if (Math.ceil(this.enNumStepper.value / 50) * 50 <= this.enNumStepper.maximum)
            {
                this.enNumStepper.value = Math.ceil(this.enNumStepper.value / 50) * 50;
            }
            else
            {
                this.enNumStepper.value = this.enNumStepper.maximum;
            }
            this.setEnNum(this.enNumStepper.value);
            return;
        }// end function

        private function enNumChange2(event:Event) : void
        {
            this.enNumStepper.value = int(this.enNumStepper.value / 50) * 50;
            this.setEnNum(this.enNumStepper.value);
            return;
        }// end function

        private function enNumChange3(event:Event) : void
        {
            if (this.enNumStepper.focus)
            {
                this.setEnNum(this.enNumStepper.value);
            }
            return;
        }// end function

        private function setEnNum(param1:int) : void
        {
            var _loc_2:* = 1;
            if (this.getlandstr() != "")
            {
                this.landtext1.text = Config.language("EnergyPanel", 22);
                _loc_2 = 1.2;
            }
            this.mt1.text = Config.language("EnergyPanel", 7, Math.ceil(param1 / 50));
            this.mt2.text = Config.language("EnergyPanel", 7, Math.ceil(param1 / 50) * 8);
            this.mt3.text = Config.language("EnergyPanel", 7, Math.ceil(param1 / 50) * 16);
            this.expt1.text = Config.language("EnergyPanel", 8, Config.coinShow(param1 * Config._ListExp[Config.player.level].monsterExp)) + this.getlandstr();
            this.expt2.text = Config.language("EnergyPanel", 8, Config.coinShow(param1 * Config._ListExp[Config.player.level].monsterExp * 3)) + this.getlandstr();
            this.expt3.text = Config.language("EnergyPanel", 8, Config.coinShow(param1 * Config._ListExp[Config.player.level].monsterExp * 5)) + this.getlandstr();
            this.num1 = int(int(param1 * Config._ListExp[Config.player.level].monsterExp) * _loc_2);
            this.num2 = int(int(param1 * Config._ListExp[Config.player.level].monsterExp * 3) * _loc_2);
            this.num3 = int(int(param1 * Config._ListExp[Config.player.level].monsterExp * 5) * _loc_2);
            return;
        }// end function

        public function setEnLabel(param1:int) : void
        {
            this.leftEn.text = Config.language("EnergyPanel", 9, param1);
            this.enNumStepper.maximum = param1;
            if (this.stage != null)
            {
                this.setEnNum(this.enNumStepper.value);
            }
            this.setEnLabel2(param1);
            return;
        }// end function

        private function energySend(event:MouseEvent, param2:int = 1) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param2 == 1)
            {
                _loc_3 = this.mt1.text + Config.language("EnergyPanel", 24) + this.num1;
                _loc_4 = Config.language("EnergyPanel", 10, _loc_3);
            }
            else if (param2 == 2)
            {
                _loc_3 = this.mt2.text + Config.language("EnergyPanel", 24) + this.num2;
                _loc_4 = Config.language("EnergyPanel", 11, _loc_3);
            }
            else
            {
                _loc_3 = this.mt3.text + Config.language("EnergyPanel", 24) + this.num3;
                _loc_4 = Config.language("EnergyPanel", 12, _loc_3);
            }
            if (this._enalert != null)
            {
                AlertUI.remove(this._enalert);
            }
            if (this.enNumStepper.value > 0)
            {
                this._enalert = AlertUI.alert(Config.language("EnergyPanel", 13), _loc_4, [Config.language("EnergyPanel", 14), Config.language("EnergyPanel", 15)], [Config.create(this.centerSend, this.enNumStepper.value, param2)]);
            }
            else
            {
                this._enalert = AlertUI.alert(Config.language("EnergyPanel", 13), Config.language("EnergyPanel", 16), [Config.language("EnergyPanel", 14)]);
            }
            return;
        }// end function

        private function centerSend(event:MouseEvent, param2:int, param3:int) : void
        {
            trace(param2, param3);
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_EXPBALL_BUYEXP);
            _loc_4.add32(param2);
            _loc_4.add8(param3);
            ClientSocket.send(_loc_4);
            return;
        }// end function

        public function selectPage(event:MouseEvent = null, param2:int = 0) : void
        {
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                param2 = 1;
            }
            if (param2 == 0)
            {
                this.addChild(this.moneySp);
                this.moneySp.y = 30;
                if (this.itemSp.parent != null)
                {
                    this.removeChild(this.itemSp);
                }
                this.mbar.selectpage = 0;
            }
            else
            {
                this.addChild(this.itemSp);
                this.itemSp.y = 30;
                if (this.moneySp.parent != null)
                {
                    this.removeChild(this.moneySp);
                }
                this.mbar.selectpage = 1;
            }
            if (event != null)
            {
                if (this.mbar.selectpage == 0)
                {
                    if (this.enNumStepper.maximum > 50)
                    {
                        this.enNumStepper.value = 50;
                        this.setEnNum(50);
                    }
                    else
                    {
                        this.enNumStepper.value = this.enNumStepper.maximum;
                        this.setEnNum(this.enNumStepper.maximum);
                    }
                }
                else if (this.enNumStepper2.maximum > 10)
                {
                    this.enNumStepper2.value = 10;
                    this.setEnNum2(10);
                }
                else
                {
                    this.enNumStepper2.value = this.enNumStepper2.maximum;
                    this.setEnNum2(this.enNumStepper2.maximum);
                }
            }
            return;
        }// end function

        private function enNumChange4(event:Event) : void
        {
            if (Math.ceil(this.enNumStepper2.value / 10) * 10 <= this.enNumStepper2.maximum)
            {
                this.enNumStepper2.value = Math.ceil(this.enNumStepper2.value / 10) * 10;
            }
            else
            {
                this.enNumStepper2.value = this.enNumStepper2.maximum;
            }
            this.setEnNum2(this.enNumStepper2.value);
            return;
        }// end function

        private function enNumChange5(event:Event) : void
        {
            this.enNumStepper2.value = int(this.enNumStepper2.value / 10) * 10;
            this.setEnNum2(this.enNumStepper2.value);
            return;
        }// end function

        private function enNumChange6(event:Event) : void
        {
            if (this.enNumStepper2.focus)
            {
                this.setEnNum2(this.enNumStepper2.value);
            }
            return;
        }// end function

        private function setEnNum2(param1:int) : void
        {
            var _loc_2:* = 1;
            if (this.getlandstr() != "")
            {
                this.landtext2.text = Config.language("EnergyPanel", 22);
                _loc_2 = 1.2;
            }
            this.mt12.text = Config.language("EnergyPanel", 20, Math.ceil(param1 / 10));
            this.mt22.text = Config.language("EnergyPanel", 20, Math.ceil(param1 / 10) * 8);
            this.mt32.text = Config.language("EnergyPanel", 20, Math.ceil(param1 / 10) * 16);
            this.expt12.text = Config.language("EnergyPanel", 21, Config.coinShow(param1 * Config._ListExp[Config.player.level].monsterExp)) + this.getlandstr();
            this.expt22.text = Config.language("EnergyPanel", 21, Config.coinShow(param1 * Config._ListExp[Config.player.level].monsterExp * 3)) + this.getlandstr();
            this.expt32.text = Config.language("EnergyPanel", 21, Config.coinShow(param1 * Config._ListExp[Config.player.level].monsterExp * 5)) + this.getlandstr();
            this.num1 = int(int(param1 * Config._ListExp[Config.player.level].monsterExp) * _loc_2);
            this.num2 = int(int(param1 * Config._ListExp[Config.player.level].monsterExp * 3) * _loc_2);
            this.num3 = int(int(param1 * Config._ListExp[Config.player.level].monsterExp * 5) * _loc_2);
            return;
        }// end function

        public function setEnLabel2(param1:int) : void
        {
            this.leftEn2.text = Config.language("EnergyPanel", 9, param1);
            this.enNumStepper2.maximum = param1;
            if (this.stage != null)
            {
                this.setEnNum2(this.enNumStepper2.value);
            }
            return;
        }// end function

        private function energySend2(event:MouseEvent, param2:int = 1) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param2 == 1)
            {
                _loc_4 = this.mt12.text + Config.language("EnergyPanel", 23) + this.num1;
                _loc_3 = Config.language("EnergyPanel", 10, _loc_4);
            }
            else if (param2 == 2)
            {
                _loc_4 = this.mt22.text + Config.language("EnergyPanel", 23) + this.num2;
                _loc_3 = Config.language("EnergyPanel", 11, _loc_4);
            }
            else
            {
                _loc_4 = this.mt32.text + Config.language("EnergyPanel", 23) + this.num3;
                _loc_3 = Config.language("EnergyPanel", 12, _loc_4);
            }
            if (this._enalert != null)
            {
                AlertUI.remove(this._enalert);
            }
            if (this.enNumStepper2.value > 0)
            {
                this._enalert = AlertUI.alert(Config.language("EnergyPanel", 13), _loc_3, [Config.language("EnergyPanel", 14), Config.language("EnergyPanel", 15)], [Config.create(this.centerSend2, this.enNumStepper2.value, param2)]);
            }
            else
            {
                this._enalert = AlertUI.alert(Config.language("EnergyPanel", 13), Config.language("EnergyPanel", 16), [Config.language("EnergyPanel", 14)]);
            }
            return;
        }// end function

        private function centerSend2(event:MouseEvent, param2:int, param3:int) : void
        {
            trace(param2, param3);
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_EXPBALL_ITEMBUYEXP);
            _loc_4.add32(param2);
            _loc_4.add8(param3);
            ClientSocket.send(_loc_4);
            return;
        }// end function

        private function getlandstr() : String
        {
            var _loc_2:* = 0;
            var _loc_1:* = "";
            if (Config.ui._landGravePanel.showLandgildId().length > 0)
            {
                _loc_2 = 0;
                while (_loc_2 < Config.ui._landGravePanel.showLandgildId().length)
                {
                    
                    trace(Config.ui._landGravePanel.showLandgildId()[_loc_2]._gild, Config.ui._landGravePanel.showLandgildId()[_loc_2]._landLvmax, Config.ui._landGravePanel.showLandgildId()[_loc_2]._landLvmin, "领地");
                    if (Config.ui._landGravePanel.showLandgildId()[_loc_2]._gild == Config.player.gildid)
                    {
                        if (Config.player.level >= int(Config.ui._landGravePanel.showLandgildId()[_loc_2]._landLvmin) && Config.player.level <= int(Config.ui._landGravePanel.showLandgildId()[_loc_2]._landLvmax))
                        {
                            _loc_1 = "\n        <font COLOR=\'#ad1b2e\'>* 120%</font>";
                        }
                    }
                    _loc_2++;
                }
            }
            return _loc_1;
        }// end function

    }
}
