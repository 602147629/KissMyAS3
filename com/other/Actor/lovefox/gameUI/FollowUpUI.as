package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.gui.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class FollowUpUI extends Window
    {
        private var _leftClip:UnitClip;
        private var _rightClip:UnitClip;
        private var _leftEffectClip:GClip;
        private var _rightEffectClip:GClip;
        private var _gradeID:int = 0;
        private var _level:int = 0;
        private var _star:int = 0;
        private var _maxID:int = 0;
        private var _modelID:int = 0;
        private var _honor:int = 0;
        private var _leftTitleTF:TextField;
        private var _leftInfoTFs:Array;
        private var _rightTitleTF:TextField;
        private var _rightInfoTFs:Array;
        private var _honorTF:TextField;
        private var _honorExpandTF:TextField;
        private var _starContainers:Array;
        private var _stars:Array;
        private var _grayStars:Array;
        private var _starEffects:Array;
        private var _layer1:Sprite;
        private var _layer2:Sprite;
        private var _layer:int = 1;
        private var _page:int = 0;
        private var _pageTF:TextField;
        private var _bgs:Array;
        private var _modeClips:Array;
        private var _modeCBs:Array;
        private var _lockers:Array;
        private var _overallLayer:Sprite;
        private var _overallTF1:TextField;
        private var _overallTF2:TextField;
        private var _arrowBmp:Bitmap;
        private var _lockerBmp:Bitmap;
        private var _lockerBmpd:BitmapData;
        private var _rightLB1:TextField;
        private var _rightBG:Shape;
        private var _upPB:PushButton;
        private var _upPBRollLayer:Sprite;
        private var _eatPB:PushButton;
        private var _eatPBRollLayer:Sprite;
        private var _upLock:Boolean = false;
        private var _upEffectCount:int = 0;
        private var _upEffecting:Boolean = false;
        private var _firstOpen:Boolean = true;

        public function FollowUpUI(param1:DisplayObjectContainer = null)
        {
            this._leftInfoTFs = [];
            this._rightInfoTFs = [];
            this._starContainers = [];
            this._stars = [];
            this._grayStars = [];
            this._starEffects = [];
            this._bgs = [];
            this._modeClips = [];
            this._modeCBs = [];
            this._lockers = [];
            super(param1);
            this.initsocket();
            this.initUI();
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            this.title = Config.language("FollowUpUI", 1);
            this.refresh();
            this.setLayer(1);
            return;
        }// end function

        override public function close()
        {
            if (this._layer == 2)
            {
                this.setLayer(1);
            }
            else
            {
                super.close();
                this.clearClips();
            }
            return;
        }// end function

        public function changeMapRefresh() : void
        {
            if (_opening)
            {
                this.refresh();
                this.setPage(this._page);
            }
            return;
        }// end function

        private function initsocket()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ACCPRO_INIT, this.initUpInfor);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ACCPRO_EXP, this.handleHohor);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ACCPRO_UPGRADE, this.handleLevelup);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ACCOMPANY_MODEL, this.handleModel);
            return;
        }// end function

        private function setLayer(param1:int) : void
        {
            if (param1 == 1)
            {
                this._layer = 1;
                if (this._layer1.parent == null)
                {
                    addChild(this._layer1);
                }
                if (this._layer2.parent != null)
                {
                    this._layer2.parent.removeChild(this._layer2);
                }
                if (Config.player != null)
                {
                    this.title = Config.language("FollowUpUI", 1);
                }
            }
            else
            {
                this._layer = 2;
                if (this._layer2.parent == null)
                {
                    addChild(this._layer2);
                }
                if (this._layer1.parent != null)
                {
                    this._layer1.parent.removeChild(this._layer1);
                }
                this.title = Config.language("FollowUpUI", 2);
            }
            return;
        }// end function

        private function setPage(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            _loc_2 = 0;
            while (_loc_2 < this._modeClips.length)
            {
                
                this._modeClips[_loc_2].destroy();
                if (this._modeClips[_loc_2].parent != null)
                {
                    this._modeClips[_loc_2].parent.removeChild(this._modeClips[_loc_2]);
                }
                _loc_2++;
            }
            this._modeClips = [];
            this._page = Math.max(0, Math.min(8, param1));
            this._pageTF.text = (this._page + 1) + "/9";
            _loc_2 = 0;
            while (_loc_2 < 6)
            {
                
                _loc_3 = this._modeCBs[_loc_2];
                if (this._level + (this._star == 10 ? (1) : (0)) > this._page * 6 + _loc_2 && this._page * 6 + _loc_2 < 50)
                {
                    _loc_3.data = this._page * 6 + _loc_2 + 1;
                    _loc_3.visible = true;
                    this._lockers[_loc_2].visible = false;
                    if (this._modelID == _loc_3.data)
                    {
                        _loc_3.label = Config.language("FollowUpUI", 3);
                        _loc_3.selected = true;
                        _loc_3.textColor = 2526035;
                    }
                    else
                    {
                        _loc_3.label = Config.language("FollowUpUI", 4);
                        _loc_3.selected = false;
                        _loc_3.textColor = Style.WINDOW_FONT;
                    }
                }
                else
                {
                    _loc_3.visible = false;
                    this._lockers[_loc_2].visible = true;
                }
                if (this._page * 6 + _loc_2 < 50)
                {
                    this._bgs[_loc_2].visible = true;
                    _loc_4 = Config._followUpMap[(this._page * 6 + _loc_2) * 10 + 1].model;
                    _loc_5 = UnitClip.newUnitClip(Config._model[_loc_4]);
                    _loc_5.changeStateTo("idle");
                    _loc_5.changeDirectionTo(1);
                    _loc_5.x = _loc_3.x - 30 + 83;
                    _loc_5.y = _loc_3.y - 132 + 167 - 35;
                    _loc_5.shadow = false;
                    this._layer2.addChild(_loc_5);
                    this._modeClips[_loc_2] = _loc_5;
                }
                else
                {
                    this._bgs[_loc_2].visible = false;
                    this._lockers[_loc_2].visible = false;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function initUI()
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_8:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            resize(580, 395);
            this._lockerBmpd = Config.findsysUI("icon/fight5", 21, 30);
            this._layer1 = new Sprite();
            var _loc_1:* = this.drawBG(this._layer1, 22, 58, 218, 228);
            this._rightBG = this.drawBG(this._layer1, 341, 58, 218, 228);
            var _loc_2:* = new TextFormat(null, 18, null, true);
            this._leftTitleTF = Config.getSimpleTextField();
            this._leftTitleTF.defaultTextFormat = _loc_2;
            this._rightTitleTF = Config.getSimpleTextField();
            this._rightTitleTF.defaultTextFormat = _loc_2;
            var _loc_16:* = 29;
            this._rightTitleTF.y = 29;
            this._leftTitleTF.y = _loc_16;
            this._layer1.addChild(this._leftTitleTF);
            this._layer1.addChild(this._rightTitleTF);
            _loc_3 = 0;
            while (_loc_3 < 4)
            {
                
                if (_loc_3 == 0)
                {
                    _loc_11 = 44;
                    _loc_12 = 243;
                }
                else if (_loc_3 == 1)
                {
                    _loc_11 = 145;
                    _loc_12 = 243;
                }
                else if (_loc_3 == 2)
                {
                    _loc_11 = 44;
                    _loc_12 = 265;
                }
                else
                {
                    _loc_11 = 145;
                    _loc_12 = 265;
                }
                _loc_4 = Config.getSimpleTextField();
                _loc_4.x = _loc_11;
                _loc_4.y = _loc_12;
                this._layer1.addChild(_loc_4);
                this._leftInfoTFs.push(_loc_4);
                _loc_4 = Config.getSimpleTextField();
                _loc_4.x = _loc_11 + 341 - 22;
                _loc_4.y = _loc_12;
                this._layer1.addChild(_loc_4);
                this._rightInfoTFs.push(_loc_4);
                _loc_3++;
            }
            _loc_4 = Config.getSimpleTextField();
            _loc_4.x = 22;
            _loc_4.y = 222;
            _loc_4.text = Config.language("FollowUpUI", 5);
            this._layer1.addChild(_loc_4);
            this._rightLB1 = Config.getSimpleTextField();
            this._rightLB1.x = 341;
            this._rightLB1.y = 222;
            this._rightLB1.text = Config.language("FollowUpUI", 5);
            this._layer1.addChild(this._rightLB1);
            _loc_4 = Config.getSimpleTextField();
            _loc_4.x = 120;
            _loc_4.y = 355;
            _loc_4.text = Config.language("FollowUpUI", 6);
            this._layer1.addChild(_loc_4);
            _loc_4 = Config.getSimpleTextField();
            _loc_4.defaultTextFormat = _loc_2;
            _loc_4.x = 68;
            _loc_4.y = 292;
            _loc_4.text = Config.language("FollowUpUI", 7);
            this._layer1.addChild(_loc_4);
            this._honorExpandTF = Config.getSimpleTextField();
            this._honorExpandTF.x = 120;
            this._honorExpandTF.y = 330;
            this._layer1.addChild(this._honorExpandTF);
            this._honorTF = Config.getSimpleTextField();
            this._honorTF.x = 315;
            this._honorTF.y = 330;
            this._layer1.addChild(this._honorTF);
            this._arrowBmp = new Bitmap(Config.findsysUI("follower_up/j", 47, 29));
            this._arrowBmp.x = 268;
            this._arrowBmp.y = 145;
            this._layer1.addChild(this._arrowBmp);
            this._lockerBmp = new Bitmap(this._lockerBmpd);
            this._lockerBmp.x = 279;
            this._lockerBmp.y = 143;
            this._layer1.addChild(this._lockerBmp);
            _loc_5 = new Bitmap(Config.findsysUI("follower_up/level", 42, 42));
            _loc_5.x = 71;
            _loc_5.y = 328;
            this._layer1.addChild(_loc_5);
            var _loc_6:* = Config.findsysUI("follower_up/rstart", 19, 19);
            var _loc_7:* = Config.findsysUI("follower_up/bstart", 19, 19);
            _loc_3 = 0;
            while (_loc_3 < 10)
            {
                
                _loc_13 = new Bitmap(_loc_6);
                _loc_14 = new Bitmap(_loc_7);
                _loc_15 = new Sprite();
                _loc_15.addChild(_loc_13);
                _loc_15.addChild(_loc_14);
                _loc_15.x = 130 + 33 * _loc_3;
                _loc_15.y = 295;
                this._starContainers.push(_loc_15);
                this._stars.push(_loc_13);
                this._grayStars.push(_loc_14);
                this._layer1.addChild(_loc_15);
                _loc_15.name = "" + _loc_3;
                _loc_15.addEventListener(MouseEvent.ROLL_OVER, this.handleStarRollover);
                _loc_15.addEventListener(MouseEvent.ROLL_OUT, this.handleStarRollout);
                this._starEffects[_loc_3] = GClip.newGClip("followup_faguang");
                this._starEffects[_loc_3].visible = false;
                this._starEffects[_loc_3].x = _loc_15.x - 5 + 15;
                this._starEffects[_loc_3].y = _loc_15.y - 4 + 15;
                this._layer1.addChild(this._starEffects[_loc_3]);
                _loc_3++;
            }
            this._upPB = new PushButton(this._layer1, 479, 333, Config.language("FollowUpUI", 8), this.handleStarUp);
            this._upPB.width = 76;
            this._upPBRollLayer = new Sprite();
            this._upPBRollLayer.graphics.beginFill(0, 0);
            this._upPBRollLayer.graphics.drawRect(0, 0, 76, 24);
            this._upPBRollLayer.graphics.endFill();
            this._upPBRollLayer.x = this._upPB.x;
            this._upPBRollLayer.y = this._upPB.y;
            this._upPBRollLayer.visible = false;
            this._layer1.addChild(this._upPBRollLayer);
            this._eatPB = new PushButton(this._layer1, 479, 360, Config.language("FollowUpUI", 9), this.handleBatEat);
            this._eatPB.width = 76;
            this._eatPBRollLayer = new Sprite();
            this._eatPBRollLayer.graphics.beginFill(0, 0);
            this._eatPBRollLayer.graphics.drawRect(0, 0, 76, 24);
            this._eatPBRollLayer.graphics.endFill();
            this._eatPBRollLayer.x = this._eatPB.x;
            this._eatPBRollLayer.y = this._eatPB.y;
            this._eatPBRollLayer.visible = false;
            this._layer1.addChild(this._eatPBRollLayer);
            this._eatPB.addEventListener(MouseEvent.ROLL_OVER, this.handleEatPBRollover);
            this._eatPBRollLayer.addEventListener(MouseEvent.ROLL_OVER, this.handleEatPBRollover1);
            _loc_8 = new PushButton(this._layer1, 506, 22, Config.language("FollowUpUI", 10), this.handleRoad, null, "table18", "table31");
            _loc_8.width = 60;
            _loc_8.overshow = true;
            _loc_8.textColor = Style.GOLD_FONT;
            var _loc_9:* = new ClickLabel(this._layer1, 510, 40, Config.language("FollowUpUI", 11), null, true);
            new ClickLabel(this._layer1, 510, 40, Config.language("FollowUpUI", 11), null, true).clickColor([1405985, 1857060]);
            _loc_9.addEventListener(MouseEvent.ROLL_OVER, this.handleOverallRollOver);
            _loc_9.addEventListener(MouseEvent.ROLL_OUT, this.handleOverallRollOut);
            this._layer2 = new Sprite();
            this._bgs.push(this.drawBG(this._layer2, 28, 30, 166, 157));
            this._bgs.push(this.drawBG(this._layer2, 213, 30, 166, 157));
            this._bgs.push(this.drawBG(this._layer2, 398, 30, 166, 157));
            this._bgs.push(this.drawBG(this._layer2, 28, 204, 166, 157));
            this._bgs.push(this.drawBG(this._layer2, 213, 204, 166, 157));
            this._bgs.push(this.drawBG(this._layer2, 398, 204, 166, 157));
            _loc_3 = 0;
            while (_loc_3 < 6)
            {
                
                this._modeCBs[_loc_3] = new CheckBox(this._layer2, this._bgs[_loc_3].x + 30, this._bgs[_loc_3].y + 132, Config.language("FollowUpUI", 4), this.handleChangeModel);
                this._lockers[_loc_3] = new Bitmap(this._lockerBmpd);
                this._lockers[_loc_3].x = this._bgs[_loc_3].x + 130;
                this._lockers[_loc_3].y = this._bgs[_loc_3].y + 121;
                this._layer2.addChild(this._lockers[_loc_3]);
                _loc_3++;
            }
            _loc_8 = new PushButton(this._layer2, 240, 365, "<", this.setPagePre);
            _loc_8.width = 30;
            _loc_8 = new PushButton(this._layer2, 312, 365, ">", this.setPageNext);
            _loc_8.width = 30;
            this._pageTF = Config.getSimpleTextField();
            this._pageTF.defaultTextFormat = new TextFormat(null, 16, Style.WINDOW_FONT, true);
            this._pageTF.text = "1/9";
            this._pageTF.y = 365;
            this._pageTF.x = 270;
            this._pageTF.width = 42;
            this._pageTF.autoSize = TextFieldAutoSize.CENTER;
            this._layer2.addChild(this._pageTF);
            this._overallLayer = new Sprite();
            this._overallLayer.x = 423;
            this._overallLayer.y = 33;
            this._overallTF1 = Config.getSimpleTextField();
            this._overallTF2 = Config.getSimpleTextField();
            var _loc_10:* = Config.getSimpleTextField();
            Config.getSimpleTextField().textColor = 16292406;
            _loc_10.text = Config.language("FollowUpUI", 29);
            _loc_10.x = 62;
            _loc_10.y = 5;
            this._overallLayer.addChild(_loc_10);
            var _loc_16:* = new TextFormat(null, null, 16777215, null, null, null, null, null, null, null, null, null, 2);
            this._overallTF2.defaultTextFormat = new TextFormat(null, null, 16777215, null, null, null, null, null, null, null, null, null, 2);
            this._overallTF1.defaultTextFormat = _loc_16;
            this._overallLayer.addChild(this._overallTF1);
            this._overallLayer.addChild(this._overallTF2);
            this._overallTF1.x = 8;
            this._overallTF2.x = 105;
            var _loc_16:* = 30;
            this._overallTF2.y = 30;
            this._overallTF1.y = _loc_16;
            var _loc_16:* = false;
            this._overallLayer.mouseEnabled = false;
            this._overallLayer.mouseChildren = _loc_16;
            this._leftEffectClip = GClip.newGClip("followup_texiao");
            this._rightEffectClip = GClip.newGClip("followup_texiao");
            this._leftEffectClip.x = 131 - 32 + 33;
            this._leftEffectClip.y = 225 - 83 + 31;
            this._rightEffectClip.x = 450 - 32 + 33;
            this._rightEffectClip.y = 225 - 83 + 31;
            this._layer1.addChild(this._leftEffectClip);
            this._layer1.addChild(this._rightEffectClip);
            var _loc_16:* = false;
            this._rightEffectClip.visible = false;
            this._leftEffectClip.visible = _loc_16;
            _loc_8 = new PushButton(this._layer2, 490, 365, Config.language("FollowUpUI", 12), this.handleBack);
            _loc_8.width = 76;
            this.setLayer(this._layer);
            return;
        }// end function

        private function handleBack(event:MouseEvent) : void
        {
            this.setLayer(1);
            return;
        }// end function

        private function handleBatEat(event:MouseEvent) : void
        {
            var _loc_2:* = this.getFood();
            if (_loc_2.length > 0)
            {
                AlertUI.alert(Config.language("FollowUpUI", 13), Config.language("FollowUpUI", 14), [Config.language("FollowUpUI", 15), Config.language("FollowUpUI", 16)], [this.eatAll]);
            }
            else
            {
                AlertUI.alert(Config.language("FollowUpUI", 13), Config.language("FollowUpUI", 17), [Config.language("FollowUpUI", 15), Config.language("FollowUpUI", 16)], [this.buyFood]);
            }
            return;
        }// end function

        private function eatAll(param1 = null) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_2:* = this.getFood();
            var _loc_3:* = 100;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_5 = 0;
                while (_loc_5 < _loc_2[_loc_4].amount)
                {
                    
                    _loc_6 = new DataSet();
                    _loc_6.addHead(CONST_ENUM.CMSG_ITEM_USE);
                    _loc_6.add16(_loc_2[_loc_4].position);
                    ClientSocket.send(_loc_6);
                    _loc_3 = _loc_3 - 1;
                    if (_loc_3 <= 0)
                    {
                        break;
                    }
                    _loc_5++;
                }
                _loc_4++;
            }
            return;
        }// end function

        private function getFood() : Array
        {
            var _loc_4:* = null;
            var _loc_1:* = [898007, 898008, 898009, 898010];
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1.length)
            {
                
                _loc_4 = Config.ui._charUI.getItemArr(_loc_1[_loc_3]);
                _loc_2 = _loc_2.concat(_loc_4);
                _loc_3++;
            }
            return _loc_2;
        }// end function

        private function buyFood(param1 = null) : void
        {
            Config.ui._shopmail.openListPanel(99);
            return;
        }// end function

        private function handleStarRollover(event:MouseEvent) : void
        {
            var _loc_2:* = Sprite(event.target);
            var _loc_3:* = Config._followUpMap[(Math.max(1, this._level + (this._star == 10 && this._level < 50 ? (1) : (0))) - 1) * 10 + Math.max(1, (int(_loc_2.name) + 1))];
            var _loc_4:* = "";
            var _loc_5:* = 1;
            while (_loc_5 < 16)
            {
                
                if (_loc_3["effectId" + _loc_5] != 0 && _loc_3["effectValue" + _loc_5] != 0)
                {
                    if (_loc_4.length > 0)
                    {
                        _loc_4 = _loc_4 + "\n";
                    }
                    _loc_4 = _loc_4 + (Config._itemPropMap[_loc_3["effectId" + _loc_5]].name + "+" + _loc_3["effectValue" + _loc_5]);
                }
                _loc_5++;
            }
            if (this._stars[int(_loc_2.name)].parent == null)
            {
                _loc_4 = _loc_4 + ("\n<font color=\'#FF0000\'>" + Config.language("FollowUpUI", 18) + "</font>");
            }
            var _loc_6:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            Holder.showInfo(_loc_4, new Rectangle(_loc_6.x, _loc_6.y, _loc_2.width, _loc_2.height), false, 1);
            return;
        }// end function

        private function handleStarRollout(event:MouseEvent) : void
        {
            Holder.closeInfo();
            return;
        }// end function

        private function setPagePre(event:MouseEvent) : void
        {
            this.setPage((this._page - 1));
            return;
        }// end function

        private function setPageNext(event:MouseEvent) : void
        {
            this.setPage((this._page + 1));
            return;
        }// end function

        private function drawBG(param1:DisplayObjectContainer, param2:int, param3:int, param4:int, param5:int) : Shape
        {
            var _loc_6:* = new Shape();
            new Shape().graphics.beginFill(16777215, 0.4);
            _loc_6.graphics.drawRect(0, 0, param4, param5);
            _loc_6.graphics.endFill();
            _loc_6.x = param2;
            _loc_6.y = param3;
            param1.addChild(_loc_6);
            return _loc_6;
        }// end function

        private function handleRoad(event:MouseEvent) : void
        {
            this.setPage(this._page);
            this.setLayer(2);
            return;
        }// end function

        private function handleOverallRollOver(event:MouseEvent) : void
        {
            this._layer1.addChild(this._overallLayer);
            return;
        }// end function

        private function handleOverallRollOut(event:MouseEvent) : void
        {
            if (this._overallLayer.parent != null)
            {
                this._overallLayer.parent.removeChild(this._overallLayer);
            }
            return;
        }// end function

        private function handleStarUp(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (!this._upEffecting && !this._upLock)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_ACCPRO_UPGRADE);
                ClientSocket.send(_loc_2);
                this._upLock = true;
            }
            return;
        }// end function

        private function handleEatPBRollover(event:MouseEvent) : void
        {
            this._eatPB.addEventListener(MouseEvent.ROLL_OUT, this.handleEatPBRollout);
            var _loc_2:* = Config.language("FollowUpUI", 19);
            var _loc_3:* = new Point(this._eatPB.x, this._eatPB.y);
            _loc_3 = this._eatPB.parent.localToGlobal(_loc_3);
            Holder.showInfo(_loc_2, new Rectangle(_loc_3.x + 55, _loc_3.y + 12, 0, 0), false, 1);
            return;
        }// end function

        private function handleEatPBRollout(event:MouseEvent) : void
        {
            this._eatPB.removeEventListener(MouseEvent.ROLL_OUT, this.handleEatPBRollout);
            Holder.closeInfo();
            return;
        }// end function

        private function handleEatPBRollover1(event:MouseEvent) : void
        {
            this._eatPBRollLayer.addEventListener(MouseEvent.ROLL_OUT, this.handleEatPBRollout1);
            var _loc_2:* = Config.language("FollowUpUI", 20);
            var _loc_3:* = new Point(this._eatPBRollLayer.x, this._eatPBRollLayer.y);
            _loc_3 = this._eatPBRollLayer.parent.localToGlobal(_loc_3);
            Holder.showInfo(_loc_2, new Rectangle(_loc_3.x + 55, _loc_3.y + 12, 0, 0), false, 1);
            return;
        }// end function

        private function handleEatPBRollout1(event:MouseEvent) : void
        {
            this._eatPBRollLayer.removeEventListener(MouseEvent.ROLL_OUT, this.handleEatPBRollout1);
            Holder.closeInfo();
            return;
        }// end function

        private function handleUpPBRollover(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            this._upPBRollLayer.addEventListener(MouseEvent.ROLL_OUT, this.handleUpPBRollout);
            if (this._level == 50 && this._star == 10)
            {
                _loc_2 = Config.language("FollowUpUI", 20);
            }
            else
            {
                _loc_2 = Config.language("FollowUpUI", 21);
            }
            var _loc_3:* = new Point(this._upPB.x, this._upPB.y);
            _loc_3 = this._upPB.parent.localToGlobal(_loc_3);
            Holder.showInfo(_loc_2, new Rectangle(_loc_3.x + 55, _loc_3.y + 12, 0, 0), false, 1);
            return;
        }// end function

        private function handleUpPBRollout(event:MouseEvent) : void
        {
            this._upPBRollLayer.removeEventListener(MouseEvent.ROLL_OUT, this.handleUpPBRollout);
            Holder.closeInfo();
            return;
        }// end function

        private function refresh() : void
        {
            var _loc_4:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = undefined;
            this._upEffecting = false;
            Config.stopLoop(this.upEffectLoop);
            if (this._level == 50 && this._star == 10)
            {
                this.setStar(10);
                this._honorExpandTF.text = Config.language("FollowUpUI", 22, 0);
            }
            else
            {
                this.setStar(this._star < 10 ? (this._star) : (0));
                this._honorExpandTF.text = Config.language("FollowUpUI", 22, Config._followUpMap[(Math.max(1, this._level) - 1) * 10 + this._star + 1].value);
            }
            var _loc_1:* = "#1AD23D";
            this._upPBRollLayer.removeEventListener(MouseEvent.ROLL_OVER, this.handleUpPBRollover);
            if (this._level == 50 && this._star == 10)
            {
                this._upPB.enabled = false;
                this._upPBRollLayer.visible = true;
                this._eatPB.enabled = false;
                this._eatPBRollLayer.visible = true;
                this._upPBRollLayer.addEventListener(MouseEvent.ROLL_OVER, this.handleUpPBRollover);
            }
            else if (this._honor > Config._followUpMap[(Math.max(1, this._level) - 1) * 10 + this._star + 1].value)
            {
                this._upPB.enabled = true;
                this._upPBRollLayer.visible = false;
                this._eatPB.enabled = true;
                this._eatPBRollLayer.visible = false;
            }
            else
            {
                _loc_1 = "#ad1b2e";
                this._upPB.enabled = false;
                this._upPBRollLayer.visible = true;
                this._upPBRollLayer.addEventListener(MouseEvent.ROLL_OVER, this.handleUpPBRollover);
                this._eatPB.enabled = true;
                this._eatPBRollLayer.visible = false;
            }
            this._honorTF.htmlText = Config.language("FollowUpUI", 23, _loc_1, this._honor);
            var _loc_2:* = Config._followUpMap[(Math.max(1, this._level) - 1) * 10 + Math.max(1, this._star)];
            var _loc_3:* = Config._followUpMap[(Math.max(1, this._level) + (this._star == 10 ? (1) : (0))) * 10 + 1];
            this._leftTitleTF.text = _loc_2.name;
            this._leftTitleTF.x = 131 - int(this._leftTitleTF.width / 2);
            if (_loc_3 != null)
            {
                this._rightBG.graphics.clear();
                this._rightBG.graphics.beginFill(16777215, 0.4);
                this._rightBG.graphics.drawRect(0, 0, 218, 228);
                this._rightBG.graphics.endFill();
                this._lockerBmp.visible = false;
                this._arrowBmp.visible = true;
                this._rightLB1.visible = true;
                this._rightTitleTF.text = _loc_3.name;
                this._rightTitleTF.x = 450 - int(this._rightTitleTF.width / 2);
            }
            else
            {
                this._rightBG.graphics.clear();
                this._rightBG.graphics.beginFill(14540253, 1);
                this._rightBG.graphics.drawRect(0, 0, 218, 228);
                this._rightBG.graphics.endFill();
                this._rightTitleTF.text = "";
                this._rightLB1.visible = false;
                this._lockerBmp.visible = true;
                this._arrowBmp.visible = false;
            }
            _loc_4 = 0;
            while (_loc_4 < 4)
            {
                
                this._leftInfoTFs[_loc_4].text = "";
                if (_loc_2["effectId" + (16 + _loc_4)] != 0 && _loc_2["effectValue" + (16 + _loc_4)] != 0)
                {
                    this._leftInfoTFs[_loc_4].text = Config._itemPropMap[_loc_2["effectId" + (16 + _loc_4)]].name + "  +" + _loc_2["effectValue" + (16 + _loc_4)];
                }
                this._rightInfoTFs[_loc_4].text = "";
                if (_loc_3 != null)
                {
                    if (_loc_3["effectId" + (16 + _loc_4)] != 0 && _loc_3["effectValue" + (16 + _loc_4)] != 0)
                    {
                        this._rightInfoTFs[_loc_4].text = Config._itemPropMap[_loc_3["effectId" + (16 + _loc_4)]].name + "  +" + _loc_3["effectValue" + (16 + _loc_4)];
                    }
                }
                _loc_4++;
            }
            if (this._leftInfoTFs[0].text == "")
            {
                this._leftInfoTFs[0].text = Config.language("FollowUpUI", 24);
            }
            if (this._rightInfoTFs[0].text == "")
            {
                this._rightInfoTFs[0].text = Config.language("FollowUpUI", 24);
            }
            var _loc_5:* = "";
            var _loc_6:* = "";
            var _loc_7:* = {};
            var _loc_8:* = 1;
            while (_loc_8 <= (this._level - 1) * 10 + this._star)
            {
                
                _loc_9 = Config._followUpMap[_loc_8];
                _loc_4 = 1;
                while (_loc_4 < 16)
                {
                    
                    if (_loc_9["effectId" + _loc_4] != 0 && _loc_9["effectValue" + _loc_4] != 0)
                    {
                        if (_loc_7[_loc_9["effectId" + _loc_4]] == null)
                        {
                            _loc_7[_loc_9["effectId" + _loc_4]] = 0;
                        }
                        _loc_7[_loc_9["effectId" + _loc_4]] = _loc_7[_loc_9["effectId" + _loc_4]] + _loc_9["effectValue" + _loc_4];
                    }
                    _loc_4++;
                }
                _loc_8++;
            }
            _loc_9 = Config._followUpMap[(this._level - 1) * 10 + this._star];
            if (_loc_9 != null)
            {
                _loc_4 = 16;
                while (_loc_4 < 20)
                {
                    
                    if (_loc_9["effectId" + _loc_4] != 0 && _loc_9["effectValue" + _loc_4] != 0)
                    {
                        if (_loc_7[_loc_9["effectId" + _loc_4]] == null)
                        {
                            _loc_7[_loc_9["effectId" + _loc_4]] = 0;
                        }
                        _loc_7[_loc_9["effectId" + _loc_4]] = _loc_7[_loc_9["effectId" + _loc_4]] + _loc_9["effectValue" + _loc_4];
                    }
                    _loc_4++;
                }
            }
            for (_loc_10 in _loc_7)
            {
                
                if (_loc_5.length > 0)
                {
                    _loc_5 = _loc_5 + "\n";
                    _loc_6 = _loc_6 + "\n";
                }
                _loc_5 = _loc_5 + Config._itemPropMap[_loc_10].name;
                _loc_6 = _loc_6 + ("+" + _loc_7[_loc_10]);
            }
            this._overallLayer.graphics.clear();
            if (_loc_5.length > 0)
            {
                this._overallTF1.text = _loc_5;
                this._overallTF2.text = _loc_6;
                this._overallLayer.graphics.lineStyle(0, 16768355, 0.4, true);
                this._overallLayer.graphics.beginFill(0, 0.8);
                this._overallLayer.graphics.drawRect(0, 0, 163, this._overallTF1.height + this._overallTF1.y + 5);
                this._overallLayer.graphics.endFill();
                this._overallLayer.visible = true;
            }
            else
            {
                this._overallLayer.visible = false;
            }
            if (this._leftClip != null)
            {
                this._leftClip.destroy();
                if (this._leftClip.parent != null)
                {
                    this._leftClip.parent.removeChild(this._leftClip);
                }
                this._leftClip = null;
            }
            this._leftClip = UnitClip.newUnitClip(Config._model[int(_loc_2.model)]);
            this._leftClip.changeStateTo("idle");
            this._leftClip.changeDirectionTo(1);
            this._leftClip.x = 131;
            this._leftClip.y = 225;
            this._leftClip.shadow = false;
            this._layer1.addChild(this._leftClip);
            this._layer1.addChild(this._leftEffectClip);
            if (this._rightClip != null)
            {
                this._rightClip.destroy();
                if (this._rightClip.parent != null)
                {
                    this._rightClip.parent.removeChild(this._rightClip);
                }
                this._rightClip = null;
            }
            if (_loc_3 != null)
            {
                this._rightClip = UnitClip.newUnitClip(Config._model[int(_loc_3.model)]);
                this._rightClip.changeStateTo("idle");
                this._rightClip.changeDirectionTo(1);
                this._rightClip.x = 450;
                this._rightClip.y = 225;
                this._rightClip.shadow = false;
                this._layer1.addChild(this._rightClip);
                this._layer1.addChild(this._rightEffectClip);
            }
            return;
        }// end function

        private function clearClips() : void
        {
            if (this._leftClip != null)
            {
                this._leftClip.destroy();
                if (this._leftClip.parent != null)
                {
                    this._leftClip.parent.removeChild(this._leftClip);
                }
                this._leftClip = null;
            }
            if (this._rightClip != null)
            {
                this._rightClip.destroy();
                if (this._rightClip.parent != null)
                {
                    this._rightClip.parent.removeChild(this._rightClip);
                }
                this._rightClip = null;
            }
            var _loc_1:* = 0;
            while (_loc_1 < this._modeClips.length)
            {
                
                this._modeClips[_loc_1].destroy();
                if (this._modeClips[_loc_1].parent != null)
                {
                    this._modeClips[_loc_1].parent.removeChild(this._modeClips[_loc_1]);
                }
                _loc_1++;
            }
            this._modeClips = [];
            return;
        }// end function

        private function upEffect() : void
        {
            this._upEffecting = true;
            this.setStar(0);
            var _loc_1:* = 0;
            while (_loc_1 < 10)
            {
                
                GClip(this._starEffects[_loc_1]).gotoAndPlay(0, false);
                GClip(this._starEffects[_loc_1]).visible = true;
                _loc_1++;
            }
            this._upEffectCount = 0;
            Config.startLoop(this.upEffectLoop);
            return;
        }// end function

        private function handleEffectOver(param1:UnitClip) : void
        {
            if (param1.parent != null)
            {
                param1.parent.removeChild(param1);
            }
            param1.sleepAnimation();
            return;
        }// end function

        private function upEffectLoop(event:Event) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = Math.max(GClip(this._starEffects[0]).totalFrame, 1);
            var _loc_3:* = _loc_2 + Math.max(this._leftEffectClip.totalFrame, 1);
            if (this._upEffectCount == _loc_2)
            {
                _loc_4 = 0;
                while (_loc_4 < 10)
                {
                    
                    GClip(this._starEffects[_loc_4]).stop();
                    GClip(this._starEffects[_loc_4]).visible = false;
                    _loc_4++;
                }
                this._leftEffectClip.visible = true;
                this._leftEffectClip.gotoAndPlay(0, false);
                this._rightEffectClip.visible = true;
                this._rightEffectClip.gotoAndPlay(0, false);
            }
            else if (this._upEffectCount == _loc_3)
            {
                this._leftEffectClip.visible = false;
                this._leftEffectClip.stop();
                this._rightEffectClip.visible = false;
                this._rightEffectClip.stop();
                this.refresh();
            }
            var _loc_5:* = this;
            var _loc_6:* = this._upEffectCount + 1;
            _loc_5._upEffectCount = _loc_6;
            return;
        }// end function

        private function setStar(param1:int) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < 10)
            {
                
                if (_loc_2 < param1)
                {
                    if (this._stars[_loc_2].parent == null)
                    {
                        this._starContainers[_loc_2].addChild(this._stars[_loc_2]);
                    }
                    if (this._grayStars[_loc_2].parent != null)
                    {
                        this._grayStars[_loc_2].parent.removeChild(this._grayStars[_loc_2]);
                    }
                }
                else
                {
                    if (this._grayStars[_loc_2].parent == null)
                    {
                        this._starContainers[_loc_2].addChild(this._grayStars[_loc_2]);
                    }
                    if (this._stars[_loc_2].parent != null)
                    {
                        this._stars[_loc_2].parent.removeChild(this._stars[_loc_2]);
                    }
                }
                this._stars[_loc_2].alpha = 1;
                this._grayStars[_loc_2].alpha = 1;
                _loc_2++;
            }
            return;
        }// end function

        private function handleHohor(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this._honor = _loc_2.readUnsignedInt();
            this.refresh();
            return;
        }// end function

        private function handleModel(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            if (_loc_3 == 1)
            {
                Config.message(Config.language("FollowUpUI", 25));
            }
            else if (_loc_3 == 2)
            {
                Config.message(Config.language("FollowUpUI", 26));
            }
            this._modelID = _loc_2.readUnsignedInt();
            this.setPage(this._page);
            return;
        }// end function

        private function handleChangeModel(event:Event) : void
        {
            var _loc_2:* = CheckBox(event.currentTarget);
            _loc_2.selected = false;
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_ACCOMPANY_MODEL);
            _loc_3.add32(int(_loc_2.data));
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function handleLevelup(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            if (_loc_3 == 0)
            {
            }
            else if (_loc_3 == 1302)
            {
                Config.message(Config.language("FollowUpUI", 27));
            }
            else if (_loc_3 == 1303)
            {
                Config.message(Config.language("FollowUpUI", 28));
            }
            this._upLock = false;
            return;
        }// end function

        private function initUpInfor(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this._gradeID = _loc_2.readUnsignedInt();
            this._level = _loc_2.readUnsignedByte();
            this._star = _loc_2.readUnsignedByte();
            this._maxID = _loc_2.readUnsignedInt();
            this._honor = _loc_2.readUnsignedInt();
            this._modelID = _loc_2.readUnsignedInt();
            if (_opening)
            {
                if (this._star < 10)
                {
                    this.refresh();
                    this.setPage(this._page);
                }
                else
                {
                    this.upEffect();
                }
            }
            if (this._firstOpen)
            {
                this._firstOpen = false;
                this._page = Math.max(0, int((this._modelID - 1) / 6));
            }
            return;
        }// end function

    }
}
