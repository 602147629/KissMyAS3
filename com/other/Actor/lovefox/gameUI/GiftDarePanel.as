package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class GiftDarePanel extends Window
    {
        private var recomCanvas:CanvasUI;
        private var _recomArr:Array;
        private var bitarr:Array;

        public function GiftDarePanel(param1:DisplayObjectContainer = null)
        {
            this._recomArr = new Array();
            this.bitarr = [];
            super(param1);
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            resize(580, 360);
            this.title = Config.language("GiftDarePanel", 1);
            this.recomCanvas = new CanvasUI(this, 10, 30, 560, 320);
            this.addChild(this.recomCanvas);
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            this.dayRecom();
            return;
        }// end function

        public function reshowPanel() : void
        {
            if (this.stage != null)
            {
                this.dayRecom();
            }
            return;
        }// end function

        public function dayRecom() : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = false;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (Config.player == null)
            {
                return;
            }
            this.recomCanvas.removeAllChildren();
            var _loc_1:* = new Array();
            for (_loc_2 in Config._dayRecomList)
            {
                
                if (Config.player.level >= Config._dayRecomList[_loc_2].minlevel && (Config.player.level < Config._dayRecomList[_loc_2].maxlevel || int(Config._dayRecomList[_loc_2].maxlevel) == 0))
                {
                    _loc_3 = true;
                    if (int(Config._dayRecomList[_loc_2].preTask) != 0)
                    {
                        _loc_3 = false;
                        if (Config.ui._taskpanel.taskdownlist[int(Config._dayRecomList[_loc_2].preTask)] != null)
                        {
                            _loc_3 = true;
                        }
                        if (int(Config._dayRecomList[_loc_2].type) == 2)
                        {
                            if (Config.ui._taskpanel.taskdownlist[int(Config._dayRecomList[_loc_2].taskchainend)] != null)
                            {
                                _loc_3 = false;
                            }
                        }
                    }
                    else if (int(Config._dayRecomList[_loc_2].type) == 2)
                    {
                        if (Config.ui._taskpanel.taskdownlist[int(Config._dayRecomList[_loc_2].taskchainend)] != null)
                        {
                            _loc_3 = false;
                        }
                    }
                    else if (Config.ui._taskpanel.taskdownlist[int(Config._dayRecomList[_loc_2].task)] != null)
                    {
                        _loc_3 = false;
                    }
                    if (_loc_3)
                    {
                        _loc_4 = new Object();
                        _loc_4.id = Config._dayRecomList[_loc_2].id;
                        _loc_4.has = 0;
                        if (int(Config._dayRecomList[_loc_2].type) == 0 || int(Config._dayRecomList[_loc_2].type) == 4)
                        {
                            _loc_4.has = 0;
                        }
                        else if (int(Config._dayRecomList[_loc_2].type) == 1)
                        {
                            if (int(Config._dayRecomList[_loc_2].id) == 1)
                            {
                                _loc_4.has = Skill.picksoulTime;
                            }
                            else if (int(Config._dayRecomList[_loc_2].id) == 2)
                            {
                                _loc_4.has = Skill.goldhandTime;
                            }
                        }
                        else if (int(Config._dayRecomList[_loc_2].type) == 3)
                        {
                            _loc_5 = 0;
                            while (_loc_5 < Config.ui._taskpanel.taskdayarr.length)
                            {
                                
                                if (Config.ui._taskpanel.taskdayarr[_loc_5].id == int(Config._dayRecomList[_loc_2].task))
                                {
                                    _loc_4.has = Config.ui._taskpanel.taskdayarr[_loc_5].daynum;
                                    break;
                                }
                                _loc_5 = _loc_5 + 1;
                            }
                            if (int(Config._dayRecomList[_loc_2].id) == 16)
                            {
                                _loc_6 = 0;
                                while (_loc_6 < Config.ui._taskpanel.taskdayarr.length)
                                {
                                    
                                    if (Config.ui._taskpanel.taskdayarr[_loc_6].id == int(Config._dayRecomList[_loc_2].task))
                                    {
                                        _loc_4.has = Config.ui._taskpanel.taskdayarr[_loc_6].spnum;
                                        break;
                                    }
                                    _loc_6 = _loc_6 + 1;
                                }
                            }
                        }
                        if (_loc_4.has >= int(Config._dayRecomList[_loc_2].times) && int(Config._dayRecomList[_loc_2].times) != 0)
                        {
                            _loc_4.sort = 1;
                        }
                        else
                        {
                            _loc_4.sort = 0;
                        }
                        if (int(Config._dayRecomList[_loc_2].type) == 4)
                        {
                            _loc_7 = Config.ui._fbEntranceUI.checkFbTime();
                            if (_loc_7 == 1 || _loc_7 == 2)
                            {
                                _loc_4.sort = 0;
                            }
                            else
                            {
                                _loc_4.sort = 1;
                            }
                        }
                        _loc_1.push(_loc_4);
                    }
                }
            }
            _loc_1.sortOn("id", Array.NUMERIC);
            this.dayrecomlist(_loc_1);
            return;
        }// end function

        private function dayrecomlist(param1:Array) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            this.recomCanvas.removeAllChildren();
            var _loc_2:* = 0;
            while (_loc_2 < this.bitarr.length)
            {
                
                if (this.bitarr[_loc_2].hasOwnProperty("bitmapData"))
                {
                    this.bitarr[_loc_2].bitmapData.dispose();
                }
                _loc_2++;
            }
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < param1.length)
            {
                
                _loc_5 = new Sprite();
                this.recomCanvas.addChildUI(_loc_5);
                _loc_5.x = 0;
                _loc_5.y = _loc_3;
                _loc_3 = _loc_3 + 5;
                _loc_5.addEventListener(MouseEvent.ROLL_OUT, this.handleActiveOut);
                _loc_6 = Config._dayRecomList[param1[_loc_4].id].describe;
                _loc_7 = new Label(_loc_5, 65, 25);
                if (int(Config._dayRecomList[param1[_loc_4].id].times) > 0 && int(Config._dayRecomList[param1[_loc_4].id].type) != 2)
                {
                    _loc_7.text = Config.language("TaskPanel", 109) + param1[_loc_4].has + "/" + Config._dayRecomList[param1[_loc_4].id].times;
                }
                else
                {
                    _loc_7.text = " ";
                }
                _loc_8 = new Label(_loc_5, 65, 45, Config._dayRecomList[param1[_loc_4].id].reward);
                _loc_9 = new TextAreaUI(_loc_5, 200, 20, 250, 20);
                _loc_9.autoHeight = true;
                _loc_10 = new PushButton(_loc_5, 450, 30);
                _loc_10.visible = false;
                _loc_10.width = 70;
                _loc_11 = new Label(_loc_5, 430, 30, Config.language("TaskPanel", 110));
                _loc_11.visible = false;
                _loc_12 = 0;
                _loc_13 = Config._dayRecomList[param1[_loc_4].id].taskchainbegin;
                _loc_14 = String(Config._dayRecomList[param1[_loc_4].id].taskchain).split("|");
                _loc_15 = 0;
                while (_loc_15 < Config.ui._taskpanel.tasklistarr.length)
                {
                    
                    if (_loc_14.length > 1)
                    {
                        _loc_18 = 1;
                        while (_loc_18 < _loc_14.length)
                        {
                            
                            if (int(_loc_14[_loc_18]) == Config.ui._taskpanel.tasklistarr[_loc_15].id)
                            {
                                _loc_13 = Config.ui._taskpanel.tasklistarr[_loc_15].id;
                                _loc_12 = 2;
                                break;
                            }
                            _loc_18 = _loc_18 + 1;
                        }
                    }
                    else if (Config.ui._taskpanel.tasklistarr[_loc_15].id == Config._dayRecomList[param1[_loc_4].id].taskchainbegin)
                    {
                        _loc_13 = Config.ui._taskpanel.tasklistarr[_loc_15].id;
                        _loc_12 = 1;
                        break;
                    }
                    _loc_15 = _loc_15 + 1;
                }
                if (Config._dayRecomList[param1[_loc_4].id].showtype == 3 && _loc_12 == 2)
                {
                    _loc_6 = Config.language("TaskPanel", 111) + "<FONT COLOR=\'#00aeff\'>" + Config._taskMap[_loc_13].title + "</FONT>";
                }
                if (param1[_loc_4].id == 4 || param1[_loc_4].id == 5)
                {
                    if (param1[_loc_4].sort == 1)
                    {
                        _loc_11.visible = true;
                        _loc_12 = 3;
                    }
                    else
                    {
                        _loc_10.visible = true;
                        if (_loc_12 == 0)
                        {
                            _loc_10.label = Config.language("TaskPanel", 112);
                        }
                        else
                        {
                            _loc_10.label = Config.language("TaskPanel", 113);
                        }
                    }
                }
                else if (param1[_loc_4].id >= 18 && param1[_loc_4].id <= 23)
                {
                    if (param1[_loc_4].sort == 1)
                    {
                        _loc_11.visible = true;
                        _loc_12 = 3;
                    }
                    else
                    {
                        _loc_10.visible = true;
                        if (_loc_12 == 0)
                        {
                            _loc_10.label = Config.language("TaskPanel", 112);
                        }
                        else
                        {
                            _loc_10.label = Config.language("TaskPanel", 113);
                        }
                    }
                }
                else if (param1[_loc_4].id >= 6 && param1[_loc_4].id <= 15)
                {
                    _loc_10.label = Config.language("GiftDarePanel", 2);
                    _loc_10.visible = true;
                }
                else if (param1[_loc_4].id == 16)
                {
                    if (Config.ui._taskpanel.dayListPanel.tasklistarr.length > 0)
                    {
                        _loc_6 = Config._dayRecomList[param1[_loc_4].id].describe;
                        _loc_10.label = Config.language("TaskPanel", 114);
                        _loc_10.visible = true;
                        _loc_12 = 0;
                    }
                    else
                    {
                        _loc_19 = -1;
                        _loc_15 = 0;
                        while (_loc_15 < Config.ui._taskpanel.tasklistarr.length)
                        {
                            
                            if (Config.ui._taskpanel.tasklistarr[_loc_15].id == Config._dayRecomList[param1[_loc_4].id].task)
                            {
                                _loc_19 = Config.ui._taskpanel.tasklistarr[_loc_15].spnum;
                            }
                            _loc_15 = _loc_15 + 1;
                        }
                        if (_loc_19 == -1)
                        {
                            _loc_6 = Config._dayRecomList[param1[_loc_4].id].describe;
                            _loc_11.visible = true;
                            _loc_12 = 3;
                        }
                        else if (_loc_19 == 10)
                        {
                            _loc_6 = Config._dayRecomList[param1[_loc_4].id].describe3;
                            _loc_10.label = Config.language("TaskPanel", 116);
                            _loc_10.visible = true;
                            _loc_12 = 2;
                        }
                        else
                        {
                            _loc_6 = Config._dayRecomList[param1[_loc_4].id].describe2;
                            _loc_10.label = Config.language("TaskPanel", 113);
                            _loc_10.visible = true;
                            _loc_12 = 1;
                        }
                    }
                }
                else if (param1[_loc_4].id >= 24 && param1[_loc_4].id <= 29)
                {
                    if (param1[_loc_4].sort == 0)
                    {
                        _loc_10.label = Config.language("TaskPanel", 113);
                        _loc_10.visible = true;
                        _loc_12 = 1;
                    }
                    else
                    {
                        _loc_11.visible = true;
                    }
                }
                else
                {
                    if (param1[_loc_4].sort == 0)
                    {
                        _loc_11.text = Config.language("TaskPanel", 115);
                    }
                    _loc_11.visible = true;
                }
                _loc_10.addEventListener(MouseEvent.CLICK, Config.create(this.dayClickFuc, param1[_loc_4].id, _loc_12, _loc_13));
                _loc_6 = DescriptionTranslate.translate(_loc_6);
                _loc_9.text = _loc_6;
                _loc_6 = "<font color=\'" + Style.FONT_Yellow + "\'>" + Config._dayRecomList[param1[_loc_4].id].name + "</font>\n" + _loc_6;
                _loc_16 = new ClickLabel(_loc_5, 65, 5, Config._dayRecomList[param1[_loc_4].id].name, Config.create(this.handleActiveOver, _loc_6));
                _loc_16.clickColor([26367, 6837142]);
                _loc_5.graphics.beginFill(16777215, 0.3);
                _loc_5.graphics.drawRoundRect(0, 0, 580, 100, 5);
                _loc_5.graphics.beginFill(6710886, 0.3);
                _loc_5.graphics.drawRoundRect(5, 10, 54, 54, 5);
                _loc_3 = _loc_3 + 100;
                _loc_17 = new Bitmap();
                _loc_5.addChild(_loc_17);
                _loc_17.x = 5;
                _loc_17.y = 10;
                _loc_17.bitmapData = Config.findsysUI("acitve/" + Config._dayRecomList[param1[_loc_4].id].icon, 54, 54);
                this.bitarr.push(_loc_17);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        private function dayClickFuc(event:MouseEvent, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param3 == 0)
            {
                if (param2 == 16)
                {
                    Config.ui._taskpanel.dayListPanel.open();
                }
                else if (param2 == 8 || param2 == 10 || param2 == 12 || param2 == 14)
                {
                    Hang.hangNpc(int(Config._taskMap[int(Config._dayRecomList[param2].taskchainbegin)].startNPC));
                }
                else if (param2 >= 6 && param2 <= 15)
                {
                    _loc_5 = new DataSet();
                    _loc_5.addHead(CONST_ENUM.C2G_ENTER_UMAP);
                    _loc_5.add32(int(Config._giftMap[int(Config._dayRecomList[param2].jumpMap)].id));
                    ClientSocket.send(_loc_5);
                }
                else
                {
                    _loc_6 = new Object();
                    _loc_6.id = param4;
                    AlertUI.alert(Config.language("TaskPanel", 63), Config.language("TaskPanel", 106, Config.ui._taskpanel.getPayCoin()), [Config.language("TaskPanel", 66), Config.language("TaskPanel", 67)], [Config.ui._taskpanel.opengetTaskPanel], _loc_6);
                }
            }
            else if (param3 == 1)
            {
                if (param2 == 16)
                {
                    this.open();
                    Config.ui._taskpanel.opentaskinfor(param4, true);
                }
                else if (param2 >= 6 && param2 <= 15)
                {
                    _loc_5 = new DataSet();
                    _loc_5.addHead(CONST_ENUM.C2G_ENTER_UMAP);
                    _loc_5.add32(int(Config._giftMap[int(Config._dayRecomList[param2].jumpMap)].id));
                    ClientSocket.send(_loc_5);
                }
                else if (param2 >= 24 && param2 <= 29)
                {
                    Config.ui._fbEntranceUI.open();
                }
                else if (int(Config._dayRecomList[param2].jumpMap) > 0)
                {
                    Config.ui._zoommap.flyMapAlert(int(Config._dayRecomList[param2].jumpMap));
                }
                else
                {
                    Config.ui._taskpanel.open();
                    Config.ui._taskpanel.opentaskinfor(param4, true);
                }
            }
            else if (param3 == 2)
            {
                if (param2 == 16)
                {
                    this.open();
                }
                else if (param2 >= 6 && param2 <= 15)
                {
                    _loc_5 = new DataSet();
                    _loc_5.addHead(CONST_ENUM.C2G_ENTER_UMAP);
                    _loc_5.add32(int(Config._giftMap[int(Config._dayRecomList[param2].jumpMap)].id));
                    ClientSocket.send(_loc_5);
                }
                else if (int(Config._dayRecomList[param2].jumpMap) > 0)
                {
                    Config.ui._zoommap.flyMapAlert(int(Config._dayRecomList[param2].jumpMap));
                }
                else
                {
                    Config.ui._taskpanel.open();
                    Config.ui._taskpanel.opentaskinfor(param4, true);
                }
            }
            else if (param2 >= 6 && param2 <= 15)
            {
                _loc_5 = new DataSet();
                _loc_5.addHead(CONST_ENUM.C2G_ENTER_UMAP);
                _loc_5.add32(int(Config._giftMap[int(Config._dayRecomList[param2].jumpMap)].id));
                ClientSocket.send(_loc_5);
            }
            else
            {
                _loc_6 = new Object();
                _loc_6.id = param4;
                AlertUI.alert(Config.language("TaskPanel", 63), Config.language("TaskPanel", 106, Config.ui._taskpanel.getPayCoin()), [Config.language("TaskPanel", 66), Config.language("TaskPanel", 67)], [Config.ui._taskpanel.openLingPanel], _loc_6);
            }
            return;
        }// end function

        private function removeallchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        private function handleActiveOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleActiveOver(param1, param2:String)
        {
            Holder.showInfo(param2, new Rectangle(Config.stage.mouseX, Config.stage.mouseY + 10), false, 1, 200);
            return;
        }// end function

    }
}
