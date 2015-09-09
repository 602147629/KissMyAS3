package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class CombatMode extends Sprite
    {
        private var _modePBL:PushButtonList;
        private var _teamModeCB:CheckBox;
        private var _guildModeCB:CheckBox;
        public var type:int = 0;
        private var pknum:uint = 0;
        private const pkgrow:int = 12;
        private var color:int = 16777215;
        private var mustpk:Boolean = false;
        private var _warStatus:Boolean = false;

        public function CombatMode()
        {
            this.initpanel();
            this.init();
            return;
        }// end function

        private function init() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PLAYER_PKMODE, this.changetype);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_PLAYER_PK, this.changepkstate);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ENTER_WAR, this.enterWar);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_LEAVE_WAR, this.leaveWar);
            return;
        }// end function

        private function initpanel() : void
        {
            this._modePBL = new PushButtonList(this, 0, 0, this.checkmodechange);
            this._modePBL.orientation = 2;
            this._modePBL.addButtons([Config.language("CombatMode", 1), "PK"]);
            this._modePBL.width = 40;
            return;
        }// end function

        private function checkmodechange(event:Event) : void
        {
            if (this._modePBL.selectedIndex != 0)
            {
                AlertUI.alert(Config.language("CombatMode", 3), Config.language("CombatMode", 4), [Config.language("CombatMode", 5), Config.language("CombatMode", 6)], [this.handleModeChange, this.cancelcheck]);
                return;
            }
            this.handleModeChange();
            return;
        }// end function

        private function cancelcheck(param1) : void
        {
            this._modePBL.selectedIndex = 0;
            return;
        }// end function

        private function handleModeChange(param1 = null)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_PLAYER_PKMODE);
            switch(this._modePBL.selectedIndex)
            {
                case 0:
                {
                    _loc_2.add8(0);
                    break;
                }
                case 1:
                {
                    _loc_2.add8(3);
                    break;
                }
                default:
                {
                    break;
                }
            }
            ClientSocket.send(_loc_2);
            this._modePBL.enabled = false;
            return;
        }// end function

        private function sendmode(event:MouseEvent) : void
        {
            var _loc_2:* = this.type + 1;
            if (_loc_2 > 3)
            {
                _loc_2 = 1;
            }
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_PLAYER_PKMODE);
            _loc_3.add8(_loc_2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function selectmode(param1:uint) : void
        {
            return;
        }// end function

        private function order(param1:Object, param2:Object) : int
        {
            var _loc_3:* = int(param1.type);
            var _loc_4:* = int(param2.type);
            if (_loc_3 < _loc_4)
            {
                return -1;
            }
            if (_loc_3 > _loc_4)
            {
                return 1;
            }
            return 0;
        }// end function

        public function get combattype() : int
        {
            return this.type;
        }// end function

        public function set combattype(param1:int) : void
        {
            this.type = param1;
            if (this.mustpk)
            {
                Config.player.pkState = 3;
                this._modePBL.selectedIndex = 1;
            }
            else
            {
                switch(param1)
                {
                    case 0:
                    {
                        this._modePBL.selectedIndex = 0;
                        break;
                    }
                    case 3:
                    {
                        this._modePBL.selectedIndex = 1;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function changetype(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            this.type = event.data.readByte();
            var _loc_2:* = event.data.readUnsignedInt();
            var _loc_3:* = event.data.readUnsignedInt();
            var _loc_4:* = event.data.readByte();
            if (this.mustpk)
            {
            }
            switch(this.type)
            {
                case 0:
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
            if (_loc_4 == 1)
            {
                if (_loc_7 > 0)
                {
                }
                if (_loc_8 > 0)
                {
                }
                if (_loc_6 > 0)
                {
                }
            }
            if (_loc_4 == 0)
            {
            }
            if (_loc_11 != null)
            {
                if (this.mustpk)
                {
                }
                else
                {
                }
            }
            return;
        }// end function

        private function changepkstate(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readByte();
            return;
        }// end function

        public function set pkpoint(param1:int) : void
        {
            this.pknum = param1;
            this.pkcolor = this.pknum;
            return;
        }// end function

        public function get pkpoint() : int
        {
            return this.pknum;
        }// end function

        public function set pkcolor(param1:int) : void
        {
            var _loc_2:* = [16777215, 16776960, 6684672, 3342387];
            if (this.pknum == 0)
            {
                this.color = _loc_2[0];
            }
            else if (this.pknum > 0 && this.pknum < 24)
            {
                this.color = _loc_2[1];
            }
            else if (this.pknum >= 24 && this.pknum < 120)
            {
                this.color = _loc_2[2];
            }
            else if (this.pknum >= 120)
            {
                this.color = _loc_2[3];
            }
            return;
        }// end function

        public function get pkcolor() : int
        {
            return this.color;
        }// end function

        public function addpk() : void
        {
            return;
        }// end function

        public function pkchange(param1:Boolean = true) : void
        {
            if (param1)
            {
                this._modePBL.selectedIndex = 1;
                Config.player.pkState = 3;
                this.mustpk = true;
                this._modePBL.enabled = false;
            }
            else
            {
                switch(this.type)
                {
                    case 0:
                    {
                        this._modePBL.selectedIndex = 0;
                        break;
                    }
                    case 3:
                    {
                        this._modePBL.selectedIndex = 1;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                Config.player.pkState = this.type;
                this.mustpk = false;
                this._modePBL.enabled = true;
            }
            return;
        }// end function

        public function get warStatus() : Boolean
        {
            return this._warStatus;
        }// end function

        public function set warStatus(param1:Boolean) : void
        {
            this._warStatus = param1;
            return;
        }// end function

        private function enterWar(event:SocketEvent) : void
        {
            this.warStatus = true;
            return;
        }// end function

        private function leaveWar(event:SocketEvent) : void
        {
            this.warStatus = false;
            return;
        }// end function

    }
}
