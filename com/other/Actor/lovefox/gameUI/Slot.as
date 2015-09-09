package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import lovefox.buffer.*;
    import lovefox.util.*;

    public class Slot extends MouseSprite
    {
        public var _size:uint;
        public var _id:uint;
        public var _bgTable:Table;
        public var _bg:Bitmap;
        public var _bgURL:Object;
        private var _cdMax:Object;
        var _cd:Object = 0;
        private var _cdPreTime:Object;
        private var _cdInterval:Object;
        var _cdShape:Object;
        private var _enabled:Object = true;
        public var _locked:Boolean = false;
        public var _container:Sprite;
        private var _select:Boolean = false;
        private var _gray:Boolean = false;
        var _selectMask:Shape;
        var _iconMask:Shape;
        var _iconShade:Shape;
        private var _color:Object;
        private var _colorBg:Shape;
        private var _colorBorder:Shape;
        private var _borderColor:int = 0;
        private var pdUpLabel:Label;
        private var _pdUpFlag:Boolean = false;
        private var _hightLightCount:int;
        private var _particleLock:Boolean = false;
        private var _luxBitmap:Bitmap;
        private var _luxBorderBmpdIndex:int = 0;
        private var _luxBorderBmpds:Array;
        public static var _grayFilter:Object = new ColorMatrixFilter([0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0]);
        private static var _hightLightFilters:Array;
        private static var _luxBallLayer:Sprite;
        private static var _luxBalls:Array = [];
        private static var _luxBallDirection:int = 0;
        private static var _bgctr:ColorMatrixFilter = new ColorMatrixFilter([1, 0, 0, 0, 150, 0, 1, 0, 0, 150, 0, 0, 1, 0, 150, 0, 0, 0, 1.5, 0]);
        private static var _luxSize:int;
        private static var _luxBorderBmpd:BitmapData;
        private static var _luxBorderBmpdMap:Object = {};
        private static var _recorderState:int = 0;
        private static var cTra:ColorTransform = new ColorTransform(1, 1, 1, 0.7);

        public function Slot(param1, param2)
        {
            this._luxBorderBmpds = [];
            this._size = param2;
            this._id = param1;
            return;
        }// end function

        public function get pdUpFlag() : Boolean
        {
            return this._pdUpFlag;
        }// end function

        public function set pdUpFlag(param1:Boolean) : void
        {
            if (param1)
            {
                if (this.pdUpLabel.parent == null)
                {
                    this.addChild(this.pdUpLabel);
                }
            }
            else if (this.pdUpLabel.parent != null)
            {
                this.removeChild(this.pdUpLabel);
            }
            this._pdUpFlag = param1;
            return;
        }// end function

        public function lock()
        {
            this._locked = true;
            enableMouse = false;
            return;
        }// end function

        public function unlock()
        {
            this._locked = false;
            enableMouse = true;
            return;
        }// end function

        public function set enabled(param1)
        {
            this._enabled = param1;
            return;
        }// end function

        public function get enabled()
        {
            return this._enabled;
        }// end function

        public function set bg(param1)
        {
            var _loc_2:* = null;
            if (this._bg != null)
            {
                if (this._bg.bitmapData != null)
                {
                    this._bg.bitmapData.dispose();
                }
            }
            else
            {
                this._bg = new Bitmap();
                addChild(this._bg);
            }
            if (param1 != null)
            {
                this._bgURL = param1;
                if (BitmapLoader.pick(String(param1)) != null)
                {
                    this._bg.bitmapData = BitmapLoader.pick(String(param1));
                    this._bg.x = Math.floor((this._size - this._bg.width) / 2);
                    this._bg.y = Math.ceil((this._size - this._bg.height) / 2);
                }
                else
                {
                    _loc_2 = BitmapLoader.newBitmapLoader();
                    _loc_2.addEventListener("complete", this.subSetBg);
                    _loc_2.load([String(param1)]);
                }
            }
            else
            {
                removeChild(this._bg);
                this._bg = null;
            }
            return;
        }// end function

        public function get bg()
        {
            return this._bg;
        }// end function

        private function subSetBg(param1)
        {
            param1.target.removeEventListener("complete", this.subSetBg);
            this._bg.bitmapData = BitmapLoader.pick(this._bgURL);
            this._bg.x = Math.floor((this._size - this._bg.width) / 2);
            this._bg.y = Math.ceil((this._size - this._bg.height) / 2);
            return;
        }// end function

        public function init()
        {
            this._bgTable = new Table("table1");
            this._bgTable.resize(this._size + 4, this._size + 4);
            var _loc_1:* = -2;
            this._bgTable.y = -2;
            this._bgTable.x = _loc_1;
            addChild(this._bgTable);
            this._colorBg = new Shape();
            addChild(this._colorBg);
            this._iconMask = new Shape();
            this._iconMask.graphics.beginFill(0, 0);
            this._iconMask.graphics.drawRoundRect(0, 0, this._size, this._size, 6, 6);
            this._iconMask.graphics.endFill();
            addChild(this._iconMask);
            this._container = new Sprite();
            addChild(this._container);
            this._container.mask = this._iconMask;
            this._cdShape = new Shape();
            addChild(this._cdShape);
            this._iconShade = new Shape();
            this._iconShade.graphics.beginFill(0);
            this._iconShade.graphics.drawRoundRect(0, 0, this._size, this._size, 6, 6);
            this._iconShade.graphics.endFill();
            this._iconShade.filters = [new GlowFilter(0, 1, 5, 5, 1, 1, true, true)];
            addChild(this._iconShade);
            this._colorBorder = new Shape();
            addChild(this._colorBorder);
            this._selectMask = new Shape();
            addChild(this._selectMask);
            this._selectMask.x = this._container.x;
            this._selectMask.y = this._container.y;
            this.pdUpLabel = new Label(null, this._size - 10, this._size - 15, "↑");
            this.pdUpLabel.textColor = Style.FONT_6int_Yellow;
            return;
        }// end function

        public function setCd(param1, param2 = null)
        {
            if (param1 > 0)
            {
                this._cdMax = param2;
                this._cdPreTime = getTimer() + param1;
                this._cd = param1;
                this.handleCdCircle();
            }
            else
            {
                this._cd = 0;
                clearTimeout(this._cdInterval);
                this._cdShape.graphics.clear();
            }
            return;
        }// end function

        private function handleCdCircle()
        {
            clearTimeout(this._cdInterval);
            this._cd = this._cdPreTime - getTimer();
            var _loc_1:* = (this._cdMax - this._cd) / this._cdMax;
            var _loc_2:* = Math.PI * 2 * _loc_1;
            this._cdShape.graphics.clear();
            if (this._cd > 0)
            {
                this._cdShape.graphics.beginFill(0, 0.8);
                this._cdShape.graphics.moveTo(this._size / 2, this._size / 2);
                if (_loc_1 < 1 / 8)
                {
                    this._cdShape.graphics.lineTo(this._size / 2, 0);
                    this._cdShape.graphics.lineTo(0, 0);
                    this._cdShape.graphics.lineTo(0, this._size);
                    this._cdShape.graphics.lineTo(this._size, this._size);
                    this._cdShape.graphics.lineTo(this._size, 0);
                    this._cdShape.graphics.lineTo(this._size / 2 + Math.tan(_loc_2) * this._size / 2, 0);
                }
                else if (_loc_1 < 3 / 8)
                {
                    this._cdShape.graphics.lineTo(this._size / 2, 0);
                    this._cdShape.graphics.lineTo(0, 0);
                    this._cdShape.graphics.lineTo(0, this._size);
                    this._cdShape.graphics.lineTo(this._size, this._size);
                    this._cdShape.graphics.lineTo(this._size, this._size / 2 - Math.tan(Math.PI / 2 - _loc_2) * this._size / 2);
                }
                else if (_loc_1 < 5 / 8)
                {
                    this._cdShape.graphics.lineTo(this._size / 2, 0);
                    this._cdShape.graphics.lineTo(0, 0);
                    this._cdShape.graphics.lineTo(0, this._size);
                    this._cdShape.graphics.lineTo(this._size / 2 + Math.tan(Math.PI - _loc_2) * this._size / 2, this._size);
                }
                else if (_loc_1 < 7 / 8)
                {
                    this._cdShape.graphics.lineTo(this._size / 2, 0);
                    this._cdShape.graphics.lineTo(0, 0);
                    this._cdShape.graphics.lineTo(0, this._size / 2 + Math.tan(Math.PI / 2 * 3 - _loc_2) * this._size / 2);
                }
                else
                {
                    this._cdShape.graphics.lineTo(this._size / 2, 0);
                    this._cdShape.graphics.lineTo(Math.tan(_loc_2) * this._size / 2 + this._size / 2, 0);
                }
                this._cdShape.graphics.lineTo(this._size / 2, this._size / 2);
                this._cdShape.graphics.endFill();
                this._cdInterval = setTimeout(this.handleCdCircle, 100);
            }
            else
            {
                this._cd = 0;
            }
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._select;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            this._select = param1;
            if (this._select)
            {
                this._selectMask.graphics.clear();
                this._selectMask.graphics.lineStyle(2, 16711680);
                this._selectMask.graphics.drawRoundRect(1, 1, this._size - 2, this._size - 2, 5, 5);
            }
            else
            {
                this._selectMask.graphics.clear();
            }
            return;
        }// end function

        public function get gray() : Boolean
        {
            return this._gray;
        }// end function

        public function set gray(param1:Boolean) : void
        {
            this._gray = param1;
            if (this._gray)
            {
                this._container.filters = [_grayFilter];
            }
            else
            {
                this._container.filters = [];
            }
            return;
        }// end function

        public function get borderColor()
        {
            return this._borderColor;
        }// end function

        public function set borderColor(param1) : void
        {
            this._borderColor = param1;
            this._iconShade.filters = [new GlowFilter(this._borderColor, 1, 5, 5, 1, 1, true, true)];
            return;
        }// end function

        public function get color()
        {
            return this._color;
        }// end function

        public function set color(param1) : void
        {
            this._color = param1;
            this._colorBg.graphics.clear();
            if (this._color != null)
            {
                this._colorBg.graphics.beginFill(this._color, 1);
                this._colorBg.graphics.drawRoundRect(0, 0, this._size, this._size, 6, 6);
                this._colorBg.graphics.endFill();
            }
            return;
        }// end function

        public function setColorBorder(param1 = null, param2 = null)
        {
            this._colorBorder.graphics.clear();
            if (param1 != null)
            {
                this._colorBorder.graphics.lineStyle(0, param1, 1, true);
                this._colorBorder.graphics.drawRoundRect(0, 0, this._size, this._size, 6, 6);
                if (param2 != null)
                {
                    this._colorBorder.filters = [new GlowFilter(param2, 1, 3, 3, 1, 1)];
                }
                else
                {
                    this._colorBorder.filters = [];
                }
            }
            else
            {
                this._colorBorder.filters = [];
            }
            return;
        }// end function

        private function getPos() : Point
        {
            return new Point(Math.random() * this._size, Math.random() * this._size);
        }// end function

        private function getBorderPos() : Point
        {
            var _loc_1:* = Math.random();
            if (_loc_1 < 0.25)
            {
                return new Point(Math.random() * this._size, 0);
            }
            if (_loc_1 < 0.5)
            {
                return new Point(0, Math.random() * this._size);
            }
            if (_loc_1 < 0.75)
            {
                return new Point(Math.random() * this._size, this._size);
            }
            return new Point(this._size, Math.random() * this._size);
        }// end function

        private function getContainerPoints() : Array
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_1:* = new BitmapData(this._size, this._size, true, 0);
            this._container.mask = null;
            _loc_1.draw(this._container);
            this._container.mask = this._iconMask;
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1.width)
            {
                
                _loc_4 = 0;
                while (_loc_4 < _loc_1.height)
                {
                    
                    _loc_5 = _loc_1.getPixel32(_loc_3, _loc_4) >> 24 & 255;
                    if (_loc_5 != 0)
                    {
                        _loc_2.push({x:_loc_3, y:_loc_4, color:_loc_1.getPixel(_loc_3, _loc_4)});
                    }
                    _loc_4 = _loc_4 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            _loc_1.dispose();
            return _loc_2;
        }// end function

        private function getRandomOne(param1:Array)
        {
            var _loc_2:* = int(Math.random() * param1.length);
            return param1.splice(_loc_2, 1)[0];
        }// end function

        public function releaseParticle(param1 = 1000) : Array
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            if (!this._particleLock)
            {
                _loc_2 = [];
                _loc_3 = this.getContainerPoints();
                _loc_4 = Math.min(_loc_3.length, 64);
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    _loc_6 = this.getRandomOne(_loc_3);
                    _loc_7 = parent.localToGlobal(new Point(x + _loc_6.x, y + _loc_6.y));
                    _loc_8 = Math.atan2(_loc_6.y - this._size / 2, _loc_6.y - this._size / 2);
                    _loc_9 = Particle.create(_loc_7.x, _loc_7.y, 1, 2, _loc_8, _loc_6.color, 0.2, param1);
                    _loc_9.filters = [new GlowFilter(_loc_6.color, 1, 10, 10, 2, 3)];
                    _loc_2.push(_loc_9);
                    _loc_5 = _loc_5 + 1;
                }
                this.handleReceiveDie();
                this._particleLock = true;
                setTimeout(this.realeaseParticleLock, param1);
                return _loc_2;
            }
            else
            {
                return null;
            }
        }// end function

        private function realeaseParticleLock()
        {
            this._particleLock = false;
            return;
        }// end function

        public function receiveParticle(param1:Array)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            var _loc_6:* = null;
            if (param1 == null || param1.length == 0)
            {
                return;
            }
            var _loc_2:* = this.getContainerPoints();
            if (_loc_2.length == 0)
            {
                _loc_3 = 0;
                while (_loc_3 < param1.length)
                {
                    
                    _loc_4 = param1[_loc_3];
                    _loc_5 = this.getPos();
                    _loc_6 = parent.localToGlobal(new Point(x + _loc_5.x, y + _loc_5.y));
                    _loc_4.beReceive(_loc_6.x, _loc_6.y, Math.random() * 5 + 5, 0.8, this.handleReceiveDie);
                    _loc_3 = _loc_3 + 1;
                }
            }
            else
            {
                _loc_3 = 0;
                while (_loc_3 < param1.length)
                {
                    
                    _loc_4 = param1[_loc_3];
                    _loc_5 = _loc_2[int(Math.random() * _loc_2.length)];
                    _loc_6 = parent.localToGlobal(new Point(x + _loc_5.x, y + _loc_5.y));
                    _loc_4.beReceive(_loc_6.x, _loc_6.y, Math.random() * 5 + 5, 0.8, this.handleReceiveDie);
                    _loc_3 = _loc_3 + 1;
                }
            }
            return;
        }// end function

        private function handleReceiveDie()
        {
            var _loc_1:* = undefined;
            if (_hightLightFilters == null)
            {
                _hightLightFilters = [];
                _loc_1 = 1;
                while (_loc_1 < 6)
                {
                    
                    _hightLightFilters[_loc_1] = [new ColorMatrixFilter([1 + _loc_1 / 6, _loc_1 / 6, _loc_1 / 6, 0, 0, _loc_1 / 6, 1 + _loc_1 / 6, _loc_1 / 6, 0, 0, _loc_1 / 6, _loc_1 / 6, 1 + _loc_1 / 6, 0, 0, 0, 0, 0, 1, 0])];
                    _loc_1 = _loc_1 + 1;
                }
            }
            if (this._hightLightCount < 3)
            {
                this._hightLightCount = 5;
                Config.startLoop(this.receiveDieEffectLoop);
                this.receiveDieEffectLoop();
            }
            return;
        }// end function

        private function receiveDieEffectLoop(param1 = null)
        {
            if (this._hightLightCount > 0)
            {
                this._container.filters = _hightLightFilters[this._hightLightCount];
            }
            else
            {
                this.gray = this._gray;
            }
            var _loc_2:* = this;
            var _loc_3:* = this._hightLightCount - 1;
            _loc_2._hightLightCount = _loc_3;
            if (this._hightLightCount < 0)
            {
                this.gray = this._gray;
                this._container.mask = this._iconMask;
                Config.stopLoop(this.receiveDieEffectLoop);
            }
            return;
        }// end function

        public function set luxBorder(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            if (param1)
            {
                if (_luxBorderBmpdMap[this._size] == null)
                {
                    _loc_2 = 15728895;
                    _loc_3 = 16750848;
                    _luxSize = this._size;
                    _luxBorderBmpdMap[this._size] = [];
                    _luxBallLayer = new Sprite();
                    _loc_4 = 0;
                    while (_loc_4 < 30)
                    {
                        
                        _loc_5 = new Shape();
                        if (_loc_4 < 2)
                        {
                            _loc_5.graphics.beginFill(16777215, 1);
                            _loc_5.graphics.drawRect(-1, -1, 2, 2);
                            _loc_5.graphics.endFill();
                            _loc_5.filters = [new BlurFilter(1, 1, 1), _bgctr, new GlowFilter(_loc_2, 1, 2, 2, 5, 3), new BlurFilter(2, 2, 1)];
                        }
                        else if (_loc_4 > 10 && _loc_4 < 20 || Math.random() < 0.5)
                        {
                            _loc_6 = Math.random() * 1 + 0.4;
                            _loc_7 = _loc_6;
                            _loc_5.graphics.beginFill(16777215, 1);
                            _loc_5.graphics.drawCircle(0, 0, _loc_6 / 2);
                            _loc_5.graphics.endFill();
                            _loc_5.filters = [new BlurFilter(_loc_6 / 2, _loc_7 / 2, 1), _bgctr, new GlowFilter(_loc_3, 1, _loc_6, _loc_7, 5, 1)];
                        }
                        _luxBalls.push(_loc_5);
                        _luxBallDirection = 0;
                        _loc_4++;
                    }
                    _loc_4 = _luxBalls.length - 1;
                    while (_loc_4 >= 0)
                    {
                        
                        _luxBallLayer.addChild(_luxBalls[_loc_4]);
                        _loc_4 = _loc_4 - 1;
                    }
                    _luxBallLayer.filters = [_bgctr];
                    while (luxBorderLoop())
                    {
                        
                    }
                }
                if (this._luxBitmap == null)
                {
                    this._luxBorderBmpds = _luxBorderBmpdMap[this._size];
                    this._luxBitmap = new Bitmap(this._luxBorderBmpds[0]);
                    this._luxBorderBmpdIndex = 1;
                    var _loc_8:* = -2;
                    this._luxBitmap.y = -2;
                    this._luxBitmap.x = _loc_8;
                }
                addChild(this._luxBitmap);
                if (stage != null)
                {
                    Config.startLoop(this.luxPlay);
                }
                removeEventListener(Event.ADDED_TO_STAGE, this.luxAddToStage);
                removeEventListener(Event.REMOVED_FROM_STAGE, this.luxRemovedFromStage);
                addEventListener(Event.ADDED_TO_STAGE, this.luxAddToStage);
                addEventListener(Event.REMOVED_FROM_STAGE, this.luxRemovedFromStage);
            }
            else
            {
                if (this._luxBitmap != null && this._luxBitmap.parent != null)
                {
                    this._luxBitmap.parent.removeChild(this._luxBitmap);
                }
                Config.stopLoop(this.luxPlay);
                removeEventListener(Event.ADDED_TO_STAGE, this.luxAddToStage);
                removeEventListener(Event.REMOVED_FROM_STAGE, this.luxRemovedFromStage);
            }
            return;
        }// end function

        private function luxAddToStage(event:Event) : void
        {
            Config.startLoop(this.luxPlay);
            return;
        }// end function

        private function luxRemovedFromStage(event:Event) : void
        {
            Config.stopLoop(this.luxPlay);
            return;
        }// end function

        private function luxPlay(param1) : void
        {
            this._luxBitmap.bitmapData = this._luxBorderBmpds[this._luxBorderBmpdIndex];
            var _loc_2:* = this;
            var _loc_3:* = this._luxBorderBmpdIndex + 1;
            _loc_2._luxBorderBmpdIndex = _loc_3;
            if (this._luxBorderBmpdIndex >= this._luxBorderBmpds.length)
            {
                this._luxBorderBmpdIndex = 0;
            }
            return;
        }// end function

        private static function luxBorderLoop() : Boolean
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_1:* = 2;
            var _loc_2:* = _luxSize - 2;
            var _loc_3:* = 1;
            if (_recorderState == 1)
            {
                _loc_5 = new Matrix();
                _loc_5.translate(-_loc_1 + 4, -_loc_1 + 4);
                _luxBorderBmpd.colorTransform(_luxBorderBmpd.rect, cTra);
                _luxBorderBmpd.draw(_luxBallLayer, _loc_5);
                _luxBorderBmpdMap[_luxSize].push(_luxBorderBmpd.clone());
            }
            var _loc_4:* = 0;
            while (_loc_4 < 3)
            {
                
                _loc_6 = _luxBalls.length - 1;
                while (_loc_6 > 0)
                {
                    
                    _luxBalls[_loc_6].x = _luxBalls[(_loc_6 - 1)].x;
                    _luxBalls[_loc_6].y = _luxBalls[(_loc_6 - 1)].y;
                    _loc_6 = _loc_6 - 1;
                }
                if (_luxBallDirection == 0)
                {
                    _luxBalls[0].x = _luxBalls[0].x + _loc_3;
                    if (_luxBalls[0].x > _loc_2)
                    {
                        _luxBalls[0].y = _loc_1 + _luxBalls[0].x - _loc_2;
                        _luxBalls[0].x = _loc_2;
                        _luxBallDirection = 1;
                    }
                }
                else if (_luxBallDirection == 1)
                {
                    _luxBalls[0].y = _luxBalls[0].y + _loc_3;
                    if (_luxBalls[0].y > _loc_2)
                    {
                        _luxBalls[0].x = _loc_2 - (_luxBalls[0].y - _loc_2);
                        _luxBalls[0].y = _loc_2;
                        _luxBallDirection = 2;
                    }
                }
                else if (_luxBallDirection == 2)
                {
                    _luxBalls[0].x = _luxBalls[0].x - _loc_3;
                    if (_luxBalls[0].x < _loc_1)
                    {
                        _luxBalls[0].y = _loc_2 - (_loc_1 - _luxBalls[0].x);
                        _luxBalls[0].x = _loc_1;
                        _luxBallDirection = 3;
                    }
                }
                else if (_luxBallDirection == 3)
                {
                    _luxBalls[0].y = _luxBalls[0].y - _loc_3;
                    if (_luxBalls[0].y < _loc_1)
                    {
                        if (_recorderState == 0)
                        {
                            _recorderState = 1;
                            _luxBorderBmpd = new BitmapData(_loc_2 - _loc_1 + 8, _loc_2 - _loc_1 + 8, true, 0);
                            _loc_5 = new Matrix();
                            _loc_5.translate(-_loc_1 + 4, -_loc_1 + 4);
                            _luxBorderBmpd.draw(_luxBallLayer, _loc_5);
                        }
                        else if (_recorderState == 1)
                        {
                            _recorderState = 2;
                            _luxBorderBmpd.dispose();
                            return false;
                        }
                        _luxBalls[0].x = _loc_1 + _loc_1 - _luxBalls[0].y;
                        _luxBalls[0].y = _loc_1;
                        _luxBallDirection = 0;
                    }
                }
                _loc_4++;
            }
            return true;
        }// end function

    }
}
