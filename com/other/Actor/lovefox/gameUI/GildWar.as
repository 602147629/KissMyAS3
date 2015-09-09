package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class GildWar extends Sprite
    {
        private var heachlist:Array;
        private var mywarplist:Array;
        private var _layer:Sprite;
        private var taxlvtext:Label;
        private var taxuptext:Label;
        private var taxmontext:Label;
        private var deflvtext:Label;
        private var defuptext:Label;
        private var defmontext:Label;
        private var listdata:DataGridUI;
        private var tflag:int = 0;
        private var npcpotobj:Object;

        public function GildWar(param1:Sprite)
        {
            this.npcpotobj = {};
            this._layer = param1;
            this.initpanel();
            this.initsocket();
            return;
        }// end function

        private function initpanel() : void
        {
            this.taxlvtext = new Label(null, 90, 20, "0");
            this.taxlvtext.textColor = 16777215;
            this.taxuptext = new Label(null, 90, 40, "0");
            this.taxuptext.textColor = 16777215;
            this.taxmontext = new Label(null, 150, 60, "0");
            this.taxmontext.textColor = 16777215;
            this.deflvtext = new Label(null, 90, 20, "0");
            this.deflvtext.textColor = 16777215;
            this.defuptext = new Label(null, 90, 40, "0");
            this.defuptext.textColor = 16777215;
            this.defmontext = new Label(null, 150, 60, "0");
            this.defmontext.textColor = 16777215;
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BEACHHEAD_OWNER_LIST, this.backallheachlist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BEACHHEAD_AUCTION_LIST, this.backauctionlist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BEACHHEAD_AUCTION_UPDATE, this.updateauctiongild);
            return;
        }// end function

        private function sendheachlist() : void
        {
            return;
        }// end function

        private function backheachlist(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            this.heachlist = new Array();
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.id = _loc_2.readUnsignedInt();
                _loc_5.taxlevel = _loc_2.readUnsignedInt();
                _loc_5.deflevel = _loc_2.readUnsignedInt();
                _loc_5.taxpoint = _loc_2.readUnsignedInt();
                _loc_5.dexpoint = _loc_2.readUnsignedInt();
                this.heachlist.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        private function sendheach(param1:int) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_GET_HEACHHEAD_INFO);
            _loc_2.add32(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backheach(event:SocketEvent) : void
        {
            var _loc_10:* = NaN;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedInt();
            var _loc_6:* = _loc_2.readUnsignedInt();
            var _loc_7:* = _loc_2.readUnsignedInt();
            var _loc_8:* = _loc_2.readUnsignedInt();
            var _loc_9:* = _loc_2.readUnsignedInt();
            this.taxlvtext.text = String(_loc_4);
            this.deflvtext.text = String(_loc_5);
            _loc_10 = int(Config._locaTions[1].point1);
            if (_loc_4 < 10)
            {
                _loc_11 = 0;
                while (_loc_11 < _loc_8)
                {
                    
                    _loc_10 = _loc_10 * 2;
                    _loc_11 = _loc_11 + 1;
                }
                this.taxuptext.text = _loc_6 + "/" + Config._locaTions[2]["tax" + int((_loc_4 + 1))];
                this.taxmontext.text = String(_loc_10);
            }
            else
            {
                this.taxuptext.text = Config.language("GildWar", 1);
                this.taxmontext.text = "";
            }
            _loc_10 = int(Config._locaTions[1].point1);
            if (_loc_5 < 10)
            {
                _loc_12 = 0;
                while (_loc_12 < _loc_9)
                {
                    
                    _loc_10 = _loc_10 * 2;
                    _loc_12 = _loc_12 + 1;
                }
                this.defuptext.text = _loc_7 + "/" + Config._locaTions[2]["def" + int((_loc_5 + 1))];
                this.defmontext.text = String(_loc_10);
            }
            else
            {
                this.defuptext.text = Config.language("GildWar", 1);
                this.defmontext.text = "";
            }
            return;
        }// end function

        public function npcTalk(param1:int, param2:Array, param3:Function = null) : void
        {
            param2.push({label:Config.language("GildWar", 2), handler:this.gildwarauction, closeflag:true});
            return;
        }// end function

        private function inradmap(event:TextEvent, param2:Object, param3:int) : void
        {
            AlertUI.alert(Config.language("GildWar", 3), Config.language("GildWar", 4), [Config.language("GildWar", 5), Config.language("GildWar", 6)], [param2.handler]);
            return;
        }// end function

        private function getwarplist(event:TextEvent, param2:int) : void
        {
            if (Config.ui._gangs.mytype != 1)
            {
                AlertUI.alert(Config.language("GildWar", 3), Config.language("GildWar", 7), [Config.language("GildWar", 5)]);
                return;
            }
            this.tflag = param2;
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.CMSG_GET_HEACHHEAD_LIST);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function backwarplist(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            this.mywarplist = new Array();
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.id = _loc_2.readUnsignedInt();
                _loc_5.taxlevel = _loc_2.readUnsignedInt();
                _loc_5.deflevel = _loc_2.readUnsignedInt();
                _loc_5.taxpoint = _loc_2.readUnsignedInt();
                _loc_5.dexpoint = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedInt();
                this.mywarplist.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            this.showwarplist();
            return;
        }// end function

        private function showwarplist() : void
        {
            var _loc_1:* = [];
            var _loc_2:* = 0;
            while (_loc_2 < this.mywarplist.length)
            {
                
                if (this.tflag == 0)
                {
                    _loc_1.push({label:String(Config._warplist[this.mywarplist[_loc_2].id].name), handler:Config.create(this.tax, this.mywarplist[_loc_2].id)});
                }
                else
                {
                    _loc_1.push({label:String(Config._warplist[this.mywarplist[_loc_2].id].name), handler:Config.create(this.defense, this.mywarplist[_loc_2].id)});
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this.mywarplist.length > 0)
            {
            }
            return;
        }// end function

        private function tax(event:TextEvent, param2:int) : void
        {
            return;
        }// end function

        private function defense(event:TextEvent, param2:int) : void
        {
            return;
        }// end function

        public function gildwarauction(event:TextEvent = null)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_BEACHHEAD_AUCTION_LIST);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function gildwarinstruction(event:TextEvent = null)
        {
            Config.ui._gildWarStraction.open();
            return;
        }// end function

        private function backauctionlist(event:SocketEvent)
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            this.heachlist = new Array();
            this.npcpotobj = new Object();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.id = _loc_2.readUnsignedInt();
                _loc_5.gildid = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedShort();
                _loc_5.gildname = _loc_2.readUTFBytes(_loc_6);
                _loc_5.ifauciton = _loc_2.readByte();
                _loc_5.auctiongildid = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedShort();
                _loc_5.auctiongildname = _loc_2.readUTFBytes(_loc_7);
                _loc_5.i = _loc_4 + 1;
                _loc_5.name = String(Config._warplist[_loc_5.id].name);
                _loc_5.auctionprice = _loc_2.readUnsignedInt();
                _loc_5.gildwaror = _loc_2.readByte();
                this.heachlist.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            Config.ui._gildwarauction.open();
            Config.ui._gildwarauction.getgildname(this.heachlist);
            return;
        }// end function

        private function updateauctiongild(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = new Object();
            _loc_3.id = _loc_2.readUnsignedInt();
            _loc_3.gildid = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            _loc_3.gildname = _loc_2.readUTFBytes(_loc_4);
            _loc_3.ifauciton = _loc_2.readByte();
            _loc_3.auctiongildid = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedShort();
            _loc_3.auctiongildname = _loc_2.readUTFBytes(_loc_5);
            _loc_3.name = String(Config._warplist[_loc_3.id].name);
            _loc_3.auctionprice = _loc_2.readUnsignedInt();
            _loc_3.gildwaror = _loc_2.readByte();
            Config.ui._gildwarauction.updatelist(_loc_3);
            return;
        }// end function

        public function getheachlist() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_BEACHHEAD_OWNER_LIST);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function backallheachlist(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            this.heachlist = new Array();
            var _loc_2:* = event.data;
            trace(_loc_2.length, "bytes.length+++++++");
            var _loc_3:* = _loc_2.readUnsignedShort();
            this.npcpotobj = new Object();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.id = _loc_2.readUnsignedInt();
                _loc_5.gildid = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedShort();
                _loc_5.gildname = _loc_2.readUTFBytes(_loc_6);
                _loc_5.i = _loc_4 + 1;
                if (Config._warplist[_loc_5.id].name != null)
                {
                    _loc_5.name = String(Config._warplist[_loc_5.id].name);
                }
                else
                {
                    _loc_5.name = "";
                }
                this.heachlist.push(_loc_5);
                if (_loc_5.gildid != 0)
                {
                    this.npcpotobj[Config._warplist[_loc_5.id].npc] = _loc_5;
                    _loc_7 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_NPC, Npc._idIndexMap[Config._warplist[_loc_5.id].npc]);
                    if (_loc_7 != null)
                    {
                        _loc_7.title = _loc_5.gildname;
                    }
                }
                _loc_4 = _loc_4 + 1;
            }
            if (this.listdata != null)
            {
                this.listdata.dataProvider = this.heachlist;
            }
            return;
        }// end function

        private function buypoint(event:MouseEvent, param2:int, param3:int) : void
        {
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.CMSG_HEACHHEAD_EXP_ADD);
            _loc_4.add32(param3);
            _loc_4.add8(param2);
            _loc_4.add32(1);
            ClientSocket.send(_loc_4);
            return;
        }// end function

        private function expadd(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readByte();
            var _loc_5:* = _loc_2.readByte();
            if (_loc_2.readByte() == 0)
            {
                if (_loc_4 == 0)
                {
                }
            }
            else
            {
                Config.message(Config.language("GildWar", 8));
            }
            return;
        }// end function

        public function npctitle(param1:Npc) : void
        {
            if (this.npcpotobj[param1._data.id] != null)
            {
                param1.title = Config.language("GildWar", 9) + "[" + this.npcpotobj[param1._data.id].gildname + "]";
            }
            return;
        }// end function

    }
}
