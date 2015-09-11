package 
{
    import __AS3__.vec.*;
    import com.dango_itimi.as3_and_createjs.font.*;
    import flash.*;
    import flash.display.*;
    import haxe.*;
    import haxegame.*;
    import haxegame.game.character._CharacterWeight.*;
    import haxegame.game.coin._CoinType.*;
    import haxegame.game.pointer.*;
    import haxegame.game.turn._TurnType.*;
    import haxegame.save._Language.*;
    import nape.callbacks.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import zpp_nape.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.constraint.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    dynamic public class boot_2a9b extends Boot
    {

        public function boot_2a9b() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (Lib.current == null)
            {
                Lib.current = this;
            }
            start();
            return;
        }// end function

        override public function init() : void
        {
            var _loc_1:* = Date;
            _loc_1.now = function ()
            {
                return new Date;
            }// end function
            ;
            _loc_1.fromTime = function (param1) : Date
            {
                var _loc_2:* = new Date;
                _loc_2.setTime(param1);
                return _loc_2;
            }// end function
            ;
            _loc_1.fromString = function (param1:String) : Date
            {
                var _loc_3:* = null as Array;
                var _loc_4:* = null as Date;
                var _loc_5:* = null as Array;
                var _loc_6:* = null as Array;
                var _loc_2:* = param1.length;
                switch(_loc_2) branch count is:<19>[65, 65, 65, 65, 65, 65, 65, 65, 77, 65, 153, 65, 65, 65, 65, 65, 65, 65, 65, 208] default offset is:<65>;
                throw "Invalid date format : " + param1;
                ;
                _loc_3 = param1.split(":");
                _loc_4 = new Date;
                _loc_4.setTime(0);
                _loc_4.setUTCHours(_loc_3[0]);
                _loc_4.setUTCMinutes(_loc_3[1]);
                _loc_4.setUTCSeconds(_loc_3[2]);
                return _loc_4;
                ;
                _loc_3 = param1.split("-");
                return new Date(_loc_3[0], (_loc_3[1] - 1), _loc_3[2], 0, 0, 0);
                ;
                _loc_3 = param1.split(" ");
                _loc_5 = _loc_3[0].split("-");
                _loc_6 = _loc_3[1].split(":");
                return new Date(_loc_5[0], (_loc_5[1] - 1), _loc_5[2], _loc_6[0], _loc_6[1], _loc_6[2]);
                return;
            }// end function
            ;
            _loc_1.prototype["toString"] = function () : String
            {
                var _loc_1:* = this;
                var _loc_2:* = _loc_1.getMonth() + 1;
                var _loc_3:* = _loc_1.getDate();
                var _loc_4:* = _loc_1.getHours();
                var _loc_5:* = _loc_1.getMinutes();
                var _loc_6:* = _loc_1.getSeconds();
                return _loc_1.getFullYear() + "-" + (_loc_2 < 10 ? ("0" + _loc_2) : ("" + _loc_2)) + "-" + (_loc_3 < 10 ? ("0" + _loc_3) : ("" + _loc_3)) + " " + (_loc_4 < 10 ? ("0" + _loc_4) : ("" + _loc_4)) + ":" + (_loc_5 < 10 ? ("0" + _loc_5) : ("" + _loc_5)) + ":" + (_loc_6 < 10 ? ("0" + _loc_6) : ("" + _loc_6));
            }// end function
            ;
            Math.NaN = Number.NaN;
            Math.NEGATIVE_INFINITY = Number.NEGATIVE_INFINITY;
            Math.POSITIVE_INFINITY = Number.POSITIVE_INFINITY;
            Math.isFinite = function (param1:Number) : Boolean
            {
                return isFinite(param1);
            }// end function
            ;
            Math.isNaN = function (param1:Number) : Boolean
            {
                return isNaN(param1);
            }// end function
            ;
            if (!TextToBitmapFontConverter.init__)
            {
                TextToBitmapFontConverter.init__ = true;
                TextToBitmapFontConverter.JIS_0201_EReg = new EReg("[ -~｡-ﾟ]", "");
            }
            if (!Unserializer.init__)
            {
                Unserializer.init__ = true;
                Unserializer.DEFAULT_RESOLVER = Type;
            }
            if (!URI.init__)
            {
                URI.init__ = true;
                URI.GAME = "http://www.deeg-entertainment.jp/" + "zombie_delivery/";
                URI.ABOUT = "http://www.deeg-entertainment.jp/" + "app/";
            }
            if (!CharacterWeight_Impl_.init__)
            {
                CharacterWeight_Impl_.init__ = true;
                CharacterWeight_Impl_.SMALL = 1;
                CharacterWeight_Impl_.MIDDLE = 1.25;
                CharacterWeight_Impl_.BIG = 1.5;
            }
            if (!CoinType_Impl_.init__)
            {
                CoinType_Impl_.init__ = true;
                CoinType_Impl_.SMALL = 50;
                CoinType_Impl_.MIDDLE = 100;
                CoinType_Impl_.BIG = 200;
            }
            if (!Line.init__)
            {
                Line.init__ = true;
                Line.LINE_THICKNESS = 4;
                Line.LINE_ALPHA = 1;
            }
            if (!TurnType_Impl_.init__)
            {
                TurnType_Impl_.init__ = true;
                TurnType_Impl_.NORMAL = 1;
                TurnType_Impl_.ZOMBIE = 2;
                TurnType_Impl_.HUMAN = 3;
            }
            if (!Language_Impl_.init__)
            {
                Language_Impl_.init__ = true;
                Language_Impl_.JAPANESE = "ja";
                Language_Impl_.ENGLISH = "eng";
            }
            if (!ZPP_Const.init__)
            {
                ZPP_Const.init__ = true;
                ZPP_Const.vec2vector = Type.getClass(new Vector.<Vec2>);
                ZPP_Const.cbtypevector = Type.getClass(new Vector.<CbType>);
                ZPP_Const.optiontypevector = Type.getClass(new Vector.<OptionType>);
            }
            if (!ZPP_CbType.init__)
            {
                ZPP_CbType.init__ = true;
                ZPP_CbType.ANY_SHAPE = new CbType();
                ZPP_CbType.ANY_BODY = new CbType();
                ZPP_CbType.ANY_COMPOUND = new CbType();
                ZPP_CbType.ANY_CONSTRAINT = new CbType();
            }
            if (!ZPP_Listener.init__)
            {
                ZPP_Listener.init__ = true;
                if (ZPP_Flags.ListenerType_BODY == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ListenerType_BODY = new ListenerType();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.ListenerType_CONSTRAINT == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ListenerType_CONSTRAINT = new ListenerType();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.ListenerType_INTERACTION == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ListenerType_INTERACTION = new ListenerType();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.ListenerType_PRE == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ListenerType_PRE = new ListenerType();
                    ZPP_Flags.internal = false;
                }
                ZPP_Listener.types = [ZPP_Flags.ListenerType_BODY, ZPP_Flags.ListenerType_CONSTRAINT, ZPP_Flags.ListenerType_INTERACTION, ZPP_Flags.ListenerType_PRE];
                if (ZPP_Flags.CbEvent_BEGIN == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.CbEvent_BEGIN = new CbEvent();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.CbEvent_END == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.CbEvent_END = new CbEvent();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.CbEvent_WAKE == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.CbEvent_WAKE = new CbEvent();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.CbEvent_SLEEP == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.CbEvent_SLEEP = new CbEvent();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.CbEvent_BREAK == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.CbEvent_BREAK = new CbEvent();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.CbEvent_PRE == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.CbEvent_PRE = new CbEvent();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.CbEvent_ONGOING == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.CbEvent_ONGOING = new CbEvent();
                    ZPP_Flags.internal = false;
                }
                ZPP_Listener.events = [ZPP_Flags.CbEvent_BEGIN, ZPP_Flags.CbEvent_END, ZPP_Flags.CbEvent_WAKE, ZPP_Flags.CbEvent_SLEEP, ZPP_Flags.CbEvent_BREAK, ZPP_Flags.CbEvent_PRE, ZPP_Flags.CbEvent_ONGOING];
            }
            if (!ZPP_InteractionListener.init__)
            {
                ZPP_InteractionListener.init__ = true;
                ZPP_InteractionListener.UCbSet = new ZNPList_ZPP_CbSet();
                ZPP_InteractionListener.VCbSet = new ZNPList_ZPP_CbSet();
                ZPP_InteractionListener.WCbSet = new ZNPList_ZPP_CbSet();
                ZPP_InteractionListener.UCbType = new ZNPList_ZPP_CbType();
                ZPP_InteractionListener.VCbType = new ZNPList_ZPP_CbType();
                ZPP_InteractionListener.WCbType = new ZNPList_ZPP_CbType();
            }
            if (!ZPP_AngleDraw.init__)
            {
                ZPP_AngleDraw.init__ = true;
                ZPP_AngleDraw.maxarc = Math.PI / 4;
            }
            if (!ZPP_Arbiter.init__)
            {
                ZPP_Arbiter.init__ = true;
                if (ZPP_Flags.ArbiterType_COLLISION == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ArbiterType_COLLISION = new ArbiterType();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.ArbiterType_SENSOR == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ArbiterType_SENSOR = new ArbiterType();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.ArbiterType_FLUID == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ArbiterType_FLUID = new ArbiterType();
                    ZPP_Flags.internal = false;
                }
                ZPP_Arbiter.types = [null, ZPP_Flags.ArbiterType_COLLISION, ZPP_Flags.ArbiterType_SENSOR, null, ZPP_Flags.ArbiterType_FLUID];
            }
            if (!ZPP_Collide.init__)
            {
                ZPP_Collide.init__ = true;
                ZPP_Collide.flowpoly = new ZNPList_ZPP_Vec2();
                ZPP_Collide.flowsegs = new ZNPList_ZPP_Vec2();
            }
            if (!ZPP_MarchingSquares.init__)
            {
                ZPP_MarchingSquares.init__ = true;
                ZPP_MarchingSquares.me = new ZPP_MarchingSquares();
            }
            if (!ZPP_Body.init__)
            {
                ZPP_Body.init__ = true;
                if (ZPP_Flags.BodyType_STATIC == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.BodyType_STATIC = new BodyType();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.BodyType_DYNAMIC == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.BodyType_DYNAMIC = new BodyType();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.BodyType_KINEMATIC == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.BodyType_KINEMATIC = new BodyType();
                    ZPP_Flags.internal = false;
                }
                ZPP_Body.types = [null, ZPP_Flags.BodyType_STATIC, ZPP_Flags.BodyType_DYNAMIC, ZPP_Flags.BodyType_KINEMATIC];
            }
            if (!ZPP_Shape.init__)
            {
                ZPP_Shape.init__ = true;
                if (ZPP_Flags.ShapeType_CIRCLE == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ShapeType_CIRCLE = new ShapeType();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.ShapeType_POLYGON == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ShapeType_POLYGON = new ShapeType();
                    ZPP_Flags.internal = false;
                }
                ZPP_Shape.types = [ZPP_Flags.ShapeType_CIRCLE, ZPP_Flags.ShapeType_POLYGON];
            }
            if (!ZPP_AABBTree.init__)
            {
                ZPP_AABBTree.init__ = true;
                ZPP_AABBTree.tmpaabb = new ZPP_AABB();
            }
            MainForFlash.main();
            return;
        }// end function

    }
}
