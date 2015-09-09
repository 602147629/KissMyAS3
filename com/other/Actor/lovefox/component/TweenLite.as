package lovefox.component
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.utils.*;

    public class TweenLite extends Object
    {
        private var _sound:SoundTransform;
        private var _endTarget:Object;
        private var _active:Boolean;
        private var _color:ColorTransform;
        private var _endColor:ColorTransform;
        public var duration:Number;
        public var vars:Object;
        public var delay:Number;
        public var onComplete:Function;
        public var onCompleteParams:Array;
        public var onStart:Function;
        public var onStartParams:Array;
        public var startTime:uint;
        public var initTime:uint;
        public var tweens:Object;
        public var extraTweens:Object;
        public var target:Object;
        public static var version:Number = 5.1;
        public static var killDelayedCallsTo:Function = killTweensOf;
        private static var _sprite:Sprite = new Sprite();
        private static var _listening:Boolean;
        private static var _all:Dictionary = new Dictionary();
        private static var _timer:Timer = new Timer(2000);

        public function TweenLite(param1:Object, param2:Number, param3:Object, param4:Number = 0, param5:Function = null, param6:Array = null, param7:Boolean = true)
        {
            if (param1 == null)
            {
                return;
            }
            if (param3.overwrite != false && param7 != false && param1 != null || _all[param1] == undefined)
            {
                delete _all[param1];
                _all[param1] = new Dictionary();
            }
            _all[param1][this] = this;
            this.vars = param3;
            this.duration = param2;
            this.delay = param3.delay || param4 || 0;
            if (param2 == 0)
            {
                this.duration = 0.001;
                if (this.delay == 0)
                {
                    this.vars.runBackwards = true;
                }
            }
            var _loc_9:* = param1;
            this._endTarget = param1;
            this.target = _loc_9;
            this.onComplete = param3.onComplete || param5;
            this.onCompleteParams = param3.onCompleteParams || param6 || [];
            this.onStart = param3.onStart;
            this.onStartParams = param3.onStartParams || [];
            if (this.vars.ease == undefined)
            {
                this.vars.ease = easeOut;
            }
            else if (!(this.vars.ease is Function))
            {
                trace("ERROR: You cannot use \'" + this.vars.ease + "\' for the TweenLite ease property. Only functions are accepted.");
            }
            if (!isNaN(Number(this.vars.autoAlpha)))
            {
                this.vars.alpha = Number(this.vars.autoAlpha);
            }
            else if (!isNaN(Number(this.vars._autoAlpha)))
            {
                var _loc_9:* = Number(this.vars._autoAlpha);
                this.vars.autoAlpha = Number(this.vars._autoAlpha);
                this.vars.alpha = _loc_9;
            }
            this.tweens = {};
            this.extraTweens = {};
            this.initTime = getTimer();
            if (this.vars.runBackwards == true)
            {
                this.initTweenVals();
            }
            this._active = false;
            var _loc_8:* = this.active;
            if (param2 == 0 && this.delay == 0)
            {
                if (this.vars.autoAlpha == 0)
                {
                    this.target.visible = false;
                }
                if (this.onComplete != null)
                {
                    this.onComplete.apply(null, this.onCompleteParams);
                }
                removeTween(this);
            }
            else if (!_listening)
            {
                _sprite.addEventListener(Event.ENTER_FRAME, executeAll);
                _timer.addEventListener("timer", killGarbage);
                _timer.start();
                _listening = true;
            }
            return;
        }// end function

        public function initTweenVals() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_1:* = this.delay - (getTimer() - this.initTime) / 1000;
            if (this.target is Array)
            {
                _loc_4 = [];
                for (_loc_2 in this.vars)
                {
                    
                    if (this.vars[_loc_2] is Array)
                    {
                        _loc_4 = this.vars[_loc_2];
                        break;
                    }
                }
                _loc_5 = 0;
                while (_loc_5 < _loc_4.length)
                {
                    
                    if (this.target[_loc_5] != _loc_4[_loc_5] && this.target[_loc_5] != undefined)
                    {
                        this.tweens[_loc_5.toString()] = {o:this.target, s:this.target[_loc_5], c:_loc_4[_loc_5] - this.target[_loc_5], e:this.vars.ease};
                    }
                    _loc_5++;
                }
            }
            else
            {
                for (_loc_2 in this.vars)
                {
                    
                    if (_loc_2 == "volume" && this.target is MovieClip)
                    {
                        this._sound = this.target.soundTransform;
                        _loc_6 = new TweenLite(this, this.duration, {volumeProxy:this.vars[_loc_2], ease:easeOut, delay:_loc_1, overwrite:false, runBackwards:this.vars.runBackwards});
                        _loc_6.endTarget = this.target;
                        continue;
                    }
                    if (_loc_2.toLowerCase() == "mccolor" && this.target is DisplayObject)
                    {
                        this._color = this.target.transform.colorTransform;
                        this._endColor = new ColorTransform();
                        this._endColor.alphaMultiplier = this.vars.alpha || this.target.alpha;
                        if (this.vars[_loc_2] != null && this.vars[_loc_2] != "")
                        {
                            this._endColor.color = this.vars[_loc_2];
                        }
                        _loc_7 = new TweenLite(this, this.duration, {colorProxy:1, delay:_loc_1, overwrite:false, runBackwards:this.vars.runBackwards});
                        _loc_7.endTarget = this.target;
                        continue;
                    }
                    if (_loc_2 == "delay" || _loc_2 == "ease" || _loc_2 == "overwrite" || _loc_2 == "onComplete" || _loc_2 == "onCompleteParams" || _loc_2 == "runBackwards" || _loc_2 == "autoAlpha" || _loc_2 == "_autoAlpha" || _loc_2 == "onStart" || _loc_2 == "onStartParams")
                    {
                        continue;
                    }
                    if (this.target.hasOwnProperty(_loc_2))
                    {
                        if (typeof(this.vars[_loc_2]) == "number")
                        {
                            _loc_3 = this.vars[_loc_2] - this.target[_loc_2];
                        }
                        else
                        {
                            _loc_3 = Number(this.vars[_loc_2]);
                        }
                        this.tweens[_loc_2] = {o:this.target, s:this.target[_loc_2], c:_loc_3, e:this.vars.ease};
                        continue;
                    }
                    this.extraTweens[_loc_2] = {o:this.target, s:0, c:0, e:this.vars.ease, v:this.vars[_loc_2]};
                }
            }
            if (this.vars.runBackwards == true)
            {
                for (_loc_2 in this.tweens)
                {
                    
                    _loc_8 = this.tweens[_loc_2];
                    this.tweens[_loc_2].s = _loc_8.s + _loc_8.c;
                    _loc_8.c = _loc_8.c * -1;
                    if (_loc_8.c != 0)
                    {
                        _loc_8.o[_loc_2] = _loc_8.e(0, _loc_8.s, _loc_8.c, this.duration);
                    }
                }
            }
            if (typeof(this.vars.autoAlpha) == "number")
            {
                this.target.visible = !(this.vars.runBackwards == true && this.target.alpha == 0);
            }
            return;
        }// end function

        public function render() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = (getTimer() - this.startTime) / 1000;
            if (_loc_1 > this.duration)
            {
                _loc_1 = this.duration;
            }
            for (_loc_3 in this.tweens)
            {
                
                _loc_2 = this.tweens[_loc_3];
                _loc_2.o[_loc_3] = _loc_2.e(_loc_1, _loc_2.s, _loc_2.c, this.duration);
            }
            if (_loc_1 == this.duration)
            {
                if (typeof(this.vars.autoAlpha) == "number" && this.target.alpha == 0)
                {
                    this.target.visible = false;
                }
                if (this.onComplete != null)
                {
                    this.onComplete.apply(null, this.onCompleteParams);
                }
                removeTween(this);
            }
            return;
        }// end function

        public function get active() : Boolean
        {
            if (this._active)
            {
                return true;
            }
            if ((getTimer() - this.initTime) / 1000 > this.delay)
            {
                this._active = true;
                this.startTime = this.initTime + this.delay * 1000;
                if (this.vars.runBackwards != true)
                {
                    this.initTweenVals();
                }
                else if (typeof(this.vars.autoAlpha) == "number")
                {
                    this.target.visible = true;
                }
                if (this.onStart != null)
                {
                    this.onStart.apply(null, this.onStartParams);
                }
                if (this.duration == 0.001)
                {
                    (this.startTime - 1);
                }
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public function set endTarget(param1:Object) : void
        {
            delete _all[this._endTarget][this];
            this._endTarget = param1;
            if (_all[param1] == undefined)
            {
                _all[param1] = new Dictionary();
            }
            _all[param1][this] = this;
            return;
        }// end function

        public function get endTarget() : Object
        {
            return this._endTarget;
        }// end function

        public function set volumeProxy(param1:Number) : void
        {
            this._sound.volume = param1;
            this.target.soundTransform = this._sound;
            return;
        }// end function

        public function get volumeProxy() : Number
        {
            return this._sound.volume;
        }// end function

        public function set colorProxy(param1:Number) : void
        {
            var _loc_2:* = 1 - param1;
            this.target.transform.colorTransform = new ColorTransform(this._color.redMultiplier * _loc_2 + this._endColor.redMultiplier * param1, this._color.greenMultiplier * _loc_2 + this._endColor.greenMultiplier * param1, this._color.blueMultiplier * _loc_2 + this._endColor.blueMultiplier * param1, this._color.alphaMultiplier * _loc_2 + this._endColor.alphaMultiplier * param1, this._color.redOffset * _loc_2 + this._endColor.redOffset * param1, this._color.greenOffset * _loc_2 + this._endColor.greenOffset * param1, this._color.blueOffset * _loc_2 + this._endColor.blueOffset * param1, this._color.alphaOffset * _loc_2 + this._endColor.alphaOffset * param1);
            return;
        }// end function

        public function get colorProxy() : Number
        {
            return 0;
        }// end function

        public static function to(param1:Object, param2:Number, param3:Object, param4:Number = 0, param5:Function = null, param6:Array = null, param7:Boolean = true) : TweenLite
        {
            return new TweenLite(param1, param2, param3, param4, param5, param6, param7);
        }// end function

        public static function from(param1:Object, param2:Number, param3:Object, param4:Number = 0, param5:Function = null, param6:Array = null, param7:Boolean = true) : TweenLite
        {
            param3.runBackwards = true;
            return new TweenLite(param1, param2, param3, param4, param5, param6, param7);
        }// end function

        public static function delayedCall(param1:Number, param2:Function, param3:Array = null) : TweenLite
        {
            return new TweenLite(param2, 0, {delay:param1, onComplete:param2, onCompleteParams:param3, overwrite:false});
        }// end function

        public static function removeTween(param1:TweenLite = null) : void
        {
            if (param1 != null && _all[param1.endTarget] != null)
            {
                delete _all[param1.endTarget][param1];
            }
            return;
        }// end function

        public static function killTweensOf(param1:Object = null) : void
        {
            if (param1 != null)
            {
                delete _all[param1];
            }
            return;
        }// end function

        public static function executeAll(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = _all;
            for (_loc_3 in _loc_2)
            {
                
                for (_loc_4 in _loc_2[_loc_3])
                {
                    
                    _loc_5 = _loc_2[_loc_3][_loc_4];
                    if (_loc_5.active)
                    {
                        _loc_5.render();
                    }
                }
            }
            return;
        }// end function

        public static function killGarbage(event:TimerEvent) : void
        {
            var _loc_4:* = false;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = _all;
            var _loc_3:* = 0;
            for (_loc_5 in _loc_2)
            {
                
                _loc_4 = false;
                for (_loc_6 in _loc_2[_loc_5])
                {
                    
                    _loc_4 = true;
                    break;
                }
                if (!_loc_4)
                {
                    delete _loc_2[_loc_5];
                    continue;
                }
                _loc_3++;
            }
            if (_loc_3 == 0)
            {
                _sprite.removeEventListener(Event.ENTER_FRAME, executeAll);
                _timer.removeEventListener("timer", killGarbage);
                _timer.stop();
                _listening = false;
            }
            return;
        }// end function

        private static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / param4;
            param1 = param1 / param4;
            return (-param3) * _loc_5 * (param1 - 2) + param2;
        }// end function

    }
}
