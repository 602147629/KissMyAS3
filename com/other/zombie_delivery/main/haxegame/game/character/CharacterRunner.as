package haxegame.game.character
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import flash.*;
    import haxe.ds.*;
    import haxegame.game.*;
    import haxegame.game.character._CharacterRunner.*;
    import haxegame.game.human.*;
    import haxegame.game.level.*;
    import haxegame.game.turn.*;
    import haxegame.game.zombie.*;
    import nape.callbacks.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.space.*;
    import zpp_nape.geom.*;

    public class CharacterRunner extends Object
    {
        public var nextTurn:NextTurn;
        public var napeMap:NapeCharacterMap;
        public var map:IMap;
        public var mainFunction:Function;
        public var level:Level;
        public var layer:IDisplayObjectContainer;
        public var creationTimer:CreationTimer;
        public var changedLevel:Boolean;
        public var appearancePosition:AppearancePosition;

        public function CharacterRunner(param1:IDisplayObjectContainer = undefined, param2:Space = undefined, param3:AssetsParser = undefined, param4:Level = undefined, param5:NextTurn = undefined, param6:CbType = undefined, param7:CbType = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            nextTurn = param5;
            level = param4;
            map = new IntMap();
            napeMap = new NapeCharacterMap(param2, param3, param6, param7);
            appearancePosition = AppearancePosition.FIX;
            creationTimer = new CreationTimer();
            startNextLevel();
            return;
        }// end function

        public function startNextLevel() : void
        {
            creationTimer.initialize(level.num);
            mainFunction = play;
            return;
        }// end function

        public function setWeight(param1:Body) : Number
        {
            var _loc_2:* = NaN;
            if (level.num >= 5)
            {
                if (Math.random() > 0.3)
                {
                    _loc_2 = 1;
                }
                else if (Math.random() > 0.15)
                {
                    _loc_2 = 1.25;
                }
                else
                {
                    _loc_2 = 1.5;
                }
            }
            else if (level.num >= 3)
            {
                if (Math.random() > 0.2)
                {
                    _loc_2 = 1;
                }
                else
                {
                    _loc_2 = 1.25;
                }
            }
            else
            {
                _loc_2 = 1;
            }
            return _loc_2;
        }// end function

        public function setNextRush() : void
        {
            var _loc_1:* = appearancePosition;
            switch(_loc_1.index) branch count is:<1>[15, 45] default offset is:<11>;
            ;
            appearancePosition = AppearancePosition.RANDOM;
            mainFunction = finishRush;
            ;
            appearancePosition = AppearancePosition.FIX;
            mainFunction = finishLevel;
            return;
        }// end function

        public function run() : void
        {
            mainFunction();
            return;
        }// end function

        public function play() : void
        {
            draw();
            creationTimer.run();
            if (creationTimer.creationOrder)
            {
                create();
                creationTimer.resetCreationOrder();
            }
            else if (creationTimer.isFinishedRush())
            {
                setNextRush();
            }
            return;
        }// end function

        public function isFinishedRushCreation() : Boolean
        {
            return Reflect.compareMethods(mainFunction, finishRush);
        }// end function

        public function isFinishedLevelCreation() : Boolean
        {
            return Reflect.compareMethods(mainFunction, finishLevel);
        }// end function

        public function finishRush() : void
        {
            draw();
            return;
        }// end function

        public function finishLevel() : void
        {
            draw();
            return;
        }// end function

        public function draw() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null as Body;
            var _loc_4:* = null as Character;
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
            var _loc_3:* = null as Character;
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

        public function delete(param1:int) : void
        {
            map.h[param1].destroy();
            map.remove(param1);
            napeMap.delete(param1);
            return;
        }// end function

        public function createNapeBody() : Body
        {
            var _loc_1:* = null as Body;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_2:* = appearancePosition;
            switch(_loc_2.index) branch count is:<1>[15, 215] default offset is:<11>;
            ;
            _loc_3 = level.num;
            switch(_loc_3) branch count is:<2>[14, 106, 127] default offset is:<14>;
            _loc_4 = creationTimer.creationCount % 3;
            switch(_loc_4) branch count is:<1>[32, 53] default offset is:<11>;
            _loc_1 = napeMap.createLittleRight();
            ;
            _loc_1 = napeMap.createCenter();
            ;
            _loc_1 = napeMap.createLittleLeft();
            ;
            _loc_1 = napeMap.createCenter();
            ;
            if (creationTimer.creationCount % 2 == 0)
            {
                _loc_1 = napeMap.createLittleLeft();
            }
            else
            {
                _loc_1 = napeMap.createLittleRight();
            }
            ;
            _loc_1 = napeMap.createRandomPosition();
            return _loc_1;
        }// end function

        public function createCharacter(param1:Body, param2:CharacterType, param3:Number, param4:CharacterColorType) : void
        {
            var _loc_5:* = null as Class;
            switch(param2.index) branch count is:<1>[26, 15] default offset is:<11>;
            ;
            _loc_5 = Zombie;
            ;
            _loc_5 = Human;
            var _loc_6:* = Type.createInstance(_loc_5, []);
            _loc_6.initialize(layer, param2, param3, param4);
            if (param1.zpp_inner.wrap_pos == null)
            {
                param1.zpp_inner.setupPosition();
            }
            var _loc_7:* = param1.zpp_inner.wrap_pos;
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_8:* = _loc_7.zpp_inner;
            if (_loc_8._validate != null)
            {
                _loc_8._validate();
            }
            if (param1.zpp_inner.wrap_pos == null)
            {
                param1.zpp_inner.setupPosition();
            }
            _loc_7 = param1.zpp_inner.wrap_pos;
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_8 = _loc_7.zpp_inner;
            if (_loc_8._validate != null)
            {
                _loc_8._validate();
            }
            _loc_6.draw(_loc_7.zpp_inner.x, _loc_7.zpp_inner.y);
            map.h[param1.zpp_inner_i.id] = _loc_6;
            return;
        }// end function

        public function create() : void
        {
            var _loc_2:* = null as CharacterType;
            var _loc_1:* = createNapeBody();
            var _loc_3:* = nextTurn.type;
            switch(_loc_3) branch count is:<3>[17, 21, 63, 77] default offset is:<17>;
            ;
            if (Math.random() > 0.5)
            {
                _loc_2 = CharacterType.ZOMBIE;
            }
            else
            {
                _loc_2 = CharacterType.HUMAN;
            }
            ;
            _loc_2 = CharacterType.ZOMBIE;
            ;
            _loc_2 = CharacterType.HUMAN;
            var _loc_4:* = setWeight(_loc_1);
            var _loc_5:* = CharacterColor.getType(level);
            createCharacter(_loc_1, _loc_2, _loc_4, _loc_5);
            return;
        }// end function

    }
}
