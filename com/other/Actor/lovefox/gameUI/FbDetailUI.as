package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class FbDetailUI extends Window
    {
        private var _rsIt:InputText;
        private var _boutPanel:Sprite;
        private var _boutHandArray:Array;
        private var _boutHandPlayer:ButtonSlot;
        private var _boutHandCom:ButtonSlot;
        private var _boutHandPlayerCurr:Number;
        private var _boutHandComCurr:Number;
        private var _boutInterval:Number;
        private var _boutCount:Number;
        private var _awardPanel:Sprite;
        private var _moneyLabel:Label;
        private var _pokerEffectLayer:Sprite;
        private var _awardSlot:ButtonSlot;
        private var _awardConfirm:PushButton;
        private var _awardInterval:Number;
        private var _awardCount:Number;
        private var _awardCurr:Number;
        private var _awardItem:Number = -1;
        private var _awardItemCount:Number = -1;
        private var _awardStack:Array;
        private var _awardTime:Label;
        private var _awardEXP:Label;
        private var _awardDieCount:Label;
        private var _awardScore:Label;
        private var _awardTimeValue:Object;
        private var _awardEXPValue:Object;
        private var _awardDieCountValue:Object;
        private var _awardScoreValue:Object;
        private var _pokers:Array;
        private var endLabel:Label;
        private var _closeAlertId:int;
        private var _pokerEffectStack:Array;
        private var _pokerEffectPtStack:Array;
        private var _pokerNumMap:Array;
        private var _preAlertIndex:Object;
        private var _pokerClicked:Object;
        private var _pokerRewarded:int = 0;
        private static var ct:ColorTransform = new ColorTransform(1, 1, 1, 0.8, 0, 0, 0, 0);
        private static var _overCMF:Object = new ColorMatrixFilter([1.3, 0, 0, 0, 0, 0, 1.3, 0, 0, 0, 0, 0, 1.3, 0, 0, 0, 0, 0, 1, 0]);

        public function FbDetailUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            this._boutHandArray = [];
            this._awardStack = [];
            this._awardTimeValue = {};
            this._awardEXPValue = {};
            this._awardDieCountValue = {};
            this._awardScoreValue = {};
            this._pokers = [];
            this._pokerEffectStack = [];
            this._pokerEffectPtStack = [];
            this._pokerNumMap = [5, 5, 5];
            super(param1, param2, param3);
            resize(200, 200);
            title = Config.language("FbDetailUI", 1);
            this.initDraw();
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_INSTANCE_BOUT, this.handleBoutReceive);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_INSTANCE_SUCCEED, this.handleSucceed);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_INSTANCE_REWARD, this.handleReward);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BALLCHARGE_NOTICE, this.handleBuyBall);
            return;
        }// end function

        private function handleBuyBall(param1)
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            if (_loc_3 == 1)
            {
                _loc_4 = Config.language("FbDetailUI", 32, 2 - Config.ui._fbEntranceUI._fbPayTime);
                _loc_4 = _loc_4.replace(/\\\
n""\\n/g, "\n");
                AlertUI.alert(Config.language("FbDetailUI", 23), _loc_4, [Config.language("FbDetailUI", 33), Config.language("FbDetailUI", 30)], [this.confirmBuyBall]);
            }
            else if (_loc_3 == 2)
            {
                _loc_4 = Config.language("FbDetailUI", 34);
                _loc_4 = _loc_4.replace(/\\\
n""\\n/g, "\n");
                AlertUI.alert(Config.language("FbDetailUI", 27), _loc_4, [Config.language("FbDetailUI", 10)]);
            }
            return;
        }// end function

        private function confirmBuyBall(param1)
        {
            Config.ui._fbEntranceUI.ballCharge(1);
            return;
        }// end function

        private function handleReward(param1)
        {
            var _loc_7:* = undefined;
            var _loc_9:* = undefined;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedInt();
            var _loc_6:* = _loc_2.readByte();
            if (Player._playerId == _loc_3)
            {
                _loc_7 = this._pokerClicked;
                if (_loc_7 >= this._pokerNumMap[(_loc_6 - 1)] || _loc_7 == null)
                {
                    _loc_7 = int(Math.random() * this._pokerNumMap[(_loc_6 - 1)]);
                }
            }
            else
            {
                _loc_7 = int(Math.random() * this._pokerNumMap[(_loc_6 - 1)]);
                while (_loc_7 == this._pokerClicked)
                {
                    
                    _loc_7 = int(Math.random() * this._pokerNumMap[(_loc_6 - 1)]);
                }
            }
            this._pokerClicked = null;
            var _loc_8:* = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_3);
            if (Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_3) == null)
            {
                _loc_9 = Config.language("FbDetailUI", 18);
            }
            else
            {
                _loc_9 = _loc_8.name;
            }
            this._pokers[_loc_7][(_loc_6 - 1)]._data = {name:_loc_9, itemId:_loc_4, count:_loc_5};
            this.flipPoker(this._pokers[_loc_7][(_loc_6 - 1)], Player._playerId == _loc_3);
            if (_loc_6 < 3)
            {
                var _loc_10:* = this;
                var _loc_11:* = this._pokerRewarded + 1;
                _loc_10._pokerRewarded = _loc_11;
            }
            return;
        }// end function

        private function resetPoker()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            this._pokerNumMap = [5, 5, 5];
            this._pokerClicked = null;
            this._pokerRewarded = 0;
            _loc_1 = 0;
            while (_loc_1 < this._pokers.length)
            {
                
                _loc_2 = 0;
                while (_loc_2 < this._pokers[_loc_1].length)
                {
                    
                    this._pokers[_loc_1][_loc_2].reset();
                    this._pokers[_loc_1][_loc_2].x = this.getPokerX(_loc_1);
                    this._pokers[_loc_1][_loc_2].y = this.getPokerY(_loc_2);
                    this._pokers[_loc_1][_loc_2].buttonMode = true;
                    this._pokers[_loc_1][_loc_2].baseFiler = null;
                    this._pokers[_loc_1][_loc_2].removeEventListener(MouseEvent.ROLL_OVER, this.handlePokerRollOver1);
                    this._pokers[_loc_1][_loc_2].removeEventListener(MouseEvent.ROLL_OUT, this.handlePokerRollOut1);
                    this._pokers[_loc_1][_loc_2].removeEventListener(MouseEvent.CLICK, this.handlePokerClick);
                    this._pokers[_loc_1][_loc_2].addEventListener(MouseEvent.CLICK, this.handlePokerClick);
                    this._pokers[_loc_1][_loc_2].removeEventListener(MouseEvent.ROLL_OVER, this.handlePokerRollOver);
                    this._pokers[_loc_1][_loc_2].removeEventListener(MouseEvent.ROLL_OUT, this.handlePokerRollOut);
                    this._pokers[_loc_1][_loc_2].addEventListener(MouseEvent.ROLL_OVER, this.handlePokerRollOver);
                    this._pokers[_loc_1][_loc_2].addEventListener(MouseEvent.ROLL_OUT, this.handlePokerRollOut);
                    _loc_2 = _loc_2 + 1;
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function initDraw()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_10:* = undefined;
            this._boutPanel = new Sprite();
            _loc_1 = 0;
            while (_loc_1 < 3)
            {
                
                this._boutHandArray[_loc_1] = new ButtonSlot(32);
                this._boutHandArray[_loc_1].x = 80 + _loc_1 * 42;
                this._boutHandArray[_loc_1].setIcon(this.transBout(_loc_1));
                this._boutHandArray[_loc_1].y = 130;
                this._boutPanel.addChild(this._boutHandArray[_loc_1]);
                this._boutHandArray[_loc_1].data = _loc_1;
                this._boutHandArray[_loc_1].addEventListener(MouseEvent.CLICK, this.handleBout);
                this._boutHandArray[_loc_1].addEventListener(MouseEvent.ROLL_OVER, this.handleOver);
                this._boutHandArray[_loc_1].addEventListener(MouseEvent.ROLL_OUT, this.handleOut);
                _loc_1 = _loc_1 + 1;
            }
            _loc_3 = new Panel(this._boutPanel, 20, 30);
            _loc_3.color = 13545363;
            _loc_3.width = 200;
            _loc_3.height = 90;
            _loc_3.roundCorner = 7;
            _loc_4 = new Label(this._boutPanel, 30, 40, Config.language("FbDetailUI", 2));
            _loc_4 = new Label(this._boutPanel, 154, 40, Config.language("FbDetailUI", 3));
            this._boutHandPlayer = new ButtonSlot(32);
            this._boutHandPlayer.setIcon(this.transBout(0), true);
            this._boutHandPlayer.x = 40;
            this._boutHandPlayer.y = 70;
            this._boutHandPlayer.buttonMode = false;
            this._boutPanel.addChild(this._boutHandPlayer);
            this._boutHandCom = new ButtonSlot(32);
            this._boutHandCom.setIcon(this.transBout(0), true);
            this._boutHandCom.x = 168;
            this._boutHandCom.y = 70;
            this._boutHandCom.buttonMode = false;
            this._boutPanel.addChild(this._boutHandCom);
            var _loc_5:* = new Label(this._boutPanel, 100, 60, "<b><font size=\'40\' color=\'" + Style.FONT_Red + "\'>" + "vs" + "</font></b>");
            new Label(this._boutPanel, 100, 60, "<b><font size=\'40\' color=\'" + Style.FONT_Red + "\'>" + "vs" + "</font></b>").html = true;
            this.endLabel = new Label(this._boutPanel, 20, 140);
            this._awardPanel = new Sprite();
            this._awardPanel.graphics.beginFill(4676475, 1);
            this._awardPanel.graphics.drawRoundRect(24, 36, 481, 230, 7);
            this._awardPanel.graphics.endFill();
            this._awardPanel.graphics.beginFill(6307385, 1);
            this._awardPanel.graphics.drawRoundRect(24, 269, 481, 122, 7);
            this._awardPanel.graphics.endFill();
            this._awardPanel.graphics.beginFill(6307385, 1);
            this._awardPanel.graphics.drawRoundRect(24, 394, 138, 20, 7);
            this._awardPanel.graphics.endFill();
            this._pokerEffectLayer = new Sprite();
            this._awardPanel.addChild(this._pokerEffectLayer);
            this._moneyLabel = new Label(this._awardPanel, 28, 396);
            this._moneyLabel.textColor = 16501086;
            var _loc_6:* = Config.findsysUI("poker/poker_blue_p", 77, 105);
            var _loc_7:* = Config.findsysUI("poker/poker_blue_n", 77, 105);
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                _loc_10 = Config.findsysUI("poker/poker_red_p_qq", 77, 105);
            }
            else
            {
                _loc_10 = Config.findsysUI("poker/poker_red_p", 77, 105);
            }
            var _loc_8:* = Config.findsysUI("poker/poker_red_n", 77, 105);
            _loc_1 = 0;
            while (_loc_1 < 5)
            {
                
                this._pokers[_loc_1] = [];
                _loc_2 = 0;
                while (_loc_2 < 3)
                {
                    
                    if (_loc_2 == 2)
                    {
                        this._pokers[_loc_1][_loc_2] = new Poker(_loc_10, _loc_8, _loc_1, _loc_2);
                    }
                    else
                    {
                        this._pokers[_loc_1][_loc_2] = new Poker(_loc_6, _loc_7, _loc_1, _loc_2);
                    }
                    this._awardPanel.addChild(this._pokers[_loc_1][_loc_2]);
                    _loc_2 = _loc_2 + 1;
                }
                _loc_1 = _loc_1 + 1;
            }
            var _loc_9:* = new PushButton(this._awardPanel, 228, 405, Config.language("FbDetailUI", 10), this.handleClose);
            new PushButton(this._awardPanel, 228, 405, Config.language("FbDetailUI", 10), this.handleClose).width = 80;
            return;
        }// end function

        private function getPokerX(param1)
        {
            return 39 + 94 * param1 + 38;
        }// end function

        private function getPokerY(param1)
        {
            if (param1 == 2)
            {
                return 41 + 114 * param1 + 52 + 7;
            }
            return 41 + 114 * param1 + 52;
        }// end function

        private function handlePokerClick(param1)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = Poker(param1.currentTarget);
            if (_loc_2._ypos == 2)
            {
                AlertUI.remove(this._preAlertIndex);
                _loc_3 = Config.language("FbDetailUI", 20);
                if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                {
                    _loc_3 = Config.language("FbDetailUI", 31);
                }
                this._preAlertIndex = AlertUI.alert(Config.language("FbDetailUI", 19), _loc_3, [Config.language("FbDetailUI", 21), Config.language("FbDetailUI", 22)], [this.handlePokerClickDianquan], _loc_2);
            }
            else
            {
                _loc_4 = new DataSet();
                _loc_4.addHead(CONST_ENUM.C2G_INSTANCE_REWARD);
                _loc_4.add8((_loc_2._ypos + 1));
                ClientSocket.send(_loc_4);
                this._pokerClicked = _loc_2._xpos;
            }
            return;
        }// end function

        private function handlePokerClickDianquan(param1:Poker)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_INSTANCE_REWARD);
            _loc_2.add8((param1._ypos + 1));
            ClientSocket.send(_loc_2);
            this._pokerClicked = param1._xpos;
            return;
        }// end function

        private function handlePokerRollOver(param1)
        {
            var _loc_2:* = Poker(param1.currentTarget);
            _loc_2.baseFiler = _overCMF;
            return;
        }// end function

        private function handlePokerRollOut(param1)
        {
            var _loc_2:* = Poker(param1.currentTarget);
            _loc_2.baseFiler = null;
            return;
        }// end function

        private function handlePokerRollOver1(param1)
        {
            var _loc_2:* = Poker(param1.currentTarget);
            Holder.showInfo(_loc_2._info, new Rectangle(_loc_2.x - 16 + x - 2, _loc_2.y - 32 + y - 2, 32, 32), false);
            return;
        }// end function

        private function handlePokerRollOut1(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function flipPoker(param1:Poker, param2 = false)
        {
            var _loc_6:* = undefined;
            param1.removeEventListener(MouseEvent.ROLL_OVER, this.handlePokerRollOver);
            param1.removeEventListener(MouseEvent.ROLL_OUT, this.handlePokerRollOut);
            param1.removeEventListener(MouseEvent.CLICK, this.handlePokerClick);
            param1.baseFiler = null;
            param1.buttonMode = false;
            var _loc_3:* = [];
            var _loc_4:* = param1._xpos;
            var _loc_5:* = param1._ypos;
            param1.move(this.getPokerX(4), 1);
            param1._xpos = 4;
            _loc_3.push(param1);
            _loc_6 = _loc_4 + 1;
            while (_loc_6 < 5)
            {
                
                var _loc_7:* = this._pokers[_loc_6][_loc_5];
                _loc_7._xpos = this._pokers[_loc_6][_loc_5]._xpos - 1;
                this._pokers[_loc_6][_loc_5].move(this.getPokerX(--this._pokers[_loc_6][_loc_5]._xpos));
                _loc_3.push(this._pokers[_loc_6][_loc_5]);
                _loc_6 = _loc_6 + 1;
            }
            _loc_6 = 0;
            while (_loc_6 < _loc_3.length)
            {
                
                this._pokers[_loc_3[_loc_6]._xpos][_loc_3[_loc_6]._ypos] = _loc_3[_loc_6];
                _loc_6 = _loc_6 + 1;
            }
            var _loc_7:* = this._pokerNumMap;
            var _loc_8:* = _loc_5;
            var _loc_9:* = this._pokerNumMap[_loc_5] - 1;
            _loc_7[_loc_8] = _loc_9;
            if (param2)
            {
                _loc_6 = 0;
                while (_loc_6 < 5)
                {
                    
                    this._pokers[_loc_6][_loc_5].removeEventListener(MouseEvent.ROLL_OVER, this.handlePokerRollOver);
                    this._pokers[_loc_6][_loc_5].removeEventListener(MouseEvent.ROLL_OUT, this.handlePokerRollOut);
                    this._pokers[_loc_6][_loc_5].removeEventListener(MouseEvent.CLICK, this.handlePokerClick);
                    this._pokers[_loc_6][_loc_5].buttonMode = false;
                    _loc_6 = _loc_6 + 1;
                }
            }
            param1.removeEventListener(MouseEvent.ROLL_OVER, this.handlePokerRollOver1);
            param1.removeEventListener(MouseEvent.ROLL_OUT, this.handlePokerRollOut1);
            param1.addEventListener(MouseEvent.ROLL_OVER, this.handlePokerRollOver1);
            param1.addEventListener(MouseEvent.ROLL_OUT, this.handlePokerRollOut1);
            return;
        }// end function

        private function setAwardPB(param1)
        {
            if (param1 == 0)
            {
                this._awardConfirm.label = Config.language("FbDetailUI", 9);
            }
            else
            {
                this._awardConfirm.label = Config.language("FbDetailUI", 10);
            }
            return;
        }// end function

        private function handleSucceed(param1)
        {
            trace("handleSucceed");
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedInt();
            var _loc_6:* = _loc_2.readUnsignedInt();
            var _loc_7:* = _loc_2.readUnsignedInt();
            this.resetPoker();
            AlertUI.alert(Config.language("FbDetailUI", 23), Config.language("FbDetailUI", 24, _loc_5), [Config.language("FbDetailUI", 25)], [this.openAward]);
            return;
        }// end function

        private function awardTimeLoop(param1)
        {
            if (this.loopDo(this._awardTime, this._awardTimeValue, 1))
            {
                Config.stopLoop(this.awardTimeLoop);
                Config.startLoop(this.awardDieCount);
            }
            return;
        }// end function

        private function awardDieCount(param1)
        {
            if (this.loopDo(this._awardDieCount, this._awardDieCountValue))
            {
                Config.stopLoop(this.awardDieCount);
                Config.startLoop(this.awardScore);
            }
            return;
        }// end function

        private function awardScore(param1)
        {
            if (this.loopDo(this._awardScore, this._awardScoreValue, 2))
            {
                Config.stopLoop(this.awardScore);
                Config.startLoop(this.awardEXP);
            }
            return;
        }// end function

        private function awardEXP(param1)
        {
            if (this.loopDo(this._awardEXP, this._awardEXPValue, 2))
            {
                Config.stopLoop(this.awardEXP);
            }
            return;
        }// end function

        private function loopDo(param1, param2, param3 = 0)
        {
            param2.now = param2.now + Math.ceil((param2.max - param2.now) / 4);
            if (Math.abs(param2.max - param2.now) <= 3)
            {
                param2.now = param2.max;
            }
            if (param3 == 1)
            {
                param1.text = Config.timeShow(param2.now, 2);
            }
            else if (param3 == 2)
            {
                param1.text = Config.coinShow(param2.now);
            }
            else
            {
                param1.text = String(param2.now);
            }
            param1.x = 170 - param1.width;
            return param2.now == param2.max;
        }// end function

        public function setAwardDrop(param1)
        {
            var _loc_2:* = undefined;
            this._awardStack = [];
            var _loc_3:* = Config._dropMap[param1];
            for (_loc_2 in _loc_3)
            {
                
                this._awardStack.push(Number(_loc_3[_loc_2].item));
            }
            this.startAwardSelect();
            return;
        }// end function

        private function selectAwardDrop(param1, param2 = 1)
        {
            this._awardItem = param1;
            this._awardItemCount = param2;
            var _loc_3:* = String(Config._itemMap[this._awardItem].icon);
            if (_loc_3.indexOf("|") != -1)
            {
                _loc_3 = _loc_3.split("|")[0];
            }
            this._awardSlot.setIcon(_loc_3, true);
            this._awardSlot.removeEventListener(MouseEvent.ROLL_OVER, this.handleAwardSlotRollOver);
            this._awardSlot.removeEventListener(MouseEvent.ROLL_OUT, this.handleAwardSlotRollOut);
            this._awardSlot.addEventListener(MouseEvent.ROLL_OVER, this.handleAwardSlotRollOver);
            this._awardSlot.addEventListener(MouseEvent.ROLL_OUT, this.handleAwardSlotRollOut);
            Config.message(Config.language("FbDetailUI", 11) + this._awardItemCount + Config.language("FbDetailUI", 12) + String(Config._itemMap[this._awardItem].name));
            this.setAwardPB(1);
            this.stopAwardSelect();
            return;
        }// end function

        private function startAwardSelect()
        {
            this._awardInterval = 10;
            this._awardCount = 0;
            this._awardCurr = 0;
            this._awardItem = -1;
            this._awardSlot.removeEventListener(MouseEvent.ROLL_OVER, this.handleAwardSlotRollOver);
            this._awardSlot.removeEventListener(MouseEvent.ROLL_OUT, this.handleAwardSlotRollOut);
            this.awardSelectLoop();
            Config.startLoop(this.awardSelectLoop);
            return;
        }// end function

        private function stopAwardSelect()
        {
            Config.stopLoop(this.awardSelectLoop);
            return;
        }// end function

        private function handleAwardSlotRollOver(param1)
        {
            var _loc_2:* = Config._itemMap[this._awardItem];
            var _loc_3:* = this._awardSlot;
            if (_loc_2.description == null)
            {
                Holder.showInfo("" + _loc_2.name, new Rectangle(_loc_3.x + _loc_3.parent.x + _loc_3.parent.parent.x, _loc_3.y + _loc_3.parent.y + _loc_3.parent.parent.y, _loc_3._size, _loc_3._size), true);
            }
            else
            {
                Holder.showInfo(_loc_2.name + "\n<font color=\'#28d0e4\'>" + _loc_2.description + "</font>", new Rectangle(_loc_3.x + _loc_3.parent.x + _loc_3.parent.parent.x, _loc_3.y + _loc_3.parent.y + _loc_3.parent.parent.y, _loc_3._size, _loc_3._size), true);
            }
            return;
        }// end function

        private function handleAwardSlotRollOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function awardSelectLoop(param1 = null)
        {
            var _loc_2:* = undefined;
            if (this._awardCount <= 0)
            {
                if (this._awardItem < 0)
                {
                    if (this._awardInterval > 5)
                    {
                        this._awardInterval = this._awardInterval - 2;
                    }
                }
                this._awardCount = this._awardInterval;
                _loc_2 = String(Config._itemMap[this._awardStack[this._awardCurr]].icon);
                if (_loc_2.indexOf("|") != -1)
                {
                    _loc_2 = _loc_2.split("|")[0];
                }
                this._awardSlot.setIcon(_loc_2, true);
                var _loc_3:* = this;
                var _loc_4:* = this._awardCurr + 1;
                _loc_3._awardCurr = _loc_4;
                if (this._awardCurr >= this._awardStack.length)
                {
                    this._awardCurr = 0;
                }
            }
            else
            {
                var _loc_3:* = this;
                var _loc_4:* = this._awardCount - 1;
                _loc_3._awardCount = _loc_4;
            }
            return;
        }// end function

        private function startBoutSelect()
        {
            this._boutInterval = 20;
            this._boutCount = this._boutInterval;
            this._boutHandPlayerCurr = Math.floor(Math.random() * 3);
            this._boutHandComCurr = Math.floor(Math.random() * 3);
            this.boutSelectLoop();
            Config.startLoop(this.boutSelectLoop);
            return;
        }// end function

        private function stopBoutSelect()
        {
            Config.stopLoop(this.boutSelectLoop);
            return;
        }// end function

        private function boutSelectLoop(param1 = null)
        {
            var _loc_2:* = undefined;
            if (this._boutCount <= 0)
            {
                if (this._boutInterval > 5)
                {
                    this._boutInterval = this._boutInterval - 2;
                }
                this._boutCount = this._boutInterval;
                _loc_2 = Math.floor(Math.random() * 3);
                do
                {
                    
                    _loc_2 = Math.floor(Math.random() * 3);
                }while (_loc_2 == this._boutHandPlayerCurr)
                this._boutHandPlayerCurr = _loc_2;
                this._boutHandPlayer.setIcon(this.transBout(this._boutHandPlayerCurr), true);
                _loc_2 = Math.floor(Math.random() * 3);
                do
                {
                    
                    _loc_2 = Math.floor(Math.random() * 3);
                }while (_loc_2 == this._boutHandComCurr)
                this._boutHandComCurr = _loc_2;
                this._boutHandCom.setIcon(this.transBout(this._boutHandComCurr), true);
            }
            else
            {
                var _loc_3:* = this;
                var _loc_4:* = this._boutCount - 1;
                _loc_3._boutCount = _loc_4;
            }
            return;
        }// end function

        public function openBout()
        {
            this.clear();
            title = Config.language("FbDetailUI", 1);
            resize(240, 180);
            this.startBoutSelect();
            addChild(this._boutPanel);
            this.closable = true;
            this.endLabel.text = Config.language("FbDetailUI", 13);
            var _loc_1:* = 0;
            while (_loc_1 < 3)
            {
                
                this._boutHandArray[_loc_1].visible = true;
                _loc_1 = _loc_1 + 1;
            }
            this.open();
            return;
        }// end function

        public function openAward(param1 = null)
        {
            this.clear();
            title = Config.language("FbDetailUI", 14);
            resize(532, 438);
            addChild(this._awardPanel);
            this.closable = false;
            this.open();
            if (Config.player != null)
            {
                Config.player.removeEventListener("move", this.handlePlayerMove);
            }
            return;
        }// end function

        private function clear()
        {
            Config.stopLoop(this.awardTimeLoop);
            Config.stopLoop(this.awardDieCount);
            Config.stopLoop(this.awardScore);
            Config.stopLoop(this.awardEXP);
            this.stopAwardSelect();
            this.stopBoutSelect();
            if (this._awardPanel.parent != null)
            {
                this._awardPanel.parent.removeChild(this._awardPanel);
            }
            if (this._boutPanel.parent != null)
            {
                this._boutPanel.parent.removeChild(this._boutPanel);
            }
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open(event);
            if (Config.player != null)
            {
                if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                {
                }
                else
                {
                    this._moneyLabel.text = Config.language("FbDetailUI", 26) + Config.coinShow(Config.player.money1);
                }
                Config.player.removeEventListener("move", this.handlePlayerMove);
                Config.player.addEventListener("move", this.handlePlayerMove);
                Config.player.removeEventListener("update", this.updatemoney);
                Config.player.addEventListener("update", this.updatemoney);
            }
            return;
        }// end function

        private function updatemoney(param1)
        {
            if (param1.param == "money1")
            {
                if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                {
                }
                else
                {
                    this._moneyLabel.text = Config.language("FbDetailUI", 26) + Config.coinShow(param1.value);
                }
            }
            return;
        }// end function

        override public function close()
        {
            if (Config.player != null)
            {
                Config.player.removeEventListener("move", this.handlePlayerMove);
                Config.player.removeEventListener("update", this.updatemoney);
            }
            this.clear();
            super.close();
            return;
        }// end function

        private function handleClose(param1)
        {
            if (this._pokerRewarded < 2)
            {
                AlertUI.remove(this._closeAlertId);
                this._closeAlertId = AlertUI.alert(Config.language("FbDetailUI", 27), Config.language("FbDetailUI", 28, 2 - this._pokerRewarded), [Config.language("FbDetailUI", 29), Config.language("FbDetailUI", 30)], [this.realClose]);
            }
            else
            {
                this.close();
            }
            return;
        }// end function

        private function realClose(param1)
        {
            this.close();
            return;
        }// end function

        private function handlePlayerMove(param1)
        {
            this.close();
            Config.ui._bagUI.close();
            return;
        }// end function

        private function handleBoutReceive(param1)
        {
            this.stopBoutSelect();
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readByte();
            var _loc_5:* = _loc_2.readByte();
            this._boutHandPlayer.setIcon(this.transBout(_loc_3), true);
            this._boutHandCom.setIcon(this.transBout(_loc_4), true);
            switch(_loc_5)
            {
                case 0:
                {
                    this.endLabel.text = Config.language("FbDetailUI", 15);
                    break;
                }
                case 1:
                {
                    this.endLabel.text = Config.language("FbDetailUI", 16);
                    break;
                }
                case 2:
                {
                    this.endLabel.text = Config.language("FbDetailUI", 17);
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_6:* = 0;
            while (_loc_6 < 3)
            {
                
                this._boutHandArray[_loc_6].visible = false;
                _loc_6 = _loc_6 + 1;
            }
            return;
        }// end function

        private function transBout(param1)
        {
            if (param1 == 0)
            {
                return "bout0";
            }
            if (param1 == 1)
            {
                return "bout1";
            }
            if (param1 == 2)
            {
                return "bout2";
            }
            return;
        }// end function

        private function handleBout(event:Event)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_INSTANCE_BOUT);
            _loc_2.add32(Npc._npcId);
            _loc_2.add8(event.currentTarget.data);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function handleOver(event:Event) : void
        {
            event.currentTarget.setColorBorder(Style.FONT_3int_Orange, Style.FONT_3int_Orange - 50);
            return;
        }// end function

        private function handleOut(event:Event) : void
        {
            event.currentTarget.setColorBorder(null);
            return;
        }// end function

        public function afterEffect(param1:Rectangle, param2)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = {};
            {}._aCanvas = new Sprite();
            _loc_5._aBmp = new BitmapData(param1.width + 100, param1.height + 100, true, 0);
            _loc_5.bmp = new Bitmap(_loc_5._aBmp);
            _loc_5.bmp.x = param1.x - 50 - param1.width / 2;
            _loc_5.bmp.y = param1.y - 50 - param1.height / 2;
            this._pokerEffectLayer.addChild(_loc_5.bmp);
            _loc_5._aPtArray = [];
            var _loc_6:* = int(param1.width / 2) + 50;
            var _loc_7:* = int(param1.height / 2) + 50;
            _loc_3 = 50;
            while (_loc_3 < param1.width + 50)
            {
                
                this.makePT(_loc_5, _loc_3, 50, Math.atan2(50 - _loc_7, _loc_3 - _loc_6), param2);
                _loc_3 = _loc_3 + int(Math.random() * 10);
            }
            _loc_3 = 50;
            while (_loc_3 < param1.width + 50)
            {
                
                this.makePT(_loc_5, _loc_3, param1.height + 50, Math.atan2(param1.height + 50 - _loc_7, _loc_3 - _loc_6), param2);
                _loc_3 = _loc_3 + int(Math.random() * 10);
            }
            _loc_3 = 50;
            while (_loc_3 < param1.height + 50)
            {
                
                this.makePT(_loc_5, 50, _loc_3, Math.atan2(_loc_3 - _loc_7, 50 - _loc_6), param2);
                _loc_3 = _loc_3 + int(Math.random() * 10);
            }
            _loc_3 = 50;
            while (_loc_3 < param1.height + 50)
            {
                
                this.makePT(_loc_5, param1.width + 50, _loc_3, Math.atan2(_loc_3 - _loc_7, param1.width + 50 - _loc_6), param2);
                _loc_3 = _loc_3 + int(Math.random() * 10);
            }
            _loc_5._count = 30;
            this._pokerEffectStack.push(_loc_5);
            Config.startLoop(this.afterEffectLoop);
            return;
        }// end function

        private function makePT(param1, param2, param3, param4, param5)
        {
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            if (this._pokerEffectPtStack.length > 0)
            {
                _loc_8 = this._pokerEffectPtStack.shift();
                _loc_7 = _loc_8.shape;
                _loc_9 = new Matrix();
                _loc_9.createGradientBox(8, 8, 0, -4, -4);
                _loc_7.graphics.clear();
                _loc_7.graphics.beginGradientFill(GradientType.RADIAL, [16777215, 16777215], [1, 0], [0, 255], _loc_9);
                _loc_7.graphics.drawCircle(0, 0, 4);
                _loc_7.graphics.endFill();
                _loc_7.x = param2;
                _loc_7.y = param3;
                _loc_7.filters = [new GlowFilter(param5, 1, 20, 20, 5, 1)];
                param1._aCanvas.addChild(_loc_7);
                var _loc_10:* = param4;
                _loc_8.angle = param4;
                _loc_8.initAngle = _loc_10;
                _loc_8.speed = Math.random() * 5 + 2;
                _loc_8.acc = 0;
                param1._aPtArray.push(_loc_8);
            }
            else
            {
                _loc_7 = new Shape();
                _loc_9 = new Matrix();
                _loc_9.createGradientBox(8, 8, 0, -4, -4);
                _loc_7.graphics.clear();
                _loc_7.graphics.beginGradientFill(GradientType.RADIAL, [16777215, 16777215], [1, 0], [0, 255], _loc_9);
                _loc_7.graphics.drawCircle(0, 0, 4);
                _loc_7.graphics.endFill();
                _loc_7.x = param2;
                _loc_7.y = param3;
                _loc_7.filters = [new GlowFilter(param5, 1, 20, 20, 5, 1)];
                param1._aCanvas.addChild(_loc_7);
                param1._aPtArray.push({shape:_loc_7, initAngle:param4, angle:param4, speed:Math.random() * 5 + 2, acc:0});
            }
            return;
        }// end function

        private function afterEffectLoop(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = null;
            _loc_3 = 0;
            while (_loc_3 < this._pokerEffectStack.length)
            {
                
                _loc_6 = this._pokerEffectStack[_loc_3];
                _loc_7 = _loc_6._aPtArray;
                _loc_8 = _loc_6._count;
                _loc_9 = _loc_6._aBmp;
                _loc_10 = _loc_6._aCanvas;
                _loc_2 = 0;
                while (_loc_2 < _loc_7.length)
                {
                    
                    _loc_4 = _loc_7[_loc_2].shape;
                    _loc_5 = (_loc_8 - 20) / 10;
                    _loc_11 = new Matrix();
                    _loc_11.createGradientBox(8 * _loc_5, 8 * _loc_5, 0, -4 * _loc_5, -4 * _loc_5);
                    _loc_4.graphics.clear();
                    _loc_4.graphics.beginGradientFill(GradientType.RADIAL, [16777215, 16777215], [1 * _loc_5, 0], [0, 255], _loc_11);
                    _loc_4.graphics.drawCircle(0, 0, 4 * _loc_5);
                    _loc_4.graphics.endFill();
                    _loc_7[_loc_2].acc = _loc_7[_loc_2].acc + (Math.random() * 0.4 - 0.2 - (_loc_7[_loc_2].angle - _loc_7[_loc_2].initAngle) / 5);
                    _loc_7[_loc_2].angle = _loc_7[_loc_2].angle + _loc_7[_loc_2].acc / Math.sqrt(Math.max(0.2, _loc_4.alpha));
                    _loc_4.x = _loc_4.x + Math.cos(_loc_7[_loc_2].angle) * _loc_7[_loc_2].speed;
                    _loc_4.y = _loc_4.y + Math.sin(_loc_7[_loc_2].angle) * _loc_7[_loc_2].speed;
                    _loc_7[_loc_2].speed = _loc_7[_loc_2].speed * 0.8;
                    _loc_2 = _loc_2 + 1;
                }
                if (_loc_8 == 20)
                {
                    _loc_2 = 0;
                    while (_loc_2 < _loc_7.length)
                    {
                        
                        this._pokerEffectPtStack.push(_loc_7[_loc_2]);
                        _loc_7[_loc_2].shape.parent.removeChild(_loc_7[_loc_2].shape);
                        _loc_2 = _loc_2 + 1;
                    }
                    _loc_6._aPtArray = [];
                }
                if (_loc_8 == 0)
                {
                    _loc_9.dispose();
                    _loc_6.bmp.parent.removeChild(_loc_6.bmp);
                    this._pokerEffectStack.splice(_loc_3, 1);
                    _loc_3 = _loc_3 - 1;
                }
                else
                {
                    var _loc_12:* = _loc_6;
                    var _loc_13:* = _loc_6._count - 1;
                    _loc_12._count = _loc_13;
                    _loc_9.colorTransform(_loc_9.rect, ct);
                    _loc_9.draw(_loc_10);
                }
                _loc_3 = _loc_3 + 1;
            }
            if (this._pokerEffectStack.length == 0)
            {
                Config.stopLoop(this.afterEffectLoop);
            }
            return;
        }// end function

    }
}
