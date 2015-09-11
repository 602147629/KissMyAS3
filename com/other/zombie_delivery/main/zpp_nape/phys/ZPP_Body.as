package zpp_nape.phys
{
    import flash.*;
    import nape.*;
    import nape.constraint.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import zpp_nape.constraint.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.shape.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_Body extends ZPP_Interactor
    {
        public var zip_worldCOM:Boolean;
        public var zip_mass:Boolean;
        public var zip_localCOM:Boolean;
        public var zip_inertia:Boolean;
        public var zip_gravMassScale:Boolean;
        public var zip_gravMass:Boolean;
        public var zip_axis:Boolean;
        public var zip_aabb:Boolean;
        public var wrapcvel:Vec3;
        public var wrap_worldCOM:Vec2;
        public var wrap_vel:Vec2;
        public var wrap_svel:Vec2;
        public var wrap_shapes:ShapeList;
        public var wrap_pos:Vec2;
        public var wrap_localCOM:Vec2;
        public var wrap_kinvel:Vec2;
        public var wrap_force:Vec2;
        public var wrap_constraints:ConstraintList;
        public var wrap_arbiters:ArbiterList;
        public var worldCOMy:Number;
        public var worldCOMx:Number;
        public var world:Boolean;
        public var vely:Number;
        public var velx:Number;
        public var type:int;
        public var torque:Number;
        public var sweep_angvel:Number;
        public var sweepTime:Number;
        public var sweepRadius:Number;
        public var sweepFrozen:Boolean;
        public var svely:Number;
        public var svelx:Number;
        public var space:ZPP_Space;
        public var smass:Number;
        public var sinertia:Number;
        public var shapes:ZNPList_ZPP_Shape;
        public var rot:Number;
        public var pre_rot:Number;
        public var pre_posy:Number;
        public var pre_posx:Number;
        public var posy:Number;
        public var posx:Number;
        public var outer:Body;
        public var norotate:Boolean;
        public var nomove:Boolean;
        public var massMode:int;
        public var mass:Number;
        public var localCOMy:Number;
        public var localCOMx:Number;
        public var kinvely:Number;
        public var kinvelx:Number;
        public var kinematicDelaySleep:Boolean;
        public var kinangvel:Number;
        public var inertiaMode:int;
        public var inertia:Number;
        public var imass:Number;
        public var iinertia:Number;
        public var gravMassScale:Number;
        public var gravMassMode:int;
        public var gravMass:Number;
        public var graph_depth:int;
        public var forcey:Number;
        public var forcex:Number;
        public var disableCCD:Boolean;
        public var constraints:ZNPList_ZPP_Constraint;
        public var compound:ZPP_Compound;
        public var component:ZPP_Component;
        public var cmass:Number;
        public var cinertia:Number;
        public var bulletEnabled:Boolean;
        public var bullet:Boolean;
        public var axisy:Number;
        public var axisx:Number;
        public var arbiters:ZNPList_ZPP_Arbiter;
        public var angvel:Number;
        public var aabb:ZPP_AABB;
        public static var init__:Boolean;
        public static var types:Array;
        public static var bodystack:ZNPList_ZPP_Body;
        public static var bodyset:ZPP_Set_ZPP_Body;
        public static var cur_graph_depth:int;

        public function ZPP_Body() : void
        {
            var _loc_3:* = null as ZPP_AABB;
            if (Boot.skip_constructor)
            {
                return;
            }
            wrap_worldCOM = null;
            wrap_localCOM = null;
            zip_worldCOM = false;
            worldCOMy = 0;
            worldCOMx = 0;
            zip_localCOM = false;
            localCOMy = 0;
            localCOMx = 0;
            zip_aabb = false;
            aabb = null;
            norotate = false;
            sinertia = 0;
            iinertia = 0;
            cinertia = 0;
            zip_inertia = false;
            inertia = 0;
            inertiaMode = 0;
            zip_gravMassScale = false;
            gravMassScale = 0;
            gravMassMode = 0;
            zip_gravMass = false;
            gravMass = 0;
            nomove = false;
            cmass = 0;
            smass = 0;
            imass = 0;
            massMode = 0;
            zip_mass = false;
            mass = 0;
            zip_axis = false;
            axisy = 0;
            axisx = 0;
            rot = 0;
            pre_rot = 0;
            kinangvel = 0;
            torque = 0;
            angvel = 0;
            wrapcvel = null;
            wrap_svel = null;
            svely = 0;
            svelx = 0;
            wrap_kinvel = null;
            kinvely = 0;
            kinvelx = 0;
            wrap_force = null;
            forcey = 0;
            forcex = 0;
            wrap_vel = null;
            vely = 0;
            velx = 0;
            wrap_pos = null;
            posy = 0;
            posx = 0;
            pre_posy = 0;
            pre_posx = 0;
            disableCCD = false;
            bulletEnabled = false;
            bullet = false;
            sweepRadius = 0;
            sweepFrozen = false;
            sweep_angvel = 0;
            sweepTime = 0;
            graph_depth = 0;
            component = null;
            wrap_constraints = null;
            constraints = null;
            wrap_arbiters = null;
            arbiters = null;
            space = null;
            wrap_shapes = null;
            shapes = null;
            compound = null;
            type = 0;
            world = false;
            outer = null;
            ibody = this;
            world = false;
            bulletEnabled = false;
            sweepTime = 0;
            sweep_angvel = 0;
            var _loc_1:* = false;
            nomove = false;
            norotate = _loc_1;
            disableCCD = false;
            posx = 0;
            posy = 0;
            rot = 0;
            axisx = 0;
            axisy = 1;
            svelx = 0;
            svely = 0;
            velx = 0;
            vely = 0;
            kinvelx = 0;
            kinvely = 0;
            forcex = 0;
            forcey = 0;
            var _loc_2:* = 0;
            kinangvel = 0;
            _loc_2 = _loc_2;
            angvel = _loc_2;
            torque = _loc_2;
            pre_posx = 17899999999999994000000000000;
            pre_posy = 17899999999999994000000000000;
            pre_rot = 17899999999999994000000000000;
            localCOMx = 0;
            localCOMy = 0;
            worldCOMx = 0;
            worldCOMy = 0;
            zip_aabb = true;
            if (ZPP_AABB.zpp_pool == null)
            {
                _loc_3 = new ZPP_AABB();
            }
            else
            {
                _loc_3 = ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.minx = 0;
            _loc_3.miny = 0;
            _loc_3.maxx = 0;
            _loc_3.maxy = 0;
            aabb = _loc_3;
            aabb._immutable = true;
            var _loc_4:* = this;
            aabb._validate = aabb_validate;
            massMode = ZPP_Flags.id_MassMode_DEFAULT;
            gravMassMode = ZPP_Flags.id_GravMassMode_DEFAULT;
            gravMassScale = 1;
            inertiaMode = ZPP_Flags.id_InertiaMode_DEFAULT;
            arbiters = new ZNPList_ZPP_Arbiter();
            constraints = new ZNPList_ZPP_Constraint();
            shapes = new ZNPList_ZPP_Shape();
            wrap_shapes = ZPP_ShapeList.get(shapes);
            wrap_shapes.zpp_inner.adder = shapes_adder;
            wrap_shapes.zpp_inner.subber = shapes_subber;
            wrap_shapes.zpp_inner._invalidate = shapes_invalidate;
            wrap_shapes.zpp_inner._modifiable = shapes_modifiable;
            kinematicDelaySleep = false;
            return;
        }// end function

        public function vel_validate() : void
        {
            wrap_vel.zpp_inner.x = velx;
            wrap_vel.zpp_inner.y = vely;
            return;
        }// end function

        public function vel_invalidate(param1:ZPP_Vec2) : void
        {
            if (type == ZPP_Flags.id_BodyType_STATIC)
            {
                throw "Error: Static body cannot have its velocity set.";
            }
            velx = param1.x;
            vely = param1.y;
            wake();
            return;
        }// end function

        public function validate_worldCOM() : void
        {
            if (zip_worldCOM)
            {
                zip_worldCOM = false;
                validate_localCOM();
                if (zip_axis)
                {
                    zip_axis = false;
                    axisx = Math.sin(rot);
                    axisy = Math.cos(rot);
                }
                worldCOMx = posx + (axisy * localCOMx - axisx * localCOMy);
                worldCOMy = posy + (localCOMx * axisx + localCOMy * axisy);
                if (wrap_worldCOM != null)
                {
                    wrap_worldCOM.zpp_inner.x = worldCOMx;
                    wrap_worldCOM.zpp_inner.y = worldCOMy;
                }
            }
            return;
        }// end function

        public function validate_mass() : void
        {
            var _loc_2:* = null as ZNPNode_ZPP_Shape;
            var _loc_3:* = null as ZPP_Shape;
            var _loc_4:* = NaN;
            var _loc_1:* = false;
            if (!zip_mass)
            {
                if (massMode == ZPP_Flags.id_MassMode_DEFAULT)
                {
                }
            }
            if (_loc_1)
            {
                zip_mass = false;
                if (massMode == ZPP_Flags.id_MassMode_DEFAULT)
                {
                    cmass = 0;
                    _loc_2 = shapes.head;
                    while (_loc_2 != null)
                    {
                        
                        _loc_3 = _loc_2.elt;
                        _loc_3.refmaterial.density = _loc_3.material.density;
                        _loc_3.validate_area_inertia();
                        cmass = cmass + _loc_3.area * _loc_3.material.density;
                        _loc_2 = _loc_2.next;
                    }
                }
                if (type == ZPP_Flags.id_BodyType_DYNAMIC)
                {
                }
                if (!nomove)
                {
                    mass = cmass;
                    _loc_4 = 1 / mass;
                    smass = _loc_4;
                    imass = _loc_4;
                }
                else
                {
                    mass = 17899999999999994000000000000;
                    _loc_4 = 0;
                    smass = _loc_4;
                    imass = _loc_4;
                }
                if (_loc_1)
                {
                    invalidate_inertia();
                }
            }
            return;
        }// end function

        public function validate_localCOM() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = null as ZNPNode_ZPP_Shape;
            var _loc_5:* = null as ZPP_Shape;
            var _loc_6:* = null as ZPP_Polygon;
            var _loc_7:* = NaN;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = NaN;
            var _loc_13:* = null as ZPP_Vec2;
            if (zip_localCOM)
            {
                zip_localCOM = false;
                _loc_1 = 0;
                _loc_2 = 0;
                _loc_3 = 0;
                _loc_4 = shapes.head;
                while (_loc_4 != null)
                {
                    
                    _loc_5 = _loc_4.elt;
                    if (_loc_5.zip_localCOM)
                    {
                        _loc_5.zip_localCOM = false;
                        if (_loc_5.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                            _loc_6 = _loc_5.polygon;
                            if (_loc_6.lverts.next == null)
                            {
                                throw "Error: An empty polygon has no meaningful localCOM";
                            }
                            if (_loc_6.lverts.next.next == null)
                            {
                                _loc_6.localCOMx = _loc_6.lverts.next.x;
                                _loc_6.localCOMy = _loc_6.lverts.next.y;
                            }
                            else if (_loc_6.lverts.next.next.next == null)
                            {
                                _loc_6.localCOMx = _loc_6.lverts.next.x;
                                _loc_6.localCOMy = _loc_6.lverts.next.y;
                                _loc_7 = 1;
                                _loc_6.localCOMx = _loc_6.localCOMx + _loc_6.lverts.next.next.x * _loc_7;
                                _loc_6.localCOMy = _loc_6.localCOMy + _loc_6.lverts.next.next.y * _loc_7;
                                _loc_7 = 0.5;
                                _loc_6.localCOMx = _loc_6.localCOMx * _loc_7;
                                _loc_6.localCOMy = _loc_6.localCOMy * _loc_7;
                            }
                            else
                            {
                                _loc_6.localCOMx = 0;
                                _loc_6.localCOMy = 0;
                                _loc_7 = 0;
                                _loc_8 = _loc_6.lverts.next;
                                _loc_9 = _loc_8;
                                _loc_8 = _loc_8.next;
                                _loc_10 = _loc_8;
                                _loc_8 = _loc_8.next;
                                while (_loc_8 != null)
                                {
                                    
                                    _loc_11 = _loc_8;
                                    _loc_7 = _loc_7 + _loc_10.x * (_loc_11.y - _loc_9.y);
                                    _loc_12 = _loc_11.y * _loc_10.x - _loc_11.x * _loc_10.y;
                                    _loc_6.localCOMx = _loc_6.localCOMx + (_loc_10.x + _loc_11.x) * _loc_12;
                                    _loc_6.localCOMy = _loc_6.localCOMy + (_loc_10.y + _loc_11.y) * _loc_12;
                                    _loc_9 = _loc_10;
                                    _loc_10 = _loc_11;
                                    _loc_8 = _loc_8.next;
                                }
                                _loc_8 = _loc_6.lverts.next;
                                _loc_11 = _loc_8;
                                _loc_7 = _loc_7 + _loc_10.x * (_loc_11.y - _loc_9.y);
                                _loc_12 = _loc_11.y * _loc_10.x - _loc_11.x * _loc_10.y;
                                _loc_6.localCOMx = _loc_6.localCOMx + (_loc_10.x + _loc_11.x) * _loc_12;
                                _loc_6.localCOMy = _loc_6.localCOMy + (_loc_10.y + _loc_11.y) * _loc_12;
                                _loc_9 = _loc_10;
                                _loc_10 = _loc_11;
                                _loc_8 = _loc_8.next;
                                _loc_13 = _loc_8;
                                _loc_7 = _loc_7 + _loc_10.x * (_loc_13.y - _loc_9.y);
                                _loc_12 = _loc_13.y * _loc_10.x - _loc_13.x * _loc_10.y;
                                _loc_6.localCOMx = _loc_6.localCOMx + (_loc_10.x + _loc_13.x) * _loc_12;
                                _loc_6.localCOMy = _loc_6.localCOMy + (_loc_10.y + _loc_13.y) * _loc_12;
                                _loc_7 = 1 / (3 * _loc_7);
                                _loc_12 = _loc_7;
                                _loc_6.localCOMx = _loc_6.localCOMx * _loc_12;
                                _loc_6.localCOMy = _loc_6.localCOMy * _loc_12;
                            }
                        }
                        if (_loc_5.wrap_localCOM != null)
                        {
                            _loc_5.wrap_localCOM.zpp_inner.x = _loc_5.localCOMx;
                            _loc_5.wrap_localCOM.zpp_inner.y = _loc_5.localCOMy;
                        }
                    }
                    _loc_5.validate_area_inertia();
                    _loc_7 = _loc_5.area * _loc_5.material.density;
                    _loc_1 = _loc_1 + _loc_5.localCOMx * _loc_7;
                    _loc_2 = _loc_2 + _loc_5.localCOMy * _loc_7;
                    _loc_3 = _loc_3 + _loc_5.area * _loc_5.material.density;
                    _loc_4 = _loc_4.next;
                }
                if (_loc_3 != 0)
                {
                    _loc_7 = 1 / _loc_3;
                    localCOMx = _loc_1 * _loc_7;
                    localCOMy = _loc_2 * _loc_7;
                }
                if (wrap_localCOM != null)
                {
                    wrap_localCOM.zpp_inner.x = localCOMx;
                    wrap_localCOM.zpp_inner.y = localCOMy;
                }
                if (zip_mass)
                {
                }
                if (massMode == ZPP_Flags.id_MassMode_DEFAULT)
                {
                    zip_mass = false;
                    cmass = _loc_3;
                    if (type == ZPP_Flags.id_BodyType_DYNAMIC)
                    {
                        mass = cmass;
                        _loc_7 = 1 / mass;
                        smass = _loc_7;
                        imass = _loc_7;
                    }
                    else
                    {
                        mass = 17899999999999994000000000000;
                        _loc_7 = 0;
                        smass = _loc_7;
                        imass = _loc_7;
                    }
                }
            }
            return;
        }// end function

        public function validate_inertia() : void
        {
            var _loc_2:* = null as ZNPNode_ZPP_Shape;
            var _loc_3:* = null as ZPP_Shape;
            var _loc_4:* = NaN;
            var _loc_1:* = false;
            if (!zip_inertia)
            {
                if (inertiaMode == ZPP_Flags.id_InertiaMode_DEFAULT)
                {
                }
            }
            if (_loc_1)
            {
                zip_inertia = false;
                if (inertiaMode == ZPP_Flags.id_InertiaMode_DEFAULT)
                {
                    cinertia = 0;
                    _loc_2 = shapes.head;
                    while (_loc_2 != null)
                    {
                        
                        _loc_3 = _loc_2.elt;
                        _loc_3.refmaterial.density = _loc_3.material.density;
                        _loc_3.validate_area_inertia();
                        cinertia = cinertia + _loc_3.inertia * _loc_3.area * _loc_3.material.density;
                        _loc_2 = _loc_2.next;
                    }
                }
                if (type == ZPP_Flags.id_BodyType_DYNAMIC)
                {
                }
                if (!norotate)
                {
                    inertia = cinertia;
                    _loc_4 = 1 / inertia;
                    iinertia = _loc_4;
                    sinertia = _loc_4;
                }
                else
                {
                    inertia = 17899999999999994000000000000;
                    _loc_4 = 0;
                    iinertia = _loc_4;
                    sinertia = _loc_4;
                }
                if (_loc_1)
                {
                    invalidate_inertia();
                }
            }
            return;
        }// end function

        public function validate_gravMassScale() : void
        {
            if (zip_gravMassScale)
            {
                zip_gravMassScale = false;
                if (gravMassMode == ZPP_Flags.id_GravMassMode_DEFAULT)
                {
                    gravMassScale = 1;
                }
                else if (gravMassMode == ZPP_Flags.id_GravMassMode_FIXED)
                {
                    validate_mass();
                    gravMassScale = gravMass / cmass;
                }
            }
            return;
        }// end function

        public function validate_gravMass() : void
        {
            if (zip_gravMass)
            {
                zip_gravMass = false;
                validate_mass();
                if (gravMassMode == ZPP_Flags.id_GravMassMode_DEFAULT)
                {
                    validate_mass();
                    gravMass = cmass;
                }
                else if (gravMassMode == ZPP_Flags.id_GravMassMode_SCALED)
                {
                    validate_mass();
                    gravMass = cmass * gravMassScale;
                }
            }
            return;
        }// end function

        public function validate_axis() : void
        {
            if (zip_axis)
            {
                zip_axis = false;
                axisx = Math.sin(rot);
                axisy = Math.cos(rot);
            }
            return;
        }// end function

        public function validate_aabb() : void
        {
            var _loc_1:* = null as ZNPNode_ZPP_Shape;
            var _loc_2:* = null as ZPP_Shape;
            var _loc_3:* = null as ZPP_Circle;
            var _loc_4:* = null as ZPP_Polygon;
            var _loc_5:* = NaN;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = NaN;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = null as ZPP_Body;
            var _loc_13:* = null as ZPP_AABB;
            var _loc_14:* = null as ZPP_AABB;
            if (shapes.head == null)
            {
                throw "Error: Body bounds only makes sense if it contains shapes";
            }
            if (zip_aabb)
            {
                zip_aabb = false;
                aabb.minx = 17899999999999994000000000000;
                aabb.miny = 17899999999999994000000000000;
                aabb.maxx = -17899999999999994000000000000;
                aabb.maxy = -17899999999999994000000000000;
                _loc_1 = shapes.head;
                while (_loc_1 != null)
                {
                    
                    _loc_2 = _loc_1.elt;
                    if (_loc_2.zip_aabb)
                    {
                        if (_loc_2.body != null)
                        {
                            _loc_2.zip_aabb = false;
                            if (_loc_2.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                _loc_3 = _loc_2.circle;
                                if (_loc_3.zip_worldCOM)
                                {
                                    if (_loc_3.body != null)
                                    {
                                        _loc_3.zip_worldCOM = false;
                                        if (_loc_3.zip_localCOM)
                                        {
                                            _loc_3.zip_localCOM = false;
                                            if (_loc_3.type == ZPP_Flags.id_ShapeType_POLYGON)
                                            {
                                                _loc_4 = _loc_3.polygon;
                                                if (_loc_4.lverts.next == null)
                                                {
                                                    throw "Error: An empty polygon has no meaningful localCOM";
                                                }
                                                if (_loc_4.lverts.next.next == null)
                                                {
                                                    _loc_4.localCOMx = _loc_4.lverts.next.x;
                                                    _loc_4.localCOMy = _loc_4.lverts.next.y;
                                                }
                                                else if (_loc_4.lverts.next.next.next == null)
                                                {
                                                    _loc_4.localCOMx = _loc_4.lverts.next.x;
                                                    _loc_4.localCOMy = _loc_4.lverts.next.y;
                                                    _loc_5 = 1;
                                                    _loc_4.localCOMx = _loc_4.localCOMx + _loc_4.lverts.next.next.x * _loc_5;
                                                    _loc_4.localCOMy = _loc_4.localCOMy + _loc_4.lverts.next.next.y * _loc_5;
                                                    _loc_5 = 0.5;
                                                    _loc_4.localCOMx = _loc_4.localCOMx * _loc_5;
                                                    _loc_4.localCOMy = _loc_4.localCOMy * _loc_5;
                                                }
                                                else
                                                {
                                                    _loc_4.localCOMx = 0;
                                                    _loc_4.localCOMy = 0;
                                                    _loc_5 = 0;
                                                    _loc_6 = _loc_4.lverts.next;
                                                    _loc_7 = _loc_6;
                                                    _loc_6 = _loc_6.next;
                                                    _loc_8 = _loc_6;
                                                    _loc_6 = _loc_6.next;
                                                    while (_loc_6 != null)
                                                    {
                                                        
                                                        _loc_9 = _loc_6;
                                                        _loc_5 = _loc_5 + _loc_8.x * (_loc_9.y - _loc_7.y);
                                                        _loc_10 = _loc_9.y * _loc_8.x - _loc_9.x * _loc_8.y;
                                                        _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_9.x) * _loc_10;
                                                        _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_9.y) * _loc_10;
                                                        _loc_7 = _loc_8;
                                                        _loc_8 = _loc_9;
                                                        _loc_6 = _loc_6.next;
                                                    }
                                                    _loc_6 = _loc_4.lverts.next;
                                                    _loc_9 = _loc_6;
                                                    _loc_5 = _loc_5 + _loc_8.x * (_loc_9.y - _loc_7.y);
                                                    _loc_10 = _loc_9.y * _loc_8.x - _loc_9.x * _loc_8.y;
                                                    _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_9.x) * _loc_10;
                                                    _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_9.y) * _loc_10;
                                                    _loc_7 = _loc_8;
                                                    _loc_8 = _loc_9;
                                                    _loc_6 = _loc_6.next;
                                                    _loc_11 = _loc_6;
                                                    _loc_5 = _loc_5 + _loc_8.x * (_loc_11.y - _loc_7.y);
                                                    _loc_10 = _loc_11.y * _loc_8.x - _loc_11.x * _loc_8.y;
                                                    _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_11.x) * _loc_10;
                                                    _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_11.y) * _loc_10;
                                                    _loc_5 = 1 / (3 * _loc_5);
                                                    _loc_10 = _loc_5;
                                                    _loc_4.localCOMx = _loc_4.localCOMx * _loc_10;
                                                    _loc_4.localCOMy = _loc_4.localCOMy * _loc_10;
                                                }
                                            }
                                            if (_loc_3.wrap_localCOM != null)
                                            {
                                                _loc_3.wrap_localCOM.zpp_inner.x = _loc_3.localCOMx;
                                                _loc_3.wrap_localCOM.zpp_inner.y = _loc_3.localCOMy;
                                            }
                                        }
                                        _loc_12 = _loc_3.body;
                                        if (_loc_12.zip_axis)
                                        {
                                            _loc_12.zip_axis = false;
                                            _loc_12.axisx = Math.sin(_loc_12.rot);
                                            _loc_12.axisy = Math.cos(_loc_12.rot);
                                        }
                                        _loc_3.worldCOMx = _loc_3.body.posx + (_loc_3.body.axisy * _loc_3.localCOMx - _loc_3.body.axisx * _loc_3.localCOMy);
                                        _loc_3.worldCOMy = _loc_3.body.posy + (_loc_3.localCOMx * _loc_3.body.axisx + _loc_3.localCOMy * _loc_3.body.axisy);
                                    }
                                }
                                _loc_5 = _loc_3.radius;
                                _loc_10 = _loc_3.radius;
                                _loc_3.aabb.minx = _loc_3.worldCOMx - _loc_5;
                                _loc_3.aabb.miny = _loc_3.worldCOMy - _loc_10;
                                _loc_3.aabb.maxx = _loc_3.worldCOMx + _loc_5;
                                _loc_3.aabb.maxy = _loc_3.worldCOMy + _loc_10;
                            }
                            else
                            {
                                _loc_4 = _loc_2.polygon;
                                if (_loc_4.zip_gverts)
                                {
                                    if (_loc_4.body != null)
                                    {
                                        _loc_4.zip_gverts = false;
                                        _loc_4.validate_lverts();
                                        _loc_12 = _loc_4.body;
                                        if (_loc_12.zip_axis)
                                        {
                                            _loc_12.zip_axis = false;
                                            _loc_12.axisx = Math.sin(_loc_12.rot);
                                            _loc_12.axisy = Math.cos(_loc_12.rot);
                                        }
                                        _loc_6 = _loc_4.lverts.next;
                                        _loc_7 = _loc_4.gverts.next;
                                        while (_loc_7 != null)
                                        {
                                            
                                            _loc_8 = _loc_7;
                                            _loc_9 = _loc_6;
                                            _loc_6 = _loc_6.next;
                                            _loc_8.x = _loc_4.body.posx + (_loc_4.body.axisy * _loc_9.x - _loc_4.body.axisx * _loc_9.y);
                                            _loc_8.y = _loc_4.body.posy + (_loc_9.x * _loc_4.body.axisx + _loc_9.y * _loc_4.body.axisy);
                                            _loc_7 = _loc_7.next;
                                        }
                                    }
                                }
                                if (_loc_4.lverts.next == null)
                                {
                                    throw "Error: An empty polygon has no meaningful bounds";
                                }
                                _loc_6 = _loc_4.gverts.next;
                                _loc_4.aabb.minx = _loc_6.x;
                                _loc_4.aabb.miny = _loc_6.y;
                                _loc_4.aabb.maxx = _loc_6.x;
                                _loc_4.aabb.maxy = _loc_6.y;
                                _loc_7 = _loc_4.gverts.next.next;
                                while (_loc_7 != null)
                                {
                                    
                                    _loc_8 = _loc_7;
                                    if (_loc_8.x < _loc_4.aabb.minx)
                                    {
                                        _loc_4.aabb.minx = _loc_8.x;
                                    }
                                    if (_loc_8.x > _loc_4.aabb.maxx)
                                    {
                                        _loc_4.aabb.maxx = _loc_8.x;
                                    }
                                    if (_loc_8.y < _loc_4.aabb.miny)
                                    {
                                        _loc_4.aabb.miny = _loc_8.y;
                                    }
                                    if (_loc_8.y > _loc_4.aabb.maxy)
                                    {
                                        _loc_4.aabb.maxy = _loc_8.y;
                                    }
                                    _loc_7 = _loc_7.next;
                                }
                            }
                        }
                    }
                    _loc_13 = aabb;
                    _loc_14 = _loc_2.aabb;
                    if (_loc_14.minx < _loc_13.minx)
                    {
                        _loc_13.minx = _loc_14.minx;
                    }
                    if (_loc_14.maxx > _loc_13.maxx)
                    {
                        _loc_13.maxx = _loc_14.maxx;
                    }
                    if (_loc_14.miny < _loc_13.miny)
                    {
                        _loc_13.miny = _loc_14.miny;
                    }
                    if (_loc_14.maxy > _loc_13.maxy)
                    {
                        _loc_13.maxy = _loc_14.maxy;
                    }
                    _loc_1 = _loc_1.next;
                }
            }
            return;
        }// end function

        public function sweepValidate(param1:ZPP_Shape) : void
        {
            var _loc_2:* = null as ZPP_Polygon;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZNPNode_ZPP_Edge;
            var _loc_8:* = null as ZPP_Edge;
            if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                param1.worldCOMx = posx + (axisy * param1.localCOMx - axisx * param1.localCOMy);
                param1.worldCOMy = posy + (param1.localCOMx * axisx + param1.localCOMy * axisy);
            }
            else
            {
                _loc_2 = param1.polygon;
                _loc_3 = _loc_2.lverts.next;
                _loc_4 = _loc_2.gverts.next;
                while (_loc_4 != null)
                {
                    
                    _loc_5 = _loc_4;
                    _loc_6 = _loc_3;
                    _loc_3 = _loc_3.next;
                    _loc_5.x = posx + (axisy * _loc_6.x - axisx * _loc_6.y);
                    _loc_5.y = posy + (_loc_6.x * axisx + _loc_6.y * axisy);
                    _loc_4 = _loc_4.next;
                }
                _loc_7 = _loc_2.edges.head;
                _loc_4 = _loc_2.gverts.next;
                _loc_5 = _loc_4;
                _loc_4 = _loc_4.next;
                while (_loc_4 != null)
                {
                    
                    _loc_6 = _loc_4;
                    _loc_8 = _loc_7.elt;
                    _loc_7 = _loc_7.next;
                    _loc_8.gnormx = axisy * _loc_8.lnormx - axisx * _loc_8.lnormy;
                    _loc_8.gnormy = _loc_8.lnormx * axisx + _loc_8.lnormy * axisy;
                    _loc_8.gprojection = posx * _loc_8.gnormx + posy * _loc_8.gnormy + _loc_8.lprojection;
                    _loc_8.tp0 = _loc_5.y * _loc_8.gnormx - _loc_5.x * _loc_8.gnormy;
                    _loc_8.tp1 = _loc_6.y * _loc_8.gnormx - _loc_6.x * _loc_8.gnormy;
                    _loc_5 = _loc_6;
                    _loc_4 = _loc_4.next;
                }
                _loc_6 = _loc_2.gverts.next;
                _loc_8 = _loc_7.elt;
                _loc_7 = _loc_7.next;
                _loc_8.gnormx = axisy * _loc_8.lnormx - axisx * _loc_8.lnormy;
                _loc_8.gnormy = _loc_8.lnormx * axisx + _loc_8.lnormy * axisy;
                _loc_8.gprojection = posx * _loc_8.gnormx + posy * _loc_8.gnormy + _loc_8.lprojection;
                _loc_8.tp0 = _loc_5.y * _loc_8.gnormx - _loc_5.x * _loc_8.gnormy;
                _loc_8.tp1 = _loc_6.y * _loc_8.gnormx - _loc_6.x * _loc_8.gnormy;
            }
            return;
        }// end function

        public function sweepIntegrate(param1:Number) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_2:* = param1 - sweepTime;
            if (_loc_2 != 0)
            {
                sweepTime = param1;
                _loc_3 = _loc_2;
                posx = posx + velx * _loc_3;
                posy = posy + vely * _loc_3;
                if (angvel != 0)
                {
                    _loc_3 = sweep_angvel * _loc_2;
                    rot = rot + _loc_3;
                    if (_loc_3 * _loc_3 > 0.0001)
                    {
                        axisx = Math.sin(rot);
                        axisy = Math.cos(rot);
                    }
                    else
                    {
                        _loc_4 = _loc_3 * _loc_3;
                        _loc_5 = 1 - 0.5 * _loc_4;
                        _loc_6 = 1 - _loc_4 * _loc_4 / 8;
                        _loc_7 = (_loc_5 * axisx + _loc_3 * axisy) * _loc_6;
                        axisy = (_loc_5 * axisy - _loc_3 * axisx) * _loc_6;
                        axisx = _loc_7;
                    }
                }
            }
            return;
        }// end function

        public function svel_validate() : void
        {
            wrap_svel.zpp_inner.x = svelx;
            wrap_svel.zpp_inner.y = svely;
            return;
        }// end function

        public function svel_invalidate(param1:ZPP_Vec2) : void
        {
            svelx = param1.x;
            svely = param1.y;
            wake();
            return;
        }// end function

        public function shapes_subber(param1:Shape) : void
        {
            if (space != null)
            {
                space.removed_shape(param1.zpp_inner);
            }
            param1.zpp_inner.body = null;
            param1.zpp_inner.removedFromBody();
            return;
        }// end function

        public function shapes_modifiable() : void
        {
            immutable_midstep("Body::shapes");
            if (type == ZPP_Flags.id_BodyType_STATIC)
            {
            }
            if (space != null)
            {
                throw "Error: Cannot modifiy shapes of static object once added to Space";
            }
            return;
        }// end function

        public function shapes_invalidate(param1:ZPP_ShapeList) : void
        {
            invalidate_shapes();
            return;
        }// end function

        public function shapes_adder(param1:Shape) : Boolean
        {
            var _loc_2:* = null as ZPP_Space;
            var _loc_3:* = null as ZPP_Shape;
            var _loc_4:* = false;
            var _loc_5:* = null as ZPP_Body;
            if (param1.zpp_inner.body != this)
            {
                if (param1.zpp_inner.body != null)
                {
                    param1.zpp_inner.body.wrap_shapes.remove(param1);
                }
                param1.zpp_inner.body = this;
                param1.zpp_inner.addedToBody();
                if (space != null)
                {
                    _loc_2 = space;
                    _loc_3 = param1.zpp_inner;
                    _loc_4 = false;
                    if (!_loc_4)
                    {
                        _loc_5 = _loc_3.body;
                        if (!_loc_5.world)
                        {
                            _loc_5.component.waket = _loc_2.stamp + (_loc_2.midstep ? (0) : (1));
                            if (_loc_5.type == ZPP_Flags.id_BodyType_KINEMATIC)
                            {
                                _loc_5.kinematicDelaySleep = true;
                            }
                            if (_loc_5.component.sleeping)
                            {
                                _loc_2.really_wake(_loc_5, false);
                            }
                        }
                    }
                    _loc_2.bphase.insert(_loc_3);
                    _loc_3.addedToSpace();
                }
                if (param1.zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    param1.zpp_inner.polygon.invalidate_gaxi();
                    param1.zpp_inner.polygon.invalidate_gverts();
                }
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public function setupsvel() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = svelx;
            var _loc_2:* = svely;
            var _loc_3:* = false;
            if (_loc_1 == _loc_1)
            {
            }
            if (_loc_2 != _loc_2)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_4 = new Vec2();
            }
            else
            {
                _loc_4 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_4.zpp_pool;
                _loc_4.zpp_pool = null;
                _loc_4.zpp_disp = false;
                if (_loc_4 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_4.zpp_inner == null)
            {
                _loc_5 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_6 = new ZPP_Vec2();
                }
                else
                {
                    _loc_6 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_6.next;
                    _loc_6.next = null;
                }
                _loc_6.weak = false;
                _loc_6._immutable = _loc_5;
                _loc_6.x = _loc_1;
                _loc_6.y = _loc_2;
                _loc_4.zpp_inner = _loc_6;
                _loc_4.zpp_inner.outer = _loc_4;
            }
            else
            {
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_1 == _loc_1)
                {
                }
                if (_loc_2 != _loc_2)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_4.zpp_inner.x == _loc_1)
                {
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                }
                if (_loc_4.zpp_inner.y != _loc_2)
                {
                    _loc_4.zpp_inner.x = _loc_1;
                    _loc_4.zpp_inner.y = _loc_2;
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._invalidate != null)
                    {
                        _loc_6._invalidate(_loc_6);
                    }
                }
            }
            _loc_4.zpp_inner.weak = _loc_3;
            wrap_svel = _loc_4;
            wrap_svel.zpp_inner._inuse = true;
            if (world)
            {
                wrap_svel.zpp_inner._immutable = true;
            }
            else
            {
                wrap_svel.zpp_inner._invalidate = svel_invalidate;
                wrap_svel.zpp_inner._validate = svel_validate;
            }
            return;
        }// end function

        public function setupkinvel() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = kinvelx;
            var _loc_2:* = kinvely;
            var _loc_3:* = false;
            if (_loc_1 == _loc_1)
            {
            }
            if (_loc_2 != _loc_2)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_4 = new Vec2();
            }
            else
            {
                _loc_4 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_4.zpp_pool;
                _loc_4.zpp_pool = null;
                _loc_4.zpp_disp = false;
                if (_loc_4 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_4.zpp_inner == null)
            {
                _loc_5 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_6 = new ZPP_Vec2();
                }
                else
                {
                    _loc_6 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_6.next;
                    _loc_6.next = null;
                }
                _loc_6.weak = false;
                _loc_6._immutable = _loc_5;
                _loc_6.x = _loc_1;
                _loc_6.y = _loc_2;
                _loc_4.zpp_inner = _loc_6;
                _loc_4.zpp_inner.outer = _loc_4;
            }
            else
            {
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_1 == _loc_1)
                {
                }
                if (_loc_2 != _loc_2)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_4.zpp_inner.x == _loc_1)
                {
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                }
                if (_loc_4.zpp_inner.y != _loc_2)
                {
                    _loc_4.zpp_inner.x = _loc_1;
                    _loc_4.zpp_inner.y = _loc_2;
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._invalidate != null)
                    {
                        _loc_6._invalidate(_loc_6);
                    }
                }
            }
            _loc_4.zpp_inner.weak = _loc_3;
            wrap_kinvel = _loc_4;
            wrap_kinvel.zpp_inner._inuse = true;
            if (world)
            {
                wrap_kinvel.zpp_inner._immutable = true;
            }
            else
            {
                wrap_kinvel.zpp_inner._invalidate = kinvel_invalidate;
                wrap_kinvel.zpp_inner._validate = kinvel_validate;
            }
            return;
        }// end function

        public function setup_cvel() : void
        {
            var _loc_1:* = this;
            wrapcvel = Vec3.get();
            wrapcvel.zpp_inner.immutable = true;
            wrapcvel.zpp_inner._validate = cvel_validate;
            return;
        }// end function

        public function setupVelocity() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = velx;
            var _loc_2:* = vely;
            var _loc_3:* = false;
            if (_loc_1 == _loc_1)
            {
            }
            if (_loc_2 != _loc_2)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_4 = new Vec2();
            }
            else
            {
                _loc_4 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_4.zpp_pool;
                _loc_4.zpp_pool = null;
                _loc_4.zpp_disp = false;
                if (_loc_4 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_4.zpp_inner == null)
            {
                _loc_5 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_6 = new ZPP_Vec2();
                }
                else
                {
                    _loc_6 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_6.next;
                    _loc_6.next = null;
                }
                _loc_6.weak = false;
                _loc_6._immutable = _loc_5;
                _loc_6.x = _loc_1;
                _loc_6.y = _loc_2;
                _loc_4.zpp_inner = _loc_6;
                _loc_4.zpp_inner.outer = _loc_4;
            }
            else
            {
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_1 == _loc_1)
                {
                }
                if (_loc_2 != _loc_2)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_4.zpp_inner.x == _loc_1)
                {
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                }
                if (_loc_4.zpp_inner.y != _loc_2)
                {
                    _loc_4.zpp_inner.x = _loc_1;
                    _loc_4.zpp_inner.y = _loc_2;
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._invalidate != null)
                    {
                        _loc_6._invalidate(_loc_6);
                    }
                }
            }
            _loc_4.zpp_inner.weak = _loc_3;
            wrap_vel = _loc_4;
            wrap_vel.zpp_inner._inuse = true;
            if (world)
            {
                wrap_vel.zpp_inner._immutable = true;
            }
            else
            {
                wrap_vel.zpp_inner._invalidate = vel_invalidate;
                wrap_vel.zpp_inner._validate = vel_validate;
            }
            return;
        }// end function

        public function setupPosition() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = posx;
            var _loc_2:* = posy;
            var _loc_3:* = false;
            if (_loc_1 == _loc_1)
            {
            }
            if (_loc_2 != _loc_2)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_4 = new Vec2();
            }
            else
            {
                _loc_4 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_4.zpp_pool;
                _loc_4.zpp_pool = null;
                _loc_4.zpp_disp = false;
                if (_loc_4 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_4.zpp_inner == null)
            {
                _loc_5 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_6 = new ZPP_Vec2();
                }
                else
                {
                    _loc_6 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_6.next;
                    _loc_6.next = null;
                }
                _loc_6.weak = false;
                _loc_6._immutable = _loc_5;
                _loc_6.x = _loc_1;
                _loc_6.y = _loc_2;
                _loc_4.zpp_inner = _loc_6;
                _loc_4.zpp_inner.outer = _loc_4;
            }
            else
            {
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_1 == _loc_1)
                {
                }
                if (_loc_2 != _loc_2)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_4.zpp_inner.x == _loc_1)
                {
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                }
                if (_loc_4.zpp_inner.y != _loc_2)
                {
                    _loc_4.zpp_inner.x = _loc_1;
                    _loc_4.zpp_inner.y = _loc_2;
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._invalidate != null)
                    {
                        _loc_6._invalidate(_loc_6);
                    }
                }
            }
            _loc_4.zpp_inner.weak = _loc_3;
            wrap_pos = _loc_4;
            wrap_pos.zpp_inner._inuse = true;
            if (world)
            {
                wrap_pos.zpp_inner._immutable = true;
            }
            else
            {
                wrap_pos.zpp_inner._invalidate = pos_invalidate;
                wrap_pos.zpp_inner._validate = pos_validate;
            }
            return;
        }// end function

        public function setupForce() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = forcex;
            var _loc_2:* = forcey;
            var _loc_3:* = false;
            if (_loc_1 == _loc_1)
            {
            }
            if (_loc_2 != _loc_2)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_4 = new Vec2();
            }
            else
            {
                _loc_4 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_4.zpp_pool;
                _loc_4.zpp_pool = null;
                _loc_4.zpp_disp = false;
                if (_loc_4 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_4.zpp_inner == null)
            {
                _loc_5 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_6 = new ZPP_Vec2();
                }
                else
                {
                    _loc_6 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_6.next;
                    _loc_6.next = null;
                }
                _loc_6.weak = false;
                _loc_6._immutable = _loc_5;
                _loc_6.x = _loc_1;
                _loc_6.y = _loc_2;
                _loc_4.zpp_inner = _loc_6;
                _loc_4.zpp_inner.outer = _loc_4;
            }
            else
            {
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_1 == _loc_1)
                {
                }
                if (_loc_2 != _loc_2)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_4.zpp_inner.x == _loc_1)
                {
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                }
                if (_loc_4.zpp_inner.y != _loc_2)
                {
                    _loc_4.zpp_inner.x = _loc_1;
                    _loc_4.zpp_inner.y = _loc_2;
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._invalidate != null)
                    {
                        _loc_6._invalidate(_loc_6);
                    }
                }
            }
            _loc_4.zpp_inner.weak = _loc_3;
            wrap_force = _loc_4;
            wrap_force.zpp_inner._inuse = true;
            if (world)
            {
                wrap_force.zpp_inner._immutable = true;
            }
            else
            {
                wrap_force.zpp_inner._invalidate = force_invalidate;
                wrap_force.zpp_inner._validate = force_validate;
            }
            return;
        }// end function

        public function removedFromSpace() : void
        {
            var _loc_1:* = null as ZPP_Arbiter;
            var _loc_2:* = null as ZNPList_ZPP_Arbiter;
            var _loc_3:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_4:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_5:* = false;
            var _loc_6:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_7:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_8:* = null as ZNPNode_ZPP_Arbiter;
            while (arbiters.head != null)
            {
                
                _loc_1 = arbiters.pop_unsafe();
                _loc_1.cleared = true;
                if (_loc_1.b2 == this)
                {
                    _loc_2 = _loc_1.b1.arbiters;
                    _loc_3 = null;
                    _loc_4 = _loc_2.head;
                    _loc_5 = false;
                    while (_loc_4 != null)
                    {
                        
                        if (_loc_4.elt == _loc_1)
                        {
                            if (_loc_3 == null)
                            {
                                _loc_6 = _loc_2.head;
                                _loc_7 = _loc_6.next;
                                _loc_2.head = _loc_7;
                                if (_loc_2.head == null)
                                {
                                    _loc_2.pushmod = true;
                                }
                            }
                            else
                            {
                                _loc_6 = _loc_3.next;
                                _loc_7 = _loc_6.next;
                                _loc_3.next = _loc_7;
                                if (_loc_7 == null)
                                {
                                    _loc_2.pushmod = true;
                                }
                            }
                            _loc_8 = _loc_6;
                            _loc_8.elt = null;
                            _loc_8.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                            ZNPNode_ZPP_Arbiter.zpp_pool = _loc_8;
                            _loc_2.modified = true;
                            (_loc_2.length - 1);
                            _loc_2.pushmod = true;
                            _loc_5 = true;
                            break;
                        }
                        _loc_3 = _loc_4;
                        _loc_4 = _loc_4.next;
                    }
                }
                if (_loc_1.b1 == this)
                {
                    _loc_2 = _loc_1.b2.arbiters;
                    _loc_3 = null;
                    _loc_4 = _loc_2.head;
                    _loc_5 = false;
                    while (_loc_4 != null)
                    {
                        
                        if (_loc_4.elt == _loc_1)
                        {
                            if (_loc_3 == null)
                            {
                                _loc_6 = _loc_2.head;
                                _loc_7 = _loc_6.next;
                                _loc_2.head = _loc_7;
                                if (_loc_2.head == null)
                                {
                                    _loc_2.pushmod = true;
                                }
                            }
                            else
                            {
                                _loc_6 = _loc_3.next;
                                _loc_7 = _loc_6.next;
                                _loc_3.next = _loc_7;
                                if (_loc_7 == null)
                                {
                                    _loc_2.pushmod = true;
                                }
                            }
                            _loc_8 = _loc_6;
                            _loc_8.elt = null;
                            _loc_8.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                            ZNPNode_ZPP_Arbiter.zpp_pool = _loc_8;
                            _loc_2.modified = true;
                            (_loc_2.length - 1);
                            _loc_2.pushmod = true;
                            _loc_5 = true;
                            break;
                        }
                        _loc_3 = _loc_4;
                        _loc_4 = _loc_4.next;
                    }
                }
                if (_loc_1.pair != null)
                {
                    _loc_1.pair.arb = null;
                    _loc_1.pair = null;
                }
                _loc_1.active = false;
                space.f_arbiters.modified = true;
            }
            var _loc_9:* = component;
            _loc_9.body = null;
            _loc_9.constraint = null;
            _loc_9.next = ZPP_Component.zpp_pool;
            ZPP_Component.zpp_pool = _loc_9;
            component = null;
            __iremovedFromSpace();
            return;
        }// end function

        public function refreshArbiters() : void
        {
            var _loc_2:* = null as ZPP_Arbiter;
            var _loc_1:* = arbiters.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_2.invalidated = true;
                _loc_1 = _loc_1.next;
            }
            return;
        }// end function

        public function quick_validate_axis() : void
        {
            axisx = Math.sin(rot);
            axisy = Math.cos(rot);
            return;
        }// end function

        public function pos_validate() : void
        {
            wrap_pos.zpp_inner.x = posx;
            wrap_pos.zpp_inner.y = posy;
            return;
        }// end function

        public function pos_invalidate(param1:ZPP_Vec2) : void
        {
            var _loc_2:* = null as ZNPNode_ZPP_Shape;
            var _loc_3:* = null as ZPP_Shape;
            immutable_midstep("Body::position");
            if (type == ZPP_Flags.id_BodyType_STATIC)
            {
            }
            if (space != null)
            {
                throw "Error: Cannot move a static object once inside a Space";
            }
            if (posx == param1.x)
            {
            }
            if (posy != param1.y)
            {
                posx = param1.x;
                posy = param1.y;
                _loc_2 = shapes.head;
                while (_loc_2 != null)
                {
                    
                    _loc_3 = _loc_2.elt;
                    if (_loc_3.type == ZPP_Flags.id_ShapeType_POLYGON)
                    {
                        _loc_3.polygon.invalidate_gverts();
                        _loc_3.polygon.invalidate_gaxi();
                    }
                    _loc_3.invalidate_worldCOM();
                    _loc_2 = _loc_2.next;
                }
                zip_worldCOM = true;
                wake();
            }
            return;
        }// end function

        public function kinvel_validate() : void
        {
            wrap_kinvel.zpp_inner.x = kinvelx;
            wrap_kinvel.zpp_inner.y = kinvely;
            return;
        }// end function

        public function kinvel_invalidate(param1:ZPP_Vec2) : void
        {
            kinvelx = param1.x;
            kinvely = param1.y;
            wake();
            return;
        }// end function

        public function isStatic() : Boolean
        {
            return type == ZPP_Flags.id_BodyType_STATIC;
        }// end function

        public function isKinematic() : Boolean
        {
            return type == ZPP_Flags.id_BodyType_KINEMATIC;
        }// end function

        public function isDynamic() : Boolean
        {
            return type == ZPP_Flags.id_BodyType_DYNAMIC;
        }// end function

        public function invalidate_worldCOM() : void
        {
            zip_worldCOM = true;
            return;
        }// end function

        public function invalidate_wake() : void
        {
            wake();
            return;
        }// end function

        public function invalidate_type() : void
        {
            invalidate_mass();
            invalidate_inertia();
            return;
        }// end function

        public function invalidate_shapes() : void
        {
            zip_aabb = true;
            zip_localCOM = true;
            zip_worldCOM = true;
            invalidate_mass();
            invalidate_inertia();
            return;
        }// end function

        public function invalidate_rot() : void
        {
            var _loc_2:* = null as ZPP_Shape;
            zip_axis = true;
            var _loc_1:* = shapes.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                if (_loc_2.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    _loc_2.polygon.invalidate_gverts();
                    _loc_2.polygon.invalidate_gaxi();
                }
                _loc_2.invalidate_worldCOM();
                _loc_1 = _loc_1.next;
            }
            zip_worldCOM = true;
            return;
        }// end function

        public function invalidate_pos() : void
        {
            var _loc_2:* = null as ZPP_Shape;
            var _loc_1:* = shapes.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                if (_loc_2.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    _loc_2.polygon.invalidate_gverts();
                    _loc_2.polygon.invalidate_gaxi();
                }
                _loc_2.invalidate_worldCOM();
                _loc_1 = _loc_1.next;
            }
            zip_worldCOM = true;
            return;
        }// end function

        public function invalidate_mass() : void
        {
            zip_mass = true;
            invalidate_gravMass();
            return;
        }// end function

        public function invalidate_localCOM() : void
        {
            zip_localCOM = true;
            zip_worldCOM = true;
            return;
        }// end function

        public function invalidate_inertia() : void
        {
            zip_inertia = true;
            wake();
            return;
        }// end function

        public function invalidate_gravMassScale() : void
        {
            if (gravMassMode != ZPP_Flags.id_GravMassMode_SCALED)
            {
                zip_gravMassScale = true;
            }
            else
            {
                invalidate_gravMass();
            }
            return;
        }// end function

        public function invalidate_gravMass() : void
        {
            if (gravMassMode != ZPP_Flags.id_GravMassMode_FIXED)
            {
                zip_gravMass = true;
            }
            if (gravMassMode != ZPP_Flags.id_GravMassMode_SCALED)
            {
                zip_gravMassScale = true;
            }
            wake();
            return;
        }// end function

        public function invalidate_aabb() : void
        {
            zip_aabb = true;
            return;
        }// end function

        public function interactingBodies(param1:int, param2:int, param3:BodyList) : BodyList
        {
            var _loc_5:* = null as BodyList;
            var _loc_6:* = null as ZPP_Body;
            var _loc_7:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_8:* = null as ZPP_Arbiter;
            var _loc_9:* = null as ZPP_Body;
            var _loc_11:* = null as ZPP_Set_ZPP_Body;
            var _loc_12:* = null as Body;
            var _loc_13:* = null as ZPP_Set_ZPP_Body;
            var _loc_14:* = null as ZPP_Set_ZPP_Body;
            var _loc_4:* = this;
            if (ZPP_Body.bodyset == null)
            {
                ZPP_Body.bodyset = new ZPP_Set_ZPP_Body();
                ZPP_Body.bodyset.lt = ZPP_Body.bodysetlt;
                ZPP_Body.bodystack = new ZNPList_ZPP_Body();
            }
            if (param3 == null)
            {
                _loc_5 = new BodyList();
            }
            else
            {
                _loc_5 = param3;
            }
            ZPP_Body.bodyset.insert(this);
            ZPP_Body.bodystack.add(this);
            graph_depth = 0;
            while (ZPP_Body.bodystack.head != null)
            {
                
                _loc_6 = ZPP_Body.bodystack.pop_unsafe();
                if (_loc_6.graph_depth == param2)
                {
                    continue;
                }
                _loc_7 = _loc_6.arbiters.head;
                while (_loc_7 != null)
                {
                    
                    _loc_8 = _loc_7.elt;
                    if ((_loc_8.type & param1) != 0)
                    {
                        if (_loc_8.b1 == _loc_6)
                        {
                            _loc_9 = _loc_8.b2;
                        }
                        else
                        {
                            _loc_9 = _loc_8.b1;
                        }
                        if (ZPP_Body.bodyset.try_insert_bool(_loc_9))
                        {
                            ZPP_Body.bodystack.add(_loc_9);
                            _loc_9.graph_depth = _loc_6.graph_depth + 1;
                        }
                    }
                    _loc_7 = _loc_7.next;
                }
            }
            var _loc_10:* = ZPP_Body.bodyset;
            if (_loc_10.parent == null)
            {
            }
            else
            {
                _loc_11 = _loc_10.parent;
                while (_loc_11 != null)
                {
                    
                    if (_loc_11.prev != null)
                    {
                        _loc_11 = _loc_11.prev;
                        continue;
                    }
                    if (_loc_11.next != null)
                    {
                        _loc_11 = _loc_11.next;
                        continue;
                    }
                    _loc_6 = _loc_11.data;
                    if (_loc_6 != _loc_4)
                    {
                        _loc_12 = _loc_6.outer;
                        if (_loc_5.zpp_inner.reverse_flag)
                        {
                            _loc_5.push(_loc_12);
                        }
                        else
                        {
                            _loc_5.unshift(_loc_12);
                        }
                    }
                    _loc_13 = _loc_11.parent;
                    if (_loc_13 != null)
                    {
                        if (_loc_11 == _loc_13.prev)
                        {
                            _loc_13.prev = null;
                        }
                        else
                        {
                            _loc_13.next = null;
                        }
                        _loc_11.parent = null;
                    }
                    _loc_14 = _loc_11;
                    _loc_14.data = null;
                    _loc_14.lt = null;
                    _loc_14.swapped = null;
                    _loc_14.next = ZPP_Set_ZPP_Body.zpp_pool;
                    ZPP_Set_ZPP_Body.zpp_pool = _loc_14;
                    _loc_11 = _loc_13;
                }
                _loc_10.parent = null;
            }
            return _loc_5;
        }// end function

        public function init_bodysetlist() : void
        {
            if (ZPP_Body.bodyset == null)
            {
                ZPP_Body.bodyset = new ZPP_Set_ZPP_Body();
                ZPP_Body.bodyset.lt = ZPP_Body.bodysetlt;
                ZPP_Body.bodystack = new ZNPList_ZPP_Body();
            }
            return;
        }// end function

        public function getworldCOM() : void
        {
            if (shapes.head == null)
            {
                throw "Error: worldCOM only makes sense when Body has Shapes";
            }
            validate_worldCOM();
            return;
        }// end function

        public function getlocalCOM() : void
        {
            if (shapes.head == null)
            {
                throw "Error: localCOM only makes sense when Body has Shapes";
            }
            validate_localCOM();
            return;
        }// end function

        public function force_validate() : void
        {
            wrap_force.zpp_inner.x = forcex;
            wrap_force.zpp_inner.y = forcey;
            return;
        }// end function

        public function force_invalidate(param1:ZPP_Vec2) : void
        {
            if (type != ZPP_Flags.id_BodyType_DYNAMIC)
            {
                throw "Error: Non-dynamic body cannot have force applied.";
            }
            forcex = param1.x;
            forcey = param1.y;
            wake();
            return;
        }// end function

        public function delta_rot(param1:Number) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            rot = rot + param1;
            if (param1 * param1 > 0.0001)
            {
                axisx = Math.sin(rot);
                axisy = Math.cos(rot);
            }
            else
            {
                _loc_2 = param1 * param1;
                _loc_3 = 1 - 0.5 * _loc_2;
                _loc_4 = 1 - _loc_2 * _loc_2 / 8;
                _loc_5 = (_loc_3 * axisx + param1 * axisy) * _loc_4;
                axisy = (_loc_3 * axisy - param1 * axisx) * _loc_4;
                axisx = _loc_5;
            }
            return;
        }// end function

        public function cvel_validate() : void
        {
            wrapcvel.zpp_inner.x = velx + kinvelx;
            wrapcvel.zpp_inner.y = vely + kinvely;
            wrapcvel.zpp_inner.z = angvel + kinangvel;
            return;
        }// end function

        public function copy() : Body
        {
            var _loc_2:* = null as ZNPNode_ZPP_Shape;
            var _loc_3:* = null as ZPP_Shape;
            var _loc_4:* = null as ShapeList;
            var _loc_5:* = null as Shape;
            var _loc_1:* = new Body().zpp_inner;
            _loc_1.type = type;
            _loc_1.bulletEnabled = bulletEnabled;
            _loc_1.disableCCD = disableCCD;
            _loc_2 = shapes.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                _loc_4 = _loc_1.outer.zpp_inner.wrap_shapes;
                _loc_5 = _loc_3.outer.copy();
                if (_loc_4.zpp_inner.reverse_flag)
                {
                    _loc_4.push(_loc_5);
                }
                else
                {
                    _loc_4.unshift(_loc_5);
                }
                _loc_2 = _loc_2.next;
            }
            _loc_1.posx = posx;
            _loc_1.posy = posy;
            _loc_1.velx = velx;
            _loc_1.vely = vely;
            _loc_1.forcex = forcex;
            _loc_1.forcey = forcey;
            _loc_1.rot = rot;
            _loc_1.angvel = angvel;
            _loc_1.torque = torque;
            _loc_1.kinvelx = kinvelx;
            _loc_1.kinvely = kinvely;
            _loc_1.kinangvel = kinangvel;
            _loc_1.svelx = svelx;
            _loc_1.svely = svely;
            if (!zip_axis)
            {
                _loc_1.axisx = axisx;
                _loc_1.axisy = axisy;
            }
            else
            {
                _loc_1.zip_axis = true;
                _loc_2 = _loc_1.shapes.head;
                while (_loc_2 != null)
                {
                    
                    _loc_3 = _loc_2.elt;
                    if (_loc_3.type == ZPP_Flags.id_ShapeType_POLYGON)
                    {
                        _loc_3.polygon.invalidate_gverts();
                        _loc_3.polygon.invalidate_gaxi();
                    }
                    _loc_3.invalidate_worldCOM();
                    _loc_2 = _loc_2.next;
                }
                _loc_1.zip_worldCOM = true;
            }
            _loc_1.rot = rot;
            _loc_1.massMode = massMode;
            _loc_1.gravMassMode = gravMassMode;
            _loc_1.inertiaMode = inertiaMode;
            _loc_1.norotate = norotate;
            _loc_1.nomove = nomove;
            _loc_1.cmass = cmass;
            _loc_1.cinertia = cinertia;
            if (!zip_mass)
            {
                _loc_1.mass = mass;
            }
            else
            {
                _loc_1.invalidate_mass();
            }
            if (!zip_gravMass)
            {
                _loc_1.gravMass = gravMass;
            }
            else
            {
                _loc_1.invalidate_gravMass();
            }
            if (!zip_gravMassScale)
            {
                _loc_1.gravMassScale = gravMassScale;
            }
            else
            {
                _loc_1.invalidate_gravMassScale();
            }
            if (!zip_inertia)
            {
                _loc_1.inertia = inertia;
            }
            else
            {
                _loc_1.invalidate_inertia();
            }
            if (!zip_aabb)
            {
                _loc_1.aabb.minx = aabb.minx;
                _loc_1.aabb.miny = aabb.miny;
                _loc_1.aabb.maxx = aabb.maxx;
                _loc_1.aabb.maxy = aabb.maxy;
            }
            else
            {
                _loc_1.zip_aabb = true;
            }
            if (!zip_localCOM)
            {
                _loc_1.localCOMx = localCOMx;
                _loc_1.localCOMy = localCOMy;
            }
            else
            {
                _loc_1.zip_localCOM = true;
                _loc_1.zip_worldCOM = true;
            }
            if (!zip_worldCOM)
            {
                _loc_1.worldCOMx = worldCOMx;
                _loc_1.worldCOMy = worldCOMy;
            }
            else
            {
                _loc_1.zip_worldCOM = true;
            }
            copyto(_loc_1.outer);
            return _loc_1.outer;
        }// end function

        public function connectedBodies_cont(param1:Body) : void
        {
            if (ZPP_Body.bodyset.try_insert_bool(param1.zpp_inner))
            {
                ZPP_Body.bodystack.add(param1.zpp_inner);
                param1.zpp_inner.graph_depth = ZPP_Body.cur_graph_depth + 1;
            }
            return;
        }// end function

        public function connectedBodies(param1:int, param2:BodyList) : BodyList
        {
            var _loc_4:* = null as BodyList;
            var _loc_5:* = null as ZPP_Body;
            var _loc_6:* = null as ZNPNode_ZPP_Constraint;
            var _loc_7:* = null as ZPP_Constraint;
            var _loc_9:* = null as ZPP_Set_ZPP_Body;
            var _loc_10:* = null as Body;
            var _loc_11:* = null as ZPP_Set_ZPP_Body;
            var _loc_12:* = null as ZPP_Set_ZPP_Body;
            var _loc_3:* = this;
            if (ZPP_Body.bodyset == null)
            {
                ZPP_Body.bodyset = new ZPP_Set_ZPP_Body();
                ZPP_Body.bodyset.lt = ZPP_Body.bodysetlt;
                ZPP_Body.bodystack = new ZNPList_ZPP_Body();
            }
            if (param2 == null)
            {
                _loc_4 = new BodyList();
            }
            else
            {
                _loc_4 = param2;
            }
            ZPP_Body.bodystack.add(this);
            ZPP_Body.bodyset.insert(this);
            graph_depth = 0;
            while (ZPP_Body.bodystack.head != null)
            {
                
                _loc_5 = ZPP_Body.bodystack.pop_unsafe();
                if (_loc_5.graph_depth == param1)
                {
                    continue;
                }
                ZPP_Body.cur_graph_depth = _loc_5.graph_depth;
                _loc_6 = _loc_5.constraints.head;
                while (_loc_6 != null)
                {
                    
                    _loc_7 = _loc_6.elt;
                    _loc_7.outer.visitBodies(connectedBodies_cont);
                    _loc_6 = _loc_6.next;
                }
            }
            var _loc_8:* = ZPP_Body.bodyset;
            if (_loc_8.parent == null)
            {
            }
            else
            {
                _loc_9 = _loc_8.parent;
                while (_loc_9 != null)
                {
                    
                    if (_loc_9.prev != null)
                    {
                        _loc_9 = _loc_9.prev;
                        continue;
                    }
                    if (_loc_9.next != null)
                    {
                        _loc_9 = _loc_9.next;
                        continue;
                    }
                    _loc_5 = _loc_9.data;
                    if (_loc_5 != _loc_3)
                    {
                        _loc_10 = _loc_5.outer;
                        if (_loc_4.zpp_inner.reverse_flag)
                        {
                            _loc_4.push(_loc_10);
                        }
                        else
                        {
                            _loc_4.unshift(_loc_10);
                        }
                    }
                    _loc_11 = _loc_9.parent;
                    if (_loc_11 != null)
                    {
                        if (_loc_9 == _loc_11.prev)
                        {
                            _loc_11.prev = null;
                        }
                        else
                        {
                            _loc_11.next = null;
                        }
                        _loc_9.parent = null;
                    }
                    _loc_12 = _loc_9;
                    _loc_12.data = null;
                    _loc_12.lt = null;
                    _loc_12.swapped = null;
                    _loc_12.next = ZPP_Set_ZPP_Body.zpp_pool;
                    ZPP_Set_ZPP_Body.zpp_pool = _loc_12;
                    _loc_9 = _loc_11;
                }
                _loc_8.parent = null;
            }
            return _loc_4;
        }// end function

        public function clear() : void
        {
            var _loc_1:* = null as ZPP_Shape;
            if (space != null)
            {
                throw "Error: Cannot clear a Body if it is currently being used by a Space!";
            }
            if (constraints.head != null)
            {
                throw "Error: Cannot clear a Body if it is currently being used by a constraint!";
            }
            while (shapes.head != null)
            {
                
                _loc_1 = shapes.pop_unsafe();
                _loc_1.removedFromBody();
                _loc_1.body = null;
            }
            invalidate_shapes();
            pre_posx = 0;
            pre_posy = 0;
            posx = 0;
            posy = 0;
            velx = 0;
            vely = 0;
            forcex = 0;
            forcey = 0;
            kinvelx = 0;
            kinvely = 0;
            svelx = 0;
            svely = 0;
            var _loc_2:* = 0;
            rot = 0;
            _loc_2 = _loc_2;
            pre_rot = _loc_2;
            _loc_2 = _loc_2;
            kinangvel = _loc_2;
            _loc_2 = _loc_2;
            torque = _loc_2;
            angvel = _loc_2;
            var _loc_3:* = shapes.head;
            while (_loc_3 != null)
            {
                
                _loc_1 = _loc_3.elt;
                if (_loc_1.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    _loc_1.polygon.invalidate_gverts();
                    _loc_1.polygon.invalidate_gaxi();
                }
                _loc_1.invalidate_worldCOM();
                _loc_3 = _loc_3.next;
            }
            zip_worldCOM = true;
            zip_axis = true;
            _loc_3 = shapes.head;
            while (_loc_3 != null)
            {
                
                _loc_1 = _loc_3.elt;
                if (_loc_1.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    _loc_1.polygon.invalidate_gverts();
                    _loc_1.polygon.invalidate_gaxi();
                }
                _loc_1.invalidate_worldCOM();
                _loc_3 = _loc_3.next;
            }
            zip_worldCOM = true;
            axisx = 0;
            axisy = 1;
            zip_axis = false;
            massMode = ZPP_Flags.id_MassMode_DEFAULT;
            gravMassMode = ZPP_Flags.id_GravMassMode_DEFAULT;
            gravMassScale = 1;
            inertiaMode = ZPP_Flags.id_InertiaMode_DEFAULT;
            norotate = false;
            nomove = false;
            return;
        }// end function

        public function atRest(param1:Number) : Boolean
        {
            var _loc_2:* = NaN;
            var _loc_3:* = false;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            if (type != ZPP_Flags.id_BodyType_DYNAMIC)
            {
                return component.sleeping;
            }
            else
            {
                _loc_2 = Config.linearSleepThreshold;
                _loc_2 = _loc_2 * _loc_2;
                if (velx * velx + vely * vely > _loc_2)
                {
                    _loc_3 = false;
                }
                else
                {
                    _loc_4 = 0;
                    _loc_5 = 0;
                    _loc_4 = posx - pre_posx;
                    _loc_5 = posy - pre_posy;
                    if (_loc_4 * _loc_4 + _loc_5 * _loc_5 > 0.25 * _loc_2 * param1 * param1)
                    {
                        _loc_3 = false;
                    }
                    else
                    {
                        _loc_4 = 0;
                        _loc_5 = 0;
                        _loc_4 = aabb.maxx - aabb.minx;
                        _loc_5 = aabb.maxy - aabb.miny;
                        _loc_6 = _loc_4 * _loc_4 + _loc_5 * _loc_5;
                        _loc_7 = Config.angularSleepThreshold;
                        _loc_7 = _loc_7 * _loc_7;
                        if (4 * angvel * angvel * _loc_6 > _loc_7)
                        {
                            _loc_3 = false;
                        }
                        else
                        {
                            _loc_8 = rot - pre_rot;
                            if (_loc_8 * _loc_8 * _loc_6 > _loc_7 * param1 * param1)
                            {
                                _loc_3 = false;
                            }
                            else
                            {
                                _loc_3 = true;
                            }
                        }
                    }
                }
                if (!_loc_3)
                {
                    component.waket = space.stamp;
                }
                return component.waket + Config.sleepDelay < space.stamp;
            }
        }// end function

        public function addedToSpace() : void
        {
            if (ZPP_Component.zpp_pool == null)
            {
                component = new ZPP_Component();
            }
            else
            {
                component = ZPP_Component.zpp_pool;
                ZPP_Component.zpp_pool = component.next;
                component.next = null;
            }
            component.isBody = true;
            component.body = this;
            __iaddedToSpace();
            return;
        }// end function

        public function aabb_validate() : void
        {
            var _loc_1:* = null as ZNPNode_ZPP_Shape;
            var _loc_2:* = null as ZPP_Shape;
            var _loc_3:* = null as ZPP_Circle;
            var _loc_4:* = null as ZPP_Polygon;
            var _loc_5:* = NaN;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = NaN;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = null as ZPP_Body;
            var _loc_13:* = null as ZPP_AABB;
            var _loc_14:* = null as ZPP_AABB;
            if (shapes.head == null)
            {
                throw "Error: bounds only makes sense when Body has shapes";
            }
            if (shapes.head == null)
            {
                throw "Error: Body bounds only makes sense if it contains shapes";
            }
            if (zip_aabb)
            {
                zip_aabb = false;
                aabb.minx = 17899999999999994000000000000;
                aabb.miny = 17899999999999994000000000000;
                aabb.maxx = -17899999999999994000000000000;
                aabb.maxy = -17899999999999994000000000000;
                _loc_1 = shapes.head;
                while (_loc_1 != null)
                {
                    
                    _loc_2 = _loc_1.elt;
                    if (_loc_2.zip_aabb)
                    {
                        if (_loc_2.body != null)
                        {
                            _loc_2.zip_aabb = false;
                            if (_loc_2.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                _loc_3 = _loc_2.circle;
                                if (_loc_3.zip_worldCOM)
                                {
                                    if (_loc_3.body != null)
                                    {
                                        _loc_3.zip_worldCOM = false;
                                        if (_loc_3.zip_localCOM)
                                        {
                                            _loc_3.zip_localCOM = false;
                                            if (_loc_3.type == ZPP_Flags.id_ShapeType_POLYGON)
                                            {
                                                _loc_4 = _loc_3.polygon;
                                                if (_loc_4.lverts.next == null)
                                                {
                                                    throw "Error: An empty polygon has no meaningful localCOM";
                                                }
                                                if (_loc_4.lverts.next.next == null)
                                                {
                                                    _loc_4.localCOMx = _loc_4.lverts.next.x;
                                                    _loc_4.localCOMy = _loc_4.lverts.next.y;
                                                }
                                                else if (_loc_4.lverts.next.next.next == null)
                                                {
                                                    _loc_4.localCOMx = _loc_4.lverts.next.x;
                                                    _loc_4.localCOMy = _loc_4.lverts.next.y;
                                                    _loc_5 = 1;
                                                    _loc_4.localCOMx = _loc_4.localCOMx + _loc_4.lverts.next.next.x * _loc_5;
                                                    _loc_4.localCOMy = _loc_4.localCOMy + _loc_4.lverts.next.next.y * _loc_5;
                                                    _loc_5 = 0.5;
                                                    _loc_4.localCOMx = _loc_4.localCOMx * _loc_5;
                                                    _loc_4.localCOMy = _loc_4.localCOMy * _loc_5;
                                                }
                                                else
                                                {
                                                    _loc_4.localCOMx = 0;
                                                    _loc_4.localCOMy = 0;
                                                    _loc_5 = 0;
                                                    _loc_6 = _loc_4.lverts.next;
                                                    _loc_7 = _loc_6;
                                                    _loc_6 = _loc_6.next;
                                                    _loc_8 = _loc_6;
                                                    _loc_6 = _loc_6.next;
                                                    while (_loc_6 != null)
                                                    {
                                                        
                                                        _loc_9 = _loc_6;
                                                        _loc_5 = _loc_5 + _loc_8.x * (_loc_9.y - _loc_7.y);
                                                        _loc_10 = _loc_9.y * _loc_8.x - _loc_9.x * _loc_8.y;
                                                        _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_9.x) * _loc_10;
                                                        _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_9.y) * _loc_10;
                                                        _loc_7 = _loc_8;
                                                        _loc_8 = _loc_9;
                                                        _loc_6 = _loc_6.next;
                                                    }
                                                    _loc_6 = _loc_4.lverts.next;
                                                    _loc_9 = _loc_6;
                                                    _loc_5 = _loc_5 + _loc_8.x * (_loc_9.y - _loc_7.y);
                                                    _loc_10 = _loc_9.y * _loc_8.x - _loc_9.x * _loc_8.y;
                                                    _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_9.x) * _loc_10;
                                                    _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_9.y) * _loc_10;
                                                    _loc_7 = _loc_8;
                                                    _loc_8 = _loc_9;
                                                    _loc_6 = _loc_6.next;
                                                    _loc_11 = _loc_6;
                                                    _loc_5 = _loc_5 + _loc_8.x * (_loc_11.y - _loc_7.y);
                                                    _loc_10 = _loc_11.y * _loc_8.x - _loc_11.x * _loc_8.y;
                                                    _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_11.x) * _loc_10;
                                                    _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_11.y) * _loc_10;
                                                    _loc_5 = 1 / (3 * _loc_5);
                                                    _loc_10 = _loc_5;
                                                    _loc_4.localCOMx = _loc_4.localCOMx * _loc_10;
                                                    _loc_4.localCOMy = _loc_4.localCOMy * _loc_10;
                                                }
                                            }
                                            if (_loc_3.wrap_localCOM != null)
                                            {
                                                _loc_3.wrap_localCOM.zpp_inner.x = _loc_3.localCOMx;
                                                _loc_3.wrap_localCOM.zpp_inner.y = _loc_3.localCOMy;
                                            }
                                        }
                                        _loc_12 = _loc_3.body;
                                        if (_loc_12.zip_axis)
                                        {
                                            _loc_12.zip_axis = false;
                                            _loc_12.axisx = Math.sin(_loc_12.rot);
                                            _loc_12.axisy = Math.cos(_loc_12.rot);
                                        }
                                        _loc_3.worldCOMx = _loc_3.body.posx + (_loc_3.body.axisy * _loc_3.localCOMx - _loc_3.body.axisx * _loc_3.localCOMy);
                                        _loc_3.worldCOMy = _loc_3.body.posy + (_loc_3.localCOMx * _loc_3.body.axisx + _loc_3.localCOMy * _loc_3.body.axisy);
                                    }
                                }
                                _loc_5 = _loc_3.radius;
                                _loc_10 = _loc_3.radius;
                                _loc_3.aabb.minx = _loc_3.worldCOMx - _loc_5;
                                _loc_3.aabb.miny = _loc_3.worldCOMy - _loc_10;
                                _loc_3.aabb.maxx = _loc_3.worldCOMx + _loc_5;
                                _loc_3.aabb.maxy = _loc_3.worldCOMy + _loc_10;
                            }
                            else
                            {
                                _loc_4 = _loc_2.polygon;
                                if (_loc_4.zip_gverts)
                                {
                                    if (_loc_4.body != null)
                                    {
                                        _loc_4.zip_gverts = false;
                                        _loc_4.validate_lverts();
                                        _loc_12 = _loc_4.body;
                                        if (_loc_12.zip_axis)
                                        {
                                            _loc_12.zip_axis = false;
                                            _loc_12.axisx = Math.sin(_loc_12.rot);
                                            _loc_12.axisy = Math.cos(_loc_12.rot);
                                        }
                                        _loc_6 = _loc_4.lverts.next;
                                        _loc_7 = _loc_4.gverts.next;
                                        while (_loc_7 != null)
                                        {
                                            
                                            _loc_8 = _loc_7;
                                            _loc_9 = _loc_6;
                                            _loc_6 = _loc_6.next;
                                            _loc_8.x = _loc_4.body.posx + (_loc_4.body.axisy * _loc_9.x - _loc_4.body.axisx * _loc_9.y);
                                            _loc_8.y = _loc_4.body.posy + (_loc_9.x * _loc_4.body.axisx + _loc_9.y * _loc_4.body.axisy);
                                            _loc_7 = _loc_7.next;
                                        }
                                    }
                                }
                                if (_loc_4.lverts.next == null)
                                {
                                    throw "Error: An empty polygon has no meaningful bounds";
                                }
                                _loc_6 = _loc_4.gverts.next;
                                _loc_4.aabb.minx = _loc_6.x;
                                _loc_4.aabb.miny = _loc_6.y;
                                _loc_4.aabb.maxx = _loc_6.x;
                                _loc_4.aabb.maxy = _loc_6.y;
                                _loc_7 = _loc_4.gverts.next.next;
                                while (_loc_7 != null)
                                {
                                    
                                    _loc_8 = _loc_7;
                                    if (_loc_8.x < _loc_4.aabb.minx)
                                    {
                                        _loc_4.aabb.minx = _loc_8.x;
                                    }
                                    if (_loc_8.x > _loc_4.aabb.maxx)
                                    {
                                        _loc_4.aabb.maxx = _loc_8.x;
                                    }
                                    if (_loc_8.y < _loc_4.aabb.miny)
                                    {
                                        _loc_4.aabb.miny = _loc_8.y;
                                    }
                                    if (_loc_8.y > _loc_4.aabb.maxy)
                                    {
                                        _loc_4.aabb.maxy = _loc_8.y;
                                    }
                                    _loc_7 = _loc_7.next;
                                }
                            }
                        }
                    }
                    _loc_13 = aabb;
                    _loc_14 = _loc_2.aabb;
                    if (_loc_14.minx < _loc_13.minx)
                    {
                        _loc_13.minx = _loc_14.minx;
                    }
                    if (_loc_14.maxx > _loc_13.maxx)
                    {
                        _loc_13.maxx = _loc_14.maxx;
                    }
                    if (_loc_14.miny < _loc_13.miny)
                    {
                        _loc_13.miny = _loc_14.miny;
                    }
                    if (_loc_14.maxy > _loc_13.maxy)
                    {
                        _loc_13.maxy = _loc_14.maxy;
                    }
                    _loc_1 = _loc_1.next;
                }
            }
            return;
        }// end function

        public function __immutable_midstep(param1:String) : void
        {
            if (space != null)
            {
            }
            if (space.midstep)
            {
                throw "Error: " + param1 + " cannot be set during a space step()";
            }
            return;
        }// end function

        public static function bodysetlt(param1:ZPP_Body, param2:ZPP_Body) : Boolean
        {
            return param1.id < param2.id;
        }// end function

        public static function __static() : Body
        {
            if (ZPP_Flags.BodyType_STATIC == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.BodyType_STATIC = new BodyType();
                ZPP_Flags.internal = false;
            }
            var _loc_1:* = new Body(ZPP_Flags.BodyType_STATIC);
            var _loc_2:* = _loc_1.zpp_inner;
            _loc_2.world = true;
            _loc_2.wrap_shapes.zpp_inner.immutable = true;
            var _loc_3:* = 0;
            _loc_2.gravMass = 0;
            _loc_3 = _loc_3;
            _loc_2.mass = _loc_3;
            _loc_3 = _loc_3;
            _loc_2.cmass = _loc_3;
            _loc_3 = _loc_3;
            _loc_2.imass = _loc_3;
            _loc_2.smass = _loc_3;
            _loc_3 = 0;
            _loc_2.inertia = _loc_3;
            _loc_3 = _loc_3;
            _loc_2.cinertia = _loc_3;
            _loc_3 = _loc_3;
            _loc_2.iinertia = _loc_3;
            _loc_2.sinertia = _loc_3;
            _loc_2.cbTypes.clear();
            return _loc_1;
        }// end function

    }
}
