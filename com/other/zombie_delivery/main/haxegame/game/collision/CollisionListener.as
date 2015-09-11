package haxegame.game.collision
{
    import flash.*;
    import nape.callbacks.*;
    import nape.space.*;
    import zpp_nape.util.*;

    public class CollisionListener extends Object
    {
        public var space:Space;
        public var interactionListenerForCoinAndBackground:InteractionListener;
        public var interactionListenerForBallAndWall:InteractionListener;
        public var interactionListenerForBallAndFloor:InteractionListener;
        public var coinAndBackgroundSet:Array;
        public var characterAndWallSet:Array;
        public var characterAndFloorSet:Array;
        public var callBackTypeForCoinAndBackground:CbType;
        public var callBackTypeForCharacterAndWall:CbType;
        public var callBackTypeForBallAndFloor:CbType;

        public function CollisionListener(param1:Space = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            space = param1;
            setCharacterAndWall();
            setCharacterAndFloor();
            setCoinAndBackground();
            return;
        }// end function

        public function setCoinAndBackground() : void
        {
            coinAndBackgroundSet = [];
            callBackTypeForCoinAndBackground = new CbType();
            if (ZPP_Flags.CbEvent_ONGOING == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.CbEvent_ONGOING = new CbEvent();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.InteractionType_COLLISION == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InteractionType_COLLISION = new InteractionType();
                ZPP_Flags.internal = false;
            }
            interactionListenerForCoinAndBackground = new InteractionListener(ZPP_Flags.CbEvent_ONGOING, ZPP_Flags.InteractionType_COLLISION, callBackTypeForCoinAndBackground, callBackTypeForCoinAndBackground, onCollisionCoinAndBackground);
            var _loc_1:* = space.zpp_inner.wrap_listeners;
            var _loc_2:* = interactionListenerForCoinAndBackground;
            if (_loc_1.zpp_inner.reverse_flag)
            {
                _loc_1.push(_loc_2);
            }
            else
            {
                _loc_1.unshift(_loc_2);
            }
            return;
        }// end function

        public function setCharacterAndWall() : void
        {
            characterAndWallSet = [];
            callBackTypeForCharacterAndWall = new CbType();
            if (ZPP_Flags.CbEvent_ONGOING == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.CbEvent_ONGOING = new CbEvent();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.InteractionType_COLLISION == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InteractionType_COLLISION = new InteractionType();
                ZPP_Flags.internal = false;
            }
            interactionListenerForBallAndWall = new InteractionListener(ZPP_Flags.CbEvent_ONGOING, ZPP_Flags.InteractionType_COLLISION, callBackTypeForCharacterAndWall, callBackTypeForCharacterAndWall, onCollisionCharacterAndWall);
            var _loc_1:* = space.zpp_inner.wrap_listeners;
            var _loc_2:* = interactionListenerForBallAndWall;
            if (_loc_1.zpp_inner.reverse_flag)
            {
                _loc_1.push(_loc_2);
            }
            else
            {
                _loc_1.unshift(_loc_2);
            }
            return;
        }// end function

        public function setCharacterAndFloor() : void
        {
            characterAndFloorSet = [];
            callBackTypeForBallAndFloor = new CbType();
            if (ZPP_Flags.CbEvent_ONGOING == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.CbEvent_ONGOING = new CbEvent();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.InteractionType_COLLISION == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InteractionType_COLLISION = new InteractionType();
                ZPP_Flags.internal = false;
            }
            interactionListenerForBallAndFloor = new InteractionListener(ZPP_Flags.CbEvent_ONGOING, ZPP_Flags.InteractionType_COLLISION, callBackTypeForBallAndFloor, callBackTypeForBallAndFloor, onCollisionBallAndFloor);
            var _loc_1:* = space.zpp_inner.wrap_listeners;
            var _loc_2:* = interactionListenerForBallAndFloor;
            if (_loc_1.zpp_inner.reverse_flag)
            {
                _loc_1.push(_loc_2);
            }
            else
            {
                _loc_1.unshift(_loc_2);
            }
            return;
        }// end function

        public function reset() : void
        {
            characterAndWallSet = [];
            characterAndFloorSet = [];
            coinAndBackgroundSet = [];
            return;
        }// end function

        public function onCollisionCoinAndBackground(param1:InteractionCallback) : void
        {
            coinAndBackgroundSet.push(new CollisionPair(param1.zpp_inner.int1.outer_i.zpp_inner_i.id, param1.zpp_inner.int2.outer_i.zpp_inner_i.id));
            return;
        }// end function

        public function onCollisionCharacterAndWall(param1:InteractionCallback) : void
        {
            characterAndWallSet.push(new CollisionPair(param1.zpp_inner.int1.outer_i.zpp_inner_i.id, param1.zpp_inner.int2.outer_i.zpp_inner_i.id));
            return;
        }// end function

        public function onCollisionBallAndFloor(param1:InteractionCallback) : void
        {
            characterAndFloorSet.push(new CollisionPair(param1.zpp_inner.int1.outer_i.zpp_inner_i.id, param1.zpp_inner.int2.outer_i.zpp_inner_i.id));
            return;
        }// end function

        public function destroy() : void
        {
            space.zpp_inner.wrap_listeners.remove(interactionListenerForBallAndWall);
            space.zpp_inner.wrap_listeners.remove(interactionListenerForBallAndFloor);
            space.zpp_inner.wrap_listeners.remove(interactionListenerForCoinAndBackground);
            return;
        }// end function

    }
}
