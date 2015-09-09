package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class Transport extends Window
    {
        private var canv:CanvasUI;
        private var txtrans:Label;
        private var txrober:Label;
        private var _npcid:int;
        private var taskId:int = 0;
        private var _pushbtn40:PushButton;
        private var bitarr:Array;

        public function Transport(param1:DisplayObjectContainer = null)
        {
            this.bitarr = [];
            super(param1);
            resize(620, 360);
            this.initpanel();
            return;
        }// end function

        override public function testGuide()
        {
            if (GuideUI.testId(69) && this._pushbtn40 != null)
            {
                GuideUI.doId(69, this._pushbtn40);
            }
            else if (GuideUI.testId(71) && this._pushbtn40 != null)
            {
                GuideUI.doId(71, this._pushbtn40);
            }
            return;
        }// end function

        private function initpanel()
        {
            this.title = Config.language("Transport", 1);
            this.txtrans = new Label(this, 10, 30);
            this.txrober = new Label(this, 280, 30);
            var _loc_1:* = new Label(this, 10, 50, Config.language("Transport", 2));
            this.canv = new CanvasUI(this, 10, 80, 600, 270);
            this.addChild(this.canv);
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            if (Config.ver_yabiao)
            {
                this._npcid = 0;
                this.addlistlv();
                super.open();
            }
            else
            {
                Config.message(Config.language("Transport", 17));
            }
            return;
        }// end function

        private function openthis(event:TextEvent) : void
        {
            if (Config.ver_yabiao)
            {
                Config.ui._dialogue.closedialogue();
                this.addlistlv();
                super.open();
            }
            else
            {
                Config.message(Config.language("Transport", 17));
            }
            return;
        }// end function

        public function transpNpcTalk(param1:int, param2:Array, param3:Function = null) : void
        {
            param2.push({label:Config.language("Transport", 1), handler:this.openthis, closeflag:true});
            this._npcid = param1;
            trace(this._npcid);
            return;
        }// end function

        private function addlistlv()
        {
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_1:* = new Array();
            this._pushbtn40 = null;
            this.canv.removeAllChildren();
            var _loc_2:* = 0;
            while (_loc_2 < this.bitarr.length)
            {
                
                if (this.bitarr[_loc_2].hasOwnProperty("bitmapData"))
                {
                    this.bitarr[_loc_2].bitmapData.dispose();
                }
                _loc_2++;
            }
            this.bitarr = [];
            this.txtrans.text = Config.language("Transport", 3) + Config.player.escortra;
            this.txrober.text = Config.language("Transport", 4) + Config.player.escortrob;
            for (_loc_3 in Config._escortPanel)
            {
                
                if (Config.player.level >= Config._escortPanel[_loc_3].minlevel)
                {
                    _loc_6 = new Sprite();
                    _loc_6.x = 0;
                    _loc_6.graphics.beginFill(16777215, 0.3);
                    _loc_6.graphics.drawRoundRect(0, 0, 600, 100, 5);
                    _loc_6.graphics.beginFill(6710886, 0.3);
                    _loc_6.graphics.drawRoundRect(5, 10, 54, 54, 5);
                    _loc_1.push(_loc_6);
                    if (Config._escortPanel[_loc_3].targetNPC == this._npcid)
                    {
                        _loc_7 = new PushButton(_loc_6, 425, 35, Config.language("Transport", 5), this.autofindnpc);
                        this.taskId = _loc_3;
                    }
                    else
                    {
                        _loc_7 = new PushButton(_loc_6, 425, 35, Config.language("Transport", 6), this.autofindnpc);
                    }
                    if (Config._escortPanel[_loc_3].minlevel == 40)
                    {
                        this._pushbtn40 = _loc_7;
                    }
                    _loc_7.width = 70;
                    _loc_7.data = Config._escortPanel[_loc_3].targetNPC;
                    _loc_8 = new PushButton(_loc_6, 505, 35, Config.language("Transport", 7), this.lookmap);
                    _loc_8.width = 70;
                    _loc_8.data = Config._escortPanel[_loc_3].minlevel;
                    _loc_9 = new Bitmap();
                    _loc_6.addChild(_loc_9);
                    _loc_9.x = 5;
                    _loc_9.y = 10;
                    _loc_9.bitmapData = Config.findsysUI("acitve/" + Config._escortPanel[_loc_3].icon, 54, 54);
                    this.bitarr.push(_loc_9);
                    _loc_10 = new Label(_loc_6, 65, 5);
                    _loc_10.html = true;
                    _loc_10.text = "<font color=\'#0066ff\'>" + Config._escortPanel[_loc_3].name + "</font>";
                    _loc_11 = new Label(_loc_6, 260, 5, Config._escortPanel[_loc_3].reward);
                    _loc_12 = new TextAreaUI(_loc_6, 65, 25, 160, 20);
                    _loc_12.text = DescriptionTranslate.translate(Config._escortPanel[_loc_3].describe);
                    _loc_12.autoHeight = true;
                    _loc_12.width = 350;
                }
            }
            _loc_4 = 0;
            _loc_5 = 0;
            while (_loc_5 < _loc_1.length)
            {
                
                _loc_1[_loc_1.length - _loc_5 - 1].y = _loc_4;
                this.canv.addChildUI(_loc_1[_loc_1.length - _loc_5 - 1]);
                _loc_4 = _loc_4 + 105;
                _loc_5++;
            }
            return;
        }// end function

        private function autofindnpc(event:MouseEvent)
        {
            var _loc_3:* = null;
            var _loc_2:* = int(event.currentTarget.data);
            if (_loc_2 == this._npcid && this.taskId != 0)
            {
                if (Config.player.pkState == 0)
                {
                    AlertUI.alert(Config.language("Transport", 8), Config.language("Transport", 9), [Config.language("Transport", 10), Config.language("Transport", 11)], [this.sendecord], {_npcid:this._npcid});
                    return;
                }
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_ESCORT_ACCEPT_MISSION);
                _loc_3.add32(this.taskId);
                _loc_3.add32(Npc._idIndexMap[this._npcid]);
                ClientSocket.send(_loc_3);
            }
            else if (_loc_2 > 0)
            {
                Config.ui._zoommap.moveFly(DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_NPC, _loc_2), _loc_2);
                Config.ui._taskpanel.setMapNext(1, _loc_2);
            }
            else
            {
                AlertUI.alert(Config.language("ZoomMap", 13), Config.language("ZoomMap", 16), [Config.language("ZoomMap", 15)]);
            }
            return;
        }// end function

        private function sendecord(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_ESCORT_ACCEPT_MISSION);
            _loc_2.add32(this.taskId);
            _loc_2.add32(Npc._idIndexMap[param1._npcid]);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function lookmap(event:MouseEvent)
        {
            var _loc_2:* = String(event.currentTarget.data);
            if (_loc_2 == "90")
            {
                _loc_2 = "80";
            }
            Config.ui._lookmapanel.lookmap(_loc_2);
            return;
        }// end function

        public function onlineaddevent(param1:int)
        {
            this.addevent();
            Config.ui._radar.addlookmapBtn(String((param1 + 3) * 10));
            return;
        }// end function

        public function addevent()
        {
            Config.player.removeEventListener("update", this.updateescortstatus);
            Config.player.addEventListener("update", this.updateescortstatus);
            return;
        }// end function

        public function alertinfor(param1:int)
        {
            var _loc_2:* = new Label();
            _loc_2.mouseEnabled = true;
            _loc_2.html = true;
            AlertUI.alert(Config.language("Transport", 13), "", [Config.language("Transport", 10)], null, null, false, true, false, _loc_2);
            if (param1 == 1015)
            {
                _loc_2.text = Config.language("Transport", 14);
            }
            else if (param1 == 1016)
            {
                _loc_2.text = Config.language("Transport", 15);
            }
            else if (param1 == 1017)
            {
                _loc_2.text = Config.language("Transport", 16);
            }
            _loc_2.tf.addEventListener(TextEvent.LINK, this.txtlink);
            return;
        }// end function

        private function txtlink(param1)
        {
            Config.ui._mailpanel.openMail(2);
            return;
        }// end function

        private function updateescortstatus(event:UnitEvent = null) : void
        {
            if (event.param == "escortentryId")
            {
                if (Config.player.escortentryId == 0)
                {
                    Config.player.removeEventListener("update", this.updateescortstatus);
                    Config.ui._radar.remlookmapBtn();
                }
                else
                {
                    Config.ui._radar.addlookmapBtn(String((Config.player.escortentryId + 3) * 10));
                }
            }
            return;
        }// end function

        private function removechild(param1:Sprite)
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

    }
}
