package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class AnswerUI extends Window
    {
        private var _indexLabel:Label;
        private var _remainTimeLabel:Label;
        private var _scoreLabel:TextField;
        private var _score:int = 0;
        private var _topic:int = 0;
        private var _index:int = 0;
        private var _phDGI:DataGridUI;
        private var _startTime:int;
        private var _questionTF:TextField;
        private var _answers:Array;
        private var _leftTimer:Number;
        private var _preTime:int;
        private var _correctIcon:Bitmap;
        private var _wrongIcon:Bitmap;
        private var _preCountTime:int;
        private var _answered:Boolean;

        public function AnswerUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            this._answers = [];
            super(param1, param2, param3);
            title = Config.language("AnswerUI", 1);
            this.init();
            return;
        }// end function

        private function init()
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_4:* = null;
            resize(580, 360);
            _loc_1 = new Shape();
            _loc_1.graphics.beginFill(13286041, 1);
            _loc_1.graphics.drawRect(0, 0, 328, 149);
            _loc_1.x = 10;
            _loc_1.y = 44;
            addChild(_loc_1);
            _loc_1 = new Shape();
            _loc_1.graphics.beginFill(13286041, 1);
            _loc_1.graphics.drawRect(0, 0, 328, 152);
            _loc_1.x = 10;
            _loc_1.y = 198;
            addChild(_loc_1);
            _loc_1 = new Shape();
            _loc_1.graphics.lineStyle(0, 10322007, 1, true);
            _loc_1.graphics.beginFill(13545600, 1);
            _loc_1.graphics.drawRect(0, 0, 96, 21);
            _loc_1.x = 228;
            _loc_1.y = 165;
            addChild(_loc_1);
            _loc_1 = new Shape();
            _loc_1.graphics.lineStyle(0, 10322007, 1, true);
            _loc_1.graphics.beginFill(13545600, 1);
            _loc_1.graphics.drawRect(0, 0, 100, 35);
            _loc_1.x = 228;
            _loc_1.y = 205;
            addChild(_loc_1);
            _loc_1 = new Shape();
            _loc_1.graphics.beginFill(13286041, 1);
            _loc_1.graphics.drawRect(0, 0, 221, 306);
            _loc_1.x = 345;
            _loc_1.y = 44;
            addChild(_loc_1);
            this._indexLabel = new Label(this, 12, 25, Config.language("AnswerUI", 2));
            _loc_2 = new Label(this, 448, 25, Config.language("AnswerUI", 3));
            this._remainTimeLabel = new Label(this, 250, 167, Config.language("AnswerUI", 4, "18"));
            _loc_2 = new Label(this, 230, 215, Config.language("AnswerUI", 5));
            this._scoreLabel = Config.getSimpleTextField();
            this._scoreLabel.x = 288;
            this._scoreLabel.y = 209;
            this._scoreLabel.defaultTextFormat = new TextFormat(null, 24, 2541383);
            this._scoreLabel.text = "0";
            addChild(this._scoreLabel);
            var _loc_3:* = [{datafield:"index", label:Config.language("AnswerUI", 6), len:55}, {datafield:"name", label:Config.language("AnswerUI", 7), len:100}, {datafield:"score", label:Config.language("AnswerUI", 8), len:43}];
            this._phDGI = new DataGridUI(_loc_3, this, 356, 50, 198, 292, 22);
            this._phDGI.listShow = true;
            _loc_4 = new Bitmap(Config.findIcon("misc/star3", 12, 12));
            var _loc_5:* = new Bitmap(Config.findIcon("misc/star2", 12, 12));
            var _loc_6:* = new Bitmap(Config.findIcon("misc/star2", 12, 12));
            var _loc_9:* = this._phDGI.x + 10;
            _loc_6.x = this._phDGI.x + 10;
            _loc_5.x = _loc_9;
            _loc_4.x = _loc_9;
            var _loc_7:* = 30;
            _loc_4.y = this._phDGI.y + _loc_7;
            _loc_5.y = this._phDGI.y + 27 + _loc_7;
            _loc_6.y = this._phDGI.y + 27 * 2 + _loc_7;
            addChild(_loc_4);
            addChild(_loc_5);
            addChild(_loc_6);
            this._questionTF = Config.getSimpleTextField();
            this._questionTF.wordWrap = true;
            this._questionTF.x = 15;
            this._questionTF.y = 49;
            this._questionTF.width = 325;
            this._questionTF.defaultTextFormat = new TextFormat(null, null, Style.WINDOW_FONT);
            addChild(this._questionTF);
            var _loc_8:* = 0;
            while (_loc_8 < 4)
            {
                
                this._answers[_loc_8] = new Option(_loc_8, this, 15, 250 + 24 * _loc_8, this.handleSelectAnswer);
                _loc_8++;
            }
            this._correctIcon = new Bitmap(Config.findIcon("answer/correct", 78, 44));
            this._correctIcon.visible = false;
            this._correctIcon.x = 240;
            this._correctIcon.y = 260;
            this._wrongIcon = new Bitmap(Config.findIcon("answer/wrong", 75, 35));
            this._wrongIcon.visible = false;
            this._wrongIcon.x = 242;
            this._wrongIcon.y = 265;
            addChild(this._correctIcon);
            addChild(this._wrongIcon);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ASW_STATUS, this.handleOpenClose);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ASW_TOPIC, this.handleTopic);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ASW_GO, this.handleGo);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ASW_ARP, this.handleResult);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ASW_END, this.handleEnd);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_QUIZ_TOPLIST, this.handleTopList);
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open(event);
            this.refreshTopList();
            return;
        }// end function

        private function refreshTopList()
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2B_QUIZ_TOPLIST);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function handleTopList(event:SocketEvent)
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            var _loc_4:* = [];
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = _loc_2.readUnsignedByte();
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_8 = _loc_2.readUnsignedShort();
                _loc_9 = _loc_2.readUTFBytes(_loc_8);
                _loc_10 = _loc_2.readUnsignedInt();
                _loc_4.push({index:_loc_6, name:_loc_9, score:_loc_10});
                _loc_5++;
            }
            this._phDGI.dataProvider = _loc_4;
            return;
        }// end function

        private function handleSelectAnswer(param1)
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_2:* = Option(param1.currentTarget);
            if (_loc_2.enabled)
            {
                _loc_2.selected = true;
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_ASW_ARP);
                _loc_3.add8(int(_loc_2.id));
                ClientSocket.send(_loc_3);
                _loc_4 = 0;
                while (_loc_4 < 4)
                {
                    
                    Option(this._answers[_loc_4]).mouseChildren = false;
                    Option(this._answers[_loc_4]).mouseEnabled = false;
                    _loc_4++;
                }
                this._answered = true;
            }
            return;
        }// end function

        private function handleOpenClose(event:SocketEvent)
        {
            var _loc_4:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            this._startTime = _loc_2.readUnsignedInt();
            if (_loc_3 == 1)
            {
                this._score = 0;
                this._scoreLabel.text = "0";
                this._questionTF.text = "";
                _loc_4 = 0;
                while (_loc_4 < 4)
                {
                    
                    Option(this._answers[_loc_4]).visible = false;
                    _loc_4++;
                }
                this.open();
            }
            else
            {
                clearInterval(this._leftTimer);
            }
            this._correctIcon.visible = false;
            this._wrongIcon.visible = false;
            return;
        }// end function

        private function handleTopic(event:SocketEvent)
        {
            var _loc_4:* = 0;
            var _loc_2:* = event.data;
            this._topic = _loc_2.readUnsignedShort();
            this._index = _loc_2.readUnsignedInt();
            this._indexLabel.text = Config.language("AnswerUI", 9, this._topic);
            this._questionTF.text = Config._quizMap[this._index].question;
            this._answered = false;
            var _loc_3:* = [];
            _loc_4 = 0;
            while (_loc_4 < 4)
            {
                
                _loc_3.push({str:Config._quizMap[this._index]["answer" + (_loc_4 + 1)], id:(_loc_4 + 1)});
                _loc_4++;
            }
            _loc_3 = AdvMath.randomOrder(_loc_3);
            _loc_4 = 0;
            while (_loc_4 < 4)
            {
                
                Option(this._answers[_loc_4]).visible = true;
                Option(this._answers[_loc_4]).enabled = false;
                Option(this._answers[_loc_4]).show = false;
                Option(this._answers[_loc_4]).selected = false;
                Option(this._answers[_loc_4]).label = _loc_3[_loc_4].str;
                Option(this._answers[_loc_4]).id = _loc_3[_loc_4].id;
                _loc_4++;
            }
            if (_opening)
            {
                this.refreshTopList();
            }
            this._correctIcon.visible = false;
            this._wrongIcon.visible = false;
            this._preTime = getTimer();
            clearInterval(this._leftTimer);
            this.timeCount();
            this._leftTimer = setInterval(this.timeCount, 500);
            return;
        }// end function

        private function timeCount()
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = 0;
            var _loc_1:* = getTimer();
            var _loc_2:* = Math.max(0, 18 - int((getTimer() - this._preTime) / 1000));
            this._remainTimeLabel.text = Config.language("AnswerUI", 4, _loc_2);
            if (!this._answered)
            {
                if (this._preCountTime > 0 && _loc_2 <= 0)
                {
                    _loc_3 = this._wrongIcon;
                    _loc_4 = 242;
                    _loc_5 = 265;
                    var _loc_7:* = 4;
                    _loc_3.scaleY = 4;
                    _loc_3.scaleX = _loc_7;
                    _loc_3.x = 140;
                    _loc_3.y = 100;
                    _loc_3.visible = true;
                    TweenLite.to(_loc_3, 0.3, {scaleX:1, scaleY:1, x:_loc_4, y:_loc_5, ease:Quint.easeIn});
                    _loc_6 = 0;
                    while (_loc_6 < 4)
                    {
                        
                        Option(this._answers[_loc_6]).mouseChildren = false;
                        Option(this._answers[_loc_6]).mouseEnabled = false;
                        _loc_6++;
                    }
                }
            }
            this._preCountTime = _loc_2;
            return;
        }// end function

        private function handleGo(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < 4)
            {
                
                Option(this._answers[_loc_4]).enabled = true;
                Option(this._answers[_loc_4]).show = true;
                _loc_4++;
            }
            return;
        }// end function

        private function handleResult(event:SocketEvent)
        {
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = _loc_2.readUnsignedByte();
            if (_loc_2.readUnsignedByte() == 1)
            {
                _loc_8 = _loc_2.readUnsignedInt();
                this._scoreLabel.text = "" + _loc_8;
                _loc_5 = this._correctIcon;
                _loc_6 = 240;
                _loc_7 = 260;
            }
            else
            {
                _loc_5 = this._wrongIcon;
                _loc_6 = 242;
                _loc_7 = 265;
            }
            var _loc_9:* = 4;
            _loc_5.scaleY = 4;
            _loc_5.scaleX = _loc_9;
            _loc_5.x = 140;
            _loc_5.y = 100;
            _loc_5.visible = true;
            TweenLite.to(_loc_5, 0.3, {scaleX:1, scaleY:1, x:_loc_6, y:_loc_7, ease:Quint.easeIn});
            return;
        }// end function

        private function handleEnd(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            this._scoreLabel.text = "" + _loc_3;
            AlertUI.alert(Config.language("AnswerUI", 10), Config.language("AnswerUI", 11, _loc_3, _loc_4), [Config.language("AnswerUI", 12)]);
            clearInterval(this._leftTimer);
            return;
        }// end function

    }
}

