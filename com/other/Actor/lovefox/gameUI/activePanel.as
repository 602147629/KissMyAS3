package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.gui.*;
    import lovefox.socket.*;

    public class activePanel extends Window
    {
        private var main:CanvasUI;
        private var bitarr:Array;
        private var infowindow:Window;
        private var info:TextAreaUI;
        private var _btn11:PushButton;
        private var _btn10:PushButton;
        private var _btn18:PushButton;
        private var topbtn:ButtonBar;
        private var _lab:Label;
        private var _value:int;
        private var _flag:uint;
        private var _bitArr:Array;
        private var _filters:Array;
        private var _lineBtndown:PushButton;
        private var _nowracetimes:uint;
        private var _getcount:int = 0;
        private var _getallcount:Object = 0;
        private var _buttonGClips:Array;
        private var _preSelPage:int = -1;

        public function activePanel(param1:DisplayObjectContainer = null)
        {
            this.bitarr = [];
            this._bitArr = new Array();
            this._buttonGClips = [];
            super(param1);
            this.initpanel();
            return;
        }// end function

        override public function testGuide()
        {
            if (GuideUI.testId(68) && this._btn11 != null)
            {
                this.main.verticalScrollPosition = 0;
                GuideUI.doId(68, this._btn11);
            }
            else if (GuideUI.testId(122) && this._btn10 != null)
            {
                this.main.verticalScrollPosition = 0;
                GuideUI.doId(122, this._btn10);
            }
            return;
        }// end function

        private function initpanel() : void
        {
            resize(560, 340);
            this.title = Config.language("activePanel", 31);
            this._lab = new Label(this, 15, 30);
            this.topbtn = new ButtonBar(this, 15, 25, 0);
            this.topbtn.addTab(Config.language("activePanel", 26), Config.create(this.showPanel, 1));
            this.topbtn.addTab(Config.language("activePanel", 27), Config.create(this.showPanel, 2));
            this.topbtn.addTab(Config.language("activePanel", 28), Config.create(this.showPanel, 3));
            this.main = new CanvasUI(this, 20, 60, 525, 255);
            var _loc_2:* = new Window(Config.ui._layer1);
            this.infowindow = new Window(Config.ui._layer1);
            Config.ui._windowStack.push(_loc_2);
            this.infowindow.resize(250, 300);
            var _loc_1:* = new PushButton(this.infowindow, 90, 270, Config.language("activePanel", 22), this.closePanel);
            _loc_1.width = 60;
            this.info = new TextAreaUI(this.infowindow, 10, 25, 230, 230);
            this.info.autoHeight = true;
            this.info.textColor = Style.WINDOW_FONT;
            this._lineBtndown = new PushButton(this, 260, 320, "", this.changepage, Config.findUI("quickui").button3);
            this._lineBtndown.width = 40;
            this._lineBtndown.overshow = true;
            this._lineBtndown.visible = false;
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_CARENA_REG_APPLY, this.rebackerr);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_CARENA2_REG, this.rebackerr);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_CARENA2_CANCEL, this.rebackjionerr);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_CARENA_EVENT, this.stratend);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_TOP3_STATUS_PLR, this.playerstatus);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ACCGUARD_COUNT, this.getcount);
            this._filters = [new GlowFilter(0, 1, 2, 2, 1, 3, false)];
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            this.showPanel();
            super.open();
            this.title = Config.language("activePanel", 1);
            return;
        }// end function

        override public function close()
        {
            super.close();
            Config.ui._pkrace.close();
            return;
        }// end function

        override public function switchOpen() : void
        {
            if (this._preSelPage != 4)
            {
                super.switchOpen();
            }
            else
            {
                this.open();
            }
            return;
        }// end function

        public function opengiftdare() : void
        {
            if (this._preSelPage == 4)
            {
                super.switchOpen();
            }
            else
            {
                super.open();
            }
            if (this._opening)
            {
                this.showPanel(null, 4);
                this.topbtn.visible = false;
                this._lab.text = Config.language("activePanel", 29);
                this.title = Config.language("activePanel", 30);
            }
            this.testGuide();
            return;
        }// end function

        public function refresh() : void
        {
            if (this._opening)
            {
                this.showPanel(null, this._preSelPage);
            }
            return;
        }// end function

        public function showPanel(event:MouseEvent = null, param2:int = 1) : void
        {
            var loop:*;
            var m:*;
            var ss:uint;
            var _odarr:Array;
            var _k:uint;
            var strue:Boolean;
            var lev:int;
            var tcolor:int;
            var flagBt:Boolean;
            var flagwar:Boolean;
            var allday:Boolean;
            var titlestr:String;
            var sp:Sprite;
            var temb:Bitmap;
            var tempstr:String;
            var titlestrArr:Array;
            var l1:ClickLabel;
            var l11:PushButton;
            var l3:Label;
            var l4:Label;
            var tarr2:Array;
            var str:String;
            var l7:Label;
            var bitmap:Bitmap;
            var tarr:Array;
            var s:uint;
            var dayarr:Array;
            var daytrue:Boolean;
            var t:uint;
            var titlestr12:Label;
            var titlestr2:Label;
            var l2:Label;
            var _fl:Boolean;
            var temparr3:Array;
            var _m:*;
            var _start:int;
            var _end:int;
            var _da:String;
            var tarr3:Array;
            var start1:*;
            var end1:*;
            var start2:*;
            var end2:*;
            var start3:*;
            var end3:*;
            var _f:int;
            var dataSet:DataSet;
            var tempid:int;
            var tempc2:ClickLabel;
            var sp1:Sprite;
            var btn:PushButton;
            var _st:String;
            var btninfo:PushButton;
            var _jin:uint;
            var gclip:GClip;
            var btnjion:PushButton;
            var shopBtn:PushButton;
            var prizeBtn:PushButton;
            var event:* = event;
            var selpage:* = param2;
            this._preSelPage = selpage;
            if (this._preSelPage == 4 || this._preSelPage == 2)
            {
                this._lineBtndown.visible = true;
            }
            else
            {
                this._lineBtndown.visible = false;
            }
            this._btn10 = null;
            this._btn11 = null;
            this._btn18 = null;
            loop;
            while (loop < this._buttonGClips.length)
            {
                
                if (GClip(this._buttonGClips[loop]).parent != null)
                {
                    GClip(this._buttonGClips[loop]).parent.removeChild(GClip(this._buttonGClips[loop]));
                }
                GClip(this._buttonGClips[loop]).destroy();
                loop = (loop + 1);
            }
            this._buttonGClips = [];
            loop;
            while (loop < this._bitArr.length)
            {
                
                if (this._bitArr[loop].hasOwnProperty("bitmapData") != null)
                {
                    this._bitArr[loop].bitmapData.dispose();
                }
                loop = (loop + 1);
            }
            this._bitArr = [];
            this.main.removeAllChildren();
            var ypos:int;
            var tempdate:* = Config.now;
            var m_hour:* = tempdate.getHours();
            var m_min:* = tempdate.getMinutes();
            var m_day:* = tempdate.getDay();
            var m_date:* = tempdate.getDate();
            var m_year:* = tempdate.getFullYear();
            var m_month:* = tempdate.getMonth();
            var temparr:* = new Array();
            var temparr2:* = new Array();
            var _order:int;
            this.topbtn.visible = true;
            this._lab.text = "";
            if (selpage < 4)
            {
                this.topbtn.selectpage = selpage - 1;
            }
            var f:int;
            while (f < this.bitarr.length)
            {
                
                if (this.bitarr[f].hasOwnProperty("bitmapData"))
                {
                    this.bitarr[f].bitmapData.dispose();
                }
                f = (f + 1);
            }
            var _loc_4:* = 0;
            var _loc_5:* = Config._activMap;
            while (_loc_5 in _loc_4)
            {
                
                m = _loc_5[_loc_4];
                if (m == 10 && !Config.ver_emo)
                {
                    continue;
                }
                if (m == 13 && !Config.ver_kongju)
                {
                    continue;
                }
                if (m == 11 && !Config.ver_yabiao)
                {
                    continue;
                }
                if (selpage != int(Config._activMap[m].type))
                {
                    continue;
                }
                _order = int(Config._activMap[m].order);
                if (int(Config._activMap[m].type) == 2)
                {
                    _odarr = Config._activMap[m].openDay.split("<br/>");
                    _k;
                    while (_k < _odarr.length)
                    {
                        
                        if (_odarr[_k] == m_day)
                        {
                            _order;
                        }
                        _k = (_k + 1);
                    }
                }
                temparr2.push({id:m, order:_order});
            }
            temparr2.sortOn("order", Array.NUMERIC);
            ss;
            while (ss < temparr2.length)
            {
                
                temparr.push(temparr2[ss].id);
                ss = (ss + 1);
            }
            var j:uint;
            while (j < temparr.length)
            {
                
                strue;
                lev;
                if (Config.player != null)
                {
                    lev = Config.player.level;
                }
                tcolor;
                if (lev < int(Config._activMap[temparr[j]].reLevel))
                {
                    tcolor;
                }
                flagBt;
                flagwar;
                allday;
                try
                {
                    tarr = Config._activMap[temparr[j]].openTime.split("<br/>");
                    if (Config._activMap[temparr[j]].openTime == "00:00 – 24:00" || lev < int(Config._activMap[temparr[j]].reLevel))
                    {
                        allday;
                    }
                    s;
                    while (s < tarr.length)
                    {
                        
                        if (int(tarr[s].split("–")[0].split(":")[0]) < m_hour || int(tarr[s].split("–")[0].split(":")[0]) == m_hour && int(tarr[s].split("–")[0].split(":")[1]) <= m_min)
                        {
                            if (int(tarr[s].split("–")[1].split(":")[0]) > m_hour || int(tarr[s].split("–")[1].split(":")[0]) == m_hour && int(tarr[s].split("–")[1].split(":")[1]) > m_min)
                            {
                                tcolor;
                                dayarr = Config._activMap[temparr[j]].openDay.split("<br/>");
                                daytrue;
                                t;
                                while (t < dayarr.length)
                                {
                                    
                                    if (int(dayarr[t]) == m_day || int(dayarr[t]) == 8)
                                    {
                                        daytrue;
                                        break;
                                    }
                                    t = (t + 1);
                                }
                                if (!daytrue)
                                {
                                    tcolor;
                                }
                                if (int(Config._activMap[temparr[j]].id) == 9)
                                {
                                    if (s % 2 == 0)
                                    {
                                        flagBt;
                                    }
                                    else
                                    {
                                        flagBt;
                                    }
                                }
                                if (int(Config._activMap[temparr[j]].id) == 14)
                                {
                                    if (s % 2 == 0)
                                    {
                                        flagwar;
                                    }
                                    else
                                    {
                                        flagwar;
                                    }
                                }
                            }
                        }
                        s = (s + 1);
                    }
                }
                catch (e:Error)
                {
                    Config.message(Config.language("TaskPanel", 48));
                }
                titlestr = Config._activMap[temparr[j]].name;
                sp = new Sprite();
                sp.graphics.beginFill(16777215, 0);
                sp.graphics.drawRoundRect(0, 0, 251, 124, 5);
                sp.graphics.endFill();
                this.main.addChildUI(sp);
                if (j % 2 == 0)
                {
                    sp.x = 0;
                }
                else
                {
                    sp.x = 259;
                }
                sp.y = int(j / 2) * 130;
                ypos = ypos + 10;
                temb = new Bitmap();
                sp.addChild(temb);
                temb.x = 2;
                temb.y = 2;
                temb.filters = this._filters;
                temb.bitmapData = Config.findsysUI("poker/hdmb", 249, 120);
                this._bitArr.push(temb);
                tempstr = "<font color=\'" + Style.FONT_Yellow + "\'>" + Config._activMap[temparr[j]].name + "</font>\n" + Config._activMap[temparr[j]].infor;
                sp.addEventListener(MouseEvent.ROLL_OUT, this.handleActiveOut);
                titlestrArr = titlestr.split("<br/>");
                l1 = new ClickLabel(sp, 65, 5, "", Config.create(this.handleActiveOver, tempstr));
                l1.text = "<font size=\'14\'>" + titlestrArr[0] + "</font>";
                l1.clickColor([26367, 6837142]);
                if (Config._activMap[temparr[j]].id == 19)
                {
                    titlestr12 = new Label(sp, 125, 5);
                    titlestr12.html = true;
                    titlestr12.textColor = Style.FONT_5int_Green;
                    titlestr12.text = "(" + (1 - Config.ui._sellCultivation.count) + "/1)";
                }
                if (Config._activMap[temparr[j]].id == 21)
                {
                    if (Config.player.level >= Config._activMap[temparr[j]].reLevel)
                    {
                        titlestr12 = new Label(sp, 140, 6);
                        titlestr12.html = true;
                        titlestr12.textColor = Style.FONT_5int_Green;
                        titlestr12.text = "(" + (this.get_allcount - this.get_count) + "/" + this.get_allcount + ")";
                    }
                }
                if (titlestrArr.length > 1)
                {
                    titlestr2 = new Label(sp, 65, 20, titlestrArr[1]);
                    titlestr2.textColor = 6710886;
                }
                l11 = new PushButton(sp, 8, 70, Config.language("activePanel", 21), Config.create(this.openInfoPanel, Config._activMap[temparr[j]].name, Config._activMap[temparr[j]].infor));
                l11.width = 52;
                l11.setTable("table18", "table31");
                l11.textColor = Style.GOLD_FONT;
                l11.color = 16777215;
                if (lev < int(Config._activMap[temparr[j]].reLevel))
                {
                    l2 = new Label(sp, 160, 5, Config.language("activePanel", 2, Config._activMap[temparr[j]].reLevel));
                    l2.textColor = tcolor;
                }
                l3 = new Label(sp, 65, 55, Config._activMap[temparr[j]].award);
                l4 = new Label(sp, 65, 75, Config.language("activePanel", 3, " "));
                l4.html = true;
                tarr2 = Config._activMap[temparr[j]].showDay.split("<br/>");
                str;
                ss;
                while (ss < tarr2.length)
                {
                    
                    str = str + (tarr2[ss] + " ");
                    if ((ss + 1) % 2 == 0 && ss != 0)
                    {
                        str = str + "<br/>";
                    }
                    ss = (ss + 1);
                }
                if (int(Config._activMap[temparr[j]].id) == 18)
                {
                    _fl;
                    temparr3 = new Array();
                    var _loc_4:* = 0;
                    var _loc_5:* = Config._actEvent;
                    while (_loc_5 in _loc_4)
                    {
                        
                        _m = _loc_5[_loc_4];
                        _start = Config._actEvent[_m].startEvent;
                        _end = Config._actEvent[_m].endEvent;
                        _da = Config._actEvent[_m].date_s;
                        if (_start != 0 || _end != 0)
                        {
                            tarr3 = _da.split("-");
                            if (tarr3.length >= 3)
                            {
                                if (parseInt(tarr3[0]) != m_year || parseInt(tarr3[1]) != (m_month + 1))
                                {
                                    tcolor;
                                    _fl;
                                    break;
                                }
                                temparr3.push({start:_start, end:_end, dat:tarr3[2]});
                            }
                        }
                    }
                    if (!_fl)
                    {
                        _f;
                        while (_f < temparr3.length)
                        {
                            
                            if (temparr3[_f].start == 1)
                            {
                                start1 = temparr3[_f].dat;
                            }
                            if (temparr3[_f].end == 1)
                            {
                                end1 = temparr3[_f].dat;
                            }
                            if (temparr3[_f].start == 2)
                            {
                                start2 = temparr3[_f].dat;
                            }
                            if (temparr3[_f].end == 2)
                            {
                                end2 = temparr3[_f].dat;
                            }
                            if (temparr3[_f].start == 3)
                            {
                                start3 = temparr3[_f].dat;
                            }
                            if (temparr3[_f].end == 3)
                            {
                                end3 = temparr3[_f].dat;
                            }
                            _f = (_f + 1);
                        }
                        if (m_date >= start1 && m_date <= end1)
                        {
                            trace("第一周活动时间");
                            if (Config.player.level >= 90)
                            {
                                l1.text = Config.language("activePanel", 32, titlestrArr[0]);
                            }
                            this._flag = 1;
                        }
                        else if (m_date >= start2 && m_date <= end2)
                        {
                            trace("第二周活动时间", tcolor);
                            Config.ui._serveracebill.send20list();
                            if (Config.player.level >= 90)
                            {
                                l1.text = Config.language("activePanel", 33, titlestrArr[0]);
                            }
                            if (this._flag < 4)
                            {
                                this._flag = 2;
                            }
                        }
                        else if (m_date >= start3 && m_date <= end3)
                        {
                            trace("第三周活动时间");
                            dataSet = new DataSet();
                            dataSet.addHead(CONST_ENUM.C2B_TOP3_STATUS_PLR);
                            ClientSocket.send(dataSet);
                            if (Config.player.level >= 90)
                            {
                                l1.text = Config.language("activePanel", 34, titlestrArr[0]);
                            }
                            this._flag = 3;
                        }
                        else
                        {
                            tcolor;
                            str = Config.language("activePanel", 35);
                        }
                    }
                }
                l7 = new Label(sp, 100, 75, str);
                l7.html = true;
                if (tcolor == 39168)
                {
                    tempid = int(Config._activMap[temparr[j]].id);
                    if (tempid == 5)
                    {
                        tempc2 = new ClickLabel(sp, 65, 28, Config._activMap[temparr[j]].npcName, Config.create(this.findNPC, Config._activMap[temparr[j]].npcId), true);
                        tempc2.clickColor([26367, 6837142]);
                        sp1 = this.getFlyBtn(Config._activMap[temparr[j]].npcId);
                        sp1.x = tempc2.x + tempc2.width + 5;
                        sp1.y = ypos + 25;
                        this.main.addChildUI(sp1);
                    }
                    else
                    {
                        if (tempid == 9 && flagBt)
                        {
                            btn = new PushButton(sp, 65, 28, Config.language("activePanel", 16), this.racejionFuc);
                        }
                        else if (tempid == 14 && flagwar)
                        {
                            btn = new PushButton(sp, 65, 28, Config.language("activePanel", 16), this.interwarjion);
                            if (m_hour == 19 && m_min > 0)
                            {
                                btn.label = Config.language("activePanel", 23);
                            }
                        }
                        else
                        {
                            if (tempid == 9)
                            {
                                btninfo = new PushButton(sp, 8, 100, Config.language("activePanel", 17), this.sendrequestInfo);
                                btninfo.setTable("table18", "table31");
                                btninfo.textColor = Style.GOLD_FONT;
                                btninfo.overshow = true;
                                btninfo.width = 52;
                            }
                            _st = Config._activMap[temparr[j]].buttonName;
                            if (tempid == 18)
                            {
                                if (this._flag == 1 || this._flag == 2)
                                {
                                    _jin = Config.ui._serveracebill.jionorin;
                                    if (_jin == 0)
                                    {
                                        _st = Config.language("activePanel", 36, this.jionnumber);
                                    }
                                    else if (_jin == 1)
                                    {
                                        _st = Config.language("activePanel", 37);
                                    }
                                    else if (_jin == 2)
                                    {
                                        _st = Config.language("activePanel", 38);
                                    }
                                    else if (_jin == 3)
                                    {
                                        if (Config.map._type == 24)
                                        {
                                            _st = Config.language("activePanel", 39);
                                        }
                                    }
                                }
                                else if (this._flag == 3)
                                {
                                    _jin = Config.ui._serveracebill.jionorin;
                                    if (_jin == 0)
                                    {
                                        _st = Config.language("activePanel", 40);
                                    }
                                    else if (_jin == 1)
                                    {
                                        _st = Config.language("activePanel", 37);
                                    }
                                    else if (_jin == 3)
                                    {
                                        if (Config.map._type == 24)
                                        {
                                            _st = Config.language("activePanel", 39);
                                        }
                                    }
                                    else if (_jin == 5)
                                    {
                                        _st = Config.language("activePanel", 41);
                                    }
                                    else
                                    {
                                        _st = Config.language("activePanel", 42);
                                    }
                                }
                            }
                            btn = new PushButton(sp, 65, 28, _st, Config.create(this.activeFuc, tempid, Config._activMap[temparr[j]].name, Config._activMap[temparr[j]].award));
                            if (tempid == 11)
                            {
                                this._btn11 = btn;
                            }
                            else if (tempid == 16)
                            {
                                this._btn10 = btn;
                            }
                            else if (tempid == 18)
                            {
                                this._btn18 = btn;
                            }
                            if (!allday)
                            {
                                gclip = GClip.newGClip("buttonborder");
                                gclip.x = btn.x - 20;
                                gclip.y = btn.y - 21;
                                gclip.mouseChildren = false;
                                gclip.mouseEnabled = false;
                                sp.addChild(gclip);
                                this._buttonGClips.push(gclip);
                            }
                        }
                        btn.width = 80;
                        btn.setTable("table18", "table31");
                        btn.textColor = Style.GOLD_FONT;
                        btn.overshow = true;
                        if (Config.player.level < int(Config._activMap[temparr[j]].reLevel))
                        {
                            btn.enabled = false;
                        }
                        if (tempid == 18)
                        {
                            if (this._flag == 2 && !Config.ui._serveracebill.rightwo)
                            {
                                this.setwobtn18(false);
                            }
                            else if (this._flag == 3 && !Config.ui._serveracebill.rightwo)
                            {
                            }
                        }
                        if (tempid == 19)
                        {
                            if (Config.ui._sellCultivation.count <= 0)
                            {
                                btn.overshow = false;
                                btn.enabled = false;
                                btn.textColor = 10066329;
                            }
                        }
                    }
                }
                else if (int(Config._activMap[temparr[j]].id) == 1)
                {
                    btn = new PushButton(sp, 65, 28, Config._activMap[temparr[j]].buttonName, Config.create(this.activeFuc, int(Config._activMap[temparr[j]].id), Config._activMap[temparr[j]].name, Config._activMap[temparr[j]].award));
                    btn.width = 80;
                    btn.setTable("table18", "table31");
                    btn.textColor = Style.GOLD_FONT;
                    btn.overshow = true;
                    if (Config.player.level < 50)
                    {
                        btn.enabled = false;
                    }
                }
                else
                {
                    btnjion = new PushButton(sp, 65, 28, Config.language("activePanel", 5));
                    btnjion.setTable("table18", "table31");
                    btnjion.overshow = false;
                    btnjion.enabled = false;
                    btnjion.width = 80;
                }
                if (int(Config._activMap[temparr[j]].id) == 6)
                {
                    shopBtn = new PushButton(sp, 160, 28, Config.language("activePanel", 9), this.openShop);
                    shopBtn.width = 80;
                    shopBtn.setTable("table18", "table31");
                    shopBtn.textColor = Style.GOLD_FONT;
                    shopBtn.overshow = true;
                }
                if (int(Config._activMap[temparr[j]].id) == 9)
                {
                    shopBtn = new PushButton(sp, 160, 28, Config.language("activePanel", 19), this.openbillpan);
                    shopBtn.width = 80;
                    shopBtn.setTable("table18", "table31");
                    shopBtn.textColor = Style.GOLD_FONT;
                    shopBtn.overshow = true;
                }
                if (int(Config._activMap[temparr[j]].id) == 12)
                {
                    shopBtn = new PushButton(sp, 160, 28, Config.language("activePanel", 20), this.openLandList);
                    shopBtn.width = 80;
                    shopBtn.setTable("table18", "table31");
                    shopBtn.textColor = Style.GOLD_FONT;
                    shopBtn.overshow = true;
                }
                if (int(Config._activMap[temparr[j]].id) == 18)
                {
                    shopBtn = new PushButton(sp, 160, 28, Config.language("activePanel", 19), this.openracebill);
                    shopBtn.width = 80;
                    shopBtn.setTable("table18", "table31");
                    shopBtn.textColor = Style.GOLD_FONT;
                    shopBtn.overshow = true;
                }
                if (int(Config._activMap[temparr[j]].id) == 20)
                {
                    prizeBtn = new PushButton(sp, 160, 28, Config.language("activePanel", 57), this.seniorcopyprize);
                    prizeBtn.width = 80;
                    prizeBtn.setTable("table18", "table31");
                    if (Config.ui._seniorcopy.prizecount > 0 && Config.player.level >= 100 && Config.map._type != 25 && Config.ui._seniorcopy.floor > 0)
                    {
                        prizeBtn.textColor = Style.GOLD_FONT;
                        prizeBtn.overshow = true;
                    }
                    else
                    {
                        prizeBtn.overshow = false;
                        prizeBtn.enabled = false;
                        prizeBtn.mouseEnabled = true;
                        prizeBtn.buttonMode = false;
                        if (Config.map._type == 25)
                        {
                            prizeBtn.removeEventListener(MouseEvent.MOUSE_OVER, this.handleover);
                            prizeBtn.removeEventListener(MouseEvent.MOUSE_OUT, this.handleout);
                            prizeBtn.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
                            prizeBtn.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
                            prizeBtn.name = String(1);
                        }
                        else if (Config.ui._seniorcopy.prizecount == 0 && Config.player.level >= 100)
                        {
                            prizeBtn.removeEventListener(MouseEvent.MOUSE_OVER, this.handleover);
                            prizeBtn.removeEventListener(MouseEvent.MOUSE_OUT, this.handleout);
                            prizeBtn.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
                            prizeBtn.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
                            prizeBtn.name = String(2);
                        }
                        else if (Config.ui._seniorcopy.floor == 0 && Config.player.level >= 100)
                        {
                            prizeBtn.removeEventListener(MouseEvent.MOUSE_OVER, this.handleover);
                            prizeBtn.removeEventListener(MouseEvent.MOUSE_OUT, this.handleout);
                            prizeBtn.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
                            prizeBtn.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
                            prizeBtn.name = String(3);
                        }
                        else
                        {
                            prizeBtn.removeEventListener(MouseEvent.MOUSE_OVER, this.handleover);
                            prizeBtn.name = String(0);
                        }
                    }
                }
                if (int(Config._activMap[temparr[j]].id) == 22)
                {
                    prizeBtn = new PushButton(sp, 160, 28, Config.language("activePanel", 64), this.toairprize);
                    prizeBtn.width = 80;
                    prizeBtn.setTable("table18", "table31");
                    if (Config.player.level >= 100)
                    {
                        prizeBtn.textColor = Style.GOLD_FONT;
                        prizeBtn.overshow = true;
                    }
                    else
                    {
                        prizeBtn.overshow = false;
                        prizeBtn.enabled = false;
                        prizeBtn.mouseEnabled = true;
                        prizeBtn.buttonMode = false;
                    }
                }
                l3.textColor = tcolor;
                l4.textColor = tcolor;
                l7.textColor = tcolor;
                ypos = ypos + 130;
                bitmap = new Bitmap();
                sp.addChild(bitmap);
                bitmap.x = 8;
                bitmap.y = 8;
                bitmap.bitmapData = Config.findsysUI("acitve/" + Config._activMap[temparr[j]].icon, 54, 54);
                this.bitarr.push(bitmap);
                j = (j + 1);
            }
            return;
        }// end function

        private function racejionFuc(event:MouseEvent)
        {
            if (Config.player.level >= 40)
            {
                Config.ui._pkrace.sendnosign();
            }
            else
            {
                Config.message(Config.language("activePanel", 18));
            }
            return;
        }// end function

        private function interwarjion(event:MouseEvent)
        {
            trace(Config.ui._gangs.gildlv, Config.ui._gangs.gildid);
            if (Config.ui._gangs.gildlv == 0)
            {
                Config.message(Config.language("activePanel", 24));
            }
            else if (Config.ui._gangs.gildlv < 5)
            {
                Config.message(Config.language("activePanel", 25));
            }
            else
            {
                Config.ui._interBigwar.openwarpanel();
            }
            return;
        }// end function

        private function sendrequestInfo(param1)
        {
            Config.ui._pkraceinfo.sendInfo();
            return;
        }// end function

        private function seniorcopyprize(event:MouseEvent) : void
        {
            if (event.currentTarget.enabled)
            {
                Config.ui._seniorcopy.prizealert();
            }
            return;
        }// end function

        private function toairprize(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (event.currentTarget.enabled)
            {
                _loc_2 = Config.ui._manyplayertoair.passhfloor;
                if (_loc_2 > 0)
                {
                    _loc_3 = Config.language("activePanel", 65, _loc_2);
                    if (int(Config._crowdskytower[_loc_2].perDayAwardNumber1) != 0)
                    {
                        _loc_3 = _loc_3 + Config.language("activePanel", 66, Config._crowdskytower[_loc_2].perDayAwardNumber1);
                    }
                    if (int(Config._crowdskytower[_loc_2].perDayAwardNumber2) != 0)
                    {
                        _loc_3 = _loc_3 + Config.language("activePanel", 67, Config._crowdskytower[_loc_2].perDayAwardNumber2);
                    }
                    if (int(Config._crowdskytower[_loc_2].perDayAwardItemNumber) != 0)
                    {
                        _loc_3 = _loc_3 + ("\n                    <font color=\'#ad1b2e\'>" + Config._itemMap[Config._crowdskytower[_loc_2].perDayAwardItemId].name + "</font> *<font color=\'#ad1b2e\'>" + Config._crowdskytower[_loc_2].perDayAwardItemNumber + "</font>");
                    }
                    _loc_3 = _loc_3 + Config.language("activePanel", 68);
                    AlertUI.alert(Config.language("SeniorCopy", 7), _loc_3, [Config.language("activePanel", 54), Config.language("activePanel", 22)], [this.sendprize]);
                }
                else
                {
                    Config.message(Config.language("activePanel", 69));
                }
            }
            return;
        }// end function

        private function sendprize(event:MouseEvent) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_MULTISKYTOWER_REWARD);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function handleActiveOver(param1, param2:String)
        {
            Holder.showInfo(param2, new Rectangle(Config.stage.mouseX, Config.stage.mouseY + 10), false, 1, 200);
            return;
        }// end function

        private function handleActiveOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function findNPC(event:TextEvent, param2:int) : void
        {
            Hang.hangNpc(int(param2));
            return;
        }// end function

        public function levelShow() : void
        {
            if (this._opening)
            {
                this.showPanel();
            }
            return;
        }// end function

        private function activeFuc(event:MouseEvent, param2:int, param3:String, param4:String) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            switch(param2)
            {
                case 1:
                case 2:
                case 4:
                case 7:
                case 8:
                {
                    _loc_5 = {};
                    _loc_5.id = param2;
                    AlertUI.alert(param3, "<font color=\'#cc0000\'>" + param3 + "</font>" + Config.language("activePanel", 6) + "<font color=\'#cc0000\'>" + param4 + "</font>", [Config.language("TaskPanel", 66), Config.language("TaskPanel", 67)], [this.checkFuc, null], _loc_5);
                    break;
                }
                case 6:
                {
                    Config.ui._bigWar.warLogin(param3, param4);
                    break;
                }
                case 9:
                {
                    Config.ui._pkrace.sendenterPkmap();
                    break;
                }
                case 11:
                {
                    Config.ui._transport.open();
                    break;
                }
                case 12:
                {
                    this.landGraveOpen();
                    break;
                }
                case 14:
                {
                    Config.ui._interBigwar.goininterwar();
                    break;
                }
                case 16:
                {
                    this.setToAir();
                    break;
                }
                case 17:
                {
                    Config.ui._giftDare.open();
                    break;
                }
                case 18:
                {
                    this.activeracebtn();
                    break;
                }
                case 19:
                {
                    if (Config.player.level >= 50)
                    {
                        this.sendenterrongyan();
                        this.close();
                        Config.ui._sellCultivation.cultivationfun();
                    }
                    break;
                }
                case 20:
                {
                    if (Config.map._type == 25)
                    {
                        Config.message(Config.language("activePanel", 58));
                    }
                    else if (Config.ui._seniorcopy.prizecount >= 1)
                    {
                        Config.ui._seniorcopy.openseniorcopy();
                    }
                    else
                    {
                        AlertUI.alert(Config.language("activePanel", 52), Config.language("activePanel", 59), [Config.language("activePanel", 54)]);
                    }
                    break;
                }
                case 21:
                {
                    _loc_6 = new DataSet();
                    _loc_6.addHead(CONST_ENUM.C2G_ENTER_ACCGUARD);
                    ClientSocket.send(_loc_6);
                    this.close();
                    break;
                }
                case 22:
                {
                    Config.ui._manyplayertoair.switchOpen();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function checkFuc(param1) : void
        {
            var _loc_2:* = null;
            switch(param1.id)
            {
                case 1:
                {
                    this.sendenterrongyan();
                    break;
                }
                case 2:
                {
                    Config.ui._wolfactive.sendeLitein();
                    break;
                }
                case 4:
                {
                    Config.ui._farmpanel.sendformin();
                    break;
                }
                case 7:
                {
                    Config.ui._radar.sendentermap();
                    break;
                }
                case 8:
                {
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2G_CANNON_IN);
                    ClientSocket.send(_loc_2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function sendenterrongyan() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_ENTER_UMAP);
            _loc_1.add32(int(Config._giftMap[489].id));
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function getFlyBtn(param1:int) : Sprite
        {
            var _loc_2:* = new Sprite();
            var _loc_3:* = new Bitmap();
            var _loc_4:* = Config.ui._mousepointer._cursorStack["jump"];
            _loc_3.bitmapData = _loc_4.bmpd;
            _loc_2.addChild(_loc_3);
            _loc_2.buttonMode = true;
            _loc_2.addEventListener(MouseEvent.CLICK, Config.create(this.flycheck, param1));
            _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.handleFlyOver);
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.handleFlyOut);
            return _loc_2;
        }// end function

        private function flycheck(event:MouseEvent, param2:int) : void
        {
            Config.ui._zoommap.flyMapAlert(DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_NPC, param2));
            return;
        }// end function

        private function handleFlyOver(param1)
        {
            var _loc_2:* = param1.currentTarget;
            var _loc_3:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x + 80, _loc_2.y));
            Holder.showInfo(Config.language("TaskInforSp", 54), new Rectangle(_loc_3.x, _loc_3.y, 10, 10));
            return;
        }// end function

        private function handleFlyOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function openShop(event:MouseEvent) : void
        {
            Config.ui._shopUI.getitemlist(30015);
            return;
        }// end function

        private function openbillpan(event:MouseEvent) : void
        {
            Config.ui._billboardpanel.opentype(11);
            return;
        }// end function

        public function setPosition(param1:int = 0) : void
        {
            this.open();
            this.main.verticalScrollPosition = param1;
            return;
        }// end function

        public function setToAir() : void
        {
            Config.ui._toAirPanel.switchOpen();
            return;
        }// end function

        private function landGraveOpen() : void
        {
            Config.ui._landGravePanel.switchOpen();
            Config.ui._landGravePanel.x = this.x + 30;
            Config.ui._landGravePanel.y = this.y + 40;
            return;
        }// end function

        public function openLandList(event:MouseEvent) : void
        {
            Config.ui._landGravePanel.openLandListPanel();
            return;
        }// end function

        private function openracebill(event:MouseEvent) : void
        {
            Config.ui._serveracebill.openracebill(this._flag);
            return;
        }// end function

        private function closePanel(event:MouseEvent) : void
        {
            this.infowindow.close();
            return;
        }// end function

        private function openInfoPanel(event:MouseEvent, param2:String, param3:String) : void
        {
            this.infowindow.title = param2;
            this.info.text = param3;
            this.infowindow.open();
            this.infowindow.x = this.x + 20;
            this.infowindow.y = this.y + 20;
            return;
        }// end function

        public function set jionnumber(param1:int) : void
        {
            this._value = param1;
            if (this._btn18 != null)
            {
                this._btn18.label = Config.language("activePanel", 36, this._value);
            }
            return;
        }// end function

        public function get jionnumber() : int
        {
            return this._value;
        }// end function

        private function rebackerr(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            if (_loc_3 == 0)
            {
                Config.ui._serveracebill.jionorin = 2;
                Config.message(Config.language("activePanel", 60));
            }
            else if (_loc_3 == 1)
            {
                Config.message(Config.language("activePanel", 43));
            }
            else if (_loc_3 == 2)
            {
                Config.message(Config.language("activePanel", 44));
            }
            else if (_loc_3 == 3)
            {
                Config.message(Config.language("activePanel", 45));
            }
            else if (_loc_3 == 4)
            {
                Config.message(Config.language("activePanel", 46));
            }
            else if (_loc_3 == 5)
            {
                Config.message(Config.language("activePanel", 47));
            }
            else if (_loc_3 == 6)
            {
                Config.message(Config.language("activePanel", 48));
            }
            else if (_loc_3 == 7)
            {
                Config.message(Config.language("activePanel", 49));
            }
            else if (_loc_3 == 8)
            {
                Config.message(Config.language("activePanel", 50));
            }
            else if (_loc_3 == 9)
            {
                Config.message(Config.language("activePanel", 51));
            }
            return;
        }// end function

        public function setbtn18(param1:uint) : void
        {
            if (this._btn18 != null)
            {
                if (this._flag == 1 || this._flag == 2)
                {
                    if (param1 == 0)
                    {
                        this._btn18.label = Config.language("activePanel", 36, this.jionnumber);
                    }
                    else if (param1 == 1)
                    {
                        this._btn18.label = Config.language("activePanel", 37);
                    }
                    else if (param1 == 2)
                    {
                        this._btn18.label = Config.language("activePanel", 38);
                    }
                    else if (param1 == 3)
                    {
                        this._btn18.label = Config.language("activePanel", 39);
                    }
                }
                else if (this._flag == 3)
                {
                    if (param1 == 0)
                    {
                        this._btn18.label = Config.language("activePanel", 40);
                    }
                    else if (param1 == 1)
                    {
                        this._btn18.label = Config.language("activePanel", 37);
                    }
                    else if (param1 == 3)
                    {
                        this._btn18.label = Config.language("activePanel", 39);
                    }
                    else if (param1 == 5)
                    {
                        this._btn18.label = Config.language("activePanel", 41);
                    }
                    else
                    {
                        this.setwobtn18(false);
                    }
                }
                else
                {
                    this._btn18.label = Config.language("activePanel", 5);
                }
            }
            return;
        }// end function

        public function setwobtn18(param1:Boolean)
        {
            var _loc_2:* = undefined;
            if (this._flag == 2 || this._flag == 3)
            {
                if (this._btn18 != null)
                {
                    if (!param1)
                    {
                        _loc_2 = 0;
                        while (_loc_2 < this._buttonGClips.length)
                        {
                            
                            if (GClip(this._buttonGClips[_loc_2]).parent != null)
                            {
                                GClip(this._buttonGClips[_loc_2]).parent.removeChild(GClip(this._buttonGClips[_loc_2]));
                            }
                            GClip(this._buttonGClips[_loc_2]).destroy();
                            _loc_2 = _loc_2 + 1;
                        }
                        this._buttonGClips = [];
                        this._btn18.label = Config.language("activePanel", 42);
                        this._btn18.overshow = false;
                        this._btn18.enabled = false;
                        this._btn18.textColor = 10066329;
                    }
                    else
                    {
                        this.showPanel(null, 3);
                    }
                }
            }
            return;
        }// end function

        private function activeracebtn()
        {
            var _loc_2:* = null;
            var _loc_1:* = Config.ui._serveracebill.jionorin;
            if (this._flag == 1)
            {
                if (_loc_1 == 0)
                {
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2G_CARENA_REG_APPLY);
                    ClientSocket.send(_loc_2);
                }
                else if (_loc_1 == 1)
                {
                    Config.ui._serveracebill.sendenter(1);
                }
                else if (_loc_1 == 2)
                {
                    AlertUI.alert(Config.language("activePanel", 52), Config.language("activePanel", 53), [Config.language("activePanel", 54), Config.language("activePanel", 8)], [this.cancelbaoming]);
                }
                else if (_loc_1 == 3)
                {
                    AlertUI.alert(Config.language("InterPkPanel", 11), Config.language("InterPkPanel", 12), [Config.language("InterPkPanel", 13), Config.language("InterPkPanel", 14)], [this.surebackrace]);
                }
            }
            else if (this._flag == 2)
            {
                if (_loc_1 == 0)
                {
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2B_CARENA2_REG);
                    ClientSocket.send(_loc_2);
                }
                else if (_loc_1 == 1)
                {
                    Config.ui._serveracebill.sendenter(2);
                }
                else if (_loc_1 == 2)
                {
                    AlertUI.alert(Config.language("activePanel", 52), Config.language("activePanel", 53), [Config.language("activePanel", 54), Config.language("activePanel", 8)], [this.cancelbaoming]);
                }
                else if (_loc_1 == 3)
                {
                    AlertUI.alert(Config.language("InterPkPanel", 11), Config.language("InterPkPanel", 12), [Config.language("InterPkPanel", 13), Config.language("InterPkPanel", 14)], [this.surebackrace]);
                }
            }
            else if (this._flag == 3)
            {
                if (_loc_1 == 0)
                {
                }
                else if (_loc_1 == 1)
                {
                    Config.ui._serveracebill.sendenter(3);
                }
                else if (_loc_1 == 2)
                {
                }
                else if (_loc_1 == 3)
                {
                    AlertUI.alert(Config.language("InterPkPanel", 11), Config.language("InterPkPanel", 12), [Config.language("InterPkPanel", 13), Config.language("InterPkPanel", 14)], [this.surebackrace]);
                }
            }
            return;
        }// end function

        private function surebackrace(param1)
        {
            AlertUI.close();
            Config.ui._serveracebill.jionorin = 0;
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_CARENA_LEAVE);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function cancelbaoming(event:MouseEvent) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2B_CARENA2_CANCEL);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function rebackjionerr(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            Config.ui._serveracebill.jionorin = 0;
            if (_loc_3 == 0)
            {
                Config.message(Config.language("activePanel", 55));
            }
            else if (_loc_3 == 1)
            {
                Config.message(Config.language("activePanel", 56));
            }
            return;
        }// end function

        private function stratend(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            this.nowracetimes = _loc_2.readUnsignedByte();
            if (_loc_3 == 4 || _loc_3 == 6)
            {
                this._flag = 4;
            }
            else if (_loc_3 == 5)
            {
                this._flag = 3;
            }
            trace(this.nowracetimes, _loc_3, "fdafdaf");
            return;
        }// end function

        public function set nowracetimes(param1:uint) : void
        {
            this._nowracetimes = param1;
            return;
        }// end function

        public function get nowracetimes()
        {
            return this._nowracetimes;
        }// end function

        private function playerstatus(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            if (_loc_3 == 0)
            {
            }
            else if (_loc_3 == 1)
            {
                Config.ui._serveracebill.jionorin = 1;
            }
            else if (_loc_3 == 2)
            {
            }
            else if (_loc_3 == 3)
            {
                Config.ui._serveracebill.jionorin = 5;
            }
            else
            {
                Config.ui._serveracebill.jionorin = 10;
            }
            return;
        }// end function

        private function handleover(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget;
            var _loc_3:* = "";
            if (parseInt(_loc_2.name) == 0)
            {
                return;
            }
            if (parseInt(_loc_2.name) == 1)
            {
                _loc_3 = Config.language("activePanel", 61);
            }
            else if (parseInt(_loc_2.name) == 2)
            {
                _loc_3 = Config.language("activePanel", 62);
            }
            else if (parseInt(_loc_2.name) == 3)
            {
                _loc_3 = Config.language("activePanel", 63);
            }
            Holder.showInfo(_loc_3, new Rectangle(Config.stage.mouseX + 10, Config.stage.mouseY + 15));
            return;
        }// end function

        private function handleout(param1) : void
        {
            Holder.closeInfo();
            return;
        }// end function

        private function changepage(event:MouseEvent) : void
        {
            this.main.verticalScrollPosition = 100;
            return;
        }// end function

        private function getcount(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this.get_count = _loc_2.readUnsignedByte();
            this.get_allcount = _loc_2.readUnsignedByte();
            return;
        }// end function

        private function get get_count() : int
        {
            return this._getcount;
        }// end function

        private function set get_count(param1:int) : void
        {
            this._getcount = param1;
            return;
        }// end function

        private function get get_allcount() : int
        {
            return this._getallcount;
        }// end function

        private function set get_allcount(param1:int) : void
        {
            this._getallcount = param1;
            return;
        }// end function

    }
}
