package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.text.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class TargetUI extends Sprite
    {
        private var _hpBar:ProgressBar;
        private var _mpBar:ProgressBar;
        private var _hpLb:TextField;
        private var _nameLB:TextField;
        private var _nameBB:Table;
        public var _closeBtn:PushButton;
        public var _unit:Unit;

        public function TargetUI()
        {
            this._nameBB = new Table("table18");
            this._nameBB.resize(100, 22);
            addChild(this._nameBB);
            this._hpBar = new ProgressBar(this, -50, 23);
            this._hpBar.gradientFillDirection = Math.PI;
            this._hpBar.roundCorner = 6;
            this._hpBar.color = 13369344;
            this._hpBar.subColor = 6684672;
            this._hpBar.height = 12;
            this._hpLb = Config.getSimpleTextField();
            this._hpLb.textColor = 16315890;
            this._hpLb.filters = [new GlowFilter(Style.WINDOW_FONT, 1, 3, 3, 10, 1)];
            this._hpLb.y = 19;
            addChild(this._hpLb);
            this._nameLB = Config.getSimpleTextField();
            this._nameLB.textColor = Style.WHITE_FONT;
            this._nameLB.y = 2;
            addChild(this._nameLB);
            this._nameBB.addEventListener(MouseEvent.CLICK, this.handleClick);
            this._closeBtn = new PushButton(this, 200, 4, "", this.handleCloseBtn);
            this._closeBtn.overshow = true;
            this._closeBtn.setStyle(Config.findUI("window")["closebutton"]);
            return;
        }// end function

        private function handleCloseBtn(param1)
        {
            if (Config.player != null)
            {
                Config.player.tracingTarget = null;
            }
            return;
        }// end function

        private function handleClick(param1)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._unit.type == UNIT_TYPE_ENUM.TYPEID_PLAYER && !(this._unit is Player))
            {
                _loc_2 = new Array();
                if (Config._switchMobage)
                {
                    _loc_3 = [Config.language("TargetUI", 16), Config.language("TargetUI", 1), Config.language("TargetUI", 2), Config.language("TargetUI", 3), Config.language("TargetUI", 4), Config.language("TargetUI", 15), Config.language("TargetUI", 9)];
                    _loc_4 = [Config.language("TargetUI", 16), Config.language("TargetUI", 1), Config.language("TargetUI", 2), Config.language("TargetUI", 3), Config.language("TargetUI", 4), Config.language("TargetUI", 15)];
                }
                else
                {
                    _loc_3 = [Config.language("TargetUI", 16), Config.language("TargetUI", 1), Config.language("TargetUI", 2), Config.language("TargetUI", 3), Config.language("TargetUI", 4), Config.language("TargetUI", 5), Config.language("TargetUI", 6), Config.language("TargetUI", 7), Config.language("TargetUI", 8), Config.language("TargetUI", 15), Config.language("TargetUI", 9)];
                    _loc_4 = [Config.language("TargetUI", 16), Config.language("TargetUI", 1), Config.language("TargetUI", 2), Config.language("TargetUI", 3), Config.language("TargetUI", 4), Config.language("TargetUI", 5), Config.language("TargetUI", 6), Config.language("TargetUI", 7), Config.language("TargetUI", 8), Config.language("TargetUI", 15)];
                }
                if (this._unit.teamflag && !Config.player.teamflag)
                {
                    _loc_3[1] = Config.language("TargetUI", 10);
                    _loc_4[1] = Config.language("TargetUI", 10);
                }
                else if (!this._unit.teamflag && Config.player.teamflag)
                {
                    _loc_3[1] = Config.language("TargetUI", 11);
                    _loc_4[1] = Config.language("TargetUI", 11);
                }
                else if (this._unit.teamflag && Config.player.teamflag)
                {
                    _loc_3[1] = Config.language("TargetUI", 12);
                    _loc_4[1] = Config.language("TargetUI", 12);
                }
                if (Config.ui._gangs.mytype == 0)
                {
                    _loc_2 = _loc_4;
                }
                else if (Config.ui._gangs.mytype == 1 || Config.ui._gangs.mytype == 2 || Config.ui._gangs.mytype == 3)
                {
                    _loc_2 = _loc_3;
                }
                else
                {
                    _loc_2 = _loc_4;
                }
                _loc_2 = _loc_2;
                DropDown.dropDown(_loc_2, this.handleDropDownClick);
            }
            return;
        }// end function

        private function handleDropDownClick(param1)
        {
            var _loc_2:* = null;
            if (this._unit == null)
            {
                return;
            }
            if (Config._switchMobage)
            {
                if (param1 > 3)
                {
                    param1 = param1 + 5;
                }
            }
            if (param1 == 0)
            {
                if (Config.ui._giveflower.todaysendnum < 5)
                {
                    Config.ui._giveflower.open();
                    Config.ui._giveflower.flowerplayerid = this._unit.id;
                    Config.ui._giveflower.flowerplayername = this._unit.name;
                }
                else
                {
                    Config.message(Config.language("TargetUI", 17));
                }
            }
            else if (param1 == 1)
            {
                if (this._unit != null)
                {
                    if (this._unit.teamflag)
                    {
                        Config.ui._teamUI.reloginteam(this._unit._id);
                    }
                    else
                    {
                        Config.ui._teamUI.inviteTeam(this._unit._id);
                    }
                }
            }
            else if (param1 == 2)
            {
                Config.ui._friendUI.addFriend(this._unit.name);
            }
            else if (param1 == 3)
            {
                if (Config.map._type == 10 || Config.ui._farmpanel._opening == true)
                {
                    Config.message(Config.language("TargetUI", 13));
                }
                else if (this._unit != null)
                {
                    _loc_2 = new DataSet();
                    if (Config.ui._dealUI.tempdealplayer == 0 || Config.ui._dealUI.tempdealplayer == Config.player._id)
                    {
                        _loc_2.addHead(CONST_ENUM.CMSG_TRADE_REQUEST);
                        _loc_2.add32(int(this._unit._id));
                        ClientSocket.send(_loc_2);
                    }
                    else
                    {
                        if (int(this._unit._id) == Config.ui._dealUI.tempdealplayer)
                        {
                            Config.message(Config.language("TargetUI", 14));
                            return;
                        }
                        Config.ui._dealUI.nowplayerid = int(this._unit._id);
                        Config.ui._dealUI.dealflag = true;
                        _loc_2.addHead(CONST_ENUM.CMSG_TRADE_CANCEL);
                        _loc_2.add32(Config.ui._dealUI.tempdealplayer);
                        ClientSocket.send(_loc_2);
                    }
                }
            }
            else if (param1 == 4)
            {
                Config.ui._equippanel.sendequip(this._unit._id);
            }
            else if (param1 == 5)
            {
                Config.ui._chatUI.whisperTo(this._unit.name);
            }
            else if (param1 == 6)
            {
                Config.ui._mailpanel.sendmailshow(null, this._unit.name);
                Config.ui._mailpanel.open();
            }
            else if (param1 == 7)
            {
                Config.ui._friendUI.sendAddEnemy(this._unit.name);
            }
            else if (param1 == 8)
            {
                Config.ui._friendUI.sendaddblack(null, this._unit.name);
            }
            else if (param1 == 9)
            {
                Config.ui._pkUI.invitePk(this._unit.id, this._unit.name);
            }
            else if (param1 == 10)
            {
                Config.ui._gangs.inviteguild(this._unit.name);
            }
            return;
        }// end function

        public function set unit(param1)
        {
            var _loc_2:* = 0;
            if (this._unit != param1)
            {
                if (this._unit != null)
                {
                    this._unit.removeEventListener("update", this.handleUpdate);
                    this._unit.removeEventListener("destroy", this.handleDestroy);
                    this._unit.removeEventListener("disappear", this.handleDestroy);
                }
                this._unit = param1;
                if (this._unit != null)
                {
                    this._nameLB.text = String(param1.name) + "  lv:" + String(param1.level);
                    this._nameLB.x = (-this._nameLB.width) / 2;
                    this._nameBB.resize(Math.max(100, this._nameLB.width + 15 + 40), 22);
                    this._nameBB.x = -Math.ceil(this._nameBB.width / 2);
                    this._closeBtn.x = this._nameBB.x + this._nameBB.width - 20;
                    this._hpBar.maximum = this._unit.hpMax;
                    this._hpBar.value = this._unit.hp;
                    if (this._unit.hp >= 10000)
                    {
                        this._hpLb.text = int(this._unit.hp / 1000) + " K (" + int(Math.max(1, this._unit.hp * 100 / this._unit.hpMax)) + "%)";
                    }
                    else
                    {
                        this._hpLb.text = this._unit.hp + " (" + int(Math.max(1, this._unit.hp * 100 / this._unit.hpMax)) + "%)";
                    }
                    this._hpLb.x = (-this._hpLb.width) / 2;
                    this._unit.addEventListener("update", this.handleUpdate);
                    this._unit.addEventListener("destroy", this.handleDestroy);
                    this._unit.addEventListener("disappear", this.handleDestroy);
                    visible = true;
                    if (this._unit.type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
                    {
                        this._nameBB.buttonMode = true;
                    }
                    else
                    {
                        this._nameBB.buttonMode = false;
                    }
                }
                else
                {
                    visible = false;
                    this._nameBB.buttonMode = false;
                }
            }
            return;
        }// end function

        public function get unit() : Unit
        {
            return this._unit;
        }// end function

        private function handleDestroy(param1)
        {
            Config.player.tracingTarget = null;
            return;
        }// end function

        private function handleUpdate(param1)
        {
            var _loc_2:* = param1.target;
            if (param1.param == "hp" || param1.param == "hpMax")
            {
                this._hpBar.maximum = _loc_2.hpMax;
                this._hpBar.value = _loc_2.hp;
                if (this._unit.hp >= 10000)
                {
                    this._hpLb.text = int(this._unit.hp / 1000) + " K (" + int(Math.max(1, this._unit.hp * 100 / this._unit.hpMax)) + "%)";
                }
                else
                {
                    this._hpLb.text = this._unit.hp + " (" + int(Math.max(1, this._unit.hp * 100 / this._unit.hpMax)) + "%)";
                }
                this._hpLb.x = (-this._hpLb.width) / 2;
            }
            else if (param1.param == "level")
            {
                this._nameLB.text = String(_loc_2.name) + "  lv:" + String(_loc_2.level);
                this._nameLB.x = (-this._nameLB.width) / 2;
                this._nameBB.resize(Math.max(100, this._nameLB.width + 15 + 40), 22);
                this._nameBB.x = -Math.ceil(this._nameBB.width / 2);
                this._closeBtn.x = this._nameBB.x + this._nameBB.width - 20;
            }
            else if (param1.param == "die")
            {
                Config.player.tracingTarget = null;
            }
            else if (param1.param == "destroy")
            {
                Config.player.tracingTarget = null;
            }
            return;
        }// end function

    }
}
