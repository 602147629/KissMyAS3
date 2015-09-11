package zpp_nape.dynamics
{
    import flash.*;
    import nape.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_ColArbiter extends ZPP_Arbiter
    {
        public var wrap_normal:Vec2;
        public var wrap_contacts:ContactList;
        public var userdef_stat_fric:Boolean;
        public var userdef_rfric:Boolean;
        public var userdef_restitution:Boolean;
        public var userdef_dyn_fric:Boolean;
        public var surfacey:Number;
        public var surfacex:Number;
        public var stat_fric:Number;
        public var stat:Boolean;
        public var s2:ZPP_Shape;
        public var s1:ZPP_Shape;
        public var rt2b:Number;
        public var rt2a:Number;
        public var rt1b:Number;
        public var rt1a:Number;
        public var rn2b:Number;
        public var rn2a:Number;
        public var rn1b:Number;
        public var rn1a:Number;
        public var rfric:Number;
        public var rev:Boolean;
        public var restitution:Number;
        public var radius:Number;
        public var rMass:Number;
        public var ptype:int;
        public var pre_dt:Number;
        public var outer_zn:CollisionArbiter;
        public var oc2:ZPP_Contact;
        public var oc1:ZPP_Contact;
        public var ny:Number;
        public var nx:Number;
        public var next:ZPP_ColArbiter;
        public var mutable:Boolean;
        public var lproj:Number;
        public var lnormy:Number;
        public var lnormx:Number;
        public var kMassc:Number;
        public var kMassb:Number;
        public var kMassa:Number;
        public var k2y:Number;
        public var k2x:Number;
        public var k1y:Number;
        public var k1x:Number;
        public var jrAcc:Number;
        public var innards:ZPP_IContact;
        public var hpc2:Boolean;
        public var hc2:Boolean;
        public var dyn_fric:Number;
        public var contacts:ZPP_Contact;
        public var c2:ZPP_IContact;
        public var c1:ZPP_IContact;
        public var biasCoef:Number;
        public var __ref_vertex:int;
        public var __ref_edge2:ZPP_Edge;
        public var __ref_edge1:ZPP_Edge;
        public var Kc:Number;
        public var Kb:Number;
        public var Ka:Number;
        public static var FACE1:int;
        public static var FACE2:int;
        public static var CIRCLE:int;
        public static var zpp_pool:ZPP_ColArbiter;

        public function ZPP_ColArbiter() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            pre_dt = 0;
            mutable = false;
            stat = false;
            next = null;
            hpc2 = false;
            hc2 = false;
            oc2 = null;
            c2 = null;
            oc1 = null;
            c1 = null;
            __ref_vertex = 0;
            __ref_edge2 = null;
            __ref_edge1 = null;
            biasCoef = 0;
            rev = false;
            radius = 0;
            lproj = 0;
            lnormy = 0;
            lnormx = 0;
            surfacey = 0;
            surfacex = 0;
            k2y = 0;
            k2x = 0;
            k1y = 0;
            k1x = 0;
            rt2b = 0;
            rn2b = 0;
            rt2a = 0;
            rn2a = 0;
            rt1b = 0;
            rn1b = 0;
            rt1a = 0;
            rn1a = 0;
            jrAcc = 0;
            rMass = 0;
            Kc = 0;
            Kb = 0;
            Ka = 0;
            kMassc = 0;
            kMassb = 0;
            kMassa = 0;
            wrap_normal = null;
            ny = 0;
            nx = 0;
            innards = null;
            wrap_contacts = null;
            contacts = null;
            s2 = null;
            s1 = null;
            userdef_rfric = false;
            userdef_restitution = false;
            userdef_stat_fric = false;
            userdef_dyn_fric = false;
            rfric = 0;
            restitution = 0;
            stat_fric = 0;
            dyn_fric = 0;
            outer_zn = null;
            pre_dt = -1;
            contacts = new ZPP_Contact();
            innards = new ZPP_IContact();
            type = ZPP_Arbiter.COL;
            colarb = this;
            return;
        }// end function

        public function warmStart() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            _loc_1 = nx * c1.jnAcc - ny * c1.jtAcc;
            _loc_2 = ny * c1.jnAcc + nx * c1.jtAcc;
            _loc_3 = b1.imass;
            b1.velx = b1.velx - _loc_1 * _loc_3;
            b1.vely = b1.vely - _loc_2 * _loc_3;
            b1.angvel = b1.angvel - b1.iinertia * (_loc_2 * c1.r1x - _loc_1 * c1.r1y);
            _loc_3 = b2.imass;
            b2.velx = b2.velx + _loc_1 * _loc_3;
            b2.vely = b2.vely + _loc_2 * _loc_3;
            b2.angvel = b2.angvel + b2.iinertia * (_loc_2 * c1.r2x - _loc_1 * c1.r2y);
            if (hc2)
            {
                _loc_1 = nx * c2.jnAcc - ny * c2.jtAcc;
                _loc_2 = ny * c2.jnAcc + nx * c2.jtAcc;
                _loc_3 = b1.imass;
                b1.velx = b1.velx - _loc_1 * _loc_3;
                b1.vely = b1.vely - _loc_2 * _loc_3;
                b1.angvel = b1.angvel - b1.iinertia * (_loc_2 * c2.r1x - _loc_1 * c2.r1y);
                _loc_3 = b2.imass;
                b2.velx = b2.velx + _loc_1 * _loc_3;
                b2.vely = b2.vely + _loc_2 * _loc_3;
                b2.angvel = b2.angvel + b2.iinertia * (_loc_2 * c2.r2x - _loc_1 * c2.r2y);
            }
            b2.angvel = b2.angvel + jrAcc * b2.iinertia;
            b1.angvel = b1.angvel - jrAcc * b1.iinertia;
            return;
        }// end function

        public function validate_props() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = 0;
            var _loc_3:* = NaN;
            if (invalidated)
            {
                invalidated = false;
                if (!userdef_restitution)
                {
                    if (s1.material.elasticity > -17899999999999994000000000000)
                    {
                    }
                    if (s2.material.elasticity <= -17899999999999994000000000000)
                    {
                        restitution = 0;
                    }
                    else
                    {
                        if (s1.material.elasticity < 17899999999999994000000000000)
                        {
                        }
                        if (s2.material.elasticity >= 17899999999999994000000000000)
                        {
                            restitution = 1;
                        }
                        else
                        {
                            restitution = (s1.material.elasticity + s2.material.elasticity) / 2;
                        }
                    }
                    if (restitution < 0)
                    {
                        restitution = 0;
                    }
                    if (restitution > 1)
                    {
                        restitution = 1;
                    }
                }
                if (!userdef_dyn_fric)
                {
                    _loc_1 = s1.material.dynamicFriction * s2.material.dynamicFriction;
                    if (_loc_1 == 0)
                    {
                        dyn_fric = 0;
                    }
                    else
                    {
                        _loc_2 = 1597463007 - (0 >> 1);
                        _loc_3 = 0;
                        _loc_2.dyn_fric = 0 / (_loc_3 * (1.5 - 0.5 * _loc_1 * _loc_3 * _loc_3));
                    }
                }
                if (!userdef_stat_fric)
                {
                    _loc_1 = s1.material.staticFriction * s2.material.staticFriction;
                    if (_loc_1 == 0)
                    {
                        stat_fric = 0;
                    }
                    else
                    {
                        _loc_2 = 1597463007 - (0 >> 1);
                        _loc_3 = 0;
                        _loc_2.stat_fric = 0 / (_loc_3 * (1.5 - 0.5 * _loc_1 * _loc_3 * _loc_3));
                    }
                }
                if (!userdef_rfric)
                {
                    _loc_1 = s1.material.rollingFriction * s2.material.rollingFriction;
                    if (_loc_1 == 0)
                    {
                        rfric = 0;
                    }
                    else
                    {
                        _loc_2 = 1597463007 - (0 >> 1);
                        _loc_3 = 0;
                        _loc_2.rfric = 0 / (_loc_3 * (1.5 - 0.5 * _loc_1 * _loc_3 * _loc_3));
                    }
                }
            }
            return;
        }// end function

        public function setupcontacts() : void
        {
            wrap_contacts = ZPP_ContactList.get(contacts, true);
            wrap_contacts.zpp_inner.immutable = !mutable;
            wrap_contacts.zpp_inner.adder = contacts_adder;
            wrap_contacts.zpp_inner.dontremove = true;
            wrap_contacts.zpp_inner.subber = contacts_subber;
            return;
        }// end function

        public function retire() : void
        {
            var _loc_1:* = null as ZNPList_ZPP_Arbiter;
            var _loc_2:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_3:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_4:* = false;
            var _loc_5:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_6:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_7:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_9:* = null as ZPP_Contact;
            var _loc_10:* = null as ZPP_Contact;
            var _loc_11:* = null as ZPP_Contact;
            var _loc_12:* = null as ZPP_IContact;
            var _loc_13:* = null as ZPP_IContact;
            if (!cleared)
            {
                _loc_1 = b1.arbiters;
                _loc_2 = null;
                _loc_3 = _loc_1.head;
                _loc_4 = false;
                while (_loc_3 != null)
                {
                    
                    if (_loc_3.elt == this)
                    {
                        if (_loc_2 == null)
                        {
                            _loc_5 = _loc_1.head;
                            _loc_6 = _loc_5.next;
                            _loc_1.head = _loc_6;
                            if (_loc_1.head == null)
                            {
                                _loc_1.pushmod = true;
                            }
                        }
                        else
                        {
                            _loc_5 = _loc_2.next;
                            _loc_6 = _loc_5.next;
                            _loc_2.next = _loc_6;
                            if (_loc_6 == null)
                            {
                                _loc_1.pushmod = true;
                            }
                        }
                        _loc_7 = _loc_5;
                        _loc_7.elt = null;
                        _loc_7.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc_7;
                        _loc_1.modified = true;
                        (_loc_1.length - 1);
                        _loc_1.pushmod = true;
                        _loc_4 = true;
                        break;
                    }
                    _loc_2 = _loc_3;
                    _loc_3 = _loc_3.next;
                }
                _loc_1 = b2.arbiters;
                _loc_2 = null;
                _loc_3 = _loc_1.head;
                _loc_4 = false;
                while (_loc_3 != null)
                {
                    
                    if (_loc_3.elt == this)
                    {
                        if (_loc_2 == null)
                        {
                            _loc_5 = _loc_1.head;
                            _loc_6 = _loc_5.next;
                            _loc_1.head = _loc_6;
                            if (_loc_1.head == null)
                            {
                                _loc_1.pushmod = true;
                            }
                        }
                        else
                        {
                            _loc_5 = _loc_2.next;
                            _loc_6 = _loc_5.next;
                            _loc_2.next = _loc_6;
                            if (_loc_6 == null)
                            {
                                _loc_1.pushmod = true;
                            }
                        }
                        _loc_7 = _loc_5;
                        _loc_7.elt = null;
                        _loc_7.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc_7;
                        _loc_1.modified = true;
                        (_loc_1.length - 1);
                        _loc_1.pushmod = true;
                        _loc_4 = true;
                        break;
                    }
                    _loc_2 = _loc_3;
                    _loc_3 = _loc_3.next;
                }
                if (pair != null)
                {
                    pair.arb = null;
                    pair = null;
                }
            }
            var _loc_8:* = null;
            b2 = null;
            b1 = _loc_8;
            active = false;
            intchange = false;
            while (contacts.next != null)
            {
                
                _loc_10 = contacts;
                _loc_11 = _loc_10.next;
                _loc_10.pop();
                _loc_9 = _loc_11;
                _loc_9.arbiter = null;
                _loc_9.next = ZPP_Contact.zpp_pool;
                ZPP_Contact.zpp_pool = _loc_9;
                _loc_12 = innards;
                _loc_13 = _loc_12.next;
                _loc_12.next = _loc_13.next;
                _loc_13._inuse = false;
                if (_loc_12.next == null)
                {
                    _loc_12.pushmod = true;
                }
                _loc_12.modified = true;
                (_loc_12.length - 1);
            }
            var _loc_14:* = this;
            _loc_14.userdef_dyn_fric = false;
            _loc_14.userdef_stat_fric = false;
            _loc_14.userdef_restitution = false;
            _loc_14.userdef_rfric = false;
            var _loc_15:* = null;
            _loc_14.__ref_edge2 = null;
            _loc_14.__ref_edge1 = _loc_15;
            _loc_14.next = ZPP_ColArbiter.zpp_pool;
            ZPP_ColArbiter.zpp_pool = _loc_14;
            pre_dt = -1;
            return;
        }// end function

        public function preStep(param1:Number) : Boolean
        {
            var _loc_2:* = NaN;
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            var _loc_7:* = NaN;
            var _loc_11:* = null as ZPP_Contact;
            var _loc_12:* = null as ZPP_Contact;
            var _loc_13:* = null as ZPP_Contact;
            var _loc_14:* = null as ZPP_Contact;
            var _loc_15:* = null as ZPP_Contact;
            var _loc_16:* = null as ZPP_IContact;
            var _loc_17:* = null as ZPP_IContact;
            var _loc_18:* = null as ZPP_IContact;
            var _loc_19:* = false;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            if (invalidated)
            {
                invalidated = false;
                if (!userdef_restitution)
                {
                    if (s1.material.elasticity > -17899999999999994000000000000)
                    {
                    }
                    if (s2.material.elasticity <= -17899999999999994000000000000)
                    {
                        restitution = 0;
                    }
                    else
                    {
                        if (s1.material.elasticity < 17899999999999994000000000000)
                        {
                        }
                        if (s2.material.elasticity >= 17899999999999994000000000000)
                        {
                            restitution = 1;
                        }
                        else
                        {
                            restitution = (s1.material.elasticity + s2.material.elasticity) / 2;
                        }
                    }
                    if (restitution < 0)
                    {
                        restitution = 0;
                    }
                    if (restitution > 1)
                    {
                        restitution = 1;
                    }
                }
                if (!userdef_dyn_fric)
                {
                    _loc_2 = s1.material.dynamicFriction * s2.material.dynamicFriction;
                    if (_loc_2 == 0)
                    {
                        dyn_fric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.dyn_fric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
                if (!userdef_stat_fric)
                {
                    _loc_2 = s1.material.staticFriction * s2.material.staticFriction;
                    if (_loc_2 == 0)
                    {
                        stat_fric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.stat_fric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
                if (!userdef_rfric)
                {
                    _loc_2 = s1.material.rollingFriction * s2.material.rollingFriction;
                    if (_loc_2 == 0)
                    {
                        rfric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.rfric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
            }
            if (pre_dt == -1)
            {
                pre_dt = param1;
            }
            _loc_2 = param1 / pre_dt;
            pre_dt = param1;
            _loc_4 = b1.smass + b2.smass;
            hc2 = false;
            var _loc_5:* = true;
            if (b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
            }
            var _loc_6:* = b2.type != ZPP_Flags.id_BodyType_DYNAMIC;
            if (_loc_6)
            {
                if (continuous)
                {
                    _loc_7 = Config.contactContinuousStaticBiasCoef;
                }
                else
                {
                    _loc_7 = Config.contactStaticBiasCoef;
                }
            }
            else if (continuous)
            {
                _loc_7 = Config.contactContinuousBiasCoef;
            }
            else
            {
                _loc_7 = Config.contactBiasCoef;
            }
            biasCoef = _loc_7;
            continuous = false;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = innards.next;
            _loc_11 = contacts.next;
            while (_loc_11 != null)
            {
                
                _loc_12 = _loc_11;
                if (_loc_12.stamp + Config.arbiterExpirationDelay < stamp)
                {
                    _loc_13 = contacts;
                    if (_loc_8 == null)
                    {
                        _loc_14 = _loc_13.next;
                        _loc_15 = _loc_14.next;
                        _loc_13.next = _loc_15;
                        if (_loc_13.next == null)
                        {
                            _loc_13.pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_14 = _loc_8.next;
                        _loc_15 = _loc_14.next;
                        _loc_8.next = _loc_15;
                        if (_loc_15 == null)
                        {
                            _loc_13.pushmod = true;
                        }
                    }
                    _loc_14._inuse = false;
                    _loc_13.modified = true;
                    (_loc_13.length - 1);
                    _loc_13.pushmod = true;
                    _loc_11 = _loc_15;
                    _loc_16 = innards;
                    if (_loc_9 == null)
                    {
                        _loc_17 = _loc_16.next;
                        _loc_18 = _loc_17.next;
                        _loc_16.next = _loc_18;
                        if (_loc_16.next == null)
                        {
                            _loc_16.pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_17 = _loc_9.next;
                        _loc_18 = _loc_17.next;
                        _loc_9.next = _loc_18;
                        if (_loc_18 == null)
                        {
                            _loc_16.pushmod = true;
                        }
                    }
                    _loc_17._inuse = false;
                    _loc_16.modified = true;
                    (_loc_16.length - 1);
                    _loc_16.pushmod = true;
                    _loc_10 = _loc_18;
                    _loc_13 = _loc_12;
                    _loc_13.arbiter = null;
                    _loc_13.next = ZPP_Contact.zpp_pool;
                    ZPP_Contact.zpp_pool = _loc_13;
                    continue;
                }
                _loc_16 = _loc_12.inner;
                _loc_19 = _loc_12.active;
                _loc_12.active = _loc_12.stamp == stamp;
                if (_loc_12.active)
                {
                    if (_loc_5)
                    {
                        _loc_5 = false;
                        c1 = _loc_16;
                        oc1 = _loc_12;
                    }
                    else
                    {
                        hc2 = true;
                        c2 = _loc_16;
                        oc2 = _loc_12;
                    }
                    _loc_16.r2x = _loc_12.px - b2.posx;
                    _loc_16.r2y = _loc_12.py - b2.posy;
                    _loc_16.r1x = _loc_12.px - b1.posx;
                    _loc_16.r1y = _loc_12.py - b1.posy;
                    _loc_21 = _loc_16.r2x * nx + _loc_16.r2y * ny;
                    _loc_20 = _loc_4 + b2.sinertia * (_loc_21 * _loc_21);
                    _loc_21 = _loc_16.r1x * nx + _loc_16.r1y * ny;
                    _loc_20 = _loc_20 + b1.sinertia * (_loc_21 * _loc_21);
                    if (_loc_20 < Config.epsilon * Config.epsilon)
                    {
                        _loc_16.tMass = 0;
                    }
                    else
                    {
                        _loc_16.tMass = 1 / _loc_20;
                    }
                    _loc_22 = ny * _loc_16.r2x - nx * _loc_16.r2y;
                    _loc_21 = _loc_4 + b2.sinertia * (_loc_22 * _loc_22);
                    _loc_22 = ny * _loc_16.r1x - nx * _loc_16.r1y;
                    _loc_21 = _loc_21 + b1.sinertia * (_loc_22 * _loc_22);
                    if (_loc_21 < Config.epsilon * Config.epsilon)
                    {
                        _loc_16.nMass = 0;
                    }
                    else
                    {
                        _loc_16.nMass = 1 / _loc_21;
                    }
                    _loc_22 = 0;
                    _loc_23 = 0;
                    _loc_24 = b2.angvel + b2.kinangvel;
                    _loc_22 = b2.velx + b2.kinvelx - _loc_16.r2y * _loc_24;
                    _loc_23 = b2.vely + b2.kinvely + _loc_16.r2x * _loc_24;
                    _loc_24 = b1.angvel + b1.kinangvel;
                    _loc_22 = _loc_22 - (b1.velx + b1.kinvelx - _loc_16.r1y * _loc_24);
                    _loc_23 = _loc_23 - (b1.vely + b1.kinvely + _loc_16.r1x * _loc_24);
                    _loc_24 = nx * _loc_22 + ny * _loc_23;
                    _loc_12.elasticity = restitution;
                    _loc_16.bounce = _loc_24 * _loc_12.elasticity;
                    if (_loc_16.bounce > -Config.elasticThreshold)
                    {
                        _loc_16.bounce = 0;
                    }
                    _loc_24 = _loc_23 * nx - _loc_22 * ny;
                    _loc_25 = Config.staticFrictionThreshold;
                    if (_loc_24 * _loc_24 > _loc_25 * _loc_25)
                    {
                        _loc_16.friction = dyn_fric;
                    }
                    else
                    {
                        _loc_16.friction = stat_fric;
                    }
                    _loc_16.jnAcc = _loc_16.jnAcc * _loc_2;
                    _loc_16.jtAcc = _loc_16.jtAcc * _loc_2;
                }
                if (_loc_19 != _loc_12.active)
                {
                    contacts.modified = true;
                }
                _loc_8 = _loc_11;
                _loc_9 = _loc_10;
                _loc_10 = _loc_10.next;
                _loc_11 = _loc_11.next;
            }
            if (hc2)
            {
                hpc2 = true;
                if (oc1.posOnly)
                {
                    _loc_16 = c1;
                    c1 = c2;
                    c2 = _loc_16;
                    _loc_11 = oc1;
                    oc1 = oc2;
                    oc2 = _loc_11;
                    hc2 = false;
                }
                else if (oc2.posOnly)
                {
                    hc2 = false;
                }
                if (oc1.posOnly)
                {
                    _loc_5 = true;
                }
            }
            else
            {
                hpc2 = false;
            }
            jrAcc = jrAcc * _loc_2;
            if (!_loc_5)
            {
                rn1a = ny * c1.r1x - nx * c1.r1y;
                rt1a = c1.r1x * nx + c1.r1y * ny;
                rn1b = ny * c1.r2x - nx * c1.r2y;
                rt1b = c1.r2x * nx + c1.r2y * ny;
                k1x = b2.kinvelx - c1.r2y * b2.kinangvel - (b1.kinvelx - c1.r1y * b1.kinangvel);
                k1y = b2.kinvely + c1.r2x * b2.kinangvel - (b1.kinvely + c1.r1x * b1.kinangvel);
            }
            if (hc2)
            {
                rn2a = ny * c2.r1x - nx * c2.r1y;
                rt2a = c2.r1x * nx + c2.r1y * ny;
                rn2b = ny * c2.r2x - nx * c2.r2y;
                rt2b = c2.r2x * nx + c2.r2y * ny;
                k2x = b2.kinvelx - c2.r2y * b2.kinangvel - (b1.kinvelx - c2.r1y * b1.kinangvel);
                k2y = b2.kinvely + c2.r2x * b2.kinangvel - (b1.kinvely + c2.r1x * b1.kinangvel);
                kMassa = _loc_4 + b1.sinertia * rn1a * rn1a + b2.sinertia * rn1b * rn1b;
                kMassb = _loc_4 + b1.sinertia * rn1a * rn2a + b2.sinertia * rn1b * rn2b;
                kMassc = _loc_4 + b1.sinertia * rn2a * rn2a + b2.sinertia * rn2b * rn2b;
                _loc_20 = kMassa * kMassa + 2 * kMassb * kMassb + kMassc * kMassc;
                if (_loc_20 < Config.illConditionedThreshold * (kMassa * kMassc - kMassb * kMassb))
                {
                    Ka = kMassa;
                    Kb = kMassb;
                    Kc = kMassc;
                    _loc_21 = kMassa * kMassc - kMassb * kMassb;
                    if (_loc_21 != _loc_21)
                    {
                        _loc_22 = 0;
                        kMassc = _loc_22;
                        _loc_22 = _loc_22;
                        kMassb = _loc_22;
                        kMassa = _loc_22;
                    }
                    else if (_loc_21 == 0)
                    {
                        _loc_3 = 0;
                        if (kMassa != 0)
                        {
                            kMassa = 1 / kMassa;
                        }
                        else
                        {
                            kMassa = 0;
                            _loc_3 = _loc_3 | 1;
                        }
                        if (kMassc != 0)
                        {
                            kMassc = 1 / kMassc;
                        }
                        else
                        {
                            kMassc = 0;
                            _loc_3 = _loc_3 | 2;
                        }
                        kMassb = 0;
                    }
                    else
                    {
                        _loc_21 = 1 / _loc_21;
                        _loc_22 = kMassc * _loc_21;
                        kMassc = kMassa * _loc_21;
                        kMassa = _loc_22;
                        kMassb = kMassb * (-_loc_21);
                    }
                }
                else
                {
                    hc2 = false;
                    if (oc2.dist < oc1.dist)
                    {
                        _loc_16 = c1;
                        c1 = c2;
                        c2 = _loc_16;
                    }
                    oc2.active = false;
                    contacts.modified = true;
                }
            }
            surfacex = b2.svelx;
            surfacey = b2.svely;
            _loc_20 = 1;
            surfacex = surfacex + b1.svelx * _loc_20;
            surfacey = surfacey + b1.svely * _loc_20;
            surfacex = -surfacex;
            surfacey = -surfacey;
            rMass = b1.sinertia + b2.sinertia;
            if (rMass != 0)
            {
                rMass = 1 / rMass;
            }
            return _loc_5;
        }// end function

        public function normal_validate() : void
        {
            if (cleared)
            {
                throw "Error: Arbiter not currently in use";
            }
            wrap_normal.zpp_inner.x = nx;
            wrap_normal.zpp_inner.y = ny;
            if (ws1.id > ws2.id)
            {
                wrap_normal.zpp_inner.x = -wrap_normal.zpp_inner.x;
                wrap_normal.zpp_inner.y = -wrap_normal.zpp_inner.y;
            }
            return;
        }// end function

        public function makemutable() : void
        {
            mutable = true;
            if (wrap_normal != null)
            {
                wrap_normal.zpp_inner._immutable = false;
            }
            if (wrap_contacts != null)
            {
                wrap_contacts.zpp_inner.immutable = false;
            }
            return;
        }// end function

        public function makeimmutable() : void
        {
            mutable = false;
            if (wrap_normal != null)
            {
                wrap_normal.zpp_inner._immutable = true;
            }
            if (wrap_contacts != null)
            {
                wrap_contacts.zpp_inner.immutable = true;
            }
            return;
        }// end function

        public function injectContact(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:int, param7:Boolean = false) : ZPP_Contact
        {
            var _loc_9:* = null as ZPP_Contact;
            var _loc_10:* = null as ZPP_Contact;
            var _loc_11:* = null as ZPP_IContact;
            var _loc_12:* = NaN;
            var _loc_8:* = null;
            _loc_9 = contacts.next;
            while (_loc_9 != null)
            {
                
                _loc_10 = _loc_9;
                if (param6 == _loc_10.hash)
                {
                    _loc_8 = _loc_10;
                    break;
                }
                _loc_9 = _loc_9.next;
            }
            if (_loc_8 == null)
            {
                if (ZPP_Contact.zpp_pool == null)
                {
                    _loc_8 = new ZPP_Contact();
                }
                else
                {
                    _loc_8 = ZPP_Contact.zpp_pool;
                    ZPP_Contact.zpp_pool = _loc_8.next;
                    _loc_8.next = null;
                }
                _loc_11 = _loc_8.inner;
                _loc_12 = 0;
                _loc_11.jtAcc = _loc_12;
                _loc_11.jnAcc = _loc_12;
                _loc_8.hash = param6;
                _loc_8.fresh = true;
                _loc_8.arbiter = this;
                jrAcc = 0;
                _loc_9 = contacts;
                _loc_8._inuse = true;
                _loc_10 = _loc_8;
                _loc_10.next = _loc_9.next;
                _loc_9.next = _loc_10;
                _loc_9.modified = true;
                (_loc_9.length + 1);
                innards.add(_loc_11);
            }
            else
            {
                _loc_8.fresh = false;
            }
            _loc_8.px = param1;
            _loc_8.py = param2;
            nx = param3;
            ny = param4;
            _loc_8.dist = param5;
            _loc_8.stamp = stamp;
            _loc_8.posOnly = param7;
            return _loc_8;
        }// end function

        public function getnormal() : void
        {
            var _loc_2:* = null as Vec2;
            var _loc_3:* = false;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_1:* = false;
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_2 = new Vec2();
            }
            else
            {
                _loc_2 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_2.zpp_pool;
                _loc_2.zpp_pool = null;
                _loc_2.zpp_disp = false;
                if (_loc_2 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_2.zpp_inner == null)
            {
                _loc_3 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_4 = new ZPP_Vec2();
                }
                else
                {
                    _loc_4 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_4.next;
                    _loc_4.next = null;
                }
                _loc_4.weak = false;
                _loc_4._immutable = _loc_3;
                _loc_4.x = 0;
                _loc_4.y = 0;
                _loc_2.zpp_inner = _loc_4;
                _loc_2.zpp_inner.outer = _loc_2;
            }
            else
            {
                if (_loc_2 != null)
                {
                }
                if (_loc_2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = _loc_2.zpp_inner;
                if (_loc_4._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_4._isimmutable != null)
                {
                    _loc_4._isimmutable();
                }
                if (_loc_2 != null)
                {
                }
                if (_loc_2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = _loc_2.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                if (_loc_2.zpp_inner.x == 0)
                {
                    if (_loc_2 != null)
                    {
                    }
                    if (_loc_2.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_4 = _loc_2.zpp_inner;
                    if (_loc_4._validate != null)
                    {
                        _loc_4._validate();
                    }
                }
                if (_loc_2.zpp_inner.y != 0)
                {
                    _loc_2.zpp_inner.x = 0;
                    _loc_2.zpp_inner.y = 0;
                    _loc_4 = _loc_2.zpp_inner;
                    if (_loc_4._invalidate != null)
                    {
                        _loc_4._invalidate(_loc_4);
                    }
                }
            }
            _loc_2.zpp_inner.weak = _loc_1;
            wrap_normal = _loc_2;
            wrap_normal.zpp_inner._immutable = true;
            wrap_normal.zpp_inner._inuse = true;
            wrap_normal.zpp_inner._validate = normal_validate;
            return;
        }// end function

        public function free() : void
        {
            userdef_dyn_fric = false;
            userdef_stat_fric = false;
            userdef_restitution = false;
            userdef_rfric = false;
            var _loc_1:* = null;
            __ref_edge2 = null;
            __ref_edge1 = _loc_1;
            return;
        }// end function

        public function contacts_subber(param1:Contact) : void
        {
            var _loc_6:* = null as ZPP_Contact;
            var _loc_7:* = null as ZPP_Contact;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = innards.next;
            var _loc_5:* = contacts.next;
            while (_loc_5 != null)
            {
                
                _loc_6 = _loc_5;
                if (_loc_6 == param1.zpp_inner)
                {
                    contacts.erase(_loc_2);
                    innards.erase(_loc_3);
                    _loc_7 = _loc_6;
                    _loc_7.arbiter = null;
                    _loc_7.next = ZPP_Contact.zpp_pool;
                    ZPP_Contact.zpp_pool = _loc_7;
                    break;
                }
                _loc_2 = _loc_5;
                _loc_3 = _loc_4;
                _loc_4 = _loc_4.next;
                _loc_5 = _loc_5.next;
            }
            return;
        }// end function

        public function contacts_adder(param1:Contact) : Boolean
        {
            throw "Error: Cannot add new contacts, information required is far too specific and detailed :)";
            return false;
        }// end function

        public function cleanupContacts() : Boolean
        {
            var _loc_5:* = null as ZPP_Contact;
            var _loc_6:* = null as ZPP_Contact;
            var _loc_7:* = null as ZPP_Contact;
            var _loc_8:* = null as ZPP_Contact;
            var _loc_9:* = null as ZPP_Contact;
            var _loc_10:* = null as ZPP_IContact;
            var _loc_11:* = null as ZPP_IContact;
            var _loc_12:* = null as ZPP_IContact;
            var _loc_13:* = false;
            var _loc_1:* = true;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = innards.next;
            hc2 = false;
            _loc_5 = contacts.next;
            while (_loc_5 != null)
            {
                
                _loc_6 = _loc_5;
                if (_loc_6.stamp + Config.arbiterExpirationDelay < stamp)
                {
                    _loc_7 = contacts;
                    if (_loc_2 == null)
                    {
                        _loc_8 = _loc_7.next;
                        _loc_9 = _loc_8.next;
                        _loc_7.next = _loc_9;
                        if (_loc_7.next == null)
                        {
                            _loc_7.pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_8 = _loc_2.next;
                        _loc_9 = _loc_8.next;
                        _loc_2.next = _loc_9;
                        if (_loc_9 == null)
                        {
                            _loc_7.pushmod = true;
                        }
                    }
                    _loc_8._inuse = false;
                    _loc_7.modified = true;
                    (_loc_7.length - 1);
                    _loc_7.pushmod = true;
                    _loc_5 = _loc_9;
                    _loc_10 = innards;
                    if (_loc_3 == null)
                    {
                        _loc_11 = _loc_10.next;
                        _loc_12 = _loc_11.next;
                        _loc_10.next = _loc_12;
                        if (_loc_10.next == null)
                        {
                            _loc_10.pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_11 = _loc_3.next;
                        _loc_12 = _loc_11.next;
                        _loc_3.next = _loc_12;
                        if (_loc_12 == null)
                        {
                            _loc_10.pushmod = true;
                        }
                    }
                    _loc_11._inuse = false;
                    _loc_10.modified = true;
                    (_loc_10.length - 1);
                    _loc_10.pushmod = true;
                    _loc_4 = _loc_12;
                    _loc_7 = _loc_6;
                    _loc_7.arbiter = null;
                    _loc_7.next = ZPP_Contact.zpp_pool;
                    ZPP_Contact.zpp_pool = _loc_7;
                    continue;
                }
                _loc_10 = _loc_6.inner;
                _loc_13 = _loc_6.active;
                _loc_6.active = _loc_6.stamp == stamp;
                if (_loc_6.active)
                {
                    if (_loc_1)
                    {
                        _loc_1 = false;
                        c1 = _loc_10;
                        oc1 = _loc_6;
                    }
                    else
                    {
                        hc2 = true;
                        c2 = _loc_10;
                        oc2 = _loc_6;
                    }
                }
                if (_loc_13 != _loc_6.active)
                {
                    contacts.modified = true;
                }
                _loc_2 = _loc_5;
                _loc_3 = _loc_4;
                _loc_4 = _loc_4.next;
                _loc_5 = _loc_5.next;
            }
            if (hc2)
            {
                hpc2 = true;
                if (oc1.posOnly)
                {
                    _loc_10 = c1;
                    c1 = c2;
                    c2 = _loc_10;
                    _loc_5 = oc1;
                    oc1 = oc2;
                    oc2 = _loc_5;
                    hc2 = false;
                }
                else if (oc2.posOnly)
                {
                    hc2 = false;
                }
                if (oc1.posOnly)
                {
                    _loc_1 = true;
                }
            }
            else
            {
                hpc2 = false;
            }
            return _loc_1;
        }// end function

        public function calcProperties() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = 0;
            var _loc_3:* = NaN;
            if (!userdef_restitution)
            {
                if (s1.material.elasticity > -17899999999999994000000000000)
                {
                }
                if (s2.material.elasticity <= -17899999999999994000000000000)
                {
                    restitution = 0;
                }
                else
                {
                    if (s1.material.elasticity < 17899999999999994000000000000)
                    {
                    }
                    if (s2.material.elasticity >= 17899999999999994000000000000)
                    {
                        restitution = 1;
                    }
                    else
                    {
                        restitution = (s1.material.elasticity + s2.material.elasticity) / 2;
                    }
                }
                if (restitution < 0)
                {
                    restitution = 0;
                }
                if (restitution > 1)
                {
                    restitution = 1;
                }
            }
            if (!userdef_dyn_fric)
            {
                _loc_1 = s1.material.dynamicFriction * s2.material.dynamicFriction;
                if (_loc_1 == 0)
                {
                    dyn_fric = 0;
                }
                else
                {
                    _loc_2 = 1597463007 - (0 >> 1);
                    _loc_3 = 0;
                    _loc_2.dyn_fric = 0 / (_loc_3 * (1.5 - 0.5 * _loc_1 * _loc_3 * _loc_3));
                }
            }
            if (!userdef_stat_fric)
            {
                _loc_1 = s1.material.staticFriction * s2.material.staticFriction;
                if (_loc_1 == 0)
                {
                    stat_fric = 0;
                }
                else
                {
                    _loc_2 = 1597463007 - (0 >> 1);
                    _loc_3 = 0;
                    _loc_2.stat_fric = 0 / (_loc_3 * (1.5 - 0.5 * _loc_1 * _loc_3 * _loc_3));
                }
            }
            if (!userdef_rfric)
            {
                _loc_1 = s1.material.rollingFriction * s2.material.rollingFriction;
                if (_loc_1 == 0)
                {
                    rfric = 0;
                }
                else
                {
                    _loc_2 = 1597463007 - (0 >> 1);
                    _loc_3 = 0;
                    _loc_2.rfric = 0 / (_loc_3 * (1.5 - 0.5 * _loc_1 * _loc_3 * _loc_3));
                }
            }
            return;
        }// end function

        public function assign(param1:ZPP_Shape, param2:ZPP_Shape, param3:int, param4:int) : void
        {
            var _loc_7:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_8:* = NaN;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            b1 = param1.body;
            ws1 = param1;
            b2 = param2.body;
            ws2 = param2;
            id = param3;
            di = param4;
            var _loc_5:* = b1.arbiters;
            if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
            {
                _loc_7 = new ZNPNode_ZPP_Arbiter();
            }
            else
            {
                _loc_7 = ZNPNode_ZPP_Arbiter.zpp_pool;
                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_7.next;
                _loc_7.next = null;
            }
            _loc_7.elt = this;
            var _loc_6:* = _loc_7;
            _loc_6.next = _loc_5.head;
            _loc_5.head = _loc_6;
            _loc_5.modified = true;
            (_loc_5.length + 1);
            _loc_5 = b2.arbiters;
            if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
            {
                _loc_7 = new ZNPNode_ZPP_Arbiter();
            }
            else
            {
                _loc_7 = ZNPNode_ZPP_Arbiter.zpp_pool;
                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_7.next;
                _loc_7.next = null;
            }
            _loc_7.elt = this;
            _loc_6 = _loc_7;
            _loc_6.next = _loc_5.head;
            _loc_5.head = _loc_6;
            _loc_5.modified = true;
            (_loc_5.length + 1);
            active = true;
            present = 0;
            cleared = false;
            sleeping = false;
            fresh = false;
            presentable = false;
            s1 = param1;
            s2 = param2;
            if (!userdef_restitution)
            {
                if (s1.material.elasticity > -17899999999999994000000000000)
                {
                }
                if (s2.material.elasticity <= -17899999999999994000000000000)
                {
                    restitution = 0;
                }
                else
                {
                    if (s1.material.elasticity < 17899999999999994000000000000)
                    {
                    }
                    if (s2.material.elasticity >= 17899999999999994000000000000)
                    {
                        restitution = 1;
                    }
                    else
                    {
                        restitution = (s1.material.elasticity + s2.material.elasticity) / 2;
                    }
                }
                if (restitution < 0)
                {
                    restitution = 0;
                }
                if (restitution > 1)
                {
                    restitution = 1;
                }
            }
            if (!userdef_dyn_fric)
            {
                _loc_8 = s1.material.dynamicFriction * s2.material.dynamicFriction;
                if (_loc_8 == 0)
                {
                    dyn_fric = 0;
                }
                else
                {
                    _loc_9 = 1597463007 - (0 >> 1);
                    _loc_10 = 0;
                    _loc_9.dyn_fric = 0 / (_loc_10 * (1.5 - 0.5 * _loc_8 * _loc_10 * _loc_10));
                }
            }
            if (!userdef_stat_fric)
            {
                _loc_8 = s1.material.staticFriction * s2.material.staticFriction;
                if (_loc_8 == 0)
                {
                    stat_fric = 0;
                }
                else
                {
                    _loc_9 = 1597463007 - (0 >> 1);
                    _loc_10 = 0;
                    _loc_9.stat_fric = 0 / (_loc_10 * (1.5 - 0.5 * _loc_8 * _loc_10 * _loc_10));
                }
            }
            if (!userdef_rfric)
            {
                _loc_8 = s1.material.rollingFriction * s2.material.rollingFriction;
                if (_loc_8 == 0)
                {
                    rfric = 0;
                }
                else
                {
                    _loc_9 = 1597463007 - (0 >> 1);
                    _loc_10 = 0;
                    _loc_9.rfric = 0 / (_loc_10 * (1.5 - 0.5 * _loc_8 * _loc_10 * _loc_10));
                }
            }
            return;
        }// end function

        public function applyImpulseVel() : void
        {
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_7:* = k1x + b2.velx - c1.r2y * b2.angvel - (b1.velx - c1.r1y * b1.angvel);
            var _loc_8:* = k1y + b2.vely + c1.r2x * b2.angvel - (b1.vely + c1.r1x * b1.angvel);
            var _loc_3:* = (_loc_8 * nx - _loc_7 * ny + surfacex) * c1.tMass;
            var _loc_4:* = c1.friction * c1.jnAcc;
            var _loc_5:* = c1.jtAcc;
            var _loc_6:* = _loc_5 - _loc_3;
            if (_loc_6 > _loc_4)
            {
                _loc_6 = _loc_4;
            }
            else if (_loc_6 < -_loc_4)
            {
                _loc_6 = -_loc_4;
            }
            _loc_3 = _loc_6 - _loc_5;
            c1.jtAcc = _loc_6;
            var _loc_1:* = (-ny) * _loc_3;
            var _loc_2:* = nx * _loc_3;
            b2.velx = b2.velx + _loc_1 * b2.imass;
            b2.vely = b2.vely + _loc_2 * b2.imass;
            b1.velx = b1.velx - _loc_1 * b1.imass;
            b1.vely = b1.vely - _loc_2 * b1.imass;
            b2.angvel = b2.angvel + rt1b * _loc_3 * b2.iinertia;
            b1.angvel = b1.angvel - rt1a * _loc_3 * b1.iinertia;
            if (hc2)
            {
                _loc_9 = k2x + b2.velx - c2.r2y * b2.angvel - (b1.velx - c2.r1y * b1.angvel);
                _loc_10 = k2y + b2.vely + c2.r2x * b2.angvel - (b1.vely + c2.r1x * b1.angvel);
                _loc_3 = (_loc_10 * nx - _loc_9 * ny + surfacex) * c2.tMass;
                _loc_4 = c2.friction * c2.jnAcc;
                _loc_5 = c2.jtAcc;
                _loc_6 = _loc_5 - _loc_3;
                if (_loc_6 > _loc_4)
                {
                    _loc_6 = _loc_4;
                }
                else if (_loc_6 < -_loc_4)
                {
                    _loc_6 = -_loc_4;
                }
                _loc_3 = _loc_6 - _loc_5;
                c2.jtAcc = _loc_6;
                _loc_1 = (-ny) * _loc_3;
                _loc_2 = nx * _loc_3;
                b2.velx = b2.velx + _loc_1 * b2.imass;
                b2.vely = b2.vely + _loc_2 * b2.imass;
                b1.velx = b1.velx - _loc_1 * b1.imass;
                b1.vely = b1.vely - _loc_2 * b1.imass;
                b2.angvel = b2.angvel + rt2b * _loc_3 * b2.iinertia;
                b1.angvel = b1.angvel - rt2a * _loc_3 * b1.iinertia;
                _loc_7 = k1x + b2.velx - c1.r2y * b2.angvel - (b1.velx - c1.r1y * b1.angvel);
                _loc_8 = k1y + b2.vely + c1.r2x * b2.angvel - (b1.vely + c1.r1x * b1.angvel);
                _loc_9 = k2x + b2.velx - c2.r2y * b2.angvel - (b1.velx - c2.r1y * b1.angvel);
                _loc_10 = k2y + b2.vely + c2.r2x * b2.angvel - (b1.vely + c2.r1x * b1.angvel);
                _loc_11 = c1.jnAcc;
                _loc_12 = c2.jnAcc;
                _loc_13 = _loc_7 * nx + _loc_8 * ny + surfacey + c1.bounce - (Ka * _loc_11 + Kb * _loc_12);
                _loc_14 = _loc_9 * nx + _loc_10 * ny + surfacey + c2.bounce - (Kb * _loc_11 + Kc * _loc_12);
                _loc_15 = -(kMassa * _loc_13 + kMassb * _loc_14);
                _loc_16 = -(kMassb * _loc_13 + kMassc * _loc_14);
                if (_loc_15 >= 0)
                {
                }
                if (_loc_16 >= 0)
                {
                    _loc_13 = _loc_15 - _loc_11;
                    _loc_14 = _loc_16 - _loc_12;
                    c1.jnAcc = _loc_15;
                    c2.jnAcc = _loc_16;
                }
                else
                {
                    _loc_15 = (-c1.nMass) * _loc_13;
                    if (_loc_15 >= 0)
                    {
                    }
                    if (Kb * _loc_15 + _loc_14 >= 0)
                    {
                        _loc_13 = _loc_15 - _loc_11;
                        _loc_14 = -_loc_12;
                        c1.jnAcc = _loc_15;
                        c2.jnAcc = 0;
                    }
                    else
                    {
                        _loc_16 = (-c2.nMass) * _loc_14;
                        if (_loc_16 >= 0)
                        {
                        }
                        if (Kb * _loc_16 + _loc_13 >= 0)
                        {
                            _loc_13 = -_loc_11;
                            _loc_14 = _loc_16 - _loc_12;
                            c1.jnAcc = 0;
                            c2.jnAcc = _loc_16;
                        }
                        else
                        {
                            if (_loc_13 >= 0)
                            {
                            }
                            if (_loc_14 >= 0)
                            {
                                _loc_13 = -_loc_11;
                                _loc_14 = -_loc_12;
                                _loc_17 = 0;
                                c2.jnAcc = _loc_17;
                                c1.jnAcc = _loc_17;
                            }
                            else
                            {
                                _loc_13 = 0;
                                _loc_14 = 0;
                            }
                        }
                    }
                }
                _loc_3 = _loc_13 + _loc_14;
                _loc_1 = nx * _loc_3;
                _loc_2 = ny * _loc_3;
                b2.velx = b2.velx + _loc_1 * b2.imass;
                b2.vely = b2.vely + _loc_2 * b2.imass;
                b1.velx = b1.velx - _loc_1 * b1.imass;
                b1.vely = b1.vely - _loc_2 * b1.imass;
                b2.angvel = b2.angvel + (rn1b * _loc_13 + rn2b * _loc_14) * b2.iinertia;
                b1.angvel = b1.angvel - (rn1a * _loc_13 + rn2a * _loc_14) * b1.iinertia;
            }
            else
            {
                if (radius != 0)
                {
                    _loc_9 = b2.angvel - b1.angvel;
                    _loc_3 = _loc_9 * rMass;
                    _loc_4 = rfric * c1.jnAcc;
                    _loc_5 = jrAcc;
                    jrAcc = jrAcc - _loc_3;
                    if (jrAcc > _loc_4)
                    {
                        jrAcc = _loc_4;
                    }
                    else if (jrAcc < -_loc_4)
                    {
                        jrAcc = -_loc_4;
                    }
                    _loc_3 = jrAcc - _loc_5;
                    b2.angvel = b2.angvel + _loc_3 * b2.iinertia;
                    b1.angvel = b1.angvel - _loc_3 * b1.iinertia;
                }
                _loc_7 = k1x + b2.velx - c1.r2y * b2.angvel - (b1.velx - c1.r1y * b1.angvel);
                _loc_8 = k1y + b2.vely + c1.r2x * b2.angvel - (b1.vely + c1.r1x * b1.angvel);
                _loc_3 = (c1.bounce + (nx * _loc_7 + ny * _loc_8) + surfacey) * c1.nMass;
                _loc_5 = c1.jnAcc;
                _loc_6 = _loc_5 - _loc_3;
                if (_loc_6 < 0)
                {
                    _loc_6 = 0;
                }
                _loc_3 = _loc_6 - _loc_5;
                c1.jnAcc = _loc_6;
                _loc_1 = nx * _loc_3;
                _loc_2 = ny * _loc_3;
                b2.velx = b2.velx + _loc_1 * b2.imass;
                b2.vely = b2.vely + _loc_2 * b2.imass;
                b1.velx = b1.velx - _loc_1 * b1.imass;
                b1.vely = b1.vely - _loc_2 * b1.imass;
                b2.angvel = b2.angvel + rn1b * _loc_3 * b2.iinertia;
                b1.angvel = b1.angvel - rn1a * _loc_3 * b1.iinertia;
            }
            return;
        }// end function

        public function applyImpulsePos() : void
        {
            var _loc_1:* = null as ZPP_IContact;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = 0;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = null as ZPP_Body;
            var _loc_25:* = NaN;
            var _loc_26:* = NaN;
            var _loc_27:* = NaN;
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_32:* = NaN;
            var _loc_33:* = NaN;
            var _loc_34:* = NaN;
            var _loc_35:* = NaN;
            var _loc_36:* = NaN;
            var _loc_37:* = NaN;
            var _loc_38:* = NaN;
            var _loc_39:* = NaN;
            if (ptype == 2)
            {
                _loc_1 = c1;
                _loc_2 = 0;
                _loc_3 = 0;
                _loc_4 = 0;
                _loc_5 = 0;
                _loc_4 = b2.axisy * _loc_1.lr2x - b2.axisx * _loc_1.lr2y;
                _loc_5 = _loc_1.lr2x * b2.axisx + _loc_1.lr2y * b2.axisy;
                _loc_6 = 1;
                _loc_4 = _loc_4 + b2.posx * _loc_6;
                _loc_5 = _loc_5 + b2.posy * _loc_6;
                _loc_6 = 0;
                _loc_7 = 0;
                _loc_6 = b1.axisy * _loc_1.lr1x - b1.axisx * _loc_1.lr1y;
                _loc_7 = _loc_1.lr1x * b1.axisx + _loc_1.lr1y * b1.axisy;
                _loc_8 = 1;
                _loc_6 = _loc_6 + b1.posx * _loc_8;
                _loc_7 = _loc_7 + b1.posy * _loc_8;
                _loc_8 = 0;
                _loc_9 = 0;
                _loc_8 = _loc_4 - _loc_6;
                _loc_9 = _loc_5 - _loc_7;
                _loc_11 = _loc_8 * _loc_8 + _loc_9 * _loc_9;
                if (_loc_11 == 0)
                {
                    _loc_10 = 0;
                }
                else
                {
                    _loc_12 = 1597463007 - (0 >> 1);
                    _loc_13 = 0;
                    _loc_10 = 0 / (_loc_13 * (1.5 - 0.5 * _loc_11 * _loc_13 * _loc_13));
                }
                _loc_11 = radius - Config.collisionSlop;
                _loc_13 = _loc_10 - _loc_11;
                if (_loc_8 * nx + _loc_9 * ny < 0)
                {
                    _loc_8 = -_loc_8;
                    _loc_9 = -_loc_9;
                    _loc_13 = _loc_13 - radius;
                }
                if (_loc_13 < 0)
                {
                    if (_loc_10 < Config.epsilon)
                    {
                        if (b1.smass != 0)
                        {
                            b1.posx = b1.posx + Config.epsilon * 10;
                        }
                        else
                        {
                            b2.posx = b2.posx + Config.epsilon * 10;
                        }
                    }
                    else
                    {
                        _loc_14 = 1 / _loc_10;
                        _loc_8 = _loc_8 * _loc_14;
                        _loc_9 = _loc_9 * _loc_14;
                        _loc_14 = 0.5 * (_loc_6 + _loc_4);
                        _loc_15 = 0.5 * (_loc_7 + _loc_5);
                        _loc_16 = _loc_10 - _loc_11;
                        _loc_6 = _loc_14 - b1.posx;
                        _loc_7 = _loc_15 - b1.posy;
                        _loc_4 = _loc_14 - b2.posx;
                        _loc_5 = _loc_15 - b2.posy;
                        _loc_17 = _loc_9 * _loc_6 - _loc_8 * _loc_7;
                        _loc_18 = _loc_9 * _loc_4 - _loc_8 * _loc_5;
                        _loc_19 = b2.smass + _loc_18 * _loc_18 * b2.sinertia + b1.smass + _loc_17 * _loc_17 * b1.sinertia;
                        if (_loc_19 != 0)
                        {
                            _loc_20 = (-biasCoef) * _loc_16 / _loc_19;
                            _loc_21 = 0;
                            _loc_22 = 0;
                            _loc_23 = _loc_20;
                            _loc_21 = _loc_8 * _loc_23;
                            _loc_22 = _loc_9 * _loc_23;
                            _loc_23 = b1.imass;
                            b1.posx = b1.posx - _loc_21 * _loc_23;
                            b1.posy = b1.posy - _loc_22 * _loc_23;
                            _loc_24 = b1;
                            _loc_23 = (-_loc_17) * b1.iinertia * _loc_20;
                            _loc_24.rot = _loc_24.rot + _loc_23;
                            if (_loc_23 * _loc_23 > 0.0001)
                            {
                                _loc_24.axisx = Math.sin(_loc_24.rot);
                                _loc_24.axisy = Math.cos(_loc_24.rot);
                            }
                            else
                            {
                                _loc_25 = _loc_23 * _loc_23;
                                _loc_26 = 1 - 0.5 * _loc_25;
                                _loc_27 = 1 - _loc_25 * _loc_25 / 8;
                                _loc_28 = (_loc_26 * _loc_24.axisx + _loc_23 * _loc_24.axisy) * _loc_27;
                                _loc_24.axisy = (_loc_26 * _loc_24.axisy - _loc_23 * _loc_24.axisx) * _loc_27;
                                _loc_24.axisx = _loc_28;
                            }
                            _loc_23 = b2.imass;
                            b2.posx = b2.posx + _loc_21 * _loc_23;
                            b2.posy = b2.posy + _loc_22 * _loc_23;
                            _loc_24 = b2;
                            _loc_23 = _loc_18 * b2.iinertia * _loc_20;
                            _loc_24.rot = _loc_24.rot + _loc_23;
                            if (_loc_23 * _loc_23 > 0.0001)
                            {
                                _loc_24.axisx = Math.sin(_loc_24.rot);
                                _loc_24.axisy = Math.cos(_loc_24.rot);
                            }
                            else
                            {
                                _loc_25 = _loc_23 * _loc_23;
                                _loc_26 = 1 - 0.5 * _loc_25;
                                _loc_27 = 1 - _loc_25 * _loc_25 / 8;
                                _loc_28 = (_loc_26 * _loc_24.axisx + _loc_23 * _loc_24.axisy) * _loc_27;
                                _loc_24.axisy = (_loc_26 * _loc_24.axisy - _loc_23 * _loc_24.axisx) * _loc_27;
                                _loc_24.axisx = _loc_28;
                            }
                        }
                    }
                }
            }
            else
            {
                _loc_2 = 0;
                _loc_3 = 0;
                _loc_5 = 0;
                _loc_6 = 0;
                _loc_7 = 0;
                _loc_8 = 0;
                if (ptype == 0)
                {
                    _loc_2 = b1.axisy * lnormx - b1.axisx * lnormy;
                    _loc_3 = lnormx * b1.axisx + lnormy * b1.axisy;
                    _loc_4 = lproj + (_loc_2 * b1.posx + _loc_3 * b1.posy);
                    _loc_5 = b2.axisy * c1.lr1x - b2.axisx * c1.lr1y;
                    _loc_6 = c1.lr1x * b2.axisx + c1.lr1y * b2.axisy;
                    _loc_9 = 1;
                    _loc_5 = _loc_5 + b2.posx * _loc_9;
                    _loc_6 = _loc_6 + b2.posy * _loc_9;
                    if (hpc2)
                    {
                        _loc_7 = b2.axisy * c2.lr1x - b2.axisx * c2.lr1y;
                        _loc_8 = c2.lr1x * b2.axisx + c2.lr1y * b2.axisy;
                        _loc_9 = 1;
                        _loc_7 = _loc_7 + b2.posx * _loc_9;
                        _loc_8 = _loc_8 + b2.posy * _loc_9;
                    }
                }
                else
                {
                    _loc_2 = b2.axisy * lnormx - b2.axisx * lnormy;
                    _loc_3 = lnormx * b2.axisx + lnormy * b2.axisy;
                    _loc_4 = lproj + (_loc_2 * b2.posx + _loc_3 * b2.posy);
                    _loc_5 = b1.axisy * c1.lr1x - b1.axisx * c1.lr1y;
                    _loc_6 = c1.lr1x * b1.axisx + c1.lr1y * b1.axisy;
                    _loc_9 = 1;
                    _loc_5 = _loc_5 + b1.posx * _loc_9;
                    _loc_6 = _loc_6 + b1.posy * _loc_9;
                    if (hpc2)
                    {
                        _loc_7 = b1.axisy * c2.lr1x - b1.axisx * c2.lr1y;
                        _loc_8 = c2.lr1x * b1.axisx + c2.lr1y * b1.axisy;
                        _loc_9 = 1;
                        _loc_7 = _loc_7 + b1.posx * _loc_9;
                        _loc_8 = _loc_8 + b1.posy * _loc_9;
                    }
                }
                _loc_9 = _loc_5 * _loc_2 + _loc_6 * _loc_3 - _loc_4 - radius;
                _loc_9 = _loc_9 + Config.collisionSlop;
                _loc_10 = 0;
                if (hpc2)
                {
                    _loc_10 = _loc_7 * _loc_2 + _loc_8 * _loc_3 - _loc_4 - radius;
                    _loc_10 = _loc_10 + Config.collisionSlop;
                }
                if (_loc_9 >= 0)
                {
                }
                if (_loc_10 < 0)
                {
                    if (rev)
                    {
                        _loc_2 = -_loc_2;
                        _loc_3 = -_loc_3;
                    }
                    _loc_11 = 0;
                    _loc_13 = 0;
                    _loc_11 = _loc_5 - b1.posx;
                    _loc_13 = _loc_6 - b1.posy;
                    _loc_14 = 0;
                    _loc_15 = 0;
                    _loc_14 = _loc_5 - b2.posx;
                    _loc_15 = _loc_6 - b2.posy;
                    _loc_16 = 0;
                    _loc_17 = 0;
                    _loc_18 = 0;
                    _loc_19 = 0;
                    if (hpc2)
                    {
                        _loc_16 = _loc_7 - b1.posx;
                        _loc_17 = _loc_8 - b1.posy;
                        _loc_18 = _loc_7 - b2.posx;
                        _loc_19 = _loc_8 - b2.posy;
                        _loc_20 = _loc_3 * _loc_11 - _loc_2 * _loc_13;
                        _loc_21 = _loc_3 * _loc_14 - _loc_2 * _loc_15;
                        _loc_22 = _loc_3 * _loc_16 - _loc_2 * _loc_17;
                        _loc_23 = _loc_3 * _loc_18 - _loc_2 * _loc_19;
                        _loc_25 = b1.smass + b2.smass;
                        kMassa = _loc_25 + b1.sinertia * _loc_20 * _loc_20 + b2.sinertia * _loc_21 * _loc_21;
                        kMassb = _loc_25 + b1.sinertia * _loc_20 * _loc_22 + b2.sinertia * _loc_21 * _loc_23;
                        kMassc = _loc_25 + b1.sinertia * _loc_22 * _loc_22 + b2.sinertia * _loc_23 * _loc_23;
                        _loc_26 = 0;
                        _loc_27 = 0;
                        _loc_28 = 0;
                        _loc_26 = kMassa;
                        _loc_27 = kMassb;
                        _loc_28 = kMassc;
                        _loc_29 = _loc_9 * biasCoef;
                        _loc_30 = _loc_10 * biasCoef;
                        do
                        {
                            
                            _loc_31 = 0;
                            _loc_32 = 0;
                            _loc_31 = _loc_29;
                            _loc_32 = _loc_30;
                            _loc_31 = -_loc_31;
                            _loc_32 = -_loc_32;
                            _loc_33 = kMassa * kMassc - kMassb * kMassb;
                            if (_loc_33 != _loc_33)
                            {
                                _loc_32 = 0;
                                _loc_31 = _loc_32;
                            }
                            else if (_loc_33 == 0)
                            {
                                if (kMassa != 0)
                                {
                                    _loc_31 = _loc_31 / kMassa;
                                }
                                else
                                {
                                    _loc_31 = 0;
                                }
                                if (kMassc != 0)
                                {
                                    _loc_32 = _loc_32 / kMassc;
                                }
                                else
                                {
                                    _loc_32 = 0;
                                }
                            }
                            else
                            {
                                _loc_33 = 1 / _loc_33;
                                _loc_34 = _loc_33 * (kMassc * _loc_31 - kMassb * _loc_32);
                                _loc_32 = _loc_33 * (kMassa * _loc_32 - kMassb * _loc_31);
                                _loc_31 = _loc_34;
                            }
                            if (_loc_31 >= 0)
                            {
                            }
                            if (_loc_32 >= 0)
                            {
                                _loc_33 = (_loc_31 + _loc_32) * b1.imass;
                                b1.posx = b1.posx - _loc_2 * _loc_33;
                                b1.posy = b1.posy - _loc_3 * _loc_33;
                                _loc_24 = b1;
                                _loc_33 = (-b1.iinertia) * (_loc_20 * _loc_31 + _loc_22 * _loc_32);
                                _loc_24.rot = _loc_24.rot + _loc_33;
                                if (_loc_33 * _loc_33 > 0.0001)
                                {
                                    _loc_24.axisx = Math.sin(_loc_24.rot);
                                    _loc_24.axisy = Math.cos(_loc_24.rot);
                                }
                                else
                                {
                                    _loc_34 = _loc_33 * _loc_33;
                                    _loc_35 = 1 - 0.5 * _loc_34;
                                    _loc_36 = 1 - _loc_34 * _loc_34 / 8;
                                    _loc_37 = (_loc_35 * _loc_24.axisx + _loc_33 * _loc_24.axisy) * _loc_36;
                                    _loc_24.axisy = (_loc_35 * _loc_24.axisy - _loc_33 * _loc_24.axisx) * _loc_36;
                                    _loc_24.axisx = _loc_37;
                                }
                                _loc_33 = (_loc_31 + _loc_32) * b2.imass;
                                b2.posx = b2.posx + _loc_2 * _loc_33;
                                b2.posy = b2.posy + _loc_3 * _loc_33;
                                _loc_24 = b2;
                                _loc_33 = b2.iinertia * (_loc_21 * _loc_31 + _loc_23 * _loc_32);
                                _loc_24.rot = _loc_24.rot + _loc_33;
                                if (_loc_33 * _loc_33 > 0.0001)
                                {
                                    _loc_24.axisx = Math.sin(_loc_24.rot);
                                    _loc_24.axisy = Math.cos(_loc_24.rot);
                                }
                                else
                                {
                                    _loc_34 = _loc_33 * _loc_33;
                                    _loc_35 = 1 - 0.5 * _loc_34;
                                    _loc_36 = 1 - _loc_34 * _loc_34 / 8;
                                    _loc_37 = (_loc_35 * _loc_24.axisx + _loc_33 * _loc_24.axisy) * _loc_36;
                                    _loc_24.axisy = (_loc_35 * _loc_24.axisy - _loc_33 * _loc_24.axisx) * _loc_36;
                                    _loc_24.axisx = _loc_37;
                                }
                                break;
                            }
                            _loc_31 = (-_loc_29) / _loc_26;
                            _loc_32 = 0;
                            _loc_33 = _loc_27 * _loc_31 + _loc_30;
                            if (_loc_31 >= 0)
                            {
                            }
                            if (_loc_33 >= 0)
                            {
                                _loc_34 = (_loc_31 + _loc_32) * b1.imass;
                                b1.posx = b1.posx - _loc_2 * _loc_34;
                                b1.posy = b1.posy - _loc_3 * _loc_34;
                                _loc_24 = b1;
                                _loc_34 = (-b1.iinertia) * (_loc_20 * _loc_31 + _loc_22 * _loc_32);
                                _loc_24.rot = _loc_24.rot + _loc_34;
                                if (_loc_34 * _loc_34 > 0.0001)
                                {
                                    _loc_24.axisx = Math.sin(_loc_24.rot);
                                    _loc_24.axisy = Math.cos(_loc_24.rot);
                                }
                                else
                                {
                                    _loc_35 = _loc_34 * _loc_34;
                                    _loc_36 = 1 - 0.5 * _loc_35;
                                    _loc_37 = 1 - _loc_35 * _loc_35 / 8;
                                    _loc_38 = (_loc_36 * _loc_24.axisx + _loc_34 * _loc_24.axisy) * _loc_37;
                                    _loc_24.axisy = (_loc_36 * _loc_24.axisy - _loc_34 * _loc_24.axisx) * _loc_37;
                                    _loc_24.axisx = _loc_38;
                                }
                                _loc_34 = (_loc_31 + _loc_32) * b2.imass;
                                b2.posx = b2.posx + _loc_2 * _loc_34;
                                b2.posy = b2.posy + _loc_3 * _loc_34;
                                _loc_24 = b2;
                                _loc_34 = b2.iinertia * (_loc_21 * _loc_31 + _loc_23 * _loc_32);
                                _loc_24.rot = _loc_24.rot + _loc_34;
                                if (_loc_34 * _loc_34 > 0.0001)
                                {
                                    _loc_24.axisx = Math.sin(_loc_24.rot);
                                    _loc_24.axisy = Math.cos(_loc_24.rot);
                                }
                                else
                                {
                                    _loc_35 = _loc_34 * _loc_34;
                                    _loc_36 = 1 - 0.5 * _loc_35;
                                    _loc_37 = 1 - _loc_35 * _loc_35 / 8;
                                    _loc_38 = (_loc_36 * _loc_24.axisx + _loc_34 * _loc_24.axisy) * _loc_37;
                                    _loc_24.axisy = (_loc_36 * _loc_24.axisy - _loc_34 * _loc_24.axisx) * _loc_37;
                                    _loc_24.axisx = _loc_38;
                                }
                                break;
                            }
                            _loc_31 = 0;
                            _loc_32 = (-_loc_30) / _loc_28;
                            _loc_34 = _loc_27 * _loc_32 + _loc_29;
                            if (_loc_32 >= 0)
                            {
                            }
                            if (_loc_34 >= 0)
                            {
                                _loc_35 = (_loc_31 + _loc_32) * b1.imass;
                                b1.posx = b1.posx - _loc_2 * _loc_35;
                                b1.posy = b1.posy - _loc_3 * _loc_35;
                                _loc_24 = b1;
                                _loc_35 = (-b1.iinertia) * (_loc_20 * _loc_31 + _loc_22 * _loc_32);
                                _loc_24.rot = _loc_24.rot + _loc_35;
                                if (_loc_35 * _loc_35 > 0.0001)
                                {
                                    _loc_24.axisx = Math.sin(_loc_24.rot);
                                    _loc_24.axisy = Math.cos(_loc_24.rot);
                                }
                                else
                                {
                                    _loc_36 = _loc_35 * _loc_35;
                                    _loc_37 = 1 - 0.5 * _loc_36;
                                    _loc_38 = 1 - _loc_36 * _loc_36 / 8;
                                    _loc_39 = (_loc_37 * _loc_24.axisx + _loc_35 * _loc_24.axisy) * _loc_38;
                                    _loc_24.axisy = (_loc_37 * _loc_24.axisy - _loc_35 * _loc_24.axisx) * _loc_38;
                                    _loc_24.axisx = _loc_39;
                                }
                                _loc_35 = (_loc_31 + _loc_32) * b2.imass;
                                b2.posx = b2.posx + _loc_2 * _loc_35;
                                b2.posy = b2.posy + _loc_3 * _loc_35;
                                _loc_24 = b2;
                                _loc_35 = b2.iinertia * (_loc_21 * _loc_31 + _loc_23 * _loc_32);
                                _loc_24.rot = _loc_24.rot + _loc_35;
                                if (_loc_35 * _loc_35 > 0.0001)
                                {
                                    _loc_24.axisx = Math.sin(_loc_24.rot);
                                    _loc_24.axisy = Math.cos(_loc_24.rot);
                                }
                                else
                                {
                                    _loc_36 = _loc_35 * _loc_35;
                                    _loc_37 = 1 - 0.5 * _loc_36;
                                    _loc_38 = 1 - _loc_36 * _loc_36 / 8;
                                    _loc_39 = (_loc_37 * _loc_24.axisx + _loc_35 * _loc_24.axisy) * _loc_38;
                                    _loc_24.axisy = (_loc_37 * _loc_24.axisy - _loc_35 * _loc_24.axisx) * _loc_38;
                                    _loc_24.axisx = _loc_39;
                                }
                                break;
                            }
                        }while (false)
                    }
                    else
                    {
                        _loc_20 = _loc_3 * _loc_11 - _loc_2 * _loc_13;
                        _loc_21 = _loc_3 * _loc_14 - _loc_2 * _loc_15;
                        _loc_22 = b2.smass + _loc_21 * _loc_21 * b2.sinertia + b1.smass + _loc_20 * _loc_20 * b1.sinertia;
                        if (_loc_22 != 0)
                        {
                            _loc_23 = (-biasCoef) * _loc_9 / _loc_22;
                            _loc_25 = 0;
                            _loc_26 = 0;
                            _loc_27 = _loc_23;
                            _loc_25 = _loc_2 * _loc_27;
                            _loc_26 = _loc_3 * _loc_27;
                            _loc_27 = b1.imass;
                            b1.posx = b1.posx - _loc_25 * _loc_27;
                            b1.posy = b1.posy - _loc_26 * _loc_27;
                            _loc_24 = b1;
                            _loc_27 = (-_loc_20) * b1.iinertia * _loc_23;
                            _loc_24.rot = _loc_24.rot + _loc_27;
                            if (_loc_27 * _loc_27 > 0.0001)
                            {
                                _loc_24.axisx = Math.sin(_loc_24.rot);
                                _loc_24.axisy = Math.cos(_loc_24.rot);
                            }
                            else
                            {
                                _loc_28 = _loc_27 * _loc_27;
                                _loc_29 = 1 - 0.5 * _loc_28;
                                _loc_30 = 1 - _loc_28 * _loc_28 / 8;
                                _loc_31 = (_loc_29 * _loc_24.axisx + _loc_27 * _loc_24.axisy) * _loc_30;
                                _loc_24.axisy = (_loc_29 * _loc_24.axisy - _loc_27 * _loc_24.axisx) * _loc_30;
                                _loc_24.axisx = _loc_31;
                            }
                            _loc_27 = b2.imass;
                            b2.posx = b2.posx + _loc_25 * _loc_27;
                            b2.posy = b2.posy + _loc_26 * _loc_27;
                            _loc_24 = b2;
                            _loc_27 = _loc_21 * b2.iinertia * _loc_23;
                            _loc_24.rot = _loc_24.rot + _loc_27;
                            if (_loc_27 * _loc_27 > 0.0001)
                            {
                                _loc_24.axisx = Math.sin(_loc_24.rot);
                                _loc_24.axisy = Math.cos(_loc_24.rot);
                            }
                            else
                            {
                                _loc_28 = _loc_27 * _loc_27;
                                _loc_29 = 1 - 0.5 * _loc_28;
                                _loc_30 = 1 - _loc_28 * _loc_28 / 8;
                                _loc_31 = (_loc_29 * _loc_24.axisx + _loc_27 * _loc_24.axisy) * _loc_30;
                                _loc_24.axisy = (_loc_29 * _loc_24.axisy - _loc_27 * _loc_24.axisx) * _loc_30;
                                _loc_24.axisx = _loc_31;
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
