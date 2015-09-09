package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;

    public class GuideUI extends Sprite
    {
        private var _msgLB:RichTextField;
        private var _nameLB:TextField;
        private var _headBmp:Bitmap;
        private var _bg:Shape;
        private var _container:Object;
        private var _closePB:PushButton;
        private static var _guideFinalBuff:Object = {};
        private static var _oldLabel:Array = [];
        private static var _oldLabelTemp:Array = [];
        private static var _ui:GuideUI;
        private static var _screenWidth:Object;
        private static var _screenHeight:Object;
        private static var _buffId:Object;
        private static var _buffXML:Object;
        private static var _buffObj:Object;
        public static var _nextObjArray:Object;
        private static var _ready:Boolean = false;
        private static var _closeTimer:Object;
        private static var _preWindow:Window;

        public function GuideUI(param1)
        {
            this._container = param1;
            this.initDraw();
            _ui = this;
            x = 100;
            if (_screenHeight == null)
            {
                y = Config.ui._height / 2 - 100;
            }
            else
            {
                y = _screenHeight / 2 - 100;
            }
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SEND_UESRACT, handleReadAct);
            return;
        }// end function

        public function open()
        {
            if (parent == null)
            {
                this._container.addChild(this);
            }
            return;
        }// end function

        public function close()
        {
            if (parent != null)
            {
                parent.removeChild(this);
            }
            return;
        }// end function

        private function initDraw()
        {
            this._bg = new Shape();
            addChild(this._bg);
            this._msgLB = new RichTextField(160, 120);
            this._msgLB.selectable = false;
            this._msgLB.x = 77;
            this._msgLB.y = 25;
            this._msgLB.textColor = Style.WHITE_FONT;
            this._msgLB.mouseEnabled = false;
            this._msgLB.mouseChildren = false;
            this._nameLB = Config.getSimpleTextField();
            this._nameLB.height = 20;
            this._nameLB.x = 77;
            this._nameLB.y = 5;
            this._nameLB.textColor = Style.WHITE_FONT;
            addChild(this._nameLB);
            addChild(this._msgLB);
            this._headBmp = new Bitmap(null, "auto", true);
            this._headBmp.x = 1;
            this._headBmp.y = 19;
            addChild(this._headBmp);
            var _loc_1:* = 0.5;
            this._headBmp.scaleY = 0.5;
            this._headBmp.scaleX = _loc_1;
            this._closePB = new PushButton(this, 220, 5, "");
            this._closePB.overshow = true;
            this._closePB.setStyle(Config.findUI("window")["closebutton"]);
            this.addEventListener(MouseEvent.CLICK, this.handleClose);
            this.buttonMode = true;
            return;
        }// end function

        private function handleClose(param1)
        {
            close();
            return;
        }// end function

        public function setGuide(param1, param2)
        {
            this.open();
            var _loc_3:* = Config._npcMap[param1];
            if (_loc_3 != null)
            {
                this._nameLB.text = String(_loc_3.name) + ":";
            }
            this._msgLB.ubbText = "        " + String(param2);
            if (this._headBmp.bitmapData != null)
            {
                this._headBmp.bitmapData.dispose();
            }
            if (_loc_3 != null)
            {
                this._headBmp.bitmapData = Config.findHead(_loc_3.portrait, 140, 160);
            }
            return;
        }// end function

        private static function handleMapComplete(param1)
        {
            Config.map.removeEventListener("complete", handleMapComplete);
            doId(_buffId, _buffObj);
            return;
        }// end function

        public static function overId(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = Config._guideMap[param1];
            _oldLabelTemp[param1] = true;
            if (Number(_loc_2.final) == 0)
            {
                _oldLabel[param1] = true;
                if (_guideFinalBuff[param1] != null)
                {
                    for (_loc_3 in _guideFinalBuff[param1])
                    {
                        
                        _oldLabel[_loc_3] = true;
                    }
                    delete _guideFinalBuff[param1];
                }
                updateAct();
            }
            else
            {
                if (_guideFinalBuff[Number(_loc_2.final)] == null)
                {
                    _guideFinalBuff[Number(_loc_2.final)] = {};
                }
                _guideFinalBuff[Number(_loc_2.final)][param1] = true;
            }
            return;
        }// end function

        public static function doId(param1, param2 = null, param3 = null)
        {
            var xml:*;
            var str1:*;
            var i:*;
            var pt:*;
            var x:*;
            var y:*;
            var state:*;
            var xCenter:*;
            var yCenter:*;
            var id:* = param1;
            var obj:* = param2;
            var nextObjArray:* = param3;
            close(true);
            xml = Config._guideMap[id];
            _buffId = id;
            _buffXML = xml;
            _buffObj = obj;
            _nextObjArray = nextObjArray;
            if (Config.map._state == "ready")
            {
            }
            else
            {
                Config.map.removeEventListener("complete", handleMapComplete);
                Config.map.addEventListener("complete", handleMapComplete);
                return;
            }
            if (obj is Dummy)
            {
                str1 = "<u:" + Base64.encode("0," + Number(obj._data.id)) + ">";
                obj.addHalo(1171, 0, 2);
            }
            else if (obj is Npc)
            {
                str1 = "<u:" + Base64.encode("1," + Number(obj._data.id)) + ">";
                obj.addHalo(1171, 0, 2);
            }
            else if (obj is Item)
            {
                str1 = "<u:" + Base64.encode("2," + Number(obj._data.id)) + ">";
                obj.addHalo(1171);
            }
            else if (obj is Gather)
            {
                str1 = "<u:" + Base64.encode("3," + Number(obj._data.id)) + ">";
                obj.addHalo(1171, 0, 2);
            }
            else if (obj is PushButton)
            {
                if (obj._style != "")
                {
                    str1 = "<c:" + Base64.encode("1," + obj._style) + ">";
                }
                else if (obj._table != "")
                {
                    str1 = "<c:" + Base64.encode("0," + obj._table + "," + obj.width + "," + obj.height + "," + obj.label) + ">";
                }
                if (obj.parent != null)
                {
                    pt = obj.parent.localToGlobal(new Point(obj.x, obj.y));
                    x = pt.x + obj.width / 2;
                    y = pt.y + obj.height / 2;
                    obj.startWarn();
                }
            }
            else if (obj is Label)
            {
                if (obj.parent != null)
                {
                    pt = obj.parent.localToGlobal(new Point(obj.x, obj.y));
                    x = pt.x + obj.width / 2;
                    y = pt.y + obj.height / 2;
                    obj.startWarn();
                }
            }
            else if (obj is ProgressBar)
            {
                if (obj.parent != null)
                {
                    pt = obj.parent.localToGlobal(new Point(obj.x, obj.y));
                    x = pt.x + obj.width / 2;
                    y = pt.y + obj.height / 2;
                    obj.startWarn();
                }
            }
            else if (obj is Slot)
            {
                if (obj.parent != null)
                {
                    try
                    {
                        pt = obj.parent.localToGlobal(new Point(obj.x, obj.y));
                        x = pt.x + obj.width / 2;
                        y = pt.y + obj.height / 2;
                        obj.startWarn();
                    }
                    catch (e)
                    {
                    }
                }
            }
            else if (obj is TaskTips)
            {
                if (obj.parent != null)
                {
                    pt = obj.parent.localToGlobal(new Point(obj.x, obj.y));
                    x = pt.x + obj.width / 2;
                    y = pt.y + obj.height / 2 + 20;
                }
            }
            else if (obj is TaskInfor)
            {
                if (id == 165)
                {
                    x = obj.x + 160;
                    y = obj.y + 70;
                }
                else if (id == 6)
                {
                    x = obj.x + 150;
                    y = obj.y + 85;
                }
                else
                {
                    x = obj.x + 70;
                    y = obj.y + 70;
                }
            }
            else if (obj != null)
            {
                if (obj.parent != null)
                {
                    pt = obj.parent.localToGlobal(new Point(obj.x, obj.y));
                    x = pt.x + obj.width / 2;
                    y = pt.y + obj.height / 2;
                }
            }
            var bgW:*;
            var bgH:*;
            if (x == null || y == null)
            {
                if (Number(xml.pre) == 0)
                {
                    x;
                    y = _screenHeight / 2 - 100;
                }
                else
                {
                    x = _ui.x;
                    y = _ui.y;
                }
                _ui._bg.graphics.clear();
                _ui._bg.graphics.lineStyle(3, 8870456, 1);
                _ui._bg.graphics.beginFill(5912103, 0.6);
                _ui._bg.graphics.drawRect(0, 0, bgW, bgH);
                _ui._bg.graphics.endFill();
                _ui._bg.graphics.lineStyle(1, 16563809, 1);
                _ui._bg.graphics.drawRect(0, 0, bgW, bgH);
            }
            else
            {
                state;
                xCenter = _screenWidth / 2;
                yCenter = _screenHeight / 2;
                if (x > xCenter)
                {
                    x = x - bgW;
                    state = (state + 1);
                }
                else
                {
                    x = x;
                }
                if (y > yCenter)
                {
                    y = y - bgH - 40;
                    state = state + 2;
                }
                else
                {
                    y = y + 40;
                }
                x = Math.min(Math.max(10, x), _screenWidth - 10 - bgW);
                y = Math.min(Math.max(10, y), _screenHeight - 10 - bgH);
                _ui._bg.graphics.clear();
                _ui._bg.graphics.lineStyle(3, 8870456, 1);
                _ui._bg.graphics.beginFill(5912103, 0.6);
                if (state == 0)
                {
                    _ui._bg.graphics.moveTo(10, 0);
                    _ui._bg.graphics.lineTo(0, -40);
                    _ui._bg.graphics.lineTo(40, 0);
                    _ui._bg.graphics.lineTo(bgW, 0);
                    _ui._bg.graphics.lineTo(bgW, bgH);
                    _ui._bg.graphics.lineTo(0, bgH);
                    _ui._bg.graphics.lineTo(0, 0);
                    _ui._bg.graphics.lineTo(10, 0);
                }
                else if (state == 1)
                {
                    _ui._bg.graphics.moveTo(bgW - 10, 0);
                    _ui._bg.graphics.lineTo(bgW, -40);
                    _ui._bg.graphics.lineTo(bgW - 40, 0);
                    _ui._bg.graphics.lineTo(0, 0);
                    _ui._bg.graphics.lineTo(0, bgH);
                    _ui._bg.graphics.lineTo(bgW, bgH);
                    _ui._bg.graphics.lineTo(bgW, 0);
                    _ui._bg.graphics.lineTo(bgW - 10, 0);
                }
                else if (state == 2)
                {
                    _ui._bg.graphics.moveTo(10, bgH);
                    _ui._bg.graphics.lineTo(0, bgH + 40);
                    _ui._bg.graphics.lineTo(40, bgH);
                    _ui._bg.graphics.lineTo(bgW, bgH);
                    _ui._bg.graphics.lineTo(bgW, 0);
                    _ui._bg.graphics.lineTo(0, 0);
                    _ui._bg.graphics.lineTo(0, bgH);
                    _ui._bg.graphics.lineTo(10, bgH);
                }
                else if (state == 3)
                {
                    _ui._bg.graphics.moveTo(bgW - 10, bgH);
                    _ui._bg.graphics.lineTo(bgW, bgH + 40);
                    _ui._bg.graphics.lineTo(bgW - 40, bgH);
                    _ui._bg.graphics.lineTo(0, bgH);
                    _ui._bg.graphics.lineTo(0, 0);
                    _ui._bg.graphics.lineTo(bgW, 0);
                    _ui._bg.graphics.lineTo(bgW, bgH);
                    _ui._bg.graphics.lineTo(bgW - 10, bgH);
                }
                _ui._bg.graphics.endFill();
                _ui._bg.graphics.lineStyle(1, 16563809, 1);
                if (state == 0)
                {
                    _ui._bg.graphics.moveTo(10, 0);
                    _ui._bg.graphics.lineTo(0, -40);
                    _ui._bg.graphics.lineTo(40, 0);
                    _ui._bg.graphics.lineTo(bgW, 0);
                    _ui._bg.graphics.lineTo(bgW, bgH);
                    _ui._bg.graphics.lineTo(0, bgH);
                    _ui._bg.graphics.lineTo(0, 0);
                    _ui._bg.graphics.lineTo(10, 0);
                }
                else if (state == 1)
                {
                    _ui._bg.graphics.moveTo(bgW - 10, 0);
                    _ui._bg.graphics.lineTo(bgW, -40);
                    _ui._bg.graphics.lineTo(bgW - 40, 0);
                    _ui._bg.graphics.lineTo(0, 0);
                    _ui._bg.graphics.lineTo(0, bgH);
                    _ui._bg.graphics.lineTo(bgW, bgH);
                    _ui._bg.graphics.lineTo(bgW, 0);
                    _ui._bg.graphics.lineTo(bgW - 10, 0);
                }
                else if (state == 2)
                {
                    _ui._bg.graphics.moveTo(10, bgH);
                    _ui._bg.graphics.lineTo(0, bgH + 40);
                    _ui._bg.graphics.lineTo(40, bgH);
                    _ui._bg.graphics.lineTo(bgW, bgH);
                    _ui._bg.graphics.lineTo(bgW, 0);
                    _ui._bg.graphics.lineTo(0, 0);
                    _ui._bg.graphics.lineTo(0, bgH);
                    _ui._bg.graphics.lineTo(10, bgH);
                }
                else if (state == 3)
                {
                    _ui._bg.graphics.moveTo(bgW - 10, bgH);
                    _ui._bg.graphics.lineTo(bgW, bgH + 40);
                    _ui._bg.graphics.lineTo(bgW - 40, bgH);
                    _ui._bg.graphics.lineTo(0, bgH);
                    _ui._bg.graphics.lineTo(0, 0);
                    _ui._bg.graphics.lineTo(bgW, 0);
                    _ui._bg.graphics.lineTo(bgW, bgH);
                    _ui._bg.graphics.lineTo(bgW - 10, bgH);
                }
            }
            _ui.x = x;
            _ui.y = y;
            var str:* = String(xml.msg);
            if (str1 != null)
            {
                str = str.replace("$", str1);
            }
            _ui.setGuide(Number(xml.npc), str);
            overId(id);
            var time:* = Number(xml.time);
            if (time > 0)
            {
                clearTimeout(_closeTimer);
                _closeTimer = setTimeout(close, time * 1000);
            }
            var displayObj:* = obj;
            while (displayObj != null && displayObj is DisplayObject && displayObj != Config.ui)
            {
                
                if (displayObj is Window || displayObj is AlertUI)
                {
                    preWindow = displayObj;
                    return;
                }
                displayObj = displayObj.parent;
            }
            return;
        }// end function

        private static function set preWindow(param1)
        {
            if (_preWindow != null)
            {
                _preWindow.removeEventListener("close", handlePreWindowClose);
            }
            _preWindow = param1;
            if (_preWindow != null)
            {
                _preWindow.removeEventListener("close", handlePreWindowClose);
                _preWindow.addEventListener("close", handlePreWindowClose);
            }
            return;
        }// end function

        private static function handlePreWindowClose(param1)
        {
            close();
            return;
        }// end function

        public static function testOverId(param1)
        {
            return _oldLabelTemp[param1];
        }// end function

        public static function testId(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            if (_ready && Config._guideMap[param1] != null)
            {
                if (_oldLabel[param1] != true)
                {
                    _loc_2 = Config._guideMap[param1];
                    if (Number(_loc_2.open) == 1)
                    {
                        if (_loc_2.pre is String)
                        {
                            if (_loc_2.pre.indexOf("||") != -1)
                            {
                                _loc_3 = _loc_2.pre.split("||");
                                _loc_4 = 0;
                                while (_loc_4 < _loc_3.length)
                                {
                                    
                                    if (_oldLabelTemp[Number(_loc_3[_loc_4])])
                                    {
                                        return true;
                                    }
                                    _loc_4 = _loc_4 + 1;
                                }
                            }
                            else if (_loc_2.pre.indexOf("&&") != -1)
                            {
                                _loc_3 = _loc_2.pre.split("&&");
                                _loc_4 = 0;
                                while (_loc_4 < _loc_3.length)
                                {
                                    
                                    if (_oldLabelTemp[Number(_loc_3[_loc_4])])
                                    {
                                        return false;
                                    }
                                    _loc_4 = _loc_4 + 1;
                                }
                            }
                            return false;
                        }
                        else if (Number(_loc_2.pre) == 0 || _oldLabelTemp[Number(_loc_2.pre)])
                        {
                            return true;
                        }
                    }
                }
            }
            return false;
        }// end function

        public static function testDoId(param1, param2 = null, param3:Window = null, param4 = null)
        {
            if (testId(param1))
            {
                doId(param1, param2, param4);
                if (param3 != null && param3._opening)
                {
                    close(true);
                    param3.testGuide();
                }
            }
            return;
        }// end function

        public static function resize(param1, param2)
        {
            _screenWidth = param1;
            _screenHeight = param2;
            if (_ui != null)
            {
                _ui.x = 100;
                _ui.y = _screenHeight / 2 - 100;
            }
            return;
        }// end function

        public static function close(param1 = false)
        {
            preWindow = null;
            clearTimeout(_closeTimer);
            _ui.close();
            var _loc_2:* = _buffXML;
            var _loc_3:* = _buffObj;
            if (_buffObj != null && (_buffObj is Component || _buffObj is Slot))
            {
                _buffObj.stopWarn();
            }
            else if (_buffObj != null && (_buffObj is Unit || _buffObj is Item))
            {
                _buffObj.removeHalo(1171);
            }
            _buffXML = null;
            _buffObj = null;
            if (_loc_2 != null && !param1)
            {
                if (Number(_loc_2.next) != 0)
                {
                    if (_nextObjArray != null && _nextObjArray.length > 0)
                    {
                        testDoId(Number(_loc_2.next), _nextObjArray.shift(), null, _nextObjArray);
                    }
                    else
                    {
                        testDoId(Number(_loc_2.next));
                    }
                }
            }
            return;
        }// end function

        public static function reset()
        {
            var _loc_1:* = undefined;
            _oldLabel = [];
            _loc_1 = 0;
            while (_loc_1 < 32 * 8)
            {
                
                _oldLabel[_loc_1] = false;
                _loc_1 = _loc_1 + 1;
            }
            _oldLabelTemp = [];
            _loc_1 = 0;
            while (_loc_1 < 32 * 8)
            {
                
                _oldLabelTemp[_loc_1] = false;
                _loc_1 = _loc_1 + 1;
            }
            _ready = true;
            return;
        }// end function

        private static function handleReadAct(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_2:* = param1.data;
            _oldLabel = [];
            _loc_3 = 0;
            while (_loc_3 < 16)
            {
                
                _loc_5 = _loc_2.readUnsignedInt();
                _loc_6 = _loc_5.toString(2).split("");
                _loc_4 = 0;
                while (_loc_4 < 32)
                {
                    
                    if (_loc_6.length == 32 - _loc_4)
                    {
                        _loc_7 = Number(_loc_6.shift());
                        if (_loc_7 == 0)
                        {
                            _oldLabel.push(false);
                        }
                        else
                        {
                            _oldLabel.push(true);
                        }
                    }
                    else
                    {
                        _oldLabel.push(false);
                    }
                    _loc_4 = _loc_4 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            _ready = true;
            return;
        }// end function

        public static function updateAct()
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_1:* = _oldLabel.concat();
            var _loc_7:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_UPDATE_USERACT);
            _loc_2 = 0;
            while (_loc_2 < 16)
            {
                
                _loc_5 = "";
                _loc_3 = 0;
                while (_loc_3 < 32)
                {
                    
                    _loc_6 = _loc_1.shift();
                    if (_loc_6)
                    {
                        _loc_5 = _loc_5 + "1";
                    }
                    else
                    {
                        _loc_5 = _loc_5 + "0";
                    }
                    _loc_3 = _loc_3 + 1;
                }
                _loc_7.add32(parseInt(_loc_5, 2));
                _loc_2 = _loc_2 + 1;
            }
            ClientSocket.send(_loc_7);
            return;
        }// end function

        public static function setAct(param1)
        {
            if (_ready)
            {
                _oldLabel[param1] = true;
                _oldLabelTemp[param1] = true;
                updateAct();
            }
            return;
        }// end function

        public static function getAct(param1)
        {
            if (_oldLabel[param1])
            {
                return true;
            }
            return false;
        }// end function

        public static function clearAll()
        {
            var _loc_1:* = undefined;
            _loc_1 = 0;
            while (_loc_1 < 512)
            {
                
                _oldLabel[_loc_1] = false;
                _loc_1 = _loc_1 + 1;
            }
            updateAct();
            return;
        }// end function

    }
}
