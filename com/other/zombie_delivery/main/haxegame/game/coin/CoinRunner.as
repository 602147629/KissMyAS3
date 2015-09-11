package haxegame.game.coin
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import flash.*;
    import haxe.ds.*;
    import haxegame.game.*;
    import haxegame.game.combo.*;
    import haxegame.se.*;
    import nape.callbacks.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.space.*;
    import zpp_nape.geom.*;

    public class CoinRunner extends Object
    {
        public var napeMap:NapeCoinMap;
        public var map:IMap;
        public var mainFunction:Function;
        public var layer:IDisplayObjectContainer;
        public var comboSet:ComboSet;
        public static var CREATE_ONCE_MAX_SMALL:int;
        public static var CREATE_ONCE_MAX_MIDDLE:int;
        public static var CREATE_ONCE_MAX_BIG:int;
        public static var CREATE_ONCE_SPECIAL:int;
        public static var CREATE_SPECIAL_PERSENTAGE:Number;
        public static var CREATE_ONCE_COMBO_SPECIAL:int;

        public function CoinRunner(param1:IDisplayObjectContainer = undefined, param2:Space = undefined, param3:AssetsParser = undefined, param4:CbType = undefined, param5:ComboSet = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            comboSet = param5;
            map = new IntMap();
            napeMap = new NapeCoinMap(param2, param3, param4);
            return;
        }// end function

        public function run() : void
        {
            draw();
            delete();
            return;
        }// end function

        public function getType(param1:Number) : int
        {
            var _loc_2:* = Math.random();
            var _loc_3:* = param1;
            if (_loc_3 == 1)
            {
                if (_loc_2 > 0.95)
                {
                    return 200;
                }
                else if (_loc_2 > 0.8)
                {
                    return 100;
                }
                else
                {
                    return 50;
                }
            }
            else if (_loc_3 == 1.25)
            {
                if (_loc_2 > 0.8)
                {
                    return 200;
                }
                else if (_loc_2 > 0.5)
                {
                    return 100;
                }
                else
                {
                    return 50;
                }
            }
            else if (_loc_3 == 1.5)
            {
                if (_loc_2 > 0.6)
                {
                    return 200;
                }
                else if (_loc_2 > 0.3)
                {
                    return 100;
                }
                else
                {
                    return 50;
                }
                ;
            }
            return;
        }// end function

        public function getCreateTotal(param1:Number) : int
        {
            var _loc_2:* = 0;
            if (comboSet.isSpecialCount())
            {
                SoundMixer.playComboSpecial();
                return 7;
            }
            if (Math.random() < 0.02)
            {
                SoundMixer.playCoinSpecial();
                return 5;
            }
            var _loc_3:* = param1;
            if (_loc_3 == 1)
            {
                _loc_2 = 3;
            }
            else if (_loc_3 == 1.25)
            {
                _loc_2 = 4;
            }
            else if (_loc_3 == 1.5)
            {
                _loc_2 = 5;
                ;
            }
            return (Math.floor(Math.random() * 3) + 1);
        }// end function

        public function draw() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null as Body;
            var _loc_4:* = null as Coin;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = napeMap.map.keys();
            
            if (_loc_1.hasNext())
            {
                _loc_2 = _loc_1.next();
                _loc_3 = napeMap.map.h[_loc_2];
                _loc_4 = map.h[_loc_3.zpp_inner_i.id];
                if (_loc_3.zpp_inner.wrap_pos == null)
                {
                    _loc_3.zpp_inner.setupPosition();
                }
                _loc_5 = _loc_3.zpp_inner.wrap_pos;
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_5.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_3.zpp_inner.wrap_pos == null)
                {
                    _loc_3.zpp_inner.setupPosition();
                }
                _loc_5 = _loc_3.zpp_inner.wrap_pos;
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_5.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_4.draw(_loc_5.zpp_inner.x, _loc_5.zpp_inner.y);
                ;
            }
            return;
        }// end function

        public function destroy() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null as Coin;
            var _loc_1:* = map.keys();
            
            if (_loc_1.hasNext())
            {
                _loc_2 = _loc_1.next();
                _loc_3 = map.h[_loc_2];
                _loc_3.destroy();
                napeMap.delete(_loc_2);
                ;
            }
            map = null;
            napeMap = null;
            return;
        }// end function

        public function delete() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null as Body;
            var _loc_4:* = null as Coin;
            var _loc_1:* = napeMap.map.keys();
            
            if (_loc_1.hasNext())
            {
                _loc_2 = _loc_1.next();
                _loc_3 = napeMap.map.h[_loc_2];
                _loc_4 = map.h[_loc_3.zpp_inner_i.id];
                if (_loc_4.isCountMax())
                {
                    _loc_4.destroy();
                    map.remove(_loc_3.zpp_inner_i.id);
                    napeMap.delete(_loc_3.zpp_inner_i.id);
                }
                ;
            }
            return;
        }// end function

        public function create(param1:Number, param2:Number, param3:Number) : Array
        {
            var _loc_6:* = 0;
            var _loc_7:* = null as Body;
            var _loc_8:* = null as Coin;
            var _loc_4:* = [];
            var _loc_5:* = getCreateTotal(param3);
            do
            {
                
                _loc_6 = getType(param3);
                _loc_4.push(_loc_6);
                if (!napeMap.existsPool())
                {
                }
                else
                {
                    _loc_7 = napeMap.create(param1, param2);
                    _loc_8 = new Coin(layer, _loc_6);
                    _loc_8.draw(param1, param2);
                    map.h[_loc_7.zpp_inner_i.id] = _loc_8;
                }
                _loc_5--;
            }while (_loc_5 > -1)
            return _loc_4;
        }// end function

    }
}
