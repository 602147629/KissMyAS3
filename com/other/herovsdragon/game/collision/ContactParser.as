package herovsdragon.game.collision
{
    import Box2D.Collision.*;
    import Box2D.Dynamics.*;
    import Box2D.Dynamics.Contacts.*;
    import __AS3__.vec.*;
    import com.dango_itimi.box2d.*;
    import com.dango_itimi.box2d.material.*;
    import herovsdragon.game.box2d.view.*;

    public class ContactParser extends Object
    {
        private var world:b2World;
        private var chunkKey:String;
        private var hitCheckerSet:Vector.<HitChecker>;
        private var hittedSomething:Boolean;
        private var outHitChecker0:HitChecker;
        private var outHitChecker1:HitChecker;
        private var outHitChecker2:HitChecker;
        private var outHitChecker3:HitChecker;
        private var fireHitChecker:HitChecker;

        public function ContactParser(param1:b2World, param2:String, param3:ViewParser)
        {
            this.chunkKey = param2;
            this.world = param1;
            this.hitCheckerSet = new Vector.<HitChecker>;
            this.outHitChecker0 = this.createHitChecker(param3.getChunkInBox(ChunkSetParameter.ID_BOX_BACKGROUND, 0));
            this.outHitChecker1 = this.createHitChecker(param3.getChunkInBox(ChunkSetParameter.ID_BOX_BACKGROUND, 1));
            this.outHitChecker2 = this.createHitChecker(param3.getChunkInBox(ChunkSetParameter.ID_BOX_BACKGROUND, 2));
            this.outHitChecker3 = this.createHitChecker(param3.getChunkInBox(ChunkSetParameter.ID_BOX_BACKGROUND, 3));
            this.fireHitChecker = this.createHitChecker(param3.getChunkInBox(ChunkSetParameter.ID_FIRE, 0));
            return;
        }// end function

        private function createHitChecker(param1:Chunk) : HitChecker
        {
            return this.createHitCheckerCmn(param1._key);
        }// end function

        private function createHitCheckerCmn(param1:String) : HitChecker
        {
            var _loc_2:* = new HitChecker(param1);
            this.hitCheckerSet.push(_loc_2);
            return _loc_2;
        }// end function

        public function run() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = this.createB2ContactSet();
            this.hittedSomething = false;
            for each (_loc_2 in this.hitCheckerSet)
            {
                
                _loc_2.initialize();
            }
            this.checkBeginedContact(_loc_1);
            return;
        }// end function

        private function createB2ContactSet() : Vector.<b2Contact>
        {
            var _loc_1:* = new Vector.<b2Contact>;
            var _loc_2:* = this.world.GetContactList();
            while (_loc_2)
            {
                
                _loc_1.push(_loc_2);
                _loc_2 = _loc_2.GetNext();
            }
            return _loc_1;
        }// end function

        private function checkBeginedContact(param1:Vector.<b2Contact>) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            for each (_loc_2 in param1)
            {
                
                _loc_3 = _loc_2.GetManifold();
                if (_loc_3.m_pointCount == 0)
                {
                    continue;
                }
                _loc_4 = new ContactKey(_loc_2);
                if (!_loc_4.checkWhetherContacted(this.chunkKey))
                {
                    continue;
                }
                this.hittedSomething = true;
                for each (_loc_5 in this.hitCheckerSet)
                {
                    
                    _loc_5.exec(_loc_4, _loc_3.m_localPlaneNormal);
                }
            }
            return;
        }// end function

        public function get _hittedSomething() : Boolean
        {
            return this.hittedSomething;
        }// end function

        public function isOutForArrow() : Boolean
        {
            if (!this.outHitChecker0._hitted)
            {
            }
            if (!this.outHitChecker1._hitted)
            {
            }
            if (!this.outHitChecker2._hitted)
            {
            }
            return this.outHitChecker3._hitted;
        }// end function

        public function isOutForKaba() : Boolean
        {
            return this.outHitChecker0._hitted;
        }// end function

        public function isHittedFire() : Boolean
        {
            return this.fireHitChecker._hitted;
        }// end function

    }
}

import Box2D.Collision.*;

import Box2D.Dynamics.*;

import Box2D.Dynamics.Contacts.*;

import __AS3__.vec.*;

import com.dango_itimi.box2d.*;

import com.dango_itimi.box2d.material.*;

import herovsdragon.game.box2d.view.*;

class HitChecker extends Object
{
    private var hitted:Boolean;
    private var checkedKey:String;
    private var manifoldMLocalPlaneNormal:b2Vec2 = null;

    function HitChecker(param1:String)
    {
        this.checkedKey = param1;
        this.initialize();
        return;
    }// end function

    public function initialize() : void
    {
        this.hitted = false;
        return;
    }// end function

    public function exec(param1:ContactKey, param2:b2Vec2) : Boolean
    {
        if (param1.checkWhetherContacted(this.checkedKey))
        {
            this.hitted = true;
            this.manifoldMLocalPlaneNormal = param2;
            return true;
        }
        param2 = null;
        return false;
    }// end function

    public function get _hitted() : Boolean
    {
        return this.hitted;
    }// end function

    public function get _manifoldMLocalPlaneNormal() : b2Vec2
    {
        return this.manifoldMLocalPlaneNormal;
    }// end function

}


import Box2D.Collision.*;

import Box2D.Dynamics.*;

import Box2D.Dynamics.Contacts.*;

import __AS3__.vec.*;

import com.dango_itimi.box2d.*;

import com.dango_itimi.box2d.material.*;

import herovsdragon.game.box2d.view.*;

class ContactKey extends Object
{
    private var keyA:String;
    private var keyB:String;

    function ContactKey(param1:b2Contact)
    {
        var _loc_2:* = param1.GetFixtureA().GetBody().GetUserData();
        var _loc_3:* = param1.GetFixtureB().GetBody().GetUserData();
        if (_loc_2)
        {
            this.keyA = _loc_2._key;
        }
        if (_loc_3)
        {
            this.keyB = _loc_3._key;
        }
        return;
    }// end function

    public function checkWhetherContacted(param1:String) : Boolean
    {
        if (this.keyA != param1)
        {
        }
        return this.keyB == param1;
    }// end function

    public function getChunkInMap(param1:Dictionary) : Chunk
    {
        if (!param1[this.keyA])
        {
        }
        if (!param1[this.keyB])
        {
            return null;
        }
        return param1[this.keyA] ? (param1[this.keyA]) : (param1[this.keyB] ? (param1[this.keyB]) : (null));
    }// end function

    public function get _keyA() : String
    {
        return this.keyA;
    }// end function

    public function get _keyB() : String
    {
        return this.keyB;
    }// end function

    public function toString() : String
    {
        return this.keyA + ":" + this.keyB;
    }// end function

}