import com.bit101.components.*;

import flash.display.*;

import flash.events.*;

import flash.text.*;

import flash.utils.*;

import lovefox.component.*;

import lovefox.socket.*;

class Option extends Sprite
{
    private var _selected:Boolean = false;
    private var _enabled:Boolean = true;
    private var _show:Boolean = true;
    private var _tf:TextField;
    private var _text:String;
    private var _id:int;
    private var _index:int;

    function Option(param1:int, param2:DisplayObjectContainer, param3, param4, param5:Function)
    {
        this._index = param1;
        param2.addChild(this);
        x = param3;
        y = param4;
        this.addEventListener(MouseEvent.CLICK, param5);
        this.init();
        return;
    }// end function

    private function init()
    {
        this.buttonMode = true;
        this._tf = Config.getSimpleTextField();
        this._tf.defaultTextFormat = new TextFormat(null, null, Style.WINDOW_FONT);
        addChild(this._tf);
        return;
    }// end function

    public function set label(param1:String)
    {
        this._text = param1;
        this.setText();
        return;
    }// end function

    private function setText()
    {
        if (this._enabled)
        {
            this._tf.defaultTextFormat = new TextFormat(null, null, Style.WINDOW_FONT);
        }
        else
        {
            this._tf.defaultTextFormat = new TextFormat(null, null, Style.WINDOW_FONT_DISABLE);
        }
        var _loc_1:* = "";
        if (this._enabled)
        {
            if (this._selected)
            {
                _loc_1 = _loc_1 + "●  ";
            }
            else
            {
                _loc_1 = _loc_1 + "○  ";
            }
        }
        else
        {
            _loc_1 = _loc_1 + "      ";
        }
        _loc_1 = _loc_1 + (String.fromCharCode(65 + this._index) + ":");
        if (this._show)
        {
            _loc_1 = _loc_1 + this._text;
        }
        this._tf.text = _loc_1;
        this.graphics.clear();
        if (this._selected)
        {
            this.graphics.lineStyle(3, 10275932, 1, true);
            this.graphics.beginFill(0, 0);
            this.graphics.drawRoundRect(0, 0, Math.max(200, this._tf.width), this._tf.height, 6);
            this.graphics.endFill();
        }
        else
        {
            this.graphics.lineStyle(0, 0, 0);
            this.graphics.beginFill(0, 0);
            this.graphics.drawRect(0, 0, Math.max(200, this._tf.width), this._tf.height);
            this.graphics.endFill();
        }
        return;
    }// end function

    public function set enabled(param1:Boolean)
    {
        this._enabled = param1;
        if (this._enabled)
        {
            this.mouseEnabled = true;
            this.mouseChildren = true;
        }
        else
        {
            this.mouseEnabled = false;
            this.mouseChildren = false;
        }
        this.setText();
        return;
    }// end function

    public function get enabled()
    {
        return this._enabled;
    }// end function

    public function set selected(param1:Boolean)
    {
        this._selected = param1;
        this.setText();
        return;
    }// end function

    public function get selected()
    {
        return this._selected;
    }// end function

    public function set show(param1:Boolean)
    {
        this._show = param1;
        this.setText();
        return;
    }// end function

    public function get show()
    {
        return this._show;
    }// end function

    public function set highlight(param1:Boolean)
    {
        return;
    }// end function

    public function set id(param1:int)
    {
        this._id = param1;
        return;
    }// end function

    public function get id()
    {
        return this._id;
    }// end function

}

