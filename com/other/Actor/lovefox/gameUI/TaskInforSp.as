package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class TaskInforSp extends Sprite
    {
        private var _canvas:CanvasUI;
        private var _taskobj:Object;
        private var updateobj:Object;
        private var selectitem:Array;
        private var _sflag:int = -1;
        private var upbtn:PushButton;
        private var acolor:int = 3289650;
        private var bcolor:int = 26112;
        private var ccolor:int = 5592535;
        private var dcolor:int = 6710886;
        private var _bg:Sprite;
        private var targsp:Sprite;

        public function TaskInforSp(param1:Object, param2:DisplayObjectContainer = null)
        {
            if (param2 != null)
            {
                param2.addChild(this);
            }
            this._taskobj = param1;
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_3:* = 0;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = 0;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = null;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = null;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = null;
            var _loc_36:* = null;
            var _loc_37:* = null;
            var _loc_38:* = null;
            var _loc_39:* = null;
            var _loc_40:* = null;
            var _loc_41:* = null;
            var _loc_42:* = null;
            var _loc_43:* = null;
            var _loc_44:* = 0;
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_47:* = null;
            var _loc_48:* = null;
            this.updateobj = new Object();
            var _loc_1:* = 0;
            var _loc_2:* = new Label(this, 5, 25, Config._taskMap[this._taskobj.id].title);
            if (int(Config._taskMap[this._taskobj.id].type) == 1 && int(Config._taskMap[this._taskobj.id].acceptType) == 1 && !this._taskobj.hasOwnProperty("relevel") || !this._taskobj.hasOwnProperty("relevel") && int(Config._taskMap[this._taskobj.id].week) > 0)
            {
                _loc_15 = new ClickLabel(this, 230, 25, Config.language("TaskInforSp", 1), this.hidetask, true);
                _loc_15.clickColor([26367, 6837142]);
            }
            this._canvas = new CanvasUI(this, 5, 45, 285, 280);
            this._bg = new Sprite();
            this._canvas.addChildUI(this._bg);
            this._bg.graphics.clear();
            this._bg.graphics.beginFill(16314584, 1);
            this._bg.graphics.lineStyle(1, 16777215);
            _loc_3 = _loc_1;
            _loc_1 = _loc_1 + 5;
            if (this._taskobj.type != 0 && this._taskobj.type != 1 && this._taskobj.type != 2)
            {
                _loc_16 = new LabelUI(null, 10, _loc_1, Config.language("TaskInforSp", 64));
                _loc_16.textColor = 3348992;
                this._canvas.addChildUI(_loc_16);
                _loc_1 = _loc_1 + 22;
                _loc_17 = DistrictMap.sortNearMap(DistrictMap.findMapFromNPC(Config._taskMap[this._taskobj.id].startNPC));
                _loc_18 = 0;
                if (_loc_17 != null)
                {
                    if (_loc_17.length > 0)
                    {
                        _loc_21 = _loc_17[0];
                        _loc_22 = new LabelUI(null, 20, _loc_1, Config._mapMap[DistrictMap.realToMap(_loc_21)].mapData.name);
                        this._canvas.addChildUI(_loc_22);
                        _loc_18 = _loc_22.width;
                    }
                }
                _loc_1 = _loc_1 + 22;
                _loc_19 = new ClickLabel(null, 20, _loc_1, Config._npcMap[Config._taskMap[this._taskobj.id].startNPC].name, this.gotonpc, true);
                _loc_19.clickColor([26367, 6837142]);
                this._canvas.addChildUI(_loc_19);
                _loc_20 = this.getFlyBtn(0);
                _loc_20.x = _loc_19.x + _loc_19.width + 5;
                _loc_20.y = _loc_1;
                this._canvas.addChildUI(_loc_20);
                _loc_1 = _loc_1 + 20;
                this._bg.graphics.drawRoundRect(0, _loc_3, 280, _loc_1 - _loc_3 + 5, 10);
                _loc_1 = _loc_1 + 10;
                _loc_3 = _loc_1;
                _loc_1 = _loc_1 + 5;
            }
            if (this._taskobj.type == 2)
            {
                _loc_23 = new LabelUI(null, 10, _loc_1, Config.language("TaskInforSp", 2));
                _loc_23.textColor = 3348992;
                this._canvas.addChildUI(_loc_23);
                _loc_1 = _loc_1 + 20;
                _loc_24 = new TextAreaUI(null, 10, _loc_1, 260, 200);
                this._canvas.addChildUI(_loc_24);
                _loc_24.autoHeight = true;
                _loc_24.text = DescriptionTranslate.translate(Config._taskMap[this._taskobj.id].finishDialog, _loc_24.mytext);
                _loc_1 = _loc_1 + _loc_24.height;
                this._bg.graphics.drawRoundRect(0, _loc_3, 280, _loc_1 - _loc_3 + 5, 10);
                _loc_3 = _loc_1;
            }
            else
            {
                _loc_16 = new LabelUI(null, 10, _loc_1, Config.language("TaskInforSp", 3));
                _loc_16.textColor = 3348992;
                this._canvas.addChildUI(_loc_16);
                _loc_1 = _loc_1 + 20;
                _loc_25 = new TextAreaUI(null, 10, _loc_1, 260, 200);
                this._canvas.addChildUI(_loc_25);
                _loc_25.autoHeight = true;
                _loc_25.text = DescriptionTranslate.translate(Config._taskMap[this._taskobj.id].goalText, _loc_25.mytext);
                _loc_1 = _loc_1 + _loc_25.height;
                _loc_1 = _loc_1 + 5;
                this.targsp = new Sprite();
                this._canvas.addChildUI(this.targsp);
                this.targsp.x = 0;
                this.targsp.y = _loc_1;
                this.getTarg(this.targsp);
                _loc_1 = _loc_1 + this.targsp.height;
                this._bg.graphics.drawRoundRect(0, _loc_3, 280, _loc_1 - _loc_3 + 5, 10);
                _loc_1 = _loc_1 + 10;
                _loc_3 = _loc_1;
                _loc_1 = _loc_1 + 5;
            }
            var _loc_4:* = new LabelUI(null, 10, _loc_1, Config.language("TaskInforSp", 5));
            new LabelUI(null, 10, _loc_1, Config.language("TaskInforSp", 5)).textColor = 3348992;
            this._canvas.addChildUI(_loc_4);
            _loc_1 = _loc_1 + 20;
            var _loc_5:* = 1;
            switch(this._taskobj.quality)
            {
                case 0:
                {
                    _loc_5 = 1;
                    break;
                }
                case 1:
                {
                    _loc_5 = 2;
                    break;
                }
                case 2:
                {
                    _loc_5 = 4;
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            if (Config._taskMap[this._taskobj.id].hasOwnProperty("awardData"))
            {
                if (int(Config._taskMap[this._taskobj.id].awardData) == 0)
                {
                    if (Config._taskMap[this._taskobj.id].awardMoney != 0)
                    {
                        _loc_6 = int(Config._taskMap[this._taskobj.id].awardMoney) * _loc_5;
                    }
                    if (Config._taskMap[this._taskobj.id].awardMoney2 != 0)
                    {
                        _loc_7 = int(Config._taskMap[this._taskobj.id].awardMoney2) * _loc_5;
                    }
                    if (Config._taskMap[this._taskobj.id].awardLottery != 0)
                    {
                        _loc_8 = int(Config._taskMap[this._taskobj.id].awardLottery) * _loc_5;
                    }
                    if (Config._taskMap[this._taskobj.id].awardLottery != 0)
                    {
                        _loc_9 = int(Config._taskMap[this._taskobj.id].awardLottery2) * _loc_5;
                    }
                    if (Config._taskMap[this._taskobj.id].awardExp != 0)
                    {
                        _loc_10 = int(Config._taskMap[this._taskobj.id].awardExp) * _loc_5;
                    }
                    if (Config._taskMap[this._taskobj.id].gHpoint != 0)
                    {
                        _loc_11 = int(Config._taskMap[this._taskobj.id].gHpoint) * _loc_5;
                    }
                    if (Config._taskMap[this._taskobj.id].tianfu != 0)
                    {
                        _loc_12 = Config._taskMap[this._taskobj.id].tianfu * _loc_5;
                    }
                }
                else
                {
                    switch(int(Config._taskMap[this._taskobj.id].type))
                    {
                        case 0:
                        {
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].mtcoin1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].mtcoin2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].mtcoin3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].mtcoin4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].mtexp) != 0)
                            {
                            }
                            break;
                        }
                        case 1:
                        {
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].etcoin1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].etcoin2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].etcoin3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].etcoin4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].etexp) != 0)
                            {
                            }
                            break;
                        }
                        case 2:
                        {
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].dtcoin1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].dtcoin2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].dtcoin3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].dtcoin4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].dtexp) != 0)
                            {
                            }
                            break;
                        }
                        case 3:
                        {
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].dtcoinbag1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].dtcoinbag2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].dtcoinbag3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].dtcoinbag4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[this._taskobj.id].awardLevel].dtexpbag) != 0)
                            {
                            }
                            if (Config._taskMap[this._taskobj.id].gHpoint != 0)
                            {
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    switch(int(Config._taskMap[this._taskobj.id].type))
                    {
                        case 0:
                        {
                            if (int(Config._ListExp[Config.player.level].mtcoin1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].mtcoin2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].mtcoin3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].mtcoin4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].mtexp) != 0)
                            {
                            }
                            break;
                        }
                        case 1:
                        {
                            if (int(Config._ListExp[Config.player.level].etcoin1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].etcoin2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].etcoin3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].etcoin4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].etexp) != 0)
                            {
                            }
                            break;
                        }
                        case 2:
                        {
                            if (int(Config._ListExp[Config.player.level].dtcoin1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtcoin2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtcoin3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtcoin4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtexp) != 0)
                            {
                            }
                            break;
                        }
                        case 3:
                        {
                            if (int(Config._ListExp[Config.player.level].dtcoinbag1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtcoinbag2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtcoinbag3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtcoinbag4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtexpbag) != 0)
                            {
                            }
                            if (Config._taskMap[this._taskobj.id].gHpoint != 0)
                            {
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            if (_loc_6 != 0)
            {
                _loc_26 = new LabelUI(null, 30, _loc_1, Config.language("TaskInforSp", 6));
                this._canvas.addChildUI(_loc_26);
                _loc_27 = new LabelUI(null, 130, _loc_1, String(_loc_6));
                _loc_27.textColor = 6697728;
                this._canvas.addChildUI(_loc_27);
                _loc_1 = _loc_1 + 20;
            }
            if (_loc_7 != 0)
            {
                _loc_26 = new LabelUI(null, 30, _loc_1, Config.language("TaskInforSp", 7));
                this._canvas.addChildUI(_loc_26);
                _loc_27 = new LabelUI(null, 130, _loc_1, String(_loc_7));
                _loc_27.textColor = 6697728;
                this._canvas.addChildUI(_loc_27);
                _loc_1 = _loc_1 + 20;
            }
            if (_loc_8 != 0)
            {
                _loc_28 = new LabelUI(null, 30, _loc_1, Config.language("TaskInforSp", 8));
                this._canvas.addChildUI(_loc_28);
                _loc_29 = new LabelUI(null, 130, _loc_1, String(_loc_8));
                _loc_29.textColor = 6697728;
                this._canvas.addChildUI(_loc_29);
                _loc_1 = _loc_1 + 20;
            }
            if (_loc_9 != 0)
            {
                _loc_28 = new LabelUI(null, 30, _loc_1, Config.language("TaskInforSp", 9));
                this._canvas.addChildUI(_loc_28);
                _loc_29 = new LabelUI(null, 130, _loc_1, String(_loc_9));
                _loc_29.textColor = 6697728;
                this._canvas.addChildUI(_loc_29);
                _loc_1 = _loc_1 + 20;
            }
            if (_loc_10 != 0)
            {
                _loc_30 = new LabelUI(null, 30, _loc_1, Config.language("TaskInforSp", 10));
                this._canvas.addChildUI(_loc_30);
                _loc_31 = new LabelUI(null, 130, _loc_1, String(_loc_10));
                if (_loc_5 != 1 && Config._taskMap[this._taskobj.id].type == 2 && Config.player.level >= 70)
                {
                    _loc_1 = _loc_1 + 20;
                    _loc_32 = new LabelUI(null, 30, _loc_1);
                    _loc_32.htmlText = Config.language("TaskInforSp", 67) + "                <font color=\'#663300\'>" + _loc_5 * 50 + "</font>";
                    this._canvas.addChildUI(_loc_32);
                }
                _loc_31.textColor = 6697728;
                this._canvas.addChildUI(_loc_31);
                _loc_1 = _loc_1 + 20;
            }
            if (_loc_11 != 0)
            {
                _loc_33 = new LabelUI(null, 30, _loc_1, Config.language("TaskInforSp", 11));
                this._canvas.addChildUI(_loc_33);
                _loc_34 = new LabelUI(null, 130, _loc_1, String(_loc_11));
                _loc_34.textColor = 6697728;
                this._canvas.addChildUI(_loc_34);
                _loc_1 = _loc_1 + 20;
            }
            if (_loc_12 != 0)
            {
                _loc_35 = [1, 1, 0.5, 0.5, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15];
                if (Config._taskMap[this._taskobj.id].type == 4)
                {
                    _loc_12 = int(_loc_35[this._taskobj.daynum] * _loc_12);
                }
                _loc_33 = new LabelUI(null, 30, _loc_1, Config.language("TaskInforSp", 12));
                this._canvas.addChildUI(_loc_33);
                _loc_34 = new LabelUI(null, 130, _loc_1, String(_loc_12));
                _loc_34.textColor = 6697728;
                this._canvas.addChildUI(_loc_34);
                _loc_1 = _loc_1 + 20;
            }
            _loc_1 = _loc_1 + 10;
            if (Config._taskMap[this._taskobj.id].awardItem1 != 0)
            {
                _loc_36 = new LabelUI(null, 30, _loc_1, Config.language("TaskInforSp", 13));
                this._canvas.addChildUI(_loc_36);
                _loc_37 = this.awarditempick(Config._taskMap[this._taskobj.id].awardItem1, Config._taskMap[this._taskobj.id].awardItemNum1);
                this._canvas.addChildUI(_loc_37);
                _loc_37.x = 100;
                _loc_37.y = _loc_1;
                _loc_37.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                _loc_37.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                if (Config._taskMap[this._taskobj.id].awardItem2 != 0)
                {
                    _loc_38 = this.awarditempick(Config._taskMap[this._taskobj.id].awardItem2, Config._taskMap[this._taskobj.id].awardItemNum2);
                    this._canvas.addChildUI(_loc_38);
                    _loc_38.x = 140;
                    _loc_38.y = _loc_1;
                    _loc_38.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                    _loc_38.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    if (Config._taskMap[this._taskobj.id].awardItem3 != 0)
                    {
                        _loc_39 = this.awarditempick(Config._taskMap[this._taskobj.id].awardItem3, Config._taskMap[this._taskobj.id].awardItemNum3);
                        this._canvas.addChildUI(_loc_39);
                        _loc_39.x = 180;
                        _loc_39.y = _loc_1;
                        _loc_39.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                        _loc_39.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    }
                }
                _loc_1 = _loc_1 + 40;
            }
            if (int(Config._taskMap[this._taskobj.id].skill) != 0)
            {
                _loc_40 = new LabelUI(null, 30, _loc_1, Config.language("TaskInforSp", 14));
                this._canvas.addChildUI(_loc_40);
                _loc_41 = this.awardskill(int(Config._taskMap[this.taskid].skill));
                this._canvas.addChildUI(_loc_41);
                _loc_41.x = 100;
                _loc_41.y = _loc_1;
                _loc_1 = _loc_1 + 40;
            }
            if (Config._taskMap[this._taskobj.id].awardItemA != 0)
            {
                this.selectitem = new Array();
                this._sflag = -1;
                _loc_42 = new LabelUI(null, 30, _loc_1, Config.language("TaskInforSp", 15));
                this._canvas.addChildUI(_loc_42);
                _loc_43 = this.awarditempick(Config._taskMap[this._taskobj.id].awardItemA, Config._taskMap[this._taskobj.id].awardItemNumA);
                this._canvas.addChildUI(_loc_43);
                _loc_43.x = 100;
                _loc_43.y = _loc_1;
                this.selectitem.push(_loc_43);
                _loc_43.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                _loc_43.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                if (Config._taskMap[this._taskobj.id].awardItemB != 0)
                {
                    _loc_45 = this.awarditempick(Config._taskMap[this._taskobj.id].awardItemB, Config._taskMap[this._taskobj.id].awardItemNumB);
                    this._canvas.addChildUI(_loc_45);
                    _loc_45.x = 140;
                    _loc_45.y = _loc_1;
                    this.selectitem.push(_loc_45);
                    _loc_45.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                    _loc_45.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    if (Config._taskMap[this._taskobj.id].awardItemC != 0)
                    {
                        _loc_46 = this.awarditempick(Config._taskMap[this._taskobj.id].awardItemC, Config._taskMap[this._taskobj.id].awardItemNumC);
                        this._canvas.addChildUI(_loc_46);
                        _loc_46.x = 180;
                        _loc_46.y = _loc_1;
                        this.selectitem.push(_loc_46);
                        _loc_46.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                        _loc_46.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                        if (Config._taskMap[this._taskobj.id].awardItemD != 0)
                        {
                            _loc_47 = this.awarditempick(Config._taskMap[this._taskobj.id].awardItemD, Config._taskMap[this._taskobj.id].awardItemNumD);
                            this._canvas.addChildUI(_loc_47);
                            _loc_47.x = 220;
                            _loc_47.y = _loc_1;
                            this.selectitem.push(_loc_47);
                            _loc_47.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                            _loc_47.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                            _loc_1 = _loc_1 + 40;
                            if (Config._taskMap[this._taskobj.id].awardItemE != 0)
                            {
                                _loc_48 = this.awarditempick(Config._taskMap[this._taskobj.id].awardItemE, Config._taskMap[this._taskobj.id].awardItemNumE);
                                this._canvas.addChildUI(_loc_46);
                                _loc_48.x = 100;
                                _loc_48.y = _loc_1;
                                this.selectitem.push(_loc_48);
                                _loc_48.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                                _loc_48.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                            }
                        }
                    }
                }
                _loc_1 = _loc_1 + 40;
                _loc_44 = 0;
                while (_loc_44 < this.selectitem.length)
                {
                    
                    this.selectitem[_loc_44].addEventListener(MouseEvent.CLICK, Config.create(this.sawitem, _loc_44));
                    _loc_44 = _loc_44 + 1;
                }
            }
            this._bg.graphics.drawRoundRect(0, _loc_3, 280, _loc_1 - _loc_3 + 5, 10);
            _loc_1 = _loc_1 + 10;
            _loc_3 = _loc_1;
            _loc_1 = _loc_1 + 5;
            var _loc_13:* = new LabelUI(null, 10, _loc_1, Config.language("TaskInforSp", 16));
            new LabelUI(null, 10, _loc_1, Config.language("TaskInforSp", 16)).textColor = 3348992;
            this._canvas.addChildUI(_loc_13);
            _loc_1 = _loc_1 + 20;
            var _loc_14:* = new TextAreaUI(null, 10, _loc_1, 260, 200);
            this._canvas.addChildUI(_loc_14);
            _loc_14.autoHeight = true;
            _loc_14.text = DescriptionTranslate.translate(Config._taskMap[this._taskobj.id].description, _loc_14.mytext);
            _loc_1 = _loc_1 + _loc_14.height;
            if (_loc_1 < 270)
            {
                _loc_1 = 270;
            }
            this._bg.graphics.drawRoundRect(0, _loc_3, 280, _loc_1 - _loc_3 + 5, 10);
            _loc_3 = _loc_1;
            this._bg.graphics.endFill();
            this._canvas.reFresh();
            this.upbtn = new PushButton(null, 110, 330, Config.language("TaskInforSp", 18), this.taskfuc);
            switch(this._taskobj.type)
            {
                case 0:
                {
                    this.upbtn.label = Config.language("TaskInforSp", 19);
                    break;
                }
                case 1:
                {
                    this.upbtn.label = Config.language("TaskInforSp", 20);
                    break;
                }
                case 2:
                {
                    this.upbtn.label = Config.language("TaskInforSp", 20);
                    break;
                }
                case 3:
                {
                    this.upbtn.label = Config.language("TaskInforSp", 21);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getTarg(param1:Sprite) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = null;
            var _loc_23:* = 0;
            var _loc_24:* = null;
            var _loc_25:* = null;
            this.removeallchild(param1);
            _loc_2 = 90;
            _loc_3 = 0;
            var _loc_4:* = new Array();
            var _loc_5:* = true;
            var _loc_6:* = true;
            switch(int(Config._taskMap[this._taskobj.id].exeType))
            {
                case 2:
                {
                    if (this._taskobj.type != 1)
                    {
                        _loc_11 = new Label(null, _loc_2, _loc_3, Config.language("TaskInfor", 22) + Config._taskMap[this._taskobj.id].levelCdt);
                        _loc_11.textColor = this.dcolor;
                        _loc_5 = false;
                        _loc_4.push(_loc_11);
                        _loc_12 = new Label(null, _loc_2, _loc_3, "");
                        _loc_12.textColor = this.dcolor;
                        _loc_4.push(_loc_12);
                    }
                    break;
                }
                case 3:
                {
                    if (Config._taskMap[this._taskobj.id].mapCdt != 0)
                    {
                        _loc_11 = new Label(null, _loc_2, _loc_3, Config.language("TaskInfor", 23));
                        _loc_11.textColor = this.dcolor;
                        _loc_13 = new ClickLabel(null, 45, _loc_3, Config._mapMap[Config._taskMap[this._taskobj.id].mapCdt].mapData.name, Config.create(this.autothistask, this._taskobj.id, 1), false);
                        _loc_13.clickColor([this.acolor, this.ccolor]);
                        _loc_5 = false;
                        if (this._taskobj.type >= 1)
                        {
                            _loc_13.clickColor([this.bcolor, this.ccolor]);
                            _loc_5 = true;
                        }
                        _loc_4.push(_loc_11);
                        _loc_4.push(_loc_13);
                    }
                    break;
                }
                case 0:
                {
                    _loc_7 = int(Config._taskMap[this._taskobj.id].eventCdt);
                    _loc_9 = new ClickLabel(null, _loc_2, _loc_3, "", Config.create(this.autothistask, this._taskobj.id, 1), false);
                    _loc_9.clickColor([this.acolor, this.ccolor]);
                    _loc_4.push(_loc_9);
                    if (_loc_7 == 1)
                    {
                        _loc_8 = Config.language("TaskInfor", 24);
                    }
                    else if (_loc_7 == 2)
                    {
                        _loc_8 = Config.language("TaskInfor", 25);
                    }
                    else if (_loc_7 == 3)
                    {
                        _loc_8 = Config.language("TaskInfor", 26);
                    }
                    else if (_loc_7 == 4)
                    {
                        _loc_8 = Config.language("TaskInfor", 27);
                    }
                    else if (_loc_7 == 5)
                    {
                        _loc_8 = Config.language("TaskInfor", 28);
                    }
                    else if (_loc_7 == 6)
                    {
                        _loc_8 = Config._taskMap[this._taskobj.id].mapCdt + Config.language("TaskInfor", 29);
                    }
                    else if (_loc_7 == 7)
                    {
                        _loc_8 = Config._taskMap[this._taskobj.id].mapCdt + Config.language("TaskInfor", 30);
                    }
                    else if (_loc_7 == 8)
                    {
                        _loc_8 = Config._taskMap[this._taskobj.id].mapCdt + Config.language("TaskInfor", 31);
                    }
                    else if (_loc_7 == 9)
                    {
                        _loc_8 = Config._taskMap[this._taskobj.id].mapCdt + Config.language("TaskInfor", 32);
                    }
                    else if (_loc_7 == 10)
                    {
                        _loc_8 = Config.language("TaskInfor", 33);
                    }
                    else if (_loc_7 == 11)
                    {
                        _loc_8 = Config.language("TaskInfor", 34);
                    }
                    else if (_loc_7 == 12)
                    {
                        _loc_8 = Config.language("TaskInfor", 35);
                    }
                    else if (_loc_7 == 13)
                    {
                        _loc_8 = Config.language("TaskInfor", 36);
                    }
                    else if (_loc_7 == 14)
                    {
                        _loc_8 = Config.language("TaskInfor", 37);
                    }
                    else if (_loc_7 == 15)
                    {
                        _loc_8 = Config.language("TaskInfor", 38);
                    }
                    else if (_loc_7 == 16)
                    {
                        _loc_8 = Config.language("TaskInfor", 39);
                    }
                    else if (_loc_7 == 17)
                    {
                        _loc_8 = Config.language("TaskInfor", 40);
                    }
                    else if (_loc_7 == 18)
                    {
                        _loc_8 = Config.language("TaskInfor", 41);
                    }
                    else if (_loc_7 == 19)
                    {
                        _loc_8 = Config.language("TaskInfor", 42);
                    }
                    else if (_loc_7 == 20)
                    {
                        _loc_8 = Config.language("TaskInfor", 43);
                    }
                    else if (_loc_7 == 21)
                    {
                        _loc_8 = Config.language("TaskInfor", 44);
                    }
                    else if (_loc_7 == 22)
                    {
                        _loc_8 = Config.language("TaskInfor", 45);
                    }
                    else if (_loc_7 == 23)
                    {
                        _loc_8 = Config.language("TaskInfor", 46);
                    }
                    else if (_loc_7 == 24)
                    {
                        _loc_8 = Config.language("TaskInfor", 47);
                    }
                    else if (_loc_7 == 25)
                    {
                        _loc_8 = Config.language("TaskInfor", 48);
                    }
                    else if (_loc_7 == 26)
                    {
                        _loc_8 = Config.language("TaskInfor", 49);
                    }
                    else if (_loc_7 == 27)
                    {
                        _loc_8 = Config.language("TaskInfor", 50);
                    }
                    else if (_loc_7 == 28)
                    {
                        _loc_8 = Config.language("TaskInfor", 51);
                    }
                    else if (_loc_7 == 29)
                    {
                        _loc_8 = Config.language("TaskInfor", 52);
                    }
                    else if (_loc_7 == 30)
                    {
                        _loc_8 = Config.language("TaskInfor", 64);
                    }
                    else if (_loc_7 == 31)
                    {
                        _loc_8 = Config.language("TaskInfor", 65);
                    }
                    else if (_loc_7 == 32)
                    {
                        _loc_8 = Config.language("TaskInfor", 66);
                    }
                    _loc_9.text = _loc_8;
                    _loc_10 = new Label(null, _loc_9.x + _loc_9.width, _loc_3);
                    if (this._taskobj.type == 1)
                    {
                        _loc_10.text = Config._taskMap[this._taskobj.id].mapCdt + "/" + Config._taskMap[this._taskobj.id].mapCdt;
                        _loc_9.clickColor([this.bcolor, this.ccolor]);
                        _loc_10.textColor = this.bcolor;
                    }
                    else
                    {
                        _loc_10.text = this._taskobj.spnum + "/" + Config._taskMap[this._taskobj.id].mapCdt;
                        _loc_5 = false;
                        _loc_10.textColor = this.dcolor;
                    }
                    if (this._taskobj.id == 1644)
                    {
                        _loc_9.text = Config.language("TaskPanel", 125);
                        _loc_10.text = "";
                    }
                    _loc_4.push(_loc_10);
                    break;
                }
                case 4:
                {
                    if (Config._taskMap[this._taskobj.id].mon1 != 0)
                    {
                        _loc_14 = new ClickLabel(null, _loc_2, _loc_3, Config._monsterMap[Config._taskMap[this._taskobj.id].mon1].name, Config.create(this.autothistask, this._taskobj.id, 1), false);
                        _loc_14.clickColor([this.acolor, this.ccolor]);
                        _loc_10 = new Label(null, _loc_14.x + _loc_14.width, _loc_3, String(this._taskobj.hadmon1 + "/" + Config._taskMap[this._taskobj.id].monNum1));
                        _loc_10.textColor = this.dcolor;
                        _loc_6 = false;
                        if (this._taskobj.hadmon1 >= int(Config._taskMap[this._taskobj.id].monNum1))
                        {
                            _loc_14.clickColor([this.bcolor, this.ccolor]);
                            _loc_10.textColor = this.bcolor;
                            _loc_6 = true;
                        }
                        if (!_loc_6)
                        {
                            _loc_5 = false;
                        }
                        _loc_4.push(_loc_14);
                        _loc_4.push(_loc_10);
                        if (Config._taskMap[this._taskobj.id].mon2 != 0)
                        {
                            _loc_15 = new ClickLabel(null, _loc_2, _loc_3, Config._monsterMap[Config._taskMap[this._taskobj.id].mon2].name, Config.create(this.autothistask, this._taskobj.id, 2), false);
                            _loc_15.clickColor([this.acolor, this.ccolor]);
                            _loc_10 = new Label(null, _loc_15.x + _loc_15.width, _loc_3, String(this._taskobj.hadmon2 + "/" + Config._taskMap[this._taskobj.id].monNum2));
                            _loc_10.textColor = this.dcolor;
                            _loc_6 = false;
                            if (this._taskobj.hadmon2 >= int(Config._taskMap[this._taskobj.id].monNum2))
                            {
                                _loc_15.clickColor([this.bcolor, this.ccolor]);
                                _loc_10.textColor = this.bcolor;
                                _loc_6 = true;
                            }
                            if (!_loc_6)
                            {
                                _loc_5 = false;
                            }
                            _loc_4.push(_loc_15);
                            _loc_4.push(_loc_10);
                            if (Config._taskMap[this._taskobj.id].mon3 != 0)
                            {
                                _loc_16 = new ClickLabel(null, _loc_2, _loc_3, Config._monsterMap[Config._taskMap[this._taskobj.id].mon3].name, Config.create(this.autothistask, this._taskobj.id, 3), false);
                                _loc_16.clickColor([this.acolor, this.ccolor]);
                                _loc_10 = new Label(null, _loc_16.x + _loc_16.width, _loc_3, String(this._taskobj.hadmon3 + "/" + Config._taskMap[this._taskobj.id].monNum3));
                                _loc_10.textColor = this.dcolor;
                                _loc_6 = false;
                                if (this._taskobj.hadmon3 >= int(Config._taskMap[this._taskobj.id].monNum3))
                                {
                                    _loc_16.clickColor([this.bcolor, this.ccolor]);
                                    _loc_10.textColor = this.bcolor;
                                    _loc_6 = true;
                                }
                                if (!_loc_6)
                                {
                                    _loc_5 = false;
                                }
                                _loc_4.push(_loc_16);
                                _loc_4.push(_loc_10);
                            }
                        }
                    }
                    break;
                }
                case 5:
                case 6:
                {
                    if (Config._taskMap[this._taskobj.id].item1 != 0)
                    {
                        _loc_17 = new ClickLabel(null, _loc_2, _loc_3, Config._itemMap[Config._taskMap[this._taskobj.id].item1].name, Config.create(this.autothistask, this._taskobj.id, 1), false);
                        _loc_17.clickColor([this.acolor, this.ccolor]);
                        _loc_10 = new Label(null, _loc_17.x + _loc_17.width, _loc_3, String(this._taskobj.haditem1 + "/" + Config._taskMap[this._taskobj.id].itemNum1));
                        _loc_10.textColor = this.dcolor;
                        _loc_6 = false;
                        if (this._taskobj.haditem1 >= int(Config._taskMap[this._taskobj.id].itemNum1))
                        {
                            _loc_17.clickColor([this.bcolor, this.ccolor]);
                            _loc_10.textColor = this.bcolor;
                            _loc_6 = true;
                        }
                        if (!_loc_6)
                        {
                            _loc_5 = false;
                        }
                        _loc_4.push(_loc_17);
                        _loc_4.push(_loc_10);
                        if (Config._taskMap[this._taskobj.id].item2 != 0 && int(Config._taskMap[this._taskobj.id].item2) != int(Config._taskMap[this._taskobj.id].item1))
                        {
                            _loc_18 = new ClickLabel(null, _loc_2, _loc_3, Config._itemMap[Config._taskMap[this._taskobj.id].item2].name, Config.create(this.autothistask, this._taskobj.id, 2), false);
                            _loc_18.clickColor([this.acolor, this.ccolor]);
                            _loc_10 = new Label(null, _loc_18.x + _loc_18.width, _loc_3, String(this._taskobj.haditem2 + "/" + Config._taskMap[this._taskobj.id].itemNum2));
                            _loc_10.textColor = this.dcolor;
                            _loc_6 = false;
                            if (this._taskobj.haditem2 >= int(Config._taskMap[this._taskobj.id].itemNum2))
                            {
                                _loc_18.clickColor([this.bcolor, this.ccolor]);
                                _loc_10.textColor = this.bcolor;
                                _loc_6 = true;
                            }
                            if (!_loc_6)
                            {
                                _loc_5 = false;
                            }
                            _loc_4.push(_loc_18);
                            _loc_4.push(_loc_10);
                            if (Config._taskMap[this._taskobj.id].item3 != 0 && int(Config._taskMap[this._taskobj.id].item3) != int(Config._taskMap[this._taskobj.id].item2))
                            {
                                _loc_19 = new ClickLabel(null, _loc_2, _loc_3, Config._itemMap[Config._taskMap[this._taskobj.id].item3].name, Config.create(this.autothistask, this._taskobj.id, 3), false);
                                _loc_19.clickColor([this.acolor, this.ccolor]);
                                _loc_10 = new Label(null, _loc_19.x + _loc_19.width, _loc_3, String(this._taskobj.haditem3 + "/" + Config._taskMap[this._taskobj.id].itemNum3));
                                _loc_10.textColor = this.dcolor;
                                _loc_6 = false;
                                if (this._taskobj.haditem3 >= int(Config._taskMap[this._taskobj.id].itemNum3))
                                {
                                    _loc_19.clickColor([this.bcolor, this.ccolor]);
                                    _loc_10.textColor = this.bcolor;
                                    _loc_6 = true;
                                }
                                if (!_loc_6)
                                {
                                    _loc_5 = false;
                                }
                                _loc_4.push(_loc_19);
                                _loc_4.push(_loc_10);
                            }
                        }
                    }
                    break;
                }
                case 8:
                {
                    if (Config._taskMap[this._taskobj.id].item1 != 0)
                    {
                        _loc_17 = new ClickLabel(null, _loc_2, _loc_3, Config._itemMap[Config._taskMap[this._taskobj.id].item1].name + this.pStr(Config._taskMap[this._taskobj.id].itemQuality1), Config.create(this.autothistask, this._taskobj.id, 1), false);
                        _loc_17.clickColor([this.acolor, this.ccolor]);
                        _loc_10 = new Label(null, _loc_17.x + _loc_17.width, _loc_3, String(this._taskobj.haditem1 + "/" + Config._taskMap[this._taskobj.id].itemNum1));
                        _loc_10.textColor = this.dcolor;
                        _loc_6 = false;
                        if (this._taskobj.haditem1 >= int(Config._taskMap[this._taskobj.id].itemNum1))
                        {
                            _loc_17.clickColor([this.bcolor, this.ccolor]);
                            _loc_10.textColor = this.bcolor;
                            _loc_6 = true;
                        }
                        if (!_loc_6)
                        {
                            _loc_5 = false;
                        }
                        _loc_4.push(_loc_17);
                        _loc_4.push(_loc_10);
                        if (Config._taskMap[this._taskobj.id].item2 != 0 && int(Config._taskMap[this._taskobj.id].item2) != int(Config._taskMap[this._taskobj.id].item1))
                        {
                            _loc_18 = new ClickLabel(null, _loc_2, _loc_3, Config._itemMap[Config._taskMap[this._taskobj.id].item2].name + this.pStr(Config._taskMap[this._taskobj.id].itemQuality2), Config.create(this.autothistask, this._taskobj.id, 2), false);
                            _loc_18.clickColor([this.acolor, this.ccolor]);
                            _loc_10 = new Label(null, _loc_18.x + _loc_18.width, _loc_3, String(this._taskobj.haditem2 + "/" + Config._taskMap[this._taskobj.id].itemNum2));
                            _loc_10.textColor = this.dcolor;
                            _loc_6 = false;
                            if (this._taskobj.haditem2 >= int(Config._taskMap[this._taskobj.id].itemNum2))
                            {
                                _loc_18.clickColor([this.bcolor, this.ccolor]);
                                _loc_10.textColor = this.bcolor;
                                _loc_6 = true;
                            }
                            if (!_loc_6)
                            {
                                _loc_5 = false;
                            }
                            _loc_4.push(_loc_18);
                            _loc_4.push(_loc_10);
                            if (Config._taskMap[this._taskobj.id].item3 != 0 && int(Config._taskMap[this._taskobj.id].item3) != int(Config._taskMap[this._taskobj.id].item2))
                            {
                                _loc_19 = new ClickLabel(null, _loc_2, _loc_3, Config._itemMap[Config._taskMap[this._taskobj.id].item3].name + this.pStr(Config._taskMap[this._taskobj.id].itemQuality3), Config.create(this.autothistask, this._taskobj.id, 3), false);
                                _loc_19.clickColor([this.acolor, this.ccolor]);
                                _loc_10 = new Label(null, _loc_19.x + _loc_19.width, _loc_3, String(this._taskobj.haditem3 + "/" + Config._taskMap[this._taskobj.id].itemNum3));
                                _loc_10.textColor = this.dcolor;
                                _loc_6 = false;
                                if (this._taskobj.haditem3 >= int(Config._taskMap[this._taskobj.id].itemNum3))
                                {
                                    _loc_19.clickColor([this.bcolor, this.ccolor]);
                                    _loc_10.textColor = this.bcolor;
                                    _loc_6 = true;
                                }
                                if (!_loc_6)
                                {
                                    _loc_5 = false;
                                }
                                _loc_4.push(_loc_19);
                                _loc_4.push(_loc_10);
                            }
                        }
                    }
                    break;
                }
                case 7:
                {
                    if (Config._taskMap[this._taskobj.id].mon1 != 0)
                    {
                        _loc_14 = new ClickLabel(null, _loc_2, _loc_3, Config._monsterMap[Config._taskMap[this._taskobj.id].mon1].name, Config.create(this.autothistask, this._taskobj.id, 1), false);
                        _loc_14.clickColor([this.acolor, this.ccolor]);
                        _loc_10 = new Label(null, _loc_14.x + _loc_14.width, _loc_3, String(this._taskobj.hadmon1 + "/" + Config._taskMap[this._taskobj.id].monNum1));
                        _loc_10.textColor = this.dcolor;
                        _loc_6 = false;
                        if (this._taskobj.hadmon1 >= int(Config._taskMap[this._taskobj.id].monNum1))
                        {
                            _loc_14.clickColor([this.bcolor, this.ccolor]);
                            _loc_10.textColor = this.bcolor;
                            _loc_6 = true;
                        }
                        if (!_loc_6)
                        {
                            _loc_5 = false;
                        }
                        _loc_4.push(_loc_14);
                        _loc_4.push(_loc_10);
                        if (Config._taskMap[this._taskobj.id].mon2 != 0)
                        {
                            _loc_15 = new ClickLabel(null, _loc_2, _loc_3, Config._monsterMap[Config._taskMap[this._taskobj.id].mon2].name, Config.create(this.autothistask, this._taskobj.id, 2), false);
                            _loc_15.clickColor([this.acolor, this.ccolor]);
                            _loc_10 = new Label(null, _loc_15.x + _loc_15.width, _loc_3, String(this._taskobj.hadmon2 + "/" + Config._taskMap[this._taskobj.id].monNum2));
                            _loc_10.textColor = this.dcolor;
                            _loc_6 = false;
                            if (this._taskobj.hadmon2 >= int(Config._taskMap[this._taskobj.id].monNum2))
                            {
                                _loc_15.clickColor([this.bcolor, this.ccolor]);
                                _loc_10.textColor = this.bcolor;
                                _loc_6 = true;
                            }
                            if (!_loc_6)
                            {
                                _loc_5 = false;
                            }
                            _loc_4.push(_loc_15);
                            _loc_4.push(_loc_10);
                            if (Config._taskMap[this._taskobj.id].mon3 != 0)
                            {
                                _loc_16 = new ClickLabel(null, _loc_2, _loc_3, Config._monsterMap[Config._taskMap[this._taskobj.id].mon3].name, Config.create(this.autothistask, this._taskobj.id, 3), false);
                                _loc_16.clickColor([this.acolor, this.ccolor]);
                                _loc_10 = new Label(null, _loc_16.x + _loc_16.width, _loc_3, String(this._taskobj.hadmon3 + "/" + Config._taskMap[this._taskobj.id].monNum3));
                                _loc_10.textColor = this.dcolor;
                                _loc_6 = false;
                                if (this._taskobj.hadmon3 >= int(Config._taskMap[this._taskobj.id].monNum3))
                                {
                                    _loc_16.clickColor([this.bcolor, this.ccolor]);
                                    _loc_10.textColor = this.bcolor;
                                    _loc_6 = true;
                                }
                                if (!_loc_6)
                                {
                                    _loc_5 = false;
                                }
                                _loc_4.push(_loc_16);
                                _loc_4.push(_loc_10);
                            }
                        }
                    }
                    if (Config._taskMap[this._taskobj.id].item1 != 0)
                    {
                        _loc_17 = new ClickLabel(null, _loc_2, _loc_3, Config._itemMap[Config._taskMap[this._taskobj.id].item1].name, Config.create(this.autothistask, this._taskobj.id, 1), false);
                        _loc_17.clickColor([this.acolor, this.ccolor]);
                        _loc_10 = new Label(null, _loc_17.x + _loc_17.width, _loc_3, String(this._taskobj.haditem1 + "/" + Config._taskMap[this._taskobj.id].itemNum1));
                        _loc_10.textColor = this.dcolor;
                        _loc_6 = false;
                        if (this._taskobj.haditem1 >= int(Config._taskMap[this._taskobj.id].itemNum1))
                        {
                            _loc_17.clickColor([this.bcolor, this.ccolor]);
                            _loc_10.textColor = this.bcolor;
                            _loc_6 = true;
                        }
                        if (!_loc_6)
                        {
                            _loc_5 = false;
                        }
                        _loc_4.push(_loc_17);
                        _loc_4.push(_loc_10);
                        if (Config._taskMap[this._taskobj.id].item2 != 0)
                        {
                            _loc_18 = new ClickLabel(null, _loc_2, _loc_3, Config._itemMap[Config._taskMap[this._taskobj.id].item2].name, Config.create(this.autothistask, this._taskobj.id, 2), false);
                            _loc_18.clickColor([this.acolor, this.ccolor]);
                            _loc_10 = new Label(null, _loc_18.x + _loc_18.width, _loc_3, String(this._taskobj.haditem2 + "/" + Config._taskMap[this._taskobj.id].itemNum2));
                            _loc_10.textColor = this.dcolor;
                            _loc_6 = false;
                            if (this._taskobj.haditem2 >= int(Config._taskMap[this._taskobj.id].itemNum2))
                            {
                                _loc_18.clickColor([this.bcolor, this.ccolor]);
                                _loc_10.textColor = this.bcolor;
                                _loc_6 = true;
                            }
                            if (!_loc_6)
                            {
                                _loc_5 = false;
                            }
                            _loc_4.push(_loc_18);
                            _loc_4.push(_loc_10);
                            if (Config._taskMap[this._taskobj.id].item3 != 0)
                            {
                                _loc_19 = new ClickLabel(null, _loc_2, _loc_3, Config._itemMap[Config._taskMap[this._taskobj.id].item3].name, Config.create(this.autothistask, this._taskobj.id, 3), false);
                                _loc_19.clickColor([this.acolor, this.ccolor]);
                                _loc_10 = new Label(null, _loc_19.x + _loc_19.width, _loc_3, String(this._taskobj.haditem3 + "/" + Config._taskMap[this._taskobj.id].itemNum3));
                                _loc_10.textColor = this.dcolor;
                                _loc_6 = false;
                                if (this._taskobj.haditem3 >= int(Config._taskMap[this._taskobj.id].itemNum3))
                                {
                                    _loc_19.clickColor([this.bcolor, this.ccolor]);
                                    _loc_10.textColor = this.bcolor;
                                    _loc_6 = true;
                                }
                                if (!_loc_6)
                                {
                                    _loc_5 = false;
                                }
                                _loc_4.push(_loc_19);
                                _loc_4.push(_loc_10);
                            }
                        }
                    }
                    break;
                }
                case 9:
                {
                    if (Config._taskMap[this._taskobj.id].mon1 != 0 && this._taskobj.random == 1)
                    {
                        _loc_14 = new ClickLabel(null, _loc_2, _loc_3, Config._monsterMap[Config._taskMap[this._taskobj.id].mon1].name, Config.create(this.autothistask, this._taskobj.id, 1), false);
                        _loc_14.clickColor([this.acolor, this.ccolor]);
                        _loc_10 = new Label(null, _loc_14.x + _loc_14.width, _loc_3, String(this._taskobj.hadmon1 + "/" + Config._taskMap[this._taskobj.id].monNum1));
                        _loc_10.textColor = this.dcolor;
                        _loc_6 = false;
                        if (this._taskobj.hadmon1 >= int(Config._taskMap[this._taskobj.id].monNum1))
                        {
                            _loc_14.clickColor([this.bcolor, this.ccolor]);
                            _loc_10.textColor = this.bcolor;
                            _loc_6 = true;
                        }
                        if (!_loc_6)
                        {
                            _loc_5 = false;
                        }
                        _loc_4.push(_loc_14);
                        _loc_4.push(_loc_10);
                    }
                    if (Config._taskMap[this._taskobj.id].mon2 != 0 && this._taskobj.random == 2)
                    {
                        _loc_15 = new ClickLabel(null, _loc_2, _loc_3, Config._monsterMap[Config._taskMap[this._taskobj.id].mon2].name, Config.create(this.autothistask, this._taskobj.id, 2), false);
                        _loc_15.clickColor([this.acolor, this.ccolor]);
                        _loc_10 = new Label(null, _loc_15.x + _loc_15.width, _loc_3, String(this._taskobj.hadmon2 + "/" + Config._taskMap[this._taskobj.id].monNum2));
                        _loc_10.textColor = this.dcolor;
                        _loc_6 = false;
                        if (this._taskobj.hadmon2 >= int(Config._taskMap[this._taskobj.id].monNum2))
                        {
                            _loc_15.clickColor([this.bcolor, this.ccolor]);
                            _loc_10.textColor = this.bcolor;
                            _loc_6 = true;
                        }
                        if (!_loc_6)
                        {
                            _loc_5 = false;
                        }
                        _loc_4.push(_loc_15);
                        _loc_4.push(_loc_10);
                    }
                    if (Config._taskMap[this._taskobj.id].mon3 != 0 && this._taskobj.random == 3)
                    {
                        _loc_16 = new ClickLabel(null, _loc_2, _loc_3, Config._monsterMap[Config._taskMap[this._taskobj.id].mon3].name, Config.create(this.autothistask, this._taskobj.id, 3), false);
                        _loc_16.clickColor([this.acolor, this.ccolor]);
                        _loc_10 = new Label(null, _loc_16.x + _loc_16.width, _loc_3, String(this._taskobj.hadmon3 + "/" + Config._taskMap[this._taskobj.id].monNum3));
                        _loc_10.textColor = this.dcolor;
                        _loc_6 = false;
                        if (this._taskobj.hadmon3 >= int(Config._taskMap[this._taskobj.id].monNum3))
                        {
                            _loc_16.clickColor([this.bcolor, this.ccolor]);
                            _loc_10.textColor = this.bcolor;
                            _loc_6 = true;
                        }
                        if (!_loc_6)
                        {
                            _loc_5 = false;
                        }
                        _loc_4.push(_loc_16);
                        _loc_4.push(_loc_10);
                    }
                    break;
                }
                case 10:
                case 11:
                {
                    if (Config._taskMap[this._taskobj.id].item1 != 0 && this._taskobj.random == 1)
                    {
                        _loc_17 = new ClickLabel(null, _loc_2, _loc_3, Config._itemMap[Config._taskMap[this._taskobj.id].item1].name, Config.create(this.autothistask, this._taskobj.id, 1), false);
                        _loc_17.clickColor([this.acolor, this.ccolor]);
                        _loc_10 = new Label(null, _loc_17.x + _loc_17.width, _loc_3, String(this._taskobj.haditem1 + "/" + Config._taskMap[this._taskobj.id].itemNum1));
                        _loc_10.textColor = this.dcolor;
                        _loc_6 = false;
                        if (this._taskobj.haditem1 >= int(Config._taskMap[this._taskobj.id].itemNum1))
                        {
                            _loc_17.clickColor([this.bcolor, this.ccolor]);
                            _loc_10.textColor = this.bcolor;
                            _loc_6 = true;
                        }
                        if (!_loc_6)
                        {
                            _loc_5 = false;
                        }
                        _loc_4.push(_loc_17);
                        _loc_4.push(_loc_10);
                    }
                    if (Config._taskMap[this._taskobj.id].item2 != 0 && this._taskobj.random == 2)
                    {
                        _loc_18 = new ClickLabel(null, _loc_2, _loc_3, Config._itemMap[Config._taskMap[this._taskobj.id].item2].name, Config.create(this.autothistask, this._taskobj.id, 2), false);
                        _loc_18.clickColor([this.acolor, this.ccolor]);
                        _loc_10 = new Label(null, _loc_18.x + _loc_18.width, _loc_3, String(this._taskobj.haditem2 + "/" + Config._taskMap[this._taskobj.id].itemNum2));
                        _loc_10.textColor = this.dcolor;
                        _loc_6 = false;
                        if (this._taskobj.haditem2 >= int(Config._taskMap[this._taskobj.id].itemNum2))
                        {
                            _loc_18.clickColor([this.bcolor, this.ccolor]);
                            _loc_10.textColor = this.bcolor;
                            _loc_6 = true;
                        }
                        if (!_loc_6)
                        {
                            _loc_5 = false;
                        }
                        _loc_4.push(_loc_18);
                        _loc_4.push(_loc_10);
                    }
                    if (Config._taskMap[this._taskobj.id].item3 != 0 && this._taskobj.random == 3)
                    {
                        _loc_19 = new ClickLabel(null, _loc_2, _loc_3, Config._itemMap[Config._taskMap[this._taskobj.id].item3].name, Config.create(this.autothistask, this._taskobj.id, 3), false);
                        _loc_19.clickColor([this.acolor, this.ccolor]);
                        _loc_10 = new Label(null, _loc_19.x + _loc_19.width, _loc_3, String(this._taskobj.haditem3 + "/" + Config._taskMap[this._taskobj.id].itemNum3));
                        _loc_10.textColor = this.dcolor;
                        _loc_6 = false;
                        if (this._taskobj.haditem3 >= int(Config._taskMap[this._taskobj.id].itemNum3))
                        {
                            _loc_19.clickColor([this.bcolor, this.ccolor]);
                            _loc_10.textColor = this.bcolor;
                            _loc_6 = true;
                        }
                        if (!_loc_6)
                        {
                            _loc_5 = false;
                        }
                        _loc_4.push(_loc_19);
                        _loc_4.push(_loc_10);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_5 || this._taskobj.type == 1)
            {
                _loc_20 = 1;
                _loc_21 = 0;
                while (_loc_21 < _loc_4.length)
                {
                    
                    param1.addChild(_loc_4[_loc_21]);
                    _loc_4[_loc_21].y = _loc_3;
                    if (_loc_21 % 2 > 0)
                    {
                        _loc_23 = int(Config._taskMap[this._taskobj.id].exeType);
                        if ((_loc_23 == 1 || _loc_23 == 4 || _loc_23 == 5 || _loc_23 == 6 || _loc_23 == 7 || _loc_23 == 9 || _loc_23 == 10 || _loc_23 == 11) && this._taskobj.type == 0)
                        {
                            _loc_25 = this.getFlyBtn(_loc_20);
                            _loc_25.x = _loc_4[_loc_21].x + _loc_4[_loc_21].width + 5;
                            _loc_25.y = _loc_3;
                            param1.addChild(_loc_25);
                            _loc_20++;
                        }
                        _loc_3 = _loc_3 + 20;
                    }
                    _loc_21 = _loc_21 + 1;
                }
                _loc_10 = new Label(null, _loc_2, _loc_3, Config.language("TaskInfor", 53));
                param1.addChild(_loc_10);
                _loc_10.textColor = this.dcolor;
                _loc_22 = new ClickLabel(null, _loc_2 + _loc_10.width, _loc_3, Config._npcMap[Config._taskMap[this._taskobj.id].finishNpc].name, Config.create(this.autothistask, this._taskobj.id, 1), false);
                _loc_22.clickColor([this.bcolor, this.ccolor]);
                param1.addChild(_loc_22);
                _loc_23 = int(Config._taskMap[this._taskobj.id].exeType);
                _loc_24 = this.getFlyBtn(1);
                _loc_24.x = _loc_22.x + _loc_22.width + 5;
                _loc_24.y = _loc_3;
                param1.addChild(_loc_24);
                _loc_3 = _loc_3 + 20;
            }
            else
            {
                _loc_20 = 1;
                _loc_21 = 0;
                while (_loc_21 < _loc_4.length)
                {
                    
                    param1.addChild(_loc_4[_loc_21]);
                    _loc_4[_loc_21].y = _loc_3;
                    if (_loc_21 % 2 > 0)
                    {
                        _loc_23 = int(Config._taskMap[this._taskobj.id].exeType);
                        if ((_loc_23 == 1 || _loc_23 == 4 || _loc_23 == 5 || _loc_23 == 6 || _loc_23 == 7 || _loc_23 == 9 || _loc_23 == 10 || _loc_23 == 11) && this._taskobj.type == 0)
                        {
                            _loc_25 = this.getFlyBtn(_loc_20);
                            _loc_25.x = _loc_4[_loc_21].x + _loc_4[_loc_21].width + 5;
                            _loc_25.y = _loc_3;
                            param1.addChild(_loc_25);
                            _loc_20++;
                        }
                        _loc_3 = _loc_3 + 20;
                    }
                    _loc_21 = _loc_21 + 1;
                }
            }
            return;
        }// end function

        private function getFlyBtn(param1:int) : Sprite
        {
            if (this._taskobj.hasOwnProperty("random"))
            {
                if (this._taskobj.random > 0)
                {
                    param1 = this._taskobj.random;
                }
            }
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

        private function awarditempick(param1:int, param2:int = 1)
        {
            var _loc_3:* = new CloneSlot(0, 30);
            var _loc_4:* = Item.newItem(Config._itemMap[param1], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
            Item.newItem(Config._itemMap[param1], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0).display();
            _loc_3.item = _loc_4;
            if (param2 > 1)
            {
                _loc_4.amount = param2;
            }
            return _loc_3;
        }// end function

        private function sawitem(event:MouseEvent, param2:int) : void
        {
            if (this._sflag != param2)
            {
                if (this._sflag != -1)
                {
                    this.selectitem[this._sflag].selected = false;
                }
                this.selectitem[param2].selected = true;
                this._sflag = param2;
            }
            return;
        }// end function

        public function changeNum(param1:int, param2:int, param3:int, param4:int) : void
        {
            if (this._taskobj.id == param1)
            {
                this.getTarg(this.targsp);
            }
            return;
        }// end function

        public function changeType(param1:int) : void
        {
            switch(this._taskobj.type)
            {
                case 0:
                {
                    this.upbtn.label = Config.language("TaskInforSp", 19);
                    break;
                }
                case 1:
                {
                    this.upbtn.label = Config.language("TaskInforSp", 20);
                    break;
                }
                case 2:
                {
                    this.upbtn.label = Config.language("TaskInforSp", 20);
                    break;
                }
                case 3:
                {
                    this.upbtn.label = Config.language("TaskInforSp", 21);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function taskfuc(event:MouseEvent = null) : void
        {
            switch(this._taskobj.type)
            {
                case 0:
                {
                    if (int(Config._taskMap[this._taskobj.id].auto) == 0)
                    {
                        Config.ui._taskpanel.autotaskid = this._taskobj.id;
                    }
                    else
                    {
                        Config.message(Config.language("TaskInforSp", 66));
                    }
                    break;
                }
                case 1:
                {
                    Config.ui._taskpanel.autotaskid = this._taskobj.id;
                    break;
                }
                case 2:
                {
                    this.upbtn.label = Config.language("TaskInforSp", 18);
                    Config.ui._taskpanel.lingshang(this._taskobj.id, this.selectAwardFlag);
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
            return;
        }// end function

        public function get selectAwardFlag() : int
        {
            return this._sflag;
        }// end function

        public function set selectAwardFlag(param1:int) : void
        {
            this._sflag = param1;
            return;
        }// end function

        public function get taskid() : int
        {
            return this._taskobj.id;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_2:* = param1.currentTarget;
            var _loc_3:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
            }
            else if (_loc_2.skill != null)
            {
                Holder.showInfo(_loc_2.skill.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
            }
            return;
        }// end function

        private function handleSlotOut(event:MouseEvent) : void
        {
            Holder.closeInfo();
            return;
        }// end function

        private function hidetask(event:TextEvent) : void
        {
            AlertUI.alert(Config.language("TaskInforSp", 55), Config.language("TaskInforSp", 56), [Config.language("TaskInforSp", 57), Config.language("TaskInforSp", 58)], [this.enterhidtask, null]);
            return;
        }// end function

        private function enterhidtask(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_QUEST_GIVEUP);
            _loc_2.add32(this._taskobj.id);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function awardskill(param1:int) : CloneSlot
        {
            var _loc_2:* = new CloneSlot(0, 32);
            _loc_2.skillId = param1;
            _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            return _loc_2;
        }// end function

        private function fastdone(event:TextEvent, param2:int) : void
        {
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                AlertUI.alert(Config.language("TaskInforSp", 55), Config.language("TaskInfor", 77), [Config.language("TaskInforSp", 57), Config.language("TaskInforSp", 58)], [this.enterfast]);
            }
            else
            {
                AlertUI.alert(Config.language("TaskInforSp", 55), Config.language("TaskInforSp", 59), [Config.language("TaskInforSp", 57), Config.language("TaskInforSp", 58)], [this.enterfast]);
            }
            return;
        }// end function

        private function enterfast(param1) : void
        {
            Config.ui._taskpanel.sendFastDone(this._taskobj.id);
            GuideUI.testDoId(164, Config.ui._radar._mallBtn);
            return;
        }// end function

        private function gotonpc(event:TextEvent) : void
        {
            Hang.hangNpc(Config._taskMap[this._taskobj.id].startNPC);
            return;
        }// end function

        private function flycheck(event:MouseEvent, param2:int) : void
        {
            this.findMap(param2);
            return;
        }// end function

        private function findMap(param1:int) : void
        {
            var _loc_2:* = 0;
            switch(this._taskobj.type)
            {
                case 0:
                {
                    switch(int(Config._taskMap[this._taskobj.id].exeType))
                    {
                        case 1:
                        {
                            _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_NPC, int(Config._taskMap[this._taskobj.id].finishNpc));
                            Config.ui._taskpanel.setMapNext(1, int(Config._taskMap[this._taskobj.id].finishNpc));
                            break;
                        }
                        case 4:
                        case 5:
                        {
                            _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_UNIT, int(Config._taskMap[this._taskobj.id]["mon" + param1]));
                            Config.ui._taskpanel.setMapNext(2, int(Config._taskMap[this._taskobj.id]["mon" + param1]));
                            break;
                        }
                        case 6:
                        case 7:
                        {
                            if (int(Config._taskMap[this._taskobj.id]["mon" + param1]) != 0)
                            {
                                _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_GATHER, int(Config._taskMap[this._taskobj.id]["mon" + param1]));
                                Config.ui._taskpanel.setMapNext(3, int(Config._taskMap[this._taskobj.id]["mon" + param1]));
                            }
                            else
                            {
                                _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_GATHER, int(Config._taskMap[this._taskobj.id]["item" + param1]));
                                Config.ui._taskpanel.setMapNext(3, int(Config._taskMap[this._taskobj.id]["item" + param1]));
                            }
                            break;
                        }
                        case 9:
                        case 10:
                        {
                            if (this._taskobj.random == 1)
                            {
                                _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_UNIT, int(Config._taskMap[this._taskobj.id].mon1));
                                Config.ui._taskpanel.setMapNext(2, int(Config._taskMap[this._taskobj.id].mon1));
                            }
                            else if (this._taskobj.random == 2)
                            {
                                _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_UNIT, int(Config._taskMap[this._taskobj.id].mon2));
                                Config.ui._taskpanel.setMapNext(2, int(Config._taskMap[this._taskobj.id].mon2));
                            }
                            else if (this._taskobj.random == 3)
                            {
                                _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_UNIT, int(Config._taskMap[this._taskobj.id].mon3));
                                Config.ui._taskpanel.setMapNext(2, int(Config._taskMap[this._taskobj.id].mon3));
                            }
                            break;
                        }
                        case 11:
                        {
                            if (this._taskobj.random == 1)
                            {
                                _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_GATHER, int(Config._taskMap[this._taskobj.id].mon1));
                                Config.ui._taskpanel.setMapNext(3, int(Config._taskMap[this._taskobj.id].mon1));
                            }
                            else if (this._taskobj.random == 2)
                            {
                                _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_GATHER, int(Config._taskMap[this._taskobj.id].mon2));
                                Config.ui._taskpanel.setMapNext(3, int(Config._taskMap[this._taskobj.id].mon2));
                            }
                            else if (this._taskobj.random == 3)
                            {
                                _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_GATHER, int(Config._taskMap[this._taskobj.id].mon3));
                                Config.ui._taskpanel.setMapNext(3, int(Config._taskMap[this._taskobj.id].mon3));
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case 1:
                {
                    _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_NPC, int(Config._taskMap[this._taskobj.id].finishNpc));
                    Config.ui._taskpanel.setMapNext(1, int(Config._taskMap[this._taskobj.id].finishNpc));
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param1 == 0 || this._taskobj.type > 1)
            {
                if (int(Config._taskMap[this._taskobj.id].startNPC) > 0)
                {
                    _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_NPC, int(Config._taskMap[this._taskobj.id].startNPC));
                    Config.ui._taskpanel.setMapNext(1, int(Config._taskMap[this._taskobj.id].startNPC));
                }
            }
            if (_loc_2 > 0)
            {
                if (_loc_2 == Config.map._id)
                {
                    Config.message(Config.language("TaskInforSp", 62));
                }
                else
                {
                    Config.ui._zoommap.flyMapAlert(_loc_2);
                }
            }
            else
            {
                switch(int(Config._taskMap[this._taskobj.id]["roadType" + param1]))
                {
                    case 0:
                    {
                        Config.message(Config.language("TaskInforSp", 63));
                        return;
                    }
                    case 1:
                    {
                        _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_NPC, int(Config._taskMap[this._taskobj.id]["road" + param1]));
                        Config.ui._taskpanel.setMapNext(1, int(Config._taskMap[this._taskobj.id]["road" + param1]));
                        break;
                    }
                    case 2:
                    {
                        _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_UNIT, int(Config._taskMap[this._taskobj.id]["road" + param1]));
                        Config.ui._taskpanel.setMapNext(2, int(Config._taskMap[this._taskobj.id]["road" + param1]));
                        break;
                    }
                    case 3:
                    {
                        _loc_2 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_GATHER, int(Config._taskMap[this._taskobj.id]["road" + param1]));
                        Config.ui._taskpanel.setMapNext(3, int(Config._taskMap[this._taskobj.id]["road" + param1]));
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                    case 5:
                    {
                        _loc_2 = int(Config._taskMap[this._taskobj.id]["road" + param1]);
                        break;
                    }
                    case 6:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (_loc_2 > 0)
                {
                    Config.ui._zoommap.flyMapAlert(_loc_2);
                }
                else
                {
                    Config.message(Config.language("TaskInfor", 69));
                }
            }
            return;
        }// end function

        private function autothistask(event:TextEvent, param2:int = 0, param3:int = 1) : void
        {
            if (this._taskobj.type > 1)
            {
                Config.message(Config.language("TaskInfor", 74));
            }
            Config.ui._taskpanel._tasksite = param3;
            Config.ui._taskpanel.autotaskid = param2;
            return;
        }// end function

        private function removeallchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            param1.graphics.clear();
            return;
        }// end function

        private function pStr(param1:int) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = {0:"", 1:"", 2:Config.language("TaskInfor", 70), 4:Config.language("TaskInfor", 71), 8:Config.language("TaskInfor", 72), 16:Config.language("TaskInfor", 73), 30:Config.language("TaskInfor", 70), 28:Config.language("TaskInfor", 71), 24:Config.language("TaskInfor", 73)};
            if (_loc_3[param1] != null)
            {
                _loc_2 = _loc_3[param1];
            }
            return _loc_2;
        }// end function

    }
}
